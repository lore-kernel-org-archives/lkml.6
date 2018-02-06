Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2459548-1517960891-2-16261819113105656892
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517960890; b=d/j/0A0M56zcLAmL6GKoUQ9CSNNNpZ/bwiatnXVKWPlF1R4
    5rGuR0iFaVR43d2cr+Qr1oGRlexQZJFptvSCJY6gF+Mg8dsyyoGwNFCb85KpkAQb
    ZfsD0EgsFXasPRUFBWSgbZQJvrd/iPywi93ptfG0WeA3IukskMzaM3MLcsPSWkzW
    Rw7qbp5DwYvpf+TrwYzSNN7hjUtEg6xyAeC5HybihgMpggJeUbbiCNTOjxoc095E
    4n7ntIgqTx3kns9vkfSZC3wkXAGZZ5cA6JYB/v3pIdhae+cpQGZ3DAfHnc2ugtoG
    DfuaQcEA4TnzNGZK7vFCpzrs+HlK48mKRuZ9iEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1517960890; bh=YlwxQgD5+D5G0ExL1O6i0XtPzpSMCCbxwpeBxcNthfs=; b=e
    LnYNLlwnAOkuaKZio9Ovkx6xsbJF8qjUmGSXEK50KBKglitboV97xkQE9VAQCldf
    W3qjJsWNWBJ4tyP0WUg7Sp934Zf9waBaarUGurJ0xf2KQr9xqTXAuwx4Kocrl92A
    xNe+1/fxjfZ06bYFVwgBhFGEJPxHAW+skl0QNYBvBXQ7PSgUY8yD1oTTNQtQMoZK
    SKYh/rywWb/+Fz7TD6302cxArDLbwWJF6sM3qDvBHJ17eqff/4eGYbWkGxvQN/tW
    pLm/cPCBo+qk5sUdiXnTHqcpfqkEAIr61KcK7w0C+jqGVAuGZBwHIlaBgOXWvlt+
    zJFNaQsMhk+iZW4XUPzCA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SXBCskiu;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SXBCskiu;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x2249Cmwr8itLeRKXwuIPoREY81QwFuUsa03qvrajBRkoUlEJ8j6unIRnjUtqPqpGGJ56kUPUxQ==
Subject: Re: staging: ion: ION allocation fall back order depends on heap
 linkage order
To: Alexey Skidanov <alexey.skidanov@gmail.com>, devel@driverdev.osuosl.org
References: <CAM7Y4U8FmTNrn=BYN-J+_hVz7JTuaiV+y5Bao78wj3vYCPrz+w@mail.gmail.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <58951af2-a84e-7d7c-e956-ece3190aa8c2@redhat.com>
Date: Tue, 6 Feb 2018 15:48:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAM7Y4U8FmTNrn=BYN-J+_hVz7JTuaiV+y5Bao78wj3vYCPrz+w@mail.gmail.com>
Content-Language: en-US
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 01/28/2018 08:24 AM, Alexey Skidanov wrote:
> Hi,
> 
> According to my understanding, the allocation fall back order
> completely depends on heap->id that is assigned during the heap
> creation:
>     plist_for_each_entry(heap, &dev->heaps, node) {
>          /* if the caller didn't specify this heap id */
>          if (!((1 << heap->id) & heap_id_mask))
>              continue;
>          buffer = ion_buffer_create(heap, dev, len, flags);
>          if (!IS_ERR(buffer))
>              break;
>      }
> 
> On creation, each heap is added to the priority list according to the
> priority assigned:
> 
> ...
> static int heap_id;
> ...
> void ion_device_add_heap(struct ion_heap *heap)
> {
>          ...
>          heap->id = heap_id++;
>          ...
> }
> 
> 
> The order of creation is the order of linkage defined in the Makefile.
> Thus, by default, we have:
> 
> heap id 2, type ION_HEAP_TYPE_DMA
> heap id 1, type ION_HEAP_TYPE_SYSTEM
> heap id 0, type ION_HEAP_TYPE_SYSTEM_CONTIG
> 
> Changing the linkage order:
> diff --git a/drivers/staging/android/ion/Makefile
> b/drivers/staging/android/ion/Makefile
> index bb30bf8..e05052c 100644
> --- a/drivers/staging/android/ion/Makefile
> +++ b/drivers/staging/android/ion/Makefile
> @@ -1,6 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_ION) +=   ion.o ion-ioctl.o ion_heap.o
> -obj-$(CONFIG_ION_SYSTEM_HEAP) += ion_system_heap.o ion_page_pool.o
>   obj-$(CONFIG_ION_CARVEOUT_HEAP) += ion_carveout_heap.o
>   obj-$(CONFIG_ION_CHUNK_HEAP) += ion_chunk_heap.o
>   obj-$(CONFIG_ION_CMA_HEAP) += ion_cma_heap.o
> +obj-$(CONFIG_ION_SYSTEM_HEAP) += ion_system_heap.o ion_page_pool.o
> 
> I get the following order:
> 
> heap id 2, type ION_HEAP_TYPE_SYSTEM
> heap id 1, type ION_HEAP_TYPE_SYSTEM_CONTIG
> heap id 0, type ION_HEAP_TYPE_DMA
> 
> So, if the user specifies more than 1 heap in the heap_id_mask during
> allocation, the allocation fall back order completely depends on the
> order of linkage. Probably, it's better to let the user to define the
> fall back order (and NOT to be dependent on the linkage order at all)
> ?
> 

Yup, you've hit upon a key problem. Having fallbacks be stable
was always a problem and the recommendation these days is to
not rely on them. You can specify a heap at a time and fallback
manually if you want that behavior.

If you have a proposal to make fallbacks work reliably without
overly complicating the ABI I'm happy to review it.

Thanks,
Laura

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
