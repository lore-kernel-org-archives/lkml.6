Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F3FC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52ED12146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="K9VTw9dY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52ED12146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbeIROEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:04:10 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45640 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbeIROEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:04:10 -0400
Received: by mail-ed1-f65.google.com with SMTP id p52-v6so1150706eda.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 01:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1ucO5/nmPi9/vOmZcAmHdVLo3lY+4wMDmbvgarhTRaE=;
        b=K9VTw9dYe5q6YK+pQw41tJBJdCvAWYE16OhiDuf7x5RTHXGCQozXxlTtffRc+bFNbC
         LYMr2UKBJ266GX+wOhrlOwA/hDxoMjA0tJINpyE8Woa9MDajgcao87TPpw2DWDMN/97G
         cRksLweZ85AhUqrUvnbTRqbOgHB3MUWF0pDtnGPk0ewfkhwdD7uTgYaGalo1f9f5Rck6
         C5z8HZ7pjS/a/pWRANdmuHP+BvTunIygq9a+Vqe+1xV4bH3sXAJItbymoPyOCtsX91eJ
         2mS9u4hSy5DXZX+sqIXC464Z+Z1kVuISvLk5ktkafICz7u4ttmT1TNI57qTwLdC0QVQV
         yBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1ucO5/nmPi9/vOmZcAmHdVLo3lY+4wMDmbvgarhTRaE=;
        b=DlAitm+aHSXOo+SNX3YdKDVT1in+Pf1GR4emt2ZUPZe5+6cX5d8HmAhcaeSo5Hkhih
         O2aXe9Awld6OwZebhJ1LHBTlC3aTL+1PlV5DwJ0r0O+kdfzI/8nWjGY8pGXe1OI7BMwl
         ReMaBomVwedE5svMJ+sCBzdm8XqWoc9PasZlcPz5fIoAujg6ru6Fg7JJT6E25IznGrVR
         xUT0HJGuhyIdCNX6yn/UBn+9/xomqSktDc4KKJZMYfKiJdoTlLRhyl2pQxXwGHDbo3mX
         D6sj1YM3yWzXYIqE56nP1aE4yoMZHJIpq3YWN43RgXPPiULu6j6X5zVnLRX5a66yzJyo
         ZLaQ==
X-Gm-Message-State: APzg51DF84NnAEAwX6zxcxhy/mwivC9pTwYYdgQgtKw9asx+M13V0lii
        V+4njIdnCDZ1I/TUElFuhMmGs5Bp280=
X-Google-Smtp-Source: ANB0VdaA11hmzW1H6+UJrWCg9h22YH8HSIzcapIXA+loMC+xa1/y0U+3AL4LM1pwhPMaZAFu7cL3Kw==
X-Received: by 2002:a50:a6c7:: with SMTP id f7-v6mr48412703edc.225.1537259555767;
        Tue, 18 Sep 2018 01:32:35 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id w20-v6sm16648130edc.12.2018.09.18.01.32.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 01:32:34 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: fix race on sysfs line state
To:     javier@javigon.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com
References: <1537256432-19807-1-git-send-email-javier@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <5d780512-f36f-77a6-09ae-c6ad001ef401@lightnvm.io>
Date:   Tue, 18 Sep 2018 10:32:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537256432-19807-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18/2018 09:40 AM, Javier González wrote:
> pblk exposes a sysfs interface that represents its internal state. Part
> of this state is the map bitmap for the current open line, which should
> be protected by the line lock to avoid a race when freeing the line
> metadata. Currently, it is not.
> 
> This patch makes sure that the line state is consistent and NULL
> bitmap pointers are not dereferenced.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-core.c  | 5 +++--
>   drivers/lightnvm/pblk-sysfs.c | 8 +++++++-
>   2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index a23e965d32fc..fec0ad68dcd6 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1662,13 +1662,14 @@ struct pblk_line *pblk_line_replace_data(struct pblk *pblk)
>   	struct pblk_line *cur, *new = NULL;
>   	unsigned int left_seblks;
>   
> -	cur = l_mg->data_line;
>   	new = l_mg->data_next;
>   	if (!new)
>   		goto out;
> +
> +	spin_lock(&l_mg->free_lock);
> +	cur = l_mg->data_line;
>   	l_mg->data_line = new;
>   
> -	spin_lock(&l_mg->free_lock);
>   	pblk_line_setup_metadata(new, l_mg, &pblk->lm);
>   	spin_unlock(&l_mg->free_lock);
>   
> diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
> index cba83ac43e62..2d2818155aa8 100644
> --- a/drivers/lightnvm/pblk-sysfs.c
> +++ b/drivers/lightnvm/pblk-sysfs.c
> @@ -263,8 +263,14 @@ static ssize_t pblk_sysfs_lines(struct pblk *pblk, char *page)
>   		sec_in_line = l_mg->data_line->sec_in_line;
>   		meta_weight = bitmap_weight(&l_mg->meta_bitmap,
>   							PBLK_DATA_LINES);
> -		map_weight = bitmap_weight(l_mg->data_line->map_bitmap,
> +
> +		spin_lock(&l_mg->data_line->lock);
> +		if (l_mg->data_line->map_bitmap)
> +			map_weight = bitmap_weight(l_mg->data_line->map_bitmap,
>   							lm->sec_per_line);
> +		else
> +			map_weight = 0;
> +		spin_unlock(&l_mg->data_line->lock);
>   	}
>   	spin_unlock(&l_mg->free_lock);
>   
> 

Applied for 4.20. Thanks.
