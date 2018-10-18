Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7FFC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E2A62098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIWpR31d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E2A62098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeJSHKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 03:10:30 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:35516 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeJSHKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 03:10:30 -0400
Received: by mail-pf1-f181.google.com with SMTP id l17-v6so15574488pff.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 16:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6/9qxdhQtj2PyUUTKPga99CxqvsadZpQkwGs+1SaecU=;
        b=YIWpR31dBml4PFyjTbQkeXfYDyi3hMibycwRAd0B+2lEbPMzTCmc+KWsSeHDyq6KC+
         FX6++EDskIRO1Pd21RvgI48W7GlAjbhfoU78lXiNQfhjiEo6dFHBduWjXyxMFEalw4XJ
         je9HgdtrwDATcYux3DEtDmZUP0MYMNWxGXuS1sYZUxNBqU5R18nla94XC5Zd98u987QO
         0THqvnzIx8YiP5T8N06uvRssRuh/6a0QyglJ8ByL5Kut9/wR32QojazPSZFmvXD8KwAO
         ocf0KWDs4EfW7k1zkjFZd0rPV5qWD4XpekdPriSmzBpuyKglgIUil86t/xIdiXqYougN
         4ZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6/9qxdhQtj2PyUUTKPga99CxqvsadZpQkwGs+1SaecU=;
        b=AKxtFuO/PlIWznKjWQC4C5bpfbYEm8dBAB7qRUM+kUUfAoI5kgqP9Vfi+VdUOGbuMw
         VxvVEi3CIQdKOL1fK64xvkyhrchsjgX72IAD24zdvkg9HGDpMSr0Pi4aHHcS8C0mqMra
         NZ5vOs2+pVs6p4T3nxzDYueM9kfPLIaSQjJFGGkCfFNYV1Z8gyN01TP3BUh8Y04kDeDO
         Fz7a8x90zv8uPxqVeaCD/1xpStUb91KAu7oYLW9riN2j4vd60aIqsoV0iX+lEpEEUX5H
         I/bOtAbKPBBR1d6YXxtiSnftqq/hi/CMz0MeyIvdU3+tcwQ7zh9x0wWAixX/Ry3uSv/3
         6rZw==
X-Gm-Message-State: ABuFfogLveQAAQ7WI2nReQuGxCr/mPaKwvttrk7GwL2ih5CImXoKZW7l
        ntMTIB0n0du4Zi52FGfhBeE=
X-Google-Smtp-Source: ACcGV61rNUqJyRuMAYhQtfJIBLwQaEZW4W6Ffop5ZD5Cenc0HT6ljCjkDZh0mafAHTZZT+MmCl1PcA==
X-Received: by 2002:a63:7f0e:: with SMTP id a14-v6mr30279342pgd.296.1539904036201;
        Thu, 18 Oct 2018 16:07:16 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id d2-v6sm24376608pfn.118.2018.10.18.16.07.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 16:07:15 -0700 (PDT)
Subject: Re: [Ksummit-discuss] [PATCH v3 1/3] code-of-conduct: Fix the
 ambiguity about collecting email addresses
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tim.Bird@sony.com, ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <1539701820.2805.6.camel@HansenPartnership.com>
 <1539701896.2805.7.camel@HansenPartnership.com>
 <e332116b-62e8-9930-c263-d022edb5828e@gmail.com>
 <1539744091.2805.108.camel@HansenPartnership.com>
 <16a20416-0045-dfe6-d937-63f2f0cff269@gmail.com>
 <1539803331.3769.62.camel@HansenPartnership.com>
 <b056cdc3-29de-b6c8-b2a7-67b93b0fd730@gmail.com>
 <1539874609.2845.5.camel@HansenPartnership.com>
 <b9f5376f-d8e8-bfe5-d27e-14c26d4859b8@gmail.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF805271E5@USCULXMSG01.am.sony.com>
 <1539892678.18970.30.camel@HansenPartnership.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <2adf5ac1-f837-a598-433d-db43459028db@gmail.com>
