Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2791443-1523463886-2-17521473843033948890
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523463884; b=EPmjw3wxpMCBdyHHa0XFsowpU/YjGv5OijMtU7S7hAUrZifghG
    geR18yWvZ+d7d+yHD+MOUhPFwAhrIZ1xY9SiOy+KZ1CS1wksZeJLOaLT198nz64Z
    XDksy/55aXZKoBVEMKXoJ2l677Z+ROgpP4ZXfn/3qrp5pGLEcryDgZOqP1BsJXwn
    kCYJhfBn+rz+pzmWQad+8htmWJcms2mwLoeuTPYBbuUxL+k/VwFCFcy7vMie2wsW
    J8Z5XYe39T69yE4EyNgdzsN1kxy/UluCV1DzHrtfL3Zg0/PmmR20m+R9WGFD5X3J
    mkItxYWMKMO0eMz3tTJeeNut9hDPIZ8g7OUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1523463884; bh=e7WS4ik/5I58ACKoyBFsPtemgiQudV
    N0xRuAHR59VEw=; b=Ldj+EXqJcE6vdlscVP595HBmmOWkzYGBHgcgv0rOnPCzwj
    CGG+JprBS3uxnmoHZlgs2N/B2VuzdcS5ts3nT4gw9s+pB8T7nsd9D1jLhB7YjQHg
    kE69nxL38qMzIHRxiCLV05o/FTG67ee40gIl/buNiujzMbHqPOKBb5LCN8rYw0VS
    GSvSGyHysIdSzLacgEmQeXzFrLKkid91iFWayDzl9+8xg/NRwOhl4f7cq+ZDCMg+
    yO1UPHK5XU4bZb12uI7EWnHgac/d87a76GRM5PADIdAM7rppPlRKeydaY5VWA8UT
    2KzkG+xXjyu1k8pDUOk5uMb75ln6cMPf3pa0tMGw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFegU4GA3D7UsvaEIwrf3Lsr+L+ZfWGFy7AaPYQFBWxo7IMzz9ErkG+8zjIa2+7ezsAIOeBMdUmJjsBB332k7SHP5DRqGn/8YiLqtv7bUHygZeWz4o4v
    ad6vQ0LwHJ+Z9Sh9WISwJjOR8SfHCkOIMiTVzyhjb8p+yxcg6P/cx3hUpQ1pVIWcIFY0gLdaYajTnO3ojgFoCm8Pyr6kc3ha12/cWzCsTqI3E752I6Qh6lC/
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ZIsy-dp9ra-xQLMrs1sA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752798AbeDKQYm (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 12:24:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752211AbeDKQYl (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Apr 2018 12:24:41 -0400
Subject: [PATCH 00/24] security: Add kernel lockdown
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, linux-security-module@vger.kernel.org
Date: Wed, 11 Apr 2018 17:24:39 +0100
Message-ID: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Hi Linus,

I've modified my lockdown mode patches to remove the EFI/secure-boot
interaction and to ignore kexec.  Would you be willing to accept this?

David
---

Here's a set of patches to institute a "locked-down mode" in the kernel.
If enabled, the lockdown can be triggered either by configuration (in which
case it cannot be lifted) or by command line (lockdown=1).  In the latter
case, there's an option to allow it to be lifted by a SysRq key on an
attached keyboard.

Three config options are provided:

 (1) CONFIG_LOCK_DOWN_KERNEL makes lockdown mode available.

 (2) CONFIG_LOCK_DOWN_MANDATORY builds the kernel with lockdown mode
     enabled at compile time and removes the ability to disable it.

 (3) CONFIG_ALLOW_LOCKDOWN_LIFT_BY_SYSRQ will allow a SysRq combination to
     lift the lockdown.  On x86 this is SysRq+x.  The keys must be pressed
     on an attached keyboard.  Echoing into the trigger file won't work.

Inside the kernel, kernel_is_locked_down() is used to check if the kernel
is in lockdown mode.

For the moment, there is only one mode that locks everything down.  Andy
would prefer that there be two modes, one of which allows the kernel to be
read, but not modified and the other which allows neither.  Modifying this
later to allow what Andy wants wouldn't be particularly hard as there isn't
much additional functionality that this would enable (ie. /dev/kmem,
/dev/kcore, bpf and perf).

A manual page, kernel_lockdown.7, is proposed, to which people will be
directed by messages in dmesg.  This lists the features that are restricted
amongst other things.

The patches are tagged here:

	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
	tags/lockdown-20180410
	
The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=lockdown

---
David Howells (11):
      Add the ability to lock down access to the running kernel image
      Enforce module signatures if the kernel is locked down
      Prohibit PCMCIA CIS storage when the kernel is locked down
      Lock down TIOCSSERIAL
      Lock down module params that specify hardware parameters (eg. ioport)
      x86/mmiotrace: Lock down the testmmiotrace module
      Lock down /proc/kcore
      Lock down kprobes
      bpf: Restrict kernel image access functions when the kernel is locked down
      Lock down perf
      debugfs: Restrict debugfs when the kernel is locked down

Josh Boyer (2):
      hibernate: Disable when the kernel is locked down
      acpi: Ignore acpi_rsdp kernel param when the kernel has been locked down

Kyle McMartin (1):
      Add a SysRq option to lift kernel lockdown

Linn Crosetto (2):
      acpi: Disable ACPI table override if the kernel is locked down
      acpi: Disable APEI error injection if the kernel is locked down

Matthew Garrett (7):
      Restrict /dev/{mem,kmem,port} when the kernel is locked down
      kexec_load: Disable at runtime if the kernel is locked down
      uswsusp: Disable when the kernel is locked down
      PCI: Lock down BAR access when the kernel is locked down
      x86: Lock down IO port access when the kernel is locked down
      x86/msr: Restrict MSR access when the kernel is locked down
      ACPI: Limit access to custom_method when the kernel is locked down

Mimi Zohar (1):
      ima: require secure_boot rules in lockdown mode


 arch/x86/include/asm/setup.h        |    2 +
 arch/x86/kernel/ioport.c            |    6 +-
 arch/x86/kernel/msr.c               |   10 +++
 arch/x86/kernel/setup.c             |    2 +
 arch/x86/mm/testmmiotrace.c         |    3 +
 drivers/acpi/apei/einj.c            |    3 +
 drivers/acpi/custom_method.c        |    3 +
 drivers/acpi/osl.c                  |    2 -
 drivers/acpi/tables.c               |    5 ++
 drivers/char/mem.c                  |    2 +
 drivers/input/misc/uinput.c         |    1 
 drivers/pci/pci-sysfs.c             |    9 +++
 drivers/pci/proc.c                  |    9 +++
 drivers/pci/syscall.c               |    3 +
 drivers/pcmcia/cistpl.c             |    3 +
 drivers/tty/serial/serial_core.c    |    6 ++
 drivers/tty/sysrq.c                 |   19 ++++--
 fs/debugfs/file.c                   |   28 +++++++++
 fs/debugfs/inode.c                  |   30 +++++++++
 fs/proc/kcore.c                     |    2 +
 include/linux/input.h               |    5 ++
 include/linux/kernel.h              |   32 ++++++++++
 include/linux/sysrq.h               |    8 ++-
 kernel/bpf/syscall.c                |    3 +
 kernel/debug/kdb/kdb_main.c         |    2 -
 kernel/events/core.c                |    5 ++
 kernel/kexec.c                      |    7 ++
 kernel/kprobes.c                    |    3 +
 kernel/module.c                     |   56 +++++++++++++-----
 kernel/params.c                     |   26 +++++++-
 kernel/power/hibernate.c            |    2 -
 kernel/power/user.c                 |    3 +
 security/Kconfig                    |   34 ++++++++++-
 security/Makefile                   |    3 +
 security/integrity/ima/ima_policy.c |   39 +++++++++---
 security/lock_down.c                |  112 +++++++++++++++++++++++++++++++++++
 36 files changed, 443 insertions(+), 45 deletions(-)
 create mode 100644 security/lock_down.c

