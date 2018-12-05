Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E77EC07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070BD20879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544030713;
	bh=1xZHk5U/u8j6lAwFyyDkz4h5vtVcooAHfDHY8mf/cJc=;
	h=To:From:In-Reply-To:Cc:References:Subject:Date:List-ID:From;
	b=zEc5TNVick398mrLGMGL7DMN4L+msy7p4kSgCioKqEOSKZU//SoEKqOMHCbJCSjUs
	 CDHjkT0dRscAfjocbGNcwOrNhast4KZcDXnHrwu4CMJiQ3o8pQzM770cDHEIV0AnJq
	 UZzFW5wzVeWbFdYAnqesOkM4LGUGVkh3LuXYi0rA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070BD20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbeLERZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:25:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:48776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727839AbeLERZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:25:11 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDA2A20878;
        Wed,  5 Dec 2018 17:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544030710;
        bh=1xZHk5U/u8j6lAwFyyDkz4h5vtVcooAHfDHY8mf/cJc=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=YBuVnp8wqbmwcRpe5EJjESQvF/928Cyg4+MP7nUw6MR+1hQk+vTg+OCDUgW4M43yY
         Dr4m129doVz6QpIV7sV+UopY+wgITwxM18uIlVyOEyw6O42ydMGOCbEso9TMkdfSqz
         Y8+f6iWzchDt6GE72mwMqbs9vLEfLYYCWv1lrcL8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <90cd96112ca1ade6bff3b58989e290ae3def59e2.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
Cc:     mturquette@baylibre.com, cw00.choi@samsung.com, krzk@kernel.org,
        b.zolnierkie@samsung.com, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, pavel@ucw.cz,
        andrew.smirnov@gmail.com, pombredanne@nexb.com,
        sjhuang@iluvatar.ai, akshu.agrawal@amd.com, djkurtz@chromium.org,
        rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <90cd96112ca1ade6bff3b58989e290ae3def59e2.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
Message-ID: <154403071006.88331.16284741533378833854@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6 06/10] clk: clk-hi655x: Free of_provider at remove
Date:   Wed, 05 Dec 2018 09:25:10 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matti Vaittinen (2018-12-04 03:37:29)
> use devm variant for of_provider registration so provider is freed
> at exit.
> =

> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---

Applied to clk-next

