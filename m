Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA09AECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F63214D5
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpJzU6Em"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F63214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbeJRDvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:51:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43838 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbeJRDvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:51:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id d8-v6so1804049pgv.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 12:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x6OaPB+36JBdWhkZ++BX81AZlRsiJSO6bUvHIW4LpB4=;
        b=NpJzU6EmmPaKmHBxYryq5Dl9zA8MR6rWSzW6K9WedtO/m99IWFhQInQ5gspGkTMvy3
         tS6mvPdyJa5JkaJK1gFD2FPDjQXxbRyLYmkAq6we0glpgNk4N1Epx/lXrQsXtO9m4Ssc
         qZECUcbeutXEAZi8TQ4J/BHWB1rDw2LvTo+Gs5c3kln4wWpuUQk5h9Jrwbqmg16DJRpw
         mfYs1juvYZ9yt4h+Rx7go7ikBG6ff0hJeG8SPUAokwq+Xflup78xmvJesPN1pqfc9Pmv
         3iMOQAKsr9lyrZmnhcX4TLtnFJjkFmSgsevVK4rxtjVwlUxRnFcRiRhsVyrmI60H/dAs
         8bNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x6OaPB+36JBdWhkZ++BX81AZlRsiJSO6bUvHIW4LpB4=;
        b=BXV5TdD99+d9CZ2hmaNWrhHWmq5hl4bVKkxDbITpcJlMpqonwKNkqKeHq5SNyU3x2h
         vLb5EFsxD53vpdG2xUM5EkiNca4Id+O7N4Qi0utppJMhnYsQ/CGqXc8fZUH8hPA3+MSo
         rZa6G1EBOoIYNIj4Y/H9s2biaRXeV9aVBIp/AU5puo/P334o0DOHS1/vqt7/1QsEW67B
         ltbBkgVqNOMY1IIiqrsVk+NnKM2BeXrxUCKk/CHXpJXRt9avMUqlMMZh6Wfl0HGjQIL/
         gtpPF6fAYmaEP8oFZQL+rtXvXjbM5fHyG04+iIfCQlwd2JZ/ZCYV41RmIC5TguGDIkWt
         l3zw==
X-Gm-Message-State: ABuFfoi+ktX0+4nRJA40A6B+HV8sm3c/QPa64DMTut+f/lGzTwylhmiP
        7Y2qKAYbNv2WAV3/adt89Hs=
X-Google-Smtp-Source: ACcGV638EmeaMI02fP4zFHHSlnA+l8p5euKLCyKWhMrk6ui7z/xfHLUSLXzsEUeJH8F1cZ2IAqA2Eg==
X-Received: by 2002:a65:40c2:: with SMTP id u2-v6mr25680649pgp.123.1539806039738;
        Wed, 17 Oct 2018 12:53:59 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id m20-v6sm19232009pgv.93.2018.10.17.12.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 12:53:59 -0700 (PDT)
Subject: Re: [Ksummit-discuss] [PATCH v3 1/3] code-of-conduct: Fix the
 ambiguity about collecting email addresses
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
References: <1539701820.2805.6.camel@HansenPartnership.com>
 <1539701896.2805.7.camel@HansenPartnership.com>
 <e332116b-62e8-9930-c263-d022edb5828e@gmail.com>
 <1539744091.2805.108.camel@HansenPartnership.com>
 <16a20416-0045-dfe6-d937-63f2f0cff269@gmail.com>
 <1539803331.3769.62.camel@HansenPartnership.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <b056cdc3-29de-b6c8-b2a7-67b93b0fd730@gmail.com>
