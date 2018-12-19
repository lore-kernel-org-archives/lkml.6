Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C4AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4ADD217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbeLSSJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 13:09:35 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43105 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbeLSSJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 13:09:35 -0500
Received: by mail-qt1-f195.google.com with SMTP id i7so23223366qtj.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 10:09:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AYOh6AB59enqLCfQd8iQuBNnmtxcKdqnkLZZeFmbmzA=;
        b=QNoUEjJH57VmhG/9MbQWZ79RmCQYKN0nnWrtJfiz8A3aVZ1kGeddBX4w1EF7TfuTxI
         64rr2/CwL1aT7n/biztlNpN+ckCM7e/X6ewTVHvFG9Gg3vqwMWTjfIyS7SxrkuV7tJyp
         lrTkQipiy1RIpzcddAX1xFBinBY2wEsB011qOQdQv4OIxHgr5rPPPQsNbRVgPonAB4Q0
         e5JDB0e8ml66qpS8N6tFH8bmuBbkFXfF/B6javhkgLReqxaG2MO+y2ZZbjZNfykICeWM
         /gW1xykOw4GI5rSMftaHPJPWXN86TeP9hWOlMV/9v2gm8qxuIUpzTv0ImjZ/50vDP5zb
         HkuA==
X-Gm-Message-State: AA+aEWZQOcwOpPUJ2x5uPRJ/SPP4OqgB+Dh7dhqZrQJpkhadiQEvNpA5
        b9AjGYFH67pgpaCLQNpIP49JqZVY2ks=
X-Google-Smtp-Source: AFSGD/Upl33htwcO9FgRAEmdg9qPCa61/JfS14T8d7v3q3Tx79HuQqgYLUyph3M3H9i2HX2qO8OjEQ==
X-Received: by 2002:a0c:e010:: with SMTP id j16mr22506405qvk.111.1545242973644;
        Wed, 19 Dec 2018 10:09:33 -0800 (PST)
Received: from ?IPv6:2601:602:9802:a8dc::c5f1? ([2601:602:9802:a8dc::c5f1])
        by smtp.gmail.com with ESMTPSA id f2sm2960513qkh.20.2018.12.19.10.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 10:09:32 -0800 (PST)
Subject: Re: [PATCH] staging: android: ion: add buffer flag update ioctl
To:     Zeng Tao <prime.zeng@hisilicon.com>, sumit.semwal@linaro.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <1545239943-15414-1-git-send-email-prime.zeng@hisilicon.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <b0cc8d05-b313-9433-4e48-d0d39aa1858b@redhat.com>
Date:   Wed, 19 Dec 2018 10:09:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1545239943-15414-1-git-send-email-prime.zeng@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/18 9:19 AM, Zeng Tao wrote:
> In some usecases, the buffer cached attribute is not determined at
> allocation time, it's determined just before the real cpu mapping.
> And from the memory view of point, a buffer should not have the cached
> attribute util is really mapped by the cpu. So in this patch, we
> introduced the new ioctl command to target the requirement.
> 

This is racy and error prone. Can you explain more what
problem you are trying to solve?

> Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
> ---
>   drivers/staging/android/ion/ion-ioctl.c |  4 ++++
>   drivers/staging/android/ion/ion.c       | 17 +++++++++++++++++
>   drivers/staging/android/ion/ion.h       |  1 +
>   drivers/staging/android/uapi/ion.h      | 22 ++++++++++++++++++++++
>   4 files changed, 44 insertions(+)
> 
> diff --git a/drivers/staging/android/ion/ion-ioctl.c b/drivers/staging/android/ion/ion-ioctl.c
> index a8d3cc4..60bb702 100644
> --- a/drivers/staging/android/ion/ion-ioctl.c
> +++ b/drivers/staging/android/ion/ion-ioctl.c
> @@ -12,6 +12,7 @@
>   
>   union ion_ioctl_arg {
>   	struct ion_allocation_data allocation;
> +	struct ion_buffer_flag_data update;
>   	struct ion_heap_query query;
>   };
>   
> @@ -83,6 +84,9 @@ long ion_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>   
>   		break;
>   	}
> +	case ION_IOC_BUFFER_UPDATE:
> +		ret = ion_buffer_update(data.update.fd, data.update.flags);
> +		break;
>   	case ION_IOC_HEAP_QUERY:
>   		ret = ion_query_heaps(&data.query);
>   		break;
> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> index 9907332..f1404dc 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -436,6 +436,23 @@ int ion_alloc(size_t len, unsigned int heap_id_mask, unsigned int flags)
>   	return fd;
>   }
>   
> +int ion_buffer_update(unsigned int fd, unsigned int flags)
> +{
> +	struct dma_buf *dmabuf;
> +	struct ion_buffer *buffer;
> +
> +	dmabuf = dma_buf_get(fd);
> +
> +	if (!dmabuf)
> +		return -EINVAL;
> +
> +	buffer = dmabuf->priv;
> +	buffer->flags = flags;
> +	dma_buf_put(dmabuf);
> +
> +	return 0;
> +}
> +
>   int ion_query_heaps(struct ion_heap_query *query)
>   {
>   	struct ion_device *dev = internal_dev;
> diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
> index c006fc1..99bf9ab 100644
> --- a/drivers/staging/android/ion/ion.h
> +++ b/drivers/staging/android/ion/ion.h
> @@ -199,6 +199,7 @@ int ion_heap_pages_zero(struct page *page, size_t size, pgprot_t pgprot);
>   int ion_alloc(size_t len,
>   	      unsigned int heap_id_mask,
>   	      unsigned int flags);
> +int ion_buffer_update(unsigned int fd, unsigned int flags);
>   
>   /**
>    * ion_heap_init_shrinker
> diff --git a/drivers/staging/android/uapi/ion.h b/drivers/staging/android/uapi/ion.h
> index 5d70098..99753fc 100644
> --- a/drivers/staging/android/uapi/ion.h
> +++ b/drivers/staging/android/uapi/ion.h
> @@ -74,6 +74,20 @@ struct ion_allocation_data {
>   	__u32 unused;
>   };
>   
> +/**
> + * struct ion_buffer_flag_data - metadata passed from userspace for update
> + * buffer flags
> + * @fd:			file descriptor of the buffer
> + * @flags:		flags passed to the buffer
> + *
> + * Provided by userspace as an argument to the ioctl
> + */
> +
> +struct ion_buffer_flag_data {
> +	__u32 fd;
> +	__u32 flags;
> +}
> +
>   #define MAX_HEAP_NAME			32
>   
>   /**
> @@ -116,6 +130,14 @@ struct ion_heap_query {
>   				      struct ion_allocation_data)
>   
>   /**
> + * DOC: ION_IOC_BUFFER_UPDATE - update the specified ion buffer flags
> + *
> + * Takes an ion_buffer_flag_data structure and returns the result of the
> + * buffer flag update operation.
> + */
> +#define ION_IOC_BUFFER_UPDATE	_IOWR(ION_IOC_MAGIC, 1, \
> +				      struct ion_buffer_flag_data)
> +/**
>    * DOC: ION_IOC_HEAP_QUERY - information about available heaps
>    *
>    * Takes an ion_heap_query structure and populates information about
> 

