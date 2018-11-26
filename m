Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078F6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9656F2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCaYetmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9656F2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbeKZRi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 12:38:58 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42330 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeKZRi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 12:38:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so15467198lja.9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 22:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=QyQaxQf1EezJzKSylJ2LNlUQg0NlLuRVI3LHE26v+2c=;
        b=GCaYetmcrQrFh/7G0bBk9xpaiQ2G6NYlzEfZdx6wjn2JYQenCNobHdDlnnAM5H/Jdr
         X/R07B0H6VWDU0mWB9wApjmT3tF8Hl5qf1fA5D3sPvtlLRjr0Xo4YLE0+NfA6JMGKwn/
         ukkxK0XU0h1sTm/MuVrcFX37aOBDpEoNkGaxTYdcUdGgmcxO9lFCuwkHCwkaXk2HzgoB
         rGdWaIhlCMVFSbQgqyDrDkZ7Ovy4lIkOsLazytHmX5VuJ8hw5acOYm6Z+8NbI+AhzWGo
         eH98WlRwBuQpxhOQO4ht8xmaobwkO5pegwoq1oGw5pYr1Ju8EfIeCi3zkhcUMVWxTLl+
         GmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QyQaxQf1EezJzKSylJ2LNlUQg0NlLuRVI3LHE26v+2c=;
        b=XG59bPNZTwxOEJQfE1YCr+b8uvQBQdXQpJA7F5HnYRHrboKC1mL8HnWeX77Zo33SvS
         dvI92QjV9t/MBXKkvmnYCZVUEW2XS6HWZVGJkJJUgFR39x+yyabV/e9Qx+VgIJYSnXW4
         t7i4cqr3pcEqjfbWCuHquHdobMp7ARfnafQClo+P0FE/e3EtFubCETpRnsEnLxm6Vzz2
         IuboHJgVz5G0vqaieGvbVAWcdgFPfT0kGWkQY6ByVw9MOCbkYHGQMBSFLtQA8oeRXUIf
         v5oiGvOIWuxnqTMruPxTzo2nrOM6GqfaVTW0k0eQXrG2HPugmIcVhaJkPKrvRAYdnaEG
         0bHA==
X-Gm-Message-State: AA+aEWZkg98/Ilx0EIWrofce5Ni09E3qH5jjAkr8mQaGLk1W2HNOGZ2b
        HCKGpNO8N/Wy2Ji/odGdT+Q=
X-Google-Smtp-Source: AFSGD/UmXOOHnnp8N4xDI2xi+Fg+e4o6Zl811npCE4De6rqtr+6PVFt3/l8jaMkEV1+rrSi2PYWRFw==
X-Received: by 2002:a2e:6503:: with SMTP id z3-v6mr15615653ljb.153.1543214747685;
        Sun, 25 Nov 2018 22:45:47 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id o26sm2057695lfl.18.2018.11.25.22.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 22:45:46 -0800 (PST)
Subject: Re: [Xen-devel][PATCH 2/3] drm/xen-front: Use Xen common shared
 buffer implementation
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        jgross@suse.com, boris.ostrovsky@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
References: <20181122100230.14976-1-andr2000@gmail.com>
 <20181122100230.14976-2-andr2000@gmail.com>
 <20181122143354.GG4266@phenom.ffwll.local>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <78ad23da-810c-2993-9184-cd2cfa3fa06b@gmail.com>
Date:   Mon, 26 Nov 2018 08:45:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181122143354.GG4266@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Daniel!

