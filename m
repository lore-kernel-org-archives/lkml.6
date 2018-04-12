Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-382606-1523520562-2-8877457530906858881
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
    1523520561; b=D0a047W2FXtGxrctOFiooNR8TGXtus1Uk4akHm61CpVe8GE6h/
    ONOWlbjuE3UXoa6K0nsnwX7aPcvwfcnZnEcZl5GcP0zegHENvQHsHFzx7FDq6Vyh
    dWajPyvMAdsV9wpd49IjG5vwIrFsxPscl7iK0uONKZB1QBLA/WSwsnU4bJkPZjFv
    T38p8OqZWcN2S7igE32cHeq5lW53WYwi97i4IKDXw49J9U9qWk4+UgPknmyYcdGI
    mDOb3r0h4gSTAgGgP0O7mwras2XGWMv1+7q5+YgbUIc8Rvo3BuT+2U8obxml11zV
    x2F8SdscSVf/fHxaUuNkvEm+fJsC2pGRb+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=cc:subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523520561;
    bh=HbXnMXZvYMrhsU2Xdhl0TYtsNUdNTp9XkXzNCVy1R+M=; b=DOoY/saFFc6f
    7mNq8cx6zVnDOcV9l9j773CmuJAtCL2PSsucui04alh9U0y/KO0vi9bsKmE7CJBO
    +QUjfV0qWhNY38evjKk9ZHgz4cLncjcZ5jbyMWh6Ua1qUxmyxq6DjGQedUqcCk8e
    y2wIqYALYjARkkNOaIAgzf87L8ZrOpqt24UeUEQ79dSjTPHtLLzhDa7DJuX8bDaQ
    ghL3u/1YAjuNva3xd9Cme/kfR0/beCLhn0CmdQbkvP57stV1iiYhuw4Ulo9GCcJ3
    IrnSWNLjQ9SnFK/7c2hJp4bPs/8ikSy/6mJsBInQhsZtse5CpTcP7Rry6bV6O4s/
    JYBhSI3yuA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=j90HxZKZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fz0/Nt+5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=j90HxZKZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fz0/Nt+5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJGZAfBtnVkWATxB+olsPPx1OkRj5QRloawusgOyPWoEHIlPhSNowKX7ElllcQKnn49l6g5LkGqM+mVOMSDuAGoVS1ad7knZ5H9suZkFwUxeo1f5UdhE
    PLpBzCfY9ss2w50LH6YXCbdSWh1Q3F67Zl2HHKYDOsQwP85YoGZ9VYsC+uNQftQQvJV99aggbfIcYc7FJDYuIOho5TJVgnGCjOqR8jBwLq5zUAFh+pX3LKVb
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=ZvkwkgPurpcA:10 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
    a=Ikd4Dj_1AAAA:8 a=Sg8HuZxHAAAA:8 a=GcyzOjIWAAAA:8 a=thEeCv7x7hXpAkS5bhIA:9
    a=3X4KhXTNA_8NXt6p:21 a=mxm9TLRlXUWDhzmi:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
    a=JFlNBosjgyz61O-hmi61:22 a=hQL3dl6oAZ8NdCsdz28n:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753070AbeDLIJT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 04:09:19 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52778 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753027AbeDLIJR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Apr 2018 04:09:17 -0400
X-Google-Smtp-Source: AIpwx49J+2Bf/tS9+V0+LkLkjEohbpM4w1+AW3UDBxszVCuETiR9T0jy1YvAhH6fI9gfKQnO5fDffg==
Cc: mtk.manpages@gmail.com, John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mmap.2: document new MAP_FIXED_NOREPLACE flag
To: Jann Horn <jannh@google.com>, Michal Hocko <mhocko@kernel.org>
References: <20180411120452.1736-1-mhocko@kernel.org>
 <CAG48ez3BS5EtnrhFQUGYY9MKGOUHzFbhauJQd361uTwy2pBEeg@mail.gmail.com>
 <20180411163631.GL23400@dhcp22.suse.cz>
 <CAG48ez2wYqxJEHgZCz5g6ZYBY4_qDcYWSGAErC8pUzmrW62rug@mail.gmail.com>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <b5060a37-f33d-2e5b-5438-ed46e7740aa6@gmail.com>
