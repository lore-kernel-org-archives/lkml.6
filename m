Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-382606-1523520624-2-1600093034843573230
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
    1523520624; b=mecnK+uVoHLsdoOGNFvUElYAxL/cjokXL+NfLeiav2h7XDc4f7
    7nORKfuHEFle1D6xuQ7rSwQl72MzENp4KDOa4FHkSZ11xY1/J5UGpabvzWTMehMl
    DbdH9odmyJZNOFm99QgfZJdbh3MN9xhRIS6khkRpictYErkoPBKG09Z4N56pRUCn
    ejMCnHnSvP95j4CPyzvJKa9tBsONDAusS77txjU0UsK5zL622PJyfWXY7+ydpSMx
    sF5nh20s0c3CawdeYgr9ui9VdKwQIJhJ7UjTuBrgUhePh6YmV+5BiEdZsK8B4fS8
    fxeQtyzldBJnl8ev+4IOCefEfxhGSaEPckBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=cc:subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523520624;
    bh=fa4C219qkY/fMc8Ztgjg+YzwT9E24to6lsDlyI0GrQk=; b=RWfPo64ukQln
    VNY/wEY3koewyM6pIcTNKeb7XV/g4z2dhFWO+G+JXUMPnT+Xv5y39FA0/aFoJ/2a
    xRU2g2YAumfNb6fUYH7cdE8Is9iV5wvla+jv7sds9PiEev6R2JfH0GoGJijy8k8t
    dpwKALFkDjpvZpJ1+vGZ9IXlUawq0wUNJgDEY8EUE2F03429BPTgwajegvP6rta6
    ILcSLCydDLVWDgfIH2PJn0o9cZnCYEblem/pbZpYg7d7wul+0j4PqsBsYuwjGj2s
    9hGcGTgTkuuWXkmIYjempE9C0phh5f1EXPMluz+KJe4Hd36PnQENvl4yL2Gmav7A
    akmB2osMAQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=slcDXr1s x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=t3hyAUuq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=slcDXr1s x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=t3hyAUuq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNbwckdU6aVHbzH445uOmRTNn/E/yLTv7vMUqUo48IDJ0w8WNCzd8sTdHNPeNv9NBPcp9L5V0XoRt4OXSRka40EjoUj9GiQ20kCzOnY+J45TLybhoE/e
    W/WYNQ+tfWOSNmKCW1Jyx1/UQ3Gm/nmScEFmw4I0d5XdrS47CYYST8neORzlC/8+iDsx3NrcGyvnZpckSUxgupVfq/Z6KS3alGBNugu+lqP3z4zmc15wSRjl
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=ZvkwkgPurpcA:10 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
    a=Ikd4Dj_1AAAA:8 a=Sg8HuZxHAAAA:8 a=GcyzOjIWAAAA:8 a=4WC7gtXgC1qSHjYw5LEA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=JFlNBosjgyz61O-hmi61:22 a=hQL3dl6oAZ8NdCsdz28n:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbeDLIKV (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 04:10:21 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50894 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbeDLIKU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Apr 2018 04:10:20 -0400
X-Google-Smtp-Source: AIpwx48kl63tqipICwz8/efqZDShrjPkTjSUGTIP8KWAIT8rWoIfWBEW/5IDf2I+78AIj1jdV3G/LQ==
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
Message-ID: <6c2df5a8-b33a-915f-f220-da9a6ad08049@gmail.com>
Date: Thu, 12 Apr 2018 10:10:18 +0200
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

Hi Jann,

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
Okay -- I'm ready to take that piece now. Please send me a patch!

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
