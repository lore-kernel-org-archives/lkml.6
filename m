Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932270AbeBKXfX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 18:35:23 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:40701 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932193AbeBKXfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 18:35:21 -0500
X-Google-Smtp-Source: AH8x225Yb+dzH98KXGDzvrQGwo1HDSpqdKvtBPUkBdAxk4q5KkcwGrn+paviYrewY4bFvJtDZwhEIC5pV7EvQdUJKF0=
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 11 Feb 2018 15:35:19 -0800
X-Google-Sender-Auth: JpMMoY5UEDJ4FNISymO45-JcTIY
Message-ID: <CA+55aFzXVqgCMhPL9EaMW_D9E=HCQ9+JSQAbBPe3Oa_iQtky=g@mail.gmail.com>
Subject: Linux 4.16-rc1
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1BNZTpm029249

Two weeks have passed, -rc1 is out there, and the merge window is thus over.

I don't want to jinx anything, but things certainly look a lot better
than with 4.15. We have no (known) nasty surprises pending, and there
were no huge issues during the merge window. Fingers crossed that this
stays fairly calm and sane.

As usual, I'm only appending my mergelog, because while this is not
shaping up to be a particularly huge release, none of our recent
releases have been small enough to describe with the shortlogs I use
for later rc's.

The actual diff is dominated by drivers, and once again the GPU
patches stand out - this time some AMD GPU header files. Happily, this
time the bulk of those lines is actually *removal* due to cleanups and
getting rid of some unused headers.

But there really is changes all over. Drivers may be the bulk (GPU,
networking,  staging, media, sound, infiniband, scsi and misc smaller
subsystems), but we have a fair amount of arch updates (spectre and
meltdown fixes for non-x86 architectures, but also some further x86
work, and just general arch updates). And there's networking,
filesystem updates, documentation, tooling..

There's a little bit for everybody, in other words.

Go out and test,

                  Linus

---

Al Viro (10):
    poll annotations
    mqueue/bpf vfs cleanups
    kern_recvmsg reduction
    misc vfs updates
    get_user_pages_fast updates
    dcache updates
    asm/uaccess.h whack-a-mole
    vmci iov_iter updates
    misc vfs fixes
    more poll annotation updates

Alex Williamson (1):
    VFIO updates

Alexandre Belloni (1):
    RTC updates

Andrew Morton (2):
    updates
    misc updates

Andrey Ryabinin (1):
    KASAN word-at-a-time fixups

Andy Shevchenko (1):
    more x86 platform-drivers updates

Arnd Bergmann (3):
    ARM SoC device tree updates
    ARM SoC platform updates
    ARM SoC driver updates

Bartlomiej Zolnierkiewicz (2):
    fbdev updates
    fbdev fix

Benson Leung (1):
    chrome platform updates

Bjorn Andersson (2):
    rpmsg updates
    remoteproc updates

Bjorn Helgaas (2):
    PCI updates
    PCI fix

Bob Peterson (2):
    GFS2 updates
    GFS2 fixes

Boris Brezillon (1):
    MTD updates

Borislav Petkov (1):
    EDAC updates

Bruce Fields (1):
    nfsd update

Catalin Marinas (2):
    arm64 updates
    more arm64 updates

Christoph Hellwig (1):
    dma mapping updates

Corey Minyard (1):
    IPMI updates

Darren Hart (2):
    x86 platform-driver updates
    x86 platform driver updates

Darrick Wong (2):
    xfs updates
    more xfs updates

Dave Airlie (2):
    drm updates
    more drm updates

David Howells (2):
    init_task initializer cleanups
    afs updates

David Miller (6):
    networking updates
    sparc updates
    small IDE cleanup
    networking fixes
    networking fixes
    networking fixes

David Sterba (1):
    btrfs updates

Dmitry Torokhov (1):
    input layer updates

Dominik Brodowski (1):
    pcmcia updates

Doug Ledford (1):
    more rdma updates

Eric Biederman (2):
    siginfo cleanups
    userns updates

Geert Uytterhoeven (1):
    m68k updates

Greg KH (5):
    USB/PHY updates
    tty/staging driver updates
    staging/IIO updates
    driver core updates
    char/misc driver updates

Guenter Roeck (1):
    hwmon updates

Heiko Carstens (1):
    s390 updates

Herbert Xu (1):
    crypto updates

