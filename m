Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1432864-1522891741-5-6319416945137153186
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522891741; b=me94s5qpZJ2hqFkr6PrFRg5QctDZm+BwqKN/nqmSZ5Pe5zJKDJ
    lwvq4PgronrDJqZL5JmflXs6G3dvaRKn28ed+35bUM1AWMdUIGBPIZjzNBJKgdGN
    RMhKNu5iTowvvLHn8cCysqIWuSm7pv+VAUCJN0BpXiOWZrV8K4sPMzjP1CBJTET/
    zrE0CIZ3S27hp+3Xb16f/1XSYTxN1tFQXJRUWfNvP1SX6Kno749AoGK2VXcGMeY+
    iQEnZ0GbzxyWEW3hzI5xC9j5Yzt81HjF72Eg8lPuuWTdQ22ED/mm9/Iaz9VKE1BV
    1usXjq9PI5CQIqyugnmjqZvJhvDwwct0bslg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522891741; bh=oElVec557wuwmNQep22ORuL/ckobdEBOVd4ShUxSDM
    I=; b=bn0lg9iq85gI4eYzp52C3omgQGIjt8ydrwgkgLe18SZFV0gSdzFIup9bwk
    bsMD3ad+OYH2rQ8RRKqSX6ZZWjXJiF9pVy3laK58yi0PUr0w5F1e9kYd0nLPUHyi
    CIxKiaqKei9U5MXdmZ1YBY4WfzRo5ne27V/HylOBnfYQfUwqEQ6cMvr2D4L7Fc8v
    idKdi6cQuHocw62FT5tFw+lzFoqVejmxcvCDYNy5vtQMDiQPZq0ju+hq/k6bHJZJ
    YdyDZBUUGOsMxS/E2FsR51oyNLmUwiq1V66HHxJjNQGYD+2yPBKJJgZfCenUJKlL
    LvVP5PQg4TJpCCxD8R4v2+WopsFA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=VcGLd7OV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CTUFCsNq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=VcGLd7OV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CTUFCsNq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL+z3xtwg59/lCb0xlWOFVUqJXl9nZMkkvC3KixQ5DzeT0fPVvjR1eQ6Yxzo0qKzaIT+8iAjqwroH4qHchoYJIctwWf8/ISMdGyGyV8vNL4IN3Wc2JSQ
    8jiRiXxtRe6pJm7g4ES1hgkQZGhhZwQP5RkF+i09gKU0ZtjYImWytFDt9i9LFaqZ49kNE2077Q82p1/YnA8MIjDXWXVYC5wMzPWjhQ6rEY3UUtFIsV2G8GXT
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=j0yIDaVBfk0A:10 a=Kd1tUaAdevIA:10 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8
    a=Hnm2Hy9fAAAA:8 a=JMnnF-g5AAAA:8 a=VwQbUJbxAAAA:8 a=E1oS_M4MMqSJ6C3lVWMA:9
    a=QEXdDO2ut3YA:10 a=179r5xe0yFUA:10 a=x8gzFH9gYPwA:10 a=5NXnnWeYSB0A:10
    a=qByqzKpv1oajCkFmDuv_:22 a=MIlUOSWcqtxlsnWNI7We:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752625AbeDEB26 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 21:28:58 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46838 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752615AbeDEB24 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Apr 2018 21:28:56 -0400
