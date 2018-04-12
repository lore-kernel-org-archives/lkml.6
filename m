Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1658150-1523559004-2-2127916096558273323
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
    1523559003; b=VEZKgYwWp0vGnMQXEKr2qwYGTO6aUhA1nlnCWsDnp8OtJSMZA3
    dzV7TBNglImN2+qPXMaKoMKdQntoPLuwPk01FTqBA4q4PRL+L3LHZ7CgSuNeRnz0
    i6x7vVWWZtYIcUsiqKD2Mna+v7FtVGwfgHchSSNwi+EuJWxfAyomxrDPIoJl3bca
    wsJDBu6xsgeEAk4Ir6ou5kuzdj7ckWZ7MXolIc1FVBPwBAKyeII80luzQjNVKJ9A
    V6E/D/td8tKB4+2pX74SqBiXfFCeZLGCVjcNQuGAJdBTXhOFUQfCEP90Ym7wFJV2
    PSNQ0EzN4iNBw2K5insjHsM2TeMp+lhAt+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523559003; bh=50xuFyI7FyNJUU2Hg3P3Fb5iiN2fziFlJ/3FcqJzWQ
    A=; b=GtRGg9kuiyYSrS6Z2h3V/U2nEYt1qgva55fHzh8ibKni228EQLylaIbCKx
    nQ0gRP5XegMPutZ9U4hq9unbc2/TUHDmr8PyfjavdNiudqClngDxMsGD8Jq81EAw
    r89rju4hHjrKw6ZVX1xiVy8vC96WDpTRU6Eg4LTjXmsROeGJfuaQo6NiV/YP/CId
    xV5H94rjXGLeRCcCUtoyd9p6E07iXLHuKoUmrIDfsF3W8T1AI+57ugCuU8CXgx5u
    K2UjEKr1a5lNjEoOlbHtOEe9yk/keAH1LGrI/WnL2sjX6ZbYt5w5S6uRarh77OrY
    Ok7Z4cFYmYhBL2Vd570Ysdq7p2mA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=SEasxir1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NFlH6S21;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=SEasxir1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NFlH6S21;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMSKGEgE6BQBI48xso27ZETxU3cO8wfXgsPw+dr7iAzXkyNjADn/2mLB3rGbb9ZoDRFfFrumNjs+Bn2SBp5hQihwIW4mnuoN+Ymd7tP8SS4Bke1w9IL0
    SVLmAK0I/VA44WMkiD0wEXWcH7IECmIDXW3PkfxYhRP9Zg8zHy2NP7TZ5eAswrQpi4Z8YlzoKTHMdWAwRDNVXCj1OpVS74/zM2gMXYXWste/sVtMtNxzydTZ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=Ikd4Dj_1AAAA:8 a=1XWaLZrsAAAA:8 a=Sg8HuZxHAAAA:8
    a=VwQbUJbxAAAA:8 a=uxYdl9PFboSCzQhIakYA:9 a=E_X8TmyeoSPGMasm:21
    a=jkdwGB8dFRpI3gFR:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=JFlNBosjgyz61O-hmi61:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753340AbeDLSuB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 14:50:01 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:39761 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752920AbeDLSuA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Apr 2018 14:50:00 -0400
X-Google-Smtp-Source: AIpwx4/qGoEE6uqWy4L5Srzc8cxl6a9i/bn0yLHxVVspFN5qe8o9PMJ3lg7VdfgIpj9L4nuVDdYsyyA8qAs9ttBqKbI=
MIME-Version: 1.0
In-Reply-To: <CAKgNAkgcJ2kCTff0=7=D3zPFwpJt-9EM8yis6-4qDjfvvb8ukw@mail.gmail.com>
References: <20180412153941.170849-1-jannh@google.com> <b617740b-fd07-e248-2ba0-9e99b0240594@nvidia.com>
 <CAKgNAkgcJ2kCTff0=7=D3zPFwpJt-9EM8yis6-4qDjfvvb8ukw@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 12 Apr 2018 20:49:38 +0200
Message-ID: <CAG48ez2NtCr8+HqnKJTFBcLW+kCKUa=2pz=7HD9p9u1p-MfJqw@mail.gmail.com>
Subject: Re: [PATCH] mmap.2: MAP_FIXED is okay if the address range has been reserved
To: Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>
Cc: linux-man <linux-man@vger.kernel.org>,
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

On Thu, Apr 12, 2018 at 8:37 PM, Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
> Hi John,
>
> On 12 April 2018 at 20:33, John Hubbard <jhubbard@nvidia.com> wrote:
>> On 04/12/2018 08:39 AM, Jann Horn wrote:
>>> Clarify that MAP_FIXED is appropriate if the specified address range has
>>> been reserved using an existing mapping, but shouldn't be used otherwise.
>>>
>>> Signed-off-by: Jann Horn <jannh@google.com>
>>> ---
>>>  man2/mmap.2 | 19 +++++++++++--------
>>>  1 file changed, 11 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/man2/mmap.2 b/man2/mmap.2
[...]
>>>  .IP
>>>  For example, suppose that thread A looks through
>>> @@ -284,13 +285,15 @@ and the PAM libraries
>>>  .UR http://www.linux-pam.org
>>>  .UE .
>>>  .IP
>>> -Newer kernels
>>> -(Linux 4.17 and later) have a
>>> +For cases in which the specified memory region has not been reserved using an
>>> +existing mapping, newer kernels (Linux 4.17 and later) provide an option
>>>  .B MAP_FIXED_NOREPLACE
>>> -option that avoids the corruption problem; if available,
>>> -.B MAP_FIXED_NOREPLACE
>>> -should be preferred over
>>> -.BR MAP_FIXED .
>>> +that should be used instead; older kernels require the caller to use
>>> +.I addr
>>> +as a hint (without
>>> +.BR MAP_FIXED )
>>
>> Here, I got lost: the sentence suddenly jumps into explaining non-MAP_FIXED
>> behavior, in the MAP_FIXED section. Maybe if you break up the sentence, and
>> possibly omit non-MAP_FIXED discussion, it will help.
>
> Hmmm -- true. That piece could be a little clearer.

How about something like this?

              For  cases in which MAP_FIXED can not be used because
the specified memory
              region has not been reserved using an existing mapping,
newer kernels
              (Linux  4.17  and  later)  provide  an  option
MAP_FIXED_NOREPLACE  that
              should  be  used  instead. Older kernels require the
              caller to use addr as a hint and take appropriate action if
              the kernel places the new mapping at a different address.

John, Michael, what do you think?

> Jann, I've already pushed the existing patch. Do you want to add a patch on top?
