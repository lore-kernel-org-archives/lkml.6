Return-Path: <oiaohm@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522989774; cv=none;
        d=google.com; s=arc-20160816;
        b=rzFsibfZQtN4GEdFwd3HXXz7W85VsGPwtN8W/DuX6lP8aBqBip7Xk2a9yqG/tuzMGG
         pak497BIfYZ3E3k40i7tyv3TaIK2ro5ccHk811yDykcT6eeNIX3zveNsPihHYzAl3A/J
         8rPd+GM+q+LJrOZ2zJej77P56odpEMimhU1BVE/ZDa+a1QOFytSxFc9m9H46kcr2U2R7
         3zPa2cBpfXPJPVSv6dApzxmePnHu75DD11jrlEYuB3BUUH4CkVJHS3tQzT4ek1MIntHr
         LCGs5Y7s8aLhwkHg9M/24T8gEmUqyZTmitTtM4gn/RKTXf4xd6zkEJ317l/+VrG8eFSh
         F5/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=IC3wCHqBJ1IDCMVUwkcS5/yNQcCPLX/R2fB55uA+9/I=;
        b=QZ4+cVW0WP4jzAo1FXO6lpXo0KoZn5gJIfKv2u/trlekQB7fzuGmgS8ngyhxtgwTGx
         XcprxDJ6tTs6lSMix+iPUytWWqFiG5ne8SX4jeiZMD6750PljtLxiJtZUnTx48wxobKe
         TWrPKmfX6ellfnth3vK7YYi36r3fckjy6mrfjujmcA2O4j8mZMtue/vbDrwKaITfetcQ
         aWkK5Nw5TLcO+XZw7dLAq0wmVq4gcPF9UujCuNfHuXZUfW1IgS6UlAqXgkNp32qAFbXi
         LWfq8GWUqE81yW0fSA1C8czHfc+8PWc4FR2gHsdaXlKEDeTYoBb0G4B4bbqsxYns+OXQ
         YrVg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mqALxqd6;
       spf=pass (google.com: domain of oiaohm@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=oiaohm@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mqALxqd6;
       spf=pass (google.com: domain of oiaohm@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=oiaohm@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48ZOp/eXeTY/Y6a9d9kZ72qhjLGtUmxW6FIKYMewUvwn6n8PlQVqdt49EfBlNId+MsSoNCj1B5HExHMywaWpLY=
MIME-Version: 1.0
In-Reply-To: <20180404184255.exdrtpqnxlqme7tl@redhat.com>
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
 <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com>
 <CACdnJuutJeeaaB2kwma0MMd9uDDbKavoHEk4koDLe1M6gYZWXQ@mail.gmail.com>
 <CALCETrVR_EcbKv5-4AR6Zm02XHhJQQGNDeO8FGkMbYozmuDTJw@mail.gmail.com> <20180404184255.exdrtpqnxlqme7tl@redhat.com>
From: Peter Dolding <oiaohm@gmail.com>
Date: Fri, 6 Apr 2018 14:42:53 +1000
Message-ID: <CANA3KFW_7VVm6=Sg=gu8eE0b2+NO_4MYhmxRg_UYOOYeDj83Fg@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Peter Jones <pjones@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>, Matthew Garrett <mjg59@google.com>,
	David Howells <dhowells@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	James Morris <jmorris@namei.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Justin Forbes <jforbes@redhat.com>,
	linux-man <linux-man@vger.kernel.org>, joeyli <jlee@suse.com>,
	LSM List <linux-security-module@vger.kernel.org>,
	Linux API <linux-api@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
	linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596848216178927191?=
X-GMAIL-MSGID: =?utf-8?q?1596970525999872206?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>
> There's no inherent difference, in terms of the trust chain, between
> compromising it to use the machine as a toaster or to run a botnet - the
> trust chain is compromised either way.  But you're much more likely to
> notice if your desktop starts producing bread products than if it hides
> some malware and keeps on booting, and the second one is much more

> That is to say, as a result of the way malware has been written, our way
> of thinking about it is often that it's a way to build a boot loader for
> a malicious kernel, so that's how we wind up talking about it.  Are we
> concerned with malware stealing your data?  Yes, but Secure Boot is only
> indirectly about that.  It's primarily about denying the malware easy
> mechanisms to build a persistence mechanism.  The uid-0 != ring-0 aspect
> is useful independent of Secure Boot, but Secure Boot without it falls
> way short of accomplishing its goal.
>
> --
I am sorry the issue here this is really expanding Secure Boot to
breaking point.

Yes a person wants a secure system having the boot parts verified by
some means and using a lockdown is advantage.

Problem comes in with the idea that UEFI Secure Boot and lockdown are linked.

If I am running windows and linux on the same machine Secure Boot need
to be on so windows run happy.

Remember its my machine.  If I wish to compromise security on my
machine because it make sense I should be allowed to,

A proper lockdown would prevent you from messing with ACPI tables it a
very creative hack have kernel load a DSDT and have it from ring zero
turn bits in the kernel off.

The reality here is we need to be able to operate without lockdown due
to how badly broken some hardware it to configure system.

Yes the need to include option to push button to disable secure boot
is required due to how badly broken this stuff is.   Of course this
does not address the issue that if I am working on a system from
remote or embedded where I don't  have the push button to turn off as
a option this is still a problem.


Effective lockdown has to protect linux kernel boot parameters,
initramfs and other bits from being modified as well.   This lead us
to problem with the broken hardware in a machine we cannot turn secure
boot off we still need to perform all these alterations.


We do not live in a world of perfect computer hardware so at this
stage proper unattackable secureboot cannot be done.


We would be better off putting effort into improve means with UEFI of
adding own KEK.   This is so that only boot loaders and kernels from
the vendors user has approved in fact to work.  There could also be a
configuration KEK that gets disabled after all the required operating
systems are installed.    So Microsoft non OS KEK makes sense to be
the configuration rule breaking KEK but the current deployments of
UEFI don't have a off switch option on it.


One KEK for everyone who is not Microsoft to boot with is highly insecure.


UEFI secureboot falls way short in the validation department currently
because too much is validated under one KEK key.

UEFI also fall short due to failing to provide a system to protect
boot parameters that can alter OS behaviour and make a secure kernel
insecure this include kernels with this lockdown patches,


Really you need to compare UEFI secureboot vs boot loader and /boot on
a read only media.   Every where you can change something in the UEFI
secureboot without is being signed that you cannot in the read only
media of the boot loader and /boot is a defect in the UEFI secureboot
design and implementation.

If boot parameters were properly secured there would be no need for
lockdown query if UEFI was in secureboot mode or not.

Also lockdown being on and kernel and boot loader not running secured
still would provide extra item attacker has to get past.

So fairly much remove the EFI interrogation patches and work with UEFI
to fix it properly.   Hacking around these UEFI defects means we will
end up being stuck with them and the system still not being properly
secured.


Peter Dolding
