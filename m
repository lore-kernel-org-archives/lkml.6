Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1765435-1522768292-2-12733624455789400461
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522768292; b=CzdMhBEe7ctROO9mllf0DX6CZ4Vw+MJHx+DiK3AwP8uhkWJg98
    mo6cbfXw4L6miAkn+5szhZuokliI3bvutZ8CPkDqbjh2UefOMpivvClozxaZJRZC
    n7xloi18y1G0vpSE5yNWGAQjOTu1wTJ9FO8aXYDRn6tDTe1wJG5VL3juGaXsKsZS
    8virBJGuu6Act8TK9Up2MJu1WioFwQiXKkmLwdS7p42DJUIFNjsn6LgBFnpabagZ
    CtfZnsOs/xD6/WDi2tlKcFdSt/qEec6o9pc7BLwg85R0kmuU3ae2ApZtJ9TWqT74
    8xhhwrYpsVmYVcV7XLmd5ExhjkT9nzzlqAZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522768292; bh=WiF+offKd0HPueGLhiTcQJ9U0GMcBwlT7ggKN3Kt45
    c=; b=q+nnM1EccAGlvbPU1kEpD2C6rfvXRYXSYDJn+74AkXFMLM1ZrMjJRSwNHt
    7YCXxW1YhDSgRyYeo33RhcZwcVvveeTGcEW8W3IegGduZBDZdUFv1n5zYJxiSja2
    +YR53CYuAimbvlkAI81tGm8IGUwbXCWjPWzNoCmasvRyg13B6IS/OaWEO5/dDGoW
    reM6Ni9jHuhtdDQtjKCuoIBluqAHGqfMjg36VW/BuF6s4a/QqNR6/05u8Vtsnm1V
    6uZsNYlkwP40ONOY/YwFmY57ZNM2+AhftvQ9vCpNgq/u+gj1BtKraHovyzSGoyBt
    EZx/EhrmUacvI6Ev3bvelL4fl5Mw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNDyYOYlN+ykZcwttEUmXhELD44XHunqpfX3XzgBfYDt3wjl3hbYGlOD2T/g44S9dKvrQAG9Hje9S0be/3j03cASZbSPFIS0lGKpI4AzFS6yP8LLz/VC
    1Iz6fGJYJUrKZOJSzn7amH180hIO8eXhfXwOab1ilaGsy+ErMV8oLK5K3juKVrbFTtkc3WkjqR86HPirIHrWN/2tTEmx5Xs102nSQUt4l/+70iiw1yV8Jlil
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=D19gQVrFAAAA:8 a=lmod9NDo3kZxZdX_NSUA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=W4TVW4IDbPiebHqcZpNg:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbeDCPLa (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 11:11:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751447AbeDCPL2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 3 Apr 2018 11:11:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E672183E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AIpwx4/B6/N30qJ83PUK+Y/g/eQyP0MEutajuSXkhGaiNQsG9QnVOGdOBjoFtboE8awy7k5QO+YDBpgZKC5fOsycUkg=
MIME-Version: 1.0
In-Reply-To: <30459.1522739219@warthog.procyon.org.uk>
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 3 Apr 2018 08:11:07 -0700
X-Gmail-Original-Message-ID: <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
Message-ID: <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Lutomirski <luto@kernel.org>,
        James Morris <jmorris@namei.org>,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        linux-man <linux-man@vger.kernel.org>, joeyli <jlee@suse.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

[re-added cc's, I think.  Sorry, I think I failed to use the gmane
gateway correctly there.]

On Tue, Apr 3, 2018 at 12:06 AM, David Howells <dhowells@redhat.com> wrote:
> Andy Lutomirski <luto@kernel.org> wrote:
>
>> This is an attempt at a review.  I'm replying here because I can't find the
>> actual relevant patch emails.
>
> This was the latest post:
>
>         https://lkml.org/lkml/2017/11/9/660
>
> and they were posted multiple times before that, plus distributions, such as
> Fedora, have been carrying them for a long while.
>
>> For the rest of this review, I'm going to pretend that you actually want two
>> features: "try-prevent-root-from-corrupting-the-kernel" and
>> "try-to-prevent-root-from-reading-kernel-memory".
>
> It theoretically boils down into those two, but the line is blurrier than you
> think.
>
> Further, some of the vectors that can be used to do one can potentially do the
> other also and it starts getting to be a lot of extra work to distinguish the
> two.
>
>> I do *not* see why the mere act of using Secure Boot should have this
>> effect.
>
> To be able to pass secure boot mode over kexec, you have to make sure that the
> kernel image doesn't get corrupted, lest someone blacklist your signing key in
> the bootloader.

Can you explain that much more clearly?  I'm asking why booting via
UEFI Secure Boot should enable lockdown, and I don't see what this has
to do with kexec.  And "someone blacklist[ing] your key in the
bootloader" sounds like a political issue, not a technical issue.

What is the actual purpose of these patches?

>
>> In particular, UEFI Secure Boot should *not* enable
>> "try-to-prevent-root-from-reading-kernel-memory", which means that, unless
>> you actually implement the split, you should drop a bunch of the patches.
>
> Yes it should.  If someone can read your kernel image, they can steal the
> crypto keys you use to encrypt your filesystem.

Can you please explain the actual attack that is avoided by doing this?

Suppose I'm a bad guy attacking someone's laptop.  If I just have
normal uid!=0 access, then these patches have no effect.  Instead,
we're talking about an attacker who is somehow able to become global
root and bypass all LSM restrictions but has not gained kernel code
execution.  It is indeed the case that your patches make it harder to
simply read the dm-crypt encryption key out of main memory.  But root
can attack the disk encryption in many other ways.  They can
persistently compromise the machine by adding services or user
accounts or intentionally misconfiguring something.  They can directly
read the entire contents of the disk.  They can modify the initrd so
that the next time the machine reboots and the user types the
password, the attacker gets the key (unless the TPM is involved, but
getting *that* right on a standard distro is difficult or impossible).

And I'm not even sure why an attacker who manages to become root wants
your disk encryption key.  That key is worth nothing unless the
attacker makes its attack persistent, but, if the attacker can install
a persistent user-level backdoor, then they can read the cleartext off
your disk just as easily as they can read the ciphertext.

>
>> "Restrict /dev/{mem,kmem,port} when the kernel is locked down": this should
>> probably split into one restriction for read and one for write.
>
> Not so for /dev/port.  Read & Write here are _not_ the same as Read & Write
> on, say, /dev/mem.  In fact, if /dev/mem gives you access to mmio ports, then
> the same applies there.  Btw, Fedora hasn't even provided /dev/kmem for a
> while.

Then split /dev/mem and turn off /dev/port for all locked-down modes.

>
>> "bpf: Restrict kernel image access functions when the kernel is locked down":
>> This patch just sucks in general.
>
> Yes - but that's what Alexei Starovoitov specified.  bpf kind of sucks since
> it gives you unrestricted access to the kernel.

bpf, in certain contexts, gives you unrestricted access to *reading*
kernel memory.  bpf should, under no circumstances, let you write to
the kernel unless you're using fault injection or similar.

I'm surprised that Alexei acked this patch.  If something like XDP or
bpfilter starts becoming widely used, this patch will require a lot of
reworking to avoid breaking standard distros.