X-Google-Smtp-Source: AIpwx484DPYL43MSpVGIJ+S94UT+jPSOZRYryCulTyfaoXzwujklyncjrvGPCiIQCe4f31WCArDE2v322Ovg19FyX8w=
MIME-Version: 1.0
In-Reply-To: <CACdnJuuXgpnkMw8oacgadJQL5nE897cw3-RZBqV7df+19NuiMQ@mail.gmail.com>
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
 <CA+55aFwJBGCr-anrdV9N63fUH4V_QJqgr0_fJyHhH=fuqGAoog@mail.gmail.com>
 <CACdnJuvFqXGLsAv1Km3MmdssHBfuH5-C_vG3A4eq4Yuj0HhFBA@mail.gmail.com>
 <CA+55aFzYbpRAdma0PvqE+9ygySuKzNKByqOzzMufBoovXVnfPw@mail.gmail.com>
 <CACdnJuv-VpdhjEe1cMysdHb6Oy67jQqg-_TVHbUrOfH9GmCVvg@mail.gmail.com>
 <CA+55aFwvuoSHhKnn82VnDndZ6oXMJgwHF604gZ=h3ehHyC600A@mail.gmail.com>
 <CA+55aFzJ2sQR13T+20MKEJ5co-f3Ev8rRxQkRCWVaeDSUU3yhQ@mail.gmail.com>
 <CACdnJuti5Riqoi1sesqPALYHq9LT87o4MFj-0Y5BZqqzJ5579g@mail.gmail.com>
 <CA+55aFwhi=gz3HLoGST9--n1_kLJNP6jsf8GSesSFxTDCdPdtQ@mail.gmail.com>
 <CACdnJuuek-sS3esmomNOkjBMV_6VPL2NFCzRd+UGxbZrMe=4nw@mail.gmail.com>
 <CANA3KFXyUH4cEJVTH-yoTwqAnZ+-9h-uboYTzO642Uo78H_wqg@mail.gmail.com> <CACdnJuuXgpnkMw8oacgadJQL5nE897cw3-RZBqV7df+19NuiMQ@mail.gmail.com>
From: Peter Dolding <oiaohm@gmail.com>
Date: Thu, 5 Apr 2018 11:28:53 +1000
Message-ID: <CANA3KFX95osEn-Ny2sCUJ+UG607YCka03Eh3B6VzkLTJ+tzepQ@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Matthew Garrett <mjg59@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, luto@kernel.org,
        David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-api@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 5, 2018 at 2:26 AM, Matthew Garrett <mjg59@google.com> wrote:
> On Tue, Apr 3, 2018 at 11:56 PM Peter Dolding <oiaohm@gmail.com> wrote:
>> On Wed, Apr 4, 2018 at 11:13 AM, Matthew Garrett <mjg59@google.com> wrote:
>
>> > There are four cases:
>> >
>> > Verified Boot off, lockdown off: Status quo in distro and mainline
> kernels
>> > Verified Boot off, lockdown on: Perception of security improvement
> that's
>> > trivially circumvented (and so bad)
>> > Verified Boot on, lockdown off: Perception of security improvement
> that's
>> > trivially circumvented (and so bad), status quo in mainline kernels
>> > Verified Boot on, lockdown on: Security improvement, status quo in
> distro
>> > kernels
>> >
>> > Of these four options, only two make sense. The most common
> implementation
>> > of Verified Boot on x86 platforms is UEFI Secure Boot,
>
>> Stop right there.   Verified boot does not have to be UEFI secureboot.
>>    You could be using a uboot verified boot or
>> https://www.coreboot.org/git-docs/Intel/vboot.html  google vboot.
>> Neither of these provide flags to kernel to say they have been
>> performed.
>
> They can be modified to set the appropriate bit in the bootparams - the
> reason we can't do that in the UEFI case is that Linux can be built as a
> UEFI binary that the firmware execute directly, and so the firmware has no
> way to set that flag.
>
With some of your embedded hardware boot loaders you have exactly the
same problem.   Where you cannot set bootparams instead have to hard
set everything in the kernel image.  This is why there is a option to
embedded initramfs image inside kernel image because some of them will
only load 1 file.

So not using UEFI  you run into the exact same problem.   So lockdown
on or off need to be a kernel build option setting default.   This
could be 3 options Always on, Always off and "Automatic based on boot
verification system status".

https://linux.die.net/man/8/efibootmgr

