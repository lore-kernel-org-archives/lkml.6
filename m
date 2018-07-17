Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D104ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC388208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="xwR8xxOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC388208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ragnatech.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbeGQMVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:21:36 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43608 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731066AbeGQMVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:21:35 -0400
Received: by mail-lf0-f68.google.com with SMTP id m12-v6so603241lfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 04:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Q6tYaCQ4rc1TEXf5ZJP1+9/SoEe+42pN1eyZvMiiLdM=;
        b=xwR8xxOlvqJ2rEVq3/xajFycyqwu0PdffipkCs6ii2pT27CfYtzsmIUm9/nvt0kOV3
         /5GbltjZ4olmOz7qkvPaXOIxPTVtXQiyQzXCg5/SR1BTmGGKu27Uh6re0FcfjNZZin0K
         BTT+K5vxLGOIwSvqY7cQzQ4NKN3dzk4sbSaOBpYSVDD4HWY3Rf55wsg2QAfcac29o8T2
         ROTZAItNAk+S1rnKDVU1SaQ9NAbIQgB2lBShT3kLBv33I+L+EtQYKYdMy2cuVqrowLca
         55ZUCdfgror3sGXhuBZQ5HU4pOdOxi4YlP4ulhwCXhFHqjQ4HrSxT9r3PTXC936ZZ9c/
         94kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Q6tYaCQ4rc1TEXf5ZJP1+9/SoEe+42pN1eyZvMiiLdM=;
        b=oFyH3X6arJi3mYtwFrvJz5lateqLdT9JNRF4Vv7Wl8Y722WyAHi3Wjh67ImX2mnkB1
         Tg7IggHG3B1PWfXAJT2YPbAvbqVMHibcOmRzJBQYE/Ws2YVoGfGGyYz/RsUDLZe1O8vZ
         LeX76TMn4EJuMGgVE0os2tesQIQC1ZirlDI3xWnoixICd4uVuy5pnWwtDSeqq18OUaVh
         tJ1VRuqKwFf0Bsw/I2A5sIYYhx9A2zb2gz2RpCfUNAf24UkREwa/EnD7WVvrGerpnnuu
         gJ2PRaKrs7WcVxWBhDFrloePZcO6MdCE986VyIATdZQ2DR0A9nrvn7YNWpKMFlCEldCQ
         3gNw==
X-Gm-Message-State: AOUpUlFzX0VQsHvLYJ4tbbfy05a92ThJ5pY+deQEBSGoWzpzyAQboh/l
        inHUTV+TOm+yHEpSv3sObs2N6A==
X-Google-Smtp-Source: AAOMgpdtlZ8DscUOvLDU55Oj4gJf0ly008ajGfmrQFEtaBTV8xxr5wyFeanwgDpJ1gQxdXaaDLgPsQ==
X-Received: by 2002:a19:5a56:: with SMTP id o83-v6mr1047662lfb.50.1531828158615;
        Tue, 17 Jul 2018 04:49:18 -0700 (PDT)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id u8-v6sm142048ljh.52.2018.07.17.04.49.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 04:49:17 -0700 (PDT)
Date:   Tue, 17 Jul 2018 13:49:16 +0200
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
Subject: Re: [PATCH v4 2/3] regulator: bd9571mwv: Add support for toggle
 power switches
Message-ID: <20180717114916.GG10087@bigcity.dyn.berto.se>
References: <20180716153052.1830-1-geert+renesas@glider.be>
 <20180716153052.1830-3-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180716153052.1830-3-geert+renesas@glider.be>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thanks for your work.

On 2018-07-16 17:30:51 +0200, Geert Uytterhoeven wrote:
> Extend the existing support for backup mode to toggle power switches.
> With a toggle power switch (or level signal), the following steps must
> be followed exactly:
>    1. Configure PMIC for backup mode, to change the role of the
>       accessory power switch from a power switch to a wake-up switch,
>    2. Switch accessory power switch off, to prepare for system suspend,
>       which is a manual step not controlled by software,
>    3. Suspend system,
>    4. Switch accessory power switch on, to resume the system.
> 
> Hence the PMIC is configured for backup mode when "on" or "1" is written
> to the PMIC's "backup_mode" virtual file in sysfs.  Conversely, writing
> "off" or "0" reverts the role of the accessory switch to a power
> switch.
> 
> Unlike with momentary switches, backup mode is not enabled by default,
> as enabling it prevents the board from being powered off using the power
> switch, which may confuse the user.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> v4:
>   - Improve patch description and comment,
> 
> v3:
>   - Replace use of "wake_up" sysfs file and extra callback for wake-up
>     change notification by custom "backup_mode" sysfs file,
> 
> v2:
>   - Improve patch description,
>   - Drop "return;" at end of function.
> ---
>  drivers/regulator/bd9571mwv-regulator.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/regulator/bd9571mwv-regulator.c b/drivers/regulator/bd9571mwv-regulator.c
> index 1da36a6590c84ba4..c44613b9423baf07 100644
> --- a/drivers/regulator/bd9571mwv-regulator.c
> +++ b/drivers/regulator/bd9571mwv-regulator.c
> @@ -185,6 +185,7 @@ static ssize_t backup_mode_store(struct device *dev,
>  				 const char *buf, size_t count)
>  {
>  	struct bd9571mwv_reg *bdreg = dev_get_drvdata(dev);
> +	unsigned int mode;
>  	int ret;
>  
>  	if (!count)
> @@ -194,6 +195,25 @@ static ssize_t backup_mode_store(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> +	if (!bdreg->rstbmode_level)
> +		return count;
> +
> +	/*
> +	 * Configure DDR Backup Mode, to change the role of the accessory power
> +	 * switch from a power switch to a wake-up switch, or vice versa
> +	 */
> +	ret = bd9571mwv_bkup_mode_read(bdreg->bd, &mode);
> +	if (ret)
> +		return ret;
> +
> +	mode &= ~BD9571MWV_BKUP_MODE_CNT_KEEPON_MASK;
> +	if (bdreg->bkup_mode_enabled)
> +		mode |= bdreg->bkup_mode_cnt_keepon;
> +
> +	ret = bd9571mwv_bkup_mode_write(bdreg->bd, mode);
> +	if (ret)
> +		return ret;
> +
>  	return count;
>  }
>  
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas Söderlund
