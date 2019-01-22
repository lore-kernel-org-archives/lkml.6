Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16D9C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B2620870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="hv/wRP65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfAVTsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:48:54 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36192 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfAVTsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 14:48:54 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so21761134ljk.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 11:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8XvQdNE3d4gDWFS7yzbcGSQQwhT2kd3xzEQN9QIwJ88=;
        b=hv/wRP657hXkWTmrj/CGtSQDqF6rbnrzuQU2T2cQd6kc6789fGMeRwK1XQv5dHg5eA
         z5b0pV8bHbF0WBDSoDpVlwZGKc31QY6fO4307PI/IAtFxWopSnqmNzmrYxh9+lvqRxuo
         Arua7Aas3MBy5dUWLbxdMsE9t9bhRdxfiCAPD9Yz3XPaW+4mX4RAy+D/LnpLHZXbgxbP
         +Z26NWOsqyTvgprQDpvZdECA1WwjjSt6fzb7TQC+yVTS49PoDhc9y6nQXr8tMEcnqaNH
         8z3WhJoHfSc4xNFzZG3oFkz7IKqddaKeaN+cC8jZ6Ch7D6PduKze604lKUV12S6ThavJ
         V1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8XvQdNE3d4gDWFS7yzbcGSQQwhT2kd3xzEQN9QIwJ88=;
        b=r/ukb7GTYA6AP29HTt1PC6So+SynBBPEM6+8P4mRpfNChVjjV7fF0IMGfOr7JpzCts
         wtTdHYM9HVV80sz+jyRwrtapYPlN8HFtIlLVMoKCp8LQO+7VCZPDyGrrUMLfyoa4S4fc
         ZBxsuEJqqeQlgyGo64BCpvMda/hDkCdoS2/lh7Xa+w+kKgwht8aXHTexNzA6p5x4uNfl
         +4CsCd4W0UHxSpd2biaiYPzSwdo3FZQE8Z7690yJow9ZDfM08vEzrbdVE0K1+vp6DqDG
         3jXGXPREkppiFY16ZdK1/OAgcHFOaGcDV9Iz2Z1ARhc25rygi4M5KIwtSUn+9sc6LwPt
         31hQ==
X-Gm-Message-State: AJcUukfj64LrJ6rvEx25gsPB+zlKOywb1AoJ0vrqPJN4jd9Q3OmXXNrS
        bgmO85tYK2h3t1qIyGSvS5csYIYolU8=
X-Google-Smtp-Source: ALg8bN6cMWyLWsL05ZEVpBGDhinAnMkyX9WBssN3n//rQZODor1VzW18nGhq5AD7W55lcPJamGIy6w==
X-Received: by 2002:a2e:8992:: with SMTP id c18-v6mr21598790lji.17.1548186532401;
        Tue, 22 Jan 2019 11:48:52 -0800 (PST)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id c133sm157832lfc.45.2019.01.22.11.48.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 11:48:51 -0800 (PST)
Subject: Re: [PATCH] lightnvm: pblk: use vfree to free metadata on error path
To:     hans@owltronix.com
Cc:     javier@javigon.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
References: <20190122101759.31201-1-hans@owltronix.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <4b39d129-7db0-d2d9-4178-f2ac0009ce04@lightnvm.io>
Date:   Tue, 22 Jan 2019 20:48:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190122101759.31201-1-hans@owltronix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/19 11:17 AM, hans@owltronix.com wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> As chunk metadata is allocated using vmalloc, we need to free it
> using vfree.
> 
> Fixes: 090ee26fd512 ("lightnvm: use internal allocation for chunk log page")
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 1ff165351180..1b5ff51faa63 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -141,7 +141,7 @@ struct nvm_chk_meta *pblk_get_chunk_meta(struct pblk *pblk)
>   
>   	ret = nvm_get_chunk_meta(dev, ppa, geo->all_chunks, meta);
>   	if (ret) {
> -		kfree(meta);
> +		vfree(meta);
>   		return ERR_PTR(-EIO);
>   	}
>   
> 

Thanks Hans. Applied for 5.1.
