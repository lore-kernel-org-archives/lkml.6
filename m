Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1658150-1523558274-3-6257265372979405771
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523558273; b=D8gr6dIEgKs/5hqWC5OfysUfSx/Ej8uUj9v2z8TSpGAWFRYS6t
    u/172hL8/Haby5QAFg/FXgY54F0Em2mPr0FVmQWpK5NvO1yPKGpZDcSo4OhuemP5
    CRCYaJ91NLxZ+PI4nznMw+pWWv9bkoVvUGY5P9dyiq3vSYhk5uidPTMbB4qGMEWs
    ZNVz6Yj3TbvZxjXHSZJDctL1C9J0KxY51CI9eMOTKhDDpvcKZbxhRhL5pc1c3XPG
    9PI20JXOdBJmy3EQm05cTk3PuKhNsYd3YVfy/us6pvEgsQ/+TPhq3+LlHzdM8Bcv
    fp55ibZDN+LzFbocvEwXYIi4PWwxaJnmXkQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:reply-to:in-reply-to
    :references:from:date:message-id:subject:to:cc:content-type
    :sender:list-id; s=fm2; t=1523558273; bh=RdBCbqFhTgVIVWs/lLdYb10
    uNyIDV6YcQqoh9/kTjvI=; b=b2C/Xy4Te9F07QoS/vTmR642PdfpDTLQsqMAvc8
    iHcNfOAB4GbM6GV+2FoRH3HM3Ir2E6JsPQodp1a7SkIjZG7VZlvasNDBKmzUSRwZ
    KK6hGMcCr4hJJtx4caBvF2Zq3bczJoMMXqwYPvcehX569NQfN6VDopoq08kos6Uo
    1g3A7FQ2KZvKrK/iSA5JuodbQqFlY1h1Cv9iieYrEyuci/FaBiOBcVU9L6f+RAIu
    JOpvNi8ZAFrJP1ETrM1QnsZ59JcbeDFZAYMHcCpTOl0C6ApWSst/dklY+IPx3Nq9
    CbJTyKmLAcEEXzcZEYTAI9apGMiebFbHMdzsMgkkXgVeWvw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=h6GtdQcp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mhFWzDX/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=h6GtdQcp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mhFWzDX/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJB/r4MjhMJk4S8/1T8Q5bmu3SbVRPhDi3aCjAGRDHJJi4hTO20ED9MJMCwcuAanec/03XFdoPBTuKhHb4k26ofTOJvMRvq+eJxNSK2N5RDPugb3szeo
    KYe3+N1OMUxOopEIgLkDC/oaf1KEK7u+0exqaiDhF20siQEfFe5ZG7dhmupes91ugSCMLEasDRqIS/kqXoFPrjwlNvhk2RX9KtzC34bI0sJfm7lTywSHDF/u
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=HxJQQrNo-dsA:10 a=IkcTkHD0fZMA:10
    a=x7bEGLp0ZPQA:10 a=ZvkwkgPurpcA:10 a=Kd1tUaAdevIA:10 a=Ikd4Dj_1AAAA:8
    a=1XWaLZrsAAAA:8 a=Sg8HuZxHAAAA:8 a=VwQbUJbxAAAA:8 a=GcyzOjIWAAAA:8
    a=UjB7W4dps-61ik5HtQsA:9 a=MSwE6HJ8QE6y0Nqt:21 a=Qk563har12P6geR3:21
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=JFlNBosjgyz61O-hmi61:22
    a=AjGcO6oz07-iQ99wixmX:22 a=hQL3dl6oAZ8NdCsdz28n:22 a=0aluAjwT0AJoM8wfvWTS:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753139AbeDLShv (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 14:37:51 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40921 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752962AbeDLShu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Apr 2018 14:37:50 -0400
X-Google-Smtp-Source: AIpwx4/TOv5fB5hfsqHF0ZN3FBVL38pvXZBzXODu2ioEouRFbuk1Gj5nGPB+WmGvBNDA2o9lGYhfwGi3hqLkBsCLkiM=
MIME-Version: 1.0
Reply-To: mtk.manpages@gmail.com
In-Reply-To: <b617740b-fd07-e248-2ba0-9e99b0240594@nvidia.com>
References: <20180412153941.170849-1-jannh@google.com> <b617740b-fd07-e248-2ba0-9e99b0240594@nvidia.com>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date: Thu, 12 Apr 2018 20:37:29 +0200
Message-ID: <CAKgNAkgcJ2kCTff0=7=D3zPFwpJt-9EM8yis6-4qDjfvvb8ukw@mail.gmail.com>
Subject: Re: [PATCH] mmap.2: MAP_FIXED is okay if the address range has been reserved
To: John Hubbard <jhubbard@nvidia.com>
Cc: Jann Horn <jannh@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi John,

On 12 April 2018 at 20:33, John Hubbard <jhubbard@nvidia.com> wrote:
> On 04/12/2018 08:39 AM, Jann Horn wrote:
>> Clarify that MAP_FIXED is appropriate if the specified address range has
>> been reserved using an existing mapping, but shouldn't be used otherwise.
>>
>> Signed-off-by: Jann Horn <jannh@google.com>
>> ---
>>  man2/mmap.2 | 19 +++++++++++--------
>>  1 file changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/man2/mmap.2 b/man2/mmap.2
>> index bef8b4432..80c9ec285 100644
>> --- a/man2/mmap.2
>> +++ b/man2/mmap.2
>> @@ -253,8 +253,9 @@ Software that aspires to be portable should use this option with care,
>>  keeping in mind that the exact layout of a process's memory mappings
>>  is allowed to change significantly between kernel versions,
>>  C library versions, and operating system releases.
>> -Furthermore, this option is extremely hazardous (when used on its own),
>> -because it forcibly removes preexisting mappings,
>> +This option should only be used when the specified memory region has
>> +already been reserved using another mapping; otherwise, it is extremely
>> +hazardous because it forcibly removes preexisting mappings,
>>  making it easy for a multithreaded process to corrupt its own address space.
>
> Yes, that's clearer and provides more information than before.
>
>>  .IP
>>  For example, suppose that thread A looks through
>> @@ -284,13 +285,15 @@ and the PAM libraries
>>  .UR http://www.linux-pam.org
>>  .UE .
>>  .IP
>> -Newer kernels
>> -(Linux 4.17 and later) have a
>> +For cases in which the specified memory region has not been reserved using an
>> +existing mapping, newer kernels (Linux 4.17 and later) provide an option
>>  .B MAP_FIXED_NOREPLACE
>> -option that avoids the corruption problem; if available,
>> -.B MAP_FIXED_NOREPLACE
>> -should be preferred over
>> -.BR MAP_FIXED .
>> +that should be used instead; older kernels require the caller to use
>> +.I addr
>> +as a hint (without
>> +.BR MAP_FIXED )
>
> Here, I got lost: the sentence suddenly jumps into explaining non-MAP_FIXED
> behavior, in the MAP_FIXED section. Maybe if you break up the sentence, and
> possibly omit non-MAP_FIXED discussion, it will help.

Hmmm -- true. That piece could be a little clearer.

Jann, I've already pushed the existing patch. Do you want to add a patch on top?

Thanks,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
