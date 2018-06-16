Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA94C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 23:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6638320895
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 23:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N5Orh6+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6638320895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756890AbeFPXXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 19:23:09 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:54071 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752975AbeFPXXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 19:23:08 -0400
Received: by mail-it0-f66.google.com with SMTP id a195-v6so7405465itd.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jun 2018 16:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=frtfY1Dslq+xwsLhGz9fsCpwTxmxTpIOizXMTdC1BzQ=;
        b=N5Orh6+2Nu2fS+WZs1Enj3UxVZqB6Ou1EfaaBKEWtm6pb79lrn9euYQd2p3onSxR91
         Cv+0q8YaJIm/4Y7a3sWkVO364RJ6ryQx3JOeXsdkzfIdeckxfa2Gtj9Zt3IuCjhIWfep
         TuhrBbPJn8QWKHTu1qFnoU9EZWoeu6wRWpmbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=frtfY1Dslq+xwsLhGz9fsCpwTxmxTpIOizXMTdC1BzQ=;
        b=nkvplbSx3mxExllX2hoafb9hQizU/2/63mXIhzHFopbEddEjkKkzCWzgFSP4mrBO6A
         GI8CmDYXJ9EThoF/+pZR7ea6iDIV/OsW2k1ZQsoDZIUBmv7j/8/O4xLutKzilrs2Ogef
         mvzMFLF+1MGaPvU5SzRXfUoUUSRJTHnCsOjTAVjmDo6jVno6tIHhiq34vLK+GPQg2zZ8
         ZoUyHWqRplUws4TP63dUwJIKCobm52MqPawxj35/swYZWGR1efSiPTtUUbPFW1fZVZJM
         fevC49tKNQ20pp1eE6N+65zQXZV79QuHdwjrdhnZFDmoJ/9kXhuuZSg7URQx5f7vNG2L
         O4yg==
X-Gm-Message-State: APt69E2O1dLVeDD9NjpReTyZYDjWEOuxKb+W93ATWUpIFyNFursZx8yU
        yEPyksDsQiITqQgYVmtnkXUcZgekzLX/g83Y+m0bm0YJ
X-Google-Smtp-Source: ADUXVKKY7t1sZTi6AGA6ZtteZ3lswfK1wtnpr89T9pyLOlPdeFNqq+FCWZw0+AjXyHyARoH5F3c6iZIYiHYqTGaetLE=
X-Received: by 2002:a24:8046:: with SMTP id g67-v6mr5530900itd.16.1529191387089;
 Sat, 16 Jun 2018 16:23:07 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Jun 2018 08:22:55 +0900
Message-ID: <CA+55aFw34Dh6p0qAZ_Ja=fjuJ89ojZZTWtmrRPKmB1QuP3C7hw@mail.gmail.com>
Subject: Linux 4.18-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You may think it's still Saturday for me, and that  I should give you
one more day of merge window to send in some last-minute pull
requests, but I know better. I'm in Japan, and it's Sunday here. Plus
I hope to spend much of this Sunday on a boat (assuming the swells
allow it), so I'm closing the merge window early morning rather than
in the afternoon.

So here we are - no more merge window, so please don't even try to
send me updates any more. Just fixes, please.

This release looks fairly regular - both in size and in behavior. We
actually have managed to shrink things a bit more this release too, as
people have clearly gotten excited about the whole "let's remove old
unused code". It's not nearly as noticeable as it was for 4.17, but
rc1 has actually caused a bit of shrinkage:

 12356 files changed, 505769 insertions(+), 612979 deletions(-)

where one component of that is the removal of Lustre.

The removal of Lustre may not be all that notable, because it does
look like a lot of the development has been happening out of tree,
which may be why it never really ended up working as well as people
hoped in the staging tree. Greg clearly got pretty frustrated about
it, so now it's gone.

But there's a few other drivers that are gone too, sometimes because
the hardware was never actually released to a wider public. You can go
see the details in the git history.

Anyway, the  real work is obviously all the  fixes and new features,
and there's a lot of that too. Much too much to have an exhaustive
shortlog, so as usual for my merge window close emails, what's
appended is just my "merge shortlog", mentioning the trees that I've
pulled, without any of the details from the individual commits. And as
always, the credited person on the list below is the maintainer I've
pulled from, which is not necessarily at all the same as the developer
that write the code.

We had 1500+ developers attributed as authors in this merge window,
and the below lists 91 maintainers, so just think about that for a
while.

Anyway, go out and test,

               Linus

---

Al Viro (11):
    dcache updates
    rmdir update
    procfs updates
    misc vfs updates
    dcache lookup cleanups
    aio updates
    proc_fill_cache regression fix
    aio iopriority support
    aio fixes
    compat updates
    AFS updates

Alex Williamson (1):
    VFIO updates

Alexandre Belloni (1):
    RTC updates

Andrew Morton (2):
    updates
    more updates

Arnd Bergmann (1):
    inode timestamps conversion to timespec64

Bartlomiej Zolnierkiewicz (1):
    fbdev updates

Benson Leung (1):
    chrome platform updates

Bjorn Andersson (3):
    hwspinlock updates
    remoteproc updates
    rpmsg updates

Bjorn Helgaas (2):
    PCI updates
    more PCI updates

Bob Peterson (1):
    gfs2 updates

Boris Brezillon (1):
    MTD updates

