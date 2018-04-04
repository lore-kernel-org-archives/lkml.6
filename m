Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-470151-1522858666-2-13977298848853117818
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522858665; b=A+yivMRBfWJJPyNk+DI0VWfWfUsu80vUQFG3MrlZfMFTfDLoZq
    4/fp7RsVWzPwMa/cGc06q96NH+Vr2IFZVBcJwC81Lsdn86hzOq524SVWOZb1if+j
    jauKcjkRhbMnilRoNPaCiXD0LBiyuH7Aml6lotLtsge26u/E/YBTLllG0xDrv7k+
    2xbSUM/HjIvtu/jWyWhY/rr7kBWxFhySdCjQFUxlFdpVbfMQHLfLClpyNN+qIdhF
    Fb14aPKXUQtiK+ezc0I4yjffGSZOqxubTX2f5ejCKiJb2lxD50tPlKugIMmNXQ0E
    NOSyvszwvcD7qgE9dLuLsvpBEf4IhHR1iosA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:in-reply-to:references:to:cc:subject
    :mime-version:content-type:content-id:date:message-id:sender
    :list-id; s=fm2; t=1522858665; bh=699DEaoExA2+QHqGHQBvJA3osocusm
    RJCTizcUJpEVI=; b=oGnDjkcsH5WH3D8M05gPA1TzI7Ah2wZ70a0rXXwyIGnOVd
    5QTalAqdoQgq/eUFe4LsW873vw3iego9OI8VlX/sXJa8lgWEPsASrjJv8sDuZpHI
    Bw7YtCovSnnkqb2aizXVZWs/efigHVue5jeNyKTbOz9v2zU6kc/V4kaLA3wtxMOT
    Tf/gmV3/jMBPzCRt7BR2hS5nXet7hbJ/4ava2UDCtj68IjW65kJQjITFLf2iEop7
    OdUHRF3OohJXTZSwHxoCdHc6XHjfzR63/G0B8IqtZj92meYFelPiRaPTuDBM8c5h
    u50bAW61vpON3652Rx29BFC98XI7K08apFDZqEvw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCVpzZe/rrq0jS4URRhdTgC41EO+PHuyW+sBTAGKqFvuL1buHKIV+TeqThJ2nFm0A8jbqb3QF+RyY+nhtuozkDAOcRV0f9K9xg+3AAzRUnLTJBdHoWMY
    9fBSjfxqqxe7Fd/zSTN8EWI/3BmKJBNIkwPZhJx9+HZ3vgPFAI8ZD/mD3nM3iN2+Epiqvb51aTHqAGe+YNe8km4T+c1bHvTrn2IET6E2IFhdTqeIwlPWiBhX
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=kQ8WpZnP7M6q8YVFnS8A:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbeDDQR3 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 12:17:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40830 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751606AbeDDQR1 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 4 Apr 2018 12:17:27 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CALCETrUVQLDC6_VEvuAbdCOuGrmcxohqTB6P8eyNojm9AryNkg@mail.gmail.com>
References: <CALCETrUVQLDC6_VEvuAbdCOuGrmcxohqTB6P8eyNojm9AryNkg@mail.gmail.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: dhowells@redhat.com,
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
Subject: Re: An actual suggestion (Re: [GIT PULL] Kernel lockdown for secure boot)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1118.1522858644.1@warthog.procyon.org.uk>
Date: Wed, 04 Apr 2018 17:17:24 +0100
Message-ID: <1119.1522858644@warthog.procyon.org.uk>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Andy Lutomirski <luto@kernel.org> wrote:

> Since this thread has devolved horribly, I'm going to propose a solution.
> 
> 1. Split the "lockdown" state into three levels:  (please don't
> bikeshed about the names right now.)
> 
> LOCKDOWN_NONE: normal behavior
> 
> LOCKDOWN_PROTECT_INTEGREITY: kernel tries to keep root from writing to
> kernel memory
> 
> LOCKDOWN_PROTECT_INTEGRITY_AND_SECRECY: kernel tries to keep root from
> reading or writing kernel memory.

In theory, it's good idea, but in practice it's not as easy to implement as I
think you think.

Let me list here the things that currently get restricted by lockdown:

 (1) Manipulation of devices to access the kernel image:

	- Ioports & ioperm
	- /dev/ports
	- /dev/mem
	- PCI Bar
	- Some debugfs files
	- pcmcia_cis
	- Driver hardware parameters
	  - ISA drivers
	  - TIOCSSERIAL
	  - SCSI EATA driver
	- testmmiotrace
	- firmware

 (2) Direct kernel memory modification:

	- /dev/mem
	- /dev/kmem
	- bpf
	- kprobes

 (3) Direct kernel memory reading:

	- /dev/mem
	- /dev/kmem
	- /dev/kcore
	- bpf
	- kprobes
	- perf

 (4) Indirect kernel access:

	- Modules
	- MSRs
	- Suspend to disk
	- ACPI (custom_method, RSDP, table override, error injection)

 (5) Kexec.

