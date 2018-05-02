Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-755991-1525266422-2-10785987082615863474
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525266417; b=HTffn2gPUamFrm2lBxy4ucQHGroYetog8AlG/oQNgcYN2qpyxW
    r8i+4tBEFVSkjkG/1t+/Yu4Qlb8O8tAAY1zObjdzBGAv/XF61J7lmQq3c/EXxQAm
    mYo4Kat8orOeVU1HFVUeAY2TleXhQyObUb+6FkNxzFM6UnbtAYXk9L8r+MTPOrNo
    TXZStLOYxlLG5yS6Yh3PklaCOFhG2A54TH7g5/618k33F0draUsNjsKSTfRWN4FI
    R8f0tasCGZQXenFZUOUPiFTh3B64G3K9jxAbDd3P1dN0FSv41Jw/ZBaHuOG2liib
    xXvMrLAKUwLuiz3TYwftJwItFH04K34qMBaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=cc:subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525266417;
    bh=SU2ZucDd9kQo5PVDwZG4++dMmv70Im04PUMe/dMoBYI=; b=L0VicQ9dambg
    J7mWzVU0wSQ9CTqJDn5rqJCpd7UDkFLwZAQ2sCiNtbl5FXQC9093yvmFOlnDOoud
    yWNXbl3yGXgCEjuxK0q/aeGoTuFdHub/iF/X9Ly0jMiR0iqf+ViQEEHiPo6Vj6+j
    /JCcEhMEFo1g2gNG+lEOXcZR78UfAnxQcyazLfVMKaRT7IAIkWMEUQu4lIkUVM4U
    i0eh6WWpJX4Q1YbbuhrgTwc0Lg2uJPWCKaA0yaPXseMTJXQcKniM9Pl9lnUyjfnX
    GAStI5zh5jkWXGWpMELUvRB4OH2zt9ddponmULjd5S5WFLvA0fTKWx0OexWtmEHD
    yjcebIEJrA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=UGJUgef7 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=a8NxN6er;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=UGJUgef7 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=a8NxN6er;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBTWLGMVPyqqtu1yxWOwL7EKFe2++Y8EecNcKmukhvOXj9eXPhRAxkacFnl7YdJ52uWyu+4x8zKuhKqTnhREjbsHSpMq8pCGWibuq0MqJne1NF2wurYc
    0wnDxdQ5JiJiJy/bYISONCUxjNknslsTVtA+ueEu9qfO2dO8N9iKPLQWGptxGTiXh+jYjqeXK7fcbt7MJPPzSD4yAYHian/5bRceqQz4Xa+HGHOGtRCCACfZ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=ZvkwkgPurpcA:10 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=GcyzOjIWAAAA:8
    a=kB60VVGfhrFvc-s97boA:9 a=Vwn8hCKZZ_Rixo0P:21 a=7Q7sdM_MHv06FCcf:21
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=hQL3dl6oAZ8NdCsdz28n:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbeEBNGo (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 09:06:44 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53611 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751073AbeEBNGj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 May 2018 09:06:39 -0400
X-Google-Smtp-Source: AB8JxZoJyM8aHAJMHS8gNzQm7iPlt39Xy4BXQtjMbm0oiBFCwCQmW86DK9xNUXjukWX79PHAlMalPg==
Cc: mtk.manpages@gmail.com, John Hubbard <jhubbard@nvidia.com>,
        linux-man <linux-man@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mmap.2: MAP_FIXED is okay if the address range has been
 reserved
To: Michal Hocko <mhocko@kernel.org>, Jann Horn <jannh@google.com>
References: <CAG48ez2w+3FDh9LM3+P2EHowicjM2Xw6giR6uq=26JfWHYsTAQ@mail.gmail.com>
 <20180413160435.GA17484@dhcp22.suse.cz>
 <CAG48ez3-xtmAt2EpRFR8GNKKPcsDsyg7XdwQ=D5w3Ym6w4Krjw@mail.gmail.com>
 <CAG48ez1PdzMs8hkatbzSLBWYucjTc75o8ovSmeC66+e9mLvSfA@mail.gmail.com>
 <20180416100736.GG17484@dhcp22.suse.cz>
 <CAG48ez3DwRXMtiinUWKnan6hAppLYLdx-w+VzXG6ubioZUacQg@mail.gmail.com>
 <20180416191805.GS17484@dhcp22.suse.cz>
 <CAG48ez1nf96nHj8a+aZy22RwqYTUZBGrsGFcz=ZhZBUWzaEZ9w@mail.gmail.com>
 <20180416195726.GT17484@dhcp22.suse.cz>
 <CAG48ez1bV_zZP3Y2ioDndP+H8mLCcxOtU1vCbWe7Q8myEGfXQQ@mail.gmail.com>
 <20180416211115.GU17484@dhcp22.suse.cz>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <43db1d63-fa64-4b4a-f3c3-edc73892bd23@gmail.com>
Date: Wed, 2 May 2018 15:06:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180416211115.GU17484@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Jann, Micha,

On 04/16/2018 11:11 PM, Michal Hocko wrote:
> On Mon 16-04-18 22:17:40, Jann Horn wrote:
>> On Mon, Apr 16, 2018 at 9:57 PM, Michal Hocko <mhocko@kernel.org> wrote:
>>> On Mon 16-04-18 21:30:09, Jann Horn wrote:
>>>> On Mon, Apr 16, 2018 at 9:18 PM, Michal Hocko <mhocko@kernel.org> wrote:
>>> [...]
>>>>> Yes, reasonably well written application will not have this problem.
>>>>> That, however, requires an external synchronization and that's why
>>>>> called it error prone and racy. I guess that was the main motivation for
>>>>> that part of the man page.
>>>>
>>>> What requires external synchronization? I still don't understand at
>>>> all what you're talking about.
>>>>
>>>> The following code:
>>>>
>>>> void *try_to_alloc_addr(void *hint, size_t len) {
>>>>   char *x = mmap(hint, len, ...);
>>>>   if (x == MAP_FAILED) return NULL;
>>>>   if (x == hint) return x;
>>>
>>> Any other thread can modify the address space at this moment.
>>
>> But not parts of the address space that were returned by this mmap() call.
> ?
>>> Just
>>> consider that another thread would does mmap(x, MAP_FIXED) (or any other
>>> address overlapping [x, x+len] range)
>>
>> If the other thread does that without previously having created a
>> mapping covering the area in question, that would be a bug in the
>> other thread.
> 
> MAP_FIXED is sometimes used without preallocated address ranges.
> 
>> MAP_FIXED on an unmapped address is almost always a bug
>> (excluding single-threaded cases with no library code, and even then
>> it's quite weird) - for example, any malloc() call could also cause
>> libc to start using the memory range you're trying to map with
>> MAP_FIXED.
> 
> Yeah and that's why we there is such a large paragraph in the man page
> ;)
> 
>>> becaus it is seemingly safe as x
>>> != hint.
>>
>> I don't understand this part. Are you talking about a hypothetical
>> scenario in which a programmer attempts to segment the virtual memory
>> space into areas that are exclusively used by threads without creating
>> memory mappings for those areas?
> 
> Yeah, that doesn't sound all that over-exaggerated, right? And yes,
> such a code would be subtle and most probably buggy. I am not trying to
> argue for those hypothetical cases. All I am saying is that MAP_FIXED is
> subtle.
> 
> I _do_ agree that using it solely on the preallocated and _properly_
> managed address ranges is safe. I still maintain my position on error
> prone though. And besides that there are usecases which do not operate
> on preallocated address ranges so people really have to be careful.
> 
> I do not really care what is the form. I find the current wording quite
> informative and showing examples of how things might be broken. I do
> agree with your remark that "MAP_FIXED on preallocated ranges is safe"
> should be added. But MAP_FIXED is dangerous API and should have few big
> fat warnings.

So, at this stage, is any further patch needed to the text describing
MAP_FIXED/MAP_FIXED_REPLACE?

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
