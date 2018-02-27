Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-124878-1519695015-2-16960624006241364265
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519695014; b=fWRoNJkNZd8IrRngMdunkdYSGS4yuDZnD51CpR6RvAxhXsJ
    mYFxcPDwYhMSrYQCnqIOJ9uuSu9nXm1Sa7p8Sb7KvT7cU3xscpbHfP883NM/7pV5
    O9AKtZAgFsfBpH5ShEA/6qz7UYJv9IyCu2cHDeC6Qf6ZDUON9xAtSrQbxvHPCyMb
    xP5amHlhVkAfjHsFG3F19nQnP8exmB9oWVkZOCSj8rZM/BaFPo5/NzKVX17qCH9R
    nKFpEUo89YYN0LC6/RyFp6ILvEqDfz3GA2U9GpJj1rwRnku/VSvUI238Z9cwJ9S9
    gP9eIumSEdVFQUzmqaCLri86HkKuJ+WgMFybvhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519695014; bh=smpyBdHV6WbsclIsWuucLPDtYOgwOiKUs2WLY3OTqh0=; b=P
    GXukYT1jf6QrHVbNgWtYyb8+sPo+GXwbTjTNz6Cn+eoTarDOrUPDgPVXM65kbTRW
    LhiyKpy/dgQyTHU53Sb0CWg4knWTMhVmv4qo139/jF6qBHHFqUZBDm9gG3oIJj/7
    bsAglBHQb5ut4bB4UWoKlzXTriweEbWpP97dk99elF01I0IKt7hYp2TyFFtuP+GR
    sqvXXiM2YNqu/Pomg7S8RbBSw52k2ELz4gCHvuFvqW9SJClkZkLSowjEVJ50VBxX
    NRF/9u5H2mUgMdxhIirN4/4GyzsfaACmzCu5L6wujCLTl3+FxjWvx0cNa9+cvmUb
    RwQbAGIcNzuJ9hNHgW2jg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=b47lcP+Z x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rp4y/m5O;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=b47lcP+Z x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rp4y/m5O;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751566AbeB0BaA (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 20:30:00 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39144 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751463AbeB0B36 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 20:29:58 -0500
X-Google-Smtp-Source: AH8x225JQhxtG1qPy+G5l/YpUn42zmfannTfA5OM69B0qNRnL0HNhe5Qa9YQSrZvxVKWLf0+8pewJw==
Subject: Re: [PATCH v5 2/9] watchdog/hpwdt: Remove legacy NMI sourcing.
To: Jerry.Hoemann@hpe.com
Cc: Arnd Bergmann <arnd@arndb.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rwright@hpe.com, maurice.a.saldivar@hpe.com,
        Ingo Molnar <mingo@kernel.org>, marcus.folkesson@gmail.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        stable <stable@vger.kernel.org>
References: <20180226032227.14615-1-jerry.hoemann@hpe.com>
 <20180226032227.14615-3-jerry.hoemann@hpe.com>
 <CAK8P3a1A5d52g-3Wgs1xP3P=dT6K0RVjmamfqAi9vE5TT=mo3g@mail.gmail.com>
 <03b13d44-9ce3-ead8-020d-4b1b8114079d@roeck-us.net>
 <20180227010250.GC8244@anatevka.americas.hpqcorp.net>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <8766f2ee-428a-d72f-b0c3-e5fe68fd0a33@roeck-us.net>
Date: Mon, 26 Feb 2018 17:29:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180227010250.GC8244@anatevka.americas.hpqcorp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/26/2018 05:02 PM, Jerry Hoemann wrote:
> On Mon, Feb 26, 2018 at 06:32:30AM -0800, Guenter Roeck wrote:
>> On 02/26/2018 06:11 AM, Arnd Bergmann wrote:
>>> On Mon, Feb 26, 2018 at 4:22 AM, Jerry Hoemann <jerry.hoemann@hpe.com> wrote:
>>>> Gen8 and prior Proliant systems supported the "CRU" interface
>>>> to firmware.  This interfaces allows linux to "call back" into firmware
>>>> to source the cause of an NMI.  This feature isn't fully utilized
>>>> as the actual source of the NMI isn't printed, the driver only
>>>> indicates that the source couldn't be determined when the call
>>>> fails.
>>>>
>>>> With the advent of Gen9, iCRU replaces the CRU. The call back
>>>> feature is no longer available in firmware.  To be compatible and
>>>> not attempt to call back into firmware on system not supporting CRU,
>>>> the SMBIOS table is consulted to determine if it is safe to
>>>> make the call back or not.
>>>>
>>>> This results in about half of the driver code being devoted
>>>> to either making CRU calls or determing if it is safe to make
>>>> CRU calls.  As noted, the driver isn't really using the results of
>>>> the CRU calls.
>>>>
>>>> Furthermore, as a consequence of the Spectre security issue, the
>>>> BIOS/EFI calls are being wrapped into Spectre-disabling section.
>>>> Removing the call back in hpwdt_pretimeout assists in this effort.
>>>>
>>>> As the CRU sourcing of the NMI isn't required for handling the
>>>> NMI and there are security concerns with making the call back, remove
>>>> the legacy (pre Gen9) NMI sourcing and the DMI code to determine if
>>>> the system had the CRU interface.
>>>>
>>>> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
>>>
>>> This avoids a warning in mainline kernels, so that's great:
>>>
>>> drivers/watchdog/hpwdt.o: warning: objtool: .text+0x24: indirect call
>>> found in RETPOLINE build
>>>
>>> I wonder what we do about stable kernels. Are both this patch and the patch
>>> that added the objtool warning message candidates for backports to
>>> stable kernels?
>>>
>>
>> Makes sense to me, but it is really a bit more than a bug fix, so I'll
>> leave it up to Jerry/HPE to make the call in respect to hpwdt.
>>
> 
> Generally speaking, HPE customers who run linux do so through a distro
> vendor and pick up patches from them.  But I'm sure there are some
> customers who do things differently.
> 
> The distro vendor's have their own repos and we'll work with them
> to back port patches to their code base.  So, I typically don't do a lot
> of kernel.org stable branch work.
> 
> Looks like objtool has been enhanced to find Spectre vulnerable code.
> Are the other kernel patches related to Spectre being back ported
> to stable release lines?  If yes, it probably make sense to do
> the hpwdt change as well.
> 

Spectre has been backported to v4.4 and later. I don't know about earlier kernels.

> Is just the patch removing the firmware call back wanted/needed? Or the
> whole driver rewrite?  (The older baseline don't have all the watchdog
> features that the patch set uses.)
> 

We would only want to backport this patch. The rest is really out of scope.

> Which stable baseline(s) would need to be patched?  Priority?
> 
> Who does it?  (i.e. do you want me to submit patches to the stable baseline?)
> 
We would tag the patch for stable (and submit it into v4.16-rc). Greg would
take care of the rest unless there are conflicts, in which case we get a note
telling us that a backport is needed.

Guenter
