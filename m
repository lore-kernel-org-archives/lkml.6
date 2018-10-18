Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8B6C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519F32083A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jE6utnpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519F32083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbeJSDYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 23:24:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39532 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbeJSDYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 23:24:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id c25-v6so15330889pfe.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 12:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=woz41Xzu1f/jy8w3DNip+IXlx5+BDBke5BHd5QllxIY=;
        b=jE6utnpoljimNZQlL/SDkQJby1w1aAolFfq0i2D19bK8Df5K8QvM6fAxrD2umUskPs
         24wWa3NJ+FqEcWCiNwVVbT/ajKl+uMrSFNBfj0x3SSxqRJWdPwNx/XyQqmGIYk5edj/2
         ux1CDNToWo5kjys0VHrKsYDu5WxlM02OlNH+HrPMXytwdLwx1hEzGYZuRnbLllnQzc8w
         cXM3wH5kaWdPkXQbM1HL2U+M01JRH8U3ZZLGXCMtPDx9dQVdCiSquO58okr5a3rWE2Z9
         NZiZgk/xfFgoY/L0waQjnB/5wevsRk+iW3CSx0NEs93Bn4YbOrla1dfbNY3UJPKVl7qv
         QK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=woz41Xzu1f/jy8w3DNip+IXlx5+BDBke5BHd5QllxIY=;
        b=ulYgi1EfWPKzi/u08slR+LWK3p93/6JLFXJU+svdVqDT7o/5w0Oxj8Wvc4xX/3AVAo
         PgN+wRsa8mDqL7TzpB551i5THOs1yxIKfN39jNevGHhQ52gBvt2p7NEO36lrIPzQDO2k
         HTKCsjddE3ekEcQbToBxN4RIB8y2tvZ+PW/oFY/w56kk9g9duKOdoOplRzXUO2cORniu
         we1Gf5dIPUR3ZofEoOp7R05Fx4rmRdLMOIZxJzgHgA1laAXbJiWtPYQsRVxFxl6TUfIZ
         T/ZgC9owaYoL42/zwoVKpoNKs1pPzA2KcRvrHgBUOSg/VIc5XAtFyt3QVwX0nkBxpr1z
         NtVQ==
X-Gm-Message-State: ABuFfojevxzO9ewcpIZkwvkvlk9joeqAeHFVbJhvNT0zvhYIiz61HC2B
        4di9pMOhW4VcVHCOH4leIsJhhLgX
X-Google-Smtp-Source: ACcGV62RNlolISZlMnKG9IA1T7Ftob0B7csAHSt2MSp22giUgR+AVJA6gfFMLUuft1OK+7UukQ41hQ==
X-Received: by 2002:a63:9809:: with SMTP id q9-v6mr11243806pgd.128.1539890547615;
        Thu, 18 Oct 2018 12:22:27 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id 5-v6sm28124449pgt.83.2018.10.18.12.22.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 12:22:26 -0700 (PDT)
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
 <b056cdc3-29de-b6c8-b2a7-67b93b0fd730@gmail.com>
 <1539874609.2845.5.camel@HansenPartnership.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <b9f5376f-d8e8-bfe5-d27e-14c26d4859b8@gmail.com>
Date:   Thu, 18 Oct 2018 12:22:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539874609.2845.5.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/18 07:56, James Bottomley wrote:
> On Wed, 2018-10-17 at 12:53 -0700, Frank Rowand wrote:
>> On 10/17/18 12:08, James Bottomley wrote:
> [...]
>>>> Trying to understand how you are understanding my comment vs what
>>>> I intended to communicate, it seems to me that you are focused on
>>>> the "where allowed" and I am focused on the "which email
>>>> addresses".
>>>>
>>>> More clear?  Or am I still not communicating well enough?
>>>
>>> I think the crux of the disagreement is that you think the carve
>>> out equates to a permission which is not specific enough and I
>>> think it
>>
>> Nope.  That is a big place where I was not transferring my thoughts
>> to clear communication.  I agree that what I wrote should have been
>> written in terms of carve out instead of permission.
>>
>>
>>> doesn't equate to a permission at all, which is why there's no need
>>> to make it more explicit.  Is that a fair characterisation?
>>
>> Nope.  My concern is "which email addresses".
> 
> The idea here was because it's a carve out that doesn't give permission
> and because the permission is ruled by the project contribution
> documents, the carve out should be broad enough to cover anything they
> might say hence "email addresses not ordinarily collected by the
> project" are still included as unacceptable behaviour.
> 
> Perhaps if you propose the wording you'd like to see it would help
> because there still looks to be some subtlety I'm not getting.


From the beginning of the thread:

  > @@ -31,7 +31,7 @@ Examples of unacceptable behavior by participants include:
  >  * Trolling, insulting/derogatory comments, and personal or political attacks
  >  * Public or private harassment
  >  * Publishing others’ private information, such as a physical or electronic
  > -  address, without explicit permission
  > +  address not ordinarily collected by the project, without explicit permission
  >  * Other conduct which could reasonably be considered inappropriate in a
  >    professional setting


Alternative (and I'm sure someone else can probably clean this up a little bit):

+ address that has been provided in a public space for the project, without explicit permission


See you in Edinburgh,

-Frank


> 
> James
> 
> 
> 
> 

