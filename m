Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DB2C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFAE2089F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XO3/Xkj+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCFAE2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbeKHVO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 16:14:56 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34662 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbeKHVO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 16:14:56 -0500
Received: by mail-lj1-f194.google.com with SMTP id u6-v6so17709931ljd.1;
        Thu, 08 Nov 2018 03:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B0P2BjCOoEYe+U8J+ldQjOCLTJ93FUts5YuFTe3twaI=;
        b=XO3/Xkj+zvMczhdctwZuiW1EXTPRFbsAJ54KR6L8iirMdLYqgPoSOzowGeL3N2Nb+B
         KB2OrhPtoVhlnEpIb1M0hTUFiLyn49KFPW5FZ13SEvE1UtBZAjtxreP+IogMC51TX30Q
         sALUrt/5wtOWkX4VWgsBLfnehpMo/vEgob5WdLNszA1EHUHxpY0B9MYoy2pfF1vSZtLw
         aqM8jFrSDO2iFhKstXbDCvmbZz7LASqcefoRRQbOIqbN1GTNcMCfvDRD1fb129qZebUI
         pSsu0yrC6K85Hc0SErJP26YbIfEUBy5APZ2YYjZM+IjlBaJtBXLfvd3t0rK1mv7J/99I
         YGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B0P2BjCOoEYe+U8J+ldQjOCLTJ93FUts5YuFTe3twaI=;
        b=tXojDREuYsDRXElcp9teWt4uOT6Zp7fg9BBjtp9LBtTrRTAxcU+LjBVic1L0HEpZ9/
         NauQKeNsrbVvV5a6lGbZxXHcspjMbquiYx22zzJwtA4oqT1UlTZcu0AtEnq5Ims4HtKO
         w3ARFPtrL7pLGQUuyXYArig9t8gGsbc3ZeJi+780OJs+kOE9bScIbLAYI62bB9ioqAfV
         tZRqIuNw7Uz5MsQ4uqz9ZQVcz0LSFxEQulHdDDwlSsK75ISai5kK0Fd7nVIk82g8eiG6
         cKXFIakm2sZmdFVMIaLOJwiCBf6X6H3gCbgCOnolEAnk/wFTke32p5EKBv2xaigg/iNT
         ZMxg==
X-Gm-Message-State: AGRZ1gK8KtjjoWOPhpEmcSh0yYxOoeEIv8Uyf82acG6cT52e26bN/l3A
        zrbtdvZtEecaSMr6zEBLyr2LNCER
X-Google-Smtp-Source: AJdET5d/pkZr/XsRXziMntsHt36UTyTAt6zkFHPIoUfGkmuwI4ylkAUyH46b6/XANTFmgWf5JfkH5g==
X-Received: by 2002:a2e:9a16:: with SMTP id o22-v6mr2593449lji.112.1541677188062;
        Thu, 08 Nov 2018 03:39:48 -0800 (PST)
Received: from [192.168.2.145] ([109.252.91.202])
        by smtp.googlemail.com with ESMTPSA id 11sm632387lfq.89.2018.11.08.03.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 03:39:47 -0800 (PST)
Subject: Re: [PATCH] media: staging: tegra-vde: print long unsigned using %lu
 format specifier
To:     Colin King <colin.king@canonical.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181108110224.1916-1-colin.king@canonical.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1ac3f16a-b6b5-107c-5f13-60a29cee4eef@gmail.com>
Date:   Thu, 8 Nov 2018 14:39:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181108110224.1916-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.11.2018 14:02, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The frame.flags & FLAG_B_FRAME is promoted to a long unsigned because
> of the use of the BIT() macro when defining FLAG_B_FRAME and causing a
> build warning. Fix this by using the %lu format specifer.
> 
> Cleans up warning:
> drivers/staging/media/tegra-vde/tegra-vde.c:267:5: warning: format
> specifies type 'int' but the argument has type 'unsigned long' [-Wformat]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/media/tegra-vde/tegra-vde.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/tegra-vde/tegra-vde.c b/drivers/staging/media/tegra-vde/tegra-vde.c
> index 6f06061a40d9..66cf14212c14 100644
> --- a/drivers/staging/media/tegra-vde/tegra-vde.c
> +++ b/drivers/staging/media/tegra-vde/tegra-vde.c
> @@ -262,7 +262,7 @@ static void tegra_vde_setup_iram_tables(struct tegra_vde *vde,
>  			value |= frame->frame_num;
>  
>  			dev_dbg(vde->miscdev.parent,
> -				"\tFrame %d: frame_num = %d B_frame = %d\n",
> +				"\tFrame %d: frame_num = %d B_frame = %lu\n",
>  				i + 1, frame->frame_num,
>  				(frame->flags & FLAG_B_FRAME));
>  		} else {
> 

Thanks,

Acked-by: Dmitry Osipenko <digetx@gmail.com>
