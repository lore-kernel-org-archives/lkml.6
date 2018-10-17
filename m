Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18820ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3C321476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v4+poh3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3C321476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbeJRDEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:04:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59122 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbeJRDEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=txed5unC/EPSK9lOuS51LZ0Iujuyas2yW7FwcodyOlI=; b=v4+poh3gwKGq8xJlXJbmwsIZ+j
        IVV1v7G9RDri5a6sPyoXwQnE4FBiJUOQ3obDOuucyBzYq3H266eoVmhYZpWIT5qD/o5LG/XDzq8VP
        SQa7O/ZNZ91AaYw1hIHPmqeSrfDrmRr3YBjeJLdccQv3SdCdNqe39YX4Iu5+lrDMNaKxg+j+Vt0OL
        fKqWR5LQLj5VAW+bSk8A1HJ4flyTrHQ/Xtn0K52mr55LTH0ifxdCBVyA9SqygxF1yeikJtK8z8YAD
        u0DNtzP67h0J3yYk4ZCQ7DYs/Vk8nYH48byStwn2+16K22U+3kVrM8fuHF/IdHGqAQXlEARSl0ONp
        Km3PIHdA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCrAN-00042T-NU; Wed, 17 Oct 2018 19:07:35 +0000
Subject: Re: [Ksummit-discuss] [PATCH v3 1/3] code-of-conduct: Fix the
 ambiguity about collecting email addresses
To:     Frank Rowand <frowand.list@gmail.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
References: <1539701820.2805.6.camel@HansenPartnership.com>
 <1539701896.2805.7.camel@HansenPartnership.com>
 <e332116b-62e8-9930-c263-d022edb5828e@gmail.com>
 <1539744091.2805.108.camel@HansenPartnership.com>
 <16a20416-0045-dfe6-d937-63f2f0cff269@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <998bffa8-d280-8779-e567-c758f27b7b7b@infradead.org>
