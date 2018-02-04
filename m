Return-Path: <kernel-hardening-return-11581-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226CvCbbf0M1+CrtG5h/Wxju/sSlf2fJiQXWWavfDJnq15EyFX0ue1+v1hpXdXqJZJLRRU6w
ARC-Seal: i=1; a=rsa-sha256; t=1517780267; cv=none;
        d=google.com; s=arc-20160816;
        b=m/aH3GEGH/T2FtB7N5kvJJaq7hmkvaIVPgDwSjiaX/X2uysvXhnaRPPYIWFKqqvXwe
         vOmqYImfgyDiKHAdHLGyQ3HrR/p2tfTrjZJ3xQctkC6x13PHbW7pTWVXUik/pSzF0hMT
         9Lc3gdok04PniF7lxEpbU1GrfdAcp0VHgh7KXOAgyiiYXgiqHz2ED6SgkvT1LSdGdYqf
         hG+RT90OfdOkgieO7h26hLraUdmE8/pOubdFi5fK4rOyjIoouIi5Xcyt9G+Q4pV2zfmg
         6azGBG+oRwAea7w6aC7Ob4TPsZmDAJBbDyFnTAWVnR7FRZIiv8F8SsinqcZjt/Q+qZ2N
         ax8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=yiFwBoLU4nwXC36w4aJHUV8qK4S4p7iyG9KoNz0LeN8=;
        b=zIDR4a+mI4iAvMw7rerX8B8lPXUf9QfGsJMSZxKTTPCPFNhKEEkke683EDmT85ca25
         au8N2rBK+X/gXDFFavsYm/PwUJnxH5Idq9pESI9gItj+NxFrrNzOerLxUMX2DWldrWP/
         ZgRwTtGv61jTFw0DVtuJsQRTFX6nAWjqSCizFC3ongE0yCKNvR0zWoWKviwEZcdb/2Ll
         xdMD2a27PS716PBohkeBJlrGjQs8Z3Ebm08i3oHmBDcdH1tqy5a1lIOHzYeFmIeb9hvC
         hYmSdpLD7jZft3SWu3KdL4mISGU+ZzWs9DItD0KgGMSARQtJ7byDfUqlC6mqX/e2vgF4
         bw+g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=eQa3SYWS;
       spf=pass (google.com: domain of kernel-hardening-return-11581-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11581-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=eQa3SYWS;
       spf=pass (google.com: domain of kernel-hardening-return-11581-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11581-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 6/6] Documentation for Pmalloc
To: Igor Stoppa <igor.stoppa@huawei.com>, jglisse@redhat.com,
 keescook@chromium.org, mhocko@kernel.org, labbott@redhat.com,
 hch@infradead.org, willy@infradead.org
Cc: cl@linux.com, linux-security-module@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
References: <20180204164732.28241-1-igor.stoppa@huawei.com>
 <20180204170056.28772-1-igor.stoppa@huawei.com>
 <20180204170056.28772-2-igor.stoppa@huawei.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <29176ee0-f253-ccd7-8201-3f061b5890b0@infradead.org>
Date: Sun, 4 Feb 2018 13:37:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180204170056.28772-2-igor.stoppa@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591490610128424562?=
X-GMAIL-MSGID: =?utf-8?q?1591507961320847673?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 02/04/2018 09:00 AM, Igor Stoppa wrote:
> Detailed documentation about the protectable memory allocator.
> 
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> ---
>  Documentation/core-api/index.rst   |   1 +
>  Documentation/core-api/pmalloc.rst | 114 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 115 insertions(+)
>  create mode 100644 Documentation/core-api/pmalloc.rst
> 
> diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
> index d5bbe035316d..7244ddeb540f 100644
> --- a/Documentation/core-api/index.rst
> +++ b/Documentation/core-api/index.rst
> @@ -21,6 +21,7 @@ Core utilities
>     flexible-arrays
>     librs
>     genalloc
> +   pmalloc
>  
>  Interfaces for kernel debugging
>  ===============================
> diff --git a/Documentation/core-api/pmalloc.rst b/Documentation/core-api/pmalloc.rst
> new file mode 100644
> index 000000000000..8dabb5e18d8f
> --- /dev/null
> +++ b/Documentation/core-api/pmalloc.rst
> @@ -0,0 +1,114 @@
> +SPDX-License-Identifier: GPL-2.0
> +
> +Protectable memory allocator
> +============================
> +
> +Purpose
> +-------
> +
> +The pmalloc library is meant to provide R/O status to data that, for some
> +reason, could neither be declared as constant, nor it could take advantage

                                                  nor could it

> +of the qualifier __ro_after_init, but is write-once and read-only in spirit.
> +It protects data from both accidental and malicious overwrites.
> +
> +Ex: A policy that is loaded from userspace.

Either
   Example:
or
   E.g.:
(meaning For example)

> +
> +
> +Concept
> +-------
> +
> +pmalloc builds on top of genalloc, using the same concept of memory pools.
> +
> +The value added by pmalloc is that now the memory contained in a pool can
> +become R/O, for the rest of the life of the pool.
> +
> +Different kernel idrivers and threads can use different pools, for finer

                    drivers

> +control of what becomes R/O and when. And for improved lockless concurrency.
> +
> +
> +Caveats
> +-------
> +
> +- Memory freed while a pool is not yet protected will be reused.
> +
> +- Once a pool is protected, it's not possible to allocate any more memory
> +  from it.
> +
> +- Memory "freed" from a protected pool indicates that such memory is not
> +  in use anymore by the requestor, however it will not become avaiable for

                           requester; however,                   available


> +  further use, until the pool is destroyed.
> +
> +- Before destroying a pool, all the memory allocated from it must be
> +  released.
> +
> +- pmalloc does not provide locking support wrt allocating vs protecting

Write out "wrt" -> with respect to.

> +  an individual pool, for performance reason. It is recommended to not

                                         reasons.                  not to

> +  share the same pool between unrelated functions. Should sharing be a
> +  necessity, the user of the shared pool is expected to implement locking
> +  for that pool.
> +
> +- pmalloc uses genalloc to optimize the use of the space it allocates
> +  through vmalloc. Some more TLB entries will be used, however less than
> +  in the case of using directly vmalloc. The exact number depends on size

                 of using vmalloc directly.                          on the size

> +  of each allocation request and possible slack.
> +
> +- Considering that not much data is supposed to be dynamically allocated
> +  and then marked as read-only, it shouldn't be an issue that the address
> +  range for pmalloc is limited, on 32-bit systems.
> +
> +- Regarding SMP systems, the allocations are expected to happen mostly
> +  during an initial transient, after which there should be no more need to
> +  perform cross-processor synchronizations of page tables.
> +
> +- To facilitate the conversion of existing code to pmalloc pools, several
> +  helper functions are provided, mirroring their kmalloc counterparts.
> +
> +
> +Use
> +---
> +
> +The typical sequence, when using pmalloc, is:
> +
> +1. create a pool
> +
> +.. kernel-doc:: include/linux/pmalloc.h
> +   :functions: pmalloc_create_pool
> +
> +2. [optional] pre-allocate some memory in the pool
> +
> +.. kernel-doc:: include/linux/pmalloc.h
> +   :functions: pmalloc_prealloc
> +
> +3. issue one or more allocation requests to the pool with locking as needed
> +
> +.. kernel-doc:: include/linux/pmalloc.h
> +   :functions: pmalloc
> +
> +.. kernel-doc:: include/linux/pmalloc.h
> +   :functions: pzalloc
> +
> +4. initialize the memory obtained with desired values
> +
> +5. [optional] iterate over points 3 & 4 as needed
> +
> +6. write protect the pool

      write-protect

> +
> +.. kernel-doc:: include/linux/pmalloc.h
> +   :functions: pmalloc_protect_pool
> +
> +7. use in read-only mode the handlers obtained through the allocations

                                handles ??

> +
> +8. [optional] release all the memory allocated
> +
> +.. kernel-doc:: include/linux/pmalloc.h
> +   :functions: pfree
> +
> +9. [optional, but depends on point 8] destroy the pool
> +
> +.. kernel-doc:: include/linux/pmalloc.h
> +   :functions: pmalloc_destroy_pool
> +
> +API
> +---
> +
> +.. kernel-doc:: include/linux/pmalloc.h
> 


-- 
~Randy