Ilya Dryomov (1):
    ceph updates

Ingo Molnar (13):
    STRICT_DEVMEM default
    RCU updates
    EFI updates
    locking updates
    perf updates
    x86 RAS updates
    scheduler updates
    x86 apic cleanup
    x86 cleanups
    x86 hyperv update
    locking fixlets
    perf fixes
    scheduler updates

Jacek Anaszewski (1):
    LED updates

Jaegeuk Kim (1):
    f2fs updates

James Bottomley (2):
    SCSI updates
    second set of SCSI updates

James Hogan (2):
    MIPS updates
    MIPS fixes

James Morris (5):
    integrity updates
    smack updates
    tpm updates
    seccomp updates
    integrity fixes

Jan Kara (1):
    UDF and ext2 fixlets

Jason Gunthorpe (1):
    RDMA subsystem updates

Jassi Brar (1):
    mailbox updates

Jean Delvare (1):
    dmi subsystem updates/fixes

Jeff Layton (2):
    inode->i_version rework
    inode->i_version cleanup

Jens Axboe (3):
    block updates
    more block updates
    block fixes

Jesper Nilsson (1):
    CRIS updates and fixes

Jessica Yu (1):
    modules updates

Jiri Kosina (2):
    HID updates
    livepatching updates

Joerg Roedel (1):
    IOMMU updates

Jon Mason (1):
    NTB updates

Jonathan Corbet (2):
    documentation updates
    more documentation updates

Juergen Gross (1):
    xen fixes

Kees Cook (3):
    pstore update
    hardened usercopy whitelisting
    gcc plugins updates

Lee Jones (2):
    MFD updates
    backlight updates

Ley Foon Tan (1):
    nios2 update

Linus Walleij (2):
    GPIO updates
    pin control updates

Mark Brown (5):
    spi updates
    regulator updates
    regmap updates
    more ASoC updates
    regulator fix

Martin Schwidefsky (1):
    s390 updates

Masahiro Yamada (4):
    Kbuild updates
    Kbuild misc updates
    Kconfig updates
    more Kbuild updates

Matt Turner (1):
    alpha updates

Matthew Wilcox (1):
    idr updates

Mauro Carvalho Chehab (1):
    media updates

Max Filippov (2):
    Xtensa updates
    xtense fix

Michael Ellerman (1):
    powerpc updates

Michael Tsirkin (1):
    virtio/vhost updates

Michal Simek (1):
    microblaze updates

Mike Marshall (1):
    orangefs updates

Mike Snitzer (1):
    device mapper updates

Miklos Szeredi (1):
    overlayfs updates

Nicholas Bellinger (1):
    SCSI target updates

Palmer Dabbelt (1):
    RISC-V updates

Paul Moore (1):
    selinux updates

Petr Mladek (1):
    printk updates

Radim Krčmář (1):
    KVM updates

Rafael Wysocki (5):
    power management updates
    ACPI updates
    PNP updates
    more power management updates
    more ACPI updates

Richard Weinberger (1):
    UBI/UBIFS updates

Rob Herring (1):
    DeviceTree updates

Ross Zwisler (1):
    libnvdimm updates

Russell King (1):
    ARM updates

Sebastian Reichel (2):
    HSI update
    power supply and reset updates

Shaohua Li (1):
    MD updates

Shuah Khan (1):
    kselftest updates

Stefan Richter (1):
    firewire updates

Stephen Boyd (1):
    clk updates

Steve French (2):
    cifs updates
    cifs fixes

Steven Rostedt (2):
    tracing updates
    tracing fixes

Takashi Iwai (1):
    sound updates

Ted Ts'o (2):
    ext4 updates
    fscrypt updates

Tejun Heo (4):
    workqueue updates
    libata updates
    percpu update
    cgroup updates

Thierry Reding (1):
    pwm updates

Thomas Gleixner (10):
    irq updates
    timer updates
    x86/cache updates
    x86 platform updates
    x86 timer updates
    x86 mm update
    x86/pti updates
    irq fixes
    x86 fixes
    spectre/meltdown updates

Trond Myklebust (2):
    NFS client updates
    more NFS client updates

Ulf Hansson (2):
    MMC updates
    MMC host fixes

Vinod Koul (1):
    dmaengine updates

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (1):
    i2c updates

Zhang Rui (1):
    thermal management updates
