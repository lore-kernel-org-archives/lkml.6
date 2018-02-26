Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3025739-1519655561-5-16956824512381917941
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519655561; b=JUBnq7SPICcTmdbZXz3/Db7SzWLh37WobHRQ8rWcU6kSTY8
    /Bsjv4B47FcemcaTFCLQCuBP0SIi2xu13SHZ2x7ABuiXvLjSNuuUrv8MUfea8AtA
    Cze59kPIwch5jcJckg7SX6WXK8TBHU8DPp2nM0EJFklCWqHYKZtmdRwHlRlrYBX1
    0dU5f/8qBObnWzoFfXUw6BlavT0n6yg9aiw3O6qEtvE8RAPUUPrKH1xlAQPi5gS1
    OZGp3PYt2i1oh+lanTW3EufGf4rIoH6A64fTkZgGpOx7Dhb7wYPjJru1ykZWfjMa
    v8MPGzMJjTHXyYXelSRDJfLD6SXuukZXeG/EmtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519655561; bh=cw8VBtlOzXPm9WnYFF+KSICC9G5+kyHPrUKNWqrmg9k=; b=n
    8/ARMItVTo45RIyxql+R+QtJ1qXNhxqGj72QBjv3bFx4+qBnhcZy3carerfWYyX4
    TIIw2pSDoF8AKVa5MAZI21CDrYIncKft+G3w+YsoxCcCfJiZ+xzLADAjSS83wE1h
    JBFUPHEeaN1g3nPqI5YnAcSUEROy+cPBsr+0t07TCGcXW/NR3kGy8cmShnLYKCAI
    uo1iASIRRjZ9LY6vLi9b8r17HYCa4h9JJRT+MVs0g7kdyrY1+gGpUy8ZPDBrbaG5
    mtk0Su/j46/sZo62B40LTrpdpiHfeqnk38u13U9Tngro4AUMCfKJGfamVK27WIkY
    qf3ScYeXq2UBiFKKIIC0Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=bY/6/6EM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GLoDnNYx;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=bY/6/6EM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GLoDnNYx;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753366AbeBZOch (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 09:32:37 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43141 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753277AbeBZOcg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 09:32:36 -0500
X-Google-Smtp-Source: AH8x225UeRVmj8UPyciywW7JxChMycqERkGo5aNVNjBLZ6eThrEyvEG1uxSnDqA84Sd8h6AtFWCZUQ==
Subject: Re: [PATCH v5 2/9] watchdog/hpwdt: Remove legacy NMI sourcing.
To: Arnd Bergmann <arnd@arndb.de>,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rwright@hpe.com, maurice.a.saldivar@hpe.com,
        Ingo Molnar <mingo@kernel.org>, marcus.folkesson@gmail.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        stable <stable@vger.kernel.org>
References: <20180226032227.14615-1-jerry.hoemann@hpe.com>
 <20180226032227.14615-3-jerry.hoemann@hpe.com>
 <CAK8P3a1A5d52g-3Wgs1xP3P=dT6K0RVjmamfqAi9vE5TT=mo3g@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <03b13d44-9ce3-ead8-020d-4b1b8114079d@roeck-us.net>
Date: Mon, 26 Feb 2018 06:32:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1A5d52g-3Wgs1xP3P=dT6K0RVjmamfqAi9vE5TT=mo3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/26/2018 06:11 AM, Arnd Bergmann wrote:
> On Mon, Feb 26, 2018 at 4:22 AM, Jerry Hoemann <jerry.hoemann@hpe.com> wrote:
>> Gen8 and prior Proliant systems supported the "CRU" interface
>> to firmware.  This interfaces allows linux to "call back" into firmware
>> to source the cause of an NMI.  This feature isn't fully utilized
>> as the actual source of the NMI isn't printed, the driver only
>> indicates that the source couldn't be determined when the call
>> fails.
>>
>> With the advent of Gen9, iCRU replaces the CRU. The call back
>> feature is no longer available in firmware.  To be compatible and
>> not attempt to call back into firmware on system not supporting CRU,
>> the SMBIOS table is consulted to determine if it is safe to
>> make the call back or not.
>>
>> This results in about half of the driver code being devoted
>> to either making CRU calls or determing if it is safe to make
>> CRU calls.  As noted, the driver isn't really using the results of
>> the CRU calls.
>>
>> Furthermore, as a consequence of the Spectre security issue, the
>> BIOS/EFI calls are being wrapped into Spectre-disabling section.
>> Removing the call back in hpwdt_pretimeout assists in this effort.
>>
>> As the CRU sourcing of the NMI isn't required for handling the
>> NMI and there are security concerns with making the call back, remove
>> the legacy (pre Gen9) NMI sourcing and the DMI code to determine if
>> the system had the CRU interface.
>>
>> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> 
> This avoids a warning in mainline kernels, so that's great:
> 
> drivers/watchdog/hpwdt.o: warning: objtool: .text+0x24: indirect call
> found in RETPOLINE build
> 
> I wonder what we do about stable kernels. Are both this patch and the patch
> that added the objtool warning message candidates for backports to
> stable kernels?
> 

Makes sense to me, but it is really a bit more than a bug fix, so I'll
leave it up to Jerry/HPE to make the call in respect to hpwdt.

Guenter
