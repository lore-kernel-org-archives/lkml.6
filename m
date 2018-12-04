Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD1EC07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1842064A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZNkAWZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1842064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbeLDMek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 07:34:40 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46652 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbeLDMej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 07:34:39 -0500
Received: by mail-lj1-f195.google.com with SMTP id v15-v6so14705326ljh.13;
        Tue, 04 Dec 2018 04:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p7t1Zylc680WxUHGy4zLyH8y54duQW2sGGC10lMzwVo=;
        b=EZNkAWZK4JA1loBdbiD0csmzBNwSvmD2W7a31+CRQJEKDtPrwoPOglXgM+f+8g0PuJ
         uWJY9d9Mfq1sVjOsCEogzpUtXbpHnLLPB0mHQ0tEp5nGLSYlpelisEJ/ymjMolMA9til
         c5oECT5tivAcEx1/V1rMa2TU2BmkzAcWRHOkZb+sJh753oxBSapIrKe6FhnyYHYaaPfO
         cNz32tHq1xZPzjOukSlJBjYS8YDtDH6/+f98kx8fbzidGErw1Y743MJ5leIruqixWddy
         2W0URzHtXUmRZhhr95o6KwopaoiSY57cz3UpOnwFdQHiVv+FVMERRHqfsp0xysQWGxqn
         SUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p7t1Zylc680WxUHGy4zLyH8y54duQW2sGGC10lMzwVo=;
        b=Zyhs57BvoCXj1/Uq49Eb+BV/hjUoiEoe1WA97RMdOb5i9amdzMgKXY5QPl0i40brIS
         vsQpKueHJ4yJ2lYwrwqYHnuoAo7o8nSGv18L9upKJEfF3Sw2IKYFL5dKkehPGwXruM0n
         cft7izSxQQGR9/xVFC+E9PZmQrApVYxxT0A9CZJQxoi0gr3X8ZTclIuuv2KBgE6B99uG
         OqLUDDLLSZNkmDmcLRstM0yd+y73BXb2kHEuCRyP4zALXBkBNNeeSPmU+nGrlFEMZC68
         ukWes1lkxR2mpOpdXDkTn79Ju9RJbsSCNBsT1E0u5/HCH3WzxYBUvMqHCoo47s24jt1W
         Z8DA==
X-Gm-Message-State: AA+aEWaPxgb+GOLGWLy2wiNclKzrvY95c9ZhKDC+hj6AEIFoM8vOix0I
        bBitKi09VsRrj/V5hWe5xQA=
X-Google-Smtp-Source: AFSGD/V1zNhbWYNdoriRBLuDrZSKH3voip/q97HzGbOdQfwkZ9NlENpkNldkpGiMhqR9hJNIbnzwzQ==
X-Received: by 2002:a2e:4819:: with SMTP id v25-v6mr13752395lja.2.1543926874397;
        Tue, 04 Dec 2018 04:34:34 -0800 (PST)
Received: from [192.168.10.160] (91-156-179-117.elisa-laajakaista.fi. [91.156.179.117])
        by smtp.gmail.com with ESMTPSA id y24-v6sm3072205ljd.20.2018.12.04.04.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 04:34:33 -0800 (PST)
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Andy Lutomirski <luto@amacapital.net>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <6f60afc9-0fed-7f95-a11a-9a2eef33094c@gmail.com>
 <CALCETrXNckT9W288VXx-6inO5qYn-6dUPocKGcBT0GCO3xi3ZQ@mail.gmail.com>
 <386C0CB1-C4B1-43E2-A754-DA8DBE4FB3CB@gmail.com>
 <CALCETrWWcfLK4W3mn0bavzejmMBVKMX29aAUA3+VPQ8m9vmfhw@mail.gmail.com>
 <9373ccf0-f51b-4bfa-2b16-e03ebf3c670d@huawei.com>
 <2e52e103-15d0-0c26-275f-894dfd07e8ec@huawei.com>
 <CALCETrV0sPgf4ZgG1joF_5hM-ycPsWM9DWGO=diQ_LQKin4VuA@mail.gmail.com>
 <1166e55c-0c06-195c-a501-383b4055ea46@gmail.com>
 <3BB9DE07-E0AE-43E2-99F1-E4AA774CD462@amacapital.net>
 <5e10c8e4-aa71-1eea-b1ce-50d7d0a60e8c@gmail.com>
 <20181122200416.GS3065@bombadil.infradead.org>
 <CALCETrXB34QBcYk=k5DT1t4h7EezaPxbxM2S_h2nYk5Nv1c4_Q@mail.gmail.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <20ad363b-e78d-efcb-0a17-3ae2d3fbaa5f@gmail.com>
Date:   Tue, 4 Dec 2018 14:34:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CALCETrXB34QBcYk=k5DT1t4h7EezaPxbxM2S_h2nYk5Nv1c4_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
apologies for the delayed answer.
Please find my reply to both last mails in the thread, below.

On 22/11/2018 22:53, Andy Lutomirski wrote:
> On Thu, Nov 22, 2018 at 12:04 PM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Thu, Nov 22, 2018 at 09:27:02PM +0200, Igor Stoppa wrote:
>>> I have studied the code involved with Nadav's patchset.
>>> I am perplexed about these sentences you wrote.
>>>
>>> More to the point (to the best of my understanding):
>>>
>>> poking_init()
>>> -------------
>>>    1. it gets one random poking address and ensures to have at least 2
>>>       consecutive PTEs from the same PMD
>>>    2. it then proceeds to map/unmap an address from the first of the 2
>>>       consecutive PTEs, so that, later on, there will be no need to
>>>       allocate pages, which might fail, if poking from atomic context.
>>>    3. at this point, the page tables are populated, for the address that
>>>       was obtained at point 1, and this is ok, because the address is fixed
>>>
>>> write_rare
>>> ----------
>>>    4. it can happen on any available core / thread at any time, therefore
>>>       each of them needs a different address
>>
>> No?  Each CPU has its own CR3 (eg each CPU might be running a different
>> user task).  If you have _one_ address for each allocation, it may or
>> may not be mapped on other CPUs at the same time -- you simply don't care.

Yes, somehow I lost track of that aspect.

>> The writable address can even be a simple formula to calculate from
>> the read-only address, you don't have to allocate an address in the
>> writable mapping space.
>>
> 
> Agreed.  I suggest the formula:
> 
> writable_address = readable_address - rare_write_offset.  For
> starters, rare_write_offset can just be a constant.  If we want to get
> fancy later on, it can be randomized.

ok, I hope I captured it here [1]

> If we do it like this, then we don't need to modify any pagetables at
> all when we do a rare write.  Instead we can set up the mapping at
> boot or when we allocate the rare write space, and the actual rare
> write code can just switch mms and do the write.

I did it. I have little feeling about the actual amount of data 
involved, but there is a (probably very remote) chance that the remap 
wouldn't work, at least in the current implementation.

It's a bit different from what I had in mind initially, since I was 
thinking to have one single approach to both statically allocated memory 
(is there a better way to describe it) and what is provided from the 
allocator that would come next.

As I wrote, I do not particularly like the way I implemented multiple 
functionality vs remapping, but I couldn't figure out any better way to 
do it, so eventually I kept this one, hoping to get some advice on how 
to improve it.

I did not provide yet an example, yet, but IMA has some flags that are 
probably very suitable, since they depend on policy reloading, which can 
happen multiple times, but could be used to disable it.

[1] https://www.openwall.com/lists/kernel-hardening/2018/12/04/3

--
igor