Date:   Wed, 17 Oct 2018 12:07:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <16a20416-0045-dfe6-d937-63f2f0cff269@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/18 11:49 AM, Frank Rowand wrote:
> On 10/16/18 19:41, James Bottomley wrote:
>> On Tue, 2018-10-16 at 19:10 -0700, Frank Rowand wrote:
>>> On 10/16/18 07:58, James Bottomley wrote:
>>>> The current code of conduct has an ambiguity in the it considers
>>>> publishing
>>>> private information such as email addresses unacceptable
>>>> behaviour.  Since
>>>> the Linux kernel collects and publishes email addresses as part of
>>>> the patch
>>>> process, add an exception clause for email addresses ordinarily
>>>> collected by
>>>> the project to correct this ambiguity.
>>>>
>>>> Fixes: 8a104f8b5867c682 ("Code of Conduct: Let's revamp it.")
>>>> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>>> Acked-by: Shuah Khan <shuah@kernel.org>
>>>> Acked-by: Guenter Roeck <linux@roeck-us.net>
>>>> Reviewed-by: Alan Cox <alan@llwyncelyn.cymru>
>>>> Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
>>>> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>>> Acked-by: Kees Cook <keescook@chromium.org>
>>>> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.c
>>>> om>
>>>> ---
>>>>  Documentation/process/code-of-conduct.rst | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/process/code-of-conduct.rst
>>>> b/Documentation/process/code-of-conduct.rst
>>>> index ab7c24b5478c..aa40e34e7785 100644
>>>> --- a/Documentation/process/code-of-conduct.rst
>>>> +++ b/Documentation/process/code-of-conduct.rst
>>>> @@ -31,7 +31,7 @@ Examples of unacceptable behavior by participants
>>>> include:
>>>>  * Trolling, insulting/derogatory comments, and personal or
>>>> political attacks
>>>>  * Public or private harassment
>>>>  * Publishing others’ private information, such as a physical or
>>>> electronic
>>>> -  address, without explicit permission
>>>> +  address not ordinarily collected by the project, without
>>>> explicit permission
>>>>  * Other conduct which could reasonably be considered inappropriate
>>>> in a
>>>>    professional setting
>>>>  
>>>>
>>>
> 
> There seems to be a disconnect between what I am trying to
> communicate and what I perceive you to have understood.
> 
> I'll add comments below to try to make more clear what I'm trying to
> say.
> 
> But first a general statement.  I understand that the intent of the
> patch wording is to allow use of email addresses in the tags of a patch
> submittal or git commit without being an unacceptable behavior.  I do
> not think that the words in the patch accomplish that goal.
> 
> 
>>> Repeating my comment on version 1:
>>>
>>> My understanding of the concern behind this change is that we should
>>> be able to use an email address for the current development
>>> practices, such as Reported-by, Suggested-by, etc tags when the email
>>> address was provided in what is a public space for the project.  The
>>> public space is visible to anyone in the world who desires to access
>>> it.
>>>
>>> I do not understand how "ordinarily collected by the project" is
>>> equivalent to "an email address that was provided in a public space
>>> for the project".
>>
>> I don't think it is ... or should be.  This section is specifically
>> enumerating unacceptable behaviours.  The carve out "email address not
>> ordinarily collected by the project" means that adding someone's email
>> address in a tag isn't immediately sanctionable in the code of conduct
>> as unacceptable behaviour if a question about whether you asked
>> explicit permission arises.  Equally, a carve out from unacceptable
>> behaviours doesn't make the action always acceptable, so it's not a
>> licence to publish someone's email address regardless of context.
> 
> The patch says "Publishing ... electronic address not ordinarily
> collected by the project, without explicit permission".  (I think it
> is fair to abstract here with "...".)  This phrase specifies which
> email addresses can be published.  It does not specify in what cases
> the email address can be published.  The desired goal is to be able to
> publish email addresses in patch and commit tags.
> 
> Which email addresses are allowed to be published?  (This is the point
> of my original comment.)  To me, the patch wording is describing how
> I can determine whether I can put a specific email address in a tag
> in a patch that I submit or commit.  I can put an email address in a
> tag _if_ it is "ordinarily collected by the project".
> 
> This then leads my mental process down the path of the disclosures (from
> all of the companies that I do business with) that tell me what they
> are going to do with my personal information, such as my address.  (They
> usually plan to share it with the world for their financial benefit.)
> In that context, my personal information is not _public_, but it is
> _ordinarily collected_ by the company.  I hope this provides some
> insight into what I am reading into "ordinarily collected by the project".
> 
> My original comment was trying to provide the concept behind a way to
> create an alternate wording in the patch to define "which email
> addresses".
> 
> Where are email addresses allowed to be published?  I do not understand
> the patch wording to address this at all.
> 
> Trying to understand how you are understanding my comment vs what I
> intended to communicate, it seems to me that you are focused on the
> "where allowed" and I am focused on the "which email addresses".
> 
> More clear?  Or am I still not communicating well enough?
> 
> 
>>> Ordinarily collected could include activities that can be expected to
>>> be private and not visible to any arbitrary person in the world.
>>
>> It's not a blanket permission, it's an exclusion from being considered
>> unacceptable behaviour.  I would be interested to know what information
>> we ordinarily collect in the course of building linux that should be
>> considered private because I might have missed something about the
>> implications here.
> 
> Permission vs exclusion is orthogonal to my comments.
> 
> "building linux" is not the patch wording.  "ordinarily collected by the
> project" is a much broader universe.
> 
> A very simplistic definition of public _could_ be:
> 
>   - Visible on a project mail list that any one can subscribe to
>   - Visible on a project mail list whose archive is available via
>     the public internet
>   - Visible on an interactive communication ("chat") platform that
>     is open to the public internet
>   - Published on a web page intended for public access (for example
>     this could cover opt-in conference attendee lists and emails
>     that conference presenters voluntarily place in their slides).

does that include bugzilla.kernel.org, or should we think of those email
addresses (of bug submitters) as private?  They look public to me.

>   - (I am guessing the above covers 97% or more of possible public
>     sources, but maybe there are some more common sources.)
> 
> I'm sure that the professionals that deal with information privacy
> could provide better wording for the above list.  I am but an
> amateur in that field.
> 
> Anything else collected by the project would not be considered public.
> For example, an email address provided in an email sent to me and not
> copied to any mail list would not be public.
> 
> -Frank
> 
>>
>> James
>>
>>> My issue is with the word choice.  I agree with the underlying
>>> concept.
>>>
>>> -Frank


-- 
~Randy