Date:   Thu, 18 Oct 2018 16:07:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539892678.18970.30.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/18 12:57, James Bottomley wrote:
> On Thu, 2018-10-18 at 19:49 +0000, Tim.Bird@sony.com wrote:
>>> -----Original Message-----
>>> From: Frank Rowand
>>>
>>> On 10/18/18 07:56, James Bottomley wrote:
>>>> On Wed, 2018-10-17 at 12:53 -0700, Frank Rowand wrote:
>>>>> On 10/17/18 12:08, James Bottomley wrote:
>>>>
>>>> [...]
>>>>>>> Trying to understand how you are understanding my comment
>>>>>>> vs what
>>>>>>> I intended to communicate, it seems to me that you are
>>>>>>> focused on
>>>>>>> the "where allowed" and I am focused on the "which email
>>>>>>> addresses".
>>>>>>>
>>>>>>> More clear?  Or am I still not communicating well enough?
>>>>>>
>>>>>> I think the crux of the disagreement is that you think the
>>>>>> carve
>>>>>> out equates to a permission which is not specific enough and
>>>>>> I
>>>>>> think it
>>>>>
>>>>> Nope.  That is a big place where I was not transferring my
>>>>> thoughts
>>>>> to clear communication.  I agree that what I wrote should have
>>>>> been
>>>>> written in terms of carve out instead of permission.
>>>>>
>>>>>
>>>>>> doesn't equate to a permission at all, which is why there's
>>>>>> no need
>>>>>> to make it more explicit.  Is that a fair characterisation?
>>>>>
>>>>> Nope.  My concern is "which email addresses".
>>>>
>>>> The idea here was because it's a carve out that doesn't give
>>>> permission
>>>> and because the permission is ruled by the project contribution
>>>> documents, the carve out should be broad enough to cover anything
>>>> they
>>>> might say hence "email addresses not ordinarily collected by the
>>>> project" are still included as unacceptable behaviour.
>>>>
>>>> Perhaps if you propose the wording you'd like to see it would
>>>> help
>>>> because there still looks to be some subtlety I'm not getting.
>>>
>>>
>>> From the beginning of the thread:
>>>
>>>   > @@ -31,7 +31,7 @@ Examples of unacceptable behavior by
>>> participants
>>> include:
>>>   >  * Trolling, insulting/derogatory comments, and personal or
>>> political
>>> attacks
>>>   >  * Public or private harassment
>>>   >  * Publishing others’ private information, such as a physical
>>> or electronic
>>>   > -  address, without explicit permission
>>>   > +  address not ordinarily collected by the project, without
>>> explicit
>>> permission
>>>   >  * Other conduct which could reasonably be considered
>>> inappropriate in a
>>>   >    professional setting
>>>
>>>
>>> Alternative (and I'm sure someone else can probably clean this up a
>>> little bit):
>>>
>>> + address that has been provided in a public space for the project,
>>> without explicit permission
>>
>> This ends up reading like so:
>>
>> ----
>> Examples of unacceptable behavior by participants include:
>> ...
>> * Publishing others’ private information, such as a physical or
>> electronic
>> address that has been provided in a public space for the project,
>> without
>> explicit permission.
>> ----
>>

>> I think that in context, you want a 'not' in there.  That is:

Yes, thank you.


>> unacceptable behavior includes publishing others' private
>> information... that has *not* been provided in a public space.  So, I
>> think the suggested text needs some fixing, IMHO.
> 
> You beat me to this one.  However, there is another issue that I did
> touch on but perhaps not in this subthread: For those of us who live in
> the US, our addresses (that's physical and sometimes email) are
> actually provided in a public space because they're available in the
> public property records.  That's actually why I chose "not ordinarily
> collected by the project" as opposed to "not previously provided in the
> public space" or an equivalent because doxxing in the US is mostly
> finding this information from public sources and broadcasting it.

That clarification helps a _lot_ in understanding what you have said
previously in this thread.  Thanks.  :-)


>> I looked at this issue upstream, and decided to leave the wording in
>> the CoC itself alone - favoring instead to add a clarifying addition
>> to the upstream CoC FAQ, about some email addresses not being
>> private information.
>>
>> The reason I took that approach, rather than try to change the
>> wording inside the CoC, is that the current wording seems to me to be
>> sufficient. The thing that is unacceptable is publishing private
>> information.  The "such as..." clause is intended to convey examples
>> of the types of thing that might usually be considered private
>> information.  But it is not exhaustive, nor is it necessarily
>> correct, depending on the circumstances.  In particular, email
>> addresses are sometimes private information and sometimes not.
>> In the context of kernel development, many email addresses are not
>> private.
>>
>> I am sympathetic to the argument that we use emails as public
>> information so much in kernel development processes, that it makes
>> sense to omit this or qualify it more.
> 
> I think that's the sense of the people who acked this, yes.  Personally
> I'm happy with a separate clarification in another document, but I can
> also see the argument that we do need our single CoC to be consistent
> with our operational method, which is why I proposed the patch.
> 
>> My own views are that:
>> 1) if we change this line at all, we should simply omit the "such
>> as..." part of the phrase, and leave it at:
>>
>> * Publishing others’ private information without explicit permission
> 
> This looks OK to me too ... the problem with the original is that the
> additional qualification overlaps our normal project method of
> operation, this solves the issue as well.

Looks good to me.

-Frank

> 
> James
> 
> 
>> but also
>> 2) I'm OK with leaving the phrase as is and handling the concerns
>> in an clarifying document.
>>
>> Just my 2 cents.
>>  -- Tim
>>
>>
>>
>> _______________________________________________
>> Ksummit-discuss mailing list
>> Ksummit-discuss@lists.linuxfoundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
> 
> 

