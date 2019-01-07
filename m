Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336DAC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D630D2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R8djh50p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfAGCOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:14:37 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43541 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfAGCOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 21:14:37 -0500
Received: by mail-lf1-f68.google.com with SMTP id u18so29018789lff.10
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 18:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=tXejklD8+r3N5S4F5jx4YCET+QGuiPL7tr+Ax9X+08Q=;
        b=R8djh50pjVu0bW1XSiUVvzkrFh065Cg85K80ymyPcdYQ1i0B0oI/q7X4z4Hvnt0Fa6
         FqrcJoqbsrmqh3fDtDqq/r3xVxay8zrfG7+CQ9BYdt0vUompmGf75eoo8oTZh6xrHqzc
         rr/IA0SLgZo2rw/jCdFrpGIuZ2Q+8ubI6osao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tXejklD8+r3N5S4F5jx4YCET+QGuiPL7tr+Ax9X+08Q=;
        b=Dacrwz2TQpZU8I8ZQ0EKZCyC0PXEnlYcdqIhn3w+gCpf3evLstL8N+7Au6ewS8/Jt9
         1t4myuGqyWAO4h1m9MNqUWS0Mfn1OSntC/B2rVOwkeVteB/hzeLKEzC5HrAWNqWnq3Aq
         BU5izXCd4qrF4ZFMm147Yazhv1MLsUZyu5aCpoRks0yIcKGcAXFLPYIdk52k2WMPJ4vI
         RqjZTXr4ifd0dxTN0Y7sDB0XRhMxpgxebWiEUjufT8/WaaN4TVPVISKvbsa9JiuJ7qBC
         4471vdQ5DNaB+mRqhOBFht4zG17nBHs2uU7WxAKpcBg2vg+kzTwwPUi25aeSmMqf0Enn
         mViw==
X-Gm-Message-State: AA+aEWbt+ieJIgjWJfvAxuE5Ns6tVy+Y+s4ObjD9Xp/ze1sCqlxaD/Gu
        4ZkXwyDQXdPF9c0UspbSklI4BMmgiJY=
X-Google-Smtp-Source: AFSGD/V06tjKhKX9/SytJgu3RrNRuwei75Ylm1Mtboa/v6yGOZhyJKktojm8iVYc9X13lmIiHTEKvA==
X-Received: by 2002:a19:8d01:: with SMTP id p1mr27586826lfd.149.1546827273657;
        Sun, 06 Jan 2019 18:14:33 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id k13-v6sm11118386lje.89.2019.01.06.18.14.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 18:14:32 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id i26so29063585lfc.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 18:14:32 -0800 (PST)
X-Received: by 2002:a19:7006:: with SMTP id h6mr27074018lfc.147.1546827272337;
 Sun, 06 Jan 2019 18:14:32 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Jan 2019 18:14:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgKYnrL3LjhVkH2Fp+ecmWhLqezT9zmR6CzfcpwcJX0qA@mail.gmail.com>
Message-ID: <CAHk-=wgKYnrL3LjhVkH2Fp+ecmWhLqezT9zmR6CzfcpwcJX0qA@mail.gmail.com>
Subject: Linux 5.0-rc1
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So this was a fairly unusual merge window with the holidays, and as a
result I'm not even going to complain about the pull requests that
ended up coming in late. It all mostly worked out fine, I think. And
lot of people got their pull requests in early, and hopefully had a
calm holiday season. Thanks again to everybody.

