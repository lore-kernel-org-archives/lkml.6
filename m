Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B6FECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C732082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ujaGyG03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C732082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeJaHLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 03:11:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45278 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeJaHLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 03:11:07 -0400
Received: by mail-lf1-f68.google.com with SMTP id c24-v6so10131041lfi.12;
        Tue, 30 Oct 2018 15:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5Ky3uiKRIkgCOv3N0jJvjqQ23cVkr/7JkItMxX78SbQ=;
        b=ujaGyG03GOtuFjUJZIu2eAQzgm6NK2JTwXOltUPpx6nXKFLGbqGZC5IKtsI3xXeAX2
         ivRnhJJpJbDHp6yCFpcraDcKyMzwwX2hk6UtkPpTr2jikgp6zO/X26orMQ22dbGlSe5Y
         c4DQFR6EclBCeM9bxMP2xSetjrt6iC2V9VNxUyjmF6hD4Mmti368oMeQb1aaQ+Xv3oGS
         L/tFlhHz8qSb/a8tRGtJtI2svKIdbyh9knE4tPQudiGTlGj2mmqOOt0vLzlLz10nBcIR
         aT0nGswAi7ucysGJIfMri+Fpcso28891sM9EtH8XcP/MPXZ/5uIROZXooaUTFu7Y0nWT
         pmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5Ky3uiKRIkgCOv3N0jJvjqQ23cVkr/7JkItMxX78SbQ=;
        b=P8YhsGVkrqGlVj+fU6egPMROtb9dhFkqwSC7QsNimuWxVQPkVFk9LD75MZr//92KAO
         eTFoSxq0lN/1j6YMeycwNSWnNZw/UOCQPuBh8BMIdqyCxLd/dIUXPxPYCHevox/tC1gM
         aZMnwe7ntrz39UOOJs3gehglNMHtumtNQlrGuHrMRTnIV4/y32fkanBertgp99cFNGOt
         m0amACjbo/n69PcDl2WVAz/iEnDu55qn8jn+PAF9Qa4DEDk0QZsocHnEClwNdHsuFqCc
         PRC4SqCbPGJgyV9bEr8BxLiG8E9M+OyAJqWdvHGCpgL5EmLwWlQtiGzhxpAhmXZoqRQR
         pGpg==
X-Gm-Message-State: AGRZ1gKl7jaQ+c2CLC5K3U8smWMLw6cnxPiRyvJZppV0aLkIoKlhq1AC
        dMd9vCvNWnj3oe7wC+FOVgg=
X-Google-Smtp-Source: AJdET5cLfZ/LiUZETwLRKti0DlIEs5ZZWN7s5o0SKnm9C5hTnMmQ1HWGdfadZaZxwn14awXniefvbQ==
X-Received: by 2002:a19:5713:: with SMTP id l19mr297890lfb.85.1540937748834;
        Tue, 30 Oct 2018 15:15:48 -0700 (PDT)
Received: from [192.168.10.160] (91-159-62-242.elisa-laajakaista.fi. [91.159.62.242])
        by smtp.gmail.com with ESMTPSA id a8-v6sm3672465ljd.6.2018.10.30.15.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 15:15:48 -0700 (PDT)
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20181023213504.28905-11-igor.stoppa@huawei.com>
 <20181026092609.GB3159@worktop.c.hoisthospitality.com>
 <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net>
 <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net>
 <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net>
 <20181030175814.GB10491@bombadil.infradead.org> <20181030182841.GE7343@cisco>
 <20181030192021.GC10491@bombadil.infradead.org>
 <9edbdf8b-b5fb-5a82-43b4-b639f5ec8484@gmail.com>
 <BAA65A07-F3AF-4209-9D18-7075CEF11EE8@amacapital.net>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <2cfb3835-0c18-b3fb-1722-5d693ae0ecd2@gmail.com>
Date:   Wed, 31 Oct 2018 00:15:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <BAA65A07-F3AF-4209-9D18-7075CEF11EE8@amacapital.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/10/2018 23:02, Andy Lutomirski wrote:
> 
> 
>> On Oct 30, 2018, at 1:43 PM, Igor Stoppa <igor.stoppa@gmail.com> wrote:


>> There is no need to process each of these tens of thousands allocations and initialization as write-rare.
>>
>> Would it be possible to do the same here?
> 
> I don’t see why not, although getting the API right will be a tad complicated.

yes, I have some first-hand experience with this :-/

>>
>>>>>
>>>>> To subsequently modify q,
>>>>>
>>>>>     p = rare_modify(q);
>>>>>     q->a = y;
>>>>
>>>> Do you mean
>>>>
>>>>      p->a = y;
>>>>
>>>> here? I assume the intent is that q isn't writable ever, but that's
>>>> the one we have in the structure at rest.
>>> Yes, that was my intent, thanks.
>>> To handle the list case that Igor has pointed out, you might want to
>>> do something like this:
>>>     list_for_each_entry(x, &xs, entry) {
>>>         struct foo *writable = rare_modify(entry);
>>
>> Would this mapping be impossible to spoof by other cores?
>>
> 
> Indeed. Only the core with the special mm loaded could see it.
> 
> But I dislike allowing regular writes in the protected region. We really only need four write primitives:
> 
> 1. Just write one value.  Call at any time (except NMI).
> 
> 2. Just copy some bytes. Same as (1) but any number of bytes.
> 
> 3,4: Same as 1 and 2 but must be called inside a special rare write region. This is purely an optimization.

Atomic? RCU?

Yes, they are technically just memory writes, but shouldn't the "normal" 
operation be executed on the writable mapping?

It is possible to sandwich any call between a rare_modify/rare_protect, 
however isn't that pretty close to having a write-rare version of these 
plain function.

--
igor
