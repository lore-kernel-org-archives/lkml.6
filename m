Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8410C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E82F20833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R5NSpW30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E82F20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbeILVqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:46:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59782 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbeILVqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KiTQfn4Cjuzb84qR9Y4s0DWeekIzQkWZhFbYjA1J0I8=; b=R5NSpW305hSrUNs+0+Ckly2l3
        282iVwUe99S0mhwfjZN7DvgVzAv+UJcS/i8rrcDlBV7VuRUhsOnbiW7SexpN4B/stS+kR1yRIjOIj
        iZ1Zal6qs2QBcWrwZArFAl+LpufjUtBRqasHTv5TQARODXX0acsxQ3T3YvLvBqDx+PMXbHjUac2gt
        xWBhVWpC69AErYNTSPiC3Pi+C59Byn0SB0W11bBNjYHpJjFJAF16trlqrQXsdLdUBfPQC3p5+HAmn
        TgjXYV2uTtvGzRav4GHLwCWEJNgLd4TEdFUcekJJdlGwhbxu9tDC20DBXY3pATDnPErNs7pyZFhH3
        L4KFAGH5Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g08C0-0005cc-2f; Wed, 12 Sep 2018 16:40:40 +0000
Subject: Re: [PATCH v3 1/3] udmabuf: add documentation
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     laurent.pinchart@ideasonboard.com, daniel@ffwll.ch,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180912063316.21047-1-kraxel@redhat.com>
 <20180912063316.21047-2-kraxel@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4d4ffe16-f46d-5dda-68b6-38f59e228214@infradead.org>
Date:   Wed, 12 Sep 2018 09:40:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180912063316.21047-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd,

Missed one from yesterday:

On 9/11/18 11:33 PM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/uapi/linux/udmabuf.h         | 51 +++++++++++++++++++++++++++++++++---
>  Documentation/driver-api/dma-buf.rst |  8 ++++++
>  2 files changed, 56 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/udmabuf.h b/include/uapi/linux/udmabuf.h
> index 46b6532ed8..281e2c52f1 100644
> --- a/include/uapi/linux/udmabuf.h
> +++ b/include/uapi/linux/udmabuf.h
> @@ -5,8 +5,39 @@
>  #include <linux/types.h>
>  #include <linux/ioctl.h>
>  
> +/**
> + * DOC: udmabuf
> + *
> + * udmabuf is a device driver which allows userspace to create
> + * dmabufs.  The memory used for these dmabufs must be backed by
> + * memfd.  The memfd must have F_SEAL_SHRINK and it must not have
> + * F_SEAL_WRITE.
> + *
> + * The driver has two ioctls, one to create a dmabuf from a single
> + * memory block and one to create a dmabuf from a list of memory
> + * blocks.
> + *
> + * UDMABUF_CREATE - _IOW('u', 0x42, udmabuf_create)
> + *
> + * UDMABUF_CREATE_LIST - _IOW('u', 0x43, udmabuf_create_list)
> + */
> +
> +#define UDMABUF_CREATE       _IOW('u', 0x42, struct udmabuf_create)
> +#define UDMABUF_CREATE_LIST  _IOW('u', 0x43, struct udmabuf_create_list)
> +
>  #define UDMABUF_FLAGS_CLOEXEC	0x01
>  
> +/**
> + * struct udmabuf_create - create a dmabuf from a single memory block.
> + *
> + * @memfd: The file handle.
> + * @offset: Start of the buffer (from memfd start).
> + * Must be page aligned.
> + * @size: Size of the buffer.  Must be rounded to page size.
> + *
> + * @flags:
> + * UDMABUF_FLAGS_CLOEXEC: set CLOEXEC flag for the dmabuf.
> + */
>  struct udmabuf_create {
>  	__u32 memfd;
>  	__u32 flags;
> @@ -14,6 +45,14 @@ struct udmabuf_create {
>  	__u64 size;
>  };
>  
> +/**
> + * struct udmabuf_create_item - one memory block list item.
> + *
> + * @memfd: The file handle.
> + * @offset: Start of the buffer (from memfd start).
> + * Must be page aligned.
> + * @size: Size of the buffer.  Must be rounded to page size.
> + */
>  struct udmabuf_create_item {
>  	__u32 memfd;
>  	__u32 __pad;
> @@ -21,13 +60,19 @@ struct udmabuf_create_item {
>  	__u64 size;
>  };
>  
> +/**
> + * struct udmabuf_create_list - create a dmabuf from a memory block list.
> + *
> + * @count: The number of list elements.
> + * @list: The memory block list
> + *
> + * flags:

      @flags:

> + * UDMABUF_FLAGS_CLOEXEC: set CLOEXEC flag for the dmabuf.
> + */
>  struct udmabuf_create_list {
>  	__u32 flags;
>  	__u32 count;
>  	struct udmabuf_create_item list[];
>  };

-- 
~Randy
