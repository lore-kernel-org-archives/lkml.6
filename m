Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D49AECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27AB20C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="CLT8IEVS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27AB20C10
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ragnatech.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbeGQMIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:08:48 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46656 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731148AbeGQMIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:08:47 -0400
Received: by mail-lj1-f193.google.com with SMTP id 203-v6so677010ljj.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 04:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WBi8fL3vXH8xpnEK0RzS+mbCngBYOYa4TG8MbxwsZ6A=;
        b=CLT8IEVSguBp8uKBHFSysgxKg5+BPutXAVIZhq7X5sBZo6S8ePbrDE2I4N7ZSePwRQ
         jUvS0fKr+o9RZ3+F7af8ezKaptAfqo2PiWoO1DBSqBJnLf9hLnyXpEmB7y1fnKXxO+5Y
         tyiLc4ciO+3Raxz7p53aSQsFwFwuLKDEUzOA1N63Zthn7XBouNQu90Q+cqckdUqmpRB8
         WNAm9VJdAy9YWeXKKJ2eC5JiDRPgKhwKFX52nHt5gRtKbknEfyE5u11BawNNzNL9CNe/
         +Jyhm28PoKg1dABZMYGhzWelESAgOjZeL4oIx+IXPnaqmmxjl3Kbg4+AVZ/tOdS3LLd4
         0/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WBi8fL3vXH8xpnEK0RzS+mbCngBYOYa4TG8MbxwsZ6A=;
        b=q49/yUOwniXyL5veZK5vz05xjDgDEyRK4ufYHsE+eds1TLBHPCu7Mvp/+UC8WfanVe
         CJjx2vvxf+DlhyhjtSJVZDwZMggvgGxGoriz8MQaQDPvJ0SjIF7D6/wKG8IfQB/0P/dV
         UI560tUdQtvM/hBYvxpR3KPabY5CWVpbGCWpil38jIYCYODVQuIE3MtM6mIf+Pdbo4Uu
         CM0qF+zUCfG1Ap9EmbAcANS8yrRg4MqdByfGxh4CqFveTCgWULTxpzToH1vT1vajx+zj
         Ocn2s8XrUm3K3q3JA7D7uVOAc8bh9fKThexJQy7HrIiYcrRbaEGLTxju9ed9jOkMLCkN
         gdKw==
X-Gm-Message-State: AOUpUlEFBcqHYn6nmQ9415KH4SS7tJMZIwCmi1QNwmy0mojYqIIF40Af
        6WnCmp97tOxb2N0DDXRxLBDWQA==
X-Google-Smtp-Source: AAOMgpec9BftNDnUeXGFUMC4Q1mnSn32mvcm4DNGy2NsiVX44968BwEPXSGCE7hOIHnC5jcwup//rA==
X-Received: by 2002:a2e:9d0e:: with SMTP id t14-v6mr1177087lji.112.1531827392821;
        Tue, 17 Jul 2018 04:36:32 -0700 (PDT)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id d24-v6sm122826lfl.53.2018.07.17.04.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 04:36:31 -0700 (PDT)
Date:   Tue, 17 Jul 2018 13:36:30 +0200
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
Subject: Re: [PATCH v4 1/3] regulator: bd9571mwv: Use "backup_mode" sysfs
 file instead of "wake_up"
Message-ID: <20180717113630.GF10087@bigcity.dyn.berto.se>
References: <20180716153052.1830-1-geert+renesas@glider.be>
 <20180716153052.1830-2-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180716153052.1830-2-geert+renesas@glider.be>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thanks for your patch.

