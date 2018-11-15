Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF87C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A3320825
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IBOESC9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A3320825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388264AbeKOVIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 16:08:39 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45591 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388234AbeKOVIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 16:08:37 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so8844595pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 03:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PjRbarftVaeegdHhXEWWPcdfdsqiFYrh2sxl6OIBO1w=;
        b=IBOESC9oVvroh5+TuwvOcb0cK/SnWAoREZpWpDYoBc7REJ6R2Y0ZD3xThcKKTjnGaQ
         Dnct2tD6W54ChTRoFgBQo0nrPm/iycXcOsKdqUiPzCDWToNSzMeR/9qFRMxgHO2QsX0o
         HTwrfIHHdr+LQ9blDczIKtb2yFcVgFd5OwLyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PjRbarftVaeegdHhXEWWPcdfdsqiFYrh2sxl6OIBO1w=;
        b=K8OzFaou0wVfBE9rKY3nn8+sFgZQCQ0cHT6rv+z391LbLN3jBNvPD6skbo8ZX3lpLd
         +s402+xJwdAdwd8FbcQjb27DthcKXRzPihHVaGUnADlOIsWerbSUPDt90gZR8SfavoAS
         20czpsRPqrOwBbGctbQX+iqq45QF+akqTJK1E+xc1LjIgSFWL1Uy7RmGzieojXziBPcS
         I9CIfExBsGlguUR1EOU/jPttuLARqwuPXGQV5Mz2ZBswZLPCZ/Bosuhv8PWsV0qo990G
         yhPWvoappNhOLUHtK4hESrDtmwSl/+INzXmVbkmSoS6Whd5bf3Wx1YfEnvV1DOkUNmWJ
         4Gaw==
X-Gm-Message-State: AGRZ1gIL+cQE4QMFPLbfTJ/Igz/0nWHOCdAXkM2r84Ay5fQ3jHU5qHeX
        mR6VKNWN8p0q6tv1HGDHEqZu
X-Google-Smtp-Source: AJdET5dXvXDKHeimyJAd32tVi+K7Szph1XUmQVGCoRLc7fMH438lHxB0wxDt9CrNxXeZdpO3DBOOFA==
X-Received: by 2002:a62:d10c:: with SMTP id z12mr6098928pfg.52.1542279675744;
        Thu, 15 Nov 2018 03:01:15 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:908:5dae:cd7f:9353:9ed0:7488])
        by smtp.gmail.com with ESMTPSA id z127-v6sm30421012pfz.135.2018.11.15.03.01.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 03:01:15 -0800 (PST)
Date:   Thu, 15 Nov 2018 16:31:04 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Parthiban Nallathambi <pn@denx.de>
Cc:     linus.walleij@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, mp-cs@actions-semi.com,
        thomas.liau@actions-semi.com, linux@cubietech.com,
        sravanhome@gmail.com
Subject: Re: [PATCH v6 0/5] Add Actions Semi S700 pinctrl support
Message-ID: <20181115110104.GB15537@Mani-XPS-13-9360>
References: <20181113100709.5615-1-pn@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113100709.5615-1-pn@denx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 11:07:04AM +0100, Parthiban Nallathambi wrote:
> This patchset adds pinctrl support for Actions Semi S700 SoC.
> Pinmux functions are only accessible for pin groups while pinconf
> parameters are available for both pin groups and individual pins.
> 
> pinctrl driver is verified using the Cubieboard7.
> 
> common functionalities from s900 is moved for all Actions Semi
> SoC's usage.
> Common pad control configurations are moved to SoC specific
>

Hi Parthiban,

This series looks good to me. Just spotted one nitpick in bindings
patch. Please note that I don't have any S900 device currently to test
the patches. Although nothing looks like breaking.

So for the whole series,

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks a ton for picking it up!

Regards,
Mani

> dts entry for pinctrl depends on clock driver which is still under review:
> https://patchwork.kernel.org/patch/10533959/
> 
> Thanks,
> Saravanan
> Parthiban
> 
> Changelog in v2
> - GPIO Interrupt support is added
> - Device tree entry for GPIO and Interrupt configured
> - GPIO and pinctrl define reorder, commit message findings fixed
> 
> depends on owl GPIO Interrupt support
> https://patchwork.kernel.org/patch/10483477/
> 
> Chnagelog in v3
> - Fixed 0-DAY bisectibility error
> 
> Chnagelog in v4
> - Fixed 0-DAY sparse warnings on static declaration
> 
> Chnagelog in v5
> - Rebase to mainline
> 
> Chnagelog in v6
> - Rebase to 4.20-rc2 mainline
> - Fixed nitpick findings in v5
> 
> Saravanan Sekar (5):
>   pinctrl: actions: define constructor generic to Actions Semi SoC's
>   pinctrl: actions: define pad control configurtion to SoC specific
>   dt-bindings: pinctrl: Add bindings for Actions Semi S700 SoC
>   pinctrl: actions: Add Actions Semi S700 pinctrl driver
>   arm64: dts: actions: Add pinctrl node for Actions Semi S700
> 
>  .../bindings/pinctrl/actions,s700-pinctrl.txt |  170 ++
>  arch/arm64/boot/dts/actions/s700.dtsi         |   16 +
>  drivers/pinctrl/actions/Kconfig               |    6 +
>  drivers/pinctrl/actions/Makefile              |    1 +
>  drivers/pinctrl/actions/pinctrl-owl.c         |   71 +-
>  drivers/pinctrl/actions/pinctrl-owl.h         |  142 +-
>  drivers/pinctrl/actions/pinctrl-s700.c        | 1912 +++++++++++++++++
>  drivers/pinctrl/actions/pinctrl-s900.c        |  205 +-
>  8 files changed, 2324 insertions(+), 199 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/actions,s700-pinctrl.txt
>  create mode 100644 drivers/pinctrl/actions/pinctrl-s700.c
> 
> -- 
> 2.17.2
> 