On 11/22/18 4:33 PM, Daniel Vetter wrote:
> On Thu, Nov 22, 2018 at 12:02:29PM +0200, Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> Use page directory based shared buffer implementation
>> now available as common code for Xen frontend drivers.
>>
>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>> ---
>>   drivers/gpu/drm/xen/Kconfig               |   1 +
>>   drivers/gpu/drm/xen/Makefile              |   1 -
>>   drivers/gpu/drm/xen/xen_drm_front.c       |  60 ++--
>>   drivers/gpu/drm/xen/xen_drm_front_gem.c   |   1 -
>>   drivers/gpu/drm/xen/xen_drm_front_shbuf.c | 414 ----------------------
>>   drivers/gpu/drm/xen/xen_drm_front_shbuf.h |  64 ----
>>   6 files changed, 30 insertions(+), 511 deletions(-)
>>   delete mode 100644 drivers/gpu/drm/xen/xen_drm_front_shbuf.c
>>   delete mode 100644 drivers/gpu/drm/xen/xen_drm_front_shbuf.h
>>
>> diff --git a/drivers/gpu/drm/xen/Kconfig b/drivers/gpu/drm/xen/Kconfig
>> index 4cca160782ab..f969d486855d 100644
>> --- a/drivers/gpu/drm/xen/Kconfig
>> +++ b/drivers/gpu/drm/xen/Kconfig
>> @@ -12,6 +12,7 @@ config DRM_XEN_FRONTEND
>>   	select DRM_KMS_HELPER
>>   	select VIDEOMODE_HELPERS
>>   	select XEN_XENBUS_FRONTEND
>> +	select XEN_FRONT_PGDIR_SHBUF
>>   	help
>>   	  Choose this option if you want to enable a para-virtualized
>>   	  frontend DRM/KMS driver for Xen guest OSes.
>> diff --git a/drivers/gpu/drm/xen/Makefile b/drivers/gpu/drm/xen/Makefile
>> index 712afff5ffc3..825905f67faa 100644
>> --- a/drivers/gpu/drm/xen/Makefile
>> +++ b/drivers/gpu/drm/xen/Makefile
>> @@ -4,7 +4,6 @@ drm_xen_front-objs := xen_drm_front.o \
>>   		      xen_drm_front_kms.o \
>>   		      xen_drm_front_conn.o \
>>   		      xen_drm_front_evtchnl.o \
>> -		      xen_drm_front_shbuf.o \
>>   		      xen_drm_front_cfg.o \
>>   		      xen_drm_front_gem.o
>>   
>> diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
>> index 6b6d5ab82ec3..9597544fecc1 100644
>> --- a/drivers/gpu/drm/xen/xen_drm_front.c
>> +++ b/drivers/gpu/drm/xen/xen_drm_front.c
>> @@ -19,6 +19,7 @@
>>   #include <xen/xen.h>
>>   #include <xen/xenbus.h>
>>   
>> +#include <xen/xen-front-pgdir-shbuf.h>
>>   #include <xen/interface/io/displif.h>
>>   
>>   #include "xen_drm_front.h"
>> @@ -26,28 +27,20 @@
>>   #include "xen_drm_front_evtchnl.h"
>>   #include "xen_drm_front_gem.h"
>>   #include "xen_drm_front_kms.h"
>> -#include "xen_drm_front_shbuf.h"
>>   
>>   struct xen_drm_front_dbuf {
>>   	struct list_head list;
>>   	u64 dbuf_cookie;
>>   	u64 fb_cookie;
>> -	struct xen_drm_front_shbuf *shbuf;
>> +
>> +	struct xen_front_pgdir_shbuf shbuf;
>>   };
>>   
>> -static int dbuf_add_to_list(struct xen_drm_front_info *front_info,
>> -			    struct xen_drm_front_shbuf *shbuf, u64 dbuf_cookie)
>> +static void dbuf_add_to_list(struct xen_drm_front_info *front_info,
>> +			     struct xen_drm_front_dbuf *dbuf, u64 dbuf_cookie)
>>   {
>> -	struct xen_drm_front_dbuf *dbuf;
>> -
>> -	dbuf = kzalloc(sizeof(*dbuf), GFP_KERNEL);
>> -	if (!dbuf)
>> -		return -ENOMEM;
>> -
>>   	dbuf->dbuf_cookie = dbuf_cookie;
>> -	dbuf->shbuf = shbuf;
>>   	list_add(&dbuf->list, &front_info->dbuf_list);
>> -	return 0;
>>   }
>>   
>>   static struct xen_drm_front_dbuf *dbuf_get(struct list_head *dbuf_list,
>> @@ -64,11 +57,14 @@ static struct xen_drm_front_dbuf *dbuf_get(struct list_head *dbuf_list,
>>   
>>   static void dbuf_flush_fb(struct list_head *dbuf_list, u64 fb_cookie)
>>   {
>> +#if IS_ENABLED(CONFIG_X86)
>>   	struct xen_drm_front_dbuf *buf, *q;
>>   
>>   	list_for_each_entry_safe(buf, q, dbuf_list, list)
>>   		if (buf->fb_cookie == fb_cookie)
>> -			xen_drm_front_shbuf_flush(buf->shbuf);
>> +			drm_clflush_pages(buf->shbuf.pages,
>> +					  buf->shbuf.num_pages);
>> +#endif
> Why do we need to clflush here only on x86? Feels fairly fishy, but I
> think we've discussed this problem for long time with the original
> submission already.

First of all sorry for the late response: it took me quite some time

to dig deeper into the flushing issue and better understand the

root cause of this. At the moment my understanding is that this

flushing just hides the real problem and must be removed totally.

So, in v2 of this patch I will remove dbuf_flush_fb.

I am about to start a dedicated discussion on dri-devel with this respect

as I am still concerned about the way this can be solved: I have a suspect

and couple of solutions/workarounds, but I do also need some advise

from DRI community on this.

>
> Anyway, I'm all for code duplication removal, so if the Xen folks are
> happy with patch 1, this one here has my ack. Might also be best to merge
> all three through the Xen tree. Fallback would be xen folks sending a
> topic pull request with these 3 patches to drm-misc and takashi's sound
> tree.
> -Daniel
>
>>   }
>>   
>>   static void dbuf_free(struct list_head *dbuf_list, u64 dbuf_cookie)
>> @@ -78,8 +74,8 @@ static void dbuf_free(struct list_head *dbuf_list, u64 dbuf_cookie)
>>   	list_for_each_entry_safe(buf, q, dbuf_list, list)
>>   		if (buf->dbuf_cookie == dbuf_cookie) {
>>   			list_del(&buf->list);
>> -			xen_drm_front_shbuf_unmap(buf->shbuf);
>> -			xen_drm_front_shbuf_free(buf->shbuf);
>> +			xen_front_pgdir_shbuf_unmap(&buf->shbuf);
>> +			xen_front_pgdir_shbuf_free(&buf->shbuf);
>>   			kfree(buf);
>>   			break;
>>   		}
>> @@ -91,8 +87,8 @@ static void dbuf_free_all(struct list_head *dbuf_list)
>>   
>>   	list_for_each_entry_safe(buf, q, dbuf_list, list) {
>>   		list_del(&buf->list);
>> -		xen_drm_front_shbuf_unmap(buf->shbuf);
>> -		xen_drm_front_shbuf_free(buf->shbuf);
>> +		xen_front_pgdir_shbuf_unmap(&buf->shbuf);
>> +		xen_front_pgdir_shbuf_free(&buf->shbuf);
>>   		kfree(buf);
>>   	}
>>   }
>> @@ -171,9 +167,9 @@ int xen_drm_front_dbuf_create(struct xen_drm_front_info *front_info,
>>   			      u32 bpp, u64 size, struct page **pages)
>>   {
>>   	struct xen_drm_front_evtchnl *evtchnl;
>> -	struct xen_drm_front_shbuf *shbuf;
>> +	struct xen_drm_front_dbuf *dbuf;
>>   	struct xendispl_req *req;
>> -	struct xen_drm_front_shbuf_cfg buf_cfg;
>> +	struct xen_front_pgdir_shbuf_cfg buf_cfg;
>>   	unsigned long flags;
>>   	int ret;
>>   
>> @@ -181,28 +177,29 @@ int xen_drm_front_dbuf_create(struct xen_drm_front_info *front_info,
>>   	if (unlikely(!evtchnl))
>>   		return -EIO;
>>   
>> +	dbuf = kzalloc(sizeof(*dbuf), GFP_KERNEL);
>> +	if (!dbuf)
>> +		return -ENOMEM;
>> +
>> +	dbuf_add_to_list(front_info, dbuf, dbuf_cookie);
>> +
>>   	memset(&buf_cfg, 0, sizeof(buf_cfg));
>>   	buf_cfg.xb_dev = front_info->xb_dev;
>> +	buf_cfg.num_pages = DIV_ROUND_UP(size, PAGE_SIZE);
>>   	buf_cfg.pages = pages;
>> -	buf_cfg.size = size;
>> +	buf_cfg.pgdir = &dbuf->shbuf;
>>   	buf_cfg.be_alloc = front_info->cfg.be_alloc;
>>   
>> -	shbuf = xen_drm_front_shbuf_alloc(&buf_cfg);
>> -	if (IS_ERR(shbuf))
>> -		return PTR_ERR(shbuf);
>> -
>> -	ret = dbuf_add_to_list(front_info, shbuf, dbuf_cookie);
>> -	if (ret < 0) {
>> -		xen_drm_front_shbuf_free(shbuf);
>> -		return ret;
>> -	}
>> +	ret = xen_front_pgdir_shbuf_alloc(&buf_cfg);
>> +	if (ret < 0)
>> +		goto fail_shbuf_alloc;
>>   
>>   	mutex_lock(&evtchnl->u.req.req_io_lock);
>>   
>>   	spin_lock_irqsave(&front_info->io_lock, flags);
>>   	req = be_prepare_req(evtchnl, XENDISPL_OP_DBUF_CREATE);
>>   	req->op.dbuf_create.gref_directory =
>> -			xen_drm_front_shbuf_get_dir_start(shbuf);
>> +			xen_front_pgdir_shbuf_get_dir_start(&dbuf->shbuf);
>>   	req->op.dbuf_create.buffer_sz = size;
>>   	req->op.dbuf_create.dbuf_cookie = dbuf_cookie;
>>   	req->op.dbuf_create.width = width;
>> @@ -221,7 +218,7 @@ int xen_drm_front_dbuf_create(struct xen_drm_front_info *front_info,
>>   	if (ret < 0)
>>   		goto fail;
>>   
>> -	ret = xen_drm_front_shbuf_map(shbuf);
>> +	ret = xen_front_pgdir_shbuf_map(&dbuf->shbuf);
>>   	if (ret < 0)
>>   		goto fail;
>>   
>> @@ -230,6 +227,7 @@ int xen_drm_front_dbuf_create(struct xen_drm_front_info *front_info,
>>   
>>   fail:
>>   	mutex_unlock(&evtchnl->u.req.req_io_lock);
>> +fail_shbuf_alloc:
>>   	dbuf_free(&front_info->dbuf_list, dbuf_cookie);
>>   	return ret;
>>   }
>> diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
>> index c85bfe7571cb..53be4c7dc0a4 100644
>> --- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
>> +++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
>> @@ -22,7 +22,6 @@
>>   #include <xen/balloon.h>
>>   
>>   #include "xen_drm_front.h"
>> -#include "xen_drm_front_shbuf.h"
>>   
>>   struct xen_gem_object {
>>   	struct drm_gem_object base;
>> diff --git a/drivers/gpu/drm/xen/xen_drm_front_shbuf.c b/drivers/gpu/drm/xen/xen_drm_front_shbuf.c
>> deleted file mode 100644
>> index d333b67cc1a0..000000000000
>> --- a/drivers/gpu/drm/xen/xen_drm_front_shbuf.c
>> +++ /dev/null
>> @@ -1,414 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0 OR MIT
>> -
>> -/*
>> - *  Xen para-virtual DRM device
>> - *
>> - * Copyright (C) 2016-2018 EPAM Systems Inc.
>> - *
>> - * Author: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>> - */
>> -
>> -#include <drm/drmP.h>
>> -
>> -#if defined(CONFIG_X86)
>> -#include <drm/drm_cache.h>
>> -#endif
>> -#include <linux/errno.h>
>> -#include <linux/mm.h>
>> -
>> -#include <asm/xen/hypervisor.h>
>> -#include <xen/balloon.h>
>> -#include <xen/xen.h>
>> -#include <xen/xenbus.h>
>> -#include <xen/interface/io/ring.h>
>> -#include <xen/interface/io/displif.h>
>> -
>> -#include "xen_drm_front.h"
>> -#include "xen_drm_front_shbuf.h"
>> -
>> -struct xen_drm_front_shbuf_ops {
>> -	/*
>> -	 * Calculate number of grefs required to handle this buffer,
>> -	 * e.g. if grefs are required for page directory only or the buffer
>> -	 * pages as well.
>> -	 */
>> -	void (*calc_num_grefs)(struct xen_drm_front_shbuf *buf);
>> -	/* Fill page directory according to para-virtual display protocol. */
>> -	void (*fill_page_dir)(struct xen_drm_front_shbuf *buf);
>> -	/* Claim grant references for the pages of the buffer. */
>> -	int (*grant_refs_for_buffer)(struct xen_drm_front_shbuf *buf,
>> -				     grant_ref_t *priv_gref_head, int gref_idx);
>> -	/* Map grant references of the buffer. */
>> -	int (*map)(struct xen_drm_front_shbuf *buf);
>> -	/* Unmap grant references of the buffer. */
>> -	int (*unmap)(struct xen_drm_front_shbuf *buf);
>> -};
>> -
>> -grant_ref_t xen_drm_front_shbuf_get_dir_start(struct xen_drm_front_shbuf *buf)
>> -{
>> -	if (!buf->grefs)
>> -		return GRANT_INVALID_REF;
>> -
>> -	return buf->grefs[0];
>> -}
>> -
>> -int xen_drm_front_shbuf_map(struct xen_drm_front_shbuf *buf)
>> -{
>> -	if (buf->ops->map)
>> -		return buf->ops->map(buf);
>> -
>> -	/* no need to map own grant references */
>> -	return 0;
>> -}
>> -
>> -int xen_drm_front_shbuf_unmap(struct xen_drm_front_shbuf *buf)
>> -{
>> -	if (buf->ops->unmap)
>> -		return buf->ops->unmap(buf);
>> -
>> -	/* no need to unmap own grant references */
>> -	return 0;
>> -}
>> -
>> -void xen_drm_front_shbuf_flush(struct xen_drm_front_shbuf *buf)
>> -{
>> -#if defined(CONFIG_X86)
>> -	drm_clflush_pages(buf->pages, buf->num_pages);
>> -#endif
>> -}
>> -
>> -void xen_drm_front_shbuf_free(struct xen_drm_front_shbuf *buf)
>> -{
>> -	if (buf->grefs) {
>> -		int i;
>> -
>> -		for (i = 0; i < buf->num_grefs; i++)
>> -			if (buf->grefs[i] != GRANT_INVALID_REF)
>> -				gnttab_end_foreign_access(buf->grefs[i],
>> -							  0, 0UL);
>> -	}
>> -	kfree(buf->grefs);
>> -	kfree(buf->directory);
>> -	kfree(buf);
>> -}
>> -
>> -/*
>> - * number of grefs a page can hold with respect to the
>> - * struct xendispl_page_directory header
>> - */
>> -#define XEN_DRM_NUM_GREFS_PER_PAGE ((PAGE_SIZE - \
>> -		offsetof(struct xendispl_page_directory, gref)) / \
>> -		sizeof(grant_ref_t))
>> -
>> -static int get_num_pages_dir(struct xen_drm_front_shbuf *buf)
>> -{
>> -	/* number of pages the page directory consumes itself */
>> -	return DIV_ROUND_UP(buf->num_pages, XEN_DRM_NUM_GREFS_PER_PAGE);
>> -}
>> -
>> -static void backend_calc_num_grefs(struct xen_drm_front_shbuf *buf)
>> -{
>> -	/* only for pages the page directory consumes itself */
>> -	buf->num_grefs = get_num_pages_dir(buf);
>> -}
>> -
>> -static void guest_calc_num_grefs(struct xen_drm_front_shbuf *buf)
>> -{
>> -	/*
>> -	 * number of pages the page directory consumes itself
>> -	 * plus grefs for the buffer pages
>> -	 */
>> -	buf->num_grefs = get_num_pages_dir(buf) + buf->num_pages;
>> -}
>> -
>> -#define xen_page_to_vaddr(page) \
>> -		((uintptr_t)pfn_to_kaddr(page_to_xen_pfn(page)))
>> -
>> -static int backend_unmap(struct xen_drm_front_shbuf *buf)
>> -{
>> -	struct gnttab_unmap_grant_ref *unmap_ops;
>> -	int i, ret;
>> -
>> -	if (!buf->pages || !buf->backend_map_handles || !buf->grefs)
>> -		return 0;
>> -
>> -	unmap_ops = kcalloc(buf->num_pages, sizeof(*unmap_ops),
>> -			    GFP_KERNEL);
>> -	if (!unmap_ops) {
>> -		DRM_ERROR("Failed to get memory while unmapping\n");
>> -		return -ENOMEM;
>> -	}
>> -
>> -	for (i = 0; i < buf->num_pages; i++) {
>> -		phys_addr_t addr;
>> -
>> -		addr = xen_page_to_vaddr(buf->pages[i]);
>> -		gnttab_set_unmap_op(&unmap_ops[i], addr, GNTMAP_host_map,
>> -				    buf->backend_map_handles[i]);
>> -	}
>> -
>> -	ret = gnttab_unmap_refs(unmap_ops, NULL, buf->pages,
>> -				buf->num_pages);
>> -
>> -	for (i = 0; i < buf->num_pages; i++) {
>> -		if (unlikely(unmap_ops[i].status != GNTST_okay))
>> -			DRM_ERROR("Failed to unmap page %d: %d\n",
>> -				  i, unmap_ops[i].status);
>> -	}
>> -
>> -	if (ret)
>> -		DRM_ERROR("Failed to unmap grant references, ret %d", ret);
>> -
>> -	kfree(unmap_ops);
>> -	kfree(buf->backend_map_handles);
>> -	buf->backend_map_handles = NULL;
>> -	return ret;
>> -}
>> -
>> -static int backend_map(struct xen_drm_front_shbuf *buf)
>> -{
>> -	struct gnttab_map_grant_ref *map_ops = NULL;
>> -	unsigned char *ptr;
>> -	int ret, cur_gref, cur_dir_page, cur_page, grefs_left;
>> -
>> -	map_ops = kcalloc(buf->num_pages, sizeof(*map_ops), GFP_KERNEL);
>> -	if (!map_ops)
>> -		return -ENOMEM;
>> -
>> -	buf->backend_map_handles = kcalloc(buf->num_pages,
>> -					   sizeof(*buf->backend_map_handles),
>> -					   GFP_KERNEL);
>> -	if (!buf->backend_map_handles) {
>> -		kfree(map_ops);
>> -		return -ENOMEM;
>> -	}
>> -
>> -	/*
>> -	 * read page directory to get grefs from the backend: for external
>> -	 * buffer we only allocate buf->grefs for the page directory,
>> -	 * so buf->num_grefs has number of pages in the page directory itself
>> -	 */
>> -	ptr = buf->directory;
>> -	grefs_left = buf->num_pages;
>> -	cur_page = 0;
>> -	for (cur_dir_page = 0; cur_dir_page < buf->num_grefs; cur_dir_page++) {
>> -		struct xendispl_page_directory *page_dir =
>> -				(struct xendispl_page_directory *)ptr;
>> -		int to_copy = XEN_DRM_NUM_GREFS_PER_PAGE;
>> -
>> -		if (to_copy > grefs_left)
>> -			to_copy = grefs_left;
>> -
>> -		for (cur_gref = 0; cur_gref < to_copy; cur_gref++) {
>> -			phys_addr_t addr;
>> -
>> -			addr = xen_page_to_vaddr(buf->pages[cur_page]);
>> -			gnttab_set_map_op(&map_ops[cur_page], addr,
>> -					  GNTMAP_host_map,
>> -					  page_dir->gref[cur_gref],
>> -					  buf->xb_dev->otherend_id);
>> -			cur_page++;
>> -		}
>> -
>> -		grefs_left -= to_copy;
>> -		ptr += PAGE_SIZE;
>> -	}
>> -	ret = gnttab_map_refs(map_ops, NULL, buf->pages, buf->num_pages);
>> -
>> -	/* save handles even if error, so we can unmap */
>> -	for (cur_page = 0; cur_page < buf->num_pages; cur_page++) {
>> -		buf->backend_map_handles[cur_page] = map_ops[cur_page].handle;
>> -		if (unlikely(map_ops[cur_page].status != GNTST_okay))
>> -			DRM_ERROR("Failed to map page %d: %d\n",
>> -				  cur_page, map_ops[cur_page].status);
>> -	}
>> -
>> -	if (ret) {
>> -		DRM_ERROR("Failed to map grant references, ret %d", ret);
>> -		backend_unmap(buf);
>> -	}
>> -
>> -	kfree(map_ops);
>> -	return ret;
>> -}
>> -
>> -static void backend_fill_page_dir(struct xen_drm_front_shbuf *buf)
>> -{
>> -	struct xendispl_page_directory *page_dir;
>> -	unsigned char *ptr;
>> -	int i, num_pages_dir;
>> -
>> -	ptr = buf->directory;
>> -	num_pages_dir = get_num_pages_dir(buf);
>> -
>> -	/* fill only grefs for the page directory itself */
>> -	for (i = 0; i < num_pages_dir - 1; i++) {
>> -		page_dir = (struct xendispl_page_directory *)ptr;
>> -
>> -		page_dir->gref_dir_next_page = buf->grefs[i + 1];
>> -		ptr += PAGE_SIZE;
>> -	}
>> -	/* last page must say there is no more pages */
>> -	page_dir = (struct xendispl_page_directory *)ptr;
>> -	page_dir->gref_dir_next_page = GRANT_INVALID_REF;
>> -}
>> -
>> -static void guest_fill_page_dir(struct xen_drm_front_shbuf *buf)
>> -{
>> -	unsigned char *ptr;
>> -	int cur_gref, grefs_left, to_copy, i, num_pages_dir;
>> -
>> -	ptr = buf->directory;
>> -	num_pages_dir = get_num_pages_dir(buf);
>> -
>> -	/*
>> -	 * while copying, skip grefs at start, they are for pages
>> -	 * granted for the page directory itself
>> -	 */
>> -	cur_gref = num_pages_dir;
>> -	grefs_left = buf->num_pages;
>> -	for (i = 0; i < num_pages_dir; i++) {
>> -		struct xendispl_page_directory *page_dir =
>> -				(struct xendispl_page_directory *)ptr;
>> -
>> -		if (grefs_left <= XEN_DRM_NUM_GREFS_PER_PAGE) {
>> -			to_copy = grefs_left;
>> -			page_dir->gref_dir_next_page = GRANT_INVALID_REF;
>> -		} else {
>> -			to_copy = XEN_DRM_NUM_GREFS_PER_PAGE;
>> -			page_dir->gref_dir_next_page = buf->grefs[i + 1];
>> -		}
>> -		memcpy(&page_dir->gref, &buf->grefs[cur_gref],
>> -		       to_copy * sizeof(grant_ref_t));
>> -		ptr += PAGE_SIZE;
>> -		grefs_left -= to_copy;
>> -		cur_gref += to_copy;
>> -	}
>> -}
>> -
>> -static int guest_grant_refs_for_buffer(struct xen_drm_front_shbuf *buf,
>> -				       grant_ref_t *priv_gref_head,
>> -				       int gref_idx)
>> -{
>> -	int i, cur_ref, otherend_id;
>> -
>> -	otherend_id = buf->xb_dev->otherend_id;
>> -	for (i = 0; i < buf->num_pages; i++) {
>> -		cur_ref = gnttab_claim_grant_reference(priv_gref_head);
>> -		if (cur_ref < 0)
>> -			return cur_ref;
>> -
>> -		gnttab_grant_foreign_access_ref(cur_ref, otherend_id,
>> -						xen_page_to_gfn(buf->pages[i]),
>> -						0);
>> -		buf->grefs[gref_idx++] = cur_ref;
>> -	}
>> -	return 0;
>> -}
>> -
>> -static int grant_references(struct xen_drm_front_shbuf *buf)
>> -{
>> -	grant_ref_t priv_gref_head;
>> -	int ret, i, j, cur_ref;
>> -	int otherend_id, num_pages_dir;
>> -
>> -	ret = gnttab_alloc_grant_references(buf->num_grefs, &priv_gref_head);
>> -	if (ret < 0) {
>> -		DRM_ERROR("Cannot allocate grant references\n");
>> -		return ret;
>> -	}
>> -
>> -	otherend_id = buf->xb_dev->otherend_id;
>> -	j = 0;
>> -	num_pages_dir = get_num_pages_dir(buf);
>> -	for (i = 0; i < num_pages_dir; i++) {
>> -		unsigned long frame;
>> -
>> -		cur_ref = gnttab_claim_grant_reference(&priv_gref_head);
>> -		if (cur_ref < 0)
>> -			return cur_ref;
>> -
>> -		frame = xen_page_to_gfn(virt_to_page(buf->directory +
>> -					PAGE_SIZE * i));
>> -		gnttab_grant_foreign_access_ref(cur_ref, otherend_id, frame, 0);
>> -		buf->grefs[j++] = cur_ref;
>> -	}
>> -
>> -	if (buf->ops->grant_refs_for_buffer) {
>> -		ret = buf->ops->grant_refs_for_buffer(buf, &priv_gref_head, j);
>> -		if (ret)
>> -			return ret;
>> -	}
>> -
>> -	gnttab_free_grant_references(priv_gref_head);
>> -	return 0;
>> -}
>> -
>> -static int alloc_storage(struct xen_drm_front_shbuf *buf)
>> -{
>> -	buf->grefs = kcalloc(buf->num_grefs, sizeof(*buf->grefs), GFP_KERNEL);
>> -	if (!buf->grefs)
>> -		return -ENOMEM;
>> -
>> -	buf->directory = kcalloc(get_num_pages_dir(buf), PAGE_SIZE, GFP_KERNEL);
>> -	if (!buf->directory)
>> -		return -ENOMEM;
>> -
>> -	return 0;
>> -}
>> -
>> -/*
>> - * For be allocated buffers we don't need grant_refs_for_buffer as those
>> - * grant references are allocated at backend side
>> - */
>> -static const struct xen_drm_front_shbuf_ops backend_ops = {
>> -	.calc_num_grefs = backend_calc_num_grefs,
>> -	.fill_page_dir = backend_fill_page_dir,
>> -	.map = backend_map,
>> -	.unmap = backend_unmap
>> -};
>> -
>> -/* For locally granted references we do not need to map/unmap the references */
>> -static const struct xen_drm_front_shbuf_ops local_ops = {
>> -	.calc_num_grefs = guest_calc_num_grefs,
>> -	.fill_page_dir = guest_fill_page_dir,
>> -	.grant_refs_for_buffer = guest_grant_refs_for_buffer,
>> -};
>> -
>> -struct xen_drm_front_shbuf *
>> -xen_drm_front_shbuf_alloc(struct xen_drm_front_shbuf_cfg *cfg)
>> -{
>> -	struct xen_drm_front_shbuf *buf;
>> -	int ret;
>> -
>> -	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
>> -	if (!buf)
>> -		return ERR_PTR(-ENOMEM);
>> -
>> -	if (cfg->be_alloc)
>> -		buf->ops = &backend_ops;
>> -	else
>> -		buf->ops = &local_ops;
>> -
>> -	buf->xb_dev = cfg->xb_dev;
>> -	buf->num_pages = DIV_ROUND_UP(cfg->size, PAGE_SIZE);
>> -	buf->pages = cfg->pages;
>> -
>> -	buf->ops->calc_num_grefs(buf);
>> -
>> -	ret = alloc_storage(buf);
>> -	if (ret)
>> -		goto fail;
>> -
>> -	ret = grant_references(buf);
>> -	if (ret)
>> -		goto fail;
>> -
>> -	buf->ops->fill_page_dir(buf);
>> -
>> -	return buf;
>> -
>> -fail:
>> -	xen_drm_front_shbuf_free(buf);
>> -	return ERR_PTR(ret);
>> -}
>> diff --git a/drivers/gpu/drm/xen/xen_drm_front_shbuf.h b/drivers/gpu/drm/xen/xen_drm_front_shbuf.h
>> deleted file mode 100644
>> index 7545c692539e..000000000000
>> --- a/drivers/gpu/drm/xen/xen_drm_front_shbuf.h
>> +++ /dev/null
>> @@ -1,64 +0,0 @@
>> -/* SPDX-License-Identifier: GPL-2.0 OR MIT */
>> -
>> -/*
>> - *  Xen para-virtual DRM device
>> - *
>> - * Copyright (C) 2016-2018 EPAM Systems Inc.
>> - *
>> - * Author: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>> - */
>> -
>> -#ifndef __XEN_DRM_FRONT_SHBUF_H_
>> -#define __XEN_DRM_FRONT_SHBUF_H_
>> -
>> -#include <linux/kernel.h>
>> -#include <linux/scatterlist.h>
>> -
>> -#include <xen/grant_table.h>
>> -
>> -struct xen_drm_front_shbuf {
>> -	/*
>> -	 * number of references granted for the backend use:
>> -	 *  - for allocated/imported dma-buf's this holds number of grant
>> -	 *    references for the page directory and pages of the buffer
>> -	 *  - for the buffer provided by the backend this holds number of
>> -	 *    grant references for the page directory as grant references for
>> -	 *    the buffer will be provided by the backend
>> -	 */
>> -	int num_grefs;
>> -	grant_ref_t *grefs;
>> -	unsigned char *directory;
>> -
>> -	int num_pages;
>> -	struct page **pages;
>> -
>> -	struct xenbus_device *xb_dev;
>> -
>> -	/* these are the ops used internally depending on be_alloc mode */
>> -	const struct xen_drm_front_shbuf_ops *ops;
>> -
>> -	/* Xen map handles for the buffer allocated by the backend */
>> -	grant_handle_t *backend_map_handles;
>> -};
>> -
>> -struct xen_drm_front_shbuf_cfg {
>> -	struct xenbus_device *xb_dev;
>> -	size_t size;
>> -	struct page **pages;
>> -	bool be_alloc;
>> -};
>> -
>> -struct xen_drm_front_shbuf *
>> -xen_drm_front_shbuf_alloc(struct xen_drm_front_shbuf_cfg *cfg);
>> -
>> -grant_ref_t xen_drm_front_shbuf_get_dir_start(struct xen_drm_front_shbuf *buf);
>> -
>> -int xen_drm_front_shbuf_map(struct xen_drm_front_shbuf *buf);
>> -
>> -int xen_drm_front_shbuf_unmap(struct xen_drm_front_shbuf *buf);
>> -
>> -void xen_drm_front_shbuf_flush(struct xen_drm_front_shbuf *buf);
>> -
>> -void xen_drm_front_shbuf_free(struct xen_drm_front_shbuf *buf);
>> -
>> -#endif /* __XEN_DRM_FRONT_SHBUF_H_ */
>> -- 
>> 2.19.1
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel

Thank you,

Oleksandr