Borislav Petkov (1):
    EDAC updates

Bruce Fields (1):
    nfsd updates

Catalin Marinas (1):
    arm64 updates

Christoph Hellwig (1):
    dma-mapping updates

Corey Minyard (1):
    IPMI updates

Dan Williams (1):
    libnvdimm updates

Darren Hart (1):
    x86 platform driver updates

Darrick Wong (2):
    xfs updates
    more xfs updates

Dave Airlie (3):
    drm updates
    drm msm updates and misc fixes
    amd drm fixes

David Miller (5):
    networking updates
    IDE updates
    sparc updates
    networking fixes
    networking fixes

David Sterba (3):
    affs fix
    btrfs updates
    btrfs fixes

David Teigland (1):
    dlm updates

Dmitry Torokhov (1):
    input updates

Eric Biederman (2):
    userns updates
    siginfo updates

Geert Uytterhoeven (1):
    m68k updates

Greg KH (5):
    USB and PHY updates
    char/misc driver updates
    driver core updates
    tty/serial updates
    staging/IIO updates

Greg Ungerer (1):
    m68knommu updates

Guenter Roeck (1):
    hwmon updates

Herbert Xu (1):
    crypto updates

Ilya Dryomov (1):
    ceph updates

Ingo Molnar (12):
    RCU updates
    EFI updates
    locking updates
    perf tooling fixes
    perf updates
    scheduler updates
    x86 boot updates
    x86 asm updates
    x86 build updates
    x86 cleanups
    x86 debug updates
    x86 dax updates

Jacek Anaszewski (1):
    LED updates

Jaegeuk Kim (1):
    f2fs updates

James Bottomley (2):
    SCSI updates
    SCSI fixes

James Hogan (1):
    MIPS updates

James Morris (4):
    security system updates
    integrity updates
    TPM updates
    smack update

Jan Kara (2):
    udf updates
    fsnotify updates

Jason Gunthorpe (1):
    rdma updates

Jassi Brar (1):
    mailbox updates

Jeff Layton (1):
    fasync fix

Jens Axboe (5):
    block updates
    block fixes
    block fixes
    block flush handling fix
    block fixes

Jessica Yu (1):
    module updates

Jiri Kosina (2):
    livepatching fixlet
    HID updates

Joerg Roedel (1):
    IOMMU updates

John Johansen (1):
    AppArmor updates

Jon Mason (1):
    NTB updates

Jonathan Corbet (1):
    documentation updates

Josh Poimboeuf (1):
    faddr2line updates

Josh)
 (1):
    branch 'faddr2line' (patches

Juergen Gross (1):
    xen updates

Kees Cook (3):
    reed-salomon library updates
    overflow updates
    more overflow updates

Lee Jones (2):
    MFD updates
    backlight updates

Linus Walleij (2):
    pin control updates
    GPIO updates

Mark Brown (3):
    spi updates
    regmap updates
    regulator updates

Martin Schwidefsky (1):
    s390 updates

Masahiro Yamada (3):
    Kbuild updates
    Kconfig updates
    more Kbuild updates

Mauro Carvalho Chehab (2):
    media updates
    documentation fixes

Michael Ellerman (1):
    powerpc updates

Michael Tsirkin (1):
    virtio updates

Michal Simek (1):
    microblaze updates

Miguel Ojeda (1):
    auxdisplay updates

Mike Marshall (1):
    orangefs updates

Mike Snitzer (1):
    device mapper updates

Miklos Szeredi (2):
    fuse updates
    overlayfs fixes

Olof Johansson (4):
    ARM SoC platform updates
    ARM SoC device tree updates
    ARM SoC driver updates
    ARM SoC late updates

Palmer Dabbelt (1):
    RISC-V updates

Paolo Bonzini (2):
    KVM updates
    more kvm updates

Paul Moore (2):
    SELinux updates
    audit updates

Petr Mladek (1):
    printk updates

Rafael Wysocki (5):
    power management updates
    ACPI updates
    device properties framework update
    more power management updates
    additional ACPI updates

Richard Weinberger (2):
    UBI and UBIFS updates
    uml updates

Rob Herring (1):
    DeviceTree updates

Russell King (1):
    ARM updates

Sebastian Reichel (2):
    HSI update
    power supply and reset updates

Shaohua Li (1):
    MD updates

Shuah Khan (2):
    Kselftest update
    more Kselftest updates

Stephen Boyd (1):
    clk updates

Steve French (2):
    cifs updates
    cifs fixes

Steven Rostedt (1):
    tracing updates

Takashi Iwai (2):
    sound updates
    sound fixes

Ted Ts'o (2):
    ext4 updates
    fscrypt updates

Tejun Heo (4):
    libata fixes
    libata updates
    cgroup updates
    workqueue updates

Thierry Reding (1):
    pwm updates

Thomas Gleixner (12):
    irq updates
    x86 RAS updates
    timers and timekeeping updates
    time/Y2038 updates
    x86 cache resource controller updates
    x86 hyperv updates
    core fixes
    irq fixes
    more perf tooling updates
    x86 pti updates
    x86 updates and fixes
    restartable sequence support

Trond Myklebust (1):
    NFS client updates

Ulf Hansson (1):
    MMC updates

Vinod Koul (1):
    dmaengine updates

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (1):
    i2c updates

Zhang Rui (2):
    thermal updates
    thermal SoC updates
