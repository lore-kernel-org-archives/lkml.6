Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C818FC282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95AB2218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549474251;
	bh=HrEKY9+pMnoHMuWxSVzFwM4XrO9kfffNcP++QDX3QAE=;
	h=Cc:Subject:In-Reply-To:From:To:References:Date:List-ID:From;
	b=vMQIRTU1MRzbf3Z7MbRt9Ldc5/Man36G1br5N6AAd4yipf8LYBYw+QlpY53bcTLZr
	 jO2AVwYUacdQ5V2/Ec15Eo9jbZkW+SijLiaQWTviUiD3a9nGlMFl1pJf+PhVBR7tX2
	 xWcfVz7R/ffW6HedW7/nh854EzVh2qklpTYOCEa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbfBFRat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:30:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:49382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbfBFRat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:30:49 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 626F22186A;
        Wed,  6 Feb 2019 17:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549474248;
        bh=HrEKY9+pMnoHMuWxSVzFwM4XrO9kfffNcP++QDX3QAE=;
        h=Cc:Subject:In-Reply-To:From:To:References:Date:From;
        b=HtPAZC1WAH/HnyHWrRpa2Z7j/0QMcgzp05yVGQEfGlH3Ikb+adlM4IAxU5IW5RMek
         Lvi+eZEJn1Ee5tLifnqC9YzsviiU8s8CZrbuZbTrGYCVpYyhsDtdms+S1i3ajpikk/
         ItzDOJv2gr50ThMM82Iyf/JqMRqWQhwB0D0+aZCo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
User-Agent: alot/0.8
Cc:     Guenter Roeck <linux@roeck-us.net>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        wim@linux-watchdog.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v7 03/10] clk: bd718x7: use chip specific and generic data structs
In-Reply-To: <d30e869929638cb4907e52222124df8250b0980c.1549444366.git.matti.vaittinen@fi.rohmeurope.com>
From:   Stephen Boyd <sboyd@kernel.org>
Message-ID: <154947424775.74891.14167975959188860194@swboyd.mtv.corp.google.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mazziesaccount@gmail.com
References: <cover.1549444366.git.matti.vaittinen@fi.rohmeurope.com> <d30e869929638cb4907e52222124df8250b0980c.1549444366.git.matti.vaittinen@fi.rohmeurope.com>
Date:   Wed, 06 Feb 2019 09:30:47 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matti Vaittinen (2019-02-06 01:38:54)
> Header rohm-bd718x7.h was split to generic and component specific
> parts. This changed the struct bd718x7. Adapt the clk driver to
> these changes.
>=20
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

