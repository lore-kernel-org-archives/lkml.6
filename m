Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D28C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449BE20844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="J5GEJsPP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g6wxxWmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfBFSbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:31:43 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60286 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfBFSbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:31:42 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id ABFC4608CE; Wed,  6 Feb 2019 18:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549477901;
        bh=YlngkEcrubiWf9pZRC9IG949L1KZB0gWKk+KzEWvo0E=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=J5GEJsPPxltNV7TvXemcdmfACth1ErwF0J5hSUIHH/4gGAnIVXeaTXzVKpAn4/sfh
         cPvCDw2zyJFkiy2E2b/HfCQdCIbhHDTsrNoSvyBPVOUIcQ8z4OzWvUa7kMeIegTK+i
         PBd6VTHaSN8+5BNMx+Ac/A7krSsyj2B8U0dVEJqY=
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AE6316022B;
        Wed,  6 Feb 2019 18:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549477900;
        bh=YlngkEcrubiWf9pZRC9IG949L1KZB0gWKk+KzEWvo0E=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=g6wxxWmU8r9BTtfCn/xNW7kozhVfkcVwLWxOnV4n6pOl/GPtGmqmjvLSho5Z2i12t
         j1REG1veT03YyxuEdk8sSyKrzJP7rgs0qnpXdPXSntPhiUOWKC//IumUl8wHn5S/mN
         gtSrRlu7iuVMO5rFMV4m3NEKyTcwsNPTev3IJcZ0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AE6316022B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Guenter Roeck <linux@roeck-us.net>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v7 00/10] support ROHM BD70528 PMIC
References: <cover.1549444366.git.matti.vaittinen@fi.rohmeurope.com>
Date:   Wed, 06 Feb 2019 20:31:32 +0200
In-Reply-To: <cover.1549444366.git.matti.vaittinen@fi.rohmeurope.com> (Matti
        Vaittinen's message of "Wed, 6 Feb 2019 11:35:36 +0200")
Message-ID: <87o97ovke3.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> writes:

> Patch series introducing support for ROHM BD70528 PMIC
>
> Please note that patch 1 breaks compilation without patches 2 and 3
> Knowing the bd718x7 driver is already in upstream, it might be good
> if this change went through single tree, right?

That would break bisect, please avoid that. So after applying patches
from a patchset one by one the compilation should always succeed.

-- 
Kalle Valo
