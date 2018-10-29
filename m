Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E62EECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C2A20880
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vWNRwsST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C2A20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeJ3GHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:07:47 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37234 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbeJ3GHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:07:46 -0400
Received: by mail-lf1-f65.google.com with SMTP id p17so766966lfh.4;
        Mon, 29 Oct 2018 14:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rHFZG9pWUais7nhw2UduPXRMeh+ITBO90nUo2sRa4wM=;
        b=vWNRwsSTgCmY8RJxJErKJu4l1ftiT/2EKB31NNmZMKIOSK2X1Ics6T/NJURxFkUDkj
         wCb36qRwTzEi1T9JZ+Z4F4lweBm7u424ZqU+MbomHjDLuiFWdyy/nCHlc9Tlddmq7wO9
         r0JYTo7jNwu0VqDSyShOMvCzNabU4I7OVGo8hN9z/nZIqIN5dfDOudv34WM0+dBGrvNe
         dUbH6pYhQO+29cXA1Gg/pe45Tj++X9AWByxZDEEmxn1asBnfHvaz3nPayhSmlrkbqOgD
         JgRBK2aNY7cOTLNrjegGR6hS8Z0X1SCB18Lowt3RQmNWEEnBiIGqFA/InMTVsSsTg2QU
         9hkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rHFZG9pWUais7nhw2UduPXRMeh+ITBO90nUo2sRa4wM=;
        b=V43ne3qj1KAgg/SW+DCsZ/i7CvtsqTqXdvAEZ/w1BXP2ygyYk7giS8srkLZN/s844+
         euQOKBflhpviQvofmuLkaOtFH+8uagJr8KO6tnhdD8BzuCFShlaYqsSB7B8i51U0UYR7
         Mkevk8DZI3b5/YG4HdbjRKmXvHzqgbMCk9FjeMYJ3aQ/1SBPPJ6wMCorigDebqwBokwT
         jIYIY+fWZmqYJORmjBJ+wq98DXhghTOopuUIFB0UUd4WZb3LHBBzcoZ+Gg92wdggrjeL
         gDqf4gnQAdVY0Q2f7RXbzC51bw95dBXV82oIWA7M6iiYxPxDhBFWFnRVWOE/TC1tl2+m
         7mCA==
X-Gm-Message-State: AGRZ1gLsSm1r0H3CYcCiQgJeLjSV48jGB8Ew8ZLu2TgveDIDFp5K0QpK
        ndBh0k4HGSq0tlmUY2N9cpqRg5ZlhD4=
X-Google-Smtp-Source: AJdET5ePGqmWE3vSrsqL3WHKhOF2Kp5JIZjKU6JQnuFMkZCMY3cPx0UpnE1RPZGQ+Ero2sE6845/5Q==
X-Received: by 2002:a19:c954:: with SMTP id z81mr210924lff.150.1540847837332;
        Mon, 29 Oct 2018 14:17:17 -0700 (PDT)
Received: from ?IPv6:2001:14bb:52:7be:f0bf:dd2d:f008:5213? (dmkd798g-7z2-yccwcp-4.rev.dnainternet.fi. [2001:14bb:52:7be:f0bf:dd2d:f008:5213])
        by smtp.gmail.com with ESMTPSA id r63-v6sm3374551lfr.66.2018.10.29.14.17.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 14:17:16 -0700 (PDT)
Subject: Re: [PATCH 16/17] prmem: pratomic-long
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, igor.stoppa@huawei.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-17-igor.stoppa@huawei.com>
 <20181025001312.GA3159@worktop.c.hoisthospitality.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <806bfff0-8d62-9918-480d-ec791b93841e@gmail.com>
Date:   Mon, 29 Oct 2018 23:17:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181025001312.GA3159@worktop.c.hoisthospitality.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/10/2018 01:13, Peter Zijlstra wrote:
> On Wed, Oct 24, 2018 at 12:35:03AM +0300, Igor Stoppa wrote:
>> +static __always_inline
>> +bool __pratomic_long_op(bool inc, struct pratomic_long_t *l)
>> +{
>> +	struct page *page;
>> +	uintptr_t base;
>> +	uintptr_t offset;
>> +	unsigned long flags;
>> +	size_t size = sizeof(*l);
>> +	bool is_virt = __is_wr_after_init(l, size);
>> +
>> +	if (WARN(!(is_virt || likely(__is_wr_pool(l, size))),
>> +		 WR_ERR_RANGE_MSG))
>> +		return false;
>> +	local_irq_save(flags);
>> +	if (is_virt)
>> +		page = virt_to_page(l);
>> +	else
>> +		vmalloc_to_page(l);
>> +	offset = (~PAGE_MASK) & (uintptr_t)l;
>> +	base = (uintptr_t)vmap(&page, 1, VM_MAP, PAGE_KERNEL);
>> +	if (WARN(!base, WR_ERR_PAGE_MSG)) {
>> +		local_irq_restore(flags);
>> +		return false;
>> +	}
>> +	if (inc)
>> +		atomic_long_inc((atomic_long_t *)(base + offset));
>> +	else
>> +		atomic_long_dec((atomic_long_t *)(base + offset));
>> +	vunmap((void *)base);
>> +	local_irq_restore(flags);
>> +	return true;
>> +
>> +}
> 
> That's just hideously nasty.. and horribly broken.
> 
> We're not going to duplicate all these kernel interfaces wrapped in gunk
> like that. 

one possibility would be to have macros which use typeof() on the 
parameter being passed, to decide what implementation to use: regular or 
write-rare

This means that type punning would still be needed, to select the 
implementation.

Would this be enough? Is there some better way?

> Also, you _cannot_ call vunmap() with IRQs disabled. Clearly
> you've never tested this with debug bits enabled.

I thought I had them. And I _did_ have them enabled, at some point.
But I must have messed up with the configuration and I failed to notice 
this.

I can think of a way it might work, albeit it's not going to be very pretty:

* for the vmap(): if I understand correctly, it might sleep while 
obtaining memory for creating the mapping. This part could be executed 
before disabling interrupts. The rest of the function, instead, would be 
executed after interrupts are disabled.

* for vunmap(): after the writing is done, change also the alternate 
mapping to read only, then enable interrupts and destroy the alternate 
mapping. Making also the secondary mapping read only makes it equally 
secure as the primary, which means that it can be visible also with 
interrupts enabled.


--
igor