Date: Thu, 12 Apr 2018 10:09:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez2wYqxJEHgZCz5g6ZYBY4_qDcYWSGAErC8pUzmrW62rug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/11/2018 06:40 PM, Jann Horn wrote:
> On Wed, Apr 11, 2018 at 6:36 PM, Michal Hocko <mhocko@kernel.org> wrote:
>> On Wed 11-04-18 17:37:46, Jann Horn wrote:
>>> On Wed, Apr 11, 2018 at 2:04 PM,  <mhocko@kernel.org> wrote:
>>>> From: Michal Hocko <mhocko@suse.com>
>>>>
>>>> 4.17+ kernels offer a new MAP_FIXED_NOREPLACE flag which allows the caller to
>>>> atomicaly probe for a given address range.
>>>>
>>>> [wording heavily updated by John Hubbard <jhubbard@nvidia.com>]
>>>> Signed-off-by: Michal Hocko <mhocko@suse.com>
>>>> ---
>>>> Hi,
>>>> Andrew's sent the MAP_FIXED_NOREPLACE to Linus for the upcoming merge
>>>> window. So here we go with the man page update.
>>>>
>>>>  man2/mmap.2 | 27 +++++++++++++++++++++++++++
>>>>  1 file changed, 27 insertions(+)
>>>>
>>>> diff --git a/man2/mmap.2 b/man2/mmap.2
>>>> index ea64eb8f0dcc..f702f3e4eba2 100644
>>>> --- a/man2/mmap.2
>>>> +++ b/man2/mmap.2
>>>> @@ -261,6 +261,27 @@ Examples include
>>>>  and the PAM libraries
>>>>  .UR http://www.linux-pam.org
>>>>  .UE .
>>>> +Newer kernels
>>>> +(Linux 4.17 and later) have a
>>>> +.B MAP_FIXED_NOREPLACE
>>>> +option that avoids the corruption problem; if available, MAP_FIXED_NOREPLACE
>>>> +should be preferred over MAP_FIXED.
>>>
>>> This still looks wrong to me. There are legitimate uses for MAP_FIXED,
>>> and for most users of MAP_FIXED that I'm aware of, MAP_FIXED_NOREPLACE
>>> wouldn't work while MAP_FIXED works perfectly well.
>>>
>>> MAP_FIXED is for when you have already reserved the targeted memory
>>> area using another VMA; MAP_FIXED_NOREPLACE is for when you haven't.
>>> Please don't make it sound as if MAP_FIXED is always wrong.
>>
>> Well, this was suggested by John. I think, nobody is objecting that
>> MAP_FIXED has legitimate usecases. The above text just follows up on
>> the previous section which emphasises the potential memory corruption
>> problems and it suggests that a new flag is safe with that regards.
>>
>> If you have specific wording that would be better I am open for changes.
> 
> I guess I'd probably also want to change the previous text; so I
> should probably send a followup patch once this one has landed.
> 
>>>> +.TP
>>>> +.BR MAP_FIXED_NOREPLACE " (since Linux 4.17)"
>>>> +Similar to MAP_FIXED with respect to the
>>>> +.I
>>>> +addr
>>>> +enforcement, but different in that MAP_FIXED_NOREPLACE never clobbers a pre-existing
>>>> +mapped range. If the requested range would collide with an existing
>>>> +mapping, then this call fails with
>>>> +.B EEXIST.
>>>> +This flag can therefore be used as a way to atomically (with respect to other
>>>> +threads) attempt to map an address range: one thread will succeed; all others
>>>> +will report failure. Please note that older kernels which do not recognize this
>>>> +flag will typically (upon detecting a collision with a pre-existing mapping)
>>>> +fall back to a "non-MAP_FIXED" type of behavior: they will return an address that
>>>> +is different than the requested one. Therefore, backward-compatible software
>>>> +should check the returned address against the requested address.
>>>>  .TP
>>>>  .B MAP_GROWSDOWN
>>>>  This flag is used for stacks.
>>>> @@ -487,6 +508,12 @@ is not a valid file descriptor (and
>>>>  .B MAP_ANONYMOUS
>>>>  was not set).
>>>>  .TP
>>>> +.B EEXIST
>>>> +range covered by
>>>> +.IR addr ,
>>>> +.IR length
>>>> +is clashing with an existing mapping.
>>>
>>> Maybe add something like ", and MAP_FIXED_NOREPLACE was specified"? I
>>> think most manpages explicitly document which error conditions can be
>>> triggered by which flags.
>>
>> sure, no objection from me.

I've added the suggested piece from Jann to the EEXIST error description.

Cheers,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
