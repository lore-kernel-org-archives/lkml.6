Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7A0C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585FE206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="B3/mYbeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfAIWkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:40:43 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34936 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbfAIWkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:40:43 -0500
Received: by mail-lf1-f67.google.com with SMTP id e26so6896295lfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 14:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=im22EfXQHQJ4U3xWKaC+1Sotpdbrj20LNzueZ0EQoBQ=;
        b=B3/mYbeC4Fjc/cEkVJD5slS0K76BgdsGoL67DTsWuvswKPQgkV2tHaCeQ3i+k6Urou
         TH7pjiDEs4lV8/+omI9CWK/KuPRv1QY0DupJFzGPDwcA7WvWSLGwF/CEvw+j63YI1i2y
         MJQXx7AzgBtcfArABZ/fwBbd5J5yLgbTSkHaXwRFg9eGeOQjqXTX9swaPLFbLAEohLUi
         hFxUmrjdLcGtzcsBH87D6Vd9SPpN2zJVA+t2WzPqrzk4L0B68oZa5D/QFRcZMwcyHgaU
         L1rEm7+NSe5hLV0Tva+funQyc6HYV7d6zwK986/PnftfQTzgDECKwMITyV0c69AurvuA
         PM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=im22EfXQHQJ4U3xWKaC+1Sotpdbrj20LNzueZ0EQoBQ=;
        b=N7ycpNCLzbiVl1M8nKvRxPm9kCN8jSgxd5tpiez/xv/KWBwTeNpoA6HSOUzzzf8hkY
         GY9g5yDmMbqjBJYZIeQRhyh8/fRi6mWhNk1Mck7oF0oO3mxrEgUz7KHFM4n8EZj4T+KF
         oi+X/XEyC5UBHeE7DVbYiLLZvEl7gP0KQqlLc0P6byZ1iRHWg5g75luX3mmv4GONFLJn
         ChPCZ+mXEscghbF5i8r7A3J4gvK/JeueJn/+i6OkTBL/CXBpGBZz5yHEl165wez+8shJ
         nhPMBgk56QbnByaHmRTE0iu1PZHTD46z1hqo0CvHh6/R4cRq9Ch81jdaWUyTF4KH9ht3
         09YQ==
X-Gm-Message-State: AJcUukcNasyA63YiiUmHOBwi+EMHBwt7RVT/hs56/HnYk/d/8RVaQa8A
        j3EK5TdC8AhoAWd6irHMWrdsLw==
X-Google-Smtp-Source: ALg8bN6fCIdZpA9nuTIBF5dLvhu64xntX+o3jFs8alYz/n5rZS/wDjLlH79odYyMsi4TRX/482HVtg==
X-Received: by 2002:a19:4bc9:: with SMTP id y192mr4351811lfa.49.1547073640822;
        Wed, 09 Jan 2019 14:40:40 -0800 (PST)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id s127sm14126874lfe.8.2019.01.09.14.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 14:40:39 -0800 (PST)
Date:   Wed, 9 Jan 2019 23:40:39 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Steve Longerbeam <slongerbeam@gmail.com>
Cc:     linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - VIN" 
        <linux-renesas-soc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] media: rcar-vin: Allow independent VIN link
 enablement
Message-ID: <20190109224039.GD24252@bigcity.dyn.berto.se>
References: <20190106212018.16519-1-slongerbeam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190106212018.16519-1-slongerbeam@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Thanks for your patch, I think it looks good.

On 2019-01-06 13:20:18 -0800, Steve Longerbeam wrote:
> There is a block of code in rvin_group_link_notify() that loops through
> all entities in the media graph, and prevents enabling a link to a VIN
> node if any entity is in use. This prevents enabling a VIN link even if
> there is an in-use entity somewhere in the graph that is independent of
> the link's pipeline.
> 
> For example, the code will prevent enabling a link from the first
> rcar-csi2 receiver to a VIN node even if there is an enabled link
> somewhere far upstream on the second independent rcar-csi2 receiver
> pipeline.
> 
> If this code is meant to prevent modifying a link if any entity in the
> graph is actively involved in streaming (because modifying the CHSEL
> register fields can disrupt any/all running streams), then the entities
> stream counts should be checked rather than the use counts.
> 
> (There is already such a check in __media_entity_setup_link() that verifies
> the stream_count of the link's source and sink entities are both zero,
> but that is insufficient, since there should be no running streams in
> the entire graph).
> 
> Modify the media_device_for_each_entity() loop to check the entity
> stream_count instead of the use_count, and elaborate on the comment.
> VIN node links can now be enabled even if there are other independent
> in-use entities that are not streaming.
> 
> Fixes: c0cc5aef31 ("media: rcar-vin: add link notify for Gen3")
> 
> Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> Changes in v2:
> - bring back the media_device_for_each_entity() loop but check the
>   stream_count not the use_count.
> ---
>  drivers/media/platform/rcar-vin/rcar-core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/rcar-vin/rcar-core.c b/drivers/media/platform/rcar-vin/rcar-core.c
> index f0719ce24b97..6dd6b11c1b2b 100644
> --- a/drivers/media/platform/rcar-vin/rcar-core.c
> +++ b/drivers/media/platform/rcar-vin/rcar-core.c
> @@ -131,9 +131,13 @@ static int rvin_group_link_notify(struct media_link *link, u32 flags,
>  	    !is_media_entity_v4l2_video_device(link->sink->entity))
>  		return 0;
>  
> -	/* If any entity is in use don't allow link changes. */
> +	/*
> +	 * Don't allow link changes if any entity in the graph is
> +	 * streaming, because modifying the CHSEL register fields
> +	 * can disrupt running streams.
> +	 */
>  	media_device_for_each_entity(entity, &group->mdev)
> -		if (entity->use_count)
> +		if (entity->stream_count)
>  			return -EBUSY;
>  
>  	mutex_lock(&group->lock);
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas Söderlund
