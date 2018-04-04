Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2795407-1522801443-2-10750746639625964613
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522801442; b=CKqL+dC7XhQfht1gzKD3yJ10FMp/3ZEoFPbw5dX/aC1GbEBGXq
    xzX10/c/+eTm1lUEwJOVnsLSaKg8t1f+tWdA6CpOMdelVKQj5dQnY4KRp/YHCkz9
    rOn7EuPNgthuX6NSPX+Rz1KCBV6iOq6yOIO+3PfSnqk+L2e6So2VLIJFeEBztWas
    xePaeykFZs5fE7UUg2+187rdvoD0ZFh2AvxdvxMlwE4RSbBDNOBsigrSXKefH8lY
    yjugBWGB+8ea2zBtXAzcWbwAxlNEQOFXOML88TAUafv4rU1/lgCOKiiWZ72z6Axv
    GrFANl2twMcJF5y3CXUC2HpkQnDP6Jo8vtIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522801442; bh=JDwAz3KNzOBXY8Ld6bvVU7PCFF5WU+77zEmIlC98lX
    E=; b=NQRninQdPIr3o9JPdw4uzmTGT2BJdlnH2xMXqAnquNQTG4eIjbEDMxzcz9
    IfmBvksvOi7lTy0noMdNd2YE8XWPBX32L84Ab56Dqu5JDVXegp+rIFTBRv/coO7R
    aahRd80IkUuRuJQOi/S6N0Yxf8jRu88RvIe5UEwKDn1lOZeB4D+ad9kGJn1wCaL0
    QNiHxdTQi2xEncq6zxV8k/qviVECE97RDr7dGcBQ2zqxbimJnOfUfnYNVqJT/l0W
    BMLKb7BppyCDYuTmr42rP4WM85nlTKdV4BVycFUZG1OhebevrNbMBnFc/LaOnZ4L
    NcjfQPpknoKMggMDTzX/phvNcXDQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfDI3UpX7hVhKFqrB4nyKIrKe1pZvVlIwgA9ckiqsh7q5ZkSZ+TbrQ05/dtPAgrFE7BSvfdVKoNBxko5ZJqrEqwCutijfHNNTewy0dLv9isjM2BhrzsBN
    4C//JrSqH72ayOG6DbSi2GGnjxkaob+QCXjxi7cShnbFIqaRqRyXfDeUj8LEyuMzsbKjMT3gJacRd439Xor/Rrlhzw5BAPrzyBAlNurRhf3dtyZolvXhcfzC
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=ZfOJmc5OJ8A7EVkeo2wA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=HkZW87K1Qel5hWWM3VKY:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756637AbeDDAYB (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 20:24:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756400AbeDDAYA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 3 Apr 2018 20:24:00 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9370121837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AIpwx4/namEq3mSxTAaXNWWtetBC02h8JYZJNJqLUORbWtq7zblwIjgimZyYdDGh2hstXi6w3FyaUk6ce7qTSXlIqNs=
MIME-Version: 1.0
In-Reply-To: <CAG48ez1MRsDGoea5MwGTXK6R0LJy9u0mX-1VrSSskwnV98kEjQ@mail.gmail.com>
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
 <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com>
 <9758.1522775763@warthog.procyon.org.uk> <CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com>
 <13189.1522784944@warthog.procyon.org.uk> <CALCETrX4CuHVpn38R24TCcJgCBLSbh-sOD-qcD5kYF8Zo53ZJw@mail.gmail.com>
 <9349.1522794769@warthog.procyon.org.uk> <CALCETrV6E+r942K+fu-ALNf-x6qOZ3o1hNKGeu7qEMvr8sMP9A@mail.gmail.com>
 <CA+55aFxKzxdRZthzaokaGPAsWCp3a-p3aVfJSutF+9Fp9sbaVA@mail.gmail.com>
 <CACdnJusSfwULV-ubvgtYd8G_cTF4LnJ4DAeTCux4XRhHKVpBUw@mail.gmail.com>
 <CA+55aFzG==xr2OLK8F03RH0nkUDeP6btWqepFTuHZqkPTAOWjQ@mail.gmail.com>
 <CACdnJuv_=ihPut=5OvCYEphdBOn7+JrKacBbNa0n3wv_JvFMzg@mail.gmail.com>
 <CA+55aFyWNok1K-Jo3TQAXGXHvFOTvuOb-Hw977B9RGjBa7prrg@mail.gmail.com>
 <CACdnJutZFKX+izBxRYbyxefT5KrKhVV0XsymU=vBhywd+TOE3A@mail.gmail.com>
 <CA+55aFwVUmjZ+Swe9xUdDOEE+EOoaU3dh7BcrH74BOLCi8y_Kw@mail.gmail.com>
 <CACdnJuvqQQ+hidokY5GA7g-yrAs5-358it0cs+m_d4RFDMuB_w@mail.gmail.com>
 <CA+55aFwJBGCr-anrdV9N63fUH4V_QJqgr0_fJyHhH=fuqGAoog@mail.gmail.com> <CAG48ez1MRsDGoea5MwGTXK6R0LJy9u0mX-1VrSSskwnV98kEjQ@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 3 Apr 2018 17:23:38 -0700
X-Gmail-Original-Message-ID: <CALCETrXZWU1MC8LbLCg7VTVHMqKpXh51amnTjKePRCJ31jRiwg@mail.gmail.com>
Message-ID: <CALCETrXZWU1MC8LbLCg7VTVHMqKpXh51amnTjKePRCJ31jRiwg@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Tue, Apr 3, 2018 at 5:17 PM, Jann Horn <jannh@google.com> wrote:
> On Wed, Apr 4, 2018 at 2:06 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> On Tue, Apr 3, 2018 at 4:59 PM, Matthew Garrett <mjg59@google.com> wrote:
>>>
>>> Ok. So we can build distribution kernels that *always* have this on, and to
>>> turn it off you have to disable Secure Boot and install a different kernel.
>>
>> Bingo.
>>
>> Exactly like EVERY OTHER KERNEL CONFIG OPTION.
>>
>> Just like all the ones that I've mentioned several times.
>>
>> Or, like a lot of other kernel options, maybe have a way to just
>> disable it on the kernel command line, and let the user know about it.
>>
>> That would still be better than disabling secure boot entirely in your
>> world view, so it's (a) more convenient and (b) better.
>>
>> Again, in no case does it make sense to tie it into "how did we boot".
>> Because that's just inconvenient for everybody.
>
> Without taking a stance regarding whether I think that kernel lockdown
> makes sense, I think Matthew's point is this:
> If you don't have lockdown, secure boot doesn't provide a benefit,
> since an attacker could just modify the init binary instead of messing
> with your kernel.
> If you have secure boot, you want lockdown to prevent chainloading
> into a backdoored version of the real OS.

I don't think that's the argument here.  Secure boot can be used to
protect initramfs, since initramfs comes from the secure boot-verified
bootloader.  That verified initramfs can protect the init binary.

As far as I can tell, what's really going on here is that there's a
significant contingent here that wants to prevent Linux from
chainloading something that isn't Linux.  (There doesn't seem to be a
real benefit to preventing Linux from chainloading Linux, since the
chainloaded Linux is unlikely to let the attacker do much that the
original rooted Linux kernel wouldn't have allowed.)  In particular,
Microsoft, which de facto controls most of the secure boot key
ecosystem, doesn't want Windows to be chainloaded without having its
signature verified.

I admit I'm not quite sure why Microsoft considers this important.
They already require a TPM for all new systems, and any important
secrets can be sealed by the TPM such that a maliciously chainloaded
Windows kernel couldn't access those secrets.  But secure boot
predates the WHQL TPM requirement if I remember correctly, and I
suspect that we're seeing leftover requirements from
secure-boot-but-no-TPM era.
