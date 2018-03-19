Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELscH9HsMWZI2ne87XmV7f+4Qrx4ivMBDhNKQcVrajs+DrqPgow9AQPsZtUh/i+u/pjzUIgv
ARC-Seal: i=1; a=rsa-sha256; t=1521484334; cv=none;
        d=google.com; s=arc-20160816;
        b=tv+L/oI4WyOsOxvEQ6pyY4a0agDX1YeGYumb/ITGzh7hPZBXixufFdP8qc2/Y+x8Yq
         rtVRKTj+PEpkbrs3eisbnuT+ZQSLLAS/1jWEru1lr/pccikMzH3Lx75oY6ncGjDRHgvt
         p+IIO6Sx4BSgxChIzodGD1/OFfjtJi4wUfKQCLNhSQnqNp9wodjXNuOBszWZ7EDVrFG5
         fam0J9cNmxUGV/Av4t3nGX5cWKVAz/sKctjEbgKkvTDCBNwaH5aRI7viNf2u7Ls+yUc1
         hGQ1wrsWO/V4IHpXt4i4JyXR1STCY6RrWq+q6dRGZfRS8A+/NNq09he0pjCHNUZB6kux
         q6hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=P6n5ft+Me43zYNeZb8eae7Qzi0vl+DhBRmp11pmqh7o=;
        b=CCxXqVwIo56tkfYGlIrqEC1Xmj14DXCNIoE3EvlCx3vERo11o9yXXYZ5PyAlXbu9l+
         mwHbU5MiJSfmQru98HIAiNQBlYZEIyjO3jkGN9oI5zfzuh0/F9iBm3PB8eJYZffJ6XvD
         urvikL6XPPywCTIT0emr8BWmpXFC7L9ZrMcNBsO2LdOLaAOMdzY3QDqeoIAlpwN6sVDq
         0ZHFB3ksoQfag3MZRHCx7AjS2Ro4/Vjvd0ftkwNOMSnxkaUhOr/I3sJTiak6Cv0AmNsp
         GwcpzpkI5N5BrF8k2Sputt75Dc7QVeFaQv4JIX2GIxYwAcbWCIOs0JsOTr4jfTFuwKab
         C5Pw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuahkh@osg.samsung.com,
	patches@kernelci.org,
	ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: [PATCH 4.15 00/52] 4.15.12-stable review
Date: Mon, 19 Mar 2018 19:07:58 +0100
Message-Id: <20180319180734.976730813@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.12-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.15.12-rc1
X-KernelTest-Deadline: 2018-03-21T18:07+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391957310699281?=
X-GMAIL-MSGID: =?utf-8?q?1595391957310699281?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.15.12 release.
There are 52 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Mar 21 18:07:15 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.12-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.15.12-rc1

Al Cooper <al.cooper@broadcom.com>
    phy: phy-brcm-usb-init: Power down USB 3.0 PHY when XHCI disabled

Al Cooper <al.cooper@broadcom.com>
    phy: phy-brcm-usb-init: DRD mode can cause crash on startup

Al Cooper <al.cooper@broadcom.com>
    phy: phy-brcm-usb-init: Some Low Speed keyboards fail on 7271

Al Cooper <alcooperx@gmail.com>
    phy: phy-brcm-usb: Fix two DT properties to match bindings doc

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    usb: gadget: udc: renesas_usb3: fix oops in renesas_usb3_remove()

Enric Balletbo i Serra <enric.balletbo@collabora.com>
    usb: dwc3: of-simple: fix oops by unbalanced clk disable call

Manu Gautam <mgautam@codeaurora.org>
    usb: dwc3: core: Power-off core/PHYs on system_suspend in host mode

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: Fix GDBGFIFOSPACE_TYPE values

Wei Yongjun <weiyongjun1@huawei.com>
    USB: gadget: udc: Add missing platform_device_put() on error in bdc_pci_probe()

Amelie Delaunay <amelie.delaunay@st.com>
    dt-bindings: usb: fix the STM32F7 DWC2 OTG HS core binding

Amelie Delaunay <amelie.delaunay@st.com>
    usb: dwc2: fix STM32F7 USB OTG HS compatible

