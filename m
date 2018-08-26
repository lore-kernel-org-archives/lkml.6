Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650D0C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EECEE21722
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bJqTM5PD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EECEE21722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeH0BdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 21:33:16 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51614 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeH0BdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 21:33:15 -0400
Received: by mail-it0-f68.google.com with SMTP id e14-v6so8599750itf.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 14:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=ZdCFovaM+GgQWHWXVfKSgNNc2ijNLEOB5QeX6snPwmg=;
        b=bJqTM5PDm4Edx/Ug/pt54WQqqnL06NQV0rGQb0JM/ka7zVZCQyl1bq7hJcrx9gjjLN
         PXjrPeCkwynh1B5y7h+HXS6TIJDASdsTtBP51iqNlUZqcgTDKBQEVM0HTHdxtlCOLMhF
         wUTxJs631NKYeTpTl0KpMUDo9s/m6aAn2Ce1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZdCFovaM+GgQWHWXVfKSgNNc2ijNLEOB5QeX6snPwmg=;
        b=LTYdLVe8HuU3OUDf2/hWv1I1FIji6kHok9YrZoMVLAtSJEZkEHCD3maPUcAIzikqJi
         OjvGIZn08zNGsaAP2MXuFQIxBCADBgWa+tMWI7WIotIH9C+eFhaBcPSl/UyH/z3SBsi+
         7HSKPce2jO+Y6dZfoGBzNaQmXaJ4HjDzz61ba/mnLsmK/uBbSqEoU5QjT0WDPkvk2LAX
         ZjV1+bDwHezrVcFLWR/EM68u5zpp3i7PcISjyJU0cmHZ8GGf0DxElhzEHZF66V0L0xYL
         7YfHyHAvIlCSq4088Jr1SpIARAy1/+526rVRDBj91CVlolSd23SHwPobsaV1UY5z6dlK
         FYzw==
X-Gm-Message-State: APzg51Cg2L2aYyzMbe2TZReuHBb8U6mIIu0yfj291QUMITvUQJYxNXEH
        au2DXAuKuo27Gk8sUO18jdSy78gMNxIEeMtajw3wlU0V
X-Google-Smtp-Source: ANB0VdZ+HKSiCMMB+IZz4+/4FaiMETDQlWF5LuFepMwBPMBjLOBrJh5ZPoqaCAWsaxlD3Qn4y64/qFF8nhk4jeP3egk=
X-Received: by 2002:a02:2b12:: with SMTP id h18-v6mr8413195jaa.10.1535320165754;
 Sun, 26 Aug 2018 14:49:25 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Aug 2018 14:49:14 -0700
Message-ID: <CA+55aFw9mxNPX6OtOp-aoUMdXSg=gBkQudGGamo__sh_ts_LdQ@mail.gmail.com>
Subject: Linux 4.19-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So two weeks have passed, and the merge window for 4.19 is over.

This was a fairly frustrating merge window, partly because 4.19 looks
to be a pretty big release (no single reason), and partly just due to
random noise. We had the L1TF hw vulnerability disclosure early in the
merge window, which just added the usual frustration due to having
patches that weren't public. That just shows just how good all our
infrastructure for linux-next and various automated testing systems
have become, in how painful it is when it's lacking.

At least we didn't actually have a lot of problems on that front in
the mainline kernel, there seemed to be many more pain points in the
backports.

We also had a report of a TLB shootdown bug come in during this merge
window, and while the patches for ended up not being a huge problem,
TLB invalidation issues is actually one of the things that stresses me
out. They're really nasty to debug (thanks to Jann Horn for
pinpointing this one), and our interfaces to the architecture specific
routines are subtle and pretty complicated. And messy. I think the
discussion will result in a few cleanups later, but timing could have
been so much better for this.

Oh well. I guess I can partly just blame myself for having delayed
4.18 by a week, which just made everything happen during that first
and busiest week of the merge window. Bad luck. Although even the
second week - when things usually calm down - was also pretty busy
this time around.

