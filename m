Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB7BC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC5C20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lMenHu3t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC5C20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbeIKUkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:40:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34322 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbeIKUkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/WrK8WaLuQ+Pr5ivwkLZduRbTVOex06t6GKmaIySDCM=; b=lMenHu3tXjJsUoSZt97lMwqcX
        IOPtHY52RwhgT8Y7ew7di3fbFhGZ+mw6e4G5qF+s8DQvvYCmc2Gcd+YsqgtNQNnOcfSo6DLaGmHtH
        b9DnBSSCppymDWKlB7PFgaSbvBFBSJxIo68it3rhFLUviT4Uvv1jonAQSLXilT+kmZYAnym/6jZiL
        b3Y3/xTP6pm+IOoW6Ku7QMFCNIkXDRhYQeOGT4Yl0nZ+3clPhWiKkd4NN3zPxiaNJ04cqSE4BqssE
        JlaFLKIlXvLzK41g4bwLH7Scgrnei1cgIwaUxoH/mAoFlKflznoBXXTPw+ZgveT3iEiPS5ArnSNbS
        /OmDl84IA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzkmB-0001pn-Kq; Tue, 11 Sep 2018 15:40:27 +0000
Subject: Re: [PATCH v2 13/13] udmabuf: add documentation
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
References: <20180911134216.9760-1-kraxel@redhat.com>
 <20180911134216.9760-14-kraxel@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ae4524da-abdb-e5b5-7658-3a0e9a6a071e@infradead.org>
Date:   Tue, 11 Sep 2018 08:40:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180911134216.9760-14-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/18 6:42 AM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/uapi/linux/udmabuf.h         | 50 +++++++++++++++++++++++++++++++++---
>  Documentation/driver-api/dma-buf.rst |  8 ++++++
>  2 files changed, 55 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/udmabuf.h b/include/uapi/linux/udmabuf.h
> index 46b6532ed8..f30b37cb5c 100644
> --- a/include/uapi/linux/udmabuf.h
> +++ b/include/uapi/linux/udmabuf.h
> @@ -5,8 +5,38 @@
>  #include <linux/types.h>
>  #include <linux/ioctl.h>
>  
> +/**
> + * DOC: udmabuf
> + *
> + * udmabuf is a device driver which allows userspace create dmabufs.

                                                        to create

> + * The memory used for these dmabufs must be backed by memfd.  The
> + * memfd must have F_SEAL_SHRINK and it must not have F_SEAL_WRITE.
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

      @flags: ???

> + *
> + * flags:
> + * UDMABUF_FLAGS_CLOEXEC: set CLOEXEC flag for the dmabuf.
> + */
>  struct udmabuf_create {
>  	__u32 memfd;
>  	__u32 flags;
> @@ -14,6 +44,14 @@ struct udmabuf_create {
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
> @@ -21,13 +59,19 @@ struct udmabuf_create_item {
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


thanks.
-- 
~Randy
