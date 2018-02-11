Return-Path: <kernel-hardening-return-11694-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224xXLVv98IrwgdcGkCI2m0CQc9j11M2axP5GjMYwtutPiO6BCr82r3qGlduAP8n7/Oj92Ca
ARC-Seal: i=1; a=rsa-sha256; t=1518312570; cv=none;
        d=google.com; s=arc-20160816;
        b=z1T3Gej/BKddSuUvdIx0g3tQUg6h1IoI7cWz/3u/Yit7o9qL3dOMVJStFGNfrqjCIX
         03sthBR6Q5hP5ltZbz8+hQUSXSroEl6PhTsYhkrwz7IrnKgvya7QdguJ00EzdoFqZ9L5
         PPR6k0dTk3DY31gzT4a85JBkpJJbDkmto25xw9sjI7IOp+J4xkDrjvYPHUzNOj4aRKl/
         nCOXa5cUr2MRJSFRBmceJvavM2J4Q/3AD+mEHpSnRd+kGts0FBT+YJGzQYuu7iJdEIaF
         ECLrf9czrYrBsWSK73lF1IvfDXyVc1ZxlKDYciQkGpXr+eIjJuQ88IvhFrdJxILF+b5C
         6duQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=VADWEFDneCLPYWhySHZ6ApuMWh7QtHRfwX27GYr81uM=;
        b=L+CvGgM/1SCno44HehQtrvhx2gReLd2IC5vaFJzZgBXoVXvvsyHZbpZUu6VwJYMYFE
         qjeC+inOXKY7lth8cqOzeMWgx3Sh+T8BULRFjPXDgdG5J/nPBxkBf601PtxP5ISydWpG
         nmLxIJ8x+qGj1oFFDjGEM1niGV6rztqINmMQ4fvmf8+zLmwMcrdIyn83MtGzQetDIdO8
         DGZqmoSEOHN5ApieVJEu34ekeuIozOk1+en3zyTM5lMBypbMKgM7aXZ+jfRlarhgtz4X
         Gf86Mqir1XMEFq0r/QfF3jZdgAEkNX9+0msuZLGgfH57NwX/CySu0scayArJVUD/JMfb
         FyIA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11694-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11694-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11694-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11694-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 5/6] Pmalloc: self-test
To: kbuild test robot <lkp@intel.com>
CC: <kbuild-all@01.org>, <jglisse@redhat.com>, <keescook@chromium.org>,
	<mhocko@kernel.org>, <labbott@redhat.com>, <hch@infradead.org>,
	<willy@infradead.org>, <cl@linux.com>,
	<linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kernel-hardening@lists.openwall.com>
References: <20180204170056.28772-1-igor.stoppa@huawei.com>
 <201802080158.oKwP7HVR%fengguang.wu@intel.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <655ac34e-cca7-f619-6d67-348fa596297c@huawei.com>
Date: Sun, 11 Feb 2018 03:28:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <201802080158.oKwP7HVR%fengguang.wu@intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591490615808474286?=
X-GMAIL-MSGID: =?utf-8?q?1592066121595109531?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 07/02/18 19:18, kbuild test robot wrote:
> Hi Igor,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on kees/for-next/pstore]
> [also build test ERROR on v4.15]
> [cannot apply to linus/master mmotm/master next-20180207]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Igor-Stoppa/mm-security-ro-protection-for-dynamic-data/20180207-171252
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
> config: i386-randconfig-s1-201805+bisect_validate (attached as .config)
> compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    mm/pmalloc.o: In function `pmalloc_pool_show_chunks':
>>> mm/pmalloc.c:100: undefined reference to `gen_pool_for_each_chunk'
>    mm/pmalloc.o: In function `pmalloc_pool_show_size':
>>> mm/pmalloc.c:81: undefined reference to `gen_pool_size'
>    mm/pmalloc.o: In function `pmalloc_pool_show_avail':
>>> mm/pmalloc.c:70: undefined reference to `gen_pool_avail'
>    mm/pmalloc.o: In function `pmalloc_chunk_free':
>>> mm/pmalloc.c:459: undefined reference to `gen_pool_flush_chunk'
>    mm/pmalloc.o: In function `pmalloc_create_pool':
>>> mm/pmalloc.c:173: undefined reference to `gen_pool_create'
>>> mm/pmalloc.c:210: undefined reference to `gen_pool_destroy'
>    mm/pmalloc.o: In function `gen_pool_add':
>>> include/linux/genalloc.h:115: undefined reference to `gen_pool_add_virt'
>    mm/pmalloc.o: In function `pmalloc':
>>> mm/pmalloc.c:357: undefined reference to `gen_pool_alloc'
>    mm/pmalloc.o: In function `gen_pool_add':
>>> include/linux/genalloc.h:115: undefined reference to `gen_pool_add_virt'
>    mm/pmalloc.o: In function `pmalloc':
>    mm/pmalloc.c:386: undefined reference to `gen_pool_alloc'
>    mm/pmalloc.o: In function `pmalloc_destroy_pool':
>    mm/pmalloc.c:484: undefined reference to `gen_pool_for_each_chunk'
>    mm/pmalloc.c:485: undefined reference to `gen_pool_destroy'

Wrong default value for the pmalloc Kconfig option, it must default to
true. Will fix it.

--
igor
