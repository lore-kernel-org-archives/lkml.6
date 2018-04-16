Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbeDPBzl (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 21:55:41 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38782 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbeDPBzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 21:55:39 -0400
X-Google-Smtp-Source: AIpwx4+zPITSAiCtm3C8sR9KIZeCNhQiN2DLIfmnhJ4FGbAwcMWMDuBAY2KEPaTzNFnSeyNyNn5tgWlty9iasHomvbw=
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 15 Apr 2018 18:55:38 -0700
X-Google-Sender-Auth: uC3MtXv2OGi1BTBmJb2c-LjSXtU
Message-ID: <CA+55aFx62iBkj+hOmhLksUtvjwTcm_o1dwcyvaNnVpJ-AmvzVQ@mail.gmail.com>
Subject: Linux 4.17-rc1
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So two weeks have passed, and the merge window was pretty normal and
is now closed.

This does not seem to be shaping up to be a particularly big release,
and there seems to be nothing particularly special about it. The most
special thing that happened is purely numerology: we've passed the six
million git objects mark, and that is reason enough to call the next
kernel 5.0. Except I probably won't, because I don't want to be too
predictable. The version numbers are meaningless, which should mean
that they don't even follow silly numerological rules - even if v3.0
and v4.0 happened to be at the 2M and 4M mark respectively.

But v5.0 will happen some day. And it should be meaningless. You have
been warned.

Anyway, we do have a *few* other things that happened, like Arnd
getting rid of a number of architectures that seem to simply not
matter any more. If it turns out that somebody wants to resurrect any
of them, the code is all there in the git history, but you'll have to
do the work and show that you'll maintain it and have a few users.

And just to not make it *all* about removing old architectures,
there's a new one in there too.

The architectures that are gone are blackfin, cris, frv, m32r, metag,
mn10300, score, and tile.  And the new architecture is the nds32
(Andes Technology 32-0bit RISC architecture).

We actually have a fair amount of other removal and cleanups too. I
was somewhat pleasantly surprised by the number of pull requests that
actually ended up removing a lot of lines. Some of it was staging
drivers that finally gave up the ghost (like irda), but we also got
rid of some copyright language boiler-plate in favor of just the spdx
lines. And some pre-shipped lexer/parser files are no more, we're
better off just generating them.

End result: we actually removed more lines than we added:

 13538 files changed, 627723 insertions(+), 818855 deletions(-)

which is probably a first. Ever. In the history of the universe. Or at
least kernel releases.

I'd call it momentous, but I think the arch removal was most of it,
and I'm sure people will quickly rectify that momentary glitch of
actually shrinking the kernel source code.

Go out and test,

             Linus

---

Al Viro (7):
    vfs dcache updates
    misc vfs updates
    sparc syscall cleanups
    alpha syscall cleanups
    vfs namei updates
    AFS updates
    vfs thaw updates

Alex Williamson (1):
    VFIO updates

Alexandre Belloni (1):
    RTC updates

Andrew Morton (3):
    updates
    more updates
    yet more updates

Andy Shevchenko (1):
    x86 platform driver updates

Anna Schumaker (1):
    NFS client updates

Arnd Bergmann (5):
    ARM SoC device tree updates
    ARM SoC platform updates
    ARM SoC driver updates
    ARM SoC fixes
    asm-generic fixes

Bartlomiej Zolnierkiewicz (1):
    fbdev updates

Benson Leung (1):
    chrome platform updates

Bjorn Andersson (2):
    rpmsg updates
    remoteproc updates

Bjorn Helgaas (2):
    PCI updates
    PCI fixes

Bob Peterson (2):
    gfs2 updates
    more gfs2 updates

Boris Brezillon (1):
    MTD updates

Borislav Petkov (1):
    EDAC updates

Bruce Fields (1):
    nfsd updates

Christoph Hellwig (2):
    dma-mapping updates
    dma-mapping fix

Corey Minyard (1):
    IPMI updates

Dan Williams (1):
    libnvdimm updates

Darrick Wong (2):
    xfs updates
    more xfs updates

Dave Airlie (2):
    drm updates
    drm fixes

David Howells (1):
    fscache updates

David Miller (5):
    networking updates
    sparc updates
    networking fixes
    networking fixes
    networking fixes

David Sterba (2):
    btrfs updates
    more btrfs updates

Dmitry Torokhov (1):
    input updates

Dominik Brodowski (1):
    removal of in-kernel calls to syscalls

Eric Biederman (2):
    namespace updates
    siginfo updates

Geert Uytterhoeven (1):
    m68k updates

Greentime Hu (1):
    nds32 architecture support

Greg KH (5):
    USB/PHY updates
    tty/serial driver updates
    staging/IIO updates
    driver core updates
    char/misc updates

Greg Ungerer (1):
    m68knommu update

Guenter Roeck (1):
    hwmon updates

Helge Deller (2):
    parisc updates
    parisc updates

Herbert Xu (1):
    crypto updates

Ilya Dryomov (1):
    ceph updates

Ingo Molnar (19):
    misc core updates
    debugobjects updates
    header file cleanup
    RCU updates
    locking updates
    perf updates
    x86 RAS updates
    scheduler updates
    SMP hotplug updates
    x86 apic updates
    x86 asm fixlets
    x86 build updates
    x86 cleanups and msr updates
    x86 mm updates
    x86 platform updates
    x86 timer updates
    wait_var_event updates
    x86 dma mapping updates
    EFI updates

Jacek Anaszewski (1):
    LED updates

Jaegeuk Kim (1):
    f2fs update

James Bottomley (2):
    SCSI updates
    SCSI fixes

James Hogan (1):
    MIPS updates

James Morris (4):
    general security layer updates
    smack update
    TPM updates
    integrity updates

Jan Kara (1):
    misc filesystem updates

Jason Gunthorpe (1):
    rdma updates

Jason Wessel (1):
    kdb updates

Jassi Brar (1):
    mailbox updates

Jean Delvare (1):
    dmi updates

Jens Axboe (2):
    block layer updates
    block fixes

Jiri Kosina (2):
    HID updates
    trivial tree updates

Joerg Roedel (1):
    IOMMU updates

John Johansen (1):
    apparmor updates

Jonathan Corbet (1):
    documentation updates

Juergen Gross (1):
    xen fixes

Kees Cook (2):
    pstore updates
    pstore fix

Ley Foon Tan (1):
    nios2 update

Linus Walleij (2):
    pin control bulk updates
    GPIO updates

Mark Brown (3):
    regmap updates
    regulator updates
    SPI updates

Mark Salter (1):
    c6x updates

Martin Schwidefsky (2):
    s390 updates
     more s390 updates

Masahiro Yamada (3):
    Kbuild updates
    Kconfig updates
    more Kbuild updates

Matt Turner (1):
    alpha updates

Mauro Carvalho Chehab (2):
    media updates
    media fixes

Michael Ellerman (2):
    powerpc updates
    powerpc fixes

Michael Tsirkin (2):
    fw_cfg, vhost updates
    virtio update

Michal Simek (1):
    microblaze updates

Mike Marshall (1):
    orangefs updates

Mike Snitzer (1):
    device mapper updates

Miklos Szeredi (1):
    overlayfs updates

Palmer Dabbelt (1):
    RISC-V updates

Paolo Bonzini (1):
    kvm updates

Paul Moore (2):
    audit updates
    SELinux updates

Petr Mladek (1):
    printk updates

Rafael Wysocki (3):
    ACPI updates
    power management updates
    more power management updates

Rich Felker (1):
    arch/sh updates

Richard Weinberger (2):
    UML updates
    UBI and UBIFS updates

Rob Herring (1):
    DeviceTree updates

Russell King (2):
    ARM updates
    ARM SA1100 updates

Sebastian Reichel (2):
    power supply and reset updates
    HSI updates

Shuah Khan (1):
    kselftest update

Stafford Horne (1):
    OpenRISC fixlet

Stephen Boyd (1):
    clk updates

Steve French (2):
    cifs updates
    cifs fixes

Steven Rostedt (3):
    tracing updates
    ktest updates
    tracing fixes

Takashi Iwai (2):
    sound updates
    sound fixes

Ted Ts'o (2):
    ext4 updates
    /dev/random updates

Tejun Heo (2):
    libata updates
    workqueue updates

Thierry Reding (1):
    pwm updates

Thomas Gleixner (8):
    time(r) updates
    irq updates
    irq affinity fixes
    x86 EFI bootup fixlet
    more perf updates
    scheduler fixes
    x86 pti updates
    x86 fixes

Tobin Harding (1):
    leaking-addresses updates

Ulf Hansson (2):
    MMC updates
    MMC fixes

Vinod Koul (1):
    dmaengine updates

Will Deacon (2):
    arm64 updates
    more arm64 updates

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (2):
    i2c updates
    more i2c updates

Zhang Rui (1):
    thermal management update