Bill Kuzeja <William.Kuzeja@stratus.com>
    scsi: qla2xxx: Fix crashes in qla2x00_probe_one on probe failure

Himanshu Madhani <hmadhani@redhat.com>
    scsi: qla2xxx: Fix logo flag for qlt_free_session_done()

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Fix NULL pointer access for fcport structure

Himanshu Madhani <himanshu.madhani@cavium.com>
    scsi: qla2xxx: Fix smatch warning in qla25xx_delete_{rsp|req}_que

Nikolay Borisov <nborisov@suse.com>
    btrfs: Fix memory barriers usage with device stats counters

Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
    btrfs: remove spurious WARN_ON(ref->count < 0) in find_parent_nodes

Nikolay Borisov <nborisov@suse.com>
    btrfs: Fix use-after-free when cleaning up fs_devs with a single stale device

Hans van Kranenburg <hans.van.kranenburg@mendix.com>
    btrfs: alloc_chunk: fix DUP stripe size handling

Edmund Nadolski <enadolski@suse.com>
    btrfs: add missing initialization in btrfs_check_shared

Dmitriy Gorokh <Dmitriy.Gorokh@wdc.com>
    btrfs: Fix NULL pointer exception in find_bio_stripe

Amir Goldstein <amir73il@gmail.com>
    xfs: preserve i_rdev when recycling a reclaimable inode

Israel Rukshin <israelr@mellanox.com>
    nvme: fix subsystem multiple controllers support check

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    irqchip/gic-v3-its: Ensure nr_ites >= nr_lpis

Tejun Heo <tj@kernel.org>
    RDMAVT: Fix synchronization around percpu_ref

Tejun Heo <tj@kernel.org>
    fs/aio: Use RCU accessors for kioctx_table->table[]

Tejun Heo <tj@kernel.org>
    fs/aio: Add explicit RCU grace period when freeing kioctx

Al Viro <viro@zeniv.linux.org.uk>
    lock_parent() needs to recheck if dentry got __dentry_kill'ed under it

Marc Zyngier <marc.zyngier@arm.com>
    KVM: arm/arm64: vgic: Don't populate multiple LRs with the same vintid

Marc Zyngier <marc.zyngier@arm.com>
    kvm: arm/arm64: vgic-v3: Tighten synchronization for guests using v2 on v3

Christoffer Dall <cdall@kernel.org>
    KVM: arm/arm64: Reset mapped IRQs on VM reset

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    KVM: arm/arm64: Reduce verbosity of KVM init log

Eric W. Biederman <ebiederm@xmission.com>
    fs: Teach path_connected to handle nfs filesystems with multiple roots.

Michel Dänzer <michel.daenzer@amd.com>
    drm/amdgpu/dce: Don't turn off DP sink when disconnected

Christian König <christian.koenig@amd.com>
    drm/radeon: fix prime teardown order

Christian König <christian.koenig@amd.com>
    drm/amdgpu: fix prime teardown order

Māris Nartišs <maris.nartiss@gmail.com>
    drm/nouveau/mmu: ALIGN_DOWN correct variable

Lukas Wunner <lukas@wunner.de>
    drm/nouveau/bl: Fix oops on driver unbind

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Clear client entry before deleting else at closing

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Fix possible UAF in snd_seq_check_queue()

Takashi Iwai <tiwai@suse.de>
    ALSA: hda - Revert power_save option default value

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Fix UAF in snd_pcm_oss_get_formats()

John David Anglin <dave.anglin@bell.net>
    parisc: Handle case where flush_cache_range is called with no context

Toshi Kani <toshi.kani@hpe.com>
    x86/mm: Fix vmalloc_fault to use pXd_large

Tom Lendacky <thomas.lendacky@amd.com>
    KVM: x86: Fix device passthrough when SME is active

Alexander Sergeyev <sergeev917@gmail.com>
    x86/speculation: Remove Skylake C2 from Speculation Control microcode blacklist

Andy Whitcroft <apw@canonical.com>
    x86/speculation, objtool: Annotate indirect calls/jumps for objtool on 32-bit kernels

Andy Lutomirski <luto@kernel.org>
    x86/vm86/32: Fix POPF emulation

Andy Lutomirski <luto@kernel.org>
    selftests/x86/entry_from_vm86: Add test cases for POPF

