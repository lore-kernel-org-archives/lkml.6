Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3312372-1518888966-2-5180378917112893242
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518888965; b=fYP8scz5c/wAaf5jKPGXWSrQlLoXEJxuYCRQ4xQUgkQiQH2
    fj6oTOxtzuHBbXOE2FR0MlbSYYLJJuzCt8EMDEeYXNzkJTD0JU6jaFyICql08Z+u
    OFqM0XvuIt4Q8k6g+t26ajt/5Fkrmgcjyv7y7XFturO4DHcg1ePF9uG/0G1lyLYe
    8GJrt2HD/CdBMAV/oRDaiUQ6PZZX38iBm8ZpHERCJF1IbPKb7O8Keu5W7Lv/XsVY
    m1WOStrbQsueG70stFzbo2XDD24u49sOf9MwNWFCx15+FFW9d9ZhnaFjbtIR0g8F
    9DMO878gOk6m2BwUZ94JtwtPuMRqi6E8vB1BIVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518888965; bh=yy2/RxtmEmZ8+BA29RAIrWGUeiTt+VJxuzlJbfqMwWU=; b=G
    oVGvvk1e68F9XPvWC7IYeJGtvrXXS4Pr1sPzdQtulI4SroCdUok5OQLG8cfIKbu3
    vMaemrJ3NY+Kt9Vo/e8/DVBRqrY1SQzXunJkEKwV6XFJWju7G1vkgTo7RrxKc14f
    xJTZuTa0u40WjWD835UroBmtTqTC9Whiv7idnPw2p5DecTy5ZrFAdNF52IJwob1v
    J2A1l0WqKKHhanB017YOTAk17AgbQa8/IiZxJEYhstO9jfl319qzjI/jYHIZugiZ
    tgluEG+RMhP/E51b8xZ0hspZh3xTlnlgdeYbIz3U0sHPCyBnjrm03mPgI0CaAuUy
    LnXufPQTQNSPLdPERMsdg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=eQP1npk8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CuD9IiZX;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=eQP1npk8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CuD9IiZX;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751106AbeBQRgE (ORCPT <rfc822;greg@kroah.com>);
        Sat, 17 Feb 2018 12:36:04 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35114 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbeBQRgD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Feb 2018 12:36:03 -0500
X-Google-Smtp-Source: AH8x226zyNbiLKgBGgfuAb4fJkhdUSSvbe4r5JI+fHC2N+E8a8XiidAUz7miPz9Wj97suV23Uq6YUg==
Subject: Re: [PATCH 4.9 00/92] 4.9.81-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yves-Alexis Perez <corsac@debian.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180209133931.211869118@linuxfoundation.org>
 <556ea00b-e265-7f14-395c-c5e6629bf194@roeck-us.net>
 <20180213093651.GA29675@kroah.com>
 <7c1ed8b1-bd9c-4b9f-051b-f9f19591cdbb@roeck-us.net>
 <20180213152907.GA29190@kroah.com> <1518874313.9465.1.camel@debian.org>
 <20180217134556.GC28145@kroah.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <3075ec06-df9e-3532-82fa-cb2ca227c86b@roeck-us.net>
Date: Sat, 17 Feb 2018 09:35:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180217134556.GC28145@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/17/2018 05:45 AM, Greg Kroah-Hartman wrote:
> On Sat, Feb 17, 2018 at 02:31:53PM +0100, Yves-Alexis Perez wrote:
>> On Tue, 2018-02-13 at 16:29 +0100, Greg Kroah-Hartman wrote:
>>>> arch/powerpc/kernel/entry_64.S: Assembler messages:
>>>> arch/powerpc/kernel/entry_64.S:260: Error: unrecognized opcode: `rfi_to_user'
>>>> arch/powerpc/kernel/entry_64.S:270: Error: unrecognized opcode: `rfi_to_kernel'
>>>> arch/powerpc/kernel/entry_64.S:885: Error: unrecognized opcode: `rfi_to_user'
>>>> arch/powerpc/kernel/entry_64.S:900: Error: unrecognized opcode: `rfi_to_kernel'
>>>>
>>>> Looks like 222f20f140623 ("powerpc/64s: Simple RFI macro conversions") is missing,
>>>> or at least part of it. Unfortunately it doesn't apply cleanly.
>>>
>>> Ugh.  Let's see if the ppc developers care about this or not :)
>>
>> Hi,
>>
>> in Debian we extracted the following hunk from 222f20f140623 to fix build on
>> powerpc/ppc64el. Only compile tested against Debian builds though.
>>
>> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
>> index 3320bcac7192..e68faa4d1b13 100644
>> --- a/arch/powerpc/kernel/entry_64.S
>> +++ b/arch/powerpc/kernel/entry_64.S
>> @@ -37,6 +37,11 @@
>>   #include <asm/tm.h>
>>   #include <asm/ppc-opcode.h>
>>   #include <asm/export.h>
>> +#ifdef CONFIG_PPC_BOOK3S
>> +#include <asm/exception-64s.h>
>> +#else
>> +#include <asm/exception-64e.h>
>> +#endif
>>   
> 
> Ah, thanks!  I've now queued up this portion of the patch.
> 

Hmm, that chunk really doesn't do what the original patch is supposed to do,
meaning it won't provide the vulnerability protection it is supposed to provide
(AFAICS that is Meltdown). Just a note in case anyone is concerned about
actually providing that protection.

Guenter
