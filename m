Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D440FC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974032084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="AoSsZbad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfBCVzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 16:55:03 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42233 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbfBCVzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 16:55:03 -0500
Received: by mail-qk1-f196.google.com with SMTP id y140so805097qkb.9
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 13:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=LfOyGTpx+NJA2WVgATJ4oQ24sfhy5QkcmQSkprv36EU=;
        b=AoSsZbad648aFQWcFf4TIovnlRUbeCBi2hCtU2EgTcnqp8D1m06MI1TWiKg+zzoBoX
         Ku2iAfN4b2ia4xxxLJwxL0CyyH/uWEMoszLSUHVQNA74oFraYI4bIUWolJNRIqMdabU1
         kjUxKstW+3a3+BnYqJc+nS54osb0RdsthSZmobLscHxYHgI50LjDJ4N+9d5kaSwAfVQz
         IQnIO/6BZKM7nHxyDwWWNtUpLeENQZT31THAkddetJvQpz9y5QlPmxZsyB3fyT2vSRMT
         0kaI072tTNA489QaByDhU3QqaaZ31XK0iXd/WqJ3bh9WN4cQbAxqaV3MCGc3N3d9g11+
         5X4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=LfOyGTpx+NJA2WVgATJ4oQ24sfhy5QkcmQSkprv36EU=;
        b=I2h0iRTELA7zhRvVmet2BFB9g/gG4G00Ul/GnUJLc0k84ilVjIeakgt2CNHLZsxMSK
         PBx5wdo5HQFPfBJjnXX+oK09v71e/VhLHy9O35pAVNrxiOySAGxz5BOvztp6przD7Hep
         gLCIdtUq2yAcpGQ3FKdsjZtk1RFL2ytOj+ejzJEVOTiEAOXjVGlxaQ+5Fk/v5KJIx+LP
         Xse3uK4PbuR4DxRPhk4t/ObmBJa6kK9/579CW0kK8dASV+mCezj6KAS8w3a3yL/t4k1R
         FUteIKUxMpW5VtaVsKkEjnRiIU848XSjN+LNz54BlHgy84kBxNTyqyVhl1bh461fEhMH
         6Aww==
X-Gm-Message-State: AJcUukfCw59gUEhWofsnhGyc7oIB/2bhMFiAASJxAQVgA1LJr0Wfp/Xb
        M+vXMPidwlM8ALRlbePPx84TZg==
X-Google-Smtp-Source: ALg8bN6XnpsxFWqBB+oxsFSbGyTN1UKw4/FOF7kOPdjeMo7jOkfW+5RQYCmO8zSMH5BFANmGxF18Sw==
X-Received: by 2002:ae9:f40b:: with SMTP id y11mr43887611qkl.228.1549230902048;
        Sun, 03 Feb 2019 13:55:02 -0800 (PST)
Received: from skullcanyon ([192.222.193.21])
        by smtp.gmail.com with ESMTPSA id m44sm12376269qtm.97.2019.02.03.13.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Feb 2019 13:55:01 -0800 (PST)
Message-ID: <22f10cf289b8115fa9e60f89edc24ec2cf0f676d.camel@ndufresne.ca>
Subject: Re: [PATCH] media: videobuf2: Return error after allocation failure
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Souptick Joarder <jrdr.linux@gmail.com>, pawel@osciak.com,
        m.szyprowski@samsung.com, kyungmin.park@samsung.com,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com, brajeswar.linux@gmail.com
Date:   Sun, 03 Feb 2019 16:54:59 -0500
In-Reply-To: <20190203133608.GA26010@jordon-HP-15-Notebook-PC>
References: <20190203133608.GA26010@jordon-HP-15-Notebook-PC>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le dimanche 03 février 2019 à 19:06 +0530, Souptick Joarder a écrit :
> There is no point to continuing assignemnt after memory allocation

assignemnt -> assignment.

> failed, rather throw error immediately.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/media/common/videobuf2/videobuf2-vmalloc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-vmalloc.c b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
> index 6dfbd5b..d3f71e2 100644
> --- a/drivers/media/common/videobuf2/videobuf2-vmalloc.c
> +++ b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
> @@ -46,16 +46,16 @@ static void *vb2_vmalloc_alloc(struct device *dev, unsigned long attrs,
>  
>  	buf->size = size;
>  	buf->vaddr = vmalloc_user(buf->size);
> -	buf->dma_dir = dma_dir;
> -	buf->handler.refcount = &buf->refcount;
> -	buf->handler.put = vb2_vmalloc_put;
> -	buf->handler.arg = buf;
>  
>  	if (!buf->vaddr) {
>  		pr_debug("vmalloc of size %ld failed\n", buf->size);
>  		kfree(buf);
>  		return ERR_PTR(-ENOMEM);
>  	}
> +	buf->dma_dir = dma_dir;
> +	buf->handler.refcount = &buf->refcount;
> +	buf->handler.put = vb2_vmalloc_put;
> +	buf->handler.arg = buf;
>  
>  	refcount_set(&buf->refcount, 1);
>  	return buf;