Anyway, on to the actual changes. And there' a lot of them. There's
just a lot of things going on, and while this isn't the biggest
release we've had (4.9 still keeps that crown), this does join 4.12
and 4.15 as one of the bigger kernel releases, at least just judging
by number of commits in the merge window.

As usual, there's way too many patches to list even in shortlog
format, but appended is my usual "mergelog" of people I merged from
and a one-liner overview of the merge. There's actually a couple of
pull requests that I might still look at after the merge window, but
that are probably in the "there's always the next one" pile.

The "big picture" of the merge window looks pretty normal: just under
two thirds of the changes are to drivers (gpu and network drivers
being the bulk - as usual), with the rest being architecture updates
(all the usual suspects), filesystems, core kernel and networking.
There's a fair chunk of documentation and tooling updates too
(selftests, tracing, perf..).

Anyway, go forth and test,

                 Linus

---

Al Viro (5):
    vfs open-related updates
    vfs icache updates
    vfs lookup() updates
    vfs aio updates
    misc vfs updates

Alex Williamson (1):
    VFIO updates

Alexandre Belloni (1):
    RTC updates

Andreas Gruenbacher (1):
    gfs2 updates

Andrew Morton (3):
    updates
    more updates
    yet more updates

Andy Shevchenko (1):
    x86 platform driver updates

Anna Schumaker (1):
    NFS client updates

Bartlomiej Zolnierkiewicz (1):
    fbdev updates

Benson Leung (1):
    chrome platform updates

Bjorn Andersson (3):
    remoteproc updates
    rpmsg updates
    hwspinlock updates

Bjorn Helgaas (1):
    pci updates

Boris Brezillon (1):
    mtd updates

Borislav Petkov (2):
    EDAC updates
    EDAC fix

Bruce Fields (1):
    nfsd updates

Christoph Hellwig (2):
    dma-mapping updates
    configfs updates

Darrick Wong (3):
    fs iomap refactoring
    xfs updates
    xfs fixes

Dave Airlie (4):
    drm updates
    drm fixes
    drm msm support for adreno a6xx
    drm fixes

Dave Jiang (2):
    libnvdimm updates
    libnvdimm memory-failure update

David Kleikamp (1):
    jfs update

David Miller (4):
    networking updates
    networking fixes
    sparc updates
    IDE updates

David Sterba (1):
    btrfs updates

Dmitry Torokhov (1):
    input updates

Dominique Martinet (1):
    9p updates

Eduardo Valentin (1):
    thermal management updates

Eric Biederman (2):
    core signal handling updates
    namespace fixes

Geert Uytterhoeven (1):
    m68k updates

Greg KH (6):
    USB/PHY updates
    tty/serial driver updates
    staging and IIO updates
    char/misc driver updates
    driver core updates
    UIO fix

Greg Ungerer (1):
    m68knommu updates

Guenter Roeck (1):
    hwmon updates

Heiko Carstens (1):
    s390 updates

Helge Deller (2):
    parisc updates
    more parisc updates

Herbert Xu (1):
    crypto updates

Ilya Dryomov (1):
    ceph updates

Jacek Anaszewski (1):
    LED updates

Jaegeuk Kim (1):
    f2fs updates

James Bottomley (1):
    SCSI updates

James Morris (4):
    security subsystem updates
    smack updates
    TPM updates
    integrity updates

Jan Kara (2):
    UDF and ext2 update
    fsnotify updates

Jason Gunthorpe (2):
    rdma updates
    more rdma updates

Jassi Brar (1):
    mailbox updates

Jeff Layton (1):
    file locking updates

Jens Axboe (3):
    block updates
    more block updates
    block fixes

Jessica Yu (1):
    modules updates

Jiri Kosina (2):
    HID updates
    livepatching updates

Joerg Roedel (1):
    IOMMU updates

