Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1684311-1523561095-2-18435870653357888512
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523561094; b=XD5KPI40bjbinCuF4ZUUAlGXcOBV5uOeffwkN509UF3/dxwv9q
    8ZxS+TwpZkm5sy3p0bMk2/t7XR7i+so/OABgcCDMN1mSk730TLh6GGuFGnh6o6pV
    YTGtVee/GIC8oy7BURLBgKK5W1vqQoLYOkRzZj54edLlwXf3DVhZqvc22oH89uPr
    uSVR73L8cIVR74kilJ9AyZJjqXnv2AgAeeGMbSsHCnwcuplREed1sMPsV2f43fBv
    7IET8+UXvt8T0xl9UzPwT5/mm5rS44lmbtfgpfwY+b/YwgwYMmkSbx+rS7MzfX0M
    cc/QE8ew3Qhwq887k97hQ94TgBM4OrEzms9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523561094;
    bh=vhCbAR2bV7bzDdh4+vrR/wWIXGzlNbYQWm3xLu7ptKM=; b=sVu5fSEMlju1
    h/WZVfVfP0swAwANf//ozqlDRt5XRadyZ4okAeRvEd8EzwJr8E7kKy1L845WjrGp
    kvENqEyi6AflBx30EV8AVbQTohGBaJtuWtYnP1jYZS84eqUPADkPSRBMC15FjNWg
    +6GsfbVB53HTmJuqrK/DGkZCwdD3ihAQvR3io8I96QdqjHGn358uy/HJL2iScoVF
    0FIaNeOzjNHVaTbil/wtBYIUWeZsTetQ/GFWfbz8XQltWdFZjRw3rEg6pUB57Ivg
    JnzHKkj9Y3ud1YxCAqDHKADW9ThHTywyNr1tcQU8Z4G6S8uv7D5wdwVnEmwB566U
    Lk4Cvz+QSw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nvidia.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nvidia.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCgN1ZsFE/AIr0BDiUoAsRf3Ek/GOITWqoYt+IaBPu37QlLlQwiA6IMGKZz9gaXgXTrUfV15OoVdXzAVi9SsmcmYsLrAKjfO03azMdmj4nO6Akq+kJZh
    q5ek6yKyOulGCoSbcETY8w7ZuiDk3wqUwBYbeowXLW4FczWPMnUqrLnFZ1Em8SADZ9X62zMIeWQBlkoV8+4Am1bbwAcuNI9VaW+qje+Eg8nZvpO3RCLrzS6l
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=rbY5Hf1s5mkA:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=Ikd4Dj_1AAAA:8 a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8
    a=Sg8HuZxHAAAA:8 a=VwQbUJbxAAAA:8 a=2TWkvXE0TD25WgRkjDQA:9
    a=xqzKbYsv-bDv8J6G:21 a=k4wZ6CUKXIoRCk7W:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=JFlNBosjgyz61O-hmi61:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753281AbeDLTYj (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 15:24:39 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7677 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753279AbeDLTYh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Apr 2018 15:24:37 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 12 Apr 2018 12:24:27 -0700
Subject: Re: [PATCH] mmap.2: MAP_FIXED is okay if the address range has been
 reserved
To: Jann Horn <jannh@google.com>
CC: Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
References: <20180412153941.170849-1-jannh@google.com>
 <b617740b-fd07-e248-2ba0-9e99b0240594@nvidia.com>
 <CAKgNAkgcJ2kCTff0=7=D3zPFwpJt-9EM8yis6-4qDjfvvb8ukw@mail.gmail.com>
 <CAG48ez2NtCr8+HqnKJTFBcLW+kCKUa=2pz=7HD9p9u1p-MfJqw@mail.gmail.com>
 <13801e2a-c44d-e940-f872-890a0612a483@nvidia.com>
 <CAG48ez085cASur3kZTRkdJY20dFZ4Yqc1KVOHxnCAn58_NtW8w@mail.gmail.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <cfbbbe06-5e63-e43c-fb28-c5afef9e1e1d@nvidia.com>
Date: Thu, 12 Apr 2018 12:24:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez085cASur3kZTRkdJY20dFZ4Yqc1KVOHxnCAn58_NtW8w@mail.gmail.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/12/2018 12:18 PM, Jann Horn wrote:
> On Thu, Apr 12, 2018 at 8:59 PM, John Hubbard <jhubbard@nvidia.com> wrote:
>> On 04/12/2018 11:49 AM, Jann Horn wrote:
>>> On Thu, Apr 12, 2018 at 8:37 PM, Michael Kerrisk (man-pages)
>>> <mtk.manpages@gmail.com> wrote:
>>>> Hi John,
>>>>
>>>> On 12 April 2018 at 20:33, John Hubbard <jhubbard@nvidia.com> wrote:
>>>>> On 04/12/2018 08:39 AM, Jann Horn wrote:
>>>>>> Clarify that MAP_FIXED is appropriate if the specified address range has
>>>>>> been reserved using an existing mapping, but shouldn't be used otherwise.
>>>>>>
>>>>>> Signed-off-by: Jann Horn <jannh@google.com>
>>>>>> ---
>>>>>>  man2/mmap.2 | 19 +++++++++++--------
>>>>>>  1 file changed, 11 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/man2/mmap.2 b/man2/mmap.2
>>> [...]
>>>>>>  .IP
>>>>>>  For example, suppose that thread A looks through
>>>>>> @@ -284,13 +285,15 @@ and the PAM libraries
>>>>>>  .UR http://www.linux-pam.org
>>>>>>  .UE .
>>>>>>  .IP
>>>>>> -Newer kernels
>>>>>> -(Linux 4.17 and later) have a
>>>>>> +For cases in which the specified memory region has not been reserved using an
>>>>>> +existing mapping, newer kernels (Linux 4.17 and later) provide an option
>>>>>>  .B MAP_FIXED_NOREPLACE
>>>>>> -option that avoids the corruption problem; if available,
>>>>>> -.B MAP_FIXED_NOREPLACE
>>>>>> -should be preferred over
>>>>>> -.BR MAP_FIXED .
>>>>>> +that should be used instead; older kernels require the caller to use
>>>>>> +.I addr
>>>>>> +as a hint (without
>>>>>> +.BR MAP_FIXED )
>>>>>
>>>>> Here, I got lost: the sentence suddenly jumps into explaining non-MAP_FIXED
>>>>> behavior, in the MAP_FIXED section. Maybe if you break up the sentence, and
>>>>> possibly omit non-MAP_FIXED discussion, it will help.
>>>>
>>>> Hmmm -- true. That piece could be a little clearer.
>>>
>>> How about something like this?
>>>
>>>               For  cases in which MAP_FIXED can not be used because
>>> the specified memory
>>>               region has not been reserved using an existing mapping,
>>> newer kernels
>>>               (Linux  4.17  and  later)  provide  an  option
>>> MAP_FIXED_NOREPLACE  that
>>>               should  be  used  instead. Older kernels require the
>>>               caller to use addr as a hint and take appropriate action if
>>>               the kernel places the new mapping at a different address.
>>>
>>> John, Michael, what do you think?
>>
>>
>> I'm still having difficulty with it, because this is in the MAP_FIXED section,
>> but I think you're documenting the behavior that you get if you do *not*
>> specify MAP_FIXED, right? Also, the hint behavior is true of both older and
>> new kernels...
> 
> The manpage patch you and mhocko wrote mentioned MAP_FIXED_NOREPLACE
> in the MAP_FIXED section - I was trying to avoid undoing a change you
> had just explicitly made.

heh. So I've succeeding in getting my own wording removed, then? Progress! :)

> 
>> So, if that's your intent (you want to sort of document by contrast to what
>> would happen if this option were not used), then how about something like this:
>>
>>
>> Without the MAP_FIXED option, the kernel would treat addr as a hint, rather
>> than a requirement, and the caller would need to take appropriate action
>> if the kernel placed the mapping at a different address. (For example,
>> munmap and try again.)
> 
> I'd be fine with removing the paragraph. As you rightly pointed out,
> it doesn't really describe MAP_FIXED.
> 

OK, that's probably the simplest fix.

thanks,
-- 
John Hubbard
NVIDIA
