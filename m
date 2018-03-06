Return-Path: <kernel-hardening-return-12155-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuWsCfOGaEohy963g/lUM3Omh0kblD/ykXvy85UlkwgXs0s8VDUmTBFVjPFbUEuAHQW3hb9
ARC-Seal: i=1; a=rsa-sha256; t=1520357648; cv=none;
        d=google.com; s=arc-20160816;
        b=xSHa2zQt1kb8aGpv7Inv+uq+d1pB9VppkhpaW5Z08Ej1bv4RVK/+l4dBUotUHnFzm0
         C4GCrnci8ZTn8Eh0iXzpZu44X3RYBgzv4nd0hDbw7fpDwyCt/UCNBKs24RV0d/UydWxY
         PwR71F4sw7uImGlBOuQYbbCydXAkBO4LIDt81/I6MV6qEkGswm0Pk0NpU8NWyKeeEWng
         X31ixI+n/hPzacIHDloXuK3eP+eoKeD/0gPlVvBhJrOBpTLy+a4oJ5j+GkEUNZcaBJpt
         GwXPHSbPzOPTAjJm7TLsbO4pv/Qxz9Wt/aCeLDMEa3om1CHqaHt0OYTum2kbfBySB/BS
         KGrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=2sK0x8Jc+jGtj94hk6mffXo/isYJpY3lLDBdXPKdRqw=;
        b=hnWtaX56QFWYT7uEG9M+25an0QlEzKDe1MvsvU2SUsxf+CkEWfSLQyeblMTUDZGo0B
         MDVTY3KcW4F8Xtiys2o3n/z3xQ/HAakPNQAltpYVYHT1QEB0eC3Dj0XnqUv1ug/Y+eFL
         tE9gSDt5cAN1Dtv6udToPfVGUOONbQCGuzoeWq0HzY/kYAsOMQcMECD39kagBAAiXSVR
         rWyJfmTO9wtUu/pKHEsoys0TFwz3apoGH9eRo0rlj3qDIV7kACQ6D7CXXqJHFLGai6h3
         chSWExiGJdsWcYFHeU26F9WFB8D9BnkMEPfpiVE+RfAHLh3BLHuD1m5GkIbN6M8pv4+n
         65lw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RP0BLKvp;
       spf=pass (google.com: domain of kernel-hardening-return-12155-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12155-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RP0BLKvp;
       spf=pass (google.com: domain of kernel-hardening-return-12155-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12155-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 7/7] Documentation for Pmalloc
To: Igor Stoppa <igor.stoppa@huawei.com>, david@fromorbit.com,
 willy@infradead.org, keescook@chromium.org, mhocko@kernel.org
Cc: labbott@redhat.com, linux-security-module@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com
References: <20180228200620.30026-1-igor.stoppa@huawei.com>
 <20180228200620.30026-8-igor.stoppa@huawei.com>
From: J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <226151f3-bec6-e6f7-d7b7-7ad0c391865b@gmail.com>
Date: Tue, 6 Mar 2018 09:33:44 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228200620.30026-8-igor.stoppa@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676894350547582?=
X-GMAIL-MSGID: =?utf-8?q?1594210542449932161?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Minus the comment-fixes Mike Rapoport mentioned, looks good:

Reviewed-by: Jay Freyensee <why2jjj.linux@gmail.com>


On 2/28/18 12:06 PM, Igor Stoppa wrote:
> Detailed documentation about the protectable memory allocator.
>
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> ---
>   Documentation/core-api/index.rst   |   1 +
>   Documentation/core-api/pmalloc.rst | 111 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 112 insertions(+)
>   create mode 100644 Documentation/core-api/pmalloc.rst
>
> diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
> index c670a8031786..8f5de42d6571 100644
> --- a/Documentation/core-api/index.rst
> +++ b/Documentation/core-api/index.rst
> @@ -25,6 +25,7 @@ Core utilities
>      genalloc
>      errseq
>      printk-formats
> +   pmalloc
>   
>   Interfaces for kernel debugging
>   ===============================
> diff --git a/Documentation/core-api/pmalloc.rst b/Documentation/core-api/pmalloc.rst
> new file mode 100644
> index 000000000000..8fb9c9d3171b
> --- /dev/null
> +++ b/Documentation/core-api/pmalloc.rst
> @@ -0,0 +1,111 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Protectable memory allocator
> +============================
> +
> +Purpose
> +-------
> +
> +The pmalloc library is meant to provide R/O status to data that, for some
> +reason, could neither be declared as constant, nor could it take advantage
> +of the qualifier __ro_after_init, but is write-once and read-only in spirit.
> +It protects data from both accidental and malicious overwrites.
> +
> +Example: A policy that is loaded from userspace.
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
> +Different kernel drivers and threads can use different pools, for finer
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
> +  in use anymore by the requester; however, it will not become available
> +  for further use, until the pool is destroyed.
> +
> +- pmalloc does not provide locking support with respect to allocating vs
> +  protecting an individual pool, for performance reasons.
> +  It is recommended not to share the same pool between unrelated functions.
> +  Should sharing be a necessity, the user of the shared pool is expected
> +  to implement locking for that pool.
> +
> +- pmalloc uses genalloc to optimize the use of the space it allocates
> +  through vmalloc. Some more TLB entries will be used, however less than
> +  in the case of using vmalloc directly. The exact number depends on the
> +  size of each allocation request and possible slack.
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
> +6. write-protect the pool
> +
> +.. kernel-doc:: include/linux/pmalloc.h
> +   :functions: pmalloc_protect_pool
> +
> +7. use in read-only mode the handles obtained through the allocations
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
