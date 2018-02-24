Return-Path: <kernel-hardening-return-11939-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvv/uX1SQEOQZbFwT20xsx0ETbPwii2AGGfOuM4oga2Jtqjajg00zSBVJQcILEA9rnKGvcz
ARC-Seal: i=1; a=rsa-sha256; t=1519432035; cv=none;
        d=google.com; s=arc-20160816;
        b=Vc/dLBF1rEHUIbriP3lXPUzL06s14XxOrcfmtEXk4ADgQN0/8jKad35JGWWAuLAiKl
         xMp5UK7RCt1bxJLEnUGwRsDLpkOAlv1KpW4YHqpsCj3v0ftpBpnTxzh8ilj9pmJpJjlw
         8O0BywfwGHbQqxBAJNnCzuAOqDYcfi679d/UKtGmSJ7MkCbVyvU+2WvCNMulV9f3Iohm
         wGIlSpUdHOgKAk/K4Dgk97W8EnQaodSosPFm+x4/2IXRNPSKZFRUVpPznX6wYdx8VklB
         0wYkeSfWsmOmV1IPnuUCa0H8jlHMEh+Pbt3qIv3sCRHZJ11u6X9uYBvh9uFwIKscPaLs
         Zgyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=YU6kOwtmVTUEQsFClZIHmbubeScXoLNXuYRl0AzORlQ=;
        b=VjCJfGy/5nm3WDvVSZmnhXJiRyaZ9xGrtj+XaQJO4Qicy5Vrbzyk4EqGYk+l9PvB/c
         H2g6N/MOP3V0o+XCkG37CAeqTXVgncW47WmE8hEE4qs+OtkY98MM0O0sUK/WLtUt2SCp
         8kQ6WEC743BTD22tXdrUdGS7pKUCZtg0gQ3qrT/Y72EmpqhXJtlO4MjJv2O9GT3uc3sI
         AbsP6Q/7v3jdctKQ86nPjmXv8HDUCxexyvAAJ46KK0kuMfQNGxQmSHAgAVU3Qa6yx6By
         gJtjtQe9pcIKWm0FKNtZyjzxP+B84y3i6ndaTW7scw6J2Ej8QuudXp+/kROm/oBPi4L8
         8RFg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pTL3dhDg;
       spf=pass (google.com: domain of kernel-hardening-return-11939-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11939-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pTL3dhDg;
       spf=pass (google.com: domain of kernel-hardening-return-11939-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11939-gregkh=linuxfoundation.org@lists.openwall.com;
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
References: <20180223144807.1180-1-igor.stoppa@huawei.com>
 <20180223144807.1180-8-igor.stoppa@huawei.com>
From: J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <98b2fecf-c1b3-aa5e-ba70-2770940bb965@gmail.com>
Date: Fri, 23 Feb 2018 16:26:49 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180223144807.1180-8-igor.stoppa@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593203869384416371?=
X-GMAIL-MSGID: =?utf-8?q?1593239965833712415?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 2/23/18 6:48 AM, Igor Stoppa wrote:
> Detailed documentation about the protectable memory allocator.
>
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> ---
>   Documentation/core-api/index.rst   |   1 +
>   Documentation/core-api/pmalloc.rst | 114 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 115 insertions(+)
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
> index 000000000000..d9725870444e
> --- /dev/null
> +++ b/Documentation/core-api/pmalloc.rst
> @@ -0,0 +1,114 @@
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
> +- Before destroying a pool, all the memory allocated from it must be
> +  released.

Is that true?  pmalloc_destroy_pool() has:

.
.
+    pmalloc_pool_set_protection(pool, false);
+    gen_pool_for_each_chunk(pool, pmalloc_chunk_free, NULL);
+    gen_pool_destroy(pool);
+    kfree(data);

which to me looks like is the opposite, the data (ie, "memory") is being 
released first, then the pool is destroyed.



> +
> +- pmalloc does not provide locking support with respect to allocating vs
> +  protecting an individual pool, for performance reasons.

What is the recommendation to using locks then, as the computing 
real-world mainly operates in multi-threaded/process world?  Maybe show 
an example of an issue that occur if locks aren't used and give a coding 
example.

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

Why is 32-bit systems mentioned and not 64-bit?  Is there a problem with 
64-bit here?

Thanks,
Jay
