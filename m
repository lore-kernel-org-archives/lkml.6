Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E5BECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6DC2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="YryOId8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E6DC2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbeINWMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:12:01 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44273 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeINWMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:12:01 -0400
Received: by mail-lj1-f193.google.com with SMTP id q127-v6so8077617ljq.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 09:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CQ0f/L7J8pGDSa6d0TC7eNcLwPVDaTAFaelbi4Nz5Ag=;
        b=YryOId8ADlXh6Zu2a0plqbGh3UMoHf2g+UdrduNhYYBt7Ggf5KQbHgbcRgMu3BEm6b
         XMPxGqCwqQIFMnnxDrwoFBRmOr+QvhreW+hW/NEY/VB4X6sOO/bM1VUlyLHz5WY1+TQH
         Odgn+J31yQZpDr9ljpy+rSLvrImJ2qbVndazc0DT6zXgqfO4wTyScHKFaFl4nTXiUOZV
         QDKgHsfN63BsVKbOasovHIoCBqtjQqZ6jblT/VO+IKMm+BUts9c4vk97yQt5IDXAd+x8
         LoBmnciqBDSuMYVWhJ51yp7b6XA/dbjf4KE8LYsFz31m1lhO+dIHGxfbCafddLkxGgIQ
         qhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CQ0f/L7J8pGDSa6d0TC7eNcLwPVDaTAFaelbi4Nz5Ag=;
        b=DnqFybLapnno288B/Srp1hbeMUsQyqOBQEHjWf5gbsWtKeYpQdlGptEwCDdu5hhwGn
         o/cOv7+UzK97KSRhEa7Tvc1oXqhsmd9trpNFRhYWqsQly6Mwi4XTEVe+MJ+IO9Z/OFtX
         93Ym6b/6PgTvU4uEI2BtCONfXjCoTdA74MwZKk2RwJryPtZIrG5NPZSA8kdiBCMgbmYA
         T/uCZKikQ88Ivf66qKvMx2n2kdwoeW1qVyIweI2+4O4PXNJkqTET7aiNcE/peMDLp6l5
         DBsEbK0LAoRnWde3IoMKeKdiGpBJZTYdSa0NqP1lIki3To8RRngK7Fb1XzfWN4MnLoYB
         eJiw==
X-Gm-Message-State: APzg51BwuMwHokUAGIcQ5agc5hWBj+foipgzAJeI7eZCu7ip3JRWER/r
        SZ2YhA78kQeAtgTfDwH2fn/MiQ==
X-Google-Smtp-Source: ANB0VdbGJjx3YQGiSqrh87fUiAHULmVUnEB3w8rn5Fkowc182ZgTXtx8xATEsa+hGw9/rVRUxE/1pw==
X-Received: by 2002:a2e:498:: with SMTP id a24-v6mr8734709ljf.27.1536944199684;
        Fri, 14 Sep 2018 09:56:39 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.86.13])
        by smtp.gmail.com with ESMTPSA id m71-v6sm1288094lje.84.2018.09.14.09.56.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 09:56:38 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] media: vsp1: Document max_width restriction on UDS
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
References: <20180914142652.30484-1-kieran.bingham+renesas@ideasonboard.com>
 <20180914142652.30484-2-kieran.bingham+renesas@ideasonboard.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <07c61a65-51fd-f01a-2f96-d9eac1e7c098@cogentembedded.com>
Date:   Fri, 14 Sep 2018 19:56:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180914142652.30484-2-kieran.bingham+renesas@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 09/14/2018 05:26 PM, Kieran Bingham wrote:

> The UDS is currently restricted based on a partition size of 256 pixels.
> Document the actual restrictions, but don't increase the implementation.
> 
> The extended partition algorithm may later choose to utilise a larger
> partition size to support overlapping partitions which will improve the
> quality of the output images.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  drivers/media/platform/vsp1/vsp1_uds.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/media/platform/vsp1/vsp1_uds.c b/drivers/media/platform/vsp1/vsp1_uds.c
> index 75c613050151..e8340de85813 100644
> --- a/drivers/media/platform/vsp1/vsp1_uds.c
> +++ b/drivers/media/platform/vsp1/vsp1_uds.c
> @@ -342,6 +342,14 @@ static unsigned int uds_max_width(struct vsp1_entity *entity,
>  					    UDS_PAD_SOURCE);
>  	hscale = output->width / input->width;
>  
> +	/*
> +	 * The maximum width of the UDS is 304 pixels. These are input pixels
> +	 * in the event of up-scaling, and output pixels in the event of
> +	 * downscaling.
> +	 *
> +	 * To support overlapping parition windows we clamp at units of 256 and

   Partition.

> +	 * the remaining pixels are reserved.
> +	 */
>  	if (hscale <= 2)
>  		return 256;
>  	else if (hscale <= 4)

MBR, Sergei