Also I have a problem here in non broken UEFI implementations -@ |
--append-binary-args that is very simple set the command line passed
into UEFI binary loaded by the firmware with the Linux kernel this
comes bootparams.   Yes using --append-binary-args can be a pain it is
used to tell the Linux kernel where to find the / drive.   So turning
lockdown off by bootparams is down right possible with working UEFI.
There is a lot of EFI out there that does not work properly.

>> Now Verified Boot on, lockdown off.   Insanely this can be required in
>> diagnostic on some embedded platform because EFI secureboot does not
>> have a off switch.    These are platforms where they don't boot if
>> they don't have a PK and KEK set installed.  Yes some of these is jtag
>> the PK and KEK set in.
>
>> The fact that this Verified Boot on, lockdown off causes trouble
>> points to a clear problem.   User owns the hardware they should have
>> the right to defeat secureboot if they wish to.
>
> Which is why Shim allows you to disable validation if you prove physical
> user presence.

Good idea until you have a motherboard where the PS2 ports have failed
and does not support usb keyboard so you have no keyboard until after
the kernel has booted so no way to prove physical presence.   Or are
working on something embedded that has no physical user presence
interface in the boot stages these embedded devices can also be UEFI
with secureboot.  Not everything running UEFI has keyboard,
screen....anything that you can prove physical user presence with
sometimes you have to pure depend on the signing key.

If I am a person who has made my own PK and has my own KEK in UEFI
system I should have the right to sign kernel with lockdown off by
default.   I may need this for diagnostics on hardware without user
interface and I may need this because the hardware is broken and I
have set PK and KEK set by direct firmware  flash access possibly by
jtag or possibly before critical port on motherboard died.

Of course I am not saying that Microsoft and others cannot have rules
that say if using their KEK that you cannot do this.   But if the
machine is my hardware and I have set my own PK and KEK set I do know
what I am doing and I should be allowed to compromise security if I
wish its my hardware.   I should not have to custom hack to do it.
Of course I am not saying that the setting in Linux kernel
configuration system cannot have a big warning that you should not do
this unless you have no other valid option and I am not saying that
the kernel should not log/report if it see what appears to be a
questionable configuration like dmesg "SECURITY ISSUE:  UEFI
secureboot detected enabled kernel built with lockdown disabled system
at risk of comprise".  Something audit tools could check logs for. .

So a kernel booting secureboot with lockdown disabled in kernel
configuration is perfectly fine to log a message that this is the
case.   Always forcing lockdown on because you see UEFI secureboot
will cause issues.

Broken hardware to get around a failed motherboard with UEFI
secureboot locked on you may wish to chain load though a kernel that
you have the means to sign to boot a different OS that is going to be
complex for you to sign due to on going updates.

In my eyes lockdown have a kernel configuration option with 5 options
setting the mode.
1) Automatic: On if a verified boot system is known to the kernel this
may be UEFI secure boot this could be other systems the Linux kernel
can detect in future and off if verified boot is not detected/disabled
or if user approves turning it off by user presence test.,
2) Always on:  That no matter what the Linux kernel turns lockdown on.
No user action or shim action is going to turn it off.
3) On but user/boot bootparams controllable.   So user can give
command line to EFI or other boot-loader to turn it off so no user
presence test and this is need in some cases..
4) Always off:  that is always off no matter what and put error in
dmesg if the Automatic on condition is found.
5) Completely build linux kernel without lockdown code bar with a
single dmesg reporting this.

3-5 all provide security risks all have valid usage reasons.
3 you may want command line controllable you are developing on a
system with user presence cannot be confirmed and you need to be able
to switch between lockdown on and off and you only want to send 1
kernel cross to device in development stages.
4 is simple you have a case where you need lockdown always off line
chain loading on a system where things have gone wrong.
5 can quite simply be diagnostics we have a issue we want to
absolutely confirm that the lockdown code is not the cause.

I can understand if 3-5 are forbin when using Microsoft KEK or other
parties KEKs but those building their own kernels using their own keys
should not have those restrictions it their hardware it thier
configuration if they decide to make it insecure it their choice..


Peter Dolding