Andy Lutomirski <luto@kernel.org>
    selftests/x86/entry_from_vm86: Exit with 1 if we fail

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/cpufeatures: Add Intel PCONFIG cpufeature

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/cpufeatures: Add Intel Total Memory Encryption cpufeature


-------------

Diffstat:

 Documentation/devicetree/bindings/usb/dwc2.txt |  2 +-
 Makefile                                       |  4 +-
 arch/parisc/kernel/cache.c                     | 41 +++++++++---
 arch/x86/include/asm/cpufeatures.h             |  2 +
 arch/x86/include/asm/nospec-branch.h           |  5 +-
 arch/x86/kernel/cpu/intel.c                    |  3 +-
 arch/x86/kernel/vm86_32.c                      |  3 +-
 arch/x86/kvm/mmu.c                             |  4 +-
 arch/x86/mm/fault.c                            |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 31 ++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c        |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c     |  2 +
 drivers/gpu/drm/nouveau/nouveau_backlight.c    |  4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c  |  2 +-
 drivers/gpu/drm/radeon/radeon_gem.c            |  2 -
 drivers/gpu/drm/radeon/radeon_object.c         |  2 +
 drivers/infiniband/sw/rdmavt/mr.c              | 10 +--
 drivers/irqchip/irq-gic-v3-its.c               |  9 ++-
 drivers/nvme/host/core.c                       | 18 +++++-
 drivers/phy/broadcom/phy-brcm-usb-init.c       | 22 +++----
 drivers/phy/broadcom/phy-brcm-usb.c            |  4 +-
 drivers/scsi/qla2xxx/qla_init.c                | 13 ++--
 drivers/scsi/qla2xxx/qla_mid.c                 |  6 +-
 drivers/scsi/qla2xxx/qla_os.c                  | 59 ++++++++++-------
 drivers/scsi/qla2xxx/qla_target.c              |  1 +
 drivers/usb/dwc2/params.c                      |  6 +-
 drivers/usb/dwc3/core.c                        | 36 ++++++-----
 drivers/usb/dwc3/core.h                        | 16 ++---
 drivers/usb/dwc3/dwc3-of-simple.c              |  1 +
 drivers/usb/gadget/udc/bdc/bdc_pci.c           |  1 +
 drivers/usb/gadget/udc/renesas_usb3.c          |  2 +-
 fs/aio.c                                       | 44 ++++++++-----
 fs/btrfs/backref.c                             | 12 +++-
 fs/btrfs/raid56.c                              |  1 +
 fs/btrfs/volumes.c                             | 30 ++++++---
 fs/btrfs/volumes.h                             | 12 ++++
 fs/dcache.c                                    | 11 +++-
 fs/namei.c                                     |  5 +-
 fs/nfs/super.c                                 |  2 +
 fs/xfs/xfs_icache.c                            |  2 +
 include/kvm/arm_vgic.h                         |  1 +
 include/linux/fs.h                             |  1 +
 include/linux/irqchip/arm-gic-v3.h             |  1 +
 include/linux/irqchip/arm-gic.h                |  1 +
 sound/core/oss/pcm_oss.c                       | 10 +--
 sound/core/seq/seq_clientmgr.c                 |  4 +-
 sound/core/seq/seq_prioq.c                     | 28 ++++-----
 sound/core/seq/seq_prioq.h                     |  6 +-
 sound/core/seq/seq_queue.c                     | 28 +++------
 sound/pci/hda/hda_intel.c                      |  9 ++-
 tools/testing/selftests/x86/entry_from_vm86.c  | 32 ++++++++--
 virt/kvm/arm/arch_timer.c                      |  6 +-
 virt/kvm/arm/hyp/vgic-v3-sr.c                  |  3 +-
 virt/kvm/arm/mmu.c                             |  6 +-
 virt/kvm/arm/vgic/vgic-v2.c                    | 11 +++-
 virt/kvm/arm/vgic/vgic-v3.c                    |  9 ++-
 virt/kvm/arm/vgic/vgic.c                       | 87 +++++++++++++++++++++-----
 virt/kvm/arm/vgic/vgic.h                       |  2 +
 58 files changed, 461 insertions(+), 222 deletions(-)
