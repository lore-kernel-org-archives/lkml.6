Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2654832-1522795233-2-7080205616290977617
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522795233; b=kRLGGGapfTVx61NTI8jAYlDVpivDWj7TwVG7nqzqQ7OODptudV
    k7eW8IBP/M8Wwn1iNr+HIvOVd0t4odWQMRxTItNG3PCwZUnEzVr8rxNCwD7dEKWS
    kcfOLjnzKRhbzt5qTt41EBOOuDPFeveQGTUtAEdB0JSJkD00ufupTfVQj8caq2pT
    LJRZvj0+QiPJeA1sKBVZpeYePD988ic9cf+Zs6t6vZ3Wa7VRy3H26UV1n0VH8h8K
    1hwg34ZeOc95HyNRv88pochUZAWpKVWZzs3E3+ZjbhJa1hSIVBB6YWVCCG0jVRWx
    TdCrFRD2XVzNKwhtOnQLK3ZWkYWDtXdkwNdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522795233; bh=sniDGGHFQheSFI0WKP/2GQK2Q6tDTCwuf790Zjkr2A
    E=; b=ODJJSRCVR3gHl9X/Vxcxit9LyDVuN2cbtyiOHI4SvHmJZO+/QjNNNFWaA4
    HW/QqO4yX6FBxqfWBto2/hqJ35r6HZLm695wypN9KW5R6qVSoy0M0apheG/IcfPw
    GBsGOYvasZ8UIWMpnkhwM7HTpPa8vzHxt+F3oa+PEqnmgJr6vRufTNZvF6VEdcXU
    MkiL4JNjJhuugU66fWR0MicWx+/1svnXOzBxvMGpj5AgWTbnCFKBoSre+909esRa
    pFeAwO1HeuWg/XIU7E1WDYSzRWa9P7BtYP1B2vLSkK8cXQK+hgbgPTLRtTJ16DN0
    a5tlwBc9LXKVJ5gTPvO4xz1g3U6g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAVRPMZpETaO3D6R8sUf1p3Nsx9kmvLByj8Cz8TbC0h6xbpsTxXsgP3Q75XTZ7cUP7A9UkcxWXYorRfD1D//xYV4kL/lsJbVXjx7bbcqe07BtpuBopzc
    w/43Z9djbzAP3LW4PfqMa1rePlHmuemPGU0pKKhvd9KODZAi8V8UcHGkOBPoQTgatw32D20vTvbsCq0GaJi+5vLFsKIpXhhSBcHC1wLMgrxgo/k759668HmU
    vCLA9XBaL43os0BheUM/qQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=NWrKdp6gXc8RIlmmansA:9
    a=H3kXc0RxdJ8O93eI:21 a=5b67EWDG6I7FBKF4:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755903AbeDCWjh (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 18:39:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754961AbeDCWjf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Apr 2018 18:39:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE9C21840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AIpwx4/RgIFwzRS7+J4owPAvGWTSf0U3SlYVK65EzB8ljyqbJEZCrJhguY0fMfNdfBBvUssD/iqk/vPdXJGobfFqDOI=
MIME-Version: 1.0
In-Reply-To: <9349.1522794769@warthog.procyon.org.uk>
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
 <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com>
 <9758.1522775763@warthog.procyon.org.uk> <CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com>
 <13189.1522784944@warthog.procyon.org.uk> <CALCETrX4CuHVpn38R24TCcJgCBLSbh-sOD-qcD5kYF8Zo53ZJw@mail.gmail.com>
 <9349.1522794769@warthog.procyon.org.uk>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 3 Apr 2018 15:39:14 -0700
X-Gmail-Original-Message-ID: <CALCETrV6E+r942K+fu-ALNf-x6qOZ3o1hNKGeu7qEMvr8sMP9A@mail.gmail.com>
Message-ID: <CALCETrV6E+r942K+fu-ALNf-x6qOZ3o1hNKGeu7qEMvr8sMP9A@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: David Howells <dhowells@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        linux-man <linux-man@vger.kernel.org>, joeyli <jlee@suse.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 3:32 PM, David Howells <dhowells@redhat.com> wrote:
> Andy Lutomirski <luto@kernel.org> wrote:
>
>> > If the user can arbitrarily modify the running kernel image, you cannot
>> > trust anything.  You cannot determine the trustworthiness of something
>> > because your basis for determining that trust can be compromised.
>>
>> I'm having a very, very hard time coming up with a scenario where I
>> can "trust" something if an attacker can get root but can't modify the
>> running kernel image but I can't "trust" something if the attacker
>> can't.
>
> Eh?  If the attacker can't what?  Did you mean to put "can" at the end of that
> rather than "can't"?  I don't see why the kernel-level trust would be
> compromised if an attacker can't get root and can't modify the running kernel
> image.

Whoops, yes.

>
> Here's a simple scenario: You boot your machine.  You have module verification
> keys in your kernel.  You have /dev/mem available for root to read/write.  A
> program running as root can modify the keys in your kernel or just disable the
> checking code entirely.  It can now insmod any module it likes.  You may as
> well not bother with signed modules.  In fact, it can modify the running
> kernel image in any way it likes, without even having to load modules.

I don't particularly disagree with any of this, but you seem to be
saying "if you've bought into the party line wrt signed modules, you
had better enable lockdown, too".  I *don't* buy into the party line
about why signed modules should be needed for Secure Boot.

> There's no point bothering with UID/GID checking either.

Give me a break.  There's a *huge* difference between a system where
only root can load unsigned modules and a system where anyone can load
unsigned modules.

>
>> > Stopping the kernel from being arbitrarily read stops any encryption keys it
>> > may be using from being retrieved.
>>
>> If I build a server that runs Panera Bread 2.0's website, and the
>> attacker exploits my machine to steal tens of millions of customer
>> records by getting the machine to talk to some database server using
>> keys that are securely stored in the kernel keyring, ...
>
> I was thinking more in terms of preventing access to the encrypted data on
> your own disk.  The key for that could be unlocked using a TPM, but the
> session key then has to be retained in RAM for performance reasons unless you
> can transfer the session key to, say, your SATA controller without it going
> through the CPU.
>
> However, if /dev/mem can be read, any root process can extract the session key
> for your disk.

Any root process can read /dev/mapper/plaintext_disk, lockdown or otherwise.

>
> But, as you suggest, they could also protect secrets used in communications.
> However, the communications themselves have to be exposed to userspace for
> userspace to be able to use them.  That is unavoidable.  The kernel keyring,
> for example, tries to restrict who can even see a key, much less use it as
> much as possible - but ptrace() exists...  You are no less vulnerable if the
> key is held in a userspace process; then the attacker can get the key and the
> data.
>
> If the kernel is locked down, the aim is to try and make sure that keys
> stashed in the kernel cannot be read, though they have to be able to be used,
> or there's no point to them.

Sure.  I have no problem with having an upstream kernel have a
lockdown feature, although I think that feature should distinguish
between reads and writes.  But I don't think the upstream kernel
should apply a patch that ties any of this to Secure Boot without a
genuine technical reason why it makes sense.
