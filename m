Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F00C04EBA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1627221479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5y6bz4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1627221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732832AbeKVEhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:37:04 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36574 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbeKVEhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:37:03 -0500
Received: by mail-lj1-f196.google.com with SMTP id g11-v6so5658926ljk.3;
        Wed, 21 Nov 2018 10:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mWykYS+jUbGJe43LdZkd94pFw+HtdGCnZbU+fASezfE=;
        b=i5y6bz4Fer523odc6ZKUZfVnbm7+N7MmGn0EPqSgMWJHfINRr2oIgJn7bNj5+Mpzyo
         h4dCP/8cIOqlqIKACJyZVHJBWSdfNa6cSErTX0Jr98SbFcZwC5kmAewDHqWyyX+BKk+3
         Lsrc3VwL1bEpjFdX2Ss4Qjot9syh/hlvS3Y+LI9GVdqiqXED59BFeT70vGJSP/kyGYit
         QkDPdUu7/swpzQ9e22zyROAyqYvXOnB5wD/8Jm88luTCYCYr5OICsN5f0SzTYl6+4e5q
         m/tPngb1GjUVnv/WRI1HOVOpcy7UXp9pobz//9sY9rnFsKKds/dQrvRs1FLyZyl2QmEn
         zkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mWykYS+jUbGJe43LdZkd94pFw+HtdGCnZbU+fASezfE=;
        b=MRXZzAgsBicHtV5YZva007zor+z4LZeOYuZjFshL+ypG9QmklyOATbS9ppYKj7eJNz
         JvieT4ExbEFvtb6r/Sr/YR9LqbOKcFxSMxN0iKmRkTY7P9s2fGNAs0wknHHoFGr/aC6v
         fSCPsew9gg1ZqEOXZe0z6oIaAfDMmrD1RgfASZC6DfdJfpOXomb6HM42irJxpYpLqK92
         i47Sy7lrAirt+Ne6tUu3PiyvP8WScgbgSDllkidFr+6PcYZ+VjQ/zDt4HKtx/jbRi5CE
         ruPDXPSzkYcPqpURRsSlDsQ7rCT6VIXxAnjMRSmMTx22DDx0UMxahJXgnAzkgOmN6KzL
         NxJw==
X-Gm-Message-State: AA+aEWbrt9H8JhEO6Zv/8hMWLV0TKi++bLNcz8Ip02eokTd66qt2NogL
        0q5yAn6bHT7/QYrK+6l7nfo=
X-Google-Smtp-Source: AFSGD/VLaPJTwFuyLVu1W/ARAq0Wul/qU/M2Un9AKnfc3QNPTnj+c2PdKqif+bdNHuK5BRLcU45YeA==
X-Received: by 2002:a2e:9b15:: with SMTP id u21-v6mr4574418lji.29.1542823297973;
        Wed, 21 Nov 2018 10:01:37 -0800 (PST)
Received: from ?IPv6:2001:14bb:40:1c40:9d63:5352:fe43:f29c? (dkyrfbjndmqls8t-wxt-4.rev.dnainternet.fi. [2001:14bb:40:1c40:9d63:5352:fe43:f29c])
        by smtp.gmail.com with ESMTPSA id s127sm6797324lfe.8.2018.11.21.10.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 10:01:37 -0800 (PST)
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
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
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181026092609.GB3159@worktop.c.hoisthospitality.com>
 <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net>
 <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net>
 <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net>
 <6f60afc9-0fed-7f95-a11a-9a2eef33094c@gmail.com>
 <CALCETrXNckT9W288VXx-6inO5qYn-6dUPocKGcBT0GCO3xi3ZQ@mail.gmail.com>
 <386C0CB1-C4B1-43E2-A754-DA8DBE4FB3CB@gmail.com>
 <CALCETrWWcfLK4W3mn0bavzejmMBVKMX29aAUA3+VPQ8m9vmfhw@mail.gmail.com>
 <9373ccf0-f51b-4bfa-2b16-e03ebf3c670d@huawei.com>
 <2e52e103-15d0-0c26-275f-894dfd07e8ec@huawei.com>
 <CALCETrV0sPgf4ZgG1joF_5hM-ycPsWM9DWGO=diQ_LQKin4VuA@mail.gmail.com>
 <1166e55c-0c06-195c-a501-383b4055ea46@gmail.com>
 <03E199F6-FD90-4B88-838E-C3702F982F78@gmail.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <19a216e3-2f1a-32d5-ed22-99d9fdd93a59@gmail.com>
Date:   Wed, 21 Nov 2018 20:01:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <03E199F6-FD90-4B88-838E-C3702F982F78@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/11/2018 19:36, Nadav Amit wrote:
>> On Nov 21, 2018, at 8:34 AM, Igor Stoppa <igor.stoppa@gmail.com> wrote:

[...]

>> There might be other reasons for replicating the mm_struct.
>>
>> If I understand correctly how the text patching works, it happens sequentially, because of the text_mutex used by arch_jump_label_transform
>>
>> Which might be fine for this specific case, but I think I shouldn't introduce a global mutex, when it comes to data.
>> Most likely, if two or more cores want to perform a write rare operation, there is no correlation between them, they could proceed in parallel. And if there really is, then the user of the API should introduce own locking, for that specific case.
> 
> I think that if you create per-CPU temporary mms as you proposed, you do not
> need a global lock. You would need to protect against module unloading,

yes, it's unlikely to happen and probably a bug in the module, if it 
tries to write while being unloaded, but I can do it

> and
> maybe refactor the code. Specifically, I’m not sure whether protection
> against IRQs is something that you need.

With the initial way I used to do write rare, which was done by creating 
a temporary mapping visible to every core, disabling IRQs was meant to 
prevent that the "writer" core would be frozen and then the mappings 
scrubbed for the page in writable state.

Without shared mapping of the page, the only way to attack it should be 
to generate an interrupt on the "writer" core, while the writing is 
ongoing, and to perform the attack from the interrupt itself, because it 
is on the same core that has the writable mapping.

Maybe it's possible, but it seems to have become quite a corner case.

> I’m also not familiar with this
> patch-set so I’m not sure what atomicity guarantees do you need.

At the very least, I think I need to ensure that pointers are updated 
atomically, like with WRITE_ONCE() And spinlocks.
Maybe atomic types can be left out.

>> A bit unrelated question, related to text patching: I see that each patching operation is validated, but wouldn't it be more robust to first validate  all of then, and only after they are all found to be compliant, to proceed with the actual modifications?
>>
>> And about the actual implementation of the write rare for the statically allocated variables, is it expected that I use Nadav's function?
> 
> It’s not “my” function. ;-)

:-P

ok, what I meant is that the signature of the __text_poke() function is 
quite specific to what it's meant to do.

I do not rule out that it might be eventually refactored as a special 
case of a more generic __write_rare() function, that would operate on 
different targets, but I'd rather do the refactoring after I have a 
clear understanding of how to alter write-protected data.

The refactoring could be the last patch of the write rare patchset.

> IMHO the code is in relatively good and stable state. The last couple of
> versions were due to me being afraid to add BUG_ONs as Peter asked me to.
> 
> The code is rather simple, but there are a couple of pitfalls that hopefully
> I avoided correctly.

Yes, I did not mean to question the quality of the code, but I'd prefer 
to not have to carry also this patchset, while it's not yet merged.

I actually hope it gets merged soon :-)
--
igor

