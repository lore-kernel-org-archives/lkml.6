Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755457AbeDCWv0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 18:51:26 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40385 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753691AbeDCWvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 18:51:23 -0400
X-Google-Smtp-Source: AIpwx49wlURlqg6cY+j4yJeHZ+Y423tZYp3rfg4sK4dusrwr9dsJ+e1IfqPSc8vGO895mGT3fQTCdR6xhjFwoa5baqs=
MIME-Version: 1.0
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
 <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com>
 <9758.1522775763@warthog.procyon.org.uk> <CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com>
 <13189.1522784944@warthog.procyon.org.uk> <CALCETrX4CuHVpn38R24TCcJgCBLSbh-sOD-qcD5kYF8Zo53ZJw@mail.gmail.com>
 <9349.1522794769@warthog.procyon.org.uk> <CALCETrV6E+r942K+fu-ALNf-x6qOZ3o1hNKGeu7qEMvr8sMP9A@mail.gmail.com>
 <CA+55aFxKzxdRZthzaokaGPAsWCp3a-p3aVfJSutF+9Fp9sbaVA@mail.gmail.com>
In-Reply-To: <CA+55aFxKzxdRZthzaokaGPAsWCp3a-p3aVfJSutF+9Fp9sbaVA@mail.gmail.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 03 Apr 2018 22:51:11 +0000
Message-ID: <CACdnJusSfwULV-ubvgtYd8G_cTF4LnJ4DAeTCux4XRhHKVpBUw@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: luto@kernel.org, David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, jmorris@namei.org,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-api@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 3, 2018 at 3:46 PM Linus Torvalds
<torvalds@linux-foundation.org>
wrote:

> For example, I love signed kernel modules. The fact that I love them
> has absolutely zero to do with secure boot, though. There is
> absolutely no linkage between the two issues: I use (self-)signed
> kernel modules simply because I think it's a good thing in general.

> The same thing is true of some lockdown patch. Maybe it's a good thing
> in general. But whether it's a good thing is _entirely_ independent of
> any secure boot issue. I can see using secure boot without it, but I
> can very much also see using lockdown without secure boot.

> The two things are simply entirely orthogonal. They have _zero_
> overlap. I'm not seeing why they'd be linked at all in any way.

Lockdown is clearly useful without Secure Boot (and I intend to deploy it
that way for various things), but I still don't understand why you feel
that the common case of booting a kernel from a boot chain that's widely
trusted derives no benefit from it being harder to subvert that kernel into
subverting that boot chain. For cases where you're self-signing and feel
happy about that, you just set CONFIG_LOCK_DOWN_IN_EFI_SECURE_BOOT to n and
everyone's happy?
