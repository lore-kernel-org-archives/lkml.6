Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-125656-1518532243-5-6553953823198050012
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
    t=1518532243; b=g5fkE0GxHXSXo5tSzeqOsNa9OYNZB7sCxHcm0hqtR8MOSHO
    uNrA5rfzXlWIujjbmyMkTcwUoMZSoVJofSVjImByaIVB6JiA+mvcekIotms5oc7N
    s3PMN0YaUb4UuQxBK1xDeWYghpb4KeFlHkE3vvXAYOHr/MlvJcmavo4vaelZfUTN
    tp38Y3gGUVcSD6B6eXvtckbBLrSV5uNu6ArgqLoY+REAL6VtKbSGsb6vi/UpiRqb
    YeQSIaTEPQTOIdO7evPVnTzFebHHR5TZ9IZ32ZFIPbfdJu/KbAGwC0JyGSlEFsKI
    cuu21kF7vXvsCTTyYH88LU//kzRGR/bw5fWltCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518532243; bh=hO25m5eFxQJcKfEiPcgEfm4Bd00iesKM3Ls5xB6hRRQ=; b=Z
    UTyocQOqda0w4vtBwQZ7DeKWn9VLgjHhxOf6wOPvt79sf08iRRgAuWpOLdB1ILo6
    45YcuDa4bzeCFjSg1hojPqnMm+yptuC4JrYgpqP5LZDG6W2RNXKI5nMcxCz47Dgi
    YxktmWlYSiqvYjCbtPlOtkQn6xSe8taMamMbXWOoAKsLKo26QGJLuWrx+EDXsfvS
    p38d1w+DoaQJJLXw5J1MffBPvwvUBQcGFvNvTM/NCYuREdpcBvWThRUWBdxttrMr
    kv7Bl38qFpi56tZ19PxnuUJc3YYJnkTzdEzpSxO4MS6pO8ELEDoS2VRQ4DeMg/Qn
    VpR7XGu+NxjLWUD3+HViQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Wdzhl7R0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JkN49uuP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Wdzhl7R0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JkN49uuP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933651AbeBMOak (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 09:30:40 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33285 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933612AbeBMOaj (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Feb 2018 09:30:39 -0500
X-Google-Smtp-Source: AH8x227ni7nobeV0r4wAlcBJV6/jjLvskzvBhSDKJOXaK33Fs1ogtbcets8AYDpovPjAmxq2YYanbw==
Subject: Re: [PATCH 4.9 00/92] 4.9.81-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180209133931.211869118@linuxfoundation.org>
 <556ea00b-e265-7f14-395c-c5e6629bf194@roeck-us.net>
 <20180213093651.GA29675@kroah.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <7c1ed8b1-bd9c-4b9f-051b-f9f19591cdbb@roeck-us.net>
Date: Tue, 13 Feb 2018 06:30:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180213093651.GA29675@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/13/2018 01:36 AM, Greg Kroah-Hartman wrote:
> On Sat, Feb 10, 2018 at 07:46:50AM -0800, Guenter Roeck wrote:
>> On 02/09/2018 05:38 AM, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 4.9.81 release.
>>> There are 92 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Sun Feb 11 13:39:04 UTC 2018.
>>> Anything received after that time might be too late.
>>>
>>
>> Build results:
>> 	total: 145 pass: 140 fail: 5
>> Failed builds:
>> 	powerpc:defconfig
>> 	powerpc:allmodconfig
>> 	powerpc:ppc64e_defconfig
>> 	powerpc:cell_defconfig
>> 	powerpc:maple_defconfig
>> Qemu test results:
>> 	total: 118 pass: 113 fail: 5
>> Failed tests:
>> 	powerpc:mac99:ppc64_book3s_defconfig:nosmp
>> 	powerpc:mac99:ppc64_book3s_defconfig:smp4
>> 	powerpc:pseries:pseries_defconfig
>> 	powerpc:mpc8544ds:ppc64_e5500_defconfig:nosmp
>> 	powerpc:mpc8544ds:ppc64_e5500_defconfig:smp
>>
>> All builds and tests fail with the following error.
>>
>> arch/powerpc/kernel/setup_64.c:41:25: fatal error: asm/debugfs.h: No such file or directory
>>
>> For older kernels, the backport of 236003e6b5443c4 ("powerpc/64s: Allow control of RFI
>> flush via debugfs") should include linux/debugfs.h, not asm/debugfs.h.
> 
> Thanks for letting me know, I've now fixed this up.  Will go work on the
> 4.4 patch as well.
> 

Unfortunately it wasn't the only problem. Now we have:

arch/powerpc/kernel/entry_64.S: Assembler messages:
arch/powerpc/kernel/entry_64.S:260: Error: unrecognized opcode: `rfi_to_user'
arch/powerpc/kernel/entry_64.S:270: Error: unrecognized opcode: `rfi_to_kernel'
arch/powerpc/kernel/entry_64.S:885: Error: unrecognized opcode: `rfi_to_user'
arch/powerpc/kernel/entry_64.S:900: Error: unrecognized opcode: `rfi_to_kernel'

Looks like 222f20f140623 ("powerpc/64s: Simple RFI macro conversions") is missing,
or at least part of it. Unfortunately it doesn't apply cleanly.

4.4 also now has a different failure.

In file included from drivers/staging/rdma/ehca/hcp_if.c:45:0:
arch/powerpc/include/asm/hvcall.h:439:2: error: unknown type name 'u64'
   u64 character;
   ^
arch/powerpc/include/asm/hvcall.h:440:2: error: unknown type name 'u64'
   u64 behaviour;

You'll need 1b689a95ce742 to fix that problem.

Guenter