Date:   Wed, 17 Oct 2018 12:53:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539803331.3769.62.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/18 12:08, James Bottomley wrote:
> On Wed, 2018-10-17 at 11:49 -0700, Frank Rowand wrote:
>> On 10/16/18 19:41, James Bottomley wrote:
>>> On Tue, 2018-10-16 at 19:10 -0700, Frank Rowand wrote:
> [...]
>>>> Repeating my comment on version 1:
>>>>
>>>> My understanding of the concern behind this change is that we
>>>> should be able to use an email address for the current
>>>> development practices, such as Reported-by, Suggested-by, etc
>>>> tags when the email address was provided in what is a public
>>>> space for the project.  The public space is visible to anyone in
>>>> the world who desires to access it.
>>>>
>>>> I do not understand how "ordinarily collected by the project" is
>>>> equivalent to "an email address that was provided in a public
>>>> space for the project".
>>>
>>> I don't think it is ... or should be.  This section is specifically
>>> enumerating unacceptable behaviours.  The carve out "email address
>>> not ordinarily collected by the project" means that adding
>>> someone's email address in a tag isn't immediately sanctionable in
>>> the code of conduct as unacceptable behaviour if a question about
>>> whether you asked explicit permission arises.  Equally, a carve out
>>> from unacceptable behaviours doesn't make the action always
>>> acceptable, so it's not a licence to publish someone's email
>>> address regardless of context.
>>
>> The patch says "Publishing ... electronic address not ordinarily
>> collected by the project, without explicit permission".  (I think it
>> is fair to abstract here with "...".)  This phrase specifies which
>> email addresses can be published.  It does not specify in what cases
>> the email address can be published.  The desired goal is to be able
>> to publish email addresses in patch and commit tags.
> 
> No, that's not my desired goal.   The section is not about giving
> permission it's about making sure listed unacceptable behaviours don't
> overlap what we normally do.  The goal is to exclude email the project
> ordinarily collects from immediate sanction under the unacceptable
> behaviours clause.  I deliberately didn't add anything about permission
> because that's up to the project to define in its more standard
> contribution documents.

OK.  I am fine with the goal of wording that excludes certain things
from unacceptable behavior instead providing permissions for certain
things.  I think me phrasing as permission instead of carve out is
creating a lot of the miscommunication.

Please re-read my comments, but in every place where I state things
in a way of providing permissions, re-state it in your mind as the
same sentence _except_ phrased as excluding from unacceptable
behavior.  (I started to do that explicitly, but it looked like
I was just going to create a whole lot of distracting text.)


>> Which email addresses are allowed to be published?  (This is the
>> point of my original comment.)  To me, the patch wording is
>> describing how I can determine whether I can put a specific email
>> address in a tag in a patch that I submit or commit.  I can put an
>> email address in a tag _if_ it is "ordinarily collected by the
>> project".
>>
>> This then leads my mental process down the path of the disclosures
>> (from all of the companies that I do business with) that tell me what
>> they are going to do with my personal information, such as my
>> address.  (They usually plan to share it with the world for their
>> financial benefit.) In that context, my personal information is not
>> _public_, but it is _ordinarily collected_ by the company.  I hope
>> this provides some insight into what I am reading into "ordinarily
>> collected by the project".
>>
>> My original comment was trying to provide the concept behind a way to
>> create an alternate wording in the patch to define "which email
>> addresses".
>>
>> Where are email addresses allowed to be published?  I do not
>> understand the patch wording to address this at all.
> 
> I agree, but, as I said, my goal wasn't to provide explicit permission
> (because the list is too long and too dependent on the way the project
> operates) it was to carve out an exclusion from sanction for stuff the
> kernel normally does.  The carve out doesn't translate into explicit
> permission because the project can define other standards for the way
> email addresses are added to the tags.
> 
>> Trying to understand how you are understanding my comment vs what I
>> intended to communicate, it seems to me that you are focused on the
>> "where allowed" and I am focused on the "which email addresses".
>>
>> More clear?  Or am I still not communicating well enough?
> 
> I think the crux of the disagreement is that you think the carve out
> equates to a permission which is not specific enough and I think it

Nope.  That is a big place where I was not transferring my thoughts
to clear communication.  I agree that what I wrote should have been
written in terms of carve out instead of permission.


> doesn't equate to a permission at all, which is why there's no need to
> make it more explicit.  Is that a fair characterisation?

Nope.  My concern is "which email addresses".

-Frank


> James
> 
> 

