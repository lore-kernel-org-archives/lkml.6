Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2765899-1523601818-2-16878270609923906816
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
    1523601817; b=TfMkiL2US3Kc/ruCwTWobwaRN7F2CdIC/wXnyMloIJ8k4XCtbS
    XsIRjT5gsZqnnyOWqjomHmFJoy1UwREY0RujYGuv2XC55twULv269AIepDAs0Ru2
    ZLjuXKz7+X5fX7CKHvsW2koD7SVWydntvxfSrNlnoXclgQp8VF1fD0vPrUI5rM+8
    JsxReOv3rCaVrg0ob2Qq3AUGGQjLBW4FRdhycykClbf3yTtGtWoJ62U2cvAj9stP
    ikKxWWpCE6atCszR2AFYNIUahE+pf5+qfx8uMjSEyImzNG/69vOUAlbgatjtbK4z
    c53cdGPoht7GtlE/YTq3MmgorBYG6N/1xMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=cc:subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523601817;
    bh=iXX36AfZLkCJre8Qf0DpRnMJJ3109Nxk0WtNA2N+glc=; b=Q7HNTelzRcZp
    EBZX8HMZzjxp3F7wu3WYaiU1AO8Vtc/dA9KPPSNCPdP+3+9ofLc/89qKEqHQo5cA
    pJyCm9jw1ZrE+Sc3hcgyzjjs3C67EPXcKQXf+xIG48KCAXX8xA9acZA1t+luOy8u
    VgrNUASDuK5cOiv1Ae/DZHnpwkFuvBj060+Ao+brQGXJAJDjuKNcUki0acUvvxEz
    XdJKhQIw/lCF20dFni6AQVNgGpSmGHk5+1LUdqzEptSv/6xrSq/qa1+UxCwpg5ce
    lKSHWITTi+0QBMWD2FhdD1Is0/dzY1HYQPHh2OWAOB916Gg8CKL8fuvewwuIA9b+
    U8ExOj4j9g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=oJMiLUsG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nIYdAPvQ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=oJMiLUsG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nIYdAPvQ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFTzqBCaAFrQlS7A+lXuTMlmiwo5oRp0g0QAMLfF1fzTeIgKUMTXCUp7diwXN9GU0u5H12DeLU4dHci7kxN5+50gtHypE5wcJYDOqlPpa55F3i027E2Q
    ObMrVnONKUuDVmHFZoYuAK5aibYpA9aKJoff0hA8q5sqAZ/7lbBPgMT0i0GXW2imZFRGN3k3urGFXRUPI59pxcxj1gLLvU8/6rTodHZe0nDKag6RkLEj1aXn
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=ZvkwkgPurpcA:10 a=Kd1tUaAdevIA:10 a=Ikd4Dj_1AAAA:8 a=pGLkceISAAAA:8
    a=1XWaLZrsAAAA:8 a=Sg8HuZxHAAAA:8 a=VwQbUJbxAAAA:8 a=GcyzOjIWAAAA:8
    a=zMeUpiw4ZyvUyf7k7m4A:9 a=Sbh-IW5uopbfk0h9:21 a=3V9h03-hL3M2h8zk:21
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=JFlNBosjgyz61O-hmi61:22
    a=AjGcO6oz07-iQ99wixmX:22 a=hQL3dl6oAZ8NdCsdz28n:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753099AbeDMGne (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 02:43:34 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40889 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbeDMGnd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 13 Apr 2018 02:43:33 -0400
X-Google-Smtp-Source: AIpwx491UCp9JkzqMe6n819BR7A2GcP6XDwRUhOa/krQvSecYKEEsXkEzFgFS9cE0QngqwJ78ivUKg==
Cc: mtk.manpages@gmail.com, linux-man <linux-man@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mmap.2: MAP_FIXED is okay if the address range has been
 reserved
To: John Hubbard <jhubbard@nvidia.com>, Jann Horn <jannh@google.com>
References: <20180412153941.170849-1-jannh@google.com>
 <b617740b-fd07-e248-2ba0-9e99b0240594@nvidia.com>
 <CAKgNAkgcJ2kCTff0=7=D3zPFwpJt-9EM8yis6-4qDjfvvb8ukw@mail.gmail.com>
 <CAG48ez2NtCr8+HqnKJTFBcLW+kCKUa=2pz=7HD9p9u1p-MfJqw@mail.gmail.com>
 <13801e2a-c44d-e940-f872-890a0612a483@nvidia.com>
 <CAG48ez085cASur3kZTRkdJY20dFZ4Yqc1KVOHxnCAn58_NtW8w@mail.gmail.com>
 <cfbbbe06-5e63-e43c-fb28-c5afef9e1e1d@nvidia.com>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <9c714917-fc29-4d12-b5e8-cff28761a2c1@gmail.com>
Date: Fri, 13 Apr 2018 08:43:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <cfbbbe06-5e63-e43c-fb28-c5afef9e1e1d@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/12/2018 09:24 PM, John Hubbard wrote:
> On 04/12/2018 12:18 PM, Jann Horn wrote:
>> On Thu, Apr 12, 2018 at 8:59 PM, John Hubbard <jhubbard@nvidia.com> wrote:
>>> On 04/12/2018 11:49 AM, Jann Horn wrote:
>>>> On Thu, Apr 12, 2018 at 8:37 PM, Michael Kerrisk (man-pages)
>>>> <mtk.manpages@gmail.com> wrote:
>>>>> Hi John,
>>>>>
>>>>> On 12 April 2018 at 20:33, John Hubbard <jhubbard@nvidia.com> wrote:
>>>>>> On 04/12/2018 08:39 AM, Jann Horn wrote:
>>>>>>> Clarify that MAP_FIXED is appropriate if the specified address range has
>>>>>>> been reserved using an existing mapping, but shouldn't be used otherwise.
>>>>>>>
>>>>>>> Signed-off-by: Jann Horn <jannh@google.com>
>>>>>>> ---
>>>>>>>  man2/mmap.2 | 19 +++++++++++--------
>>>>>>>  1 file changed, 11 insertions(+), 8 deletions(-)
>>>>>>>
>>>>>>> diff --git a/man2/mmap.2 b/man2/mmap.2
>>>> [...]
>>>>>>>  .IP
>>>>>>>  For example, suppose that thread A looks through
>>>>>>> @@ -284,13 +285,15 @@ and the PAM libraries
>>>>>>>  .UR http://www.linux-pam.org
>>>>>>>  .UE .
>>>>>>>  .IP
>>>>>>> -Newer kernels
>>>>>>> -(Linux 4.17 and later) have a
>>>>>>> +For cases in which the specified memory region has not been reserved using an
>>>>>>> +existing mapping, newer kernels (Linux 4.17 and later) provide an option
>>>>>>>  .B MAP_FIXED_NOREPLACE
>>>>>>> -option that avoids the corruption problem; if available,
>>>>>>> -.B MAP_FIXED_NOREPLACE
>>>>>>> -should be preferred over
>>>>>>> -.BR MAP_FIXED .
>>>>>>> +that should be used instead; older kernels require the caller to use
>>>>>>> +.I addr
>>>>>>> +as a hint (without
>>>>>>> +.BR MAP_FIXED )
>>>>>>
>>>>>> Here, I got lost: the sentence suddenly jumps into explaining non-MAP_FIXED
>>>>>> behavior, in the MAP_FIXED section. Maybe if you break up the sentence, and
>>>>>> possibly omit non-MAP_FIXED discussion, it will help.
>>>>>
>>>>> Hmmm -- true. That piece could be a little clearer.
>>>>
>>>> How about something like this?
>>>>
>>>>               For  cases in which MAP_FIXED can not be used because
>>>> the specified memory
>>>>               region has not been reserved using an existing mapping,
>>>> newer kernels
>>>>               (Linux  4.17  and  later)  provide  an  option
>>>> MAP_FIXED_NOREPLACE  that
>>>>               should  be  used  instead. Older kernels require the
>>>>               caller to use addr as a hint and take appropriate action if
>>>>               the kernel places the new mapping at a different address.
>>>>
>>>> John, Michael, what do you think?
>>>
>>>
>>> I'm still having difficulty with it, because this is in the MAP_FIXED section,
>>> but I think you're documenting the behavior that you get if you do *not*
>>> specify MAP_FIXED, right? Also, the hint behavior is true of both older and
>>> new kernels...
>>
>> The manpage patch you and mhocko wrote mentioned MAP_FIXED_NOREPLACE
>> in the MAP_FIXED section - I was trying to avoid undoing a change you
>> had just explicitly made.
> 
> heh. So I've succeeding in getting my own wording removed, then? Progress! :)
> 
>>
>>> So, if that's your intent (you want to sort of document by contrast to what
>>> would happen if this option were not used), then how about something like this:
>>>
>>>
>>> Without the MAP_FIXED option, the kernel would treat addr as a hint, rather
>>> than a requirement, and the caller would need to take appropriate action
>>> if the kernel placed the mapping at a different address. (For example,
>>> munmap and try again.)
>>
>> I'd be fine with removing the paragraph. As you rightly pointed out,
>> it doesn't really describe MAP_FIXED.
>>
> 
> OK, that's probably the simplest fix.

So, you mean remove this entire paragraph:

              For cases in which the specified memory region has not been
              reserved using an existing mapping,  newer  kernels  (Linux
              4.17  and later) provide an option MAP_FIXED_NOREPLACE that
              should be used instead; older kernels require the caller to
              use addr as a hint (without MAP_FIXED) and take appropriate
              action if the kernel places the new mapping at a  different
              address.

It seems like some version of the first half of the paragraph is worth 
keeping, though, so as to point the reader in the direction of a remedy.
How about replacing that text with the following:

              Since  Linux 4.17, the MAP_FIXED_NOREPLACE flag can be used
              in a multithreaded program to avoid  the  hazard  described
              above.

?

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
