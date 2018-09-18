Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1A0ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE452150B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmTPqetz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE452150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbeIRV6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:58:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38215 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbeIRV6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:58:07 -0400
Received: by mail-pl1-f195.google.com with SMTP id u11-v6so1252827plq.5;
        Tue, 18 Sep 2018 09:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f5AqQdOwdauqrZ33Obs7eO8HhpTGNnxq//y9DeqcjdY=;
        b=jmTPqetzL825kLF53sx9kQKtqGyVkcIVs48cJGBuTvF5eVBkHMNr5Mfy/z8OX9vquN
         9wGCUNDcZhV7s9L0qt8sheG4AJc+PSgZrwydDAqCi5lhsxi4M6rMt/pWf2RCMbI+zvYq
         AApDGq6WtJxzpn505l/FoM3rK/slutrXHbpOEzOW0jLfmfrZBJ8yNwdtEg/LoaHiQ710
         ycIQtUs8XcMlk2nsgo/39b3DL36+eqzRivWYK1sGh27aE4lT6L+cZDpI0cYOmhe1oypC
         DxzwxjVYKskUDxftqPXhdM3mi8drr17HsQbdo+SYa+gbTFowd1YSsxex5oRaQz9Z0BmJ
         H3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=f5AqQdOwdauqrZ33Obs7eO8HhpTGNnxq//y9DeqcjdY=;
        b=qsE4vvPYRPEAghavY75Lhy/mNRc4aT/zXpVtEr9zm/zoVEC4QXmVi8cidd1HqI4L0g
         CZcE/F9BvME0UsKqZcXYTFbk7CZcVSNyjxqEqhjZKGOqC6K2V9RmZJmZ8wmm6kCRmhoc
         ESlC2aciFETPL0hN3IeD7Qoq5cLjvndKjsEb+JA8xAxfZLSnQOyLnpq9n0ipD7tFDZ2t
         fXhttmsT7Uobn59hZKNsrAC2dxacd7nWojTX21Fp2GLoJRjePJqjpy7S1zUX8I6yxFDP
         iTea0mlhIpmVE5CEVvia23KdzaHFpE2jUm+1fHKpsUlvYeFW7R9RVK0F+3YOJHzDoYWt
         UFCQ==
X-Gm-Message-State: APzg51A+Sw0OBzmsfpvNAB+ukpIJiTO4HogmjqkHJBZBOIKhxjgtKuRg
        NKu1DLl5NJAJlpqxNfVkLvYxu2/7
X-Google-Smtp-Source: ANB0Vdbeb793UV3nFtEuuGrcOtaJofY/9UvIyL/ZydHwfHFOoQO03sGI4vn3PuHwt52ty+WE+34OXg==
X-Received: by 2002:a17:902:7794:: with SMTP id o20-v6mr30015991pll.116.1537287888024;
        Tue, 18 Sep 2018 09:24:48 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r18-v6sm22414638pgj.51.2018.09.18.09.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 09:24:47 -0700 (PDT)
Date:   Tue, 18 Sep 2018 09:24:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Radu Rendec <radu.rendec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] watchdog: mpc8xxx: provide boot status
Message-ID: <20180918162446.GE28152@roeck-us.net>
References: <c09f541d459c29aca40d54fff152d5645e24b50d.1537163776.git.christophe.leroy@c-s.fr>
 <207741bf9c994a869f574a93d4fb4152d4e169c9.1537163779.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <207741bf9c994a869f574a93d4fb4152d4e169c9.1537163779.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 06:22:50AM +0000, Christophe Leroy wrote:
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

I am ok with the patch, though I would really appreciate change logs
in the future. Consider this an informal Reviewed-by:.
Waiting for DT review before final approval.

Guenter

>  drivers/watchdog/mpc8xxx_wdt.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
> index 1dcf5f10cdd9..069072e6747d 100644
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
> @@ -159,6 +160,24 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
>  		return -ENODEV;
>  	}
>  
> +	res = platform_get_resource(ofdev, IORESOURCE_MEM, 1);
> +	if (res) {
> +		bool status;
> +		u32 __iomem *rsr = ioremap(res->start, resource_size(res));
> +
> +		if (!rsr)
> +			return -ENOMEM;
> +
> +		status = in_be32(rsr) & wdt_type->rsr_mask;
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
> @@ -216,6 +235,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
>  		.compatible = "mpc83xx_wdt",
>  		.data = &(struct mpc8xxx_wdt_type) {
>  			.prescaler = 0x10000,
> +			.rsr_mask = BIT(3), /* RSR Bit SWRS */
>  		},
>  	},
>  	{
> @@ -223,6 +243,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
>  		.data = &(struct mpc8xxx_wdt_type) {
>  			.prescaler = 0x10000,
>  			.hw_enabled = true,
> +			.rsr_mask = BIT(20), /* RSTRSCR Bit WDT_RR */
>  		},
>  	},
>  	{
> @@ -230,6 +251,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
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
