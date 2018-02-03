Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752720AbeBCRmz (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 12:42:55 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:39381 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752235AbeBCRmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 12:42:46 -0500
X-Google-Smtp-Source: AH8x227nVkvPpbQRcXtUvJXESF7HQPVy+BBRTjWiUx5gJJtE9YcUG5qCC+qvFcIPSyQSrfqFeu7T4+llgBKGf7UnVfA=
MIME-Version: 1.0
From: Mathieu Malaterre <malat@debian.org>
Date: Sat, 3 Feb 2018 18:42:25 +0100
X-Google-Sender-Auth: U4ebgdVxzOkMtoRr_vnq9NdrutE
Message-ID: <CA+7wUsyS=burMw_FPyX8sU99_iMk1Ee1x3iBUiFMff7J0Av6Vg@mail.gmail.com>
Subject: warning: "EDID_LENGTH" redefined (was Re: [PATCH v4] Fix loading of
 module radeonfb on PowerMac)
To: Dave Airlie <airlied@redhat.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Since I am not very familiar with the drm vs fbdev architecture, could
you please suggest a patch for the following [*].

Reference:
f453ba0460742 (Dave Airlie         2008-11-07 14:05:41 -0800  32)
#define EDID_LENGTH 128


Thanks

[*]
On Sat, Feb 3, 2018 at 3:39 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Mathieu,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v4.15 next-20180202]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Mathieu-Malaterre/Fix-loading-of-module-radeonfb-on-PowerMac/20180203-085907
> config: x86_64-randconfig-x009-201804 (attached as .config)
> compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> All warnings (new ones prefixed by >>):
>
>    In file included from drivers/video/fbdev/aty/radeon_base.c:91:0:
>>> drivers/video/fbdev/aty/../edid.h:21:0: warning: "EDID_LENGTH" redefined
>     #define EDID_LENGTH    0x80
>
>    In file included from include/drm/drm_crtc.h:44:0,
>                     from include/drm/drm_fb_helper.h:35,
>                     from drivers/video/fbdev/aty/radeon_base.c:73:
>    include/drm/drm_edid.h:32:0: note: this is the location of the previous definition
>     #define EDID_LENGTH 128
>
>    Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:fls64
>    Cyclomatic Complexity 1 include/linux/log2.h:__ilog2_u64
>    Cyclomatic Complexity 1 include/asm-generic/getorder.h:__get_order
>    Cyclomatic Complexity 1 include/linux/string.h:strnlen
>    Cyclomatic Complexity 4 include/linux/string.h:strlen
>    Cyclomatic Complexity 6 include/linux/string.h:strlcpy
>    Cyclomatic Complexity 4 include/linux/string.h:memcpy
>    Cyclomatic Complexity 1 arch/x86/include/asm/paravirt.h:arch_local_irq_disable
>    Cyclomatic Complexity 1 arch/x86/include/asm/paravirt.h:arch_local_irq_enable
>    Cyclomatic Complexity 1 include/linux/spinlock.h:spinlock_check
>    Cyclomatic Complexity 1 include/linux/spinlock.h:spin_unlock_irqrestore
>    Cyclomatic Complexity 1 include/linux/jiffies.h:_msecs_to_jiffies
>    Cyclomatic Complexity 3 include/linux/jiffies.h:msecs_to_jiffies
>    Cyclomatic Complexity 1 arch/x86/include/asm/io.h:readb
>    Cyclomatic Complexity 1 arch/x86/include/asm/io.h:readw
>    Cyclomatic Complexity 1 arch/x86/include/asm/io.h:readl
>    Cyclomatic Complexity 1 arch/x86/include/asm/io.h:writeb
>    Cyclomatic Complexity 1 arch/x86/include/asm/io.h:writel
>    Cyclomatic Complexity 1 arch/x86/include/asm/io.h:ioremap
>    Cyclomatic Complexity 1 include/linux/kobject.h:kobject_name
>    Cyclomatic Complexity 2 include/linux/device.h:dev_name
>    Cyclomatic Complexity 1 include/linux/device.h:dev_get_drvdata
>    Cyclomatic Complexity 1 include/linux/device.h:dev_set_drvdata
>    Cyclomatic Complexity 1 include/linux/io.h:arch_phys_wc_add
>    Cyclomatic Complexity 1 include/linux/io.h:arch_phys_wc_del
>    Cyclomatic Complexity 68 include/linux/slab.h:kmalloc_large
>    Cyclomatic Complexity 3 include/linux/slab.h:kmalloc
>    Cyclomatic Complexity 1 include/linux/slab.h:kzalloc
>    Cyclomatic Complexity 1 include/linux/pci.h:pci_get_drvdata
>    Cyclomatic Complexity 1 include/linux/pci.h:pci_set_drvdata
>    Cyclomatic Complexity 1 include/linux/pci.h:pci_name
>    Cyclomatic Complexity 2 include/linux/fb.h:alloc_apertures
>    Cyclomatic Complexity 2 drivers/video/fbdev/aty/radeonfb.h:radeon_pll_errata_after_index
>    Cyclomatic Complexity 2 drivers/video/fbdev/aty/radeonfb.h:radeon_pll_errata_after_data
>    Cyclomatic Complexity 1 drivers/video/fbdev/aty/radeonfb.h:round_div
>    Cyclomatic Complexity 3 drivers/video/fbdev/aty/radeonfb.h:var_to_depth
>    Cyclomatic Complexity 5 drivers/video/fbdev/aty/radeonfb.h:radeon_get_dstbpp
>    Cyclomatic Complexity 1 drivers/video/fbdev/aty/radeonfb.h:radeonfb_bl_init
>    Cyclomatic Complexity 1 drivers/video/fbdev/aty/radeonfb.h:radeonfb_bl_exit
>    Cyclomatic Complexity 1 include/drm/drm_fb_helper.h:drm_fb_helper_remove_conflicting_framebuffers
>    Cyclomatic Complexity 21 drivers/video/fbdev/aty/radeon_base.c:radeon_calc_pll_regs
>    Cyclomatic Complexity 1 drivers/video/fbdev/aty/radeon_base.c:radeonfb_exit
>    Cyclomatic Complexity 6 drivers/video/fbdev/aty/radeon_base.c:radeon_find_mem_vbios
>    Cyclomatic Complexity 4 drivers/video/fbdev/aty/radeon_base.c:radeon_kick_out_firmware_fb
>    Cyclomatic Complexity 5 drivers/video/fbdev/aty/radeon_base.c:radeonfb_pci_unregister
>    Cyclomatic Complexity 1 drivers/video/fbdev/aty/radeon_base.c:radeon_show_one_edid
>    Cyclomatic Complexity 3 drivers/video/fbdev/aty/radeon_base.c:radeon_show_edid2
>    Cyclomatic Complexity 3 drivers/video/fbdev/aty/radeon_base.c:radeon_show_edid1
>    Cyclomatic Complexity 2 drivers/video/fbdev/aty/radeon_base.c:radeon_set_fbinfo
>    Cyclomatic Complexity 18 drivers/video/fbdev/aty/radeon_base.c:radeonfb_check_var
>    Cyclomatic Complexity 2 drivers/video/fbdev/aty/radeon_base.c:radeon_unmap_ROM
>    Cyclomatic Complexity 7 drivers/video/fbdev/aty/radeon_base.c:radeon_map_ROM
>    Cyclomatic Complexity 16 drivers/video/fbdev/aty/radeon_base.c:radeonfb_setup
>    Cyclomatic Complexity 2 drivers/video/fbdev/aty/radeon_base.c:radeonfb_init
>    Cyclomatic Complexity 8 drivers/video/fbdev/aty/radeon_base.c:_radeon_msleep
>    Cyclomatic Complexity 1 drivers/video/fbdev/aty/radeon_base.c:radeon_pll_errata_after_index_slow
>    Cyclomatic Complexity 3 drivers/video/fbdev/aty/radeon_base.c:radeon_pll_errata_after_data_slow
>    Cyclomatic Complexity 1 drivers/video/fbdev/aty/radeon_base.c:_OUTREGP
>    Cyclomatic Complexity 1 drivers/video/fbdev/aty/radeon_base.c:__INPLL
>    Cyclomatic Complexity 20 drivers/video/fbdev/aty/radeon_base.c:radeon_probe_pll_params
>    Cyclomatic Complexity 10 drivers/video/fbdev/aty/radeon_base.c:radeon_get_pllinfo
>    Cyclomatic Complexity 1 drivers/video/fbdev/aty/radeon_base.c:radeon_save_state
>    Cyclomatic Complexity 1 drivers/video/fbdev/aty/radeon_base.c:__OUTPLL
>    Cyclomatic Complexity 1 drivers/video/fbdev/aty/radeon_base.c:__OUTPLLP
>    Cyclomatic Complexity 3 drivers/video/fbdev/aty/radeon_base.c:_radeon_fifo_wait
>    Cyclomatic Complexity 17 drivers/video/fbdev/aty/radeon_base.c:radeon_write_pll_regs
>    Cyclomatic Complexity 25 drivers/video/fbdev/aty/radeon_base.c:radeon_identify_vram
>    Cyclomatic Complexity 31 drivers/video/fbdev/aty/radeon_base.c:radeonfb_pci_register
>    Cyclomatic Complexity 10 drivers/video/fbdev/aty/radeon_base.c:radeonfb_ioctl
>    Cyclomatic Complexity 4 drivers/video/fbdev/aty/radeon_base.c:radeonfb_pan_display
>    Cyclomatic Complexity 16 drivers/video/fbdev/aty/radeon_base.c:radeon_setcolreg
>    Cyclomatic Complexity 9 drivers/video/fbdev/aty/radeon_base.c:radeonfb_setcmap
>    Cyclomatic Complexity 6 drivers/video/fbdev/aty/radeon_base.c:radeonfb_setcolreg
>    Cyclomatic Complexity 3 drivers/video/fbdev/aty/radeon_base.c:radeon_engine_flush
>    Cyclomatic Complexity 3 drivers/video/fbdev/aty/radeon_base.c:_radeon_engine_idle
>    Cyclomatic Complexity 2 drivers/video/fbdev/aty/radeon_base.c:radeon_lvds_timer_func
>    Cyclomatic Complexity 17 drivers/video/fbdev/aty/radeon_base.c:radeon_screen_blank
>    Cyclomatic Complexity 2 drivers/video/fbdev/aty/radeon_base.c:radeonfb_blank
>    Cyclomatic Complexity 7 drivers/video/fbdev/aty/radeon_base.c:radeon_write_mode
>    Cyclomatic Complexity 42 drivers/video/fbdev/aty/radeon_base.c:radeonfb_set_par
>    In file included from drivers/video/fbdev/aty/radeon_base.c:91:0:
>>> drivers/video/fbdev/aty/../edid.h:21:0: warning: "EDID_LENGTH" redefined
>     #define EDID_LENGTH    0x80
>
>    In file included from include/drm/drm_crtc.h:44:0,
>                     from include/drm/drm_fb_helper.h:35,
>                     from drivers/video/fbdev/aty/radeon_base.c:73:
>    include/drm/drm_edid.h:32:0: note: this is the location of the previous definition
>     #define EDID_LENGTH 128
>
>
> vim +/EDID_LENGTH +21 drivers/video/fbdev/aty/../edid.h
>
> ^1da177e drivers/video/edid.h Linus Torvalds 2005-04-16  20
> ^1da177e drivers/video/edid.h Linus Torvalds 2005-04-16 @21  #define EDID_LENGTH                                0x80
> ^1da177e drivers/video/edid.h Linus Torvalds 2005-04-16  22  #define EDID_HEADER                                0x00
> ^1da177e drivers/video/edid.h Linus Torvalds 2005-04-16  23  #define EDID_HEADER_END                            0x07
> ^1da177e drivers/video/edid.h Linus Torvalds 2005-04-16  24
>
> :::::: The code at line 21 was first introduced by commit
> :::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2
>
> :::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
> :::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
