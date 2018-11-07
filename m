Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50E2C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D042085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6MaNCG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D042085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbeKGVb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:31:57 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46110 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeKGVb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 16:31:56 -0500
Received: by mail-lf1-f65.google.com with SMTP id f23so6719124lfc.13;
        Wed, 07 Nov 2018 04:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=N6/5t+0cbVCot6vaYZiVdQ2CCr5S3Pc5lbG9APMFoy8=;
        b=P6MaNCG+bEzQCOE7B7mktOVmiNWXpTGDKqC6GDazqgjvWO51z/yYauLn7vzNhg/tGo
         c1cfb9IH3fCHf82CcRNryvlsxTUlIsY96KHwjOptAuNuAASP6pK5u7wPCKFDghgkvzhz
         jEpyudj1sWXLHJSAEU46TTl3Jo7PRNYI3wDqheOvN6mPZuiu7Sgn59aU+0kXF2bpLRKz
         cKUtzpZEuv3HV79Otkc9o0qz/6Dxo7sFXcC/USWyfEej8AiMmQpMslcicFJbH4SPdF2M
         rwovSTNTMAg4aqpd8of/hblIXjRdcJoyEocaY7TDho8P7v2PRONGVYX8Pr4FOnrJFrYW
         ylAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N6/5t+0cbVCot6vaYZiVdQ2CCr5S3Pc5lbG9APMFoy8=;
        b=IPiZ2cLbYN3V5DtX5f+K7O85uq79PO3P3gHaXifkXsG+8wtMINjtv0KMJQB3AHBkOz
         h5cpxqJ+MXKdgNAkwiSvfW52kzcbmivMNKwGVJ98dqwFxnSoVo7js+8jfuYmMHOYTQAH
         ij7xtqtfjUbkCtdMYee4Fm6yPrxAMMgMmVUBQB2cagFsk9zJWHxAKGYT+ttv3nvFnoiM
         3NB0D8ZKDKmr8rOvNozyavuH7Iv4diGoNSQWt15XLNabsCtOFmZblyBy38Z1mCV80ZqJ
         vLcANLaN2KMb6w6rtQ4JA+UstK5XRR1VX7wrGu8ozibP88Usn2l20Axrp0c++FXX5N+D
         MG5w==
X-Gm-Message-State: AGRZ1gISEJR+AOxeVmDSxkM/ZStCtCKoV27tC3tGS5THb7DrD84K1rsl
        lovy2JqRZvnzCajNMNPLlc05RhFH
X-Google-Smtp-Source: AJdET5e0q+2qY1sQ50xtPsq/FZ0O41Oi4rD+lM+MITd3oxez53OP2wPq7yE1fr+3Shsa0z+QwoRT8Q==
X-Received: by 2002:a19:1901:: with SMTP id 1mr893147lfz.99.1541592110848;
        Wed, 07 Nov 2018 04:01:50 -0800 (PST)
Received: from [192.168.2.145] ([109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id f134-v6sm80408lfg.68.2018.11.07.04.01.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 04:01:49 -0800 (PST)
Subject: Re: [PATCH] media: staging: tegra-vde: Change from __attribute to
 __packed.
To:     rafaelgoncalves@riseup.net, mchehab@kernel.org,
        gregkh@linuxfoundation.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-media@vger.kernel.org,
        linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
References: <20181107022324.11994-1-rafaelgoncalves@riseup.net>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <bc0d606c-c2e7-c23d-e1a5-cb9e0a30a937@gmail.com>
Date:   Wed, 7 Nov 2018 15:01:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181107022324.11994-1-rafaelgoncalves@riseup.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.11.2018 5:23, rafaelgoncalves@riseup.net wrote:
> From: Rafael Goncalves <rafaelgoncalves@riseup.net>
> 
> Correct the following warnings from checkpatch.pl:
> 
> WARNING: __packed is preferred over __attribute__((packed))
> +} __attribute__((packed));
> 
> WARNING: __packed is preferred over __attribute__((packed))
> +} __attribute__((packed));
> 
> Signed-off-by: Rafael Goncalves <rafaelgoncalves@riseup.net>
> 
> ---
> 
> Hi.
> It's my first patch submission, please let me know if there is something
> that I can improve.
> ---
>  drivers/staging/media/tegra-vde/uapi.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/tegra-vde/uapi.h b/drivers/staging/media/tegra-vde/uapi.h
> index a50c7bcae057..5ffa4afa4047 100644
> --- a/drivers/staging/media/tegra-vde/uapi.h
> +++ b/drivers/staging/media/tegra-vde/uapi.h
> @@ -29,7 +29,7 @@ struct tegra_vde_h264_frame {
>  	__u32 flags;
>  
>  	__u32 reserved;
> -} __attribute__((packed));
> +} __packed;
>  
>  struct tegra_vde_h264_decoder_ctx {
>  	__s32 bitstream_data_fd;
> @@ -61,7 +61,7 @@ struct tegra_vde_h264_decoder_ctx {
>  	__u8  num_ref_idx_l1_active_minus1;
>  
>  	__u32 reserved;
> -} __attribute__((packed));
> +} __packed;
>  
>  #define VDE_IOCTL_BASE			('v' + 0x20)
>  
> 

Hello Rafael,

Thank you very much for the patch, but looks like it is not correct. The Userspace API header is supposed to be used by kernel and userspace, the __packed macro is available in kernel only.

Interestingly there few places in include/uapi/ that use __packed macro, I'm wondering if they are correct. Note that GCC just won't complain about undefined qualifier, at least by default.