Note that /dev/mem can be used to access MMIO devices (I'm not sure about
/dev/kmem, though).  Even reads through /dev/mem can do this.  I'm not sure
whether that's sufficient to actually affect a modification, though.

Debugfs is particularly icky.  It contains at least a couple of thousand
files, a few of which provide direct access to hardware, some of which change
driver behaviour and some of which just give information.  Auditing that pile
isn't something I really want to have to do.  I'd rather just turn the whole
lot off, but got persuaded otherwise by people who have been using it to
provide mechanisms that programs rely on - hence the only allow files that
have 0444 (and even that is iffy as some of these files have side effects and
write ops anyway).

> 2. The kexec protocol gets a new flag min_lockdown_level.  A kexeced
> kernel will boot with at least that lockdown level regardless of its
> configuration.  kexec sets min_lockdown_level to the running kernels'
> lockdown_level.  Some future API could allow kexec with a higher
> min_lockdown_level.  An even fancier future API could allow a
> LOCKDOWN_PROTECT_INTEGRITY_AND_SECRECY kernel to kexec with
> min_lockdown_level == LOCKDOWN_PROTECT_INTEGRITY if there's some
> mechanism that guarantees that memory gets zeroed in the process.

Note that on x86 we already have an allocated flag for passing the secure boot
flag from kexec/bootloader to the kernel being booted, and what you're
proposing ought to be redundant.  See boot_params::secure_boot.

> 3. All the bpf and tracing stuf, etc, gets changed so it only takes
> effect when LOCKDOWN_PROTECT_INTEGRITY_AND_SECRECY is set.

Uh, no.  bpf, for example, can be used to modify kernel memory.  I think only
the following are safe from being able to talk directly to devices:

	/dev/kmem (O_RDONLY only)
	/dev/kcore
	perf
	some debugfs files

> This removes a giant annoyance on distro kernels that are likely to want to
> enable LOCKDOWN_PROTECT_INTEGRITY.

*shrug* Distros have been running with the full set for a while.  I haven't
seen many complaints.

> If you load a key into the kernel, and you want to keep that key safe, you
> can enable LOCKDOWN_PROTECT_INTEGRITY_AND_SECRECY at that time.  After all,
> if root is compromised before that, root can just remember a copu of the key
> in user memory or email it to someone.

If your key needs to be truly protected, it should never be seen unencrypted
in userspace, rather it should be decrypted in the TPM and then retained in
kernel memory only.

> ...
> 6. There's a way to *decrease* the lockdown level below the configured
> value.  (This ability itself may be gated by a config option.)
> Choices include a UEFI protected variable,

By turning secure boot off, maybe?

> an authenticated flag passed by the bootloader,

Authenticated how?  How do you stop the running system from passing this to
the bootloader next time it is run?  I guess you're thinking of a bootloader
"command" that can only be passed by someone sat at a keyboard and never read
from the config file.

> and even just some special flag in the boot handoff protocol.

We already have that with secure boot.

> It would be really quite useful for a user to be able to ask their
> bootloader to reduce the lockdown level for the purpose of a particular boot
> for debugging.

This I shall grant you - but you have to be able to prevent an attacker inside
the system from making use of it.  There's a SysRq provided to drop out of
lockdown mode - in theory only usable if you're sat at a wired keyboard
connected to the computer.

> 7. kexec does not attempt to think about "secure boot" at all.
> They're totally separate.

Except that they're not.  The boot_params flag must be set to something by
kexec on x86 for transfer along the chain.  However, we can leave secure boot
out for now - that can be treated as a separate issue.

Note that whether you like it or not, distribution kernels already work this
way and propagate the boot_params flag over kexec.

> What do you all think?  I think that this checks basically all the
> boxes, is a lot more user friendly than the current patchset or what
> distros do, and actually makes some sense from a security perspective.

You haven't really defined well what's allowed in _INTEGRITY mode verses
_SECRECY mode.

I'm currently in the throes of modifying my patchset to make it more inline
with what Linus mandates: dropping the enablement from secure boot; dropping
the propagation of the flag over kexec; providing a config option to make it
mandatory.  There is already a command line option to trigger it.

David
