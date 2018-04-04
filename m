Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-470151-1522859837-2-16246799325567493181
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522859837; b=rcIHrXedgm+DXOIBMME+HHXLYAAm/5PCZ702qlARhygvnOhSw0
    l6PJQ2+S01CFDDnPCn31of4pJdlpp1ZStbnsF3WNdx8Zj6tw/MWUG/NanCGnEl7w
    zYftLLxCXGhXzAUkB4QaoICgz7EbJsibbeKRxAx9KXe6hm45aZnw0HHc3f8w4EfB
    mk1sXRT5fbgBN7mbAtVGYSYVOTq0rH+/TtIepHbBe8NJjmCrwUl9jCd3BkqU5jDF
    mQDxAJK7tsDWp7ufwik8ZwyJCdgna0TOBUBsXWXmvmVF+9A4o9fzm/qz+2ukPZtt
    c2LwLa1YNUgzDB/Yb+4Yq8ongT+e2BMk+uyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522859837; bh=t6qPu76AKshViQgjcuM1h8rKMCNY4Ibsfdh3CeTAGY
    Y=; b=psiogqiK0SrzcwlVIrDVS8wuYNRgteSwllqegww3ua1HoK5NJCDT1XIH1p
    fnN23D72aSH5whTwLcM1Lxp/jhnZbpSMCNCMbhkyQ4rjEgntYXZ22iCK1wqPxrw6
    eo8BpfItNeDdj8Br1FnjBfQ9NegW5alqyL0cnV4Mx2mGSRXbFzEheBr7+uE1wl1q
    PPzJOwYwWRTVJ8k40ex4ANGopw5sxuLJq4uu/9QFEu/zPez80nYhDP6GapuT0eXQ
    L+YWN7K0VnNKfM6qbYgLO8125hT8UuB3PhurM4rEdLv3+QI7mONqukdb22/qKZhr
    pbNdN9qzlOCoOLoihyXyqHwothCw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNGK8vH3Uz35tVQsr+HMWxfCWJqg1lz1qbbtwS6O6c7ThrKYUJv+g482QaAWsk8KB8W1kjDKzRHplV2Rm6Y1F6zQXFIcbXNPuDHykZWYtAnxjYfL5jGl
    Gx34s+czMFpIptm8HzJAw6Chaed1KB2IRV0V22HlWr/wGkZWyUmgk1sNlIJ99RpD0UeL/S0gkEOf3c3gzYnXB02kEvUUfNPEcihghJ6IMm3Fl+CYuDouvENO
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=xR59qsu8ipgwDPc6k-kA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbeDDQhO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 12:37:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751714AbeDDQhM (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 4 Apr 2018 12:37:12 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC43121835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AIpwx485zvJbJsZYbd+EOqFkJba5A8u2YPccrChX6c0j0idsHTZcuDRDCo9vAOZPIYnH1xxX/Jbwzem6TGhyGiygMmk=
MIME-Version: 1.0
In-Reply-To: <1119.1522858644@warthog.procyon.org.uk>
References: <CALCETrUVQLDC6_VEvuAbdCOuGrmcxohqTB6P8eyNojm9AryNkg@mail.gmail.com>
 <1119.1522858644@warthog.procyon.org.uk>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 4 Apr 2018 09:36:50 -0700
X-Gmail-Original-Message-ID: <CALCETrXGStY_h5YMprSCuo-q6AgGDe_vXdPqJHSCkx4wSG0=EQ@mail.gmail.com>
Message-ID: <CALCETrXGStY_h5YMprSCuo-q6AgGDe_vXdPqJHSCkx4wSG0=EQ@mail.gmail.com>
Subject: Re: An actual suggestion (Re: [GIT PULL] Kernel lockdown for secure boot)
To: David Howells <dhowells@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Garrett <mjg59@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        linux-man <linux-man@vger.kernel.org>, joeyli <jlee@suse.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 4, 2018 at 9:17 AM, David Howells <dhowells@redhat.com> wrote:
> Andy Lutomirski <luto@kernel.org> wrote:
>
>> Since this thread has devolved horribly, I'm going to propose a solution.
>>
>> 1. Split the "lockdown" state into three levels:  (please don't
>> bikeshed about the names right now.)
>>
>> LOCKDOWN_NONE: normal behavior
>>
>> LOCKDOWN_PROTECT_INTEGREITY: kernel tries to keep root from writing to
>> kernel memory
>>
>> LOCKDOWN_PROTECT_INTEGRITY_AND_SECRECY: kernel tries to keep root from
>> reading or writing kernel memory.
>
> In theory, it's good idea, but in practice it's not as easy to implement as I
> think you think.

[...]

so do your best.  The whole lockdown patchset is a best-effort thing,
not a "we did it and it's done" thing.

> Note that /dev/mem can be used to access MMIO devices (I'm not sure about
> /dev/kmem, though).  Even reads through /dev/mem can do this.  I'm not sure
> whether that's sufficient to actually affect a modification, though.

So turn it off in both modes.  /dev/mem is basically obsolete anyway.
Or restrict it to actual memory, or whatever.

>
>> 2. The kexec protocol gets a new flag min_lockdown_level.  A kexeced
>> kernel will boot with at least that lockdown level regardless of its
>> configuration.  kexec sets min_lockdown_level to the running kernels'
>> lockdown_level.  Some future API could allow kexec with a higher
>> min_lockdown_level.  An even fancier future API could allow a
>> LOCKDOWN_PROTECT_INTEGRITY_AND_SECRECY kernel to kexec with
>> min_lockdown_level == LOCKDOWN_PROTECT_INTEGRITY if there's some
>> mechanism that guarantees that memory gets zeroed in the process.
>
> Note that on x86 we already have an allocated flag for passing the secure boot
> flag from kexec/bootloader to the kernel being booted, and what you're
> proposing ought to be redundant.  See boot_params::secure_boot.

Incorrect.  Linus is rejecting the idea that secure boot implies
lockdown.  I strongly agree with him.  I also think that trying to
make security decisions in a kexeced kernel based on whether the
previous kernel was secure booted is a bad idea, so I'm suggesting a
new feature.  I don't really care what value is passed in
boot_params::secure_boot for a kexeced kernel, but I think it should
not be used for lockdown.

So I stand by my proposal.

>
>> 3. All the bpf and tracing stuf, etc, gets changed so it only takes
>> effect when LOCKDOWN_PROTECT_INTEGRITY_AND_SECRECY is set.
>
> Uh, no.  bpf, for example, can be used to modify kernel memory.

Really?  If that is, in fact, true, then turn *that* feature off when
LOCKDOWN_PROTECT_INTEGRITY is set.

>> This removes a giant annoyance on distro kernels that are likely to want to
>> enable LOCKDOWN_PROTECT_INTEGRITY.
>
> *shrug* Distros have been running with the full set for a while.  I haven't
> seen many complaints.

As Linus noted, that's because a lot of users who care have already
turned off secure boot.  Once this whole thing gets sorted out, the
hackish dependence of lockdown and secure boot can go away, so it's
time to think about making lockdown less annoying.

>
>> If you load a key into the kernel, and you want to keep that key safe, you
>> can enable LOCKDOWN_PROTECT_INTEGRITY_AND_SECRECY at that time.  After all,
>> if root is compromised before that, root can just remember a copu of the key
>> in user memory or email it to someone.
>
> If your key needs to be truly protected, it should never be seen unencrypted
> in userspace, rather it should be decrypted in the TPM and then retained in
> kernel memory only.

You keep making claims like this with no justification whatsoever.

>
>> ...
>> 6. There's a way to *decrease* the lockdown level below the configured
>> value.  (This ability itself may be gated by a config option.)
>> Choices include a UEFI protected variable,
>
> By turning secure boot off, maybe?

No.

>
>> an authenticated flag passed by the bootloader,
>
> Authenticated how?  How do you stop the running system from passing this to
> the bootloader next time it is run?  I guess you're thinking of a bootloader
> "command" that can only be passed by someone sat at a keyboard and never read
> from the config file.

What I meant was some channel that the bootloader can use to securely
communicate options to the running kernel.  The concept of "secure"
here is obviously debatable.  Something in boot_params would work.
Some specially namespaced command line option could work.  Some whole
new "authenticated data from bootloader" block could work.

>
>> and even just some special flag in the boot handoff protocol.
>
> We already have that with secure boot.

No.  That has been rejected over and over in this thread.  I'm
proposing an alternative here.

>
>> 7. kexec does not attempt to think about "secure boot" at all.
>> They're totally separate.
>
> Except that they're not.  The boot_params flag must be set to something by
> kexec on x86 for transfer along the chain.

How about setting it unconditionally to false?

>> What do you all think?  I think that this checks basically all the
>> boxes, is a lot more user friendly than the current patchset or what
>> distros do, and actually makes some sense from a security perspective.
>
> You haven't really defined well what's allowed in _INTEGRITY mode verses
> _SECRECY mode.

_INTEGRITY means "make a best effort to keep root from writing kernel
memory, talking directly to non-IOMMU-protected devices, writing MSRs,
or otherwise corrupting state".  _INTEGRITY_AND_SECRECY means "do all
that and also make a best effort to keep root from reading kernel
memory".
