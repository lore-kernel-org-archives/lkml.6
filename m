Return-Path: <kernel-hardening-return-13119-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZp4OaYRVaUSJVcszKRA6Hm6vkFXqa2OTBwgY71U2eqYUdAx4bW98MM1fkdghnnoDwOJKMPe
ARC-Seal: i=1; a=rsa-sha256; t=1524589504; cv=none;
        d=google.com; s=arc-20160816;
        b=p+2RRwu3m7pqs970Zp03EYiys0mFZn+RwgibafjFuhqHFvvqwU8I4VAzzOZ1Y3mC+N
         LVGVoRVnVZax5JG6dJyx6X5Jw63WmMvnvMrZENKAI1Cmgvv2DEYqgxYwICngSXKevuOJ
         p0FYS3zJ43kU+t36ivP8oEhG+tMOPKcdNfANtsNbJc83RL4yR7q7WXTh5BNtQI8rSQSN
         Nw0GH8ivUkAgSRsxPFHOxN9XhvejVAgdfIE9y7h5gqshubCLUg7yvBMZykOIVLNnnbQH
         5ujaLHjiXA5uFNravlmtdU+UwHQ6i36r63W5Oltt3JdmKsad+QmyHJHyeKPX4WEVWtdj
         ZXBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=Vm7vBAO4WJMfUCTWFP2Z0/dE/TVAoCX/XqxZ4GpYMFQ=;
        b=kQ9JTlhe4If18tRyJBfm0TbwG89o/8e4H1vJPeKaR/z0q/9oZ85bzI4QcWxLZiyjZd
         8Jd/wrLvxDpofoEFLkRQnzYFUm5JQpbLVGXLy4PtsmsCjFylcZOaRwoWTgB3PyQ4X4UQ
         UYc6Ifn8btY8fusUxXqlsUswlGpQWZMf3c5YT+/LMEvIYYldVpRtaL5qugcHUXRzUGlf
         ZHTXKQAbzfnBAgJrPEYCUvrjktQuhIdrHtwsCqc2UCi4n5gKUtgL2AMrNBNNHcWBgQer
         K25T1RxWHl5kBKGQGivBkmQDOLQdQpNPy4xWD3GO5vqhPcRO5LGWJc5xgcfvLa3+fXlu
         1Hog==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZcSNG2Da;
       spf=pass (google.com: domain of kernel-hardening-return-13119-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13119-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZcSNG2Da;
       spf=pass (google.com: domain of kernel-hardening-return-13119-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13119-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 7/9] Pmalloc Rare Write: modify selected pools
From: Igor Stoppa <igor.stoppa@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: keescook@chromium.org, paul@paul-moore.com, sds@tycho.nsa.gov,
 mhocko@kernel.org, corbet@lwn.net, labbott@redhat.com, david@fromorbit.com,
 rppt@linux.vnet.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com, Igor Stoppa <igor.stoppa@huawei.com>,
 Carlos Chinea Perez <carlos.chinea.perez@huawei.com>,
 Remi Denis Courmont <remi.denis.courmont@huawei.com>,
 linux-security-module@vger.kernel.org
References: <20180423125458.5338-1-igor.stoppa@huawei.com>
 <20180423125458.5338-8-igor.stoppa@huawei.com>
 <20180424115050.GD26636@bombadil.infradead.org>
 <98799559-121f-3d9d-343f-b22d30f21b6d@gmail.com>
Message-ID: <be0c9294-90a3-5820-dca2-7ce0a9a5dcab@gmail.com>
Date: Tue, 24 Apr 2018 21:04:42 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <98799559-121f-3d9d-343f-b22d30f21b6d@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598541768538376919?=
X-GMAIL-MSGID: =?utf-8?q?1598647963889984568?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 24/04/18 16:33, Igor Stoppa wrote:
> 
> 
> On 24/04/18 15:50, Matthew Wilcox wrote:
>> On Mon, Apr 23, 2018 at 04:54:56PM +0400, Igor Stoppa wrote:
>>> While the vanilla version of pmalloc provides support for permanently
>>> transitioning between writable and read-only of a memory pool, this
>>> patch seeks to support a separate class of data, which would still
>>> benefit from write protection, most of the time, but it still needs to
>>> be modifiable. Maybe very seldom, but still cannot be permanently marked
>>> as read-only.
>>
>> This seems like a horrible idea that basically makes this feature 
>> useless.
>> I would say the right way to do this is to have:
>>
>> struct modifiable_data {
>>     struct immutable_data *d;
>>     ...
>> };
>>
>> Then allocate a new pool, change d and destroy the old pool.
> 
> I'm not sure I understand.

A few cups of coffee later ...

This seems like a regression from my case.

My case (see the example with the initialized state) is:

static void *pointer_to_pmalloc_memory __ro_after_init;

then, during init:

pointer_to_pmalloc_memory = pmalloc(pool, size);

then init happens

*pointer_to_pmalloc_memory = some_value;

pmalloc_protect_pool(pool9;

and to change the value:

support_variable = some_other_value;

pmalloc_rare_write(pool, pointer_to_pmalloc_memory,
                    &support_variable, size)

But in this case the pmalloc allocation would be assigned to a writable 
variable.

This seems like a regression to me: at this point who cares anymore 
about the pmalloc memory?

Just rewrite the pointer to point to somewhere else that is writable and 
has the desired (from the attacker) value.

It doesn't even require gadgets. pmalloc becomes useless.

Do I still need more coffee?

--
igor
