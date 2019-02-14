Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4C9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772A7222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394084AbfBNHxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:53:10 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44271 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfBNHxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 02:53:09 -0500
Received: by mail-lf1-f68.google.com with SMTP id g2so3792355lfh.11;
        Wed, 13 Feb 2019 23:53:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wn8anHxVtq7KxtiQuw3spHtBaL5Zz1KYFNoxuxhwgVo=;
        b=jOCpannHZm018ev25MIgOduG/4nLFhmhHyts8UUxSNly7ryLdevsVRFHyxqyZ7whqp
         GrpUQ54DawZlPeGg+d6caas/v6yOeXaVWW4oZL6ClsOdFYJiP63BQJmwvnrUa8Hcy6CL
         fss9fwd1ZT3v/g8Vda5SrU2ti8wjmkE50J4gGq19lHxb2hwBmz9Dco5UFlUV+p25EKtE
         8jlV6d9+2lunW5+LIASnoGrDh6R1wAtBBYaNutvAgs69tuTYZav7nPz2/BOWGt6rxrSs
         hoSSzzy3nRqABCQmGrmsfunt8E/oJMjma7A7p33nvznhH5l0rpTQGMJUYAhbFwO1iBkL
         2HBQ==
X-Gm-Message-State: AHQUAuaeVStR27LRNGJhGhofEwmVIPgfFbv7hPFCpMh6gMwlQdK/KmUv
        rHKfD1ko+zBwL7uA8BqNqlA=
X-Google-Smtp-Source: AHgI3IawnMMjMBm+PD5rdjhiWbWKbB1KOn5VWUFp6B8A/9NRybbB6LHzWkneSTGY9DnKKYzT3o4MWQ==
X-Received: by 2002:ac2:5104:: with SMTP id q4mr1478015lfb.59.1550130787192;
        Wed, 13 Feb 2019 23:53:07 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id x25-v6sm294616ljd.61.2019.02.13.23.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 23:53:06 -0800 (PST)
Date:   Thu, 14 Feb 2019 09:53:04 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com, Robin Gong <yibin.gong@nxp.com>,
        Elven Wang <elven.wang@nxp.com>,
        Anson Huang <anson.huang@nxp.com>, angus.ainslie@puri.sm
Subject: Re: [PATCH v2 3/3] regulator: bd718x7: Support SNVS low power state
Message-ID: <20190214075304.GE12247@localhost.localdomain>
References: <cover.1550050645.git.matti.vaittinen@fi.rohmeurope.com>
 <f8955e8d9a1ae10e369f24e02fc80a7f9ddc6f68.1550050645.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8955e8d9a1ae10e369f24e02fc80a7f9ddc6f68.1550050645.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello peeps,

A bug found from patch.

On Wed, Feb 13, 2019 at 11:50:49AM +0200, Matti Vaittinen wrote:
> read ROHM BD71837 / BD71847 specific device tree bindings for
> controlling the PMIC shutdown/reset states and voltages for
> different HW states. The PMIC was designed to be used with NXP
> i.MX8 SoC and it supports SNVS low power state which seems to
> be typical for NXP i.MX SoCs. However, when SNVS is used we must
> not allow SW to control enabling/disabling those regulators which
> are crucial for system to boot as there is a HW limitation which
> causes SW controlled regulators to be kept shut down after SNVS
> reset.
> 
> Allow setting the SNVS to be used as reset target state and allow
> marking those regulators which are critical for boot.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> --- a/drivers/regulator/bd718x7-regulator.c
> +++ b/drivers/regulator/bd718x7-regulator.c
> @@ -685,6 +817,7 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
>  			.enable_reg = BD718XX_REG_BUCK2_CTRL,
>  			.enable_mask = BD718XX_BUCK_EN,
>  			.owner = THIS_MODULE,
> +			.of_parse_cb = buck1_set_hw_dvs_levels,
This should be 
+			.of_parse_cb = buck2_set_hw_dvs_levels,

Thanks to Angus for all the testing! I'll send v3 soonish.

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
