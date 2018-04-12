Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1658150-1523560726-2-8880689323543679735
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523560725; b=GqczTIXqIASu3JcTKbKlibLpQDR5AqqtLk7+J1CLWfzvtSu3lZ
    Y9IpUpnJNrhL45CXrBFgre+seFikLdpQT1bZo4t8aiu2DiePCWwlM04czgwdX/mH
    J/SSxZlSKhVndj5vpNpwmbKVEXn9xqR4jERnd3xqUQOvIVQ1X0qbEetjCdABZW8V
    LJIEkvRoDzHcdP8HzKpJxODJml4DGA3Yoov1kgcyzWbMIw7Ut3sTXBX++TJN/ceQ
    Uha+vrxIOkhG4jTF2Ysloq0ITyvQt6rbxoDMZuBhgXlAJF+jvWQQmUXZ5FAU+an6
    C9CbPc6tK/3e/csUh2+d0cEOVQIBkmLeTWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523560725; bh=R6bfVyAt+Z5ZOsxRkbYq9hofk826rHbpff/l3HYmgm
    w=; b=lugy8J/EeezomijIf94LUUOpIUFzVHPyD8K/Sr7cjjyx6NQOM7cDkdr0/1
    yx3E/10EcuYeFIwb6GLNB6H43TWQ0yM8hlD2Cw4UWD9iSb2jQjTQWOAyid1wM5hx
    ihixGR7uTlvyWSAhVkyoclcIgmv2PDtFM6yY3Vh5Osb6A7rvDDBTvWTyAx+QTwKO
    zj6Eyeqe0HEDB6KFw+s4CpEWLEG/w2D3sExluV91ZVHZCyuUxqSPMKHbMTFzCDe4
    dn6AX9QgglL64fl6w4i8/YhMDP3lOa/C4gansgdyNGfCl2sYwyaCCK55SZPz2Bkf
    G/59JpoIvWyJh+Ed4V70dq+0Khyw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=fIEChYnP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lN9U+eNr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=fIEChYnP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lN9U+eNr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCmjhD6sKzqbzLTRT5ZrmvfCQ1YilHoYwB8MFRTvkIm2h7hDicrHOsD+7yJqjEeM70/IJdlvI2upeHXAq6lP+Qxe/yT0ewaVbuLzZPK9h9OLPOLMd+eL
    2nZQpFm+d3umEvBykZVzCSqngJOfgjCJwmoUGNuobQZS/7LjFfAxNWMqLQLAwaUNTC04lveJZFE3hGeIVKjyleK24TsM4Ro5qfrtql5xXC4YQGk6wT8dN7Bt
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Ikd4Dj_1AAAA:8 a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=Sg8HuZxHAAAA:8
    a=VwQbUJbxAAAA:8 a=rWIYA4eLKNsjzeS5ABEA:9 a=Qy7CBJ2B_7dp3Sbq:21
    a=umiPgS2uMHsHR1Fv:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=JFlNBosjgyz61O-hmi61:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752807AbeDLTSm (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 15:18:42 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:43664 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752932AbeDLTSl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Apr 2018 15:18:41 -0400
X-Google-Smtp-Source: AIpwx4+574/WPRz8y1CNrv8V2luHZi7NOgKd7Sdc27Ad1xlgLlSSO42z6Atyu+mQiDzNIqQbE7oXzdJa+CJHpZ98wPw=
MIME-Version: 1.0
In-Reply-To: <13801e2a-c44d-e940-f872-890a0612a483@nvidia.com>
References: <20180412153941.170849-1-jannh@google.com> <b617740b-fd07-e248-2ba0-9e99b0240594@nvidia.com>
 <CAKgNAkgcJ2kCTff0=7=D3zPFwpJt-9EM8yis6-4qDjfvvb8ukw@mail.gmail.com>
 <CAG48ez2NtCr8+HqnKJTFBcLW+kCKUa=2pz=7HD9p9u1p-MfJqw@mail.gmail.com> <13801e2a-c44d-e940-f872-890a0612a483@nvidia.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 12 Apr 2018 21:18:19 +0200
Message-ID: <CAG48ez085cASur3kZTRkdJY20dFZ4Yqc1KVOHxnCAn58_NtW8w@mail.gmail.com>
Subject: Re: [PATCH] mmap.2: MAP_FIXED is okay if the address range has been reserved
To: John Hubbard <jhubbard@nvidia.com>
Cc: Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
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

On Thu, Apr 12, 2018 at 8:59 PM, John Hubbard <jhubbard@nvidia.com> wrote:
> On 04/12/2018 11:49 AM, Jann Horn wrote:
>> On Thu, Apr 12, 2018 at 8:37 PM, Michael Kerrisk (man-pages)
>> <mtk.manpages@gmail.com> wrote:
>>> Hi John,
>>>
>>> On 12 April 2018 at 20:33, John Hubbard <jhubbard@nvidia.com> wrote:
>>>> On 04/12/2018 08:39 AM, Jann Horn wrote:
>>>>> Clarify that MAP_FIXED is appropriate if the specified address range has
>>>>> been reserved using an existing mapping, but shouldn't be used otherwise.
>>>>>
>>>>> Signed-off-by: Jann Horn <jannh@google.com>
>>>>> ---
>>>>>  man2/mmap.2 | 19 +++++++++++--------
>>>>>  1 file changed, 11 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/man2/mmap.2 b/man2/mmap.2
>> [...]
>>>>>  .IP
>>>>>  For example, suppose that thread A looks through
>>>>> @@ -284,13 +285,15 @@ and the PAM libraries
>>>>>  .UR http://www.linux-pam.org
>>>>>  .UE .
>>>>>  .IP
>>>>> -Newer kernels
>>>>> -(Linux 4.17 and later) have a
>>>>> +For cases in which the specified memory region has not been reserved using an
>>>>> +existing mapping, newer kernels (Linux 4.17 and later) provide an option
>>>>>  .B MAP_FIXED_NOREPLACE
>>>>> -option that avoids the corruption problem; if available,
>>>>> -.B MAP_FIXED_NOREPLACE
>>>>> -should be preferred over
>>>>> -.BR MAP_FIXED .
>>>>> +that should be used instead; older kernels require the caller to use
>>>>> +.I addr
>>>>> +as a hint (without
>>>>> +.BR MAP_FIXED )
>>>>
>>>> Here, I got lost: the sentence suddenly jumps into explaining non-MAP_FIXED
>>>> behavior, in the MAP_FIXED section. Maybe if you break up the sentence, and
>>>> possibly omit non-MAP_FIXED discussion, it will help.
>>>
>>> Hmmm -- true. That piece could be a little clearer.
>>
>> How about something like this?
>>
>>               For  cases in which MAP_FIXED can not be used because
>> the specified memory
>>               region has not been reserved using an existing mapping,
>> newer kernels
>>               (Linux  4.17  and  later)  provide  an  option
>> MAP_FIXED_NOREPLACE  that
>>               should  be  used  instead. Older kernels require the
>>               caller to use addr as a hint and take appropriate action if
>>               the kernel places the new mapping at a different address.
>>
>> John, Michael, what do you think?
>
>
> I'm still having difficulty with it, because this is in the MAP_FIXED section,
> but I think you're documenting the behavior that you get if you do *not*
> specify MAP_FIXED, right? Also, the hint behavior is true of both older and
> new kernels...

The manpage patch you and mhocko wrote mentioned MAP_FIXED_NOREPLACE
in the MAP_FIXED section - I was trying to avoid undoing a change you
had just explicitly made.

> So, if that's your intent (you want to sort of document by contrast to what
> would happen if this option were not used), then how about something like this:
>
>
> Without the MAP_FIXED option, the kernel would treat addr as a hint, rather
> than a requirement, and the caller would need to take appropriate action
> if the kernel placed the mapping at a different address. (For example,
> munmap and try again.)

I'd be fine with removing the paragraph. As you rightly pointed out,
it doesn't really describe MAP_FIXED.
