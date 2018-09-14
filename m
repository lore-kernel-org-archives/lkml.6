Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AE2ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B1D20833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xu9pDok8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B1D20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeINWvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:51:13 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40522 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbeINWvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:51:13 -0400
Received: by mail-pl1-f195.google.com with SMTP id s17-v6so4505868plp.7;
        Fri, 14 Sep 2018 10:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PI/NTjDiHzqBFO0yMWVsQeTPcijBxxUnUhCpkloUB6s=;
        b=Xu9pDok87NZ1lpf45i/jgiTX8L593DD6cnE1d3DKf+UZCYyivD0PdiKawumjJ1BVt8
         uMB+jxgI0cqe2y+8TzrIfMJN9s3XDPwgeleJnyguxH9N7Nxu3HjK2HMbdGDXcov7vz7w
         perpr7JdJp6+ugs3kCIHwmaEIXKCFwesOe/CpwIaJJzuydNrDKNG2UElTDzoD6nAO++Q
         0cscqX/ywoxykFoTRtsTJ0uvgCUf+vl/xU1c6NnlQzHnqc7rfyBZmEuI/SsPNPElGzXF
         JIP9NdVUDwwVPmVMbMDoDZujjw1yg4EPEbSb9JylE1THkmlksbLlvhNLwi4kQrxNw4AV
         LZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PI/NTjDiHzqBFO0yMWVsQeTPcijBxxUnUhCpkloUB6s=;
        b=WtoAhA7vwmb8Cc5e7ZGN54G0iUbLBFu/2ghq+/dauCeCi4dnpH9NG2y+z+jXgDlVRf
         9CdLUEL+SRKqhl8pow3KOFUKdTziGret7YxaA5dhkBP6BL6OBUhHVgwuPNG8tRS5pHPa
         H758fQcGp7WREfZU1qivvY6jeQnZfgdy/pA1iFWjZv4UwjzF5RDHOb2iRlVgtRxaU9Np
         LcUTzlYNzKMacerNtzFz2q9eOmc/hhOwczhzzp09YbyxctB9WrZ2ADgaOI1Kk8f/iBKY
         H57fIBT2b2gTjsWzq6vp+eD9WxaHF78G65bA02G7TrWpJpfAbN9Hf+WGcMrzT/TJCev+
         CRQg==
X-Gm-Message-State: APzg51CJQ3HmP9fBVfBDjqQW5S5NITWf1r44YgradEJYOiJGGlVfgp1V
        dLjYF5MVBj4P7TbpKHZ1+vM=
X-Google-Smtp-Source: ANB0VdYD4ywyA/COtQBYmTFHNcZBWWv+SSma95BHYobKgnR7NZxfPWU01etBChqitHiGK9U+t6RM0w==
X-Received: by 2002:a17:902:7c0a:: with SMTP id x10-v6mr13267971pll.77.1536946543596;
        Fri, 14 Sep 2018 10:35:43 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r17-v6sm11313324pff.50.2018.09.14.10.35.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 10:35:42 -0700 (PDT)
Date:   Fri, 14 Sep 2018 10:35:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Radu Rendec <radu.rendec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] watchdog: mpc8xxx: provide boot status
Message-ID: <20180914173541.GG26861@roeck-us.net>
References: <5edda1a360cf7867b98a72a1dfa22db3bd5ed7b4.1536931725.git.christophe.leroy@c-s.fr>
 <4381d1515addcbc5329fbc955ef4a5074ab9afef.1536931725.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4381d1515addcbc5329fbc955ef4a5074ab9afef.1536931725.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 01:32:01PM +0000, Christophe Leroy wrote:
> mpc8xxx watchdog driver supports the following platforms:
> - mpc8xx
> - mpc83xx
> - mpc86xx
> 
> Those three platforms have a 32 bits register which provides the
> reason of the last boot, including whether it was caused by the
> watchdog.
> 
> mpc8xx: Register RSR, bit SWRS (bit 3)
> mpc83xx: Register RSR, bit SWRS (bit 28)
> mpc86xx: Register RSTRSCR, bit WDT_RR (bit 11)
> 
> This patch maps the register as defined in the device tree and updates
> wdt.bootstatus based on the value of the watchdog related bit. Then
> the information can be retrieved via the WDIOC_GETBOOTSTATUS ioctl.
> 
> Hereunder is an example of devicetree for mpc8xx,
> the Reset Status Register being at offset 0x288:
> 
> 		WDT: watchdog@0 {
> 			compatible = "fsl,mpc823-wdt";
> 			reg = <0x0 0x10 0x288 0x4>;
> 		};
> 
> On the mpc83xx, RSR is at offset 0x910
> On the mpc86xx, RSTRSCR is at offset 0xe0094
> 
> Suggested-by: Radu Rendec <radu.rendec@gmail.com>
> Tested-by: Christophe Leroy <christophe.leroy@c-s.fr> # On mpc885
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  drivers/watchdog/mpc8xxx_wdt.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
> index 1dcf5f10cdd9..4a4700458b17 100644
> --- a/drivers/watchdog/mpc8xxx_wdt.c
> +++ b/drivers/watchdog/mpc8xxx_wdt.c
> @@ -47,6 +47,7 @@ struct mpc8xxx_wdt {
>  struct mpc8xxx_wdt_type {
>  	int prescaler;
>  	bool hw_enabled;
> +	u32 rsr_mask;
>  };
>  
>  struct mpc8xxx_wdt_ddata {
> @@ -136,6 +137,7 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
>  	u32 freq = fsl_get_sys_freq();
>  	bool enabled;
>  	struct device *dev = &ofdev->dev;
> +	u32 __iomem *rsr = NULL;
>  
>  	wdt_type = of_device_get_match_data(dev);
>  	if (!wdt_type)
> @@ -159,6 +161,21 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
>  		return -ENODEV;
>  	}
>  
> +	res = platform_get_resource(ofdev, IORESOURCE_MEM, 1);
> +	if (res)
> +		rsr = ioremap(res->start, resource_size(res));
> +	if (rsr) {

This if() can be inside the first if(), and it should be something like

	if (res) {
		rsr = ioremap(res->start, resource_size(res));
		if (!rsr) {
			dev_err(...);
			return -ENOMEM;
		}
		...
	}

... because _if_ the resource is provided in dt it should be valid.

Thanks,
Guenter

> +		bool status = in_be32(rsr) & wdt_type->rsr_mask;
> +
> +		ddata->wdd.bootstatus = status ? WDIOF_CARDRESET : 0;
> +		 /* clear reset status bits related to watchdog timer */
> +		out_be32(rsr, wdt_type->rsr_mask);
> +		iounmap(rsr);
> +
> +		dev_info(dev, "Last boot was %scaused by watchdog\n",
> +			 status ? "" : "not ");
> +	}
> +
>  	spin_lock_init(&ddata->lock);
>  
>  	ddata->wdd.info = &mpc8xxx_wdt_info,
> @@ -216,6 +233,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
>  		.compatible = "mpc83xx_wdt",
>  		.data = &(struct mpc8xxx_wdt_type) {
>  			.prescaler = 0x10000,
> +			.rsr_mask = BIT(3), /* RSR Bit SWRS */
>  		},
>  	},
>  	{
> @@ -223,6 +241,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
>  		.data = &(struct mpc8xxx_wdt_type) {
>  			.prescaler = 0x10000,
>  			.hw_enabled = true,
> +			.rsr_mask = BIT(20), /* RSTRSCR Bit WDT_RR */
>  		},
>  	},
>  	{
> @@ -230,6 +249,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
>  		.data = &(struct mpc8xxx_wdt_type) {
>  			.prescaler = 0x800,
>  			.hw_enabled = true,
> +			.rsr_mask = BIT(28), /* RSR Bit SWRS */
>  		},
>  	},
>  	{},
> -- 
> 2.13.3
> 
