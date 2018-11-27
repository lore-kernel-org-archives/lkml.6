Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A93EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3790F2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIHOZUtG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3790F2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbeK1FMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:12:09 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41206 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725752AbeK1FMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:12:09 -0500
Received: by mail-pg1-f196.google.com with SMTP id 70so8215990pgh.8;
        Tue, 27 Nov 2018 10:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u8yuH4e0STk5KDQ9hTcIUxNWTa338Pb2c9uWexqmiHA=;
        b=lIHOZUtGuY0Qdsf7qsjfu+T7rE604X/6sql1QW+LLRQVMqodex9EcbcUywB6I2ZeHa
         GcRM2jiHbKO+0R+dnVmbtvYYqyHOCG6c/iofWRtc3wQyR2TOtY+IyIa3HTyv2g46MOrh
         kTrhmx4mIZc4fO795rmrwi8benKPsAmog/TFN10yB50dyGShlqLNwXmp5guxpj1ELUL6
         J3vBDATihx4Jwno4hmDWbJ5G1eDbPGwffXRRMSDNjjPP7YCd6K1KlJ+QKA4GVDYzpzTk
         5DDCC/BmASdadnHgc0c7BdasHl3ikYVvol4MTspqfrrjyZPs2j/xpppEBR1zXuZ1nIBx
         KP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u8yuH4e0STk5KDQ9hTcIUxNWTa338Pb2c9uWexqmiHA=;
        b=eo51J9uwtA/TKl2Srp89/hbKDCQ2KvG5jfet+OV0BUrsuu2z5O5pzODTjJhgdH54Rx
         cStcPzTZ1MYq6Zi9yz9okE4qN3ScsFaURTdkvaUCY2d6aVzU0s0Sn8u7CJZmrAZ7iVyV
         53N8dV7DKXpvke0NUH08smrfjesXjfBkd0XtMwoUzYP5MFmNZYVhRs2q66oF4JzXC5q0
         g+pGb+Jm4ubYJwRheew7lDalzcadGyASRFsj026++Acn6D1gtDGby0jKggw8CUxYHsMJ
         +GnRrLdwGJUA5YUHmI6NcPf12frjs0A2z1avQad6L0/NybFTnYSCXSjIMPtDh/R+OLIv
         dsIw==
X-Gm-Message-State: AGRZ1gITKP//AHpInvQZMMxkEuns8C6tAJsbzXMiaJzvOCADpv2jfarW
        cpaCRqvuzC1tIZRWHkLe41+jrGSv
X-Google-Smtp-Source: AJdET5e6e+RvhDnYLwwKwriuKb/L9TjnEAU+Pm2tSSOA9GJJQYIvl3nY9GCp1fTACz7h06kVFH2FBQ==
X-Received: by 2002:a62:cd44:: with SMTP id o65mr33707658pfg.222.1543342404727;
        Tue, 27 Nov 2018 10:13:24 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-165-221.pppoe.mtu-net.ru. [91.79.165.221])
        by smtp.googlemail.com with ESMTPSA id w10-v6sm5772108pfg.1.2018.11.27.10.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 10:13:24 -0800 (PST)
Subject: Re: [PATCH] i2c: i2c-tegra: replace spin_lock_irqsave with spin_lock
 in ISR
To:     jun qian <hangdianqj@163.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180911145446.53621-1-hangdianqj@163.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9d98e98f-c4e6-f202-659b-288be5358117@gmail.com>
Date:   Tue, 27 Nov 2018 21:13:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20180911145446.53621-1-hangdianqj@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.09.2018 17:54, jun qian wrote:
> As you are already in ISR, it is unnecessary to call spin_lock_irqsave.
> 
> Signed-off-by: jun qian <hangdianqj@163.com>
> ---
>  drivers/i2c/busses/i2c-tegra.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> index 60c8561fbe65..59f31d3a508f 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -608,11 +608,10 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
>  	u32 status;
>  	const u32 status_err = I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
>  	struct tegra_i2c_dev *i2c_dev = dev_id;
> -	unsigned long flags;
>  
>  	status = i2c_readl(i2c_dev, I2C_INT_STATUS);
>  
> -	spin_lock_irqsave(&i2c_dev->xfer_lock, flags);
> +	spin_lock(&i2c_dev->xfer_lock);
>  	if (status == 0) {
>  		dev_warn(i2c_dev->dev, "irq status 0 %08x %08x %08x\n",
>  			 i2c_readl(i2c_dev, I2C_PACKET_TRANSFER_STATUS),
> @@ -670,7 +669,7 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
>  
>  	complete(&i2c_dev->msg_complete);
>  done:
> -	spin_unlock_irqrestore(&i2c_dev->xfer_lock, flags);
> +	spin_unlock(&i2c_dev->xfer_lock);
>  	return IRQ_HANDLED;
>  }
>  
> 

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
