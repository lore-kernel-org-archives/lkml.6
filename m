Return-Path: <kernel-hardening-return-11833-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226QI8IvaLctdco4TQbFngmtqoxZAdrm1p1jA4AA67RUhiC915KSJJlj6LajrkQh4pEg7nnd
ARC-Seal: i=1; a=rsa-sha256; t=1519149875; cv=none;
        d=google.com; s=arc-20160816;
        b=kFlHcplfN42ojiqaxWNrBCYiAVQ12WLLBWp36fe+PeEcA8Bcs7BdSieF9poFKnAHhz
         0WxbDSNGfDolCF4Grjc+MPThZKlifdzupQ88T8E2PzHMOAJtX+1IbWZvWdrG0WYfIaw5
         LgqWM9T+mjEIJkpKlaOt1GRVRBCJtiG1NWITDREDWM1RwsrzzeG+TYC7qYENazx72gsO
         nwde+OYrZCez0+JJn2W97CXsxBBi8bWDFDCES2mTrz5JXDWor1d/eu+m6hrXAcby807k
         6Tk+nKu8enYCCwhkNoc2ePFFtZZVR/EKI8oEh5HDYQAUC0mgXzXiSFB9zDfJRmCfdACA
         d8rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=KYUx9NWqWAN19tl9VF9QHwqlQzQeQ4Trp/31LC/YAKM=;
        b=P9jtQXOOTHaMN7vFv5jYEg/gvEOo4o3fuu3fg6jyKgEMbI9P7YQ6rcGNfWu64RNryk
         PZ5ETkBXDeH6ylgITtrhU9uY1gUjnUkGHobJ4rhzqSulfXrVwFgc4GS5xZ+ygmaSsV/8
         R/8NzYuZ8mt4D9sVf/15qyDJuGBv4tUlXfw4fvCOWzBu2PlQqgSpFwLYSNj4x2YaVn4c
         28FyeIuiLVisxAekZI0+zu2X3UXUWqPDChMORibkDpK0dujiF9XJaoAv3Rf3PDmfAUeI
         l4wdGJi/x8Ik56qWStmEPuOkMtWX2it1GTaMo3kPRIIvpsN5c/TGVQ0oOSrr18c6ONvh
         2zHg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11833-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11833-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11833-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11833-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [RFC PATCH v16 0/6] mm: security: ro protection for dynamic data
To: Dave Chinner <dchinner@redhat.com>, Kees Cook <keescook@chromium.org>
CC: Matthew Wilcox <willy@infradead.org>, Randy Dunlap
	<rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, Michal Hocko
	<mhocko@kernel.org>, Laura Abbott <labbott@redhat.com>, Jerome Glisse
	<jglisse@redhat.com>, Christoph Hellwig <hch@infradead.org>, "Christoph
 Lameter" <cl@linux.com>, linux-security-module
	<linux-security-module@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, LKML
	<linux-kernel@vger.kernel.org>, Kernel Hardening
	<kernel-hardening@lists.openwall.com>
References: <20180212165301.17933-1-igor.stoppa@huawei.com>
 <CAGXu5j+ZNFX17Vxd37rPnkahFepFn77Fi9zEy+OL8nNd_2bjqQ@mail.gmail.com>
 <20180220012111.GC3728@rh>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <24e65dec-f452-a444-4382-d1f88fbb334c@huawei.com>
Date: Tue, 20 Feb 2018 20:03:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180220012111.GC3728@rh>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592214870438978682?=
X-GMAIL-MSGID: =?utf-8?q?1592944099850575626?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 20/02/18 03:21, Dave Chinner wrote:
> On Mon, Feb 12, 2018 at 03:32:36PM -0800, Kees Cook wrote:
>> On Mon, Feb 12, 2018 at 8:52 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
>>> This patch-set introduces the possibility of protecting memory that has
>>> been allocated dynamically.
>>>
>>> The memory is managed in pools: when a memory pool is turned into R/O,
>>> all the memory that is part of it, will become R/O.
>>>
>>> A R/O pool can be destroyed, to recover its memory, but it cannot be
>>> turned back into R/W mode.
>>>
>>> This is intentional. This feature is meant for data that doesn't need
>>> further modifications after initialization.
>>
>> This series came up in discussions with Dave Chinner (and Matthew
>> Wilcox, already part of the discussion, and others) at LCA. I wonder
>> if XFS would make a good initial user of this, as it could allocate
>> all the function pointers and other const information about a
>> superblock in pmalloc(), keeping it separate from the R/W portions?
>> Could other filesystems do similar things?
> 
> I wasn't cc'd on this patchset, (please use david@fromorbit.com for
> future postings) 

Apologies, somehow I didn't realize that I should have put you too in
CC. It will be fixed at the next iteration.

> so I can't really say anything about it right
> now. My interest for XFS was that we have a fair amount of static
> data in XFS that we set up at mount time and it never gets modified
> after that.

This is the typical use case I had in mind, although it requires a
conversion.
Ex:

before:

static int a;


void set_a(void)
{
	a = 4;
}



after:

static int *a __ro_after_init;
struct gen_pool *pool;

void init_a(void)
{
	pool = pmalloc_create_pool("pool", 0);
	a = (int *)pmalloc(pool, sizeof(int), GFP_KERNEL);
}

void set_a(void)
{
	*a = 4;
	pmalloc_protect_pool(pool);
}

> I'm not so worried about VFS level objects (that's a
> much more complex issue) but there is a lot of low hanging fruit in
> the XFS structures we could convert to write-once structures.

I'd be interested to have your review of the pmalloc API, if you think
something is missing, once I send out the next revision.

--
igor
