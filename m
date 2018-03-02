Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-517306-1519965782-2-17031830393645436828
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
    t=1519965781; b=d24Qbvd6HJuBHb55iyj0tWh0EP2F8UFEWNTFi4gw0fTsHO/
    E8GGebu06vpabgui8rAhlcjonKBhSZAw8EKhhTYUUYJcPntppBgAwyM5A2GKNPu5
    MntGm2prfQP9diJam24aUxzWKepaPDG0NrZPYsILrfaH6qDSXFFJBU33+EYAa26D
    oeUVGIdQuvk8JFmrNKor3qCaQlUEqcMzi9+E9rCl0w8QWGt7PBgKra3SGhpSrkTh
    5MQzFlS5aG66Jnb4NhsvBU4KeGe7Ph2NXcSIKG5ULhGl8q0WwK3H3jj16/Fe6wQO
    +CWqZZe+3VuMoJruLlcZ34xwe6IdiJlV60bTHQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519965781; bh=HQivaLxPpxita7Kh4Aew5K9DBC3Gkrw+N9FlaKYKq2Q=; b=l
    MHU1eRl4eN+Pmt/7egWBlTDP3NzEypqVxrknjnQOQO+1V3/m8AMq6ky5NNH6qNn2
    QINhDiqE8n9aY/2G4wVJJMfM4GTyfw0uZs/Gm6XkWQjHsEUK7biii7J6sOgvllWz
    CF9cAdgubeevFYxcqa+2onoBFinBFaV0E29FOBXc+VuLj3m8W/DV7qOtyquZCbJk
    LXg11uPugr9zprC2wnzIb5QQWyJX1050eLEvOQOdZ720rUKdGx/koni7x8la0MdX
    Px44+la1N/8XZz9XD1XwUYg3c74IU4cj7MUpjIHCidcBBCdZWTvCyVuSXs55KmcR
    x8dkgFTiHpigVk1fNHB2w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Th4BAnn5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Uu1c1re3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Th4BAnn5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Uu1c1re3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422797AbeCBEnA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 23:43:00 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36753 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422796AbeCBEm6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 23:42:58 -0500
X-Google-Smtp-Source: AG47ELslUQOYFFExWmZYJCZyc1cdW9eLfgDUKpM9M5Uph8q/MSJEWZBqo2EFIOPhpwDzz7Ler+4qOw==
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
 <8766f2ee-428a-d72f-b0c3-e5fe68fd0a33@roeck-us.net>
 <20180228194558.GB28906@anatevka.americas.hpqcorp.net>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <f61a92c4-f923-77d7-22a8-11481baca79b@roeck-us.net>
Date: Thu, 1 Mar 2018 20:42:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228194558.GB28906@anatevka.americas.hpqcorp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/28/2018 11:45 AM, Jerry Hoemann wrote:
> On Mon, Feb 26, 2018 at 05:29:55PM -0800, Guenter Roeck wrote:
>> On 02/26/2018 05:02 PM, Jerry Hoemann wrote:
>>> On Mon, Feb 26, 2018 at 06:32:30AM -0800, Guenter Roeck wrote:
>>>> On 02/26/2018 06:11 AM, Arnd Bergmann wrote:
>>>>> On Mon, Feb 26, 2018 at 4:22 AM, Jerry Hoemann <jerry.hoemann@hpe.com> wrote:
>>>>>> Gen8 and prior Proliant systems supported the "CRU" interface
>>>>>> to firmware.  This interfaces allows linux to "call back" into firmware
>>>>>> to source the cause of an NMI.  This feature isn't fully utilized
>>>>>> as the actual source of the NMI isn't printed, the driver only
>>>>>> indicates that the source couldn't be determined when the call
>>>>>> fails.
>>>>>>
>>>>>> With the advent of Gen9, iCRU replaces the CRU. The call back
>>>>>> feature is no longer available in firmware.  To be compatible and
>>>>>> not attempt to call back into firmware on system not supporting CRU,
>>>>>> the SMBIOS table is consulted to determine if it is safe to
>>>>>> make the call back or not.
>>>>>>
>>>>>> This results in about half of the driver code being devoted
>>>>>> to either making CRU calls or determing if it is safe to make
>>>>>> CRU calls.  As noted, the driver isn't really using the results of
>>>>>> the CRU calls.
>>>>>>
>>>>>> Furthermore, as a consequence of the Spectre security issue, the
>>>>>> BIOS/EFI calls are being wrapped into Spectre-disabling section.
>>>>>> Removing the call back in hpwdt_pretimeout assists in this effort.
>>>>>>
>>>>>> As the CRU sourcing of the NMI isn't required for handling the
>>>>>> NMI and there are security concerns with making the call back, remove
>>>>>> the legacy (pre Gen9) NMI sourcing and the DMI code to determine if
>>>>>> the system had the CRU interface.
>>>>>>
>>>>>> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
>>>>>
>>>>> This avoids a warning in mainline kernels, so that's great:
>>>>>
>>>>> drivers/watchdog/hpwdt.o: warning: objtool: .text+0x24: indirect call
>>>>> found in RETPOLINE build
>>>>>
>>>>> I wonder what we do about stable kernels. Are both this patch and the patch
>>>>> that added the objtool warning message candidates for backports to
>>>>> stable kernels?
>>>>>
>>>>
>>>> Makes sense to me, but it is really a bit more than a bug fix, so I'll
>>>> leave it up to Jerry/HPE to make the call in respect to hpwdt.
>>>>
>>>
>>> Generally speaking, HPE customers who run linux do so through a distro
>>> vendor and pick up patches from them.  But I'm sure there are some
>>> customers who do things differently.
>>>
>>> The distro vendor's have their own repos and we'll work with them
>>> to back port patches to their code base.  So, I typically don't do a lot
>>> of kernel.org stable branch work.
>>>
>>> Looks like objtool has been enhanced to find Spectre vulnerable code.
>>> Are the other kernel patches related to Spectre being back ported
>>> to stable release lines?  If yes, it probably make sense to do
>>> the hpwdt change as well.
>>>
>>
>> Spectre has been backported to v4.4 and later. I don't know about earlier kernels.
>>
>>> Is just the patch removing the firmware call back wanted/needed? Or the
>>> whole driver rewrite?  (The older baseline don't have all the watchdog
>>> features that the patch set uses.)
>>>
>>
>> We would only want to backport this patch. The rest is really out of scope.
>>
>>> Which stable baseline(s) would need to be patched?  Priority?
>>>
>>> Who does it?  (i.e. do you want me to submit patches to the stable baseline?)
>>>
>> We would tag the patch for stable (and submit it into v4.16-rc). Greg would
>> take care of the rest unless there are conflicts, in which case we get a note
>> telling us that a backport is needed.
>>
> 
> Guenter,
> 
> Are you waiting for anything more from me on this patch, or are we
> good for now until the back ports to v.15 etc.,?
> 

We are good. I'll need to ask Wim to send a pull request to Linus.

Guenter
