Return-Path: <kernel-hardening-return-11963-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsN4gasv+RBP7906215sZgGSq0sjLCSLMl4KpIMeLXg3RZZxFXBGYyC2XgZVxGIOAxKCxm1
ARC-Seal: i=1; a=rsa-sha256; t=1519668076; cv=none;
        d=google.com; s=arc-20160816;
        b=vmG75d0NhVolkZVOIq0Z2NhKonxL6KlNbNngG4qSt1GFMgLuMrUXc4fRJYDLeTGN4G
         UYVXHNLBKiCNwOCE+MpdZ5Db7uwg7FtDypmRGo0gQrfsCgPSqxnBwSiJjnPetGiHozFv
         8iPgYXIAOtp5ZyzupVMdWKctzXccOaZyuUxr/ZkbvulqU+OOYGR5ObhxNpd8GOyYpdV0
         NqPUrANrHWaBGTIg9aNygE0lyAm/Y2dkXPUlxZZ1jl6dHDo5LaVm4R2wq8fHTn1L0vmp
         nbs8BtHmrAmqVomsfn6gkk6mDzdJZdmSIuArKyjittvwlBcQwl0/l3LLcq9SwZKl+/Jb
         34/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=6dvBF8i5s5T/d6HO8ybtQFoFQRMk2UQbWr9WQ3GWcfY=;
        b=i11z7YumXvXPgxocdNP0fU/IowvDvKqD9vykKc74wjTEcMuaqhylBWxf5cqN8QSsyl
         ojjFfGVX/MZSSNml9PuhiS4DHXbfRc+sdMiLTvEAWPzw3eJsuXo51yCO3YBPvA2JIjLy
         GfBfsbMU737vQ/ztM3bnG4+w1FvcA1IyGUnJEMZ038Ej6Dmf74Y4hGPJscWXZKgoKvh5
         lNdTf6TxJFOvFKBFq88qk0GMUZVqtc5mPq4ax/XVEAW3/AIHArYbn2FLxeR6W0MWi51N
         nXimeBcVLyr/2iC30CiPOGeBZHQuiUrAIESG7coOZUKO8bpXVLVwpHHzOZ0v5wXlWWZo
         vOzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11963-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11963-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11963-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11963-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 2/7] genalloc: selftest
To: J Freyensee <why2jjj.linux@gmail.com>, <david@fromorbit.com>,
	<willy@infradead.org>, <keescook@chromium.org>, <mhocko@kernel.org>
CC: <labbott@redhat.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>
References: <20180223144807.1180-1-igor.stoppa@huawei.com>
 <20180223144807.1180-3-igor.stoppa@huawei.com>
 <76b3d858-b14e-b66d-d8ae-dbd0b307308a@gmail.com>
 <a7b47f45-5929-ae07-1a10-46a02f6db078@huawei.com>
 <45087800-218a-7ff5-22c0-d0a5bfea5001@gmail.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <20249e10-4a13-8084-bcf2-0f98497a755f@huawei.com>
Date: Mon, 26 Feb 2018 20:00:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <45087800-218a-7ff5-22c0-d0a5bfea5001@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593203665689840629?=
X-GMAIL-MSGID: =?utf-8?q?1593487473253480108?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 26/02/18 19:46, J Freyensee wrote:
> 
> 
> On 2/26/18 4:11 AM, Igor Stoppa wrote:
>>
>> On 24/02/18 00:42, J Freyensee wrote:
>>>> +	locations[action->location] = gen_pool_alloc(pool, action->size);
>>>> +	BUG_ON(!locations[action->location]);
>>> Again, I'd think it through if you really want to use BUG_ON() or not:
>>>
>>> https://lwn.net/Articles/13183/
>>> https://lkml.org/lkml/2016/10/4/1
>> Is it acceptable to display only a WARNing, in case of risking damaging
>> a mounted filesystem?
> 
> That's a good question.  Based upon those articles, 'yes'.  But it seems 
> like a 'darned-if-you-do, darned-if-you-don't' question as couldn't you 
> also corrupt a mounted filesystem by crashing the kernel, yes/no?

The idea is to do it very early in the boot phase, before early init,
when the kernel has not gotten even close to any storage device.

> If you really want a system crash, maybe just do a panic() like 
> filesystems also use?

ok, if that's a more acceptable way to halt the kernel, I do not mind.

--
igor