The numbering change is not indicative of anything special. If you
want to have an official reason, it's that I ran out of fingers and
toes to count on, so 4.21 became 5.0. There's no nice git object
numerology this time (we're _about_ 6.5M objects in the git repo), and
there isn't any major particular feature that made for the release
numbering either. Of course, depending on your particular interests,
some people might well find a feature _they_ like so much that they
think it can do as a reason for incrementing the major number.

So go wild. Make up your own reason for why it's 5.0.

Because as usual, there's a lot of changes in there. Not because this
merge window was particularly big - but even our smaller merge windows
aren't exactly small. It's a very solid and average merge window with
just under 11k commits (or about 11.5k if you count merges).

The stats look fairly normal. About 50% is drivers, 20% is
architecture updates, 10% is tooling, and the remaining 20% is all
over (documentation, networking, filesystems, header file updates,
core kernel code..). Nothing particular stands out, although I do like
seeing how some ancient drivers are getting put out to pasture
(*cought*isdn*cough*).

As usual even the shortlog is much too big to post, so the summary
below is only a list of the pull requests I merged.

Go test. Kick the tires. Be the first kid on your block running a 5.0
pre-release kernel.

              Linus

---

Al Viro (2):
    trivial vfs updates
    vfs mount API prep

Alex Williamson (1):
    VFIO updates

Alexandre Belloni (1):
    RTC updates

Andrew Morton (2):
    misc updates
    more updates

Andy Shevchenko (1):
    x86 platform driver updates

Anna Schumaker (1):
    NFS client updates

Arnd Bergmann (2):
    arch/sh syscall table scripting
    y2038 updates

Bartlomiej Zolnierkiewicz (1):
    fbdev updates

Benson Leung (1):
    chrome platform updates

Bjorn Andersson (1):
    hwspinlock updates

Bjorn Helgaas (1):
    PCI updates

Bob Peterson (1):
    gfs2 updates

Boris Brezillon (2):
    initial i3c support
    mtd updates

Borislav Petkov (4):
    EDAC updates
    x86 cache control updates
    x86 microcode loading updates
    x86 RAS updates

Bruce Fields (1):
    nfsd updates

Christoph Hellwig (2):
    DMA mapping updates
    dma-mapping fixes

Dan Williams (2):
    libnvdimm updates
    dax fix

Daniel Thompson (1):
    kgdb updates

Darrick Wong (4):
    XFS updates
    iomap update
    xfs fixlets
    iomap maintainer update

Dave Airlie (3):
    drm updates
    more drm updates
    drm fixes

David Miller (3):
    sparc updates
    networking updates
    networking fixes

David Sterba (1):
    btrfs updates

David Teigland (1):
    dlm updates

Dennis Zhou (1):
    percpu update

Dmitry Torokhov (1):
    input updates

Dominique Martinet (1):
    9p updates

Eduardo Valentin (1):
    thermal SoC updates

Geert Uytterhoeven (1):
    m68k updates

Greentime Hu (1):
    nds32 updates

Greg KH (5):
    USB/PHY updates
    tty/serial driver updates
    staging/IIO driver updates
    driver core updates
    char/misc driver updates

Guenter Roeck (1):
    hwmon updates

Guo Ren (1):
    arch/csky updates

Helge Deller (2):
    parisc updates
    parisc fix

Herbert Xu (1):
    crypto updates

Ilya Dryomov (1):
    ceph updates

Ingo Molnar (15):
    RCU updates
    EFI updates
    locking updates
    perf updates
    scheduler updates
    x86 AMD northbridge updates
    x86 asm updates
    x86 boot updates
    x86 build updates
    x86 cleanups
    x86 cpu updates
    x86 fpu updates
    x86 mm updates
    x86 platform update
    scheduler fix

Jacek Anaszewski (1):
    LED updates

Jaegeuk Kim (1):
    f2fs updates

James Bottomley (1):
    SCSI updates

James Morris (5):
    general security subsystem updates
    integrity updates
    seccomp updates
    smack updates
    TPM updates

Jan Kara (2):
    fsnotify updates
    ext2, udf, and quota update

Jason Gunthorpe (2):
    rdma updates
    rdma fixes

Jassi Brar (1):
    mailbox updates

Jeff Layton (2):
    file locking updates
    file locking bugfix

Jens Axboe (6):
    block updates
    aio updates
    libata updates
    libata fix
    more block updates
    block updates and fixes

Jessica Yu (1):
    modules updates

Jiri Kosina (2):
    livepatch update
    HID updates

Joerg Roedel (1):
    IOMMU updates

Jonathan Corbet (2):
    documentation update
    documentation fixes

Juergen Gross (1):
    xen updates

Kees Cook (2):
    pstore updates
    gcc-plugins update

Linus Walleij (2):
    GPIO updates
    pin control updates

Mark Brown (3):
    regulator updates
    spi updates
    regmap updates

Martin Schwidefsky (1):
    s390 updates

Masahiro Yamada (4):
    Kbuild updates
    Kconfig updates
    Kconfig file consolidation
    more Kbuild updates

Matt Turner (1):
    alpha architecture updates

Mauro Carvalho Chehab (2):
    media updates
    more media updates

Max Filippov (1):
    Xtensa updates

Michael Ellerman (2):
    powerpc updates
    powerpc fixes

Michael Tsirkin (1):
    virtio/vhost updates

Michal Simek (1):
    arch/microblaze updates

Mike Snitzer (1):
    device mapper updates

Olof Johansson (5):
    arm SoC platform updates
    ARM SoC driver updates
    ARM Device-tree updates
    ARM SoC defconfig updates
    more ARM SoC updates

Palmer Dabbelt (1):
    RISC-V updates

Paolo Bonzini (1):
    KVM updates

Paul Burton (2):
    MIPS updates
    MIPS fixes

Paul Moore (2):
    audit updates
    selinux patches

Petr Mladek (1):
    printk updates

Rafael Wysocki (4):
    power management updates
    ACPI updates
    device properties framework updates
    device properties framework fixes

Richard Weinberger (1):
    UML updates

Rob Herring (1):
    Devicetree updates

Russell King (1):
    ARM updates

Sebastian Reichel (2):
    power supply and reset updates
    HSI update

Shuah Khan (1):
    Kselftest updates

Stafford Horne (1):
    OpenRISC update

Stefan Richter (1):
    firewire fixlet

Stephen Boyd (2):
    clk updates
    more clk updates

Steve French (2):
    cifs updates
    smb3 fixes

Steven Rostedt (2):
    tracing updates
    ftrace sh build fix

Takashi Iwai (2):
    sound updates
    sound fixes

Ted Ts'o (3):
    ext4 updates
    ext4 bug fixes
    fscrypt updates

Tejun Heo (1):
    cgroup updates

Thierry Reding (1):
    pwm updates

Thomas Gleixner (3):
    irq updates
    timer updates
    x86 pti updates

Tony Luck (1):
    ia64 updates

Ulf Hansson (1):
    MMC updates

Vinod Koul (1):
    dmaengine updates

Will Deacon (2):
    arm64 festive updates
    arm64 fixes

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (1):
    i2c updates

Yoshinori Sato (1):
    h8300 fix

Zhang Rui (1):
    thermal management updates
