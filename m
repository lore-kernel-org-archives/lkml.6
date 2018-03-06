Return-Path: <kernel-hardening-return-12141-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuUowQLyCR1zNkinnefrHfx0ySWsM20qR7B9QIAKLjukAN9rvgVkQ0zP3CIzWvXMCeI5DMT
ARC-Seal: i=1; a=rsa-sha256; t=1520343087; cv=none;
        d=google.com; s=arc-20160816;
        b=Bwgdpc6C8ysh/+AQD3MJuW0zYS0jr1cIAuzCVJb/BSEzCmHouuVBlehUNbVvIRIkbP
         cAzVdEGAFlzEVehMiu/UrBYK8cAQUoTc4WNL2vmyQg162kvds7WpNe4wCnlorEOhHTwa
         KNmcN7hTB5cTMbtdh4Ni91ZTRXwQGFRW7hGuMbZ7wl30I6WY1YpV+WljVVygFSd6OHl+
         p0AKK7eHIQFOimPE9XXxHCjGnkR00Fia3Y33+XZTcKufSjIGVCUQmknANylVLPtw7+Fp
         jJlp4Ni2/Ifs3U/lNRHYOFmM2C8WbVbqbjmKv7E/6RmSK419yWP/HveXAHEfgkVb1V8+
         O9fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:user-agent:in-reply-to:content-disposition:mime-version
         :references:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=kVGMyYpMLbafkRB2EfAxf6S8YDBVZQKlj2Qx/44Qx8I=;
        b=t5kJB7/HsT0toMri0UG+iqvMaoCnxCOH5uEQPlxuVBAq7Qj6yyKdFVbD0K7NA6qWbL
         wtBAlSNYcNM395pdaka0NqPNiGHmsCStiRSlrwQcAJZt56A5IMv/7MaqYI5FLrPBhXXi
         oWyFH7yWfC9pX+bupSMaBfGHBhiVsXGd4xUjpiPZB6p0HlTWjsI1eoDU08Z4UDYImp3r
         m4QRLTE6t2DpZEAidjJMBk+Kv/qD0eDhTEZiNCqSC1z96kmiJPDFNkA/6bKO4MTVzm5w
         2AYrbXMqi81UkH3w/L7X8UVXwOScpsA6K0P8FknFOnguKEQPcYNf2IP8HetBZV+aojDg
         cl6g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12141-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12141-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12141-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12141-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 6 Mar 2018 14:30:52 +0100
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: david@fromorbit.com, willy@infradead.org, keescook@chromium.org,
        mhocko@kernel.org, labbott@redhat.com,
        linux-security-module@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 7/7] Documentation for Pmalloc
References: <20180228200620.30026-1-igor.stoppa@huawei.com>
 <20180228200620.30026-8-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228200620.30026-8-igor.stoppa@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18030613-0008-0000-0000-000004D87037
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030613-0009-0000-0000-00001E6B8703
Message-Id: <20180306133051.GE19349@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-06_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803060153
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676894350547582?=
X-GMAIL-MSGID: =?utf-8?q?1594195273065375207?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 10:06:20PM +0200, Igor Stoppa wrote:
> Detailed documentation about the protectable memory allocator.
> 
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> ---
>  Documentation/core-api/index.rst   |   1 +
>  Documentation/core-api/pmalloc.rst | 111 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 112 insertions(+)
>  create mode 100644 Documentation/core-api/pmalloc.rst
> 
> diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
> index c670a8031786..8f5de42d6571 100644
> --- a/Documentation/core-api/index.rst
> +++ b/Documentation/core-api/index.rst
> @@ -25,6 +25,7 @@ Core utilities
>     genalloc
>     errseq
>     printk-formats
> +   pmalloc
> 
>  Interfaces for kernel debugging
>  ===============================
> diff --git a/Documentation/core-api/pmalloc.rst b/Documentation/core-api/pmalloc.rst
> new file mode 100644
> index 000000000000..8fb9c9d3171b
> --- /dev/null
> +++ b/Documentation/core-api/pmalloc.rst
> @@ -0,0 +1,111 @@
> +.. SPDX-License-Identifier: GPL-2.0

Please add a label to allow cross-referencing

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

It would be nice to add a label to genalloc.rst and reference it here:

diff --git a/Documentation/core-api/genalloc.rst b/Documentation/core-api/genalloc.rst
index 6b38a39fab24..983fa94f999c 100644
--- a/Documentation/core-api/genalloc.rst
+++ b/Documentation/core-api/genalloc.rst
@@ -1,3 +1,5 @@
+.. _genalloc:
+
 The genalloc/genpool subsystem
 ==============================
 
> +
> +The value added by pmalloc is that now the memory contained in a pool can
> +become R/O, for the rest of the life of the pool.
> +

IMHO, "read only" looks better than R/O

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

Can we use #. instead of numbers for the numbered list items?

> +.. kernel-doc:: include/linux/pmalloc.h
> +   :functions: pmalloc_create_pool
> +
> +2. [optional] pre-allocate some memory in the pool
> +
> +.. kernel-doc:: include/linux/pmalloc.h
> +   :functions: pmalloc_prealloc

Maybe it's better to have a short reference to the function and keep all
the elaborate descriptions in the API section?
For instance, something like

diff --git a/Documentation/core-api/pmalloc.rst b/Documentation/core-api/pmalloc.rst
@@ -68,8 +70,7 @@ The typical sequence, when using pmalloc, is:
 
 1. create a pool
 
-.. kernel-doc:: include/linux/pmalloc.h
-   :functions: pmalloc_create_pool
+     :c:func:`pmalloc_create_pool`
 
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
> -- 
> 2.14.1
> 

-- 
Sincerely yours,
Mike.
