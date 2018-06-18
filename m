Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B32C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9765C20020
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDcZBwN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9765C20020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754801AbeFRGIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 02:08:43 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35362 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754458AbeFRGIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 02:08:42 -0400
Received: by mail-lf0-f68.google.com with SMTP id i15-v6so22765382lfc.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 23:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xmUis4pGWUN045jpg/e3z0xO9KKsi/1jKotLcTTrKx0=;
        b=IDcZBwN2BHnFKp3AsKikc+g6VMn5FDDl3h5s5U5DcKGLtvc5w4dpqU/j+RIBnD+hx4
         hAHt4jyK19QalAS8h2fHQlMISNSVrrwXYMa2H6VjPyusaGviTUCTXKPk5ot0Z2TU61A8
         fDmdJkHPcbxLcZjm/dXfIFi4erKYwdfVEoT/TGB4rrExBOukaGHuVU8TIEpX+Q69OQXf
         A72AA8a1m/a9OwXX54+E2vONEnkdj7SXJqqWs4XKzsPZ48xY8TCvfBHGf0+KSFAhU8hp
         +xz6kdC67wDUj9iOWzcOe6HyOUMf98vqMjf/ti7T7X+ugpuiuwCOoAqWbZ3U+DPneqVo
         v5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xmUis4pGWUN045jpg/e3z0xO9KKsi/1jKotLcTTrKx0=;
        b=HZc2mlVJdHj4l5Qwk+kysUVNeXM/GRrRWW+hLH13XhUWl9xsQdtM09MudjM1UcJelX
         QbhQbdCgAJob9f/CnbJR9/47XbW4+I1q5ZZJ5hOwkFVgGlsWQ4UhRNbW0K1k8uJ8vsZ3
         uqap2mawQDMToX4HQNkvQFyeAZBDg+CZZQJoA3eWfQcOG8z/7+X7miMYothTxEZMMsgY
         qhy1uuvMDL+xlzSp7V41er/S+7wDyl+FwcYqyXMP6NcbAqZ44C2jJ4Av+71G/wfNy7SQ
         g4NOz1Je6IoS/JehgJghxoiJT76+WX1dZx6k7l8HZGyjkjCQxAwNdkzfThnMjjaLeoFM
         swlQ==
X-Gm-Message-State: APt69E3JHgsN0ciOk/K8VOUXouz+KUsm89T7wQff594iUHj8JBoCX/uq
        AHmIdNLy+qTp462UKuIY8rw=
X-Google-Smtp-Source: ADUXVKLwP95a7QPUCP2dR5MqXHHL6TynA1HPZwxfG75QgFBZisuPnq4h/BcXxcx/Oj+yBEsuRfsnjw==
X-Received: by 2002:a2e:cf:: with SMTP id e76-v6mr6896884lji.82.1529302121004;
        Sun, 17 Jun 2018 23:08:41 -0700 (PDT)
Received: from [10.17.182.9] (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id x80-v6sm2541440ljb.72.2018.06.17.23.08.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jun 2018 23:08:40 -0700 (PDT)
Subject: Re: [PATCH v2] drm: Replace NULL with error value in
 drm_prime_pages_to_sg
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org,
        gustavo@padovan.org, jgross@suse.com, boris.ostrovsky@oracle.com,
        dan.carpenter@oracle.com
Cc:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180618060709.14290-1-andr2000@gmail.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <00b712b8-6416-7116-1518-fe827fb9c9a3@gmail.com>
Date:   Mon, 18 Jun 2018 09:08:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618060709.14290-1-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/18/2018 09:07 AM, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>
> Dan Carpenter has reported that there is the following static checker
> warning:
> 	drivers/gpu/drm/drm_prime.c:317 drm_gem_map_dma_buf()
> 	warn: 'sgt' can also be NULL
>
> 314	sgt = obj->dev->driver->gem_prime_get_sg_table(obj);
> 315
> 316	if (!IS_ERR(sgt)) {
> 317		if (!dma_map_sg_attrs(attach->dev, sgt->sgl, sgt->nents, dir,
>
> Problematic functions are xen_drm_front_gem_get_sg_table and
> drm_gem_cma_prime_get_sg_table. Fix those by replacing NULL with error value.
>
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Dan, could you please review?
> ---
>   drivers/gpu/drm/drm_gem_cma_helper.c    | 2 +-
>   drivers/gpu/drm/xen/xen_drm_front_gem.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
> index 80a5115c3846..ce868ce288fb 100644
> --- a/drivers/gpu/drm/drm_gem_cma_helper.c
> +++ b/drivers/gpu/drm/drm_gem_cma_helper.c
> @@ -436,7 +436,7 @@ struct sg_table *drm_gem_cma_prime_get_sg_table(struct drm_gem_object *obj)
>   
>   	sgt = kzalloc(sizeof(*sgt), GFP_KERNEL);
>   	if (!sgt)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>   
Forgot to patch CMA helpers, thus v2
>   	ret = dma_get_sgtable(obj->dev->dev, sgt, cma_obj->vaddr,
>   			      cma_obj->paddr, obj->size);
> diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
> index c85bfe7571cb..47ff019d3aef 100644
> --- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
> +++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
> @@ -179,7 +179,7 @@ struct sg_table *xen_drm_front_gem_get_sg_table(struct drm_gem_object *gem_obj)
>   	struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
>   
>   	if (!xen_obj->pages)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>   
>   	return drm_prime_pages_to_sg(xen_obj->pages, xen_obj->num_pages);
>   }

