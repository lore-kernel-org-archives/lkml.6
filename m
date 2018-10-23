Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3346AC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE1C20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE1C20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbeJWRtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:49:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34060 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbeJWRtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:49:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id z25-v6so11148176wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 02:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=radBETOHKuVXcvPW+aAIb923MsuVGOcSYClVolaIEz0=;
        b=GXSS87IUlYv2Qo0qffMiDaE6+Aeq7wMwxoU+inuI0olCHOFcf6EL++aYjirey0uC+N
         4ANN8mrBBXO4x5P6LuSZQ3hG2CdjNCVXqyX1R0rCEVZBc1zqVMJLkjc3pc+e8ja73+9X
         EikM4j6aUy68aAwYpups92d9Dh3cUVPMgosO+H3SdZaPh7UoxK6rXXxeMA+mX/kTcTdC
         /WDW8cV+91jgNti2PoD1MCAmvz1DcML8T3WBIAUW74jkV9ouorEtmzBjBkitu8XRJfGS
         gerpO2iHyW4+QjJFQfkSpmgdxajKdM2z/JzKvddeec/tJxBkLxYP/jTDHK/gIqw0VVaX
         SOLA==
X-Gm-Message-State: ABuFfohY3QBnA8z8Cc2+a0NKwpyUoPvrKKnsG6Q/tAKap2Af7T10pTPa
        OeA+7g+f8b1aiw3bqPH4p/X0Jw==
X-Google-Smtp-Source: AJdET5eCEPIkqr5xWn6177Dyv4RvR7wlVIGO1DNzv1jOiPXkpV5IeFtTayoq5AZMI+/EorjLitvI9Q==
X-Received: by 2002:a1c:ce02:: with SMTP id e2-v6mr18933589wmg.85.1540286801909;
        Tue, 23 Oct 2018 02:26:41 -0700 (PDT)
Received: from localhost ([185.7.230.215])
        by smtp.gmail.com with ESMTPSA id c184-v6sm1079268wma.15.2018.10.23.02.26.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 02:26:41 -0700 (PDT)
Date:   Tue, 23 Oct 2018 10:26:39 +0100
From:   Moritz Fischer <mdf@kernel.org>
To:     Andreas Puhm <puhm@oregano.at>
Cc:     "mdf@kernel.org" <mdf@kernel.org>,
        "atull@kernel.org" <atull@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fpga: altera-cvp: Fix registration for CvP incapable
 devices
Message-ID: <20181023092639.GA4682@archbook>
References: <9b53d15391054a598ec3a32cee540798@SRV177.busymouse24.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b53d15391054a598ec3a32cee540798@SRV177.busymouse24.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

we're getting there :) It seems your mail setup is still a bit
funky though. Did you use git send-email / git format-patch?

On Tue, Oct 23, 2018 at 09:01:39AM +0000, Andreas Puhm wrote:
> From bfc602900b016f65bc2f183aa93702101a1fdc17 Mon Sep 17 00:00:00 2001
> From: Andreas Puhm <puhm@oregano.at>
> Date: Tue, 23 Oct 2018 10:24:10 +0200
> Subject: [PATCH] fpga: altera-cvp: Fix registration for CvP incapable devices
> 
> The probe function needs to verify the CvP enable bit in order to properly determine if FPGA Manager functionality can be safely enabled.
> 
> Fixes 34d1dc17ce978ae76e676d401b48fe9d004aa948 ("fpga manager: Add Altera CvP driver")

According to [1] this should be the first 12 characters of the SHA-1.
> 
> Signed-off-by: Andreas Puhm <puhm@oregano.at>
> ---
>  drivers/fpga/altera-cvp.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 7fa793672a7a..ece344a56075 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -403,6 +403,7 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>  	struct altera_cvp_conf *conf;
>  	struct fpga_manager *mgr;
>  	u16 cmd, val;
> +	u32 regval;
>  	int ret;
>  
>  	/*
> @@ -416,6 +417,14 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>  		return -ENODEV;
>  	}
>  
> +	pci_read_config_dword(pdev, VSE_CVP_STATUS, &regval);
> +	if (!(regval & VSE_CVP_STATUS_CVP_EN)) {
> +		dev_err(&pdev->dev,
> +			"CVP is disabled for this device: CVP_STATUS Reg 0x%x\n",
> +			regval);
> +		return -ENODEV;
> +	}
> +
>  	conf = devm_kzalloc(&pdev->dev, sizeof(*conf), GFP_KERNEL);
>  	if (!conf)
>  		return -ENOMEM;
> -- 
> 2.18.0.windows.1
> 

It looks like you used Windows / Outlook or something. Please don't send 
patches as attachment.

There's tutorials out there to set up git send-email with GMail for
example, if your current provider makes using git send-email hard.

[1] https://www.kernel.org/doc/html/v4.19/process/submitting-patches.html

Thanks,
Moritz
