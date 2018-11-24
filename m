Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7361C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 00:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628D420868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 00:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20150623.gappssmtp.com header.i=@dubeyko-com.20150623.gappssmtp.com header.b="wr0HF1gl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628D420868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbeKXLiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 06:38:25 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37655 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbeKXLiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 06:38:24 -0500
Received: by mail-pf1-f195.google.com with SMTP id u3-v6so3965956pfm.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 16:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XziGM6DHoArBzDrxn00kdBpyQ80f9urGU+CKhUkADO4=;
        b=wr0HF1gl0lh70FqeQCT1m0aCsboh7HI6OF9EAofV5acn5Gc0PkXKsnG8AtQwitxbxp
         pIw/FzGsJci5HMjcX7VE3RUcQ4DPBQw2S0jbYJf9NAJ06GW05N7Ei3cyIOENi7CG6cR3
         9zLWmI5WC1orkZ2hfjpl0Z6zg0EHAQsAAu4oQ2jJE4uvo7DkZhM3cLQ3cEeEs/IsMWHR
         eMZaVsYNz5t+wRBYMeQS/lXQiGX6dlY5zRdddIDsXBdgDPq+A+GhXSy3gqJ3IeSx1Qrk
         w9sUxGIKiDcIvIqKxUq+LBh31hAuTGwSx1XpVZoHps5p+Shd7AoCW4wF+q3/rEFNdQKO
         Xc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XziGM6DHoArBzDrxn00kdBpyQ80f9urGU+CKhUkADO4=;
        b=UYlpahIIchWXFRKCKQb1Btq/FFk8+e1Pr0pRSxRh2BMspT0i8Ujq5ezqp8sAmkK93Y
         C6YK8zGX74BsObrbqvy/i1V8MM91HJzFtn7eVl9GZVZVVGKmu+ILAyoKMkf5z9W/oMxi
         64VJiWTy2cyllFMAhYktM6Idr2Jh23sS9eOkdB9EjTTv+x9zOSDbdlabnuRv9ODP+uAy
         SS1OG+LVUvJuPlVmN/hUfJKKxUisMe0g2goy2mrJTa4nNHYlcOCdrlezZSCxHEAApkvl
         Vfizho2/34vBaOMoSKCamkqz4ew6VijzoQQ4368u/13v9oU8CzdZRF7vtlQqJxvMzcSC
         Xilg==
X-Gm-Message-State: AA+aEWYEt8zEG4CD8Ew80z9qZpnGUDuiq9S3coBHKyEr3CoZHedtZkMJ
        8osputt+gYmbZsebuLdi6Rmt2A==
X-Google-Smtp-Source: AFSGD/XziNJfHQUAyX7mgEq3bYKtZRMaUvq/KA9SnQYcqXLNnZNj1CsjEcWXUijfOd7cdIrhfXaQ8w==
X-Received: by 2002:a62:7dcb:: with SMTP id y194mr7765686pfc.113.1543020718195;
        Fri, 23 Nov 2018 16:51:58 -0800 (PST)
Received: from ubuntu-16 (c-24-130-14-162.hsd1.ca.comcast.net. [24.130.14.162])
        by smtp.gmail.com with ESMTPSA id d21sm50304357pgv.37.2018.11.23.16.51.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 16:51:51 -0800 (PST)
Message-ID: <1543020709.12764.3.camel@dubeyko.com>
Subject: Re: [PATCH] hfs: do not free node before using
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     Pan Bian <bianpan2016@163.com>, Joe Perches <joe@perches.com>,
        "Ernesto A." =?ISO-8859-1?Q?Fern=E1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 23 Nov 2018 16:51:49 -0800
In-Reply-To: <1542963889-128825-1-git-send-email-bianpan2016@163.com>
References: <1542963889-128825-1-git-send-email-bianpan2016@163.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-23 at 17:04 +0800, Pan Bian wrote:
> The function hfs_bmap_free frees node via hfs_bnode_put(node).
> However,
> it then reads node->this when dumping error message on an error path,
> which may result in a use-after-free bug. This patch frees node only
> when it is never used.
> 
> Fixes: d614267329f("hfs/hfsplus: convert printks to pr_<level>")
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  fs/hfs/btree.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> index 98b96ff..19017d2 100644
> --- a/fs/hfs/btree.c
> +++ b/fs/hfs/btree.c
> @@ -338,13 +338,14 @@ void hfs_bmap_free(struct hfs_bnode *node)
>  
>  		nidx -= len * 8;
>  		i = node->next;
> -		hfs_bnode_put(node);
>  		if (!i) {
>  			/* panic */;
>  			pr_crit("unable to free bnode %u. bmap not
> found!\n",
>  				node->this);


What's about simply to store node->this into the local variable in the
beginning of the cycle? In this case, it is possible to use the node ID
in the pr_crit() and to use the hfs_bnode_put(node) in the same place
without to use it twice. What do you think?

Thanks,
Vyacheslav Dubeyko.


> +			hfs_bnode_put(node);
>  			return;
>  		}
> +		hfs_bnode_put(node);
>  		node = hfs_bnode_find(tree, i);
>  		if (IS_ERR(node))
>  			return;
