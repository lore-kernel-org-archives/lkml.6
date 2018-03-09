Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-766342-1520608603-2-15172715170358445025
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520608602; b=SlNf4G20CoMspc4y7RsLRRkepLGUkKkFYEZMQUpXjTgnauI
    0zcEH7e6LlpKvlwfZN853j37rC4HaQIZnzvYgiei9EkhxzUkHmKBLV+jf2IC1Wb0
    jFS36Lye6hrxTEMbd0n4fUywdVpISz/AT8ldWRFg1nrrWjYBHVogLZIPhji+bI8C
    /wmRZz5VfK4OV0gCcZqGCXlxjnhHWQz3S23p/gKaD9bftYW2R+LGtQykz1RhXZAb
    I0w9G+dzKzCQC9WQj1vN1d1g+PwxIzcCDlN39E198H7r1vn8CgiUulwqpaWzDZLr
    0Zm4VajZ7TlD8bq+dwAMD+3cPBwVfEdO9JlX5Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520608602; bh=+vJd85D/lAuI2tYnQpusEsSC77r0XWjsdNOA2xQ7W94=; b=w
    FNuzGprFgYEg5j8OQZNCUbjkTYtM8yZ8Yu2Y8VKOCSiwCUZIh2jjoqr2/YYVFloe
    Dw/pFlHvc/8SeeZbQPZHIdakqKOKDQJbe0eV251lyRXJf3kp2si3bu6MJwTDOw/i
    zwYQscdaRX/r+Z1uZn6l8TnZtkaFmQooLpoK88H/S7fG9ZshB9/lTqMA9NhGZ+fL
    AV9G/pBkTSzJL9FxlkN4MAN0DOlxiVNZ9UYAH6v3gDfaJ85WjadqmqqSK+AAj8ok
    4A55JC3rHQwwbiI3LD3FcIftvjZQ9b91dj4YGaG2Js26iEThnt5+eXiUU2It7tBU
    lSeC0RWCOD/EnJ9UGFZdg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751147AbeCIPQk convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Fri, 9 Mar 2018 10:16:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:46696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751102AbeCIPQj (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 9 Mar 2018 10:16:39 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3EEB21799
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELtxuTrEIkdRI4dO0/lNN/C3dX3H3KTVjSpQr3D7TMG69r0bNiSi3kgjIKOq8YzQVah0PWePBX+o1tewABUz7Kk=
MIME-Version: 1.0
In-Reply-To: <87478c51-59a7-f6ac-1fb2-f3ca2dcf658b@fb.com>
References: <20180306013457.1955486-1-ast@kernel.org> <CAGXu5j+Q=S5sw9N5avyByxi2ekM6povT5Tajjhdb6D9g9ggKxQ@mail.gmail.com>
 <CALCETrX=Vfk1T-XegwnjtUqeEsyUFXH1744d0yGkufQvDA5xkQ@mail.gmail.com>
 <CA+55aFwJPDub+tdShCgeTz3UejeskVE7_x+eQLq75mCjYPyP8w@mail.gmail.com>
 <CAGXu5j+B4wgT3ovynAxa1zwCeROfN5zK45tL1FUnFh0sg8M5AA@mail.gmail.com>
 <CA+55aFwRGDPvaCUgMtqnQHb2PZ77JSMQMQVf1znSN+PiV7NR-Q@mail.gmail.com>
 <C94A45E9-54A0-446D-86D6-82D06E2A35CD@amacapital.net> <87478c51-59a7-f6ac-1fb2-f3ca2dcf658b@fb.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 9 Mar 2018 15:16:17 +0000
X-Gmail-Original-Message-ID: <CALCETrWKLB4e8Cw6ZRiDP535=HzoQJczsEMEpytstveO15mAMg@mail.gmail.com>
Message-ID: <CALCETrWKLB4e8Cw6ZRiDP535=HzoQJczsEMEpytstveO15mAMg@mail.gmail.com>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf binaries
To: Alexei Starovoitov <ast@fb.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Djalal Harouni <tixxdz@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>> On Mar 8, 2018, at 9:08 PM, Alexei Starovoitov <ast@fb.com> wrote:
>>
>> On 3/8/18 7:54 PM, Andy Lutomirski wrote:
>>
>>
>>
>>> On Mar 8, 2018, at 7:06 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>>
>>>
>>> Honestly, that "read twice" thing may be what scuttles this.
>>> Initially, I thought it was a non-issue, because anybody who controls
>>> the module subdirectory enough to rewrite files would be in a position
>>> to just execute the file itself directly instead.
>>
>> On further consideration, I think there’s another showstopper. This patch is a potentially severe ABI break. Right now, loading a module *copies* it into memory and does not hold a reference to the underlying fs. With the patch applied, all kinds of use cases can break in gnarly ways. Initramfs is maybe okay, but initrd may be screwed. If you load an ET_EXEC module from initrd, then umount it, then clear the ramdisk, something will go horribly wrong. Exactly what goes wrong depends on whether userspace notices that umount() failed. Similarly, if you load one of these modules over a network and then lose your connection, you have a problem.
>
> there is not abi breakage and file cannot disappear from running task.
> One cannot umount fs while file is still being used.

Sure it is. Without your patch, init_module doesn’t keep using the
file, so it’s common practice to load a module and then delete or
unmount it. With your patch, the unmount case breaks. This is likely
to break existing userspace, so, in Linux speak it’s an ABI break.

>
>>
>> The “read twice” thing is also bad for another reason: containers. Suppose I have a setup where a container can load a signed module blob. With the read twice code, the container can race and run an entirely different blob outside the container.
>
> Not only "read twice", but "read many".
> If .text sections of elf that are not yet in memory can be modified
> by malicious user, later they will be brought in with different code.
> I think the easiest fix to tighten this "umh modules" to CAP_SYS_ADMIN.

Given this issue, I think the patch would need Kees’s explicit ack. I
had initially thought your patch had minimal security impact, but I
was wrong Module security is very complicated and needs to satisfy a
bunch of requirements. There is a lot of code in the kernel that
assumes that it’s sufficient to verify a module once at load time,
your patch changes that, and this has all kinds of nasty interactions
with autoloading.  Kees is very reasonable, and he’ll change his mind
and ack a patch that he’s nacked when presented with a valid technical
argument.

But I think my ABI break observation is also a major problem, and
Linus is going to be pissed if this thing lands in his tree and breaks
systems due to an issue that was raised during review. So I think you
need to either rework the patch or do a serious survey of how all the
distros deal with modules (dracut, initramfs-tools, all the older
stuff, and probably more) and make sure they can all handle your
patch.  I'd also be concerned about anyone who puts /lib/modules on
less reliable storage than they use for the rest of their system.  (I
know it's quite common to have /boot be the only non-RAID partition on
a system, but modules don't generally live in /boot.)

Also, I think you really ought to explain how your approach will work
with MODULES=n or convince Linus that it’s okay to start adding core
networking features that don’t work with MODULES=n and can't be built
into the main kernel image.
