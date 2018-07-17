Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDCCECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99CA208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="CZTcV1wD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99CA208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ragnatech.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731325AbeGQMZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:25:27 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33463 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbeGQMZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:25:25 -0400
Received: by mail-lj1-f196.google.com with SMTP id s12-v6so744292ljj.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 04:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KYC/N6Zyk+gmyFkTsTEnL1uBAeUm4fwT2abmcDYyteY=;
        b=CZTcV1wD5zvhgKxsa7/iAbXjR+UC04XsHwDPxN1M1WzaVSDYbvU2azcVIk+OWgWB3c
         Fz8IqR69YOt2tcvJG3Xq3YBNj6tW/UVVpwiBeD6tekyJbGY8jB/bHG/wMSlZmxDJe/gm
         YloNRsbJbyqzaUxtgAZxYWJ62rkcloUXa9E8+NRBGPkVo1z/uxqMIzLPTvV3TMQPot1h
         W5dfEm1p+bXg8U9/6yk7mR866umdaY+ogW9UgqLT9L6KGKWK2gMZSJo2z9yTrkBM5+7+
         TNmaohq1JHB7NncJH+QDfy6iVxPWPOpobIG5pGX6dkm2I7BKISy6xeDvluWea8nWFhoU
         WIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KYC/N6Zyk+gmyFkTsTEnL1uBAeUm4fwT2abmcDYyteY=;
        b=GEniQFckdluXwL0vCGt8rc3uvNXVLOiMfjQnYaG1uVOakyOdob+4TqM0X0NcUxbV6D
         CEL4QPzsbNKBsLHBwjJVH+M1tCVpMzKWjMRnILaNutsiklx5s1aAcGWEoKpZYHAg2xWZ
         1tkxF+3oq1kGIoCWkJmLPtJIQusRoOqNmMZfVN60DGU2G2+hPS9lrV1xuBq/y3VfBtj6
         6PZ///7/IClx1B2FvxJuzEWYvPlfdH25MHcgM8rJbWWggpyjdcU/xUxu7s3JigTpANDY
         XZWckxcrcboYMP4Fl4CtIYoVG3zbnpHvcBBIQWYqEen6Kqtg+p1iiw5zta0F4y7yFdxD
         5f+w==
X-Gm-Message-State: AOUpUlEb9VMNOCt7x2GbVl+AqExaH8O/pJCdlqve0y85h/zlUcF25Xua
        L3155eZNUT8y6sX4M0ZGxssGtw==
X-Google-Smtp-Source: AAOMgpc2wSzxHX1+bsBFG7wpaybD1jqS8Swcf0xNkc+aiHLERPY+O1Kgg53sTXH4FA+fHvNYHv9k4g==
X-Received: by 2002:a2e:6a04:: with SMTP id f4-v6mr1279944ljc.109.1531828387418;
        Tue, 17 Jul 2018 04:53:07 -0700 (PDT)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id o3-v6sm124315lfc.95.2018.07.17.04.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 04:53:06 -0700 (PDT)
Date:   Tue, 17 Jul 2018 13:53:06 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] regulator: bd9571mwv: Document "backup_mode"
 sysfs file
Message-ID: <20180717115306.GH10087@bigcity.dyn.berto.se>
References: <20180716153052.1830-1-geert+renesas@glider.be>
 <20180716153052.1830-4-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180716153052.1830-4-geert+renesas@glider.be>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thanks for your work.

On 2018-07-16 17:30:52 +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Pavel Machek <pavel@ucw.cz>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> v4:
>   - Add Acked-by,
> 
> v3:
>   - New.
> ---
>  .../testing/sysfs-driver-bd9571mwv-regulator  | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-bd9571mwv-regulator
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-bd9571mwv-regulator b/Documentation/ABI/testing/sysfs-driver-bd9571mwv-regulator
> new file mode 100644
> index 0000000000000000..4d63a7904b94a993
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-bd9571mwv-regulator
> @@ -0,0 +1,27 @@
> +What:		/sys/bus/i2c/devices/.../bd9571mwv-regulator.*.auto/backup_mode
> +Date:		Jul 2018
> +KernelVersion:	4.19
> +Contact:	Geert Uytterhoeven <geert+renesas@glider.be>
> +Description:	Read/write the current state of DDR Backup Mode, which controls
> +		if DDR power rails will be kept powered during system suspend.
> +		("on"/"1" = enabled, "off"/"0" = disabled).
> +		Two types of power switches (or control signals) can be used:
> +		  A. With a momentary power switch (or pulse signal), DDR
> +		     Backup Mode is enabled by default when available, as the
> +		     PMIC will be configured only during system suspend.
> +		  B. With a toggle power switch (or level signal), the
> +		     following steps must be followed exactly:
> +		       1. Configure PMIC for backup mode, to change the role of
> +			  the accessory power switch from a power switch to a
> +			  wake-up switch,
> +		       2. Switch accessory power switch off, to prepare for
> +			  system suspend, which is a manual step not controlled
> +			  by software,
> +		       3. Suspend system,
> +		       4. Switch accessory power switch on, to resume the
> +			  system.
> +		     DDR Backup Mode must be explicitly enabled by the user,
> +		     to invoke step 1.
> +		See also Documentation/devicetree/bindings/mfd/bd9571mwv.txt.
> +Users:		User space applications for embedded boards equipped with a
> +		BD9571MWV PMIC.
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas Söderlund
