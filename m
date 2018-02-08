Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbeBHD1D (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 22:27:03 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750767AbeBHD1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 22:27:01 -0500
Subject: Re: [PATCH net V2 1/2] ptr_ring: try vmalloc() when kmalloc() fails
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <1518060101-19071-1-git-send-email-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <73b17c4f-7deb-f764-be1c-ab6f3c502d41@redhat.com>
Date: Thu, 8 Feb 2018 11:26:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1518060101-19071-1-git-send-email-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年02月08日 11:21, Jason Wang wrote:
> This patch switch to use kvmalloc_array() for using a vmalloc()
> fallback to help in case kmalloc() fails.
>
> Reported-by: syzbot+e4d4f9ddd4295539735d@syzkaller.appspotmail.com
> Fixes: 2e0ab8ca83c12 ("ptr_ring: array based FIFO for pointers")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>   include/linux/ptr_ring.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index 1883d61..9c3b748 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -466,7 +466,7 @@ static inline int ptr_ring_consume_batched_bh(struct ptr_ring *r,
>   
>   static inline void **__ptr_ring_init_queue_alloc(unsigned int size, gfp_t gfp)
>   {
> -	return kcalloc(size, sizeof(void *), gfp);
> +	return kvmalloc_array(size, sizeof(void *), gfp | __GFP_ZERO);
>   }
>   
>   static inline void __ptr_ring_set_size(struct ptr_ring *r, int size)

Forget the kvfree() ...

Will post V3.

Sorry.