On 2018-07-16 17:30:50 +0200, Geert Uytterhoeven wrote:
> Currently the BD9571MWV PMIC driver uses the standard "wake_up" sysfs
> file to control enablement of DDR Backup Mode.
> 
> However, configuring DDR Backup Mode is not really equivalent to
> configuring the PMIC as a wake-up source.  To avoid confusion, use a
> custom "backup_mode" attribute file in sysfs instead.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> v4:
>   - Fix build error and warning if !CONFIG_PM_SLEEP,
> 
> v3:
>   - New.
> ---
>  drivers/regulator/bd9571mwv-regulator.c | 52 ++++++++++++++++++++++---
>  1 file changed, 47 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/regulator/bd9571mwv-regulator.c b/drivers/regulator/bd9571mwv-regulator.c
> index be574eb444ebda97..1da36a6590c84ba4 100644
> --- a/drivers/regulator/bd9571mwv-regulator.c
> +++ b/drivers/regulator/bd9571mwv-regulator.c
> @@ -30,6 +30,7 @@ struct bd9571mwv_reg {
>  	/* DDR Backup Power */
>  	u8 bkup_mode_cnt_keepon;	/* from "rohm,ddr-backup-power" */
>  	u8 bkup_mode_cnt_saved;
> +	bool bkup_mode_enabled;
>  
>  	/* Power switch type */
>  	bool rstbmode_level;
> @@ -171,13 +172,40 @@ static int bd9571mwv_bkup_mode_write(struct bd9571mwv *bd, unsigned int mode)
>  	return 0;
>  }
>  
> +static ssize_t backup_mode_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct bd9571mwv_reg *bdreg = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%s\n", bdreg->bkup_mode_enabled ? "on" : "off");
> +}
> +
> +static ssize_t backup_mode_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t count)
> +{
> +	struct bd9571mwv_reg *bdreg = dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (!count)
> +		return 0;
> +
> +	ret = kstrtobool(buf, &bdreg->bkup_mode_enabled);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +DEVICE_ATTR_RW(backup_mode);
> +
>  static int bd9571mwv_suspend(struct device *dev)
>  {
>  	struct bd9571mwv_reg *bdreg = dev_get_drvdata(dev);
>  	unsigned int mode;
>  	int ret;
>  
> -	if (!device_may_wakeup(dev))
> +	if (!bdreg->bkup_mode_enabled)
>  		return 0;
>  
>  	/* Save DDR Backup Mode */
> @@ -204,7 +232,7 @@ static int bd9571mwv_resume(struct device *dev)
>  {
>  	struct bd9571mwv_reg *bdreg = dev_get_drvdata(dev);
>  
> -	if (!device_may_wakeup(dev))
> +	if (!bdreg->bkup_mode_enabled)
>  		return 0;
>  
>  	/* Restore DDR Backup Mode */
> @@ -215,9 +243,15 @@ static const struct dev_pm_ops bd9571mwv_pm  = {
>  	SET_SYSTEM_SLEEP_PM_OPS(bd9571mwv_suspend, bd9571mwv_resume)
>  };
>  
> +static int bd9571mwv_regulator_remove(struct platform_device *pdev)
> +{
> +	device_remove_file(&pdev->dev, &dev_attr_backup_mode);
> +	return 0;
> +}
>  #define DEV_PM_OPS	&bd9571mwv_pm
>  #else
>  #define DEV_PM_OPS	NULL
> +#define bd9571mwv_regulator_remove	NULL
>  #endif /* CONFIG_PM_SLEEP */
>  
>  static int bd9571mwv_regulator_probe(struct platform_device *pdev)
> @@ -270,14 +304,21 @@ static int bd9571mwv_regulator_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> +#ifdef CONFIG_PM_SLEEP
>  	if (bdreg->bkup_mode_cnt_keepon) {
> -		device_set_wakeup_capable(&pdev->dev, true);
> +		int ret;
> +
>  		/*
> -		 * Wakeup is enabled by default in pulse mode, but needs
> +		 * Backup mode is enabled by default in pulse mode, but needs
>  		 * explicit user setup in level mode.
>  		 */
> -		device_set_wakeup_enable(&pdev->dev, bdreg->rstbmode_pulse);
> +		bdreg->bkup_mode_enabled = bdreg->rstbmode_pulse;
> +
> +		ret = device_create_file(&pdev->dev, &dev_attr_backup_mode);
> +		if (ret)
> +			return ret;
>  	}
> +#endif /* CONFIG_PM_SLEEP */
>  
>  	return 0;
>  }
> @@ -294,6 +335,7 @@ static struct platform_driver bd9571mwv_regulator_driver = {
>  		.pm = DEV_PM_OPS,
>  	},
>  	.probe = bd9571mwv_regulator_probe,
> +	.remove = bd9571mwv_regulator_remove,
>  	.id_table = bd9571mwv_regulator_id_table,
>  };
>  module_platform_driver(bd9571mwv_regulator_driver);
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas Söderlund