John Johansen (1):
    apparmor updates

Jonathan Corbet (1):
    documentation update

Juergen Gross (2):
    xen updates
    xen fixes and cleanups

Kees Cook (5):
    hardened usercopy updates
    pstore update
    gcc plugin cleanups
    VLA removal leftovers
    gcc plugin fix

Lee Jones (2):
    MFD updates
    backlight updates

Linus Walleij (2):
    pin control updates
    GPIO updates

Mark Brown (3):
    regmap updates
    spi updates
    regulator updates

Martin Schwidefsky (1):
    s390 updates

Masahiro Yamada (4):
    Kbuild updates
    Kconfig updates
    Kconfig consolidation
    more Kbuild updates

Matthew Wilcox (1):
    IDA updates

Mauro Carvalho Chehab (1):
    media updates

Max Filippov (1):
    Xtensa updates

Michael Ellerman (2):
    powerpc updates
    powerpc fixes

Michael Tsirkin (1):
    virtio updates

Michal Simek (1):
    arch/microblaze updates

Miguel Ojeda (2):
    auxdisplay updates
    clang-format updates

Mike Marshall (1):
    orangefs updates

Mike Snitzer (1):
    device mapper updates

Miklos Szeredi (2):
    overlayfs updates
    fuse update

Olof Johansson (5):
    ARM 32-bit SoC platform updates
    ARM SoC driver updates
    ARM SoC defconfig updates
    ARM device-tree updates
    ARM SoC late updates

Palmer Dabbelt (2):
    RISC-V updates
    RISC-V fixes

Paolo Bonzini (2):
    first set of KVM updates
    second set of KVM updates

Paul Burton (2):
    MIPS updates
    MIPS fixes

Paul Moore (2):
    SELinux updates
    audit patches

Petr Mladek (1):
    printk updates

Rafael Wysocki (5):
    power management updates
    ACPI updates
    more power management updates
    more ACPI updates
    ACPI Kconfig fix

Richard Weinberger (2):
    UBI/UBIFS updates
    UBIFS fix

Rob Herring (1):
    Devicetree updates

Russell King (2):
    ARM updates
    ARM clkdev updates

Sebastian Reichel (1):
    power supply and reset updates

Shaohua Li (1):
    MD updates

Shuah Khan (1):
    Kselftest update

Stafford Horne (1):
    OpenRISC update

Stephen Boyd (1):
    clk updates

Steve French (2):
    cifs updates
    cifs fixes

Steven Rostedt (2):
    tracing updates
    tracing fixes

Takashi Iwai (2):
    sound updates
    sound fixes

Ted Ts'o (2):
    ext4 updates
    random updates

Tejun Heo (3):
    workqueue updates
    cgroup updates
    libata updates

Thierry Reding (1):
    pwm updates

Thomas Gleixner (32):
    debugobjects update
    EFI updates
    genirq updates
    RCU updates
    x86 RAS updates
    scheduler fix
    scheduler updates
    CPU hotplug update
    locking/atomics update
    perf update
    timer updates
    x86 apic update
    x86 boot updates
    x86 asm updates
    x86 build cleanup
    x86 cleanups
    x86 cpu updates
    x86 dump printing cleanup
    x86/hyper-v update
    x86 cache QoS (RDT/CAR) updates
    x86 platform updates
    x86 mm updates
    misc x86 fixes
    x86 vdso update
    x86 PTI updates
    x86 timer updates
    L1 Terminal Fault fixes
    licking update
    irq update
    x86 fixes
    perf updates
    timer update

Tony Luck (1):
    ia64 NO_BOOTMEM conversion

Ulf Hansson (1):
    MMC updates

Vinod Koul (1):
    DMAengine updates

Will Deacon (2):
    arm64 updates
    arm64 fixes

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (2):
    i2c updates
    second i2c update

Yoshinori Sato (1):
    arch/h8300 updates

Zhang Rui (1):
    thermal management updates
