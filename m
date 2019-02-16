Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9F9C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 10:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A252B222DD
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 10:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q34+ZRBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbfBPKeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 05:34:24 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34498 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbfBPKeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 05:34:22 -0500
Received: by mail-pf1-f195.google.com with SMTP id j18so6105980pfe.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Feb 2019 02:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=1YfJwRPB+SlWqE6wIsFtuCYcMsGNwqwvdwItf2XBFec=;
        b=q34+ZRBQcAxpEFrXYzXBvvS9Rfc1/fo+hMWvOYTB2G2uuIp3PPd6FmqHlkWHKe8stM
         rOH7o6SqrJQ+SOIQH86mKbj5d3li62DK3vAKqTA09qGPsvdkfrZ1dlsD9EI3fTEAHeJd
         nUHAZicJWFPF2Etfd9rKEp0Aec4T4Ok6jfb8uJduCMjeiGKTW4tXHAnU/kln7aiVFGsa
         kaiWjno1Df2+KQLYlm2nMKNJ3I5UOLDsh+e9vgfdfVaNbvHr4EyV6K8ZCnjuES/iLTEK
         qDj+Dn/uIpEgCcBFdvr4VLfoJ+3C6xq/ZcT8e96L/uLNqAIcspK72k2p/pdb7USl7y65
         MM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=1YfJwRPB+SlWqE6wIsFtuCYcMsGNwqwvdwItf2XBFec=;
        b=qbkAa2PZA43hMBrrSKq78zDdLXPy+ZpGvU/2yV3jWO+VpWTnHLxpSjaKseo03fa7Sy
         Vb3FuHBaxCaomJjeuXB1f/Xb33X/rEZHTh9SDAU1V7JZ9KkX2JFtlzts0xPeJRD6XFVA
         lA/pFeMQYU/75osuhr0PZx6mAMMo36J5Eb2kXfVgsPbA9fLvayOo6L83aaKPfV4BnM5z
         CKGpwMAB60BX/MbGvIkfvb4nTrjAF0Mt+awgW+nx8HciPW/NVAnnrZYQUqhT5TIOsFoR
         f48I72Pu4qjmHEh0D0YGpA4fBEqWtjDrAnkP9UTGHC/jh3/ZQnfIgcSxBtHZkiz9R18n
         7R8g==
X-Gm-Message-State: AHQUAuaDAhjy8oM2omR7IW0y0AbswZTcF/6L1diWChvFWze/ziCKdu1g
        Ln7NpJBxwDlVt0qChBM6wxk=
X-Google-Smtp-Source: AHgI3IYYRSiaET//CXRjlug2Xg2S3eFbccjRbwUhfDo6+G2uGfzywL0jVDehsDELGtBLxn5uSQb/Pg==
X-Received: by 2002:a63:eb56:: with SMTP id b22mr2150488pgk.287.1550313249301;
        Sat, 16 Feb 2019 02:34:09 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id g14sm14366031pfg.27.2019.02.16.02.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 02:34:08 -0800 (PST)
Date:   Sat, 16 Feb 2019 16:04:02 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nishad Kamdar <nishadkamdar@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Use the correct style for SPDX License Identifier in all
 header files across the kernel
Message-ID: <20190216103356.GA10673@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style
in all header files across the kernel.

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46
and making some manual changes.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 arch/arm/boot/dts/imx6ull-pinfunc-snvs.h                | 2 +-
 arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h           | 2 +-
 arch/arm64/include/asm/pointer_auth.h                   | 2 +-
 arch/arm64/include/asm/sdei.h                           | 2 +-
 arch/arm64/include/asm/vmap_stack.h                     | 2 +-
 arch/nds32/include/asm/assembler.h                      | 2 +-
 arch/nds32/include/asm/barrier.h                        | 2 +-
 arch/nds32/include/asm/bitfield.h                       | 2 +-
 arch/nds32/include/asm/cache.h                          | 2 +-
 arch/nds32/include/asm/cache_info.h                     | 2 +-
 arch/nds32/include/asm/cacheflush.h                     | 2 +-
 arch/nds32/include/asm/current.h                        | 2 +-
 arch/nds32/include/asm/delay.h                          | 2 +-
 arch/nds32/include/asm/elf.h                            | 2 +-
 arch/nds32/include/asm/fixmap.h                         | 2 +-
 arch/nds32/include/asm/futex.h                          | 2 +-
 arch/nds32/include/asm/highmem.h                        | 2 +-
 arch/nds32/include/asm/io.h                             | 2 +-
 arch/nds32/include/asm/irqflags.h                       | 2 +-
 arch/nds32/include/asm/l2_cache.h                       | 2 +-
 arch/nds32/include/asm/linkage.h                        | 2 +-
 arch/nds32/include/asm/memory.h                         | 2 +-
 arch/nds32/include/asm/mmu.h                            | 2 +-
 arch/nds32/include/asm/mmu_context.h                    | 2 +-
 arch/nds32/include/asm/module.h                         | 2 +-
 arch/nds32/include/asm/nds32.h                          | 2 +-
 arch/nds32/include/asm/page.h                           | 2 +-
 arch/nds32/include/asm/pgalloc.h                        | 2 +-
 arch/nds32/include/asm/pgtable.h                        | 2 +-
 arch/nds32/include/asm/proc-fns.h                       | 2 +-
 arch/nds32/include/asm/processor.h                      | 2 +-
 arch/nds32/include/asm/ptrace.h                         | 2 +-
 arch/nds32/include/asm/shmparam.h                       | 2 +-
 arch/nds32/include/asm/string.h                         | 2 +-
 arch/nds32/include/asm/swab.h                           | 2 +-
 arch/nds32/include/asm/syscall.h                        | 2 +-
 arch/nds32/include/asm/syscalls.h                       | 2 +-
 arch/nds32/include/asm/thread_info.h                    | 2 +-
 arch/nds32/include/asm/tlb.h                            | 2 +-
 arch/nds32/include/asm/tlbflush.h                       | 2 +-
 arch/nds32/include/asm/uaccess.h                        | 2 +-
 arch/nds32/include/asm/unistd.h                         | 2 +-
 arch/nds32/include/asm/vdso.h                           | 2 +-
 arch/nds32/include/asm/vdso_datapage.h                  | 2 +-
 arch/nds32/include/asm/vdso_timer_info.h                | 2 +-
 arch/nds32/include/uapi/asm/auxvec.h                    | 2 +-
 arch/nds32/include/uapi/asm/byteorder.h                 | 2 +-
 arch/nds32/include/uapi/asm/cachectl.h                  | 2 +-
 arch/nds32/include/uapi/asm/param.h                     | 2 +-
 arch/nds32/include/uapi/asm/ptrace.h                    | 2 +-
 arch/nds32/include/uapi/asm/sigcontext.h                | 2 +-
 arch/nds32/include/uapi/asm/unistd.h                    | 2 +-
 arch/powerpc/include/asm/pnv-ocxl.h                     | 2 +-
 arch/sh/drivers/pci/pci-sh5.h                           | 4 ++--
 arch/sh/drivers/pci/pci-sh7751.h                        | 4 ++--
 arch/sh/drivers/pci/pci-sh7780.h                        | 4 ++--
 arch/sh/drivers/pci/pcie-sh7786.h                       | 4 ++--
 arch/sh/include/asm/addrspace.h                         | 4 ++--
 arch/sh/include/asm/bl_bit_64.h                         | 4 ++--
 arch/sh/include/asm/cache_insns_64.h                    | 4 ++--
 arch/sh/include/asm/device.h                            | 4 ++--
 arch/sh/include/asm/dma-register.h                      | 4 ++--
 arch/sh/include/asm/dma.h                               | 4 ++--
 arch/sh/include/asm/dwarf.h                             | 4 ++--
 arch/sh/include/asm/fixmap.h                            | 4 ++--
 arch/sh/include/asm/flat.h                              | 4 ++--
 arch/sh/include/asm/freq.h                              | 4 ++--
 arch/sh/include/asm/gpio.h                              | 4 ++--
 arch/sh/include/asm/machvec.h                           | 4 ++--
 arch/sh/include/asm/pgtable.h                           | 4 ++--
 arch/sh/include/asm/sfp-machine.h                       | 4 ++--
 arch/sh/include/asm/shmparam.h                          | 4 ++--
 arch/sh/include/asm/siu.h                               | 4 ++--
 arch/sh/include/asm/spinlock-cas.h                      | 4 ++--
 arch/sh/include/asm/spinlock-llsc.h                     | 4 ++--
 arch/sh/include/asm/spinlock.h                          | 4 ++--
 arch/sh/include/asm/switch_to.h                         | 4 ++--
 arch/sh/include/asm/switch_to_64.h                      | 4 ++--
 arch/sh/include/asm/tlb_64.h                            | 4 ++--
 arch/sh/include/asm/traps_64.h                          | 4 ++--
 arch/sh/include/asm/watchdog.h                          | 4 ++--
 arch/sh/include/cpu-common/cpu/addrspace.h              | 4 ++--
 arch/sh/include/cpu-common/cpu/mmu_context.h            | 4 ++--
 arch/sh/include/cpu-common/cpu/pfc.h                    | 4 ++--
 arch/sh/include/cpu-sh2/cpu/cache.h                     | 4 ++--
 arch/sh/include/cpu-sh2/cpu/freq.h                      | 4 ++--
 arch/sh/include/cpu-sh2/cpu/watchdog.h                  | 4 ++--
 arch/sh/include/cpu-sh2a/cpu/cache.h                    | 4 ++--
 arch/sh/include/cpu-sh2a/cpu/freq.h                     | 4 ++--
 arch/sh/include/cpu-sh3/cpu/cache.h                     | 4 ++--
 arch/sh/include/cpu-sh3/cpu/dma-register.h              | 4 ++--
 arch/sh/include/cpu-sh3/cpu/freq.h                      | 4 ++--
 arch/sh/include/cpu-sh3/cpu/gpio.h                      | 4 ++--
 arch/sh/include/cpu-sh3/cpu/mmu_context.h               | 4 ++--
 arch/sh/include/cpu-sh3/cpu/watchdog.h                  | 4 ++--
 arch/sh/include/cpu-sh4/cpu/addrspace.h                 | 4 ++--
 arch/sh/include/cpu-sh4/cpu/cache.h                     | 4 ++--
 arch/sh/include/cpu-sh4/cpu/dma-register.h              | 4 ++--
 arch/sh/include/cpu-sh4/cpu/fpu.h                       | 4 ++--
 arch/sh/include/cpu-sh4/cpu/freq.h                      | 4 ++--
 arch/sh/include/cpu-sh4/cpu/mmu_context.h               | 4 ++--
 arch/sh/include/cpu-sh4/cpu/sh7786.h                    | 4 ++--
 arch/sh/include/cpu-sh4/cpu/sq.h                        | 4 ++--
 arch/sh/include/cpu-sh4/cpu/watchdog.h                  | 4 ++--
 arch/sh/include/mach-common/mach/hp6xx.h                | 4 ++--
 arch/sh/include/mach-common/mach/magicpanelr2.h         | 4 ++--
 arch/sh/include/mach-common/mach/mangle-port.h          | 4 ++--
 arch/sh/include/mach-common/mach/microdev.h             | 4 ++--
 arch/sh/include/mach-common/mach/secureedge5410.h       | 4 ++--
 arch/sh/include/mach-dreamcast/mach/dma.h               | 4 ++--
 arch/sh/include/mach-dreamcast/mach/pci.h               | 4 ++--
 arch/sh/include/mach-dreamcast/mach/sysasic.h           | 4 ++--
 arch/sh/include/mach-se/mach/se7721.h                   | 4 ++--
 arch/x86/include/asm/cpu_entry_area.h                   | 2 +-
 arch/x86/include/asm/pti.h                              | 2 +-
 arch/x86/kernel/process.h                               | 2 +-
 drivers/acpi/nfit/intel.h                               | 2 +-
 drivers/clk/actions/owl-common.h                        | 2 +-
 drivers/clk/actions/owl-composite.h                     | 2 +-
 drivers/clk/actions/owl-divider.h                       | 2 +-
 drivers/clk/actions/owl-factor.h                        | 2 +-
 drivers/clk/actions/owl-fixed-factor.h                  | 2 +-
 drivers/clk/actions/owl-gate.h                          | 2 +-
 drivers/clk/actions/owl-mux.h                           | 2 +-
 drivers/clk/actions/owl-pll.h                           | 2 +-
 drivers/clk/actions/owl-reset.h                         | 2 +-
 drivers/clk/davinci/pll.h                               | 2 +-
 drivers/clk/davinci/psc.h                               | 2 +-
 drivers/clk/qcom/clk-regmap-mux-div.h                   | 2 +-
 drivers/clk/renesas/rcar-gen2-cpg.h                     | 4 ++--
 drivers/clk/renesas/rcar-gen3-cpg.h                     | 4 ++--
 drivers/clk/renesas/renesas-cpg-mssr.h                  | 4 ++--
 drivers/clk/sprd/common.h                               | 2 +-
 drivers/clk/sprd/composite.h                            | 2 +-
 drivers/clk/sprd/div.h                                  | 2 +-
 drivers/clk/sprd/gate.h                                 | 2 +-
 drivers/clk/sprd/mux.h                                  | 2 +-
 drivers/clk/sprd/pll.h                                  | 2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6.h                    | 2 +-
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h                | 4 ++--
 drivers/crypto/cavium/nitrox/nitrox_debugfs.h           | 2 +-
 drivers/crypto/cavium/nitrox/nitrox_mbx.h               | 2 +-
 drivers/crypto/hisilicon/sec/sec_drv.h                  | 2 +-
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h                   | 2 +-
 drivers/firmware/arm_scmi/common.h                      | 2 +-
 drivers/firmware/ti_sci.h                               | 2 +-
 drivers/fsi/cf-fsi-fw.h                                 | 2 +-
 drivers/gpu/drm/i915/i915_active.h                      | 2 +-
 drivers/gpu/drm/i915/i915_active_types.h                | 2 +-
 drivers/gpu/drm/i915/i915_gem_batch_pool.h              | 2 +-
 drivers/gpu/drm/i915/i915_gpu_error.h                   | 2 +-
 drivers/gpu/drm/i915/i915_oa_bdw.h                      | 2 +-
 drivers/gpu/drm/i915/i915_oa_bxt.h                      | 2 +-
 drivers/gpu/drm/i915/i915_oa_cflgt2.h                   | 2 +-
 drivers/gpu/drm/i915/i915_oa_cflgt3.h                   | 2 +-
 drivers/gpu/drm/i915/i915_oa_chv.h                      | 2 +-
 drivers/gpu/drm/i915/i915_oa_cnl.h                      | 2 +-
 drivers/gpu/drm/i915/i915_oa_glk.h                      | 2 +-
 drivers/gpu/drm/i915/i915_oa_hsw.h                      | 2 +-
 drivers/gpu/drm/i915/i915_oa_icl.h                      | 2 +-
 drivers/gpu/drm/i915/i915_oa_kblgt2.h                   | 2 +-
 drivers/gpu/drm/i915/i915_oa_kblgt3.h                   | 2 +-
 drivers/gpu/drm/i915/i915_oa_sklgt2.h                   | 2 +-
 drivers/gpu/drm/i915/i915_oa_sklgt3.h                   | 2 +-
 drivers/gpu/drm/i915/i915_oa_sklgt4.h                   | 2 +-
 drivers/gpu/drm/i915/i915_pmu.h                         | 2 +-
 drivers/gpu/drm/i915/i915_query.h                       | 2 +-
 drivers/gpu/drm/i915/i915_reset.h                       | 2 +-
 drivers/gpu/drm/i915/i915_scheduler.h                   | 2 +-
 drivers/gpu/drm/i915/i915_sw_fence.h                    | 2 +-
 drivers/gpu/drm/i915/intel_gpu_commands.h               | 2 +-
 drivers/gpu/drm/i915/intel_huc_fw.h                     | 2 +-
 drivers/gpu/drm/i915/intel_lrc_reg.h                    | 2 +-
 drivers/gpu/drm/i915/intel_wopcm.h                      | 2 +-
 drivers/gpu/drm/i915/intel_workarounds.h                | 2 +-
 drivers/gpu/drm/i915/selftests/igt_flush_test.h         | 2 +-
 drivers/gpu/drm/i915/selftests/igt_live_test.h          | 2 +-
 drivers/gpu/drm/i915/selftests/igt_reset.h              | 2 +-
 drivers/gpu/drm/i915/selftests/igt_spinner.h            | 2 +-
 drivers/gpu/drm/i915/selftests/igt_wedge_me.h           | 2 +-
 drivers/gpu/drm/i915/selftests/mock_timeline.h          | 2 +-
 drivers/gpu/drm/msm/adreno/a2xx_gpu.h                   | 2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h             | 2 +-
 drivers/gpu/drm/pl111/pl111_nomadik.h                   | 2 +-
 drivers/gpu/drm/pl111/pl111_vexpress.h                  | 2 +-
 drivers/gpu/drm/sun4i/sun4i_frontend.h                  | 2 +-
 drivers/gpu/drm/sun4i/sun4i_lvds.h                      | 2 +-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h                  | 2 +-
 drivers/gpu/drm/tegra/hda.h                             | 2 +-
 drivers/gpu/drm/v3d/v3d_drv.h                           | 2 +-
 drivers/gpu/drm/v3d/v3d_regs.h                          | 2 +-
 drivers/gpu/drm/v3d/v3d_trace.h                         | 2 +-
 drivers/gpu/host1x/hw/hw_host1x06_channel.h             | 2 +-
 drivers/gpu/host1x/hw/hw_host1x07_channel.h             | 2 +-
 drivers/hv/hv_trace.h                                   | 2 +-
 drivers/hwtracing/intel_th/msu.h                        | 2 +-
 drivers/hwtracing/intel_th/pti.h                        | 2 +-
 drivers/i2c/busses/i2c-stm32.h                          | 2 +-
 drivers/media/common/siano/smsir.h                      | 2 +-
 drivers/media/i2c/max2175.h                             | 4 ++--
 drivers/media/i2c/saa711x_regs.h                        | 2 +-
 drivers/media/i2c/tda1997x_regs.h                       | 2 +-
 drivers/media/i2c/tvp5150_reg.h                         | 2 +-
 drivers/media/platform/xilinx/xilinx-dma.h              | 2 +-
 drivers/media/platform/xilinx/xilinx-vip.h              | 2 +-
 drivers/media/platform/xilinx/xilinx-vipp.h             | 2 +-
 drivers/media/platform/xilinx/xilinx-vtc.h              | 2 +-
 drivers/media/rc/rc-core-priv.h                         | 2 +-
 drivers/media/tuners/tuner-xc2028-types.h               | 2 +-
 drivers/media/tuners/tuner-xc2028.h                     | 2 +-
 drivers/media/usb/tm6000/tm6000-regs.h                  | 2 +-
 drivers/media/usb/tm6000/tm6000-usb-isoc.h              | 2 +-
 drivers/media/usb/tm6000/tm6000.h                       | 2 +-
 drivers/misc/hpilo.h                                    | 2 +-
 drivers/misc/ibmvmc.h                                   | 4 ++--
 drivers/misc/ocxl/ocxl_internal.h                       | 2 +-
 drivers/misc/ocxl/trace.h                               | 2 +-
 drivers/net/dsa/b53/b53_serdes.h                        | 4 ++--
 drivers/net/dsa/lantiq_pce.h                            | 2 +-
 drivers/net/dsa/microchip/ksz9477_reg.h                 | 4 ++--
 drivers/net/dsa/microchip/ksz_common.h                  | 4 ++--
 drivers/net/dsa/microchip/ksz_priv.h                    | 4 ++--
 drivers/net/dsa/microchip/ksz_spi.h                     | 4 ++--
 drivers/net/ethernet/cavium/common/cavium_ptp.h         | 2 +-
 drivers/net/ethernet/cortina/gemini.h                   | 2 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.h        | 2 +-
 drivers/net/ethernet/freescale/dpaa2/dprtc-cmd.h        | 2 +-
 drivers/net/ethernet/freescale/dpaa2/dprtc.h            | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h             | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h         | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h  | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.h  | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h   | 2 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.h         | 4 ++--
 drivers/net/ethernet/marvell/octeontx2/af/cgx_fw_if.h   | 4 ++--
 drivers/net/ethernet/marvell/octeontx2/af/common.h      | 4 ++--
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h        | 4 ++--
 drivers/net/ethernet/marvell/octeontx2/af/npc.h         | 4 ++--
 drivers/net/ethernet/marvell/octeontx2/af/npc_profile.h | 4 ++--
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h         | 4 ++--
 drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h     | 4 ++--
 drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h  | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h            | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h          | 2 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h              | 2 +-
 drivers/net/phy/bcm-phy-lib.h                           | 2 +-
 drivers/net/phy/mdio-cavium.h                           | 2 +-
 drivers/net/phy/mdio-i2c.h                              | 2 +-
 drivers/net/phy/mdio-xgene.h                            | 2 +-
 drivers/net/usb/aqc111.h                                | 4 ++--
 drivers/pci/controller/pcie-cadence.h                   | 2 +-
 drivers/pci/controller/pcie-rockchip.h                  | 2 +-
 drivers/phy/qualcomm/phy-qcom-qmp.h                     | 2 +-
 drivers/pinctrl/actions/pinctrl-owl.h                   | 2 +-
 drivers/pinctrl/cirrus/pinctrl-madera.h                 | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h           | 2 +-
 drivers/pinctrl/meson/pinctrl-meson-axg-pmx.h           | 2 +-
 drivers/pinctrl/sh-pfc/core.h                           | 4 ++--
 drivers/pinctrl/sh-pfc/sh_pfc.h                         | 4 ++--
 drivers/pinctrl/stm32/pinctrl-stm32.h                   | 2 +-
 drivers/platform/x86/intel_ips.h                        | 2 +-
 drivers/platform/x86/intel_pmc_core.h                   | 2 +-
 drivers/s390/cio/vfio_ccw_trace.h                       | 4 ++--
 drivers/scsi/myrb.h                                     | 4 ++--
 drivers/scsi/myrs.h                                     | 4 ++--
 drivers/scsi/ufs/ufs-hisi.h                             | 2 +-
 drivers/scsi/ufs/ufs-sysfs.h                            | 4 ++--
 drivers/siox/siox.h                                     | 2 +-
 drivers/slimbus/slimbus.h                               | 2 +-
 drivers/soc/renesas/rcar-sysc.h                         | 4 ++--
 drivers/soundwire/bus.h                                 | 2 +-
 drivers/soundwire/cadence_master.h                      | 2 +-
 drivers/soundwire/intel.h                               | 2 +-
 drivers/staging/erofs/erofs_fs.h                        | 4 ++--
 drivers/staging/erofs/include/linux/tagptr.h            | 4 ++--
 drivers/staging/erofs/internal.h                        | 4 ++--
 drivers/staging/erofs/unzip_pagevec.h                   | 4 ++--
 drivers/staging/erofs/unzip_vle.h                       | 4 ++--
 drivers/staging/erofs/xattr.h                           | 4 ++--
 drivers/staging/greybus/firmware.h                      | 2 +-
 drivers/staging/greybus/gb-camera.h                     | 2 +-
 drivers/staging/greybus/gbphy.h                         | 2 +-
 drivers/staging/greybus/greybus.h                       | 2 +-
 drivers/staging/greybus/greybus_authentication.h        | 2 +-
 drivers/staging/greybus/greybus_firmware.h              | 2 +-
 drivers/staging/greybus/greybus_manifest.h              | 2 +-
 drivers/staging/greybus/greybus_protocols.h             | 2 +-
 drivers/staging/greybus/greybus_trace.h                 | 2 +-
 drivers/staging/greybus/hd.h                            | 2 +-
 drivers/staging/greybus/interface.h                     | 2 +-
 drivers/staging/greybus/manifest.h                      | 2 +-
 drivers/staging/greybus/module.h                        | 2 +-
 drivers/staging/greybus/operation.h                     | 2 +-
 drivers/staging/greybus/spilib.h                        | 2 +-
 drivers/staging/greybus/svc.h                           | 2 +-
 drivers/staging/most/core.h                             | 2 +-
 drivers/staging/most/dim2/errors.h                      | 2 +-
 drivers/staging/most/dim2/hal.h                         | 2 +-
 drivers/staging/most/dim2/reg.h                         | 2 +-
 drivers/staging/most/dim2/sysfs.h                       | 2 +-
 drivers/staging/pi433/pi433_if.h                        | 4 ++--
 drivers/staging/pi433/rf69.h                            | 4 ++--
 drivers/staging/pi433/rf69_enum.h                       | 4 ++--
 drivers/staging/pi433/rf69_registers.h                  | 4 ++--
 drivers/staging/unisys/include/iochannel.h              | 2 +-
 drivers/staging/vt6655/baseband.h                       | 2 +-
 drivers/staging/vt6655/card.h                           | 2 +-
 drivers/staging/vt6655/channel.h                        | 2 +-
 drivers/staging/vt6655/desc.h                           | 2 +-
 drivers/staging/vt6655/device.h                         | 2 +-
 drivers/staging/vt6655/device_cfg.h                     | 2 +-
 drivers/staging/vt6655/dpc.h                            | 2 +-
 drivers/staging/vt6655/key.h                            | 2 +-
 drivers/staging/vt6655/mac.h                            | 2 +-
 drivers/staging/vt6655/power.h                          | 2 +-
 drivers/staging/vt6655/rf.h                             | 2 +-
 drivers/staging/vt6655/rxtx.h                           | 2 +-
 drivers/staging/vt6655/srom.h                           | 2 +-
 drivers/staging/vt6655/tmacro.h                         | 2 +-
 drivers/staging/vt6655/upc.h                            | 2 +-
 drivers/staging/vt6656/baseband.h                       | 2 +-
 drivers/staging/vt6656/card.h                           | 2 +-
 drivers/staging/vt6656/channel.h                        | 2 +-
 drivers/staging/vt6656/desc.h                           | 2 +-
 drivers/staging/vt6656/device.h                         | 2 +-
 drivers/staging/vt6656/dpc.h                            | 2 +-
 drivers/staging/vt6656/firmware.h                       | 2 +-
 drivers/staging/vt6656/int.h                            | 2 +-
 drivers/staging/vt6656/key.h                            | 2 +-
 drivers/staging/vt6656/power.h                          | 2 +-
 drivers/staging/vt6656/rf.h                             | 2 +-
 drivers/staging/vt6656/rxtx.h                           | 2 +-
 drivers/staging/vt6656/usbpipe.h                        | 2 +-
 drivers/staging/vt6656/wcmd.h                           | 2 +-
 drivers/tty/hvc/hvc_console.h                           | 2 +-
 drivers/tty/n_tracesink.h                               | 2 +-
 drivers/tty/serial/8250/8250.h                          | 2 +-
 drivers/tty/serial/atmel_serial.h                       | 2 +-
 drivers/tty/serial/cpm_uart/cpm_uart.h                  | 2 +-
 drivers/tty/serial/icom.h                               | 2 +-
 drivers/tty/serial/ifx6x60.h                            | 2 +-
 drivers/tty/serial/jsm/jsm.h                            | 2 +-
 drivers/tty/serial/pic32_uart.h                         | 2 +-
 drivers/tty/serial/samsung.h                            | 2 +-
 drivers/tty/serial/serial_mctrl_gpio.h                  | 2 +-
 drivers/tty/serial/sirfsoc_uart.h                       | 2 +-
 drivers/tty/serial/stm32-usart.h                        | 2 +-
 drivers/tty/serial/timbuart.h                           | 2 +-
 drivers/usb/atm/usbatm.h                                | 2 +-
 drivers/usb/c67x00/c67x00-hcd.h                         | 2 +-
 drivers/usb/c67x00/c67x00.h                             | 2 +-
 drivers/usb/chipidea/bits.h                             | 2 +-
 drivers/usb/chipidea/ci.h                               | 2 +-
 drivers/usb/chipidea/ci_hdrc_imx.h                      | 2 +-
 drivers/usb/chipidea/otg.h                              | 2 +-
 drivers/usb/chipidea/otg_fsm.h                          | 2 +-
 drivers/usb/chipidea/udc.h                              | 2 +-
 drivers/usb/core/hub.h                                  | 2 +-
 drivers/usb/core/otg_whitelist.h                        | 2 +-
 drivers/usb/core/usb.h                                  | 2 +-
 drivers/usb/dwc2/core.h                                 | 2 +-
 drivers/usb/dwc2/debug.h                                | 2 +-
 drivers/usb/dwc2/hcd.h                                  | 2 +-
 drivers/usb/dwc2/hw.h                                   | 2 +-
 drivers/usb/dwc3/core.h                                 | 2 +-
 drivers/usb/dwc3/debug.h                                | 2 +-
 drivers/usb/dwc3/gadget.h                               | 2 +-
 drivers/usb/dwc3/io.h                                   | 2 +-
 drivers/usb/dwc3/trace.h                                | 2 +-
 drivers/usb/early/xhci-dbc.h                            | 2 +-
 drivers/usb/gadget/function/f_uvc.h                     | 2 +-
 drivers/usb/gadget/function/rndis.h                     | 2 +-
 drivers/usb/gadget/function/u_audio.h                   | 2 +-
 drivers/usb/gadget/function/u_ecm.h                     | 2 +-
 drivers/usb/gadget/function/u_eem.h                     | 2 +-
 drivers/usb/gadget/function/u_ether.h                   | 2 +-
 drivers/usb/gadget/function/u_ether_configfs.h          | 2 +-
 drivers/usb/gadget/function/u_fs.h                      | 2 +-
 drivers/usb/gadget/function/u_gether.h                  | 2 +-
 drivers/usb/gadget/function/u_hid.h                     | 2 +-
 drivers/usb/gadget/function/u_midi.h                    | 2 +-
 drivers/usb/gadget/function/u_ncm.h                     | 2 +-
 drivers/usb/gadget/function/u_phonet.h                  | 2 +-
 drivers/usb/gadget/function/u_printer.h                 | 2 +-
 drivers/usb/gadget/function/u_rndis.h                   | 2 +-
 drivers/usb/gadget/function/u_serial.h                  | 2 +-
 drivers/usb/gadget/function/u_tcm.h                     | 2 +-
 drivers/usb/gadget/function/u_uac1.h                    | 2 +-
 drivers/usb/gadget/function/u_uac1_legacy.h             | 2 +-
 drivers/usb/gadget/function/u_uac2.h                    | 2 +-
 drivers/usb/gadget/function/u_uvc.h                     | 2 +-
 drivers/usb/gadget/function/uvc.h                       | 2 +-
 drivers/usb/gadget/function/uvc_configfs.h              | 2 +-
 drivers/usb/gadget/function/uvc_v4l2.h                  | 2 +-
 drivers/usb/gadget/function/uvc_video.h                 | 2 +-
 drivers/usb/gadget/u_f.h                                | 2 +-
 drivers/usb/gadget/u_os_desc.h                          | 2 +-
 drivers/usb/gadget/udc/amd5536udc.h                     | 2 +-
 drivers/usb/gadget/udc/at91_udc.h                       | 2 +-
 drivers/usb/gadget/udc/atmel_usba_udc.h                 | 2 +-
 drivers/usb/gadget/udc/bdc/bdc.h                        | 2 +-
 drivers/usb/gadget/udc/bdc/bdc_cmd.h                    | 2 +-
 drivers/usb/gadget/udc/bdc/bdc_dbg.h                    | 2 +-
 drivers/usb/gadget/udc/bdc/bdc_ep.h                     | 2 +-
 drivers/usb/gadget/udc/fotg210.h                        | 2 +-
 drivers/usb/gadget/udc/fsl_qe_udc.h                     | 2 +-
 drivers/usb/gadget/udc/fsl_usb2_udc.h                   | 2 +-
 drivers/usb/gadget/udc/fusb300_udc.h                    | 2 +-
 drivers/usb/gadget/udc/goku_udc.h                       | 2 +-
 drivers/usb/gadget/udc/gr_udc.h                         | 2 +-
 drivers/usb/gadget/udc/m66592-udc.h                     | 2 +-
 drivers/usb/gadget/udc/mv_u3d.h                         | 2 +-
 drivers/usb/gadget/udc/mv_udc.h                         | 2 +-
 drivers/usb/gadget/udc/net2272.h                        | 2 +-
 drivers/usb/gadget/udc/net2280.h                        | 2 +-
 drivers/usb/gadget/udc/pxa25x_udc.h                     | 2 +-
 drivers/usb/gadget/udc/pxa27x_udc.h                     | 2 +-
 drivers/usb/gadget/udc/r8a66597-udc.h                   | 2 +-
 drivers/usb/gadget/udc/s3c2410_udc.h                    | 2 +-
 drivers/usb/gadget/udc/trace.h                          | 2 +-
 drivers/usb/host/ehci-fsl.h                             | 2 +-
 drivers/usb/host/ehci.h                                 | 2 +-
 drivers/usb/host/fhci.h                                 | 2 +-
 drivers/usb/host/imx21-hcd.h                            | 2 +-
 drivers/usb/host/ohci.h                                 | 2 +-
 drivers/usb/host/r8a66597.h                             | 2 +-
 drivers/usb/host/whci/whcd.h                            | 2 +-
 drivers/usb/host/whci/whci-hc.h                         | 2 +-
 drivers/usb/host/xhci-debugfs.h                         | 2 +-
 drivers/usb/host/xhci-ext-caps.h                        | 2 +-
 drivers/usb/host/xhci-mtk.h                             | 2 +-
 drivers/usb/host/xhci-mvebu.h                           | 2 +-
 drivers/usb/host/xhci-plat.h                            | 2 +-
 drivers/usb/host/xhci-rcar.h                            | 2 +-
 drivers/usb/host/xhci-trace.h                           | 2 +-
 drivers/usb/host/xhci.h                                 | 2 +-
 drivers/usb/isp1760/isp1760-core.h                      | 2 +-
 drivers/usb/isp1760/isp1760-regs.h                      | 2 +-
 drivers/usb/isp1760/isp1760-udc.h                       | 2 +-
 drivers/usb/misc/rio500_usb.h                           | 2 +-
 drivers/usb/misc/sisusbvga/sisusb.h                     | 2 +-
 drivers/usb/misc/sisusbvga/sisusb_init.h                | 2 +-
 drivers/usb/misc/sisusbvga/sisusb_struct.h              | 2 +-
 drivers/usb/misc/usb_u132.h                             | 2 +-
 drivers/usb/mtu3/mtu3.h                                 | 2 +-
 drivers/usb/mtu3/mtu3_dr.h                              | 2 +-
 drivers/usb/mtu3/mtu3_hw_regs.h                         | 2 +-
 drivers/usb/mtu3/mtu3_qmu.h                             | 2 +-
 drivers/usb/musb/davinci.h                              | 2 +-
 drivers/usb/musb/musb_core.h                            | 2 +-
 drivers/usb/musb/musb_debug.h                           | 2 +-
 drivers/usb/musb/musb_dma.h                             | 2 +-
 drivers/usb/musb/musb_gadget.h                          | 2 +-
 drivers/usb/musb/musb_host.h                            | 2 +-
 drivers/usb/musb/musb_io.h                              | 2 +-
 drivers/usb/musb/musb_regs.h                            | 2 +-
 drivers/usb/musb/musb_trace.h                           | 2 +-
 drivers/usb/musb/omap2430.h                             | 2 +-
 drivers/usb/musb/tusb6010.h                             | 2 +-
 drivers/usb/phy/phy-fsl-usb.h                           | 2 +-
 drivers/usb/phy/phy-mv-usb.h                            | 2 +-
 drivers/usb/renesas_usbhs/common.h                      | 2 +-
 drivers/usb/renesas_usbhs/fifo.h                        | 2 +-
 drivers/usb/renesas_usbhs/mod.h                         | 2 +-
 drivers/usb/renesas_usbhs/pipe.h                        | 2 +-
 drivers/usb/renesas_usbhs/rcar2.h                       | 2 +-
 drivers/usb/renesas_usbhs/rcar3.h                       | 2 +-
 drivers/usb/renesas_usbhs/rza.h                         | 2 +-
 drivers/usb/serial/belkin_sa.h                          | 2 +-
 drivers/usb/serial/io_16654.h                           | 2 +-
 drivers/usb/serial/io_edgeport.h                        | 2 +-
 drivers/usb/serial/io_ionsp.h                           | 2 +-
 drivers/usb/serial/io_ti.h                              | 2 +-
 drivers/usb/serial/io_usbvend.h                         | 2 +-
 drivers/usb/serial/iuu_phoenix.h                        | 2 +-
 drivers/usb/serial/mct_u232.h                           | 2 +-
 drivers/usb/serial/oti6858.h                            | 2 +-
 drivers/usb/serial/pl2303.h                             | 2 +-
 drivers/usb/serial/visor.h                              | 2 +-
 drivers/usb/serial/whiteheat.h                          | 2 +-
 drivers/usb/storage/debug.h                             | 2 +-
 drivers/usb/storage/initializers.h                      | 2 +-
 drivers/usb/storage/protocol.h                          | 2 +-
 drivers/usb/storage/scsiglue.h                          | 2 +-
 drivers/usb/storage/transport.h                         | 2 +-
 drivers/usb/storage/unusual_alauda.h                    | 2 +-
 drivers/usb/storage/unusual_cypress.h                   | 2 +-
 drivers/usb/storage/unusual_datafab.h                   | 2 +-
 drivers/usb/storage/unusual_devs.h                      | 2 +-
 drivers/usb/storage/unusual_ene_ub6250.h                | 2 +-
 drivers/usb/storage/unusual_freecom.h                   | 2 +-
 drivers/usb/storage/unusual_isd200.h                    | 2 +-
 drivers/usb/storage/unusual_jumpshot.h                  | 2 +-
 drivers/usb/storage/unusual_karma.h                     | 2 +-
 drivers/usb/storage/unusual_onetouch.h                  | 2 +-
 drivers/usb/storage/unusual_realtek.h                   | 2 +-
 drivers/usb/storage/unusual_sddr09.h                    | 2 +-
 drivers/usb/storage/unusual_sddr55.h                    | 2 +-
 drivers/usb/storage/unusual_uas.h                       | 2 +-
 drivers/usb/storage/unusual_usbat.h                     | 2 +-
 drivers/usb/storage/usb.h                               | 2 +-
 drivers/usb/typec/tcpm/fusb302_reg.h                    | 2 +-
 drivers/usb/usbip/stub.h                                | 2 +-
 drivers/usb/usbip/usbip_common.h                        | 2 +-
 drivers/usb/usbip/vhci.h                                | 2 +-
 drivers/usb/usbip/vudc.h                                | 2 +-
 drivers/usb/wusbcore/wa-hc.h                            | 2 +-
 drivers/usb/wusbcore/wusbhc.h                           | 2 +-
 drivers/visorbus/controlvmchannel.h                     | 2 +-
 drivers/visorbus/vbuschannel.h                          | 2 +-
 drivers/visorbus/visorbus_private.h                     | 2 +-
 fs/debugfs/internal.h                                   | 2 +-
 fs/ext4/acl.h                                           | 2 +-
 fs/ext4/ext4.h                                          | 2 +-
 fs/ext4/ext4_extents.h                                  | 2 +-
 fs/ext4/ext4_jbd2.h                                     | 2 +-
 fs/ext4/extents_status.h                                | 2 +-
 fs/ext4/fsmap.h                                         | 2 +-
 fs/ext4/mballoc.h                                       | 2 +-
 fs/ext4/truncate.h                                      | 2 +-
 fs/ext4/xattr.h                                         | 2 +-
 fs/f2fs/acl.h                                           | 2 +-
 fs/f2fs/f2fs.h                                          | 2 +-
 fs/f2fs/gc.h                                            | 2 +-
 fs/f2fs/node.h                                          | 2 +-
 fs/f2fs/segment.h                                       | 2 +-
 fs/f2fs/trace.h                                         | 2 +-
 fs/f2fs/xattr.h                                         | 2 +-
 fs/xfs/kmem.h                                           | 2 +-
 fs/xfs/libxfs/xfs_ag_resv.h                             | 2 +-
 fs/xfs/libxfs/xfs_alloc.h                               | 2 +-
 fs/xfs/libxfs/xfs_alloc_btree.h                         | 2 +-
 fs/xfs/libxfs/xfs_attr.h                                | 2 +-
 fs/xfs/libxfs/xfs_attr_leaf.h                           | 2 +-
 fs/xfs/libxfs/xfs_attr_remote.h                         | 2 +-
 fs/xfs/libxfs/xfs_attr_sf.h                             | 2 +-
 fs/xfs/libxfs/xfs_bit.h                                 | 2 +-
 fs/xfs/libxfs/xfs_bmap.h                                | 2 +-
 fs/xfs/libxfs/xfs_bmap_btree.h                          | 2 +-
 fs/xfs/libxfs/xfs_btree.h                               | 2 +-
 fs/xfs/libxfs/xfs_da_btree.h                            | 2 +-
 fs/xfs/libxfs/xfs_da_format.h                           | 2 +-
 fs/xfs/libxfs/xfs_defer.h                               | 2 +-
 fs/xfs/libxfs/xfs_dir2.h                                | 2 +-
 fs/xfs/libxfs/xfs_dir2_priv.h                           | 2 +-
 fs/xfs/libxfs/xfs_errortag.h                            | 2 +-
 fs/xfs/libxfs/xfs_format.h                              | 2 +-
 fs/xfs/libxfs/xfs_fs.h                                  | 2 +-
 fs/xfs/libxfs/xfs_ialloc.h                              | 2 +-
 fs/xfs/libxfs/xfs_ialloc_btree.h                        | 2 +-
 fs/xfs/libxfs/xfs_inode_buf.h                           | 2 +-
 fs/xfs/libxfs/xfs_inode_fork.h                          | 2 +-
 fs/xfs/libxfs/xfs_log_format.h                          | 2 +-
 fs/xfs/libxfs/xfs_log_recover.h                         | 2 +-
 fs/xfs/libxfs/xfs_quota_defs.h                          | 2 +-
 fs/xfs/libxfs/xfs_refcount.h                            | 2 +-
 fs/xfs/libxfs/xfs_refcount_btree.h                      | 2 +-
 fs/xfs/libxfs/xfs_rmap.h                                | 2 +-
 fs/xfs/libxfs/xfs_rmap_btree.h                          | 2 +-
 fs/xfs/libxfs/xfs_sb.h                                  | 2 +-
 fs/xfs/libxfs/xfs_shared.h                              | 2 +-
 fs/xfs/libxfs/xfs_trans_resv.h                          | 2 +-
 fs/xfs/libxfs/xfs_trans_space.h                         | 2 +-
 fs/xfs/libxfs/xfs_types.h                               | 2 +-
 fs/xfs/mrlock.h                                         | 2 +-
 fs/xfs/scrub/bitmap.h                                   | 2 +-
 fs/xfs/scrub/btree.h                                    | 2 +-
 fs/xfs/scrub/common.h                                   | 2 +-
 fs/xfs/scrub/dabtree.h                                  | 2 +-
 fs/xfs/scrub/repair.h                                   | 2 +-
 fs/xfs/scrub/scrub.h                                    | 2 +-
 fs/xfs/scrub/trace.h                                    | 2 +-
 fs/xfs/scrub/xfs_scrub.h                                | 2 +-
 fs/xfs/xfs.h                                            | 2 +-
 fs/xfs/xfs_acl.h                                        | 2 +-
 fs/xfs/xfs_aops.h                                       | 2 +-
 fs/xfs/xfs_bmap_item.h                                  | 2 +-
 fs/xfs/xfs_bmap_util.h                                  | 2 +-
 fs/xfs/xfs_buf.h                                        | 2 +-
 fs/xfs/xfs_buf_item.h                                   | 2 +-
 fs/xfs/xfs_dquot.h                                      | 2 +-
 fs/xfs/xfs_dquot_item.h                                 | 2 +-
 fs/xfs/xfs_error.h                                      | 2 +-
 fs/xfs/xfs_export.h                                     | 2 +-
 fs/xfs/xfs_extent_busy.h                                | 2 +-
 fs/xfs/xfs_extfree_item.h                               | 2 +-
 fs/xfs/xfs_filestream.h                                 | 2 +-
 fs/xfs/xfs_fsmap.h                                      | 2 +-
 fs/xfs/xfs_fsops.h                                      | 2 +-
 fs/xfs/xfs_icache.h                                     | 2 +-
 fs/xfs/xfs_icreate_item.h                               | 2 +-
 fs/xfs/xfs_inode.h                                      | 2 +-
 fs/xfs/xfs_inode_item.h                                 | 2 +-
 fs/xfs/xfs_ioctl.h                                      | 2 +-
 fs/xfs/xfs_ioctl32.h                                    | 2 +-
 fs/xfs/xfs_iomap.h                                      | 2 +-
 fs/xfs/xfs_iops.h                                       | 2 +-
 fs/xfs/xfs_itable.h                                     | 2 +-
 fs/xfs/xfs_linux.h                                      | 2 +-
 fs/xfs/xfs_log.h                                        | 2 +-
 fs/xfs/xfs_log_priv.h                                   | 2 +-
 fs/xfs/xfs_mount.h                                      | 2 +-
 fs/xfs/xfs_mru_cache.h                                  | 2 +-
 fs/xfs/xfs_ondisk.h                                     | 2 +-
 fs/xfs/xfs_qm.h                                         | 2 +-
 fs/xfs/xfs_quota.h                                      | 2 +-
 fs/xfs/xfs_refcount_item.h                              | 2 +-
 fs/xfs/xfs_reflink.h                                    | 2 +-
 fs/xfs/xfs_rmap_item.h                                  | 2 +-
 fs/xfs/xfs_rtalloc.h                                    | 2 +-
 fs/xfs/xfs_stats.h                                      | 2 +-
 fs/xfs/xfs_super.h                                      | 2 +-
 fs/xfs/xfs_symlink.h                                    | 2 +-
 fs/xfs/xfs_sysctl.h                                     | 2 +-
 fs/xfs/xfs_sysfs.h                                      | 2 +-
 fs/xfs/xfs_trace.h                                      | 2 +-
 fs/xfs/xfs_trans.h                                      | 2 +-
 fs/xfs/xfs_trans_priv.h                                 | 2 +-
 include/acpi/nfit.h                                     | 2 +-
 include/asm-generic/atomic-instrumented.h               | 2 +-
 include/asm-generic/atomic-long.h                       | 2 +-
 include/crypto/asym_tpm_subtype.h                       | 2 +-
 include/drm/drm_audio_component.h                       | 2 +-
 include/drm/drm_dsc.h                                   | 4 ++--
 include/drm/drm_probe_helper.h                          | 2 +-
 include/dt-bindings/clock/actions,s700-cmu.h            | 4 ++--
 include/dt-bindings/clock/actions,s900-cmu.h            | 2 +-
 include/dt-bindings/clock/boston-clock.h                | 2 +-
 include/dt-bindings/clock/imx6sll-clock.h               | 2 +-
 include/dt-bindings/clock/qcom,camcc-sdm845.h           | 2 +-
 include/dt-bindings/clock/r7s72100-clock.h              | 4 ++--
 include/dt-bindings/clock/r7s9210-cpg-mssr.h            | 4 ++--
 include/dt-bindings/clock/r8a7743-cpg-mssr.h            | 4 ++--
 include/dt-bindings/clock/r8a7744-cpg-mssr.h            | 4 ++--
 include/dt-bindings/clock/r8a7745-cpg-mssr.h            | 4 ++--
 include/dt-bindings/clock/r8a77470-cpg-mssr.h           | 4 ++--
 include/dt-bindings/clock/r8a774a1-cpg-mssr.h           | 4 ++--
 include/dt-bindings/clock/r8a7790-cpg-mssr.h            | 4 ++--
 include/dt-bindings/clock/r8a7791-cpg-mssr.h            | 4 ++--
 include/dt-bindings/clock/r8a7792-cpg-mssr.h            | 4 ++--
 include/dt-bindings/clock/r8a7793-clock.h               | 4 ++--
 include/dt-bindings/clock/r8a7793-cpg-mssr.h            | 4 ++--
 include/dt-bindings/clock/r8a7794-clock.h               | 4 ++--
 include/dt-bindings/clock/r8a7794-cpg-mssr.h            | 4 ++--
 include/dt-bindings/clock/r8a7795-cpg-mssr.h            | 4 ++--
 include/dt-bindings/clock/r8a7796-cpg-mssr.h            | 4 ++--
 include/dt-bindings/clock/r8a77970-cpg-mssr.h           | 4 ++--
 include/dt-bindings/clock/r8a77995-cpg-mssr.h           | 4 ++--
 include/dt-bindings/clock/renesas-cpg-mssr.h            | 4 ++--
 include/dt-bindings/clock/sprd,sc9860-clk.h             | 2 +-
 include/dt-bindings/clock/sun50i-h6-ccu.h               | 2 +-
 include/dt-bindings/clock/sun8i-de2.h                   | 2 +-
 include/dt-bindings/clock/suniv-ccu-f1c100s.h           | 4 ++--
 include/dt-bindings/gpio/meson-axg-gpio.h               | 2 +-
 include/dt-bindings/media/xilinx-vip.h                  | 2 +-
 include/dt-bindings/power/owl-s500-powergate.h          | 2 +-
 include/dt-bindings/power/owl-s700-powergate.h          | 2 +-
 include/dt-bindings/power/r8a7744-sysc.h                | 4 ++--
 include/dt-bindings/power/r8a77470-sysc.h               | 4 ++--
 include/dt-bindings/power/r8a774a1-sysc.h               | 4 ++--
 include/dt-bindings/power/r8a774c0-sysc.h               | 4 ++--
 include/dt-bindings/power/r8a77980-sysc.h               | 4 ++--
 include/dt-bindings/reset/actions,s700-reset.h          | 2 +-
 include/dt-bindings/reset/actions,s900-reset.h          | 2 +-
 include/dt-bindings/reset/amlogic,meson-axg-audio-arb.h | 4 ++--
 include/dt-bindings/reset/amlogic,meson8b-clkc-reset.h  | 2 +-
 include/dt-bindings/reset/sun50i-h6-ccu.h               | 2 +-
 include/dt-bindings/reset/sun8i-de2.h                   | 2 +-
 include/dt-bindings/reset/suniv-ccu-f1c100s.h           | 4 ++--
 include/linux/arm_sdei.h                                | 2 +-
 include/linux/ascii85.h                                 | 2 +-
 include/linux/atomic-fallback.h                         | 2 +-
 include/linux/clk/davinci.h                             | 2 +-
 include/linux/clk/renesas.h                             | 4 ++--
 include/linux/debugfs.h                                 | 2 +-
 include/linux/device.h                                  | 2 +-
 include/linux/f2fs_fs.h                                 | 2 +-
 include/linux/fsi-occ.h                                 | 2 +-
 include/linux/fsl/ptp_qoriq.h                           | 2 +-
 include/linux/hrtimer.h                                 | 2 +-
 include/linux/kobject.h                                 | 2 +-
 include/linux/kobject_ns.h                              | 2 +-
 include/linux/logic_pio.h                               | 2 +-
 include/linux/mfd/madera/core.h                         | 2 +-
 include/linux/mfd/madera/pdata.h                        | 2 +-
 include/linux/mfd/madera/registers.h                    | 2 +-
 include/linux/mtd/sh_flctl.h                            | 4 ++--
 include/linux/nospec.h                                  | 2 +-
 include/linux/nvme-tcp.h                                | 2 +-
 include/linux/platform_data/clk-da8xx-cfgchip.h         | 2 +-
 include/linux/platform_data/clk-davinci-pll.h           | 2 +-
 include/linux/platform_data/ehci-sh.h                   | 4 ++--
 include/linux/platform_data/phy-da8xx-usb.h             | 2 +-
 include/linux/pti.h                                     | 2 +-
 include/linux/rslib.h                                   | 2 +-
 include/linux/scmi_protocol.h                           | 2 +-
 include/linux/shdma-base.h                              | 4 ++--
 include/linux/slimbus.h                                 | 2 +-
 include/linux/soc/actions/owl-sps.h                     | 2 +-
 include/linux/soc/qcom/qmi.h                            | 2 +-
 include/linux/soc/ti/ti_sci_protocol.h                  | 2 +-
 include/linux/soundwire/sdw.h                           | 2 +-
 include/linux/soundwire/sdw_intel.h                     | 2 +-
 include/linux/soundwire/sdw_registers.h                 | 2 +-
 include/linux/soundwire/sdw_type.h                      | 2 +-
 include/linux/spi/spi.h                                 | 4 ++--
 include/linux/stm.h                                     | 2 +-
 include/linux/usb/association.h                         | 2 +-
 include/linux/usb/audio-v2.h                            | 2 +-
 include/linux/usb/audio-v3.h                            | 2 +-
 include/linux/usb/audio.h                               | 2 +-
 include/linux/usb/c67x00.h                              | 2 +-
 include/linux/usb/cdc-wdm.h                             | 2 +-
 include/linux/usb/cdc.h                                 | 2 +-
 include/linux/usb/cdc_ncm.h                             | 2 +-
 include/linux/usb/composite.h                           | 2 +-
 include/linux/usb/ehci_def.h                            | 2 +-
 include/linux/usb/ehci_pdriver.h                        | 2 +-
 include/linux/usb/g_hid.h                               | 2 +-
 include/linux/usb/gadget.h                              | 2 +-
 include/linux/usb/gpio_vbus.h                           | 2 +-
 include/linux/usb/hcd.h                                 | 2 +-
 include/linux/usb/input.h                               | 2 +-
 include/linux/usb/isp1301.h                             | 2 +-
 include/linux/usb/m66592.h                              | 2 +-
 include/linux/usb/musb-ux500.h                          | 2 +-
 include/linux/usb/net2280.h                             | 2 +-
 include/linux/usb/of.h                                  | 2 +-
 include/linux/usb/ohci_pdriver.h                        | 2 +-
 include/linux/usb/otg-fsm.h                             | 2 +-
 include/linux/usb/pd_ado.h                              | 2 +-
 include/linux/usb/pd_ext_sdb.h                          | 2 +-
 include/linux/usb/phy_companion.h                       | 2 +-
 include/linux/usb/r8a66597.h                            | 2 +-
 include/linux/usb/renesas_usbhs.h                       | 2 +-
 include/linux/usb/rndis_host.h                          | 2 +-
 include/linux/usb/role.h                                | 2 +-
 include/linux/usb/samsung_usb_phy.h                     | 2 +-
 include/linux/usb/serial.h                              | 2 +-
 include/linux/usb/storage.h                             | 2 +-
 include/linux/usb/tegra_usb_phy.h                       | 2 +-
 include/linux/usb/typec_mux.h                           | 2 +-
 include/linux/usb/ulpi.h                                | 2 +-
 include/linux/usb/usb338x.h                             | 2 +-
 include/linux/usb/usbnet.h                              | 2 +-
 include/linux/usb/wusb-wa.h                             | 2 +-
 include/linux/usb/wusb.h                                | 2 +-
 include/linux/usb/xhci-dbgp.h                           | 2 +-
 include/linux/usbdevice_fs.h                            | 2 +-
 include/linux/visorbus.h                                | 2 +-
 include/media/drv-intf/renesas-ceu.h                    | 2 +-
 include/media/dvb_vb2.h                                 | 2 +-
 include/media/i2c/mt9t112.h                             | 2 +-
 include/media/media-request.h                           | 2 +-
 include/misc/ocxl-config.h                              | 2 +-
 include/misc/ocxl.h                                     | 2 +-
 include/net/page_pool.h                                 | 4 ++--
 include/sound/ac97/codec.h                              | 4 ++--
 include/sound/ac97/compat.h                             | 4 ++--
 include/sound/ac97/controller.h                         | 4 ++--
 include/sound/ac97/regs.h                               | 4 ++--
 include/sound/ac97_codec.h                              | 4 ++--
 include/sound/compress_driver.h                         | 4 ++--
 include/sound/dmaengine_pcm.h                           | 4 ++--
 include/sound/hda_component.h                           | 2 +-
 include/sound/sh_fsi.h                                  | 4 ++--
 include/sound/simple_card.h                             | 4 ++--
 include/sound/simple_card_utils.h                       | 4 ++--
 include/sound/soc-acpi-intel-match.h                    | 4 ++--
 include/sound/soc-acpi.h                                | 4 ++--
 include/sound/soc-dai.h                                 | 4 ++--
 include/sound/soc-dapm.h                                | 4 ++--
 include/sound/soc-dpcm.h                                | 4 ++--
 include/sound/soc-topology.h                            | 4 ++--
 include/sound/soc.h                                     | 4 ++--
 kernel/trace/trace.h                                    | 2 +-
 kernel/trace/trace_benchmark.h                          | 2 +-
 kernel/trace/trace_entries.h                            | 2 +-
 kernel/trace/trace_events_filter_test.h                 | 2 +-
 kernel/trace/trace_kprobe_selftest.h                    | 2 +-
 kernel/trace/trace_output.h                             | 2 +-
 kernel/trace/trace_probe.h                              | 2 +-
 kernel/trace/trace_stat.h                               | 2 +-
 kernel/trace/tracing_map.h                              | 2 +-
 mm/shuffle.h                                            | 2 +-
 samples/bpf/hash_func01.h                               | 4 ++--
 sound/soc/codecs/ak5558.h                               | 4 ++--
 sound/soc/codecs/max98373.h                             | 2 +-
 sound/soc/codecs/pcm1789.h                              | 2 +-
 sound/soc/codecs/pcm186x.h                              | 2 +-
 sound/soc/codecs/tas6424.h                              | 2 +-
 sound/soc/codecs/tlv320aic31xx.h                        | 2 +-
 sound/soc/codecs/tscs42xx.h                             | 2 +-
 sound/soc/codecs/tscs454.h                              | 2 +-
 sound/soc/meson/axg-tdm-formatter.h                     | 4 ++--
 sound/soc/meson/axg-tdm.h                               | 4 ++--
 sound/soc/sh/rcar/rsnd.h                                | 2 +-
 sound/soc/sh/siu.h                                      | 2 +-
 sound/soc/sprd/sprd-pcm-dma.h                           | 2 +-
 tools/include/tools/libc_compat.h                       | 2 +-
 tools/lib/traceevent/event-parse-local.h                | 2 +-
 tools/lib/traceevent/trace-seq.h                        | 2 +-
 tools/perf/include/bpf/bpf.h                            | 2 +-
 tools/perf/include/bpf/pid_filter.h                     | 2 +-
 tools/perf/include/bpf/stdio.h                          | 2 +-
 tools/perf/include/bpf/unistd.h                         | 2 +-
 tools/perf/util/cpu-set-sched.h                         | 2 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h         | 2 +-
 tools/perf/util/map_symbol.h                            | 2 +-
 tools/testing/nvdimm/watermark.h                        | 2 +-
 tools/testing/selftests/bpf/netcnt_common.h             | 2 +-
 tools/testing/selftests/bpf/test_tcpbpf.h               | 2 +-
 tools/testing/selftests/bpf/test_tcpnotify.h            | 2 +-
 tools/testing/selftests/powerpc/ptrace/child.h          | 2 +-
 816 files changed, 970 insertions(+), 970 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ull-pinfunc-snvs.h b/arch/arm/boot/dts/imx6ull-pinfunc-snvs.h
index f6fb6783c193..54cfe72295aa 100644
--- a/arch/arm/boot/dts/imx6ull-pinfunc-snvs.h
+++ b/arch/arm/boot/dts/imx6ull-pinfunc-snvs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2016 Freescale Semiconductor, Inc.
  * Copyright (C) 2017 NXP
diff --git a/arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h b/arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h
index 1b4cb0c55744..385c455a7c98 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h
+++ b/arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2018 MediaTek Inc.
  * Author: Zhiyong Tao <zhiyong.tao@mediatek.com>
diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
index 15d49515efdd..d328540cb85e 100644
--- a/arch/arm64/include/asm/pointer_auth.h
+++ b/arch/arm64/include/asm/pointer_auth.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __ASM_POINTER_AUTH_H
 #define __ASM_POINTER_AUTH_H
 
diff --git a/arch/arm64/include/asm/sdei.h b/arch/arm64/include/asm/sdei.h
index ffe47d766c25..63e0b92a5fbb 100644
--- a/arch/arm64/include/asm/sdei.h
+++ b/arch/arm64/include/asm/sdei.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2017 Arm Ltd.
 #ifndef __ASM_SDEI_H
 #define __ASM_SDEI_H
diff --git a/arch/arm64/include/asm/vmap_stack.h b/arch/arm64/include/asm/vmap_stack.h
index 0b5ec6e08c10..0a12115d9638 100644
--- a/arch/arm64/include/asm/vmap_stack.h
+++ b/arch/arm64/include/asm/vmap_stack.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2017 Arm Ltd.
 #ifndef __ASM_VMAP_STACK_H
 #define __ASM_VMAP_STACK_H
diff --git a/arch/nds32/include/asm/assembler.h b/arch/nds32/include/asm/assembler.h
index c3855782a541..5e7c56926049 100644
--- a/arch/nds32/include/asm/assembler.h
+++ b/arch/nds32/include/asm/assembler.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_ASSEMBLER_H__
diff --git a/arch/nds32/include/asm/barrier.h b/arch/nds32/include/asm/barrier.h
index faafc373ea6c..16413172fd50 100644
--- a/arch/nds32/include/asm/barrier.h
+++ b/arch/nds32/include/asm/barrier.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_ASM_BARRIER_H
diff --git a/arch/nds32/include/asm/bitfield.h b/arch/nds32/include/asm/bitfield.h
index 7414fcbbab4e..e75212c76b20 100644
--- a/arch/nds32/include/asm/bitfield.h
+++ b/arch/nds32/include/asm/bitfield.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_BITFIELD_H__
diff --git a/arch/nds32/include/asm/cache.h b/arch/nds32/include/asm/cache.h
index 347db4881c5f..fc3c41b59169 100644
--- a/arch/nds32/include/asm/cache.h
+++ b/arch/nds32/include/asm/cache.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_CACHE_H__
diff --git a/arch/nds32/include/asm/cache_info.h b/arch/nds32/include/asm/cache_info.h
index 38ec458ba543..e89d8078f3a6 100644
--- a/arch/nds32/include/asm/cache_info.h
+++ b/arch/nds32/include/asm/cache_info.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 struct cache_info {
diff --git a/arch/nds32/include/asm/cacheflush.h b/arch/nds32/include/asm/cacheflush.h
index 8b26198d51bb..d9ac7e6408ef 100644
--- a/arch/nds32/include/asm/cacheflush.h
+++ b/arch/nds32/include/asm/cacheflush.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_CACHEFLUSH_H__
diff --git a/arch/nds32/include/asm/current.h b/arch/nds32/include/asm/current.h
index b4dcd22b7bcb..65d30096142b 100644
--- a/arch/nds32/include/asm/current.h
+++ b/arch/nds32/include/asm/current.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASM_NDS32_CURRENT_H
diff --git a/arch/nds32/include/asm/delay.h b/arch/nds32/include/asm/delay.h
index 519ba97acb6e..56ea3894f8f8 100644
--- a/arch/nds32/include/asm/delay.h
+++ b/arch/nds32/include/asm/delay.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_DELAY_H__
diff --git a/arch/nds32/include/asm/elf.h b/arch/nds32/include/asm/elf.h
index 95f3ea253e4c..70aa9cfb523c 100644
--- a/arch/nds32/include/asm/elf.h
+++ b/arch/nds32/include/asm/elf.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASMNDS32_ELF_H
diff --git a/arch/nds32/include/asm/fixmap.h b/arch/nds32/include/asm/fixmap.h
index 0e60e153a71a..5a4bf11e5800 100644
--- a/arch/nds32/include/asm/fixmap.h
+++ b/arch/nds32/include/asm/fixmap.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_FIXMAP_H
diff --git a/arch/nds32/include/asm/futex.h b/arch/nds32/include/asm/futex.h
index baf178bf1d0b..5213c65c2e0b 100644
--- a/arch/nds32/include/asm/futex.h
+++ b/arch/nds32/include/asm/futex.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_FUTEX_H__
diff --git a/arch/nds32/include/asm/highmem.h b/arch/nds32/include/asm/highmem.h
index 425d546cb059..b3a82c97ded3 100644
--- a/arch/nds32/include/asm/highmem.h
+++ b/arch/nds32/include/asm/highmem.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASM_HIGHMEM_H
diff --git a/arch/nds32/include/asm/io.h b/arch/nds32/include/asm/io.h
index 71cd226d6863..7cbf76ec439d 100644
--- a/arch/nds32/include/asm/io.h
+++ b/arch/nds32/include/asm/io.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_IO_H
diff --git a/arch/nds32/include/asm/irqflags.h b/arch/nds32/include/asm/irqflags.h
index 2bfd00f8bc48..fb45ec46bb1b 100644
--- a/arch/nds32/include/asm/irqflags.h
+++ b/arch/nds32/include/asm/irqflags.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #include <asm/nds32.h>
diff --git a/arch/nds32/include/asm/l2_cache.h b/arch/nds32/include/asm/l2_cache.h
index 37dd5ef61de8..3ea48e19e6de 100644
--- a/arch/nds32/include/asm/l2_cache.h
+++ b/arch/nds32/include/asm/l2_cache.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef L2_CACHE_H
diff --git a/arch/nds32/include/asm/linkage.h b/arch/nds32/include/asm/linkage.h
index e708c8bdb926..a696469abb70 100644
--- a/arch/nds32/include/asm/linkage.h
+++ b/arch/nds32/include/asm/linkage.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_LINKAGE_H
diff --git a/arch/nds32/include/asm/memory.h b/arch/nds32/include/asm/memory.h
index 60efc726b56e..3f4b5eeb5be2 100644
--- a/arch/nds32/include/asm/memory.h
+++ b/arch/nds32/include/asm/memory.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_MEMORY_H
diff --git a/arch/nds32/include/asm/mmu.h b/arch/nds32/include/asm/mmu.h
index 88b9ee8c1064..89d63afee455 100644
--- a/arch/nds32/include/asm/mmu.h
+++ b/arch/nds32/include/asm/mmu.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_MMU_H
diff --git a/arch/nds32/include/asm/mmu_context.h b/arch/nds32/include/asm/mmu_context.h
index fd7d13cefccc..b8fd3d189fdc 100644
--- a/arch/nds32/include/asm/mmu_context.h
+++ b/arch/nds32/include/asm/mmu_context.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_MMU_CONTEXT_H
diff --git a/arch/nds32/include/asm/module.h b/arch/nds32/include/asm/module.h
index 16cf9c7237ad..a3a08e993c65 100644
--- a/arch/nds32/include/asm/module.h
+++ b/arch/nds32/include/asm/module.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASM_NDS32_MODULE_H
diff --git a/arch/nds32/include/asm/nds32.h b/arch/nds32/include/asm/nds32.h
index 68c38151c3e4..4994f6a9e0a0 100644
--- a/arch/nds32/include/asm/nds32.h
+++ b/arch/nds32/include/asm/nds32.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASM_NDS32_NDS32_H_
diff --git a/arch/nds32/include/asm/page.h b/arch/nds32/include/asm/page.h
index 947f0491c9a7..8feb1fa12f01 100644
--- a/arch/nds32/include/asm/page.h
+++ b/arch/nds32/include/asm/page.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * SPDX-License-Identifier: GPL-2.0
  * Copyright (C) 2005-2017 Andes Technology Corporation
  */
 
diff --git a/arch/nds32/include/asm/pgalloc.h b/arch/nds32/include/asm/pgalloc.h
index 3c5fee5b5759..3cbc749c79aa 100644
--- a/arch/nds32/include/asm/pgalloc.h
+++ b/arch/nds32/include/asm/pgalloc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASMNDS32_PGALLOC_H
diff --git a/arch/nds32/include/asm/pgtable.h b/arch/nds32/include/asm/pgtable.h
index 9f52db930c00..e820b0117399 100644
--- a/arch/nds32/include/asm/pgtable.h
+++ b/arch/nds32/include/asm/pgtable.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASMNDS32_PGTABLE_H
diff --git a/arch/nds32/include/asm/proc-fns.h b/arch/nds32/include/asm/proc-fns.h
index bedc4f59e064..27c617fa77af 100644
--- a/arch/nds32/include/asm/proc-fns.h
+++ b/arch/nds32/include/asm/proc-fns.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_PROCFNS_H__
diff --git a/arch/nds32/include/asm/processor.h b/arch/nds32/include/asm/processor.h
index 72024f8bc129..b82369c7659d 100644
--- a/arch/nds32/include/asm/processor.h
+++ b/arch/nds32/include/asm/processor.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_PROCESSOR_H
diff --git a/arch/nds32/include/asm/ptrace.h b/arch/nds32/include/asm/ptrace.h
index c4538839055c..919ee223620c 100644
--- a/arch/nds32/include/asm/ptrace.h
+++ b/arch/nds32/include/asm/ptrace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_PTRACE_H
diff --git a/arch/nds32/include/asm/shmparam.h b/arch/nds32/include/asm/shmparam.h
index fd1cff64b68e..3aeee946973d 100644
--- a/arch/nds32/include/asm/shmparam.h
+++ b/arch/nds32/include/asm/shmparam.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASMNDS32_SHMPARAM_H
diff --git a/arch/nds32/include/asm/string.h b/arch/nds32/include/asm/string.h
index 179272caa540..cae8fe16de98 100644
--- a/arch/nds32/include/asm/string.h
+++ b/arch/nds32/include/asm/string.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_STRING_H
diff --git a/arch/nds32/include/asm/swab.h b/arch/nds32/include/asm/swab.h
index e01a755a37d2..362a466f2976 100644
--- a/arch/nds32/include/asm/swab.h
+++ b/arch/nds32/include/asm/swab.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_SWAB_H__
diff --git a/arch/nds32/include/asm/syscall.h b/arch/nds32/include/asm/syscall.h
index f7e5e86765fe..50e2893e5f1e 100644
--- a/arch/nds32/include/asm/syscall.h
+++ b/arch/nds32/include/asm/syscall.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2008-2009 Red Hat, Inc.  All rights reserved.
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
diff --git a/arch/nds32/include/asm/syscalls.h b/arch/nds32/include/asm/syscalls.h
index da32101b455d..f3b16f602cb5 100644
--- a/arch/nds32/include/asm/syscalls.h
+++ b/arch/nds32/include/asm/syscalls.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_SYSCALLS_H
diff --git a/arch/nds32/include/asm/thread_info.h b/arch/nds32/include/asm/thread_info.h
index bff741ff337b..3734b1c1cf82 100644
--- a/arch/nds32/include/asm/thread_info.h
+++ b/arch/nds32/include/asm/thread_info.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_THREAD_INFO_H
diff --git a/arch/nds32/include/asm/tlb.h b/arch/nds32/include/asm/tlb.h
index b35ae5eae3ab..0c24cefaba81 100644
--- a/arch/nds32/include/asm/tlb.h
+++ b/arch/nds32/include/asm/tlb.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASMNDS32_TLB_H
diff --git a/arch/nds32/include/asm/tlbflush.h b/arch/nds32/include/asm/tlbflush.h
index 9b411f401903..62e63b891a4a 100644
--- a/arch/nds32/include/asm/tlbflush.h
+++ b/arch/nds32/include/asm/tlbflush.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASMNDS32_TLBFLUSH_H
diff --git a/arch/nds32/include/asm/uaccess.h b/arch/nds32/include/asm/uaccess.h
index 53dcb49b0b12..0979912f1cbe 100644
--- a/arch/nds32/include/asm/uaccess.h
+++ b/arch/nds32/include/asm/uaccess.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASMANDES_UACCESS_H
diff --git a/arch/nds32/include/asm/unistd.h b/arch/nds32/include/asm/unistd.h
index b586a2862beb..bf5e2d440913 100644
--- a/arch/nds32/include/asm/unistd.h
+++ b/arch/nds32/include/asm/unistd.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/nds32/include/asm/vdso.h b/arch/nds32/include/asm/vdso.h
index af2c6afc2469..89b113ffc3dc 100644
--- a/arch/nds32/include/asm/vdso.h
+++ b/arch/nds32/include/asm/vdso.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * SPDX-License-Identifier: GPL-2.0
  * Copyright (C) 2005-2017 Andes Technology Corporation
  */
 
diff --git a/arch/nds32/include/asm/vdso_datapage.h b/arch/nds32/include/asm/vdso_datapage.h
index 79db5a12ca5e..cd1dda3da0f9 100644
--- a/arch/nds32/include/asm/vdso_datapage.h
+++ b/arch/nds32/include/asm/vdso_datapage.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2012 ARM Limited
 // Copyright (C) 2005-2017 Andes Technology Corporation
 #ifndef __ASM_VDSO_DATAPAGE_H
diff --git a/arch/nds32/include/asm/vdso_timer_info.h b/arch/nds32/include/asm/vdso_timer_info.h
index 50ba117cff12..328439ce37db 100644
--- a/arch/nds32/include/asm/vdso_timer_info.h
+++ b/arch/nds32/include/asm/vdso_timer_info.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 extern struct timer_info_t timer_info;
diff --git a/arch/nds32/include/uapi/asm/auxvec.h b/arch/nds32/include/uapi/asm/auxvec.h
index 2d3213f5e595..b5d58ea8decb 100644
--- a/arch/nds32/include/uapi/asm/auxvec.h
+++ b/arch/nds32/include/uapi/asm/auxvec.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_AUXVEC_H
diff --git a/arch/nds32/include/uapi/asm/byteorder.h b/arch/nds32/include/uapi/asm/byteorder.h
index a23f6f3a2468..511e653c709d 100644
--- a/arch/nds32/include/uapi/asm/byteorder.h
+++ b/arch/nds32/include/uapi/asm/byteorder.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_BYTEORDER_H__
diff --git a/arch/nds32/include/uapi/asm/cachectl.h b/arch/nds32/include/uapi/asm/cachectl.h
index 4cdca9b23974..73793662815c 100644
--- a/arch/nds32/include/uapi/asm/cachectl.h
+++ b/arch/nds32/include/uapi/asm/cachectl.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 1994, 1995, 1996 by Ralf Baechle
 // Copyright (C) 2005-2017 Andes Technology Corporation
 #ifndef	_ASM_CACHECTL
diff --git a/arch/nds32/include/uapi/asm/param.h b/arch/nds32/include/uapi/asm/param.h
index e3fb723ee362..2977534a6bd3 100644
--- a/arch/nds32/include/uapi/asm/param.h
+++ b/arch/nds32/include/uapi/asm/param.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_PARAM_H
diff --git a/arch/nds32/include/uapi/asm/ptrace.h b/arch/nds32/include/uapi/asm/ptrace.h
index 358c99e399d0..1a6e01c00e6f 100644
--- a/arch/nds32/include/uapi/asm/ptrace.h
+++ b/arch/nds32/include/uapi/asm/ptrace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __UAPI_ASM_NDS32_PTRACE_H
diff --git a/arch/nds32/include/uapi/asm/sigcontext.h b/arch/nds32/include/uapi/asm/sigcontext.h
index 58afc416473e..628ff6b75825 100644
--- a/arch/nds32/include/uapi/asm/sigcontext.h
+++ b/arch/nds32/include/uapi/asm/sigcontext.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASMNDS32_SIGCONTEXT_H
diff --git a/arch/nds32/include/uapi/asm/unistd.h b/arch/nds32/include/uapi/asm/unistd.h
index c2c3a3e34083..319374706aae 100644
--- a/arch/nds32/include/uapi/asm/unistd.h
+++ b/arch/nds32/include/uapi/asm/unistd.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #define __ARCH_WANT_STAT64
diff --git a/arch/powerpc/include/asm/pnv-ocxl.h b/arch/powerpc/include/asm/pnv-ocxl.h
index 208b5503f4ed..7de82647e761 100644
--- a/arch/powerpc/include/asm/pnv-ocxl.h
+++ b/arch/powerpc/include/asm/pnv-ocxl.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 // Copyright 2017 IBM Corp.
 #ifndef _ASM_PNV_OCXL_H
 #define _ASM_PNV_OCXL_H
diff --git a/arch/sh/drivers/pci/pci-sh5.h b/arch/sh/drivers/pci/pci-sh5.h
index 91348af0ef6c..0d2c093fd984 100644
--- a/arch/sh/drivers/pci/pci-sh5.h
+++ b/arch/sh/drivers/pci/pci-sh5.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2001 David J. Mckay (david.mckay@st.com)
  *
  * Definitions for the SH5 PCI hardware.
diff --git a/arch/sh/drivers/pci/pci-sh7751.h b/arch/sh/drivers/pci/pci-sh7751.h
index d1951e50effc..9e23cf7113ac 100644
--- a/arch/sh/drivers/pci/pci-sh7751.h
+++ b/arch/sh/drivers/pci/pci-sh7751.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  *	Low-Level PCI Support for SH7751 targets
  *
  *  Dustin McIntire (dustin@sensoria.com) (c) 2001
diff --git a/arch/sh/drivers/pci/pci-sh7780.h b/arch/sh/drivers/pci/pci-sh7780.h
index e2ac770f8e35..7ba87b62e439 100644
--- a/arch/sh/drivers/pci/pci-sh7780.h
+++ b/arch/sh/drivers/pci/pci-sh7780.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  *	Low-Level PCI Support for SH7780 targets
  *
  *  Dustin McIntire (dustin@sensoria.com) (c) 2001
diff --git a/arch/sh/drivers/pci/pcie-sh7786.h b/arch/sh/drivers/pci/pcie-sh7786.h
index ffe383681a0b..c5e2221b6359 100644
--- a/arch/sh/drivers/pci/pcie-sh7786.h
+++ b/arch/sh/drivers/pci/pcie-sh7786.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * SH7786 PCI-Express controller definitions.
  *
  * Copyright (C) 2008, 2009 Renesas Technology Corp.
diff --git a/arch/sh/include/asm/addrspace.h b/arch/sh/include/asm/addrspace.h
index 34bfbcddcce0..c663527cab7c 100644
--- a/arch/sh/include/asm/addrspace.h
+++ b/arch/sh/include/asm/addrspace.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 1999 by Kaz Kojima
  *
  * Defitions for the address spaces of the SH CPUs.
diff --git a/arch/sh/include/asm/bl_bit_64.h b/arch/sh/include/asm/bl_bit_64.h
index aac9780fe864..c6032f194f4c 100644
--- a/arch/sh/include/asm/bl_bit_64.h
+++ b/arch/sh/include/asm/bl_bit_64.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2003  Paul Mundt
  * Copyright (C) 2004  Richard Curnow
diff --git a/arch/sh/include/asm/cache_insns_64.h b/arch/sh/include/asm/cache_insns_64.h
index ed682b987b0d..768f18aae612 100644
--- a/arch/sh/include/asm/cache_insns_64.h
+++ b/arch/sh/include/asm/cache_insns_64.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2003  Paul Mundt
  * Copyright (C) 2004  Richard Curnow
diff --git a/arch/sh/include/asm/device.h b/arch/sh/include/asm/device.h
index 6f3e686a1c6f..75e0f44f8969 100644
--- a/arch/sh/include/asm/device.h
+++ b/arch/sh/include/asm/device.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Arch specific extensions to struct device
  */
 #ifndef __ASM_SH_DEVICE_H
diff --git a/arch/sh/include/asm/dma-register.h b/arch/sh/include/asm/dma-register.h
index 724dab912b71..96fed7b02b0f 100644
--- a/arch/sh/include/asm/dma-register.h
+++ b/arch/sh/include/asm/dma-register.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Common header for the legacy SH DMA driver and the new dmaengine driver
  *
  * extracted from arch/sh/include/asm/dma-sh.h:
diff --git a/arch/sh/include/asm/dma.h b/arch/sh/include/asm/dma.h
index 4d5a21a891c0..faa1b66b9397 100644
--- a/arch/sh/include/asm/dma.h
+++ b/arch/sh/include/asm/dma.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/dma.h
  *
  * Copyright (C) 2003, 2004  Paul Mundt
diff --git a/arch/sh/include/asm/dwarf.h b/arch/sh/include/asm/dwarf.h
index 571954474122..661d1b9f07d4 100644
--- a/arch/sh/include/asm/dwarf.h
+++ b/arch/sh/include/asm/dwarf.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2009 Matt Fleming <matt@console-pimps.org>
  */
 #ifndef __ASM_SH_DWARF_H
diff --git a/arch/sh/include/asm/fixmap.h b/arch/sh/include/asm/fixmap.h
index e30348c58073..15abcd96f4b2 100644
--- a/arch/sh/include/asm/fixmap.h
+++ b/arch/sh/include/asm/fixmap.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * fixmap.h: compile-time virtual memory allocation
  *
  * Copyright (C) 1998 Ingo Molnar
diff --git a/arch/sh/include/asm/flat.h b/arch/sh/include/asm/flat.h
index 843d458b8329..6adbdfda6951 100644
--- a/arch/sh/include/asm/flat.h
+++ b/arch/sh/include/asm/flat.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/flat.h
  *
  * uClinux flat-format executables
diff --git a/arch/sh/include/asm/freq.h b/arch/sh/include/asm/freq.h
index 18133bf83738..693183a63bfb 100644
--- a/arch/sh/include/asm/freq.h
+++ b/arch/sh/include/asm/freq.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * include/asm-sh/freq.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
diff --git a/arch/sh/include/asm/gpio.h b/arch/sh/include/asm/gpio.h
index 351918894e86..18319e97a5ec 100644
--- a/arch/sh/include/asm/gpio.h
+++ b/arch/sh/include/asm/gpio.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  *  include/asm-sh/gpio.h
  *
  * Generic GPIO API and pinmux table support for SuperH.
diff --git a/arch/sh/include/asm/machvec.h b/arch/sh/include/asm/machvec.h
index f7d05546beca..76c528b8df83 100644
--- a/arch/sh/include/asm/machvec.h
+++ b/arch/sh/include/asm/machvec.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/machvec.h
  *
  * Copyright 2000 Stuart Menefy (stuart.menefy@st.com)
diff --git a/arch/sh/include/asm/pgtable.h b/arch/sh/include/asm/pgtable.h
index 3587103afe59..daa593d9f81f 100644
--- a/arch/sh/include/asm/pgtable.h
+++ b/arch/sh/include/asm/pgtable.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * This file contains the functions and defines necessary to modify and
  * use the SuperH page table tree.
  *
diff --git a/arch/sh/include/asm/sfp-machine.h b/arch/sh/include/asm/sfp-machine.h
index cbc7cf8c97ce..77b40ceec36c 100644
--- a/arch/sh/include/asm/sfp-machine.h
+++ b/arch/sh/include/asm/sfp-machine.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * Machine-dependent software floating-point definitions.
    SuperH kernel version.
    Copyright (C) 1997,1998,1999 Free Software Foundation, Inc.
diff --git a/arch/sh/include/asm/shmparam.h b/arch/sh/include/asm/shmparam.h
index 6c580a644a78..4a83ec04128a 100644
--- a/arch/sh/include/asm/shmparam.h
+++ b/arch/sh/include/asm/shmparam.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/shmparam.h
  *
  * Copyright (C) 1999 Niibe Yutaka
diff --git a/arch/sh/include/asm/siu.h b/arch/sh/include/asm/siu.h
index 35e4839d381e..1af6844b1f00 100644
--- a/arch/sh/include/asm/siu.h
+++ b/arch/sh/include/asm/siu.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * platform header for the SIU ASoC driver
  *
  * Copyright (C) 2009-2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
diff --git a/arch/sh/include/asm/spinlock-cas.h b/arch/sh/include/asm/spinlock-cas.h
index 3d49985ebf41..c9ed7492dd5d 100644
--- a/arch/sh/include/asm/spinlock-cas.h
+++ b/arch/sh/include/asm/spinlock-cas.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/spinlock-cas.h
  *
  * Copyright (C) 2015 SEI
diff --git a/arch/sh/include/asm/spinlock-llsc.h b/arch/sh/include/asm/spinlock-llsc.h
index 786ee0fde3b0..5508c0d47091 100644
--- a/arch/sh/include/asm/spinlock-llsc.h
+++ b/arch/sh/include/asm/spinlock-llsc.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/spinlock-llsc.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
diff --git a/arch/sh/include/asm/spinlock.h b/arch/sh/include/asm/spinlock.h
index fa6801f63551..6cc36df2ddd3 100644
--- a/arch/sh/include/asm/spinlock.h
+++ b/arch/sh/include/asm/spinlock.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/spinlock.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
diff --git a/arch/sh/include/asm/switch_to.h b/arch/sh/include/asm/switch_to.h
index 9eec80ab5aa2..3fe65cf11319 100644
--- a/arch/sh/include/asm/switch_to.h
+++ b/arch/sh/include/asm/switch_to.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2003  Paul Mundt
  * Copyright (C) 2004  Richard Curnow
diff --git a/arch/sh/include/asm/switch_to_64.h b/arch/sh/include/asm/switch_to_64.h
index 2dbf2311669f..87a08602f1c9 100644
--- a/arch/sh/include/asm/switch_to_64.h
+++ b/arch/sh/include/asm/switch_to_64.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2003  Paul Mundt
  * Copyright (C) 2004  Richard Curnow
diff --git a/arch/sh/include/asm/tlb_64.h b/arch/sh/include/asm/tlb_64.h
index 59fa0a23dad7..dac46f8c5216 100644
--- a/arch/sh/include/asm/tlb_64.h
+++ b/arch/sh/include/asm/tlb_64.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/tlb_64.h
  *
  * Copyright (C) 2003  Paul Mundt
diff --git a/arch/sh/include/asm/traps_64.h b/arch/sh/include/asm/traps_64.h
index f28db6dfbe45..7e5e902d2278 100644
--- a/arch/sh/include/asm/traps_64.h
+++ b/arch/sh/include/asm/traps_64.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2003  Paul Mundt
  * Copyright (C) 2004  Richard Curnow
diff --git a/arch/sh/include/asm/watchdog.h b/arch/sh/include/asm/watchdog.h
index cecd0fc507f9..6f64666186c2 100644
--- a/arch/sh/include/asm/watchdog.h
+++ b/arch/sh/include/asm/watchdog.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * include/asm-sh/watchdog.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
diff --git a/arch/sh/include/cpu-common/cpu/addrspace.h b/arch/sh/include/cpu-common/cpu/addrspace.h
index d8bf5d7d2fdf..2c0f54e68bb2 100644
--- a/arch/sh/include/cpu-common/cpu/addrspace.h
+++ b/arch/sh/include/cpu-common/cpu/addrspace.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Definitions for the address spaces of the SH-2 CPUs.
  *
  * Copyright (C) 2003  Paul Mundt
diff --git a/arch/sh/include/cpu-common/cpu/mmu_context.h b/arch/sh/include/cpu-common/cpu/mmu_context.h
index cef3a30dbf97..0f2602e1c963 100644
--- a/arch/sh/include/cpu-common/cpu/mmu_context.h
+++ b/arch/sh/include/cpu-common/cpu/mmu_context.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh2/mmu_context.h
  *
  * Copyright (C) 2003  Paul Mundt
diff --git a/arch/sh/include/cpu-common/cpu/pfc.h b/arch/sh/include/cpu-common/cpu/pfc.h
index 879d2c9da537..8ca16923cc40 100644
--- a/arch/sh/include/cpu-common/cpu/pfc.h
+++ b/arch/sh/include/cpu-common/cpu/pfc.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * SH Pin Function Control Initialization
  *
  * Copyright (C) 2012  Renesas Solutions Corp.
diff --git a/arch/sh/include/cpu-sh2/cpu/cache.h b/arch/sh/include/cpu-sh2/cpu/cache.h
index 070aa9f50d3f..9508876fede0 100644
--- a/arch/sh/include/cpu-sh2/cpu/cache.h
+++ b/arch/sh/include/cpu-sh2/cpu/cache.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh2/cache.h
  *
  * Copyright (C) 2003 Paul Mundt
diff --git a/arch/sh/include/cpu-sh2/cpu/freq.h b/arch/sh/include/cpu-sh2/cpu/freq.h
index fb2e5d2831bc..a598fba55059 100644
--- a/arch/sh/include/cpu-sh2/cpu/freq.h
+++ b/arch/sh/include/cpu-sh2/cpu/freq.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh2/freq.h
  *
  * Copyright (C) 2006  Yoshinori Sato
diff --git a/arch/sh/include/cpu-sh2/cpu/watchdog.h b/arch/sh/include/cpu-sh2/cpu/watchdog.h
index 141fe296d751..ef3941c3b726 100644
--- a/arch/sh/include/cpu-sh2/cpu/watchdog.h
+++ b/arch/sh/include/cpu-sh2/cpu/watchdog.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh2/watchdog.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
diff --git a/arch/sh/include/cpu-sh2a/cpu/cache.h b/arch/sh/include/cpu-sh2a/cpu/cache.h
index 06efb233eb35..259e4cbc4131 100644
--- a/arch/sh/include/cpu-sh2a/cpu/cache.h
+++ b/arch/sh/include/cpu-sh2a/cpu/cache.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh2a/cache.h
  *
  * Copyright (C) 2004 Paul Mundt
diff --git a/arch/sh/include/cpu-sh2a/cpu/freq.h b/arch/sh/include/cpu-sh2a/cpu/freq.h
index fb0813f47043..a637324e0f43 100644
--- a/arch/sh/include/cpu-sh2a/cpu/freq.h
+++ b/arch/sh/include/cpu-sh2a/cpu/freq.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh2a/freq.h
  *
  * Copyright (C) 2006  Yoshinori Sato
diff --git a/arch/sh/include/cpu-sh3/cpu/cache.h b/arch/sh/include/cpu-sh3/cpu/cache.h
index f57124826943..99f53e41e781 100644
--- a/arch/sh/include/cpu-sh3/cpu/cache.h
+++ b/arch/sh/include/cpu-sh3/cpu/cache.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh3/cache.h
  *
  * Copyright (C) 1999 Niibe Yutaka
diff --git a/arch/sh/include/cpu-sh3/cpu/dma-register.h b/arch/sh/include/cpu-sh3/cpu/dma-register.h
index c0f921fb4edc..efc3632756bf 100644
--- a/arch/sh/include/cpu-sh3/cpu/dma-register.h
+++ b/arch/sh/include/cpu-sh3/cpu/dma-register.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * SH3 CPU-specific DMA definitions, used by both DMA drivers
  *
  * Copyright (C) 2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
diff --git a/arch/sh/include/cpu-sh3/cpu/freq.h b/arch/sh/include/cpu-sh3/cpu/freq.h
index 7290f02b7173..5968337d7e84 100644
--- a/arch/sh/include/cpu-sh3/cpu/freq.h
+++ b/arch/sh/include/cpu-sh3/cpu/freq.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh3/freq.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
diff --git a/arch/sh/include/cpu-sh3/cpu/gpio.h b/arch/sh/include/cpu-sh3/cpu/gpio.h
index aeb0588ace98..391d55f4b689 100644
--- a/arch/sh/include/cpu-sh3/cpu/gpio.h
+++ b/arch/sh/include/cpu-sh3/cpu/gpio.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  *  include/asm-sh/cpu-sh3/gpio.h
  *
  *  Copyright (C) 2007  Markus Brunner, Mark Jonas
diff --git a/arch/sh/include/cpu-sh3/cpu/mmu_context.h b/arch/sh/include/cpu-sh3/cpu/mmu_context.h
index ead9a6f72113..45a3ac26a6c5 100644
--- a/arch/sh/include/cpu-sh3/cpu/mmu_context.h
+++ b/arch/sh/include/cpu-sh3/cpu/mmu_context.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh3/mmu_context.h
  *
  * Copyright (C) 1999 Niibe Yutaka
diff --git a/arch/sh/include/cpu-sh3/cpu/watchdog.h b/arch/sh/include/cpu-sh3/cpu/watchdog.h
index 9d7e9d986809..406f770f956a 100644
--- a/arch/sh/include/cpu-sh3/cpu/watchdog.h
+++ b/arch/sh/include/cpu-sh3/cpu/watchdog.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh3/watchdog.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
diff --git a/arch/sh/include/cpu-sh4/cpu/addrspace.h b/arch/sh/include/cpu-sh4/cpu/addrspace.h
index f006c9489f5a..92a6e0348e70 100644
--- a/arch/sh/include/cpu-sh4/cpu/addrspace.h
+++ b/arch/sh/include/cpu-sh4/cpu/addrspace.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 1999 by Kaz Kojima
  *
  * Defitions for the address spaces of the SH-4 CPUs.
diff --git a/arch/sh/include/cpu-sh4/cpu/cache.h b/arch/sh/include/cpu-sh4/cpu/cache.h
index 72b4d13da127..a2a0f2739ce4 100644
--- a/arch/sh/include/cpu-sh4/cpu/cache.h
+++ b/arch/sh/include/cpu-sh4/cpu/cache.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh4/cache.h
  *
  * Copyright (C) 1999 Niibe Yutaka
diff --git a/arch/sh/include/cpu-sh4/cpu/dma-register.h b/arch/sh/include/cpu-sh4/cpu/dma-register.h
index 53f7ab990d88..4a284e70a757 100644
--- a/arch/sh/include/cpu-sh4/cpu/dma-register.h
+++ b/arch/sh/include/cpu-sh4/cpu/dma-register.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * SH4 CPU-specific DMA definitions, used by both DMA drivers
  *
  * Copyright (C) 2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
diff --git a/arch/sh/include/cpu-sh4/cpu/fpu.h b/arch/sh/include/cpu-sh4/cpu/fpu.h
index 29f451bfef19..7722f23b6118 100644
--- a/arch/sh/include/cpu-sh4/cpu/fpu.h
+++ b/arch/sh/include/cpu-sh4/cpu/fpu.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * linux/arch/sh/kernel/cpu/sh4/sh4_fpu.h
  *
  * Copyright (C) 2006 STMicroelectronics Limited
diff --git a/arch/sh/include/cpu-sh4/cpu/freq.h b/arch/sh/include/cpu-sh4/cpu/freq.h
index 662f0f30e106..5d9cdaa0c4ba 100644
--- a/arch/sh/include/cpu-sh4/cpu/freq.h
+++ b/arch/sh/include/cpu-sh4/cpu/freq.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh4/freq.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
diff --git a/arch/sh/include/cpu-sh4/cpu/mmu_context.h b/arch/sh/include/cpu-sh4/cpu/mmu_context.h
index 421b56d5c595..df5335e9e80f 100644
--- a/arch/sh/include/cpu-sh4/cpu/mmu_context.h
+++ b/arch/sh/include/cpu-sh4/cpu/mmu_context.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh4/mmu_context.h
  *
  * Copyright (C) 1999 Niibe Yutaka
diff --git a/arch/sh/include/cpu-sh4/cpu/sh7786.h b/arch/sh/include/cpu-sh4/cpu/sh7786.h
index 8f9bfbf3cdb1..4af6e5a2cd97 100644
--- a/arch/sh/include/cpu-sh4/cpu/sh7786.h
+++ b/arch/sh/include/cpu-sh4/cpu/sh7786.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * SH7786 Pinmux
  *
  * Copyright (C) 2008, 2009  Renesas Solutions Corp.
diff --git a/arch/sh/include/cpu-sh4/cpu/sq.h b/arch/sh/include/cpu-sh4/cpu/sq.h
index 81966e41fc21..91f6b1022e5f 100644
--- a/arch/sh/include/cpu-sh4/cpu/sq.h
+++ b/arch/sh/include/cpu-sh4/cpu/sq.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh4/sq.h
  *
  * Copyright (C) 2001, 2002, 2003  Paul Mundt
diff --git a/arch/sh/include/cpu-sh4/cpu/watchdog.h b/arch/sh/include/cpu-sh4/cpu/watchdog.h
index fa7bcb398b8c..5190f7a8ed99 100644
--- a/arch/sh/include/cpu-sh4/cpu/watchdog.h
+++ b/arch/sh/include/cpu-sh4/cpu/watchdog.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh4/watchdog.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
diff --git a/arch/sh/include/mach-common/mach/hp6xx.h b/arch/sh/include/mach-common/mach/hp6xx.h
index 71241f0d02a1..10e8c4cf2247 100644
--- a/arch/sh/include/mach-common/mach/hp6xx.h
+++ b/arch/sh/include/mach-common/mach/hp6xx.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2003, 2004, 2005  Andriy Skulysh
  */
 #ifndef __ASM_SH_HP6XX_H
diff --git a/arch/sh/include/mach-common/mach/magicpanelr2.h b/arch/sh/include/mach-common/mach/magicpanelr2.h
index c2d218cea74b..ee8a76c4e21f 100644
--- a/arch/sh/include/mach-common/mach/magicpanelr2.h
+++ b/arch/sh/include/mach-common/mach/magicpanelr2.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  *  include/asm-sh/magicpanelr2.h
  *
  *  Copyright (C) 2007  Markus Brunner, Mark Jonas
diff --git a/arch/sh/include/mach-common/mach/mangle-port.h b/arch/sh/include/mach-common/mach/mangle-port.h
index dd5a761a52ee..3cca842fd1d2 100644
--- a/arch/sh/include/mach-common/mach/mangle-port.h
+++ b/arch/sh/include/mach-common/mach/mangle-port.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * SH version cribbed from the MIPS copy:
  *
  * Copyright (C) 2003, 2004 Ralf Baechle
diff --git a/arch/sh/include/mach-common/mach/microdev.h b/arch/sh/include/mach-common/mach/microdev.h
index 0e2f9ab11976..38c4120bf439 100644
--- a/arch/sh/include/mach-common/mach/microdev.h
+++ b/arch/sh/include/mach-common/mach/microdev.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * linux/include/asm-sh/microdev.h
  *
  * Copyright (C) 2003 Sean McGoogan (Sean.McGoogan@superh.com)
diff --git a/arch/sh/include/mach-common/mach/secureedge5410.h b/arch/sh/include/mach-common/mach/secureedge5410.h
index dfc68aa91003..d0be04b6cd38 100644
--- a/arch/sh/include/mach-common/mach/secureedge5410.h
+++ b/arch/sh/include/mach-common/mach/secureedge5410.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/snapgear.h
  *
  * Modified version of io_se.h for the snapgear-specific functions.
diff --git a/arch/sh/include/mach-dreamcast/mach/dma.h b/arch/sh/include/mach-dreamcast/mach/dma.h
index a773a763843a..40537ca3c110 100644
--- a/arch/sh/include/mach-dreamcast/mach/dma.h
+++ b/arch/sh/include/mach-dreamcast/mach/dma.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/dreamcast/dma.h
  *
  * Copyright (C) 2003 Paul Mundt
diff --git a/arch/sh/include/mach-dreamcast/mach/pci.h b/arch/sh/include/mach-dreamcast/mach/pci.h
index c037c1ec63a9..fec7f8aa9c5b 100644
--- a/arch/sh/include/mach-dreamcast/mach/pci.h
+++ b/arch/sh/include/mach-dreamcast/mach/pci.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/dreamcast/pci.h
  *
  * Copyright (C) 2001, 2002  M. R. Brown
diff --git a/arch/sh/include/mach-dreamcast/mach/sysasic.h b/arch/sh/include/mach-dreamcast/mach/sysasic.h
index ed69ce7f2030..03daca6ea92b 100644
--- a/arch/sh/include/mach-dreamcast/mach/sysasic.h
+++ b/arch/sh/include/mach-dreamcast/mach/sysasic.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/dreamcast/sysasic.h
  *
  * Definitions for the Dreamcast System ASIC and related peripherals.
diff --git a/arch/sh/include/mach-se/mach/se7721.h b/arch/sh/include/mach-se/mach/se7721.h
index 82226d40faf5..b1940b6f9649 100644
--- a/arch/sh/include/mach-se/mach/se7721.h
+++ b/arch/sh/include/mach-se/mach/se7721.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2008 Renesas Solutions Corp.
  *
  * Hitachi UL SolutionEngine 7721 Support.
diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index 29c706415443..84006ca0f17a 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 
 #ifndef _ASM_X86_CPU_ENTRY_AREA_H
 #define _ASM_X86_CPU_ENTRY_AREA_H
diff --git a/arch/x86/include/asm/pti.h b/arch/x86/include/asm/pti.h
index 5df09a0b80b8..07375b476c4f 100644
--- a/arch/x86/include/asm/pti.h
+++ b/arch/x86/include/asm/pti.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_X86_PTI_H
 #define _ASM_X86_PTI_H
 #ifndef __ASSEMBLY__
diff --git a/arch/x86/kernel/process.h b/arch/x86/kernel/process.h
index 320ab978fb1f..1d0797b2338a 100644
--- a/arch/x86/kernel/process.h
+++ b/arch/x86/kernel/process.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 //
 // Code shared between 32 and 64 bit
 
diff --git a/drivers/acpi/nfit/intel.h b/drivers/acpi/nfit/intel.h
index 0aca682ab9d7..8f5461c1dd9d 100644
--- a/drivers/acpi/nfit/intel.h
+++ b/drivers/acpi/nfit/intel.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright(c) 2018 Intel Corporation. All rights reserved.
  * Intel specific definitions for NVDIMM Firmware Interface Table - NFIT
diff --git a/drivers/clk/actions/owl-common.h b/drivers/clk/actions/owl-common.h
index 5a866a8b913d..c000a431471e 100644
--- a/drivers/clk/actions/owl-common.h
+++ b/drivers/clk/actions/owl-common.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 //
 // OWL common clock driver
 //
diff --git a/drivers/clk/actions/owl-composite.h b/drivers/clk/actions/owl-composite.h
index b410ed5bf308..bca38bf8f218 100644
--- a/drivers/clk/actions/owl-composite.h
+++ b/drivers/clk/actions/owl-composite.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 //
 // OWL composite clock driver
 //
diff --git a/drivers/clk/actions/owl-divider.h b/drivers/clk/actions/owl-divider.h
index 92d3e3d23967..083be6d80954 100644
--- a/drivers/clk/actions/owl-divider.h
+++ b/drivers/clk/actions/owl-divider.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 //
 // OWL divider clock driver
 //
diff --git a/drivers/clk/actions/owl-factor.h b/drivers/clk/actions/owl-factor.h
index f1a7ffe896e1..04b89cbfdccb 100644
--- a/drivers/clk/actions/owl-factor.h
+++ b/drivers/clk/actions/owl-factor.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 //
 // OWL factor clock driver
 //
diff --git a/drivers/clk/actions/owl-fixed-factor.h b/drivers/clk/actions/owl-fixed-factor.h
index cc9fe36c0964..3dfd7fd7d292 100644
--- a/drivers/clk/actions/owl-fixed-factor.h
+++ b/drivers/clk/actions/owl-fixed-factor.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 //
 // OWL fixed factor clock driver
 //
diff --git a/drivers/clk/actions/owl-gate.h b/drivers/clk/actions/owl-gate.h
index c2d61ceebce2..c2f161c93fda 100644
--- a/drivers/clk/actions/owl-gate.h
+++ b/drivers/clk/actions/owl-gate.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 //
 // OWL gate clock driver
 //
diff --git a/drivers/clk/actions/owl-mux.h b/drivers/clk/actions/owl-mux.h
index 834284c8c3ae..53b9ab665294 100644
--- a/drivers/clk/actions/owl-mux.h
+++ b/drivers/clk/actions/owl-mux.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 //
 // OWL mux clock driver
 //
diff --git a/drivers/clk/actions/owl-pll.h b/drivers/clk/actions/owl-pll.h
index 0aae30abd5dc..b6eebb9d2230 100644
--- a/drivers/clk/actions/owl-pll.h
+++ b/drivers/clk/actions/owl-pll.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 //
 // OWL pll clock driver
 //
diff --git a/drivers/clk/actions/owl-reset.h b/drivers/clk/actions/owl-reset.h
index 10f5774979a6..a947ffcb5a02 100644
--- a/drivers/clk/actions/owl-reset.h
+++ b/drivers/clk/actions/owl-reset.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 //
 // Actions Semi Owl SoCs Reset Management Unit driver
 //
diff --git a/drivers/clk/davinci/pll.h b/drivers/clk/davinci/pll.h
index 7cc354dd29e2..c2a453caa131 100644
--- a/drivers/clk/davinci/pll.h
+++ b/drivers/clk/davinci/pll.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Clock driver for TI Davinci PSC controllers
  *
diff --git a/drivers/clk/davinci/psc.h b/drivers/clk/davinci/psc.h
index cc5614567a70..69070f834391 100644
--- a/drivers/clk/davinci/psc.h
+++ b/drivers/clk/davinci/psc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Clock driver for TI Davinci PSC controllers
  *
diff --git a/drivers/clk/qcom/clk-regmap-mux-div.h b/drivers/clk/qcom/clk-regmap-mux-div.h
index 6cd6261be7ac..4df6c8d24c24 100644
--- a/drivers/clk/qcom/clk-regmap-mux-div.h
+++ b/drivers/clk/qcom/clk-regmap-mux-div.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2017, Linaro Limited
  * Author: Georgi Djakov <georgi.djakov@linaro.org>
diff --git a/drivers/clk/renesas/rcar-gen2-cpg.h b/drivers/clk/renesas/rcar-gen2-cpg.h
index bff9551c7a38..db2f57ef2f99 100644
--- a/drivers/clk/renesas/rcar-gen2-cpg.h
+++ b/drivers/clk/renesas/rcar-gen2-cpg.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * R-Car Gen2 Clock Pulse Generator
  *
  * Copyright (C) 2016 Cogent Embedded Inc.
diff --git a/drivers/clk/renesas/rcar-gen3-cpg.h b/drivers/clk/renesas/rcar-gen3-cpg.h
index f4fb6cf16688..a871635e8ce1 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.h
+++ b/drivers/clk/renesas/rcar-gen3-cpg.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * R-Car Gen3 Clock Pulse Generator
  *
  * Copyright (C) 2015-2018 Glider bvba
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.h b/drivers/clk/renesas/renesas-cpg-mssr.h
index c4ec9df146fd..4ddcdf3bfb95 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.h
+++ b/drivers/clk/renesas/renesas-cpg-mssr.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Renesas Clock Pulse Generator / Module Standby and Software Reset
  *
  * Copyright (C) 2015 Glider bvba
diff --git a/drivers/clk/sprd/common.h b/drivers/clk/sprd/common.h
index abd9ff5ef448..1d077b39cef6 100644
--- a/drivers/clk/sprd/common.h
+++ b/drivers/clk/sprd/common.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 //
 // Spreadtrum clock infrastructure
 //
diff --git a/drivers/clk/sprd/composite.h b/drivers/clk/sprd/composite.h
index 0984e9e252dc..04ab3f587ee2 100644
--- a/drivers/clk/sprd/composite.h
+++ b/drivers/clk/sprd/composite.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 //
 // Spreadtrum composite clock driver
 //
diff --git a/drivers/clk/sprd/div.h b/drivers/clk/sprd/div.h
index b3033d24d431..87510e3d0e14 100644
--- a/drivers/clk/sprd/div.h
+++ b/drivers/clk/sprd/div.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 //
 // Spreadtrum divider clock driver
 //
diff --git a/drivers/clk/sprd/gate.h b/drivers/clk/sprd/gate.h
index 2e582c68a08b..dc352ea55e1f 100644
--- a/drivers/clk/sprd/gate.h
+++ b/drivers/clk/sprd/gate.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 //
 // Spreadtrum gate clock driver
 //
diff --git a/drivers/clk/sprd/mux.h b/drivers/clk/sprd/mux.h
index 548cfa0f145c..892e4191cc7f 100644
--- a/drivers/clk/sprd/mux.h
+++ b/drivers/clk/sprd/mux.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 //
 // Spreadtrum multiplexer clock driver
 //
diff --git a/drivers/clk/sprd/pll.h b/drivers/clk/sprd/pll.h
index 514175621099..e95f11e91ffe 100644
--- a/drivers/clk/sprd/pll.h
+++ b/drivers/clk/sprd/pll.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 //
 // Spreadtrum pll clock driver
 //
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.h b/drivers/clk/sunxi-ng/ccu-sun50i-h6.h
index 2ccfe4428260..9406f9a6a8aa 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.h
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright 2016 Icenowy Zheng <icenowy@aosc.io>
  */
diff --git a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h
index 39d06fed55b2..b22484f1bb9a 100644
--- a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h
+++ b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * Copyright 2017 Icenowy Zheng <icenowy@aosc.io>
  *
  */
diff --git a/drivers/crypto/cavium/nitrox/nitrox_debugfs.h b/drivers/crypto/cavium/nitrox/nitrox_debugfs.h
index f177b79bbab0..09c4cf2513fb 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_debugfs.h
+++ b/drivers/crypto/cavium/nitrox/nitrox_debugfs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __NITROX_DEBUGFS_H
 #define __NITROX_DEBUGFS_H
 
diff --git a/drivers/crypto/cavium/nitrox/nitrox_mbx.h b/drivers/crypto/cavium/nitrox/nitrox_mbx.h
index 5008399775a9..7c93d0282174 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_mbx.h
+++ b/drivers/crypto/cavium/nitrox/nitrox_mbx.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __NITROX_MBX_H
 #define __NITROX_MBX_H
 
diff --git a/drivers/crypto/hisilicon/sec/sec_drv.h b/drivers/crypto/hisilicon/sec/sec_drv.h
index 2d2f186674ba..4d9063a8b10b 100644
--- a/drivers/crypto/hisilicon/sec/sec_drv.h
+++ b/drivers/crypto/hisilicon/sec/sec_drv.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (c) 2016-2017 Hisilicon Limited. */
 
 #ifndef _SEC_DRV_H_
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index 18b6014cf9b4..9c9b7be681c2 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier:  GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // (C) 2017-2018 Synopsys, Inc. (www.synopsys.com)
 
 /*
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 937a930ce87d..44fd4f9404a9 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * System Control and Management Interface (SCMI) Message Protocol
  * driver common header file containing some definitions, structures
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index 12bf316b68df..5f32809c3649 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause */
 /*
  * Texas Instruments System Control Interface (TISCI) Protocol
  *
diff --git a/drivers/fsi/cf-fsi-fw.h b/drivers/fsi/cf-fsi-fw.h
index 712df0461911..1118eaf7ee39 100644
--- a/drivers/fsi/cf-fsi-fw.h
+++ b/drivers/fsi/cf-fsi-fw.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 #ifndef __CF_FSI_FW_H
 #define __CF_FSI_FW_H
 
diff --git a/drivers/gpu/drm/i915/i915_active.h b/drivers/gpu/drm/i915/i915_active.h
index 12b5c1d287d1..55d33d558edd 100644
--- a/drivers/gpu/drm/i915/i915_active.h
+++ b/drivers/gpu/drm/i915/i915_active.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2019 Intel Corporation
  */
diff --git a/drivers/gpu/drm/i915/i915_active_types.h b/drivers/gpu/drm/i915/i915_active_types.h
index b679253b53a5..c285dde8e65e 100644
--- a/drivers/gpu/drm/i915/i915_active_types.h
+++ b/drivers/gpu/drm/i915/i915_active_types.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2019 Intel Corporation
  */
diff --git a/drivers/gpu/drm/i915/i915_gem_batch_pool.h b/drivers/gpu/drm/i915/i915_gem_batch_pool.h
index 56947daaaf65..0530930064d6 100644
--- a/drivers/gpu/drm/i915/i915_gem_batch_pool.h
+++ b/drivers/gpu/drm/i915/i915_gem_batch_pool.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2014-2018 Intel Corporation
  */
diff --git a/drivers/gpu/drm/i915/i915_gpu_error.h b/drivers/gpu/drm/i915/i915_gpu_error.h
index 53b1f22dd365..d9f9410018a5 100644
--- a/drivers/gpu/drm/i915/i915_gpu_error.h
+++ b/drivers/gpu/drm/i915/i915_gpu_error.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright � 2008-2018 Intel Corporation
  */
diff --git a/drivers/gpu/drm/i915/i915_oa_bdw.h b/drivers/gpu/drm/i915/i915_oa_bdw.h
index 0e667f1a8aa1..12874554ee40 100644
--- a/drivers/gpu/drm/i915/i915_oa_bdw.h
+++ b/drivers/gpu/drm/i915/i915_oa_bdw.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2018 Intel Corporation
  *
diff --git a/drivers/gpu/drm/i915/i915_oa_bxt.h b/drivers/gpu/drm/i915/i915_oa_bxt.h
index 679e92cf4f1d..2b08250e4242 100644
--- a/drivers/gpu/drm/i915/i915_oa_bxt.h
+++ b/drivers/gpu/drm/i915/i915_oa_bxt.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2018 Intel Corporation
  *
diff --git a/drivers/gpu/drm/i915/i915_oa_cflgt2.h b/drivers/gpu/drm/i915/i915_oa_cflgt2.h
index 4d6025559bbe..66ab460fe5c0 100644
--- a/drivers/gpu/drm/i915/i915_oa_cflgt2.h
+++ b/drivers/gpu/drm/i915/i915_oa_cflgt2.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2018 Intel Corporation
  *
diff --git a/drivers/gpu/drm/i915/i915_oa_cflgt3.h b/drivers/gpu/drm/i915/i915_oa_cflgt3.h
index 0697f4077402..13eb0a77e35b 100644
--- a/drivers/gpu/drm/i915/i915_oa_cflgt3.h
+++ b/drivers/gpu/drm/i915/i915_oa_cflgt3.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2018 Intel Corporation
  *
diff --git a/drivers/gpu/drm/i915/i915_oa_chv.h b/drivers/gpu/drm/i915/i915_oa_chv.h
index 0986eae3135f..d67625667cfc 100644
--- a/drivers/gpu/drm/i915/i915_oa_chv.h
+++ b/drivers/gpu/drm/i915/i915_oa_chv.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2018 Intel Corporation
  *
diff --git a/drivers/gpu/drm/i915/i915_oa_cnl.h b/drivers/gpu/drm/i915/i915_oa_cnl.h
index e830a406aff2..1a282df0164c 100644
--- a/drivers/gpu/drm/i915/i915_oa_cnl.h
+++ b/drivers/gpu/drm/i915/i915_oa_cnl.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2018 Intel Corporation
  *
diff --git a/drivers/gpu/drm/i915/i915_oa_glk.h b/drivers/gpu/drm/i915/i915_oa_glk.h
index 06dedf991edb..d41fda49f126 100644
--- a/drivers/gpu/drm/i915/i915_oa_glk.h
+++ b/drivers/gpu/drm/i915/i915_oa_glk.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2018 Intel Corporation
  *
diff --git a/drivers/gpu/drm/i915/i915_oa_hsw.h b/drivers/gpu/drm/i915/i915_oa_hsw.h
index 3d0c870cd0bd..027d0bbaf402 100644
--- a/drivers/gpu/drm/i915/i915_oa_hsw.h
+++ b/drivers/gpu/drm/i915/i915_oa_hsw.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2018 Intel Corporation
  *
diff --git a/drivers/gpu/drm/i915/i915_oa_icl.h b/drivers/gpu/drm/i915/i915_oa_icl.h
index 24eaa97d61ba..604ae92cbb08 100644
--- a/drivers/gpu/drm/i915/i915_oa_icl.h
+++ b/drivers/gpu/drm/i915/i915_oa_icl.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2018 Intel Corporation
  *
diff --git a/drivers/gpu/drm/i915/i915_oa_kblgt2.h b/drivers/gpu/drm/i915/i915_oa_kblgt2.h
index a55398a904de..7c2c97f4419a 100644
--- a/drivers/gpu/drm/i915/i915_oa_kblgt2.h
+++ b/drivers/gpu/drm/i915/i915_oa_kblgt2.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2018 Intel Corporation
  *
diff --git a/drivers/gpu/drm/i915/i915_oa_kblgt3.h b/drivers/gpu/drm/i915/i915_oa_kblgt3.h
index 3ddd3483b7cc..59df3ae95d8a 100644
--- a/drivers/gpu/drm/i915/i915_oa_kblgt3.h
+++ b/drivers/gpu/drm/i915/i915_oa_kblgt3.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2018 Intel Corporation
  *
diff --git a/drivers/gpu/drm/i915/i915_oa_sklgt2.h b/drivers/gpu/drm/i915/i915_oa_sklgt2.h
index be6256037239..4e923a7dae98 100644
--- a/drivers/gpu/drm/i915/i915_oa_sklgt2.h
+++ b/drivers/gpu/drm/i915/i915_oa_sklgt2.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2018 Intel Corporation
  *
diff --git a/drivers/gpu/drm/i915/i915_oa_sklgt3.h b/drivers/gpu/drm/i915/i915_oa_sklgt3.h
index 650beb068e56..d1a14830203d 100644
--- a/drivers/gpu/drm/i915/i915_oa_sklgt3.h
+++ b/drivers/gpu/drm/i915/i915_oa_sklgt3.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2018 Intel Corporation
  *
diff --git a/drivers/gpu/drm/i915/i915_oa_sklgt4.h b/drivers/gpu/drm/i915/i915_oa_sklgt4.h
index 8dcf849d131e..8472d8e8dae7 100644
--- a/drivers/gpu/drm/i915/i915_oa_sklgt4.h
+++ b/drivers/gpu/drm/i915/i915_oa_sklgt4.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2018 Intel Corporation
  *
diff --git a/drivers/gpu/drm/i915/i915_pmu.h b/drivers/gpu/drm/i915/i915_pmu.h
index 4fc4f2478301..a5629792be56 100644
--- a/drivers/gpu/drm/i915/i915_pmu.h
+++ b/drivers/gpu/drm/i915/i915_pmu.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2017-2018 Intel Corporation
  */
diff --git a/drivers/gpu/drm/i915/i915_query.h b/drivers/gpu/drm/i915/i915_query.h
index 31dcef181f63..2e465c68b367 100644
--- a/drivers/gpu/drm/i915/i915_query.h
+++ b/drivers/gpu/drm/i915/i915_query.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2018 Intel Corporation
  */
diff --git a/drivers/gpu/drm/i915/i915_reset.h b/drivers/gpu/drm/i915/i915_reset.h
index f2d347f319df..e8668a4aacb2 100644
--- a/drivers/gpu/drm/i915/i915_reset.h
+++ b/drivers/gpu/drm/i915/i915_reset.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2008-2018 Intel Corporation
  */
diff --git a/drivers/gpu/drm/i915/i915_scheduler.h b/drivers/gpu/drm/i915/i915_scheduler.h
index dbe9cb7ecd82..842d3edcdb23 100644
--- a/drivers/gpu/drm/i915/i915_scheduler.h
+++ b/drivers/gpu/drm/i915/i915_scheduler.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2018 Intel Corporation
  */
diff --git a/drivers/gpu/drm/i915/i915_sw_fence.h b/drivers/gpu/drm/i915/i915_sw_fence.h
index 0e055ea0179f..219bb392e9d5 100644
--- a/drivers/gpu/drm/i915/i915_sw_fence.h
+++ b/drivers/gpu/drm/i915/i915_sw_fence.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * i915_sw_fence.h - library routines for N:M synchronisation points
  *
diff --git a/drivers/gpu/drm/i915/intel_gpu_commands.h b/drivers/gpu/drm/i915/intel_gpu_commands.h
index b96a31bc1080..deca0425e9f0 100644
--- a/drivers/gpu/drm/i915/intel_gpu_commands.h
+++ b/drivers/gpu/drm/i915/intel_gpu_commands.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright � 2003-2018 Intel Corporation
  */
diff --git a/drivers/gpu/drm/i915/intel_huc_fw.h b/drivers/gpu/drm/i915/intel_huc_fw.h
index 8a00a0ebddc5..d1c59b329c4c 100644
--- a/drivers/gpu/drm/i915/intel_huc_fw.h
+++ b/drivers/gpu/drm/i915/intel_huc_fw.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2014-2018 Intel Corporation
  */
diff --git a/drivers/gpu/drm/i915/intel_lrc_reg.h b/drivers/gpu/drm/i915/intel_lrc_reg.h
index 5ef932d810a7..40aa75fca475 100644
--- a/drivers/gpu/drm/i915/intel_lrc_reg.h
+++ b/drivers/gpu/drm/i915/intel_lrc_reg.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2014-2018 Intel Corporation
  */
diff --git a/drivers/gpu/drm/i915/intel_wopcm.h b/drivers/gpu/drm/i915/intel_wopcm.h
index 6298910a384c..16009cab1237 100644
--- a/drivers/gpu/drm/i915/intel_wopcm.h
+++ b/drivers/gpu/drm/i915/intel_wopcm.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2017-2018 Intel Corporation
  */
diff --git a/drivers/gpu/drm/i915/intel_workarounds.h b/drivers/gpu/drm/i915/intel_workarounds.h
index 7c734714b05e..0f9cad92bc6e 100644
--- a/drivers/gpu/drm/i915/intel_workarounds.h
+++ b/drivers/gpu/drm/i915/intel_workarounds.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2014-2018 Intel Corporation
  */
diff --git a/drivers/gpu/drm/i915/selftests/igt_flush_test.h b/drivers/gpu/drm/i915/selftests/igt_flush_test.h
index 63e009927c43..e34c30f5f3c6 100644
--- a/drivers/gpu/drm/i915/selftests/igt_flush_test.h
+++ b/drivers/gpu/drm/i915/selftests/igt_flush_test.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2018 Intel Corporation
  */
diff --git a/drivers/gpu/drm/i915/selftests/igt_live_test.h b/drivers/gpu/drm/i915/selftests/igt_live_test.h
index c0e9f99d50de..c26489cad92b 100644
--- a/drivers/gpu/drm/i915/selftests/igt_live_test.h
+++ b/drivers/gpu/drm/i915/selftests/igt_live_test.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2019 Intel Corporation
  */
diff --git a/drivers/gpu/drm/i915/selftests/igt_reset.h b/drivers/gpu/drm/i915/selftests/igt_reset.h
index 5f0234d045d5..795ec2c9b0c8 100644
--- a/drivers/gpu/drm/i915/selftests/igt_reset.h
+++ b/drivers/gpu/drm/i915/selftests/igt_reset.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2018 Intel Corporation
  */
diff --git a/drivers/gpu/drm/i915/selftests/igt_spinner.h b/drivers/gpu/drm/i915/selftests/igt_spinner.h
index 391777c76dc7..75929696b886 100644
--- a/drivers/gpu/drm/i915/selftests/igt_spinner.h
+++ b/drivers/gpu/drm/i915/selftests/igt_spinner.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2018 Intel Corporation
  */
diff --git a/drivers/gpu/drm/i915/selftests/igt_wedge_me.h b/drivers/gpu/drm/i915/selftests/igt_wedge_me.h
index 08e5ff11bbd9..59319b22df17 100644
--- a/drivers/gpu/drm/i915/selftests/igt_wedge_me.h
+++ b/drivers/gpu/drm/i915/selftests/igt_wedge_me.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2018 Intel Corporation
  */
diff --git a/drivers/gpu/drm/i915/selftests/mock_timeline.h b/drivers/gpu/drm/i915/selftests/mock_timeline.h
index b6deaa61110d..eb262c43cd32 100644
--- a/drivers/gpu/drm/i915/selftests/mock_timeline.h
+++ b/drivers/gpu/drm/i915/selftests/mock_timeline.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * SPDX-License-Identifier: MIT
  *
  * Copyright © 2017-2018 Intel Corporation
  */
diff --git a/drivers/gpu/drm/msm/adreno/a2xx_gpu.h b/drivers/gpu/drm/msm/adreno/a2xx_gpu.h
index 02fba2cb8932..861e63f31984 100644
--- a/drivers/gpu/drm/msm/adreno/a2xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a2xx_gpu.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (c) 2018 The Linux Foundation. All rights reserved. */
 
 #ifndef __A2XX_GPU_H__
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
index 68cccfa2870a..de8bfdadd2a3 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (c) 2018 The Linux Foundation. All rights reserved. */
 
 #ifndef _A6XX_CRASH_DUMP_H_
diff --git a/drivers/gpu/drm/pl111/pl111_nomadik.h b/drivers/gpu/drm/pl111/pl111_nomadik.h
index 19d663d46353..e94ba95d3c39 100644
--- a/drivers/gpu/drm/pl111/pl111_nomadik.h
+++ b/drivers/gpu/drm/pl111/pl111_nomadik.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 #include <linux/device.h>
 
 #ifndef PL111_NOMADIK_H
diff --git a/drivers/gpu/drm/pl111/pl111_vexpress.h b/drivers/gpu/drm/pl111/pl111_vexpress.h
index 5d3681bb4c00..75e713350aba 100644
--- a/drivers/gpu/drm/pl111/pl111_vexpress.h
+++ b/drivers/gpu/drm/pl111/pl111_vexpress.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 
 struct device;
 struct pl111_drm_dev_private;
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index 0c382c1ddb0f..7f0ef7b586d8 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2017 Free Electrons
  * Maxime Ripard <maxime.ripard@free-electrons.com>
diff --git a/drivers/gpu/drm/sun4i/sun4i_lvds.h b/drivers/gpu/drm/sun4i/sun4i_lvds.h
index f3e90faa3082..afa84a6e5c88 100644
--- a/drivers/gpu/drm/sun4i/sun4i_lvds.h
+++ b/drivers/gpu/drm/sun4i/sun4i_lvds.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2017 Free Electrons
  * Maxime Ripard <maxime.ripard@free-electrons.com>
diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
index a07090579f84..065d1a1c8bba 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 2016 Allwinnertech Co., Ltd.
  * Copyright (C) 2017-2018 Bootlin
diff --git a/drivers/gpu/drm/tegra/hda.h b/drivers/gpu/drm/tegra/hda.h
index 77269955a4f2..557aeb445c8a 100644
--- a/drivers/gpu/drm/tegra/hda.h
+++ b/drivers/gpu/drm/tegra/hda.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: MIT
+/* SPDX-License-Identifier: MIT */
 /*
  * Copyright (C) 2019 NVIDIA Corporation
  */
diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index fdda3037f7af..9a0bbf5b29e5 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /* Copyright (C) 2015-2018 Broadcom */
 
 #include <linux/reservation.h>
diff --git a/drivers/gpu/drm/v3d/v3d_regs.h b/drivers/gpu/drm/v3d/v3d_regs.h
index 6ccdee9d47bd..a4f4d5c04d46 100644
--- a/drivers/gpu/drm/v3d/v3d_regs.h
+++ b/drivers/gpu/drm/v3d/v3d_regs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /* Copyright (C) 2017-2018 Broadcom */
 
 #ifndef V3D_REGS_H
diff --git a/drivers/gpu/drm/v3d/v3d_trace.h b/drivers/gpu/drm/v3d/v3d_trace.h
index edd984afa33f..0a081c319812 100644
--- a/drivers/gpu/drm/v3d/v3d_trace.h
+++ b/drivers/gpu/drm/v3d/v3d_trace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /* Copyright (C) 2015-2018 Broadcom */
 
 #if !defined(_V3D_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
diff --git a/drivers/gpu/host1x/hw/hw_host1x06_channel.h b/drivers/gpu/host1x/hw/hw_host1x06_channel.h
index 18ae1c57bbea..37fc6424043a 100644
--- a/drivers/gpu/host1x/hw/hw_host1x06_channel.h
+++ b/drivers/gpu/host1x/hw/hw_host1x06_channel.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2019 NVIDIA Corporation.
  */
diff --git a/drivers/gpu/host1x/hw/hw_host1x07_channel.h b/drivers/gpu/host1x/hw/hw_host1x07_channel.h
index 96fa72bbd7ab..84ff87b3fccb 100644
--- a/drivers/gpu/host1x/hw/hw_host1x07_channel.h
+++ b/drivers/gpu/host1x/hw/hw_host1x07_channel.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2019 NVIDIA Corporation.
  */
diff --git a/drivers/hv/hv_trace.h b/drivers/hv/hv_trace.h
index 999f80a63bff..e70783e33680 100644
--- a/drivers/hv/hv_trace.h
+++ b/drivers/hv/hv_trace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM hyperv
diff --git a/drivers/hwtracing/intel_th/msu.h b/drivers/hwtracing/intel_th/msu.h
index 9cc8aced6116..979548791b7d 100644
--- a/drivers/hwtracing/intel_th/msu.h
+++ b/drivers/hwtracing/intel_th/msu.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Intel(R) Trace Hub Memory Storage Unit (MSU) data structures
  *
diff --git a/drivers/hwtracing/intel_th/pti.h b/drivers/hwtracing/intel_th/pti.h
index e9381babc84c..7dfc0431333b 100644
--- a/drivers/hwtracing/intel_th/pti.h
+++ b/drivers/hwtracing/intel_th/pti.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Intel(R) Trace Hub PTI output data structures
  *
diff --git a/drivers/i2c/busses/i2c-stm32.h b/drivers/i2c/busses/i2c-stm32.h
index 868755f82f88..2c21893905a3 100644
--- a/drivers/i2c/busses/i2c-stm32.h
+++ b/drivers/i2c/busses/i2c-stm32.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * i2c-stm32.h
  *
diff --git a/drivers/media/common/siano/smsir.h b/drivers/media/common/siano/smsir.h
index b2c54c256e86..ada41d5c4e83 100644
--- a/drivers/media/common/siano/smsir.h
+++ b/drivers/media/common/siano/smsir.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * SPDX-License-Identifier: GPL-2.0+
  *
  * Siano Mobile Silicon, Inc.
  * MDTV receiver kernel modules.
diff --git a/drivers/media/i2c/max2175.h b/drivers/media/i2c/max2175.h
index 1ece587c153d..4c722ea3e5f1 100644
--- a/drivers/media/i2c/max2175.h
+++ b/drivers/media/i2c/max2175.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Maxim Integrated MAX2175 RF to Bits tuner driver
  *
  * This driver & most of the hard coded values are based on the reference
diff --git a/drivers/media/i2c/saa711x_regs.h b/drivers/media/i2c/saa711x_regs.h
index 44fabe08234d..4b5f6985710b 100644
--- a/drivers/media/i2c/saa711x_regs.h
+++ b/drivers/media/i2c/saa711x_regs.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * SPDX-License-Identifier: GPL-2.0+
  * saa711x - Philips SAA711x video decoder register specifications
  *
  * Copyright (c) 2006 Mauro Carvalho Chehab <mchehab@kernel.org>
diff --git a/drivers/media/i2c/tda1997x_regs.h b/drivers/media/i2c/tda1997x_regs.h
index f55dfc423a86..edd2ca39c85c 100644
--- a/drivers/media/i2c/tda1997x_regs.h
+++ b/drivers/media/i2c/tda1997x_regs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2018 Gateworks Corporation
  */
diff --git a/drivers/media/i2c/tvp5150_reg.h b/drivers/media/i2c/tvp5150_reg.h
index 9088186c24d1..f716129adf09 100644
--- a/drivers/media/i2c/tvp5150_reg.h
+++ b/drivers/media/i2c/tvp5150_reg.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * SPDX-License-Identifier: GPL-2.0
  *
  * tvp5150 - Texas Instruments TVP5150A/AM1 video decoder registers
  *
diff --git a/drivers/media/platform/xilinx/xilinx-dma.h b/drivers/media/platform/xilinx/xilinx-dma.h
index 5aec4d17eb21..2378bdae57ae 100644
--- a/drivers/media/platform/xilinx/xilinx-dma.h
+++ b/drivers/media/platform/xilinx/xilinx-dma.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Xilinx Video DMA
  *
diff --git a/drivers/media/platform/xilinx/xilinx-vip.h b/drivers/media/platform/xilinx/xilinx-vip.h
index ba939dd52818..ad22b8a6ccf8 100644
--- a/drivers/media/platform/xilinx/xilinx-vip.h
+++ b/drivers/media/platform/xilinx/xilinx-vip.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Xilinx Video IP Core
  *
diff --git a/drivers/media/platform/xilinx/xilinx-vipp.h b/drivers/media/platform/xilinx/xilinx-vipp.h
index e65fce9538f9..cc52c1854dbd 100644
--- a/drivers/media/platform/xilinx/xilinx-vipp.h
+++ b/drivers/media/platform/xilinx/xilinx-vipp.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Xilinx Video IP Composite Device
  *
diff --git a/drivers/media/platform/xilinx/xilinx-vtc.h b/drivers/media/platform/xilinx/xilinx-vtc.h
index 90cf44245283..855845911ffc 100644
--- a/drivers/media/platform/xilinx/xilinx-vtc.h
+++ b/drivers/media/platform/xilinx/xilinx-vtc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Xilinx Video Timing Controller
  *
diff --git a/drivers/media/rc/rc-core-priv.h b/drivers/media/rc/rc-core-priv.h
index c2cbe7f6266c..afc9f0f3c632 100644
--- a/drivers/media/rc/rc-core-priv.h
+++ b/drivers/media/rc/rc-core-priv.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * SPDX-License-Identifier: GPL-2.0
  * Remote Controller core raw events header
  *
  * Copyright (C) 2010 by Mauro Carvalho Chehab
diff --git a/drivers/media/tuners/tuner-xc2028-types.h b/drivers/media/tuners/tuner-xc2028-types.h
index 50d017a4822a..fcca39d3e006 100644
--- a/drivers/media/tuners/tuner-xc2028-types.h
+++ b/drivers/media/tuners/tuner-xc2028-types.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * SPDX-License-Identifier: GPL-2.0
  * tuner-xc2028_types
  *
  * This file includes internal tipes to be used inside tuner-xc2028.
diff --git a/drivers/media/tuners/tuner-xc2028.h b/drivers/media/tuners/tuner-xc2028.h
index 7b58bc06e35c..2dd45d0765d7 100644
--- a/drivers/media/tuners/tuner-xc2028.h
+++ b/drivers/media/tuners/tuner-xc2028.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * SPDX-License-Identifier: GPL-2.0
  * tuner-xc2028
  *
  * Copyright (c) 2007-2008 Mauro Carvalho Chehab <mchehab@kernel.org>
diff --git a/drivers/media/usb/tm6000/tm6000-regs.h b/drivers/media/usb/tm6000/tm6000-regs.h
index d10424673db9..6a181f2e7ef2 100644
--- a/drivers/media/usb/tm6000/tm6000-regs.h
+++ b/drivers/media/usb/tm6000/tm6000-regs.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * SPDX-License-Identifier: GPL-2.0
  * tm6000-regs.h - driver for TM5600/TM6000/TM6010 USB video capture devices
  *
  * Copyright (c) 2006-2007 Mauro Carvalho Chehab <mchehab@kernel.org>
diff --git a/drivers/media/usb/tm6000/tm6000-usb-isoc.h b/drivers/media/usb/tm6000/tm6000-usb-isoc.h
index b275dbce3a1b..e3c6933f854d 100644
--- a/drivers/media/usb/tm6000/tm6000-usb-isoc.h
+++ b/drivers/media/usb/tm6000/tm6000-usb-isoc.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * SPDX-License-Identifier: GPL-2.0
  * tm6000-buf.c - driver for TM5600/TM6000/TM6010 USB video capture devices
  *
  * Copyright (c) 2006-2007 Mauro Carvalho Chehab <mchehab@kernel.org>
diff --git a/drivers/media/usb/tm6000/tm6000.h b/drivers/media/usb/tm6000/tm6000.h
index 0864ed7314eb..81e391db4dec 100644
--- a/drivers/media/usb/tm6000/tm6000.h
+++ b/drivers/media/usb/tm6000/tm6000.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * SPDX-License-Identifier: GPL-2.0
  * tm6000.h - driver for TM5600/TM6000/TM6010 USB video capture devices
  *
  * Copyright (c) 2006-2007 Mauro Carvalho Chehab <mchehab@kernel.org>
diff --git a/drivers/misc/hpilo.h b/drivers/misc/hpilo.h
index 94dfb9e40e29..1aa433a7f66c 100644
--- a/drivers/misc/hpilo.h
+++ b/drivers/misc/hpilo.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * linux/drivers/char/hpilo.h
  *
diff --git a/drivers/misc/ibmvmc.h b/drivers/misc/ibmvmc.h
index e140ada8fe2c..0e1756fffeae 100644
--- a/drivers/misc/ibmvmc.h
+++ b/drivers/misc/ibmvmc.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * linux/drivers/misc/ibmvmc.h
  *
  * IBM Power Systems Virtual Management Channel Support.
diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
index a32f2151029f..9118cc5e30d8 100644
--- a/drivers/misc/ocxl/ocxl_internal.h
+++ b/drivers/misc/ocxl/ocxl_internal.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 // Copyright 2017 IBM Corp.
 #ifndef _OCXL_INTERNAL_H_
 #define _OCXL_INTERNAL_H_
diff --git a/drivers/misc/ocxl/trace.h b/drivers/misc/ocxl/trace.h
index bcb7ff330c1e..7cb2e277b87e 100644
--- a/drivers/misc/ocxl/trace.h
+++ b/drivers/misc/ocxl/trace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 // Copyright 2017 IBM Corp.
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM ocxl
diff --git a/drivers/net/dsa/b53/b53_serdes.h b/drivers/net/dsa/b53/b53_serdes.h
index 3bb4f91aec9e..55d280fe38e4 100644
--- a/drivers/net/dsa/b53/b53_serdes.h
+++ b/drivers/net/dsa/b53/b53_serdes.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
- *
+/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/*
  * Northstar Plus switch SerDes/SGMII PHY definitions
  *
  * Copyright (C) 2018 Florian Fainelli <f.fainelli@gmail.com>
diff --git a/drivers/net/dsa/lantiq_pce.h b/drivers/net/dsa/lantiq_pce.h
index 180663138e75..e2be31f3672a 100644
--- a/drivers/net/dsa/lantiq_pce.h
+++ b/drivers/net/dsa/lantiq_pce.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * PCE microcode extracted from UGW 7.1.1 switch api
  *
diff --git a/drivers/net/dsa/microchip/ksz9477_reg.h b/drivers/net/dsa/microchip/ksz9477_reg.h
index 2938e892b631..16939f29faa5 100644
--- a/drivers/net/dsa/microchip/ksz9477_reg.h
+++ b/drivers/net/dsa/microchip/ksz9477_reg.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Microchip KSZ9477 register definitions
  *
  * Copyright (C) 2017-2018 Microchip Technology Inc.
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 2dd832de0d52..3d9071e7c4b1 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- * Microchip switch driver common header
+/* SPDX-License-Identifier: GPL-2.0 */
+/*  Microchip switch driver common header
  *
  * Copyright (C) 2017-2018 Microchip Technology Inc.
  */
diff --git a/drivers/net/dsa/microchip/ksz_priv.h b/drivers/net/dsa/microchip/ksz_priv.h
index 60b49010904b..0f52281bbdba 100644
--- a/drivers/net/dsa/microchip/ksz_priv.h
+++ b/drivers/net/dsa/microchip/ksz_priv.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Microchip KSZ series switch common definitions
  *
  * Copyright (C) 2017-2018 Microchip Technology Inc.
diff --git a/drivers/net/dsa/microchip/ksz_spi.h b/drivers/net/dsa/microchip/ksz_spi.h
index 427811bd60b3..a3363cc35489 100644
--- a/drivers/net/dsa/microchip/ksz_spi.h
+++ b/drivers/net/dsa/microchip/ksz_spi.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- * Microchip KSZ series SPI access common header
+/* SPDX-License-Identifier: GPL-2.0 */
+/*  Microchip KSZ series SPI access common header
  *
  * Copyright (C) 2017-2018 Microchip Technology Inc.
  *	Tristram Ha <Tristram.Ha@microchip.com>
diff --git a/drivers/net/ethernet/cavium/common/cavium_ptp.h b/drivers/net/ethernet/cavium/common/cavium_ptp.h
index be2bafc7beeb..a04eccbc78e8 100644
--- a/drivers/net/ethernet/cavium/common/cavium_ptp.h
+++ b/drivers/net/ethernet/cavium/common/cavium_ptp.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /* cavium_ptp.h - PTP 1588 clock on Cavium hardware
  * Copyright (c) 2003-2015, 2017 Cavium, Inc.
  */
diff --git a/drivers/net/ethernet/cortina/gemini.h b/drivers/net/ethernet/cortina/gemini.h
index 0b12f89bf89a..9fdf77d5eb37 100644
--- a/drivers/net/ethernet/cortina/gemini.h
+++ b/drivers/net/ethernet/cortina/gemini.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Register definitions for Gemini GMAC Ethernet device driver
  *
  * Copyright (C) 2006 Storlink, Corp.
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.h
index ff2e177395d4..df2458a5e9ef 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright 2018 NXP
  */
diff --git a/drivers/net/ethernet/freescale/dpaa2/dprtc-cmd.h b/drivers/net/ethernet/freescale/dpaa2/dprtc-cmd.h
index 9af4ac71f347..40d21156a118 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dprtc-cmd.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dprtc-cmd.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2016-2018 NXP
diff --git a/drivers/net/ethernet/freescale/dpaa2/dprtc.h b/drivers/net/ethernet/freescale/dpaa2/dprtc.h
index fe19618d6cdf..74efc316d779 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dprtc.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dprtc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2016-2018 NXP
diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 10f1cc2ba157..9486c6cd776b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 // Copyright (c) 2016-2017 Hisilicon Limited.
 
 #ifndef __HNAE3_H
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 71ff8f4d6c18..e750e33e425d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 // Copyright (c) 2016-2017 Hisilicon Limited.
 
 #ifndef __HNS3_ENET_H
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index ac2cd219a9fb..4304f21737e0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 // Copyright (c) 2016-2017 Hisilicon Limited.
 
 #ifndef __HCLGE_CMD_H
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.h
index 278f21e02736..b04702e65689 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 // Copyright (c) 2016-2017 Hisilicon Limited.
 
 #ifndef __HCLGE_DCB_H__
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index c939f4a7f5f0..94bf95d819b8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 // Copyright (c) 2016-2017 Hisilicon Limited.
 
 #ifndef __HCLGE_MAIN_H
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h
index ef095d9c566f..dd9a1218a7b0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 // Copyright (c) 2016-2017 Hisilicon Limited.
 
 #ifndef __HCLGE_MDIO_H
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
index f60e540c7a62..85ef7bf772d0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 // Copyright (c) 2016-2017 Hisilicon Limited.
 
 #ifndef __HCLGE_TM_H
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
index 206dc5dc1df8..5c1f389e3320 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- * Marvell OcteonTx2 CGX driver
+/* SPDX-License-Identifier: GPL-2.0 */
+/*  Marvell OcteonTx2 CGX driver
  *
  * Copyright (C) 2018 Marvell International Ltd.
  *
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx_fw_if.h b/drivers/net/ethernet/marvell/octeontx2/af/cgx_fw_if.h
index fb3ba4968a9b..473d9751601f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx_fw_if.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx_fw_if.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- * Marvell OcteonTx2 CGX driver
+/* SPDX-License-Identifier: GPL-2.0 */
+/*  Marvell OcteonTx2 CGX driver
  *
  * Copyright (C) 2018 Marvell International Ltd.
  *
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers/net/ethernet/marvell/octeontx2/af/common.h
index e332e82fc066..413c3f254cf8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/common.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- * Marvell OcteonTx2 RVU Admin Function driver
+/* SPDX-License-Identifier: GPL-2.0 */
+/*  Marvell OcteonTx2 RVU Admin Function driver
  *
  * Copyright (C) 2018 Marvell International Ltd.
  *
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 76a4575d18ff..75439fce0505 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- * Marvell OcteonTx2 RVU Admin Function driver
+/* SPDX-License-Identifier: GPL-2.0 */
+/*  Marvell OcteonTx2 RVU Admin Function driver
  *
  * Copyright (C) 2018 Marvell International Ltd.
  *
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
index 8d6d90fdfb73..5d4df315a0e1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- * Marvell OcteonTx2 RVU Admin Function driver
+/* SPDX-License-Identifier: GPL-2.0 */
+/*  Marvell OcteonTx2 RVU Admin Function driver
  *
  * Copyright (C) 2018 Marvell International Ltd.
  *
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc_profile.h b/drivers/net/ethernet/marvell/octeontx2/af/npc_profile.h
index b2ce957605bb..da649f6a5573 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc_profile.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc_profile.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- * Marvell OcteonTx2 RVU Admin Function driver
+/* SPDX-License-Identifier: GPL-2.0 */
+/*  Marvell OcteonTx2 RVU Admin Function driver
  *
  * Copyright (C) 2018 Marvell International Ltd.
  *
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index c9d60b0554c0..5222e4228905 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- * Marvell OcteonTx2 RVU Admin Function driver
+/* SPDX-License-Identifier: GPL-2.0 */
+/*  Marvell OcteonTx2 RVU Admin Function driver
  *
  * Copyright (C) 2018 Marvell International Ltd.
  *
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
index 09a8d61f3144..1ea92a2e7cfe 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- * Marvell OcteonTx2 RVU Admin Function driver
+/* SPDX-License-Identifier: GPL-2.0 */
+/*  Marvell OcteonTx2 RVU Admin Function driver
  *
  * Copyright (C) 2018 Marvell International Ltd.
  *
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
index f920dac74e6c..84a39063a8bb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- * Marvell OcteonTx2 RVU Admin Function driver
+/* SPDX-License-Identifier: GPL-2.0 */
+/*  Marvell OcteonTx2 RVU Admin Function driver
  *
  * Copyright (C) 2018 Marvell International Ltd.
  *
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
index 775db776b3cc..23fecf68f781 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
 // Copyright (c) 2017 Synopsys, Inc. and/or its affiliates.
 // stmmac Support for 5.xx Ethernet QoS cores
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index d6bb953685fa..f25b93760979 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
 /*
  * Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
  * stmmac XGMAC definitions.
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 92b8944f26e3..bc20da885fed 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
 // Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
 // stmmac HW Interface Callbacks
 
diff --git a/drivers/net/phy/bcm-phy-lib.h b/drivers/net/phy/bcm-phy-lib.h
index 17faaefcfd60..87357676bfc7 100644
--- a/drivers/net/phy/bcm-phy-lib.h
+++ b/drivers/net/phy/bcm-phy-lib.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2015 Broadcom Corporation
  */
diff --git a/drivers/net/phy/mdio-cavium.h b/drivers/net/phy/mdio-cavium.h
index ed5f9bb5448d..2339a1e474a3 100644
--- a/drivers/net/phy/mdio-cavium.h
+++ b/drivers/net/phy/mdio-cavium.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2009-2016 Cavium, Inc.
  */
diff --git a/drivers/net/phy/mdio-i2c.h b/drivers/net/phy/mdio-i2c.h
index 751dab281f57..b1d27f7cd23f 100644
--- a/drivers/net/phy/mdio-i2c.h
+++ b/drivers/net/phy/mdio-i2c.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * MDIO I2C bridge
  *
diff --git a/drivers/net/phy/mdio-xgene.h b/drivers/net/phy/mdio-xgene.h
index b1f5ccb4ad9c..8af93ada8b64 100644
--- a/drivers/net/phy/mdio-xgene.h
+++ b/drivers/net/phy/mdio-xgene.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /* Applied Micro X-Gene SoC MDIO Driver
  *
  * Copyright (c) 2016, Applied Micro Circuits Corporation
diff --git a/drivers/net/usb/aqc111.h b/drivers/net/usb/aqc111.h
index 4d68b3a6067c..4b1fa82994b1 100644
--- a/drivers/net/usb/aqc111.h
+++ b/drivers/net/usb/aqc111.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later
- * Aquantia Corp. Aquantia AQtion USB to 5GbE Controller
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*  Aquantia Corp. Aquantia AQtion USB to 5GbE Controller
  * Copyright (C) 2003-2005 David Hollis <dhollis@davehollis.com>
  * Copyright (C) 2005 Phil Chang <pchang23@sbcglobal.net>
  * Copyright (C) 2002-2003 TiVo Inc.
diff --git a/drivers/pci/controller/pcie-cadence.h b/drivers/pci/controller/pcie-cadence.h
index ae6bf2a2b3d3..f1cba3931b99 100644
--- a/drivers/pci/controller/pcie-cadence.h
+++ b/drivers/pci/controller/pcie-cadence.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (c) 2017 Cadence
 // Cadence PCIe controller driver.
 // Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 8e87a059ce73..53e4f9e59624 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Rockchip AXI PCIe controller driver
  *
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index a1b6cdee9a08..7e621786bf71 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2017, The Linux Foundation. All rights reserved.
  */
diff --git a/drivers/pinctrl/actions/pinctrl-owl.h b/drivers/pinctrl/actions/pinctrl-owl.h
index dae2e8363fd5..feee7ad7e27e 100644
--- a/drivers/pinctrl/actions/pinctrl-owl.h
+++ b/drivers/pinctrl/actions/pinctrl-owl.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * OWL SoC's Pinctrl definitions
  *
diff --git a/drivers/pinctrl/cirrus/pinctrl-madera.h b/drivers/pinctrl/cirrus/pinctrl-madera.h
index 8000f4f832a1..ade28cac3e72 100644
--- a/drivers/pinctrl/cirrus/pinctrl-madera.h
+++ b/drivers/pinctrl/cirrus/pinctrl-madera.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Pinctrl for Cirrus Logic Madera codecs
  *
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h b/drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h
index ba2356a8ab89..845c408b5fdb 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2018 MediaTek Inc.
  * Author: Zhiyong Tao <zhiyong.tao@mediatek.com>
diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.h b/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.h
index 8ff88bf2e849..aa79d7ecee00 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.h
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
 /*
  * Copyright (c) 2017 Baylibre SAS.
  * Author:  Jerome Brunet  <jbrunet@baylibre.com>
@@ -5,7 +6,6 @@
  * Copyright (c) 2017 Amlogic, Inc. All rights reserved.
  * Author: Xingyu Chen <xingyu.chen@amlogic.com>
  *
- * SPDX-License-Identifier: (GPL-2.0+ or MIT)
  */
 
 struct meson_pmx_bank {
diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
index b5b1d163e98a..5ad0ab8f9e14 100644
--- a/drivers/pinctrl/sh-pfc/core.h
+++ b/drivers/pinctrl/sh-pfc/core.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * SuperH Pin Function Controller support.
  *
  * Copyright (C) 2012  Renesas Solutions Corp.
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 56016cb76769..737065e97db2 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * SuperH Pin Function Controller Support
  *
  * Copyright (c) 2008 Magnus Damm
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.h b/drivers/pinctrl/stm32/pinctrl-stm32.h
index 473a6238a27b..72d98db8c5c5 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.h
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) Maxime Coquelin 2015
  * Copyright (C) STMicroelectronics 2017
diff --git a/drivers/platform/x86/intel_ips.h b/drivers/platform/x86/intel_ips.h
index 512ad234ad0d..35ed9711c7b9 100644
--- a/drivers/platform/x86/intel_ips.h
+++ b/drivers/platform/x86/intel_ips.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2010 Intel Corporation
  */
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index 0680ca397b57..ccaf7a57a69e 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Intel Core SoC Power Management Controller Header File
  *
diff --git a/drivers/s390/cio/vfio_ccw_trace.h b/drivers/s390/cio/vfio_ccw_trace.h
index b1da53ddec1f..295366c8c416 100644
--- a/drivers/s390/cio/vfio_ccw_trace.h
+++ b/drivers/s390/cio/vfio_ccw_trace.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- * Tracepoints for vfio_ccw driver
+/* SPDX-License-Identifier: GPL-2.0 */
+/*  Tracepoints for vfio_ccw driver
  *
  * Copyright IBM Corp. 2018
  *
diff --git a/drivers/scsi/myrb.h b/drivers/scsi/myrb.h
index 9289c19fcb2f..fb8eacfceee8 100644
--- a/drivers/scsi/myrb.h
+++ b/drivers/scsi/myrb.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Linux Driver for Mylex DAC960/AcceleRAID/eXtremeRAID PCI RAID Controllers
  *
  * Copyright 2017 Hannes Reinecke, SUSE Linux GmbH <hare@suse.com>
diff --git a/drivers/scsi/myrs.h b/drivers/scsi/myrs.h
index e6702ee85e9f..9f6696d0ddd5 100644
--- a/drivers/scsi/myrs.h
+++ b/drivers/scsi/myrs.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Linux Driver for Mylex DAC960/AcceleRAID/eXtremeRAID PCI RAID Controllers
  *
  * This driver supports the newer, SCSI-based firmware interface only.
diff --git a/drivers/scsi/ufs/ufs-hisi.h b/drivers/scsi/ufs/ufs-hisi.h
index 3df9cd7acc29..ee77a4d6844a 100644
--- a/drivers/scsi/ufs/ufs-hisi.h
+++ b/drivers/scsi/ufs/ufs-hisi.h
@@ -1,8 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2017, HiSilicon. All rights reserved.
  *
  * Released under the GPLv2 only.
- * SPDX-License-Identifier: GPL-2.0
  */
 
 #ifndef UFS_HISI_H_
diff --git a/drivers/scsi/ufs/ufs-sysfs.h b/drivers/scsi/ufs/ufs-sysfs.h
index e5621e59a432..701e6a54be3c 100644
--- a/drivers/scsi/ufs/ufs-sysfs.h
+++ b/drivers/scsi/ufs/ufs-sysfs.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- * Copyright (C) 2018 Western Digital Corporation
+/* SPDX-License-Identifier: GPL-2.0 */
+/*  Copyright (C) 2018 Western Digital Corporation
  */
 
 #ifndef __UFS_SYSFS_H__
diff --git a/drivers/siox/siox.h b/drivers/siox/siox.h
index c674bf6fb119..f08b43b713c5 100644
--- a/drivers/siox/siox.h
+++ b/drivers/siox/siox.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2015-2017 Pengutronix, Uwe Kleine-König <kernel@pengutronix.de>
  */
diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
index 9be41089edde..cbcc38ef35c8 100644
--- a/drivers/slimbus/slimbus.h
+++ b/drivers/slimbus/slimbus.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2011-2017, The Linux Foundation
  */
diff --git a/drivers/soc/renesas/rcar-sysc.h b/drivers/soc/renesas/rcar-sysc.h
index 485520a5b295..b496c53a2eee 100644
--- a/drivers/soc/renesas/rcar-sysc.h
+++ b/drivers/soc/renesas/rcar-sysc.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Renesas R-Car System Controller
  *
  * Copyright (C) 2016 Glider bvba
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index c77de05b8100..e2955a4d6c94 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
 // Copyright(c) 2015-17 Intel Corporation.
 
 #ifndef __SDW_BUS_H
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index eb902b19c5a4..75f884e593fc 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
 // Copyright(c) 2015-17 Intel Corporation.
 #include <sound/soc.h>
 
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index c1a5bac6212e..4231f59eeb4b 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
 // Copyright(c) 2015-17 Intel Corporation.
 
 #ifndef __SDW_INTEL_LOCAL_H
diff --git a/drivers/staging/erofs/erofs_fs.h b/drivers/staging/erofs/erofs_fs.h
index fa52898df006..12707274981e 100644
--- a/drivers/staging/erofs/erofs_fs.h
+++ b/drivers/staging/erofs/erofs_fs.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0 OR Apache-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 OR Apache-2.0 */
+/*
  * linux/drivers/staging/erofs/erofs_fs.h
  *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
diff --git a/drivers/staging/erofs/include/linux/tagptr.h b/drivers/staging/erofs/include/linux/tagptr.h
index ccd106dbd48e..be9e52cc2e28 100644
--- a/drivers/staging/erofs/include/linux/tagptr.h
+++ b/drivers/staging/erofs/include/linux/tagptr.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Tagged pointer implementation
  *
  * Copyright (C) 2018 Gao Xiang <gaoxiang25@huawei.com>
diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 3a27c255950b..caf43c390b8a 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * linux/drivers/staging/erofs/internal.h
  *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
diff --git a/drivers/staging/erofs/unzip_pagevec.h b/drivers/staging/erofs/unzip_pagevec.h
index 23856ba2742d..3cc8138ec010 100644
--- a/drivers/staging/erofs/unzip_pagevec.h
+++ b/drivers/staging/erofs/unzip_pagevec.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * linux/drivers/staging/erofs/unzip_pagevec.h
  *
  * Copyright (C) 2018 HUAWEI, Inc.
diff --git a/drivers/staging/erofs/unzip_vle.h b/drivers/staging/erofs/unzip_vle.h
index 9dafa8dc712c..4a3c2ca700ff 100644
--- a/drivers/staging/erofs/unzip_vle.h
+++ b/drivers/staging/erofs/unzip_vle.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * linux/drivers/staging/erofs/unzip_vle.h
  *
  * Copyright (C) 2018 HUAWEI, Inc.
diff --git a/drivers/staging/erofs/xattr.h b/drivers/staging/erofs/xattr.h
index 35ba5ac2139a..40f4f55ef6fe 100644
--- a/drivers/staging/erofs/xattr.h
+++ b/drivers/staging/erofs/xattr.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * linux/drivers/staging/erofs/xattr.h
  *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
diff --git a/drivers/staging/greybus/firmware.h b/drivers/staging/greybus/firmware.h
index 946221307ef6..72dfabfa4704 100644
--- a/drivers/staging/greybus/firmware.h
+++ b/drivers/staging/greybus/firmware.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Greybus Firmware Management Header
  *
diff --git a/drivers/staging/greybus/gb-camera.h b/drivers/staging/greybus/gb-camera.h
index ee293e461fc3..5fc469101fc1 100644
--- a/drivers/staging/greybus/gb-camera.h
+++ b/drivers/staging/greybus/gb-camera.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Greybus Camera protocol driver.
  *
diff --git a/drivers/staging/greybus/gbphy.h b/drivers/staging/greybus/gbphy.h
index 99463489d7d6..087928a586fb 100644
--- a/drivers/staging/greybus/gbphy.h
+++ b/drivers/staging/greybus/gbphy.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Greybus Bridged-Phy Bus driver
  *
diff --git a/drivers/staging/greybus/greybus.h b/drivers/staging/greybus/greybus.h
index d03ddb7c9df0..f0488ffff93e 100644
--- a/drivers/staging/greybus/greybus.h
+++ b/drivers/staging/greybus/greybus.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Greybus driver and device API
  *
diff --git a/drivers/staging/greybus/greybus_authentication.h b/drivers/staging/greybus/greybus_authentication.h
index 03ea9615b217..d654760cf175 100644
--- a/drivers/staging/greybus/greybus_authentication.h
+++ b/drivers/staging/greybus/greybus_authentication.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
 /*
  * Greybus Component Authentication User Header
  *
diff --git a/drivers/staging/greybus/greybus_firmware.h b/drivers/staging/greybus/greybus_firmware.h
index b58281a63ba4..13ef3aa5279e 100644
--- a/drivers/staging/greybus/greybus_firmware.h
+++ b/drivers/staging/greybus/greybus_firmware.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
 /*
  * Greybus Firmware Management User Header
  *
diff --git a/drivers/staging/greybus/greybus_manifest.h b/drivers/staging/greybus/greybus_manifest.h
index 2cec5cf7a846..db68f7e7d5a7 100644
--- a/drivers/staging/greybus/greybus_manifest.h
+++ b/drivers/staging/greybus/greybus_manifest.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Greybus manifest definition
  *
diff --git a/drivers/staging/greybus/greybus_protocols.h b/drivers/staging/greybus/greybus_protocols.h
index ddc73f10eb22..7d649a7fc4c9 100644
--- a/drivers/staging/greybus/greybus_protocols.h
+++ b/drivers/staging/greybus/greybus_protocols.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
 /*
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
diff --git a/drivers/staging/greybus/greybus_trace.h b/drivers/staging/greybus/greybus_trace.h
index 7b5e2c6b1f6b..1bc9f1275c65 100644
--- a/drivers/staging/greybus/greybus_trace.h
+++ b/drivers/staging/greybus/greybus_trace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Greybus driver and device API
  *
diff --git a/drivers/staging/greybus/hd.h b/drivers/staging/greybus/hd.h
index 6cf024a20a58..348b76fabc9a 100644
--- a/drivers/staging/greybus/hd.h
+++ b/drivers/staging/greybus/hd.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Greybus Host Device
  *
diff --git a/drivers/staging/greybus/interface.h b/drivers/staging/greybus/interface.h
index 1c00c5bb3ec9..8fb1eacda302 100644
--- a/drivers/staging/greybus/interface.h
+++ b/drivers/staging/greybus/interface.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Greybus Interface Block code
  *
diff --git a/drivers/staging/greybus/manifest.h b/drivers/staging/greybus/manifest.h
index f3c95a255631..88aa7e44cad5 100644
--- a/drivers/staging/greybus/manifest.h
+++ b/drivers/staging/greybus/manifest.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Greybus manifest parsing
  *
diff --git a/drivers/staging/greybus/module.h b/drivers/staging/greybus/module.h
index b1ebcc6636db..2a27e520ee94 100644
--- a/drivers/staging/greybus/module.h
+++ b/drivers/staging/greybus/module.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Greybus Module code
  *
diff --git a/drivers/staging/greybus/operation.h b/drivers/staging/greybus/operation.h
index 40b7b02fff88..17ba3daf111b 100644
--- a/drivers/staging/greybus/operation.h
+++ b/drivers/staging/greybus/operation.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Greybus operations
  *
diff --git a/drivers/staging/greybus/spilib.h b/drivers/staging/greybus/spilib.h
index 043d4d32c3ee..9d416839e3be 100644
--- a/drivers/staging/greybus/spilib.h
+++ b/drivers/staging/greybus/spilib.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Greybus SPI library header
  *
diff --git a/drivers/staging/greybus/svc.h b/drivers/staging/greybus/svc.h
index ad01783bac9c..e7452057cfe4 100644
--- a/drivers/staging/greybus/svc.h
+++ b/drivers/staging/greybus/svc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Greybus SVC code
  *
diff --git a/drivers/staging/most/core.h b/drivers/staging/most/core.h
index 64cc02f161e7..9b729346dc95 100644
--- a/drivers/staging/most/core.h
+++ b/drivers/staging/most/core.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * most.h - API for component and adapter drivers
  *
diff --git a/drivers/staging/most/dim2/errors.h b/drivers/staging/most/dim2/errors.h
index 3487510fbd2f..268332e5735e 100644
--- a/drivers/staging/most/dim2/errors.h
+++ b/drivers/staging/most/dim2/errors.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * errors.h - Definitions of errors for DIM2 HAL API
  * (MediaLB, Device Interface Macro IP, OS62420)
diff --git a/drivers/staging/most/dim2/hal.h b/drivers/staging/most/dim2/hal.h
index e04a5350f134..fca6c22de8a6 100644
--- a/drivers/staging/most/dim2/hal.h
+++ b/drivers/staging/most/dim2/hal.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * hal.h - DIM2 HAL interface
  * (MediaLB, Device Interface Macro IP, OS62420)
diff --git a/drivers/staging/most/dim2/reg.h b/drivers/staging/most/dim2/reg.h
index 4343a483017e..b0f36c208a57 100644
--- a/drivers/staging/most/dim2/reg.h
+++ b/drivers/staging/most/dim2/reg.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * reg.h - Definitions for registers of DIM2
  * (MediaLB, Device Interface Macro IP, OS62420)
diff --git a/drivers/staging/most/dim2/sysfs.h b/drivers/staging/most/dim2/sysfs.h
index 33756a3bffe2..24277a17cff3 100644
--- a/drivers/staging/most/dim2/sysfs.h
+++ b/drivers/staging/most/dim2/sysfs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * sysfs.h - MediaLB sysfs information
  *
diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
index 9feb95c431cb..16c5b7fba249 100644
--- a/drivers/staging/pi433/pi433_if.h
+++ b/drivers/staging/pi433/pi433_if.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * include/linux/TODO
  *
  * userspace interface for pi433 radio module
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index d43a8d87d5d3..b648ba5fff89 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * hardware abstraction/register access for HopeRf rf69 radio module
  *
  * Copyright (C) 2016 Wolf-Entwicklungen
diff --git a/drivers/staging/pi433/rf69_enum.h b/drivers/staging/pi433/rf69_enum.h
index 3ee1952245c2..fbf56fcf5fe8 100644
--- a/drivers/staging/pi433/rf69_enum.h
+++ b/drivers/staging/pi433/rf69_enum.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * enumerations for HopeRf rf69 radio module
  *
  * Copyright (C) 2016 Wolf-Entwicklungen
diff --git a/drivers/staging/pi433/rf69_registers.h b/drivers/staging/pi433/rf69_registers.h
index f925a83c3247..8dc1d665f5a2 100644
--- a/drivers/staging/pi433/rf69_registers.h
+++ b/drivers/staging/pi433/rf69_registers.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * register description for HopeRf rf69 radio module
  *
  * Copyright (C) 2016 Wolf-Entwicklungen
diff --git a/drivers/staging/unisys/include/iochannel.h b/drivers/staging/unisys/include/iochannel.h
index 45c785d80ce4..9ef812c0bc42 100644
--- a/drivers/staging/unisys/include/iochannel.h
+++ b/drivers/staging/unisys/include/iochannel.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2010 - 2016 UNISYS CORPORATION
  * All rights reserved.
diff --git a/drivers/staging/vt6655/baseband.h b/drivers/staging/vt6655/baseband.h
index 30d9e9d20a39..0cc2e07829c5 100644
--- a/drivers/staging/vt6655/baseband.h
+++ b/drivers/staging/vt6655/baseband.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6655/card.h b/drivers/staging/vt6655/card.h
index 5884fd56153e..d71022aa3f86 100644
--- a/drivers/staging/vt6655/card.h
+++ b/drivers/staging/vt6655/card.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6655/channel.h b/drivers/staging/vt6655/channel.h
index 53f623a4af65..0d2709607456 100644
--- a/drivers/staging/vt6655/channel.h
+++ b/drivers/staging/vt6655/channel.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6655/desc.h b/drivers/staging/vt6655/desc.h
index b4a0037b40c1..d4572847b08a 100644
--- a/drivers/staging/vt6655/desc.h
+++ b/drivers/staging/vt6655/desc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 2f9e9219e8c8..29f354ced563 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6655/device_cfg.h b/drivers/staging/vt6655/device_cfg.h
index 6b41c74f7c2a..04db6a8d3db3 100644
--- a/drivers/staging/vt6655/device_cfg.h
+++ b/drivers/staging/vt6655/device_cfg.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6655/dpc.h b/drivers/staging/vt6655/dpc.h
index 93af4220605f..eac67794cc49 100644
--- a/drivers/staging/vt6655/dpc.h
+++ b/drivers/staging/vt6655/dpc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6655/key.h b/drivers/staging/vt6655/key.h
index 0942d8703f98..9347776fa3a5 100644
--- a/drivers/staging/vt6655/key.h
+++ b/drivers/staging/vt6655/key.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index b8ab09434773..8c8c26792343 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6655/power.h b/drivers/staging/vt6655/power.h
index 2ec40045fddb..d1736c1cbfa8 100644
--- a/drivers/staging/vt6655/power.h
+++ b/drivers/staging/vt6655/power.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6655/rf.h b/drivers/staging/vt6655/rf.h
index bfce5a89657d..042ac67a9709 100644
--- a/drivers/staging/vt6655/rf.h
+++ b/drivers/staging/vt6655/rf.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6655/rxtx.h b/drivers/staging/vt6655/rxtx.h
index 08db848613f0..464dd89078b2 100644
--- a/drivers/staging/vt6655/rxtx.h
+++ b/drivers/staging/vt6655/rxtx.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6655/srom.h b/drivers/staging/vt6655/srom.h
index 577f20dc4308..d8aad3ff5f46 100644
--- a/drivers/staging/vt6655/srom.h
+++ b/drivers/staging/vt6655/srom.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6655/tmacro.h b/drivers/staging/vt6655/tmacro.h
index 6795b5d74cfc..8f4699f0d1f4 100644
--- a/drivers/staging/vt6655/tmacro.h
+++ b/drivers/staging/vt6655/tmacro.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6655/upc.h b/drivers/staging/vt6655/upc.h
index 61b3e568ff9a..d028ad2ba0d4 100644
--- a/drivers/staging/vt6655/upc.h
+++ b/drivers/staging/vt6655/upc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6656/baseband.h b/drivers/staging/vt6656/baseband.h
index a907e3026012..c3b8bbdb3ea1 100644
--- a/drivers/staging/vt6656/baseband.h
+++ b/drivers/staging/vt6656/baseband.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6656/card.h b/drivers/staging/vt6656/card.h
index 0a91d9ba4688..75cd340c0cce 100644
--- a/drivers/staging/vt6656/card.h
+++ b/drivers/staging/vt6656/card.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6656/channel.h b/drivers/staging/vt6656/channel.h
index 6d0d2825d992..cca330f0daf4 100644
--- a/drivers/staging/vt6656/channel.h
+++ b/drivers/staging/vt6656/channel.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6656/desc.h b/drivers/staging/vt6656/desc.h
index ac45ebb71195..3a83a9ea9a2a 100644
--- a/drivers/staging/vt6656/desc.h
+++ b/drivers/staging/vt6656/desc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6656/device.h b/drivers/staging/vt6656/device.h
index a2feeb916836..6074ceda78bf 100644
--- a/drivers/staging/vt6656/device.h
+++ b/drivers/staging/vt6656/device.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6656/dpc.h b/drivers/staging/vt6656/dpc.h
index ddd0cb710512..e080add823cb 100644
--- a/drivers/staging/vt6656/dpc.h
+++ b/drivers/staging/vt6656/dpc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6656/firmware.h b/drivers/staging/vt6656/firmware.h
index f30ae90cbb1f..161126faf396 100644
--- a/drivers/staging/vt6656/firmware.h
+++ b/drivers/staging/vt6656/firmware.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6656/int.h b/drivers/staging/vt6656/int.h
index 1e6ff925701a..987c454e99e9 100644
--- a/drivers/staging/vt6656/int.h
+++ b/drivers/staging/vt6656/int.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6656/key.h b/drivers/staging/vt6656/key.h
index 1306ff441b87..918c07cf86cd 100644
--- a/drivers/staging/vt6656/key.h
+++ b/drivers/staging/vt6656/key.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6656/power.h b/drivers/staging/vt6656/power.h
index d5a3198206da..58755ae16e5a 100644
--- a/drivers/staging/vt6656/power.h
+++ b/drivers/staging/vt6656/power.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6656/rf.h b/drivers/staging/vt6656/rf.h
index f77866a9c177..6103117d6df5 100644
--- a/drivers/staging/vt6656/rf.h
+++ b/drivers/staging/vt6656/rf.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6656/rxtx.h b/drivers/staging/vt6656/rxtx.h
index 44698f41a234..d528607e02bf 100644
--- a/drivers/staging/vt6656/rxtx.h
+++ b/drivers/staging/vt6656/rxtx.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6656/usbpipe.h b/drivers/staging/vt6656/usbpipe.h
index 5d7708fcf557..2910ca54886e 100644
--- a/drivers/staging/vt6656/usbpipe.h
+++ b/drivers/staging/vt6656/usbpipe.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/staging/vt6656/wcmd.h b/drivers/staging/vt6656/wcmd.h
index 4a96f4de980d..a0d98cf74998 100644
--- a/drivers/staging/vt6656/wcmd.h
+++ b/drivers/staging/vt6656/wcmd.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
  * All rights reserved.
diff --git a/drivers/tty/hvc/hvc_console.h b/drivers/tty/hvc/hvc_console.h
index e9319954c832..18d005814e4b 100644
--- a/drivers/tty/hvc/hvc_console.h
+++ b/drivers/tty/hvc/hvc_console.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * hvc_console.h
  * Copyright (C) 2005 IBM Corporation
diff --git a/drivers/tty/n_tracesink.h b/drivers/tty/n_tracesink.h
index 1b846330c855..7031d515a700 100644
--- a/drivers/tty/n_tracesink.h
+++ b/drivers/tty/n_tracesink.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  n_tracesink.h - Kernel driver API to route trace data in kernel space.
  *
diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index ebfb0bd5bef5..85377b76c0e4 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  *  Driver for 8250/16550-type serial ports
  *
diff --git a/drivers/tty/serial/atmel_serial.h b/drivers/tty/serial/atmel_serial.h
index d811d4f2d0c0..0d8a0f9cc5c3 100644
--- a/drivers/tty/serial/atmel_serial.h
+++ b/drivers/tty/serial/atmel_serial.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * include/linux/atmel_serial.h
  *
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart.h b/drivers/tty/serial/cpm_uart/cpm_uart.h
index 9f175a92fb5d..0de77c18c475 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart.h
+++ b/drivers/tty/serial/cpm_uart/cpm_uart.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  Driver for CPM (SCC/SMC) serial ports
  *
diff --git a/drivers/tty/serial/icom.h b/drivers/tty/serial/icom.h
index 8a77e739b333..26e3aa7b01e2 100644
--- a/drivers/tty/serial/icom.h
+++ b/drivers/tty/serial/icom.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * icom.h
  *
diff --git a/drivers/tty/serial/ifx6x60.h b/drivers/tty/serial/ifx6x60.h
index c5a2514212ff..cacca5be7390 100644
--- a/drivers/tty/serial/ifx6x60.h
+++ b/drivers/tty/serial/ifx6x60.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /****************************************************************************
  *
  * Driver for the IFX spi modem.
diff --git a/drivers/tty/serial/jsm/jsm.h b/drivers/tty/serial/jsm/jsm.h
index 7a128aaa3a66..8489c07f4cd5 100644
--- a/drivers/tty/serial/jsm/jsm.h
+++ b/drivers/tty/serial/jsm/jsm.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /************************************************************************
  * Copyright 2003 Digi International (www.digi.com)
  *
diff --git a/drivers/tty/serial/pic32_uart.h b/drivers/tty/serial/pic32_uart.h
index 2f2b56927dc6..b15639cc336b 100644
--- a/drivers/tty/serial/pic32_uart.h
+++ b/drivers/tty/serial/pic32_uart.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * PIC32 Integrated Serial Driver.
  *
diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
index f93022113f59..4909dae00051 100644
--- a/drivers/tty/serial/samsung.h
+++ b/drivers/tty/serial/samsung.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __SAMSUNG_H
 #define __SAMSUNG_H
 
diff --git a/drivers/tty/serial/serial_mctrl_gpio.h b/drivers/tty/serial/serial_mctrl_gpio.h
index b7d3cca48ede..e9010da15ea3 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.h
+++ b/drivers/tty/serial/serial_mctrl_gpio.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Helpers for controlling modem lines via GPIO
  *
diff --git a/drivers/tty/serial/sirfsoc_uart.h b/drivers/tty/serial/sirfsoc_uart.h
index 004ca684d3ae..4ae64b1cffa0 100644
--- a/drivers/tty/serial/sirfsoc_uart.h
+++ b/drivers/tty/serial/sirfsoc_uart.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Drivers for CSR SiRFprimaII onboard UARTs.
  *
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 6f294e280ea3..683156db252e 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) Maxime Coquelin 2015
  * Copyright (C) STMicroelectronics SA 2017
diff --git a/drivers/tty/serial/timbuart.h b/drivers/tty/serial/timbuart.h
index fb00b172117d..007e59af636d 100644
--- a/drivers/tty/serial/timbuart.h
+++ b/drivers/tty/serial/timbuart.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * timbuart.c timberdale FPGA GPIO driver
  * Copyright (c) 2009 Intel Corporation
diff --git a/drivers/usb/atm/usbatm.h b/drivers/usb/atm/usbatm.h
index d3bdc4cc47aa..8a85c7d8f203 100644
--- a/drivers/usb/atm/usbatm.h
+++ b/drivers/usb/atm/usbatm.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /******************************************************************************
  *  usbatm.h - Generic USB xDSL driver core
  *
diff --git a/drivers/usb/c67x00/c67x00-hcd.h b/drivers/usb/c67x00/c67x00-hcd.h
index 3b181d4c7a03..6b6b04a3fe0f 100644
--- a/drivers/usb/c67x00/c67x00-hcd.h
+++ b/drivers/usb/c67x00/c67x00-hcd.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * c67x00-hcd.h: Cypress C67X00 USB HCD
  *
diff --git a/drivers/usb/c67x00/c67x00.h b/drivers/usb/c67x00/c67x00.h
index 7ce10928b037..a4456d0fffa9 100644
--- a/drivers/usb/c67x00/c67x00.h
+++ b/drivers/usb/c67x00/c67x00.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * c67x00.h: Cypress C67X00 USB register and field definitions
  *
diff --git a/drivers/usb/chipidea/bits.h b/drivers/usb/chipidea/bits.h
index 98da99510be7..b1540ce93264 100644
--- a/drivers/usb/chipidea/bits.h
+++ b/drivers/usb/chipidea/bits.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * bits.h - register bits of the ChipIdea USB IP core
  *
diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index 6a2cc5cd0281..894ee7bcd0e0 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * ci.h - common structures, functions, and macros of the ChipIdea driver
  *
diff --git a/drivers/usb/chipidea/ci_hdrc_imx.h b/drivers/usb/chipidea/ci_hdrc_imx.h
index c842e03f8767..ef69d247cd8b 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.h
+++ b/drivers/usb/chipidea/ci_hdrc_imx.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright 2012 Freescale Semiconductor, Inc.
  */
diff --git a/drivers/usb/chipidea/otg.h b/drivers/usb/chipidea/otg.h
index 4f8b8179ec96..5e7a6e571dd2 100644
--- a/drivers/usb/chipidea/otg.h
+++ b/drivers/usb/chipidea/otg.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2013-2014 Freescale Semiconductor, Inc.
  *
diff --git a/drivers/usb/chipidea/otg_fsm.h b/drivers/usb/chipidea/otg_fsm.h
index 2b49d29bf2fb..1f5c5ae0e71e 100644
--- a/drivers/usb/chipidea/otg_fsm.h
+++ b/drivers/usb/chipidea/otg_fsm.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2014 Freescale Semiconductor, Inc.
  *
diff --git a/drivers/usb/chipidea/udc.h b/drivers/usb/chipidea/udc.h
index e023735d94b7..ebb11b625bb8 100644
--- a/drivers/usb/chipidea/udc.h
+++ b/drivers/usb/chipidea/udc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * udc.h - ChipIdea UDC structures
  *
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index a9e24e4b8df1..53b014d73ec8 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * usb hub driver head file
  *
diff --git a/drivers/usb/core/otg_whitelist.h b/drivers/usb/core/otg_whitelist.h
index 2ae90158ded7..fdd4897401e2 100644
--- a/drivers/usb/core/otg_whitelist.h
+++ b/drivers/usb/core/otg_whitelist.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * drivers/usb/core/otg_whitelist.h
  *
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index d95a5358f73d..1edeb7ece234 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Released under the GPLv2 only.
  */
diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 30bab8463c96..b7d19a5807a5 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /*
  * core.h - DesignWare HS OTG Controller common declarations
  *
diff --git a/drivers/usb/dwc2/debug.h b/drivers/usb/dwc2/debug.h
index a8c565b6bc34..47252c56d410 100644
--- a/drivers/usb/dwc2/debug.h
+++ b/drivers/usb/dwc2/debug.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * debug.h - Designware USB2 DRD controller debug header
  *
diff --git a/drivers/usb/dwc2/hcd.h b/drivers/usb/dwc2/hcd.h
index c089ffa1f0a8..a47a7d00330a 100644
--- a/drivers/usb/dwc2/hcd.h
+++ b/drivers/usb/dwc2/hcd.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /*
  * hcd.h - DesignWare HS OTG Controller host-mode declarations
  *
diff --git a/drivers/usb/dwc2/hw.h b/drivers/usb/dwc2/hw.h
index 98af924a9a5c..38b5e1e7e1c6 100644
--- a/drivers/usb/dwc2/hw.h
+++ b/drivers/usb/dwc2/hw.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /*
  * hw.h - DesignWare HS OTG Controller hardware definitions
  *
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 1528d395b156..aaa83f68a0d7 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * core.h - DesignWare USB3 DRD Core Header
  *
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 6759a7efd8d5..9cd81012e534 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /**
  * debug.h - DesignWare USB3 DRD Controller Debug Header
  *
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 3ed738e86ea7..5dc015f6c2b7 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * gadget.h - DesignWare USB3 DRD Gadget Header
  *
diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
index 70acdf94a0bf..9bbe5d4bf076 100644
--- a/drivers/usb/dwc3/io.h
+++ b/drivers/usb/dwc3/io.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /**
  * io.h - DesignWare USB3 DRD IO Header
  *
diff --git a/drivers/usb/dwc3/trace.h b/drivers/usb/dwc3/trace.h
index 818a63da1a44..f12e14059398 100644
--- a/drivers/usb/dwc3/trace.h
+++ b/drivers/usb/dwc3/trace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /**
  * trace.h - DesignWare USB3 DRD Controller Trace Support
  *
diff --git a/drivers/usb/early/xhci-dbc.h b/drivers/usb/early/xhci-dbc.h
index 673686eeddd7..9fb6a9f2548a 100644
--- a/drivers/usb/early/xhci-dbc.h
+++ b/drivers/usb/early/xhci-dbc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * xhci-dbc.h - xHCI debug capability early driver
  *
diff --git a/drivers/usb/gadget/function/f_uvc.h b/drivers/usb/gadget/function/f_uvc.h
index a81a17765558..1db972d4beeb 100644
--- a/drivers/usb/gadget/function/f_uvc.h
+++ b/drivers/usb/gadget/function/f_uvc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  *	f_uvc.h  --  USB Video Class Gadget driver
  *
diff --git a/drivers/usb/gadget/function/rndis.h b/drivers/usb/gadget/function/rndis.h
index c7e3a70ce6c1..f6167f7fea82 100644
--- a/drivers/usb/gadget/function/rndis.h
+++ b/drivers/usb/gadget/function/rndis.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * RNDIS	Definitions for Remote NDIS
  *
diff --git a/drivers/usb/gadget/function/u_audio.h b/drivers/usb/gadget/function/u_audio.h
index 81d3d4ed6dfb..5ea6b86f1fda 100644
--- a/drivers/usb/gadget/function/u_audio.h
+++ b/drivers/usb/gadget/function/u_audio.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * u_audio.h -- interface to USB gadget "ALSA sound card" utilities
  *
diff --git a/drivers/usb/gadget/function/u_ecm.h b/drivers/usb/gadget/function/u_ecm.h
index 098ece573a5e..77cfb89932be 100644
--- a/drivers/usb/gadget/function/u_ecm.h
+++ b/drivers/usb/gadget/function/u_ecm.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_ecm.h
  *
diff --git a/drivers/usb/gadget/function/u_eem.h b/drivers/usb/gadget/function/u_eem.h
index 921386a375cf..3bd85dfcd71c 100644
--- a/drivers/usb/gadget/function/u_eem.h
+++ b/drivers/usb/gadget/function/u_eem.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_eem.h
  *
diff --git a/drivers/usb/gadget/function/u_ether.h b/drivers/usb/gadget/function/u_ether.h
index 332307d54292..10dd640684e2 100644
--- a/drivers/usb/gadget/function/u_ether.h
+++ b/drivers/usb/gadget/function/u_ether.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * u_ether.h -- interface to USB gadget "ethernet link" utilities
  *
diff --git a/drivers/usb/gadget/function/u_ether_configfs.h b/drivers/usb/gadget/function/u_ether_configfs.h
index d8b92485b727..bd92b5703013 100644
--- a/drivers/usb/gadget/function/u_ether_configfs.h
+++ b/drivers/usb/gadget/function/u_ether_configfs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_ether_configfs.h
  *
diff --git a/drivers/usb/gadget/function/u_fs.h b/drivers/usb/gadget/function/u_fs.h
index f9b0cf67360d..f102ec23f3af 100644
--- a/drivers/usb/gadget/function/u_fs.h
+++ b/drivers/usb/gadget/function/u_fs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_fs.h
  *
diff --git a/drivers/usb/gadget/function/u_gether.h b/drivers/usb/gadget/function/u_gether.h
index ce4f07626f96..2f7a373ed449 100644
--- a/drivers/usb/gadget/function/u_gether.h
+++ b/drivers/usb/gadget/function/u_gether.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_gether.h
  *
diff --git a/drivers/usb/gadget/function/u_hid.h b/drivers/usb/gadget/function/u_hid.h
index 1594bfa312eb..84e6da302499 100644
--- a/drivers/usb/gadget/function/u_hid.h
+++ b/drivers/usb/gadget/function/u_hid.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_hid.h
  *
diff --git a/drivers/usb/gadget/function/u_midi.h b/drivers/usb/gadget/function/u_midi.h
index 29bf006c0a13..f6e14af7f566 100644
--- a/drivers/usb/gadget/function/u_midi.h
+++ b/drivers/usb/gadget/function/u_midi.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_midi.h
  *
diff --git a/drivers/usb/gadget/function/u_ncm.h b/drivers/usb/gadget/function/u_ncm.h
index d483e45c0f77..d6fb66226d67 100644
--- a/drivers/usb/gadget/function/u_ncm.h
+++ b/drivers/usb/gadget/function/u_ncm.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_ncm.h
  *
diff --git a/drivers/usb/gadget/function/u_phonet.h b/drivers/usb/gadget/function/u_phonet.h
index 12fb613f85d1..c53233b37192 100644
--- a/drivers/usb/gadget/function/u_phonet.h
+++ b/drivers/usb/gadget/function/u_phonet.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * u_phonet.h - interface to Phonet
  *
diff --git a/drivers/usb/gadget/function/u_printer.h b/drivers/usb/gadget/function/u_printer.h
index 78797764f478..318205fb778e 100644
--- a/drivers/usb/gadget/function/u_printer.h
+++ b/drivers/usb/gadget/function/u_printer.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_printer.h
  *
diff --git a/drivers/usb/gadget/function/u_rndis.h b/drivers/usb/gadget/function/u_rndis.h
index 1e148b76f339..a8c409b2f52f 100644
--- a/drivers/usb/gadget/function/u_rndis.h
+++ b/drivers/usb/gadget/function/u_rndis.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_rndis.h
  *
diff --git a/drivers/usb/gadget/function/u_serial.h b/drivers/usb/gadget/function/u_serial.h
index 9acaac1cbb75..c9bd39c9a4a5 100644
--- a/drivers/usb/gadget/function/u_serial.h
+++ b/drivers/usb/gadget/function/u_serial.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * u_serial.h - interface to USB gadget "serial port"/TTY utilities
  *
diff --git a/drivers/usb/gadget/function/u_tcm.h b/drivers/usb/gadget/function/u_tcm.h
index 3f7ccecb0f9b..2cd15d9a1c0d 100644
--- a/drivers/usb/gadget/function/u_tcm.h
+++ b/drivers/usb/gadget/function/u_tcm.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_tcm.h
  *
diff --git a/drivers/usb/gadget/function/u_uac1.h b/drivers/usb/gadget/function/u_uac1.h
index 6f1a9d73defe..39c0e29e1b46 100644
--- a/drivers/usb/gadget/function/u_uac1.h
+++ b/drivers/usb/gadget/function/u_uac1.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_uac1.h - Utility definitions for UAC1 function
  *
diff --git a/drivers/usb/gadget/function/u_uac1_legacy.h b/drivers/usb/gadget/function/u_uac1_legacy.h
index 5c1bdf46fe32..b5df9bcbbeba 100644
--- a/drivers/usb/gadget/function/u_uac1_legacy.h
+++ b/drivers/usb/gadget/function/u_uac1_legacy.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * u_uac1.h -- interface to USB gadget "ALSA AUDIO" utilities
  *
diff --git a/drivers/usb/gadget/function/u_uac2.h b/drivers/usb/gadget/function/u_uac2.h
index 82048791eb6e..b5035711172d 100644
--- a/drivers/usb/gadget/function/u_uac2.h
+++ b/drivers/usb/gadget/function/u_uac2.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_uac2.h
  *
diff --git a/drivers/usb/gadget/function/u_uvc.h b/drivers/usb/gadget/function/u_uvc.h
index 16da49a2fcf2..9a01a7d4f17f 100644
--- a/drivers/usb/gadget/function/u_uvc.h
+++ b/drivers/usb/gadget/function/u_uvc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_uvc.h
  *
diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index 1473d25ff17a..920763b56f2e 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  *	uvc_gadget.h  --  USB Video Class Gadget driver
  *
diff --git a/drivers/usb/gadget/function/uvc_configfs.h b/drivers/usb/gadget/function/uvc_configfs.h
index 341391dbc81f..7e1d7ca29bf2 100644
--- a/drivers/usb/gadget/function/uvc_configfs.h
+++ b/drivers/usb/gadget/function/uvc_configfs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * uvc_configfs.h
  *
diff --git a/drivers/usb/gadget/function/uvc_v4l2.h b/drivers/usb/gadget/function/uvc_v4l2.h
index 452d71059b3f..1576005b61fd 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.h
+++ b/drivers/usb/gadget/function/uvc_v4l2.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *	uvc_v4l2.h  --  USB Video Class Gadget driver
  *
diff --git a/drivers/usb/gadget/function/uvc_video.h b/drivers/usb/gadget/function/uvc_video.h
index dff12103f696..3e87ac7e2c05 100644
--- a/drivers/usb/gadget/function/uvc_video.h
+++ b/drivers/usb/gadget/function/uvc_video.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *	uvc_video.h  --  USB Video Class Gadget driver
  *
diff --git a/drivers/usb/gadget/u_f.h b/drivers/usb/gadget/u_f.h
index eaa13fd3dc7f..c384d9da2b8c 100644
--- a/drivers/usb/gadget/u_f.h
+++ b/drivers/usb/gadget/u_f.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_f.h
  *
diff --git a/drivers/usb/gadget/u_os_desc.h b/drivers/usb/gadget/u_os_desc.h
index 5d7d35c8cc31..abe471b9e2d3 100644
--- a/drivers/usb/gadget/u_os_desc.h
+++ b/drivers/usb/gadget/u_os_desc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * u_os_desc.h
  *
diff --git a/drivers/usb/gadget/udc/amd5536udc.h b/drivers/usb/gadget/udc/amd5536udc.h
index dfdef6a28904..014722e14007 100644
--- a/drivers/usb/gadget/udc/amd5536udc.h
+++ b/drivers/usb/gadget/udc/amd5536udc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * amd5536.h -- header for AMD 5536 UDC high/full speed USB device controller
  *
diff --git a/drivers/usb/gadget/udc/at91_udc.h b/drivers/usb/gadget/udc/at91_udc.h
index fd58c5b81826..d4a842dcc17e 100644
--- a/drivers/usb/gadget/udc/at91_udc.h
+++ b/drivers/usb/gadget/udc/at91_udc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2004 by Thomas Rathbone, HP Labs
  * Copyright (C) 2005 by Ivan Kokshaysky
diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.h b/drivers/usb/gadget/udc/atmel_usba_udc.h
index 030bf797cd25..f87964530364 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.h
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Driver for the Atmel USBA high speed USB device controller
  *
diff --git a/drivers/usb/gadget/udc/bdc/bdc.h b/drivers/usb/gadget/udc/bdc/bdc.h
index 6e1e881dc51e..ab2e048d6f3c 100644
--- a/drivers/usb/gadget/udc/bdc/bdc.h
+++ b/drivers/usb/gadget/udc/bdc/bdc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * bdc.h - header for the BRCM BDC USB3.0 device controller
  *
diff --git a/drivers/usb/gadget/udc/bdc/bdc_cmd.h b/drivers/usb/gadget/udc/bdc/bdc_cmd.h
index 29cc988a671a..373e674809e9 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_cmd.h
+++ b/drivers/usb/gadget/udc/bdc/bdc_cmd.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * bdc_cmd.h - header for the BDC debug functions
  *
diff --git a/drivers/usb/gadget/udc/bdc/bdc_dbg.h b/drivers/usb/gadget/udc/bdc/bdc_dbg.h
index 373d5abffbb8..859d588e209d 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_dbg.h
+++ b/drivers/usb/gadget/udc/bdc/bdc_dbg.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * bdc_dbg.h - header for the BDC debug functions
  *
diff --git a/drivers/usb/gadget/udc/bdc/bdc_ep.h b/drivers/usb/gadget/udc/bdc/bdc_ep.h
index a37ff8033b4f..5bbd73f99c6f 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_ep.h
+++ b/drivers/usb/gadget/udc/bdc/bdc_ep.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * bdc_ep.h - header for the BDC debug functions
  *
diff --git a/drivers/usb/gadget/udc/fotg210.h b/drivers/usb/gadget/udc/fotg210.h
index 08c32957503b..35e781e60909 100644
--- a/drivers/usb/gadget/udc/fotg210.h
+++ b/drivers/usb/gadget/udc/fotg210.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Faraday FOTG210 USB OTG controller
  *
diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.h b/drivers/usb/gadget/udc/fsl_qe_udc.h
index 2c537a904ee7..6de774db20f8 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.h
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * drivers/usb/gadget/qe_udc.h
  *
diff --git a/drivers/usb/gadget/udc/fsl_usb2_udc.h b/drivers/usb/gadget/udc/fsl_usb2_udc.h
index 4ba651ae9048..8ec967baa4c7 100644
--- a/drivers/usb/gadget/udc/fsl_usb2_udc.h
+++ b/drivers/usb/gadget/udc/fsl_usb2_udc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2004,2012 Freescale Semiconductor, Inc
  * All rights reserved.
diff --git a/drivers/usb/gadget/udc/fusb300_udc.h b/drivers/usb/gadget/udc/fusb300_udc.h
index eb3d6d379ba7..2c3f51265180 100644
--- a/drivers/usb/gadget/udc/fusb300_udc.h
+++ b/drivers/usb/gadget/udc/fusb300_udc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Fusb300 UDC (USB gadget)
  *
diff --git a/drivers/usb/gadget/udc/goku_udc.h b/drivers/usb/gadget/udc/goku_udc.h
index 70023d401079..9190eafda219 100644
--- a/drivers/usb/gadget/udc/goku_udc.h
+++ b/drivers/usb/gadget/udc/goku_udc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Toshiba TC86C001 ("Goku-S") USB Device Controller driver
  *
diff --git a/drivers/usb/gadget/udc/gr_udc.h b/drivers/usb/gadget/udc/gr_udc.h
index 417ad2aa2cc7..1de959a0dffe 100644
--- a/drivers/usb/gadget/udc/gr_udc.h
+++ b/drivers/usb/gadget/udc/gr_udc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * USB Peripheral Controller driver for Aeroflex Gaisler GRUSBDC.
  *
diff --git a/drivers/usb/gadget/udc/m66592-udc.h b/drivers/usb/gadget/udc/m66592-udc.h
index 01a64685b8a3..de5c160d3028 100644
--- a/drivers/usb/gadget/udc/m66592-udc.h
+++ b/drivers/usb/gadget/udc/m66592-udc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * M66592 UDC (USB gadget)
  *
diff --git a/drivers/usb/gadget/udc/mv_u3d.h b/drivers/usb/gadget/udc/mv_u3d.h
index 982625b7197a..aaac0246e031 100644
--- a/drivers/usb/gadget/udc/mv_u3d.h
+++ b/drivers/usb/gadget/udc/mv_u3d.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2011 Marvell International Ltd. All rights reserved.
  */
diff --git a/drivers/usb/gadget/udc/mv_udc.h b/drivers/usb/gadget/udc/mv_udc.h
index b3f759c0962c..335472e858e0 100644
--- a/drivers/usb/gadget/udc/mv_udc.h
+++ b/drivers/usb/gadget/udc/mv_udc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2011 Marvell International Ltd. All rights reserved.
  */
diff --git a/drivers/usb/gadget/udc/net2272.h b/drivers/usb/gadget/udc/net2272.h
index 8e644627992d..f40549090e5d 100644
--- a/drivers/usb/gadget/udc/net2272.h
+++ b/drivers/usb/gadget/udc/net2272.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * PLX NET2272 high/full speed USB device controller
  *
diff --git a/drivers/usb/gadget/udc/net2280.h b/drivers/usb/gadget/udc/net2280.h
index b65a797544d7..d0e2f9e37b92 100644
--- a/drivers/usb/gadget/udc/net2280.h
+++ b/drivers/usb/gadget/udc/net2280.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * NetChip 2280 high/full speed USB device controller.
  * Unlike many such controllers, this one talks PCI.
diff --git a/drivers/usb/gadget/udc/pxa25x_udc.h b/drivers/usb/gadget/udc/pxa25x_udc.h
index ccc6b921f067..a15d2edca0dc 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.h
+++ b/drivers/usb/gadget/udc/pxa25x_udc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Intel PXA25x on-chip full speed USB device controller
  *
diff --git a/drivers/usb/gadget/udc/pxa27x_udc.h b/drivers/usb/gadget/udc/pxa27x_udc.h
index 13b2977399ab..e0b81dbc8259 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.h
+++ b/drivers/usb/gadget/udc/pxa27x_udc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * linux/drivers/usb/gadget/pxa27x_udc.h
  * Intel PXA27x on-chip full speed USB device controller
diff --git a/drivers/usb/gadget/udc/r8a66597-udc.h b/drivers/usb/gadget/udc/r8a66597-udc.h
index 9a115caba661..5b727bc49461 100644
--- a/drivers/usb/gadget/udc/r8a66597-udc.h
+++ b/drivers/usb/gadget/udc/r8a66597-udc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * R8A66597 UDC
  *
diff --git a/drivers/usb/gadget/udc/s3c2410_udc.h b/drivers/usb/gadget/udc/s3c2410_udc.h
index bdcaa8dd300f..cefc49ae338d 100644
--- a/drivers/usb/gadget/udc/s3c2410_udc.h
+++ b/drivers/usb/gadget/udc/s3c2410_udc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * linux/drivers/usb/gadget/s3c2410_udc.h
  * Samsung on-chip full speed USB device controllers
diff --git a/drivers/usb/gadget/udc/trace.h b/drivers/usb/gadget/udc/trace.h
index 2d1f68b5ea76..f7c085ebf0b6 100644
--- a/drivers/usb/gadget/udc/trace.h
+++ b/drivers/usb/gadget/udc/trace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /**
  * udc.c - Core UDC Framework
  *
diff --git a/drivers/usb/host/ehci-fsl.h b/drivers/usb/host/ehci-fsl.h
index cbc422032e50..66ad7e0be955 100644
--- a/drivers/usb/host/ehci-fsl.h
+++ b/drivers/usb/host/ehci-fsl.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /* Copyright (C) 2005-2010,2012 Freescale Semiconductor, Inc.
  * Copyright (c) 2005 MontaVista Software
  */
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index ac5e967907d1..145e193072d4 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 2001-2002 by David Brownell
  */
diff --git a/drivers/usb/host/fhci.h b/drivers/usb/host/fhci.h
index 2ce5031d866d..81fbc019a9b3 100644
--- a/drivers/usb/host/fhci.h
+++ b/drivers/usb/host/fhci.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Freescale QUICC Engine USB Host Controller Driver
  *
diff --git a/drivers/usb/host/imx21-hcd.h b/drivers/usb/host/imx21-hcd.h
index 7b9cf0a38d6e..96d16752a73e 100644
--- a/drivers/usb/host/imx21-hcd.h
+++ b/drivers/usb/host/imx21-hcd.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Macros and prototypes for i.MX21
  *
diff --git a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
index ef4813bfc5bf..379f5f284813 100644
--- a/drivers/usb/host/ohci.h
+++ b/drivers/usb/host/ohci.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-1.0+
+/* SPDX-License-Identifier: GPL-1.0+ */
 /*
  * OHCI HCD (Host Controller Driver) for USB.
  *
diff --git a/drivers/usb/host/r8a66597.h b/drivers/usb/host/r8a66597.h
index 51973a923526..ab081475c113 100644
--- a/drivers/usb/host/r8a66597.h
+++ b/drivers/usb/host/r8a66597.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * R8A66597 HCD (Host Controller Driver)
  *
diff --git a/drivers/usb/host/whci/whcd.h b/drivers/usb/host/whci/whcd.h
index 139476997e7c..10d608dafea1 100644
--- a/drivers/usb/host/whci/whcd.h
+++ b/drivers/usb/host/whci/whcd.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Wireless Host Controller (WHC) private header.
  *
diff --git a/drivers/usb/host/whci/whci-hc.h b/drivers/usb/host/whci/whci-hc.h
index 5a86a57a80cc..7c3a3e638d66 100644
--- a/drivers/usb/host/whci/whci-hc.h
+++ b/drivers/usb/host/whci/whci-hc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Wireless Host Controller (WHC) data structures.
  *
diff --git a/drivers/usb/host/xhci-debugfs.h b/drivers/usb/host/xhci-debugfs.h
index ac5bc40f5c3a..27afad3ec651 100644
--- a/drivers/usb/host/xhci-debugfs.h
+++ b/drivers/usb/host/xhci-debugfs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * xhci-debugfs.h - xHCI debugfs interface
  *
diff --git a/drivers/usb/host/xhci-ext-caps.h b/drivers/usb/host/xhci-ext-caps.h
index 268328c20681..fa59b242cd51 100644
--- a/drivers/usb/host/xhci-ext-caps.h
+++ b/drivers/usb/host/xhci-ext-caps.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * xHCI host controller driver
  *
diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
index 8be8c5f7ff62..1306a9174dcb 100644
--- a/drivers/usb/host/xhci-mtk.h
+++ b/drivers/usb/host/xhci-mtk.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2015 MediaTek Inc.
  * Author:
diff --git a/drivers/usb/host/xhci-mvebu.h b/drivers/usb/host/xhci-mvebu.h
index ca0a3a5721dd..3be021793cc8 100644
--- a/drivers/usb/host/xhci-mvebu.h
+++ b/drivers/usb/host/xhci-mvebu.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2014 Marvell
  *
diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
index ae29f22ff5bd..f451528e4375 100644
--- a/drivers/usb/host/xhci-plat.h
+++ b/drivers/usb/host/xhci-plat.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * xhci-plat.h - xHCI host controller driver platform Bus Glue.
  *
diff --git a/drivers/usb/host/xhci-rcar.h b/drivers/usb/host/xhci-rcar.h
index 804b6ab4246f..3aecd9bdb22c 100644
--- a/drivers/usb/host/xhci-rcar.h
+++ b/drivers/usb/host/xhci-rcar.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * drivers/usb/host/xhci-rcar.h
  *
diff --git a/drivers/usb/host/xhci-trace.h b/drivers/usb/host/xhci-trace.h
index 88b427434bd8..946400ff9f1d 100644
--- a/drivers/usb/host/xhci-trace.h
+++ b/drivers/usb/host/xhci-trace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * xHCI host controller driver
  *
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 652dc36e3012..1ec321becf42 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 
 /*
  * xHCI host controller driver
diff --git a/drivers/usb/isp1760/isp1760-core.h b/drivers/usb/isp1760/isp1760-core.h
index 97cb4d7a3e1c..d9a0a4cc467c 100644
--- a/drivers/usb/isp1760/isp1760-core.h
+++ b/drivers/usb/isp1760/isp1760-core.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Driver for the NXP ISP1760 chip
  *
diff --git a/drivers/usb/isp1760/isp1760-regs.h b/drivers/usb/isp1760/isp1760-regs.h
index 1f00c3850cf7..fedc4f5cded0 100644
--- a/drivers/usb/isp1760/isp1760-regs.h
+++ b/drivers/usb/isp1760/isp1760-regs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Driver for the NXP ISP1760 chip
  *
diff --git a/drivers/usb/isp1760/isp1760-udc.h b/drivers/usb/isp1760/isp1760-udc.h
index 2d0b88747701..d2df650d54e9 100644
--- a/drivers/usb/isp1760/isp1760-udc.h
+++ b/drivers/usb/isp1760/isp1760-udc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Driver for the NXP ISP1761 device controller
  *
diff --git a/drivers/usb/misc/rio500_usb.h b/drivers/usb/misc/rio500_usb.h
index 6db7a5863496..23612607f7a8 100644
--- a/drivers/usb/misc/rio500_usb.h
+++ b/drivers/usb/misc/rio500_usb.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*  ----------------------------------------------------------------------
     Copyright (C) 2000  Cesar Miquel  (miquel@df.uba.ar)
     ---------------------------------------------------------------------- */
diff --git a/drivers/usb/misc/sisusbvga/sisusb.h b/drivers/usb/misc/sisusbvga/sisusb.h
index 8a5e6bb07d05..c0fb9e1c5361 100644
--- a/drivers/usb/misc/sisusbvga/sisusb.h
+++ b/drivers/usb/misc/sisusbvga/sisusb.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
 /*
  * sisusb - usb kernel driver for Net2280/SiS315 based USB2VGA dongles
  *
diff --git a/drivers/usb/misc/sisusbvga/sisusb_init.h b/drivers/usb/misc/sisusbvga/sisusb_init.h
index 1782c759c4ad..24c2e71d06e7 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_init.h
+++ b/drivers/usb/misc/sisusbvga/sisusb_init.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /* $XFree86$ */
 /* $XdotOrg$ */
 /*
diff --git a/drivers/usb/misc/sisusbvga/sisusb_struct.h b/drivers/usb/misc/sisusbvga/sisusb_struct.h
index 706d77090e00..3df64d2a9d43 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_struct.h
+++ b/drivers/usb/misc/sisusbvga/sisusb_struct.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /*
  * General structure definitions for universal mode switching modules
  *
diff --git a/drivers/usb/misc/usb_u132.h b/drivers/usb/misc/usb_u132.h
index 4bf77736914f..1584efbbd704 100644
--- a/drivers/usb/misc/usb_u132.h
+++ b/drivers/usb/misc/usb_u132.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
 * Common Header File for the Elan Digital Systems U132 adapter
 * this file should be included by both the "ftdi-u132" and
diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index 87823ac0d120..cbfce80e7128 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * mtu3.h - MediaTek USB3 DRD header
  *
diff --git a/drivers/usb/mtu3/mtu3_dr.h b/drivers/usb/mtu3/mtu3_dr.h
index 50702fdcde28..fa432ade8101 100644
--- a/drivers/usb/mtu3/mtu3_dr.h
+++ b/drivers/usb/mtu3/mtu3_dr.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * mtu3_dr.h - dual role switch and host glue layer header
  *
diff --git a/drivers/usb/mtu3/mtu3_hw_regs.h b/drivers/usb/mtu3/mtu3_hw_regs.h
index 1d65b7476f23..0cf7a0defd68 100644
--- a/drivers/usb/mtu3/mtu3_hw_regs.h
+++ b/drivers/usb/mtu3/mtu3_hw_regs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * mtu3_hw_regs.h - MediaTek USB3 DRD register and field definitions
  *
diff --git a/drivers/usb/mtu3/mtu3_qmu.h b/drivers/usb/mtu3/mtu3_qmu.h
index 81f5151a55ed..dd239cecbd1b 100644
--- a/drivers/usb/mtu3/mtu3_qmu.h
+++ b/drivers/usb/mtu3/mtu3_qmu.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * mtu3_qmu.h - Queue Management Unit driver header
  *
diff --git a/drivers/usb/musb/davinci.h b/drivers/usb/musb/davinci.h
index e021485c83ae..c8e67d15b510 100644
--- a/drivers/usb/musb/davinci.h
+++ b/drivers/usb/musb/davinci.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2005-2006 by Texas Instruments
  */
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 04203b7126d5..57f21da8e931 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * MUSB OTG driver defines
  *
diff --git a/drivers/usb/musb/musb_debug.h b/drivers/usb/musb/musb_debug.h
index c444a80fe1da..e5b3506c7b3f 100644
--- a/drivers/usb/musb/musb_debug.h
+++ b/drivers/usb/musb/musb_debug.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * MUSB OTG driver debug defines
  *
diff --git a/drivers/usb/musb/musb_dma.h b/drivers/usb/musb/musb_dma.h
index 8f60271c0a9d..e2e5d7e831a7 100644
--- a/drivers/usb/musb/musb_dma.h
+++ b/drivers/usb/musb/musb_dma.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * MUSB OTG driver DMA controller abstraction
  *
diff --git a/drivers/usb/musb/musb_gadget.h b/drivers/usb/musb/musb_gadget.h
index d02663660813..f49f25b3bf56 100644
--- a/drivers/usb/musb/musb_gadget.h
+++ b/drivers/usb/musb/musb_gadget.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * MUSB OTG driver peripheral defines
  *
diff --git a/drivers/usb/musb/musb_host.h b/drivers/usb/musb/musb_host.h
index 2999845632ce..32336571f05c 100644
--- a/drivers/usb/musb/musb_host.h
+++ b/drivers/usb/musb/musb_host.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * MUSB OTG driver host defines
  *
diff --git a/drivers/usb/musb/musb_io.h b/drivers/usb/musb/musb_io.h
index 8058a58092cf..36741417ec5b 100644
--- a/drivers/usb/musb/musb_io.h
+++ b/drivers/usb/musb/musb_io.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * MUSB OTG driver register I/O
  *
diff --git a/drivers/usb/musb/musb_regs.h b/drivers/usb/musb/musb_regs.h
index 5cd7264fc2cb..5fa110978f1a 100644
--- a/drivers/usb/musb/musb_regs.h
+++ b/drivers/usb/musb/musb_regs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * MUSB OTG driver register defines
  *
diff --git a/drivers/usb/musb/musb_trace.h b/drivers/usb/musb/musb_trace.h
index a97d618fe8ff..22d4877fca57 100644
--- a/drivers/usb/musb/musb_trace.h
+++ b/drivers/usb/musb/musb_trace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * musb_trace.h - MUSB Controller Trace Support
  *
diff --git a/drivers/usb/musb/omap2430.h b/drivers/usb/musb/omap2430.h
index 859008fa0e3c..939a0361ae88 100644
--- a/drivers/usb/musb/omap2430.h
+++ b/drivers/usb/musb/omap2430.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2005-2006 by Texas Instruments
  */
diff --git a/drivers/usb/musb/tusb6010.h b/drivers/usb/musb/tusb6010.h
index fd8025bbece7..8a253564fb18 100644
--- a/drivers/usb/musb/tusb6010.h
+++ b/drivers/usb/musb/tusb6010.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Definitions for TUSB6010 USB 2.0 OTG Dual Role controller
  *
diff --git a/drivers/usb/phy/phy-fsl-usb.h b/drivers/usb/phy/phy-fsl-usb.h
index 43d410f6641b..fbcc28ad9964 100644
--- a/drivers/usb/phy/phy-fsl-usb.h
+++ b/drivers/usb/phy/phy-fsl-usb.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /* Copyright (C) 2007,2008 Freescale Semiconductor, Inc. */
 
 #include <linux/usb/otg-fsm.h>
diff --git a/drivers/usb/phy/phy-mv-usb.h b/drivers/usb/phy/phy-mv-usb.h
index 96701a1229ad..5d5c0abb0c3a 100644
--- a/drivers/usb/phy/phy-mv-usb.h
+++ b/drivers/usb/phy/phy-mv-usb.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2011 Marvell International Ltd. All rights reserved.
  */
diff --git a/drivers/usb/renesas_usbhs/common.h b/drivers/usb/renesas_usbhs/common.h
index 3777af848a35..c2935e21caa8 100644
--- a/drivers/usb/renesas_usbhs/common.h
+++ b/drivers/usb/renesas_usbhs/common.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-1.0+
+/* SPDX-License-Identifier: GPL-1.0+ */
 /*
  * Renesas USB driver
  *
diff --git a/drivers/usb/renesas_usbhs/fifo.h b/drivers/usb/renesas_usbhs/fifo.h
index 88d1816bcda2..b0a05538098d 100644
--- a/drivers/usb/renesas_usbhs/fifo.h
+++ b/drivers/usb/renesas_usbhs/fifo.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-1.0+
+/* SPDX-License-Identifier: GPL-1.0+ */
 /*
  * Renesas USB driver
  *
diff --git a/drivers/usb/renesas_usbhs/mod.h b/drivers/usb/renesas_usbhs/mod.h
index a4a61d6b82a1..b1f433ee4f41 100644
--- a/drivers/usb/renesas_usbhs/mod.h
+++ b/drivers/usb/renesas_usbhs/mod.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-1.0+
+/* SPDX-License-Identifier: GPL-1.0+ */
 /*
  * Renesas USB driver
  *
diff --git a/drivers/usb/renesas_usbhs/pipe.h b/drivers/usb/renesas_usbhs/pipe.h
index 3080423e600c..bad132716986 100644
--- a/drivers/usb/renesas_usbhs/pipe.h
+++ b/drivers/usb/renesas_usbhs/pipe.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-1.0+
+/* SPDX-License-Identifier: GPL-1.0+ */
 /*
  * Renesas USB driver
  *
diff --git a/drivers/usb/renesas_usbhs/rcar2.h b/drivers/usb/renesas_usbhs/rcar2.h
index 45e3526cedeb..c5d713f609d8 100644
--- a/drivers/usb/renesas_usbhs/rcar2.h
+++ b/drivers/usb/renesas_usbhs/rcar2.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #include "common.h"
 
 extern const struct renesas_usbhs_platform_callback
diff --git a/drivers/usb/renesas_usbhs/rcar3.h b/drivers/usb/renesas_usbhs/rcar3.h
index 49e535a31771..5247ea1753d2 100644
--- a/drivers/usb/renesas_usbhs/rcar3.h
+++ b/drivers/usb/renesas_usbhs/rcar3.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #include "common.h"
 
 extern const struct renesas_usbhs_platform_callback usbhs_rcar3_ops;
diff --git a/drivers/usb/renesas_usbhs/rza.h b/drivers/usb/renesas_usbhs/rza.h
index ca917ca54f6d..00f066da0bfe 100644
--- a/drivers/usb/renesas_usbhs/rza.h
+++ b/drivers/usb/renesas_usbhs/rza.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #include "common.h"
 
 extern const struct renesas_usbhs_platform_callback usbhs_rza1_ops;
diff --git a/drivers/usb/serial/belkin_sa.h b/drivers/usb/serial/belkin_sa.h
index 51bc06287603..f05bf3b82969 100644
--- a/drivers/usb/serial/belkin_sa.h
+++ b/drivers/usb/serial/belkin_sa.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Definitions for Belkin USB Serial Adapter Driver
  *
diff --git a/drivers/usb/serial/io_16654.h b/drivers/usb/serial/io_16654.h
index 4980f72dc56f..f18501f056cf 100644
--- a/drivers/usb/serial/io_16654.h
+++ b/drivers/usb/serial/io_16654.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /************************************************************************
  *
  *	16654.H		Definitions for 16C654 UART used on EdgePorts
diff --git a/drivers/usb/serial/io_edgeport.h b/drivers/usb/serial/io_edgeport.h
index 2e7fedbaf2ff..43ba53a3a6fa 100644
--- a/drivers/usb/serial/io_edgeport.h
+++ b/drivers/usb/serial/io_edgeport.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /************************************************************************
  *
  *	io_edgeport.h	Edgeport Linux Interface definitions
diff --git a/drivers/usb/serial/io_ionsp.h b/drivers/usb/serial/io_ionsp.h
index 4b8e4823bd45..db4fce815c97 100644
--- a/drivers/usb/serial/io_ionsp.h
+++ b/drivers/usb/serial/io_ionsp.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /************************************************************************
  *
  *	IONSP.H		Definitions for I/O Networks Serial Protocol
diff --git a/drivers/usb/serial/io_ti.h b/drivers/usb/serial/io_ti.h
index 9bbcee37524e..50b899d55ed0 100644
--- a/drivers/usb/serial/io_ti.h
+++ b/drivers/usb/serial/io_ti.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*****************************************************************************
  *
  *	Copyright (C) 1997-2002 Inside Out Networks, Inc.
diff --git a/drivers/usb/serial/io_usbvend.h b/drivers/usb/serial/io_usbvend.h
index c38e87ac5ea9..d89704823a06 100644
--- a/drivers/usb/serial/io_usbvend.h
+++ b/drivers/usb/serial/io_usbvend.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /************************************************************************
  *
  *	USBVEND.H		Vendor-specific USB definitions
diff --git a/drivers/usb/serial/iuu_phoenix.h b/drivers/usb/serial/iuu_phoenix.h
index b400b262f72e..87992b24d904 100644
--- a/drivers/usb/serial/iuu_phoenix.h
+++ b/drivers/usb/serial/iuu_phoenix.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Infinity Unlimited USB Phoenix driver
  *
diff --git a/drivers/usb/serial/mct_u232.h b/drivers/usb/serial/mct_u232.h
index 0084edf518e8..e3d09a83cab1 100644
--- a/drivers/usb/serial/mct_u232.h
+++ b/drivers/usb/serial/mct_u232.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Definitions for MCT (Magic Control Technology) USB-RS232 Converter Driver
  *
diff --git a/drivers/usb/serial/oti6858.h b/drivers/usb/serial/oti6858.h
index 1226bf2347eb..5c25836fdcd9 100644
--- a/drivers/usb/serial/oti6858.h
+++ b/drivers/usb/serial/oti6858.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Ours Technology Inc. OTi-6858 USB to serial adapter driver.
  */
diff --git a/drivers/usb/serial/pl2303.h b/drivers/usb/serial/pl2303.h
index 559941ca884d..e3f7508db88a 100644
--- a/drivers/usb/serial/pl2303.h
+++ b/drivers/usb/serial/pl2303.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Prolific PL2303 USB to serial adaptor driver header file
  */
diff --git a/drivers/usb/serial/visor.h b/drivers/usb/serial/visor.h
index fe290243f1ce..466777b0beeb 100644
--- a/drivers/usb/serial/visor.h
+++ b/drivers/usb/serial/visor.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * USB HandSpring Visor driver
  *
diff --git a/drivers/usb/serial/whiteheat.h b/drivers/usb/serial/whiteheat.h
index 72c1b0cf4063..810ac9100724 100644
--- a/drivers/usb/serial/whiteheat.h
+++ b/drivers/usb/serial/whiteheat.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * USB ConnectTech WhiteHEAT driver
  *
diff --git a/drivers/usb/storage/debug.h b/drivers/usb/storage/debug.h
index 6d64f342f587..a1ea02244405 100644
--- a/drivers/usb/storage/debug.h
+++ b/drivers/usb/storage/debug.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Driver for USB Mass Storage compliant devices
  * Debugging Functions Header File
diff --git a/drivers/usb/storage/initializers.h b/drivers/usb/storage/initializers.h
index 2dbf9c7d9749..dcd7b7e5eda8 100644
--- a/drivers/usb/storage/initializers.h
+++ b/drivers/usb/storage/initializers.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Header file for Special Initializers for certain USB Mass Storage devices
  *
diff --git a/drivers/usb/storage/protocol.h b/drivers/usb/storage/protocol.h
index 072f1ffda2af..1d102463a66c 100644
--- a/drivers/usb/storage/protocol.h
+++ b/drivers/usb/storage/protocol.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Driver for USB Mass Storage compliant devices
  * Protocol Functions Header File
diff --git a/drivers/usb/storage/scsiglue.h b/drivers/usb/storage/scsiglue.h
index 2bc5ea045bf7..2a79c3ed4d86 100644
--- a/drivers/usb/storage/scsiglue.h
+++ b/drivers/usb/storage/scsiglue.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Driver for USB Mass Storage compliant devices
  * SCSI Connecting Glue Header File
diff --git a/drivers/usb/storage/transport.h b/drivers/usb/storage/transport.h
index fb3bb4ee4ccf..74ffd0d7e7b6 100644
--- a/drivers/usb/storage/transport.h
+++ b/drivers/usb/storage/transport.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Driver for USB Mass Storage compliant devices
  * Transport Functions Header File
diff --git a/drivers/usb/storage/unusual_alauda.h b/drivers/usb/storage/unusual_alauda.h
index 0ec8c99a4976..13f61ec88cde 100644
--- a/drivers/usb/storage/unusual_alauda.h
+++ b/drivers/usb/storage/unusual_alauda.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Unusual Devices File for the Alauda-based card readers
  */
diff --git a/drivers/usb/storage/unusual_cypress.h b/drivers/usb/storage/unusual_cypress.h
index fb99e526cd48..0547daf116a2 100644
--- a/drivers/usb/storage/unusual_cypress.h
+++ b/drivers/usb/storage/unusual_cypress.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Unusual Devices File for devices based on the Cypress USB/ATA bridge
  *	with support for ATACB
diff --git a/drivers/usb/storage/unusual_datafab.h b/drivers/usb/storage/unusual_datafab.h
index fdab5e7d68ca..5335b5d2bd79 100644
--- a/drivers/usb/storage/unusual_datafab.h
+++ b/drivers/usb/storage/unusual_datafab.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Unusual Devices File for the Datafab USB Compact Flash reader
  */
diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index ea0d27a94afe..d3f20592f3bc 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Driver for USB Mass Storage compliant devices
  * Unusual Devices File
diff --git a/drivers/usb/storage/unusual_ene_ub6250.h b/drivers/usb/storage/unusual_ene_ub6250.h
index 9134b91fbd73..a3b32abc2b2f 100644
--- a/drivers/usb/storage/unusual_ene_ub6250.h
+++ b/drivers/usb/storage/unusual_ene_ub6250.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 #if defined(CONFIG_USB_STORAGE_ENE_UB6250) || \
 		defined(CONFIG_USB_STORAGE_ENE_UB6250_MODULE)
 
diff --git a/drivers/usb/storage/unusual_freecom.h b/drivers/usb/storage/unusual_freecom.h
index 949231c7a36b..9ca686364a93 100644
--- a/drivers/usb/storage/unusual_freecom.h
+++ b/drivers/usb/storage/unusual_freecom.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Unusual Devices File for the Freecom USB/IDE adaptor
  */
diff --git a/drivers/usb/storage/unusual_isd200.h b/drivers/usb/storage/unusual_isd200.h
index d03a02cc904e..f248190bd666 100644
--- a/drivers/usb/storage/unusual_isd200.h
+++ b/drivers/usb/storage/unusual_isd200.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Unusual Devices File for In-System Design, Inc. ISD200 ASIC
  */
diff --git a/drivers/usb/storage/unusual_jumpshot.h b/drivers/usb/storage/unusual_jumpshot.h
index c323338881ef..44878f849c1c 100644
--- a/drivers/usb/storage/unusual_jumpshot.h
+++ b/drivers/usb/storage/unusual_jumpshot.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Unusual Devices File for the Lexar "Jumpshot" Compact Flash reader
  */
diff --git a/drivers/usb/storage/unusual_karma.h b/drivers/usb/storage/unusual_karma.h
index 8f1eebd71d2c..9fbed4cbc895 100644
--- a/drivers/usb/storage/unusual_karma.h
+++ b/drivers/usb/storage/unusual_karma.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Unusual Devices File for the Rio Karma
  */
diff --git a/drivers/usb/storage/unusual_onetouch.h b/drivers/usb/storage/unusual_onetouch.h
index c76d4e990f7b..cdfee8f6cf37 100644
--- a/drivers/usb/storage/unusual_onetouch.h
+++ b/drivers/usb/storage/unusual_onetouch.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Unusual Devices File for the Maxtor OneTouch USB hard drive's button
  */
diff --git a/drivers/usb/storage/unusual_realtek.h b/drivers/usb/storage/unusual_realtek.h
index 6b2140f966ef..c6bc219986a2 100644
--- a/drivers/usb/storage/unusual_realtek.h
+++ b/drivers/usb/storage/unusual_realtek.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Driver for Realtek RTS51xx USB card reader
  *
diff --git a/drivers/usb/storage/unusual_sddr09.h b/drivers/usb/storage/unusual_sddr09.h
index 650cf2862754..bfb650974129 100644
--- a/drivers/usb/storage/unusual_sddr09.h
+++ b/drivers/usb/storage/unusual_sddr09.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Unusual Devices File for SanDisk SDDR-09 SmartMedia reader
  */
diff --git a/drivers/usb/storage/unusual_sddr55.h b/drivers/usb/storage/unusual_sddr55.h
index e89df2cea7bd..6d6f76eb0630 100644
--- a/drivers/usb/storage/unusual_sddr55.h
+++ b/drivers/usb/storage/unusual_sddr55.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Unusual Devices File for SanDisk SDDR-55 SmartMedia reader
  */
diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
index d0bdebd87ce3..fb0495f555f5 100644
--- a/drivers/usb/storage/unusual_uas.h
+++ b/drivers/usb/storage/unusual_uas.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Driver for USB Attached SCSI devices - Unusual Devices File
  *
diff --git a/drivers/usb/storage/unusual_usbat.h b/drivers/usb/storage/unusual_usbat.h
index 05abf6870b8f..f9d3e5efc39d 100644
--- a/drivers/usb/storage/unusual_usbat.h
+++ b/drivers/usb/storage/unusual_usbat.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Unusual Devices File for SCM Microsystems (a.k.a. Shuttle) USB-ATAPI cable
  */
diff --git a/drivers/usb/storage/usb.h b/drivers/usb/storage/usb.h
index 85052cd66839..1fdba7fdcb07 100644
--- a/drivers/usb/storage/usb.h
+++ b/drivers/usb/storage/usb.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Driver for USB Mass Storage compliant devices
  * Main Header File
diff --git a/drivers/usb/typec/tcpm/fusb302_reg.h b/drivers/usb/typec/tcpm/fusb302_reg.h
index 00b39d365478..edc0e4b0f1e6 100644
--- a/drivers/usb/typec/tcpm/fusb302_reg.h
+++ b/drivers/usb/typec/tcpm/fusb302_reg.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright 2016-2017 Google, Inc
  *
diff --git a/drivers/usb/usbip/stub.h b/drivers/usb/usbip/stub.h
index 35618ceb2791..403b512d18a2 100644
--- a/drivers/usb/usbip/stub.h
+++ b/drivers/usb/usbip/stub.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2003-2008 Takahiro Hirofuchi
  */
diff --git a/drivers/usb/usbip/usbip_common.h b/drivers/usb/usbip/usbip_common.h
index bf8afe9b5883..2a69e555390f 100644
--- a/drivers/usb/usbip/usbip_common.h
+++ b/drivers/usb/usbip/usbip_common.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2003-2008 Takahiro Hirofuchi
  * Copyright (C) 2015-2016 Samsung Electronics
diff --git a/drivers/usb/usbip/vhci.h b/drivers/usb/usbip/vhci.h
index 5659dce1526e..95a739be32e4 100644
--- a/drivers/usb/usbip/vhci.h
+++ b/drivers/usb/usbip/vhci.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2003-2008 Takahiro Hirofuchi
  * Copyright (C) 2015 Nobuo Iwata
diff --git a/drivers/usb/usbip/vudc.h b/drivers/usb/usbip/vudc.h
index cf968192e59f..c17c2185e38b 100644
--- a/drivers/usb/usbip/vudc.h
+++ b/drivers/usb/usbip/vudc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2015 Karol Kosik <karo9@interia.eu>
  * Copyright (C) 2015-2016 Samsung Electronics
diff --git a/drivers/usb/wusbcore/wa-hc.h b/drivers/usb/wusbcore/wa-hc.h
index ec90fff21deb..6e0f3152c6c2 100644
--- a/drivers/usb/wusbcore/wa-hc.h
+++ b/drivers/usb/wusbcore/wa-hc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * HWA Host Controller Driver
  * Wire Adapter Control/Data Streaming Iface (WUSB1.0[8])
diff --git a/drivers/usb/wusbcore/wusbhc.h b/drivers/usb/wusbcore/wusbhc.h
index 7681d796ca5b..2cb76f8027d8 100644
--- a/drivers/usb/wusbcore/wusbhc.h
+++ b/drivers/usb/wusbcore/wusbhc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Wireless USB Host Controller
  * Common infrastructure for WHCI and HWA WUSB-HC drivers
diff --git a/drivers/visorbus/controlvmchannel.h b/drivers/visorbus/controlvmchannel.h
index 8c57562a070a..c87213554427 100644
--- a/drivers/visorbus/controlvmchannel.h
+++ b/drivers/visorbus/controlvmchannel.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2010 - 2015 UNISYS CORPORATION
  * All rights reserved.
diff --git a/drivers/visorbus/vbuschannel.h b/drivers/visorbus/vbuschannel.h
index b1dce26166bf..4aaf6564eb9f 100644
--- a/drivers/visorbus/vbuschannel.h
+++ b/drivers/visorbus/vbuschannel.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2010 - 2015 UNISYS CORPORATION
  * All rights reserved.
diff --git a/drivers/visorbus/visorbus_private.h b/drivers/visorbus/visorbus_private.h
index 366380b7f8d9..6956de605827 100644
--- a/drivers/visorbus/visorbus_private.h
+++ b/drivers/visorbus/visorbus_private.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2010 - 2015 UNISYS CORPORATION
  * All rights reserved.
diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index f0d73d86cc1a..034e6973cead 100644
--- a/fs/debugfs/internal.h
+++ b/fs/debugfs/internal.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  internal.h - declarations internal to debugfs
  *
diff --git a/fs/ext4/acl.h b/fs/ext4/acl.h
index 9b63f5416a2f..a48fc5ae2701 100644
--- a/fs/ext4/acl.h
+++ b/fs/ext4/acl.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
   File: fs/ext4/acl.h
 
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 5012ddb6daf9..b5586a3d91f0 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  ext4.h
  *
diff --git a/fs/ext4/ext4_extents.h b/fs/ext4/ext4_extents.h
index 98bd0e9ee7df..ded2a0c2d255 100644
--- a/fs/ext4/ext4_extents.h
+++ b/fs/ext4/ext4_extents.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2003-2006, Cluster File Systems, Inc, info@clusterfs.com
  * Written by Alex Tomas <alex@clusterfs.com>
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index a1ac7e9245ec..367f391487ac 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * ext4_jbd2.h
  *
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index 131a8b7df265..80e64fa5e9f9 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  fs/ext4/extents_status.h
  *
diff --git a/fs/ext4/fsmap.h b/fs/ext4/fsmap.h
index 68c8001fee85..e80bae62798f 100644
--- a/fs/ext4/fsmap.h
+++ b/fs/ext4/fsmap.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2017 Oracle.  All Rights Reserved.
  *
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 88c98f17e3d9..dcf52540f379 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  fs/ext4/mballoc.h
  *
diff --git a/fs/ext4/truncate.h b/fs/ext4/truncate.h
index bcbe3668c1d4..e465183d963f 100644
--- a/fs/ext4/truncate.h
+++ b/fs/ext4/truncate.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * linux/fs/ext4/truncate.h
  *
diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index f39cad2abe2a..262b9314119f 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
   File: fs/ext4/xattr.h
 
diff --git a/fs/f2fs/acl.h b/fs/f2fs/acl.h
index b96823c59b15..124868c13f80 100644
--- a/fs/f2fs/acl.h
+++ b/fs/f2fs/acl.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * fs/f2fs/acl.h
  *
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b0b843027fbc..8b882c5c4a17 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * fs/f2fs/f2fs.h
  *
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index bbac9d3787bd..db3c61046aa4 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * fs/f2fs/gc.h
  *
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index e05af5df5648..6a2011deea23 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * fs/f2fs/node.h
  *
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 5c7ed0442d6e..af458aac2407 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * fs/f2fs/segment.h
  *
diff --git a/fs/f2fs/trace.h b/fs/f2fs/trace.h
index e8075fc5b228..789f6aa727fc 100644
--- a/fs/f2fs/trace.h
+++ b/fs/f2fs/trace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * f2fs IO tracer
  *
diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index 67db134da0f5..4f7f50503ef5 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * fs/f2fs/xattr.h
  *
diff --git a/fs/xfs/kmem.h b/fs/xfs/kmem.h
index 8e6b3ba81c03..67bcf58cf5ca 100644
--- a/fs/xfs/kmem.h
+++ b/fs/xfs/kmem.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/libxfs/xfs_ag_resv.h b/fs/xfs/libxfs/xfs_ag_resv.h
index c0352edc8e41..f3fd0ee9a7f7 100644
--- a/fs/xfs/libxfs/xfs_ag_resv.h
+++ b/fs/xfs/libxfs/xfs_ag_resv.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2016 Oracle.  All Rights Reserved.
  * Author: Darrick J. Wong <darrick.wong@oracle.com>
diff --git a/fs/xfs/libxfs/xfs_alloc.h b/fs/xfs/libxfs/xfs_alloc.h
index d6ed5d2c07c2..16471d5ca6e6 100644
--- a/fs/xfs/libxfs/xfs_alloc.h
+++ b/fs/xfs/libxfs/xfs_alloc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2002,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/libxfs/xfs_alloc_btree.h b/fs/xfs/libxfs/xfs_alloc_btree.h
index c9305ebb69f6..09e7f5c594ef 100644
--- a/fs/xfs/libxfs/xfs_alloc_btree.h
+++ b/fs/xfs/libxfs/xfs_alloc_btree.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/libxfs/xfs_attr.h b/fs/xfs/libxfs/xfs_attr.h
index 2297d8467666..c67d7aac693e 100644
--- a/fs/xfs/libxfs/xfs_attr.h
+++ b/fs/xfs/libxfs/xfs_attr.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000,2002-2003,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/libxfs/xfs_attr_leaf.h b/fs/xfs/libxfs/xfs_attr_leaf.h
index 7b74e18becff..3ce05251d5d8 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.h
+++ b/fs/xfs/libxfs/xfs_attr_leaf.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000,2002-2003,2005 Silicon Graphics, Inc.
  * Copyright (c) 2013 Red Hat, Inc.
diff --git a/fs/xfs/libxfs/xfs_attr_remote.h b/fs/xfs/libxfs/xfs_attr_remote.h
index 9d20b66ad379..217b9b8c5660 100644
--- a/fs/xfs/libxfs/xfs_attr_remote.h
+++ b/fs/xfs/libxfs/xfs_attr_remote.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2013 Red Hat, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/libxfs/xfs_attr_sf.h b/fs/xfs/libxfs/xfs_attr_sf.h
index aafa4fe70624..bb004fb7944a 100644
--- a/fs/xfs/libxfs/xfs_attr_sf.h
+++ b/fs/xfs/libxfs/xfs_attr_sf.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000,2002,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/libxfs/xfs_bit.h b/fs/xfs/libxfs/xfs_bit.h
index 99017b8df292..a04f266ae644 100644
--- a/fs/xfs/libxfs/xfs_bit.h
+++ b/fs/xfs/libxfs/xfs_bit.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000,2002,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index 4dc7d1a02b35..418b161993ef 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2006 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/libxfs/xfs_bmap_btree.h b/fs/xfs/libxfs/xfs_bmap_btree.h
index 29b407d053b4..72bf74c79fb9 100644
--- a/fs/xfs/libxfs/xfs_bmap_btree.h
+++ b/fs/xfs/libxfs/xfs_bmap_btree.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000,2002-2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/libxfs/xfs_btree.h b/fs/xfs/libxfs/xfs_btree.h
index e3b3e9dce5da..32db4d5f7590 100644
--- a/fs/xfs/libxfs/xfs_btree.h
+++ b/fs/xfs/libxfs/xfs_btree.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2001,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/libxfs/xfs_da_btree.h b/fs/xfs/libxfs/xfs_da_btree.h
index 84dd865b6c3d..5d4fd8946609 100644
--- a/fs/xfs/libxfs/xfs_da_btree.h
+++ b/fs/xfs/libxfs/xfs_da_btree.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000,2002,2005 Silicon Graphics, Inc.
  * Copyright (c) 2013 Red Hat, Inc.
diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
index ae654e06b2fb..3e8022dae1fe 100644
--- a/fs/xfs/libxfs/xfs_da_format.h
+++ b/fs/xfs/libxfs/xfs_da_format.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2001,2005 Silicon Graphics, Inc.
  * Copyright (c) 2013 Red Hat, Inc.
diff --git a/fs/xfs/libxfs/xfs_defer.h b/fs/xfs/libxfs/xfs_defer.h
index 7c28d7608ac6..d119f0fda166 100644
--- a/fs/xfs/libxfs/xfs_defer.h
+++ b/fs/xfs/libxfs/xfs_defer.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2016 Oracle.  All Rights Reserved.
  * Author: Darrick J. Wong <darrick.wong@oracle.com>
diff --git a/fs/xfs/libxfs/xfs_dir2.h b/fs/xfs/libxfs/xfs_dir2.h
index f54244779492..0192d6f503ab 100644
--- a/fs/xfs/libxfs/xfs_dir2.h
+++ b/fs/xfs/libxfs/xfs_dir2.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2001,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/libxfs/xfs_dir2_priv.h b/fs/xfs/libxfs/xfs_dir2_priv.h
index 59f9fb2241a5..c72e1dad6e63 100644
--- a/fs/xfs/libxfs/xfs_dir2_priv.h
+++ b/fs/xfs/libxfs/xfs_dir2_priv.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2001,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/libxfs/xfs_errortag.h b/fs/xfs/libxfs/xfs_errortag.h
index 79e6c4fb1d8a..9c58ab8648f5 100644
--- a/fs/xfs/libxfs/xfs_errortag.h
+++ b/fs/xfs/libxfs/xfs_errortag.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 2000-2002,2005 Silicon Graphics, Inc.
  * Copyright (C) 2017 Oracle.
diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 9bb3c48843ec..451878908571 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index f3aa59302fef..ac8f181c5b48 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: LGPL-2.1
+/* SPDX-License-Identifier: LGPL-2.1 */
 /*
  * Copyright (c) 1995-2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/libxfs/xfs_ialloc.h b/fs/xfs/libxfs/xfs_ialloc.h
index e936b7cc9389..bdfbb35df13f 100644
--- a/fs/xfs/libxfs/xfs_ialloc.h
+++ b/fs/xfs/libxfs/xfs_ialloc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/libxfs/xfs_ialloc_btree.h b/fs/xfs/libxfs/xfs_ialloc_btree.h
index ebdd0c6b8766..6376bb2c8138 100644
--- a/fs/xfs/libxfs/xfs_ialloc_btree.h
+++ b/fs/xfs/libxfs/xfs_ialloc_btree.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/libxfs/xfs_inode_buf.h b/fs/xfs/libxfs/xfs_inode_buf.h
index ab0f84165317..b13dd625abb9 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.h
+++ b/fs/xfs/libxfs/xfs_inode_buf.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2003,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/libxfs/xfs_inode_fork.h b/fs/xfs/libxfs/xfs_inode_fork.h
index 00c62ce170d0..10535c8be1d6 100644
--- a/fs/xfs/libxfs/xfs_inode_fork.h
+++ b/fs/xfs/libxfs/xfs_inode_fork.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2003,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
index e5f97c69b320..c8c41f61130b 100644
--- a/fs/xfs/libxfs/xfs_log_format.h
+++ b/fs/xfs/libxfs/xfs_log_format.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2003,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/libxfs/xfs_log_recover.h b/fs/xfs/libxfs/xfs_log_recover.h
index f3d18eaecebb..5f72c5a8d738 100644
--- a/fs/xfs/libxfs/xfs_log_recover.h
+++ b/fs/xfs/libxfs/xfs_log_recover.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/libxfs/xfs_quota_defs.h b/fs/xfs/libxfs/xfs_quota_defs.h
index 4bfdd5f4c6af..f3c336554ad8 100644
--- a/fs/xfs/libxfs/xfs_quota_defs.h
+++ b/fs/xfs/libxfs/xfs_quota_defs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/libxfs/xfs_refcount.h b/fs/xfs/libxfs/xfs_refcount.h
index 1d9c518575e7..0bffe94ee1ca 100644
--- a/fs/xfs/libxfs/xfs_refcount.h
+++ b/fs/xfs/libxfs/xfs_refcount.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2016 Oracle.  All Rights Reserved.
  * Author: Darrick J. Wong <darrick.wong@oracle.com>
diff --git a/fs/xfs/libxfs/xfs_refcount_btree.h b/fs/xfs/libxfs/xfs_refcount_btree.h
index ba416f71c824..e025bf2c7478 100644
--- a/fs/xfs/libxfs/xfs_refcount_btree.h
+++ b/fs/xfs/libxfs/xfs_refcount_btree.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2016 Oracle.  All Rights Reserved.
  * Author: Darrick J. Wong <darrick.wong@oracle.com>
diff --git a/fs/xfs/libxfs/xfs_rmap.h b/fs/xfs/libxfs/xfs_rmap.h
index e21ed0294e5c..50e103dc6107 100644
--- a/fs/xfs/libxfs/xfs_rmap.h
+++ b/fs/xfs/libxfs/xfs_rmap.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2016 Oracle.  All Rights Reserved.
  * Author: Darrick J. Wong <darrick.wong@oracle.com>
diff --git a/fs/xfs/libxfs/xfs_rmap_btree.h b/fs/xfs/libxfs/xfs_rmap_btree.h
index 820d668b063d..ad6a30fd9c10 100644
--- a/fs/xfs/libxfs/xfs_rmap_btree.h
+++ b/fs/xfs/libxfs/xfs_rmap_btree.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2014 Red Hat, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/libxfs/xfs_sb.h b/fs/xfs/libxfs/xfs_sb.h
index 13564d69800a..a55b57b3e189 100644
--- a/fs/xfs/libxfs/xfs_sb.h
+++ b/fs/xfs/libxfs/xfs_sb.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/libxfs/xfs_shared.h b/fs/xfs/libxfs/xfs_shared.h
index 4e909791aeac..66d3260320c1 100644
--- a/fs/xfs/libxfs/xfs_shared.h
+++ b/fs/xfs/libxfs/xfs_shared.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2005 Silicon Graphics, Inc.
  * Copyright (c) 2013 Red Hat, Inc.
diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
index 7241ab28cf84..2d162a45a67d 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.h
+++ b/fs/xfs/libxfs/xfs_trans_resv.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2002,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/libxfs/xfs_trans_space.h b/fs/xfs/libxfs/xfs_trans_space.h
index a62fb950bef1..5dcad6538a0c 100644
--- a/fs/xfs/libxfs/xfs_trans_space.h
+++ b/fs/xfs/libxfs/xfs_trans_space.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/libxfs/xfs_types.h b/fs/xfs/libxfs/xfs_types.h
index c5a25403b4db..cc583b8aef74 100644
--- a/fs/xfs/libxfs/xfs_types.h
+++ b/fs/xfs/libxfs/xfs_types.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/mrlock.h b/fs/xfs/mrlock.h
index 79155eec341b..9d48729a295e 100644
--- a/fs/xfs/mrlock.h
+++ b/fs/xfs/mrlock.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2006 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/scrub/bitmap.h b/fs/xfs/scrub/bitmap.h
index ae8ecbce6fa6..42e0e6b6f00a 100644
--- a/fs/xfs/scrub/bitmap.h
+++ b/fs/xfs/scrub/bitmap.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2018 Oracle.  All Rights Reserved.
  * Author: Darrick J. Wong <darrick.wong@oracle.com>
diff --git a/fs/xfs/scrub/btree.h b/fs/xfs/scrub/btree.h
index 5572e475f8ed..11a7d85d8589 100644
--- a/fs/xfs/scrub/btree.h
+++ b/fs/xfs/scrub/btree.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2017 Oracle.  All Rights Reserved.
  * Author: Darrick J. Wong <darrick.wong@oracle.com>
diff --git a/fs/xfs/scrub/common.h b/fs/xfs/scrub/common.h
index e26a430bd466..e8de0f8f88cd 100644
--- a/fs/xfs/scrub/common.h
+++ b/fs/xfs/scrub/common.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2017 Oracle.  All Rights Reserved.
  * Author: Darrick J. Wong <darrick.wong@oracle.com>
diff --git a/fs/xfs/scrub/dabtree.h b/fs/xfs/scrub/dabtree.h
index cb3f0003245b..5b90df8f80df 100644
--- a/fs/xfs/scrub/dabtree.h
+++ b/fs/xfs/scrub/dabtree.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2017 Oracle.  All Rights Reserved.
  * Author: Darrick J. Wong <darrick.wong@oracle.com>
diff --git a/fs/xfs/scrub/repair.h b/fs/xfs/scrub/repair.h
index d990314eb08b..1f21b103f458 100644
--- a/fs/xfs/scrub/repair.h
+++ b/fs/xfs/scrub/repair.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2018 Oracle.  All Rights Reserved.
  * Author: Darrick J. Wong <darrick.wong@oracle.com>
diff --git a/fs/xfs/scrub/scrub.h b/fs/xfs/scrub/scrub.h
index 22f754fba8e5..ccd467778c95 100644
--- a/fs/xfs/scrub/scrub.h
+++ b/fs/xfs/scrub/scrub.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2017 Oracle.  All Rights Reserved.
  * Author: Darrick J. Wong <darrick.wong@oracle.com>
diff --git a/fs/xfs/scrub/trace.h b/fs/xfs/scrub/trace.h
index 3c83e8b3b39c..493f29a2a75b 100644
--- a/fs/xfs/scrub/trace.h
+++ b/fs/xfs/scrub/trace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2017 Oracle.  All Rights Reserved.
  * Author: Darrick J. Wong <darrick.wong@oracle.com>
diff --git a/fs/xfs/scrub/xfs_scrub.h b/fs/xfs/scrub/xfs_scrub.h
index 2897ba3a17e6..1f3277bb5258 100644
--- a/fs/xfs/scrub/xfs_scrub.h
+++ b/fs/xfs/scrub/xfs_scrub.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2017 Oracle.  All Rights Reserved.
  * Author: Darrick J. Wong <darrick.wong@oracle.com>
diff --git a/fs/xfs/xfs.h b/fs/xfs/xfs.h
index f6ffb4f248f7..d8b47f5e5949 100644
--- a/fs/xfs/xfs.h
+++ b/fs/xfs/xfs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2003,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_acl.h b/fs/xfs/xfs_acl.h
index 94615e34bc86..6680087fd995 100644
--- a/fs/xfs/xfs_acl.h
+++ b/fs/xfs/xfs_acl.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2001-2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_aops.h b/fs/xfs/xfs_aops.h
index e5c23948a8ab..8aa9c6626f15 100644
--- a/fs/xfs/xfs_aops.h
+++ b/fs/xfs/xfs_aops.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2005-2006 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_bmap_item.h b/fs/xfs/xfs_bmap_item.h
index 89e043a88bb8..05b9335c71e6 100644
--- a/fs/xfs/xfs_bmap_item.h
+++ b/fs/xfs/xfs_bmap_item.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2016 Oracle.  All Rights Reserved.
  * Author: Darrick J. Wong <darrick.wong@oracle.com>
diff --git a/fs/xfs/xfs_bmap_util.h b/fs/xfs/xfs_bmap_util.h
index 7a78229cf1a7..1f5ba148088d 100644
--- a/fs/xfs/xfs_bmap_util.h
+++ b/fs/xfs/xfs_bmap_util.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2006 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index 44f9423a1861..15116f1d0fb7 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_buf_item.h b/fs/xfs/xfs_buf_item.h
index 90f65f891fab..c0f43097a6d5 100644
--- a/fs/xfs/xfs_buf_item.h
+++ b/fs/xfs/xfs_buf_item.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2001,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_dquot.h b/fs/xfs/xfs_dquot.h
index 64bd8640f6e8..f08a423dc6cf 100644
--- a/fs/xfs/xfs_dquot.h
+++ b/fs/xfs/xfs_dquot.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_dquot_item.h b/fs/xfs/xfs_dquot_item.h
index db9df710a308..1c9f7187eb1f 100644
--- a/fs/xfs/xfs_dquot_item.h
+++ b/fs/xfs/xfs_dquot_item.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2003 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_error.h b/fs/xfs/xfs_error.h
index 602aa7d62b66..9438a89013aa 100644
--- a/fs/xfs/xfs_error.h
+++ b/fs/xfs/xfs_error.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2002,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_export.h b/fs/xfs/xfs_export.h
index 64471a3ddb04..5efc62f15bd0 100644
--- a/fs/xfs/xfs_export.h
+++ b/fs/xfs/xfs_export.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_extent_busy.h b/fs/xfs/xfs_extent_busy.h
index 990ab3891971..daff5522ce70 100644
--- a/fs/xfs/xfs_extent_busy.h
+++ b/fs/xfs/xfs_extent_busy.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2002,2005 Silicon Graphics, Inc.
  * Copyright (c) 2010 David Chinner.
diff --git a/fs/xfs/xfs_extfree_item.h b/fs/xfs/xfs_extfree_item.h
index 2a6a895ca73e..1db7dcdc391b 100644
--- a/fs/xfs/xfs_extfree_item.h
+++ b/fs/xfs/xfs_extfree_item.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_filestream.h b/fs/xfs/xfs_filestream.h
index 5cc7665e93c9..af23117808d0 100644
--- a/fs/xfs/xfs_filestream.h
+++ b/fs/xfs/xfs_filestream.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2006-2007 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_fsmap.h b/fs/xfs/xfs_fsmap.h
index c6c57739b862..56a4209b3a4f 100644
--- a/fs/xfs/xfs_fsmap.h
+++ b/fs/xfs/xfs_fsmap.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2017 Oracle.  All Rights Reserved.
  * Author: Darrick J. Wong <darrick.wong@oracle.com>
diff --git a/fs/xfs/xfs_fsops.h b/fs/xfs/xfs_fsops.h
index d023db0862c2..1affae14aef4 100644
--- a/fs/xfs/xfs_fsops.h
+++ b/fs/xfs/xfs_fsops.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2001,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_icache.h b/fs/xfs/xfs_icache.h
index 26c0626f1f75..7017498eabd8 100644
--- a/fs/xfs/xfs_icache.h
+++ b/fs/xfs/xfs_icache.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2006 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_icreate_item.h b/fs/xfs/xfs_icreate_item.h
index a50d0b01e15a..6bf905409447 100644
--- a/fs/xfs/xfs_icreate_item.h
+++ b/fs/xfs/xfs_icreate_item.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2008-2010, Dave Chinner
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index e62074a5257c..ce6c0f62120f 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2003,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_inode_item.h b/fs/xfs/xfs_inode_item.h
index 27081eba220c..01837e2dba0d 100644
--- a/fs/xfs/xfs_inode_item.h
+++ b/fs/xfs/xfs_inode_item.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_ioctl.h b/fs/xfs/xfs_ioctl.h
index 4b17f67c888a..5b316563e057 100644
--- a/fs/xfs/xfs_ioctl.h
+++ b/fs/xfs/xfs_ioctl.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2008 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_ioctl32.h b/fs/xfs/xfs_ioctl32.h
index d28fa824284a..9267f0aefada 100644
--- a/fs/xfs/xfs_ioctl32.h
+++ b/fs/xfs/xfs_ioctl32.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2004-2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index c6170548831b..e211dd4a855d 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2003-2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
index 4d24ff309f59..4f351dfca5bb 100644
--- a/fs/xfs/xfs_iops.h
+++ b/fs/xfs/xfs_iops.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2003,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_itable.h b/fs/xfs/xfs_itable.h
index 8a822285b671..455c0c83e024 100644
--- a/fs/xfs/xfs_itable.h
+++ b/fs/xfs/xfs_itable.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2001 Silicon Graphics, Inc.  All Rights Reserved.
  */
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index edbd5a210df2..b073c22d15e7 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_log.h b/fs/xfs/xfs_log.h
index 73a64bf32f6f..f696b7d17d6e 100644
--- a/fs/xfs/xfs_log.h
+++ b/fs/xfs/xfs_log.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2003,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
index b5f82cb36202..cf6d02e04eb7 100644
--- a/fs/xfs/xfs_log_priv.h
+++ b/fs/xfs/xfs_log_priv.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2003,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index a33f45077867..3de780092820 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_mru_cache.h b/fs/xfs/xfs_mru_cache.h
index f1fde1ecf730..afed2815ffa9 100644
--- a/fs/xfs/xfs_mru_cache.h
+++ b/fs/xfs/xfs_mru_cache.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2006-2007 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_ondisk.h b/fs/xfs/xfs_ondisk.h
index c8ba98fae30a..40eecb7ff770 100644
--- a/fs/xfs/xfs_ondisk.h
+++ b/fs/xfs/xfs_ondisk.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2016 Oracle.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_qm.h b/fs/xfs/xfs_qm.h
index 3ccf0fbc9071..f48f1a97a650 100644
--- a/fs/xfs/xfs_qm.h
+++ b/fs/xfs/xfs_qm.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_quota.h b/fs/xfs/xfs_quota.h
index 55b798265ef7..756c8d345a88 100644
--- a/fs/xfs/xfs_quota.h
+++ b/fs/xfs/xfs_quota.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_refcount_item.h b/fs/xfs/xfs_refcount_item.h
index 3896dcc2368f..d2f3da88beaa 100644
--- a/fs/xfs/xfs_refcount_item.h
+++ b/fs/xfs/xfs_refcount_item.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2016 Oracle.  All Rights Reserved.
  * Author: Darrick J. Wong <darrick.wong@oracle.com>
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index 6d73daef1f13..e9cda08dac6f 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2016 Oracle.  All Rights Reserved.
  * Author: Darrick J. Wong <darrick.wong@oracle.com>
diff --git a/fs/xfs/xfs_rmap_item.h b/fs/xfs/xfs_rmap_item.h
index 7e482baa27f5..8725c73131a5 100644
--- a/fs/xfs/xfs_rmap_item.h
+++ b/fs/xfs/xfs_rmap_item.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2016 Oracle.  All Rights Reserved.
  * Author: Darrick J. Wong <darrick.wong@oracle.com>
diff --git a/fs/xfs/xfs_rtalloc.h b/fs/xfs/xfs_rtalloc.h
index 93e77b221355..47573fc80ddc 100644
--- a/fs/xfs/xfs_rtalloc.h
+++ b/fs/xfs/xfs_rtalloc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2003,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_stats.h b/fs/xfs/xfs_stats.h
index 34d704f703d2..4c44a5725612 100644
--- a/fs/xfs/xfs_stats.h
+++ b/fs/xfs/xfs_stats.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_super.h b/fs/xfs/xfs_super.h
index 21cb49a43d7c..086999e42d4c 100644
--- a/fs/xfs/xfs_super.h
+++ b/fs/xfs/xfs_super.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_symlink.h b/fs/xfs/xfs_symlink.h
index 9743d8c9394b..ff1721340dfe 100644
--- a/fs/xfs/xfs_symlink.h
+++ b/fs/xfs/xfs_symlink.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2012 Red Hat, Inc. All rights reserved.
  */
diff --git a/fs/xfs/xfs_sysctl.h b/fs/xfs/xfs_sysctl.h
index 168488130a19..d0eb515de395 100644
--- a/fs/xfs/xfs_sysctl.h
+++ b/fs/xfs/xfs_sysctl.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2001-2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_sysfs.h b/fs/xfs/xfs_sysfs.h
index e9f810fc6731..56676cd7fe8b 100644
--- a/fs/xfs/xfs_sysfs.h
+++ b/fs/xfs/xfs_sysfs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2014 Red Hat, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index c83ce022a355..9c7c26e24d99 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2009, Christoph Hellwig
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
index c6e1c5704a8c..19d124bfb542 100644
--- a/fs/xfs/xfs_trans.h
+++ b/fs/xfs/xfs_trans.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000-2002,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/fs/xfs/xfs_trans_priv.h b/fs/xfs/xfs_trans_priv.h
index 091eae9f4e74..3e905091621a 100644
--- a/fs/xfs/xfs_trans_priv.h
+++ b/fs/xfs/xfs_trans_priv.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2000,2002,2005 Silicon Graphics, Inc.
  * All Rights Reserved.
diff --git a/include/acpi/nfit.h b/include/acpi/nfit.h
index 86ed07c1200d..ed7c3dac76bd 100644
--- a/include/acpi/nfit.h
+++ b/include/acpi/nfit.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * SPDX-License-Identifier: GPL-2.0
  * Copyright (C) 2018 Intel Corporation
  */
 
diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index e8730c6b9fe2..fa7007dc835d 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 
 // Generated by scripts/atomic/gen-atomic-instrumented.sh
 // DO NOT MODIFY THIS FILE DIRECTLY
diff --git a/include/asm-generic/atomic-long.h b/include/asm-generic/atomic-long.h
index 881c7e27af28..a242308bc1d6 100644
--- a/include/asm-generic/atomic-long.h
+++ b/include/asm-generic/atomic-long.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 
 // Generated by scripts/atomic/gen-atomic-long.sh
 // DO NOT MODIFY THIS FILE DIRECTLY
diff --git a/include/crypto/asym_tpm_subtype.h b/include/crypto/asym_tpm_subtype.h
index 48198c36d6b9..b7d874cf7bdd 100644
--- a/include/crypto/asym_tpm_subtype.h
+++ b/include/crypto/asym_tpm_subtype.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _LINUX_ASYM_TPM_SUBTYPE_H
 #define _LINUX_ASYM_TPM_SUBTYPE_H
 
diff --git a/include/drm/drm_audio_component.h b/include/drm/drm_audio_component.h
index 4923b00328c1..edbd177490cb 100644
--- a/include/drm/drm_audio_component.h
+++ b/include/drm/drm_audio_component.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: MIT
+/* SPDX-License-Identifier: MIT */
 // Copyright © 2014 Intel Corporation
 
 #ifndef _DRM_AUDIO_COMPONENT_H_
diff --git a/include/drm/drm_dsc.h b/include/drm/drm_dsc.h
index 9c26f083c70f..7c453da2daee 100644
--- a/include/drm/drm_dsc.h
+++ b/include/drm/drm_dsc.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: MIT
- * Copyright (C) 2018 Intel Corp.
+/* SPDX-License-Identifier: MIT */
+/*  Copyright (C) 2018 Intel Corp.
  *
  * Authors:
  * Manasi Navare <manasi.d.navare@intel.com>
diff --git a/include/drm/drm_probe_helper.h b/include/drm/drm_probe_helper.h
index 8d3ed2834d34..15260a56e102 100644
--- a/include/drm/drm_probe_helper.h
+++ b/include/drm/drm_probe_helper.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 OR MIT
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
 
 #ifndef __DRM_PROBE_HELPER_H__
 #define __DRM_PROBE_HELPER_H__
diff --git a/include/dt-bindings/clock/actions,s700-cmu.h b/include/dt-bindings/clock/actions,s700-cmu.h
index 3e1942996724..f60b44dd42aa 100644
--- a/include/dt-bindings/clock/actions,s700-cmu.h
+++ b/include/dt-bindings/clock/actions,s700-cmu.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Device Tree binding constants for Actions Semi S700 Clock Management Unit
  *
  * Copyright (c) 2014 Actions Semi Inc.
diff --git a/include/dt-bindings/clock/actions,s900-cmu.h b/include/dt-bindings/clock/actions,s900-cmu.h
index 7c1251565f43..308dc57cacca 100644
--- a/include/dt-bindings/clock/actions,s900-cmu.h
+++ b/include/dt-bindings/clock/actions,s900-cmu.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 //
 // Device Tree binding constants for Actions Semi S900 Clock Management Unit
 //
diff --git a/include/dt-bindings/clock/boston-clock.h b/include/dt-bindings/clock/boston-clock.h
index a6f009821137..6ca3cbd58669 100644
--- a/include/dt-bindings/clock/boston-clock.h
+++ b/include/dt-bindings/clock/boston-clock.h
@@ -1,7 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2016 Imagination Technologies
  *
- * SPDX-License-Identifier:	GPL-2.0
  */
 
 #ifndef __DT_BINDINGS_CLOCK_BOSTON_CLOCK_H__
diff --git a/include/dt-bindings/clock/imx6sll-clock.h b/include/dt-bindings/clock/imx6sll-clock.h
index f446710fe63d..494fd0c37fb5 100644
--- a/include/dt-bindings/clock/imx6sll-clock.h
+++ b/include/dt-bindings/clock/imx6sll-clock.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2016 Freescale Semiconductor, Inc.
  * Copyright 2017-2018 NXP.
diff --git a/include/dt-bindings/clock/qcom,camcc-sdm845.h b/include/dt-bindings/clock/qcom,camcc-sdm845.h
index 4f7a2d2320bf..d959492dc034 100644
--- a/include/dt-bindings/clock/qcom,camcc-sdm845.h
+++ b/include/dt-bindings/clock/qcom,camcc-sdm845.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
  */
diff --git a/include/dt-bindings/clock/r7s72100-clock.h b/include/dt-bindings/clock/r7s72100-clock.h
index a267ac250143..1520a8ec45e2 100644
--- a/include/dt-bindings/clock/r7s72100-clock.h
+++ b/include/dt-bindings/clock/r7s72100-clock.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2014 Renesas Solutions Corp.
  * Copyright (C) 2014 Wolfram Sang, Sang Engineering <wsa@sang-engineering.com>
  */
diff --git a/include/dt-bindings/clock/r7s9210-cpg-mssr.h b/include/dt-bindings/clock/r7s9210-cpg-mssr.h
index b6f85ca149aa..705859b20dcf 100644
--- a/include/dt-bindings/clock/r7s9210-cpg-mssr.h
+++ b/include/dt-bindings/clock/r7s9210-cpg-mssr.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2018 Renesas Electronics Corp.
  *
  */
diff --git a/include/dt-bindings/clock/r8a7743-cpg-mssr.h b/include/dt-bindings/clock/r8a7743-cpg-mssr.h
index 3ba936029d9f..94b811e51fc7 100644
--- a/include/dt-bindings/clock/r8a7743-cpg-mssr.h
+++ b/include/dt-bindings/clock/r8a7743-cpg-mssr.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * Copyright (C) 2016 Cogent Embedded Inc.
  */
 #ifndef __DT_BINDINGS_CLOCK_R8A7743_CPG_MSSR_H__
diff --git a/include/dt-bindings/clock/r8a7744-cpg-mssr.h b/include/dt-bindings/clock/r8a7744-cpg-mssr.h
index 2690be0c3e22..c5c0e92eddda 100644
--- a/include/dt-bindings/clock/r8a7744-cpg-mssr.h
+++ b/include/dt-bindings/clock/r8a7744-cpg-mssr.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2018 Renesas Electronics Corp.
  */
 #ifndef __DT_BINDINGS_CLOCK_R8A7744_CPG_MSSR_H__
diff --git a/include/dt-bindings/clock/r8a7745-cpg-mssr.h b/include/dt-bindings/clock/r8a7745-cpg-mssr.h
index f81066c9d192..c747b5a8a32d 100644
--- a/include/dt-bindings/clock/r8a7745-cpg-mssr.h
+++ b/include/dt-bindings/clock/r8a7745-cpg-mssr.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * Copyright (C) 2016 Cogent Embedded Inc.
  */
 #ifndef __DT_BINDINGS_CLOCK_R8A7745_CPG_MSSR_H__
diff --git a/include/dt-bindings/clock/r8a77470-cpg-mssr.h b/include/dt-bindings/clock/r8a77470-cpg-mssr.h
index 34cba49d0f84..4075b8c8cd73 100644
--- a/include/dt-bindings/clock/r8a77470-cpg-mssr.h
+++ b/include/dt-bindings/clock/r8a77470-cpg-mssr.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2018 Renesas Electronics Corp.
  */
 #ifndef __DT_BINDINGS_CLOCK_R8A77470_CPG_MSSR_H__
diff --git a/include/dt-bindings/clock/r8a774a1-cpg-mssr.h b/include/dt-bindings/clock/r8a774a1-cpg-mssr.h
index e355363f40c2..97a32b93e253 100644
--- a/include/dt-bindings/clock/r8a774a1-cpg-mssr.h
+++ b/include/dt-bindings/clock/r8a774a1-cpg-mssr.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2018 Renesas Electronics Corp.
  */
 #ifndef __DT_BINDINGS_CLOCK_R8A774A1_CPG_MSSR_H__
diff --git a/include/dt-bindings/clock/r8a7790-cpg-mssr.h b/include/dt-bindings/clock/r8a7790-cpg-mssr.h
index c5955b56b36d..3e75574d397b 100644
--- a/include/dt-bindings/clock/r8a7790-cpg-mssr.h
+++ b/include/dt-bindings/clock/r8a7790-cpg-mssr.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * Copyright (C) 2015 Renesas Electronics Corp.
  */
 
diff --git a/include/dt-bindings/clock/r8a7791-cpg-mssr.h b/include/dt-bindings/clock/r8a7791-cpg-mssr.h
index aadd06c566c0..bf4675e7c104 100644
--- a/include/dt-bindings/clock/r8a7791-cpg-mssr.h
+++ b/include/dt-bindings/clock/r8a7791-cpg-mssr.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * Copyright (C) 2015 Renesas Electronics Corp.
  */
 
diff --git a/include/dt-bindings/clock/r8a7792-cpg-mssr.h b/include/dt-bindings/clock/r8a7792-cpg-mssr.h
index 829c44db0271..7a324ed0e26c 100644
--- a/include/dt-bindings/clock/r8a7792-cpg-mssr.h
+++ b/include/dt-bindings/clock/r8a7792-cpg-mssr.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * Copyright (C) 2015 Renesas Electronics Corp.
  */
 
diff --git a/include/dt-bindings/clock/r8a7793-clock.h b/include/dt-bindings/clock/r8a7793-clock.h
index 49c66d8ed178..cef67c8d2f8a 100644
--- a/include/dt-bindings/clock/r8a7793-clock.h
+++ b/include/dt-bindings/clock/r8a7793-clock.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * r8a7793 clock definition
  *
  * Copyright (C) 2014  Renesas Electronics Corporation
diff --git a/include/dt-bindings/clock/r8a7793-cpg-mssr.h b/include/dt-bindings/clock/r8a7793-cpg-mssr.h
index d1ff646c31f2..ca4c208ffa86 100644
--- a/include/dt-bindings/clock/r8a7793-cpg-mssr.h
+++ b/include/dt-bindings/clock/r8a7793-cpg-mssr.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * Copyright (C) 2015 Renesas Electronics Corp.
  */
 
diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
index 649f005782d0..e1110867a292 100644
--- a/include/dt-bindings/clock/r8a7794-clock.h
+++ b/include/dt-bindings/clock/r8a7794-clock.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * Copyright (C) 2014 Renesas Electronics Corporation
  * Copyright 2013 Ideas On Board SPRL
  */
diff --git a/include/dt-bindings/clock/r8a7794-cpg-mssr.h b/include/dt-bindings/clock/r8a7794-cpg-mssr.h
index 6314e23b51af..47070980f812 100644
--- a/include/dt-bindings/clock/r8a7794-cpg-mssr.h
+++ b/include/dt-bindings/clock/r8a7794-cpg-mssr.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * Copyright (C) 2015 Renesas Electronics Corp.
  */
 
diff --git a/include/dt-bindings/clock/r8a7795-cpg-mssr.h b/include/dt-bindings/clock/r8a7795-cpg-mssr.h
index 92b3e2a95179..74efd9f88c03 100644
--- a/include/dt-bindings/clock/r8a7795-cpg-mssr.h
+++ b/include/dt-bindings/clock/r8a7795-cpg-mssr.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * Copyright (C) 2015 Renesas Electronics Corp.
  */
 #ifndef __DT_BINDINGS_CLOCK_R8A7795_CPG_MSSR_H__
diff --git a/include/dt-bindings/clock/r8a7796-cpg-mssr.h b/include/dt-bindings/clock/r8a7796-cpg-mssr.h
index c0957cf45840..e454b5eeb8f6 100644
--- a/include/dt-bindings/clock/r8a7796-cpg-mssr.h
+++ b/include/dt-bindings/clock/r8a7796-cpg-mssr.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * Copyright (C) 2016 Renesas Electronics Corp.
  */
 #ifndef __DT_BINDINGS_CLOCK_R8A7796_CPG_MSSR_H__
diff --git a/include/dt-bindings/clock/r8a77970-cpg-mssr.h b/include/dt-bindings/clock/r8a77970-cpg-mssr.h
index 6145ebe66361..8dee7b032729 100644
--- a/include/dt-bindings/clock/r8a77970-cpg-mssr.h
+++ b/include/dt-bindings/clock/r8a77970-cpg-mssr.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * Copyright (C) 2016 Renesas Electronics Corp.
  * Copyright (C) 2017 Cogent Embedded, Inc.
  */
diff --git a/include/dt-bindings/clock/r8a77995-cpg-mssr.h b/include/dt-bindings/clock/r8a77995-cpg-mssr.h
index fd701c4e87cf..57b578e30f2d 100644
--- a/include/dt-bindings/clock/r8a77995-cpg-mssr.h
+++ b/include/dt-bindings/clock/r8a77995-cpg-mssr.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * Copyright (C) 2017 Glider bvba
  */
 #ifndef __DT_BINDINGS_CLOCK_R8A77995_CPG_MSSR_H__
diff --git a/include/dt-bindings/clock/renesas-cpg-mssr.h b/include/dt-bindings/clock/renesas-cpg-mssr.h
index 8169ad063f0a..06665b8b4c8c 100644
--- a/include/dt-bindings/clock/renesas-cpg-mssr.h
+++ b/include/dt-bindings/clock/renesas-cpg-mssr.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * Copyright (C) 2015 Renesas Electronics Corp.
  */
 #ifndef __DT_BINDINGS_CLOCK_RENESAS_CPG_MSSR_H__
diff --git a/include/dt-bindings/clock/sprd,sc9860-clk.h b/include/dt-bindings/clock/sprd,sc9860-clk.h
index f2ab4631df0d..f1a1556451d3 100644
--- a/include/dt-bindings/clock/sprd,sc9860-clk.h
+++ b/include/dt-bindings/clock/sprd,sc9860-clk.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 //
 // Spreadtrum SC9860 platform clocks
 //
diff --git a/include/dt-bindings/clock/sun50i-h6-ccu.h b/include/dt-bindings/clock/sun50i-h6-ccu.h
index a1545cd60e75..9fd16b20765e 100644
--- a/include/dt-bindings/clock/sun50i-h6-ccu.h
+++ b/include/dt-bindings/clock/sun50i-h6-ccu.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
 /*
  * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
  */
diff --git a/include/dt-bindings/clock/sun8i-de2.h b/include/dt-bindings/clock/sun8i-de2.h
index 7768f73b051e..a9f7ea63e068 100644
--- a/include/dt-bindings/clock/sun8i-de2.h
+++ b/include/dt-bindings/clock/sun8i-de2.h
@@ -1,7 +1,7 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 /*
  * Copyright (C) 2016 Icenowy Zheng <icenowy@aosc.io>
  *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
 #ifndef _DT_BINDINGS_CLOCK_SUN8I_DE2_H_
diff --git a/include/dt-bindings/clock/suniv-ccu-f1c100s.h b/include/dt-bindings/clock/suniv-ccu-f1c100s.h
index f5ac155c9c70..edd3d7fa2933 100644
--- a/include/dt-bindings/clock/suniv-ccu-f1c100s.h
+++ b/include/dt-bindings/clock/suniv-ccu-f1c100s.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- *
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
  * Copyright (c) 2018 Icenowy Zheng <icenowy@aosc.xyz>
  *
  */
diff --git a/include/dt-bindings/gpio/meson-axg-gpio.h b/include/dt-bindings/gpio/meson-axg-gpio.h
index 25bb1fffa97a..17d49a0673f5 100644
--- a/include/dt-bindings/gpio/meson-axg-gpio.h
+++ b/include/dt-bindings/gpio/meson-axg-gpio.h
@@ -1,8 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 2017 Amlogic, Inc. All rights reserved.
  * Author: Xingyu Chen <xingyu.chen@amlogic.com>
  *
- * SPDX-License-Identifier: GPL-2.0+
  */
 
 #ifndef _DT_BINDINGS_MESON_AXG_GPIO_H
diff --git a/include/dt-bindings/media/xilinx-vip.h b/include/dt-bindings/media/xilinx-vip.h
index 94ed3edfcc70..6cb1a8c4689d 100644
--- a/include/dt-bindings/media/xilinx-vip.h
+++ b/include/dt-bindings/media/xilinx-vip.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Xilinx Video IP Core
  *
diff --git a/include/dt-bindings/power/owl-s500-powergate.h b/include/dt-bindings/power/owl-s500-powergate.h
index 0a1c451865ea..e261c9d91d9b 100644
--- a/include/dt-bindings/power/owl-s500-powergate.h
+++ b/include/dt-bindings/power/owl-s500-powergate.h
@@ -1,7 +1,7 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 /*
  * Copyright (c) 2017 Andreas Färber
  *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 #ifndef DT_BINDINGS_POWER_OWL_S500_POWERGATE_H
 #define DT_BINDINGS_POWER_OWL_S500_POWERGATE_H
diff --git a/include/dt-bindings/power/owl-s700-powergate.h b/include/dt-bindings/power/owl-s700-powergate.h
index 4cf1aefbf09c..90ec2944797d 100644
--- a/include/dt-bindings/power/owl-s700-powergate.h
+++ b/include/dt-bindings/power/owl-s700-powergate.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 /*
  * Actions Semi S700 SPS
  *
diff --git a/include/dt-bindings/power/r8a7744-sysc.h b/include/dt-bindings/power/r8a7744-sysc.h
index 8b6529778f98..200465b3251c 100644
--- a/include/dt-bindings/power/r8a7744-sysc.h
+++ b/include/dt-bindings/power/r8a7744-sysc.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2018 Renesas Electronics Corp.
  */
 #ifndef __DT_BINDINGS_POWER_R8A7744_SYSC_H__
diff --git a/include/dt-bindings/power/r8a77470-sysc.h b/include/dt-bindings/power/r8a77470-sysc.h
index 8bf4db187c31..38a54199cd19 100644
--- a/include/dt-bindings/power/r8a77470-sysc.h
+++ b/include/dt-bindings/power/r8a77470-sysc.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2018 Renesas Electronics Corp.
  */
 #ifndef __DT_BINDINGS_POWER_R8A77470_SYSC_H__
diff --git a/include/dt-bindings/power/r8a774a1-sysc.h b/include/dt-bindings/power/r8a774a1-sysc.h
index 580f431cd32e..0277eea6f114 100644
--- a/include/dt-bindings/power/r8a774a1-sysc.h
+++ b/include/dt-bindings/power/r8a774a1-sysc.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2018 Renesas Electronics Corp.
  */
 #ifndef __DT_BINDINGS_POWER_R8A774A1_SYSC_H__
diff --git a/include/dt-bindings/power/r8a774c0-sysc.h b/include/dt-bindings/power/r8a774c0-sysc.h
index 9922d4c6f87d..355dbc551243 100644
--- a/include/dt-bindings/power/r8a774c0-sysc.h
+++ b/include/dt-bindings/power/r8a774c0-sysc.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2018 Renesas Electronics Corp.
  */
 #ifndef __DT_BINDINGS_POWER_R8A774C0_SYSC_H__
diff --git a/include/dt-bindings/power/r8a77980-sysc.h b/include/dt-bindings/power/r8a77980-sysc.h
index e12c8587b87e..e5d24f80728e 100644
--- a/include/dt-bindings/power/r8a77980-sysc.h
+++ b/include/dt-bindings/power/r8a77980-sysc.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2018 Renesas Electronics Corp.
  * Copyright (C) 2018 Cogent Embedded, Inc.
  */
diff --git a/include/dt-bindings/reset/actions,s700-reset.h b/include/dt-bindings/reset/actions,s700-reset.h
index 5e3b16b8ef53..94eea2c299b1 100644
--- a/include/dt-bindings/reset/actions,s700-reset.h
+++ b/include/dt-bindings/reset/actions,s700-reset.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/* SPDX-License-Identifier: (GPL-2.0-or-later OR MIT) */
 //
 // Device Tree binding constants for Actions Semi S700 Reset Management Unit
 //
diff --git a/include/dt-bindings/reset/actions,s900-reset.h b/include/dt-bindings/reset/actions,s900-reset.h
index 42c19d02e43b..e733a70114c6 100644
--- a/include/dt-bindings/reset/actions,s900-reset.h
+++ b/include/dt-bindings/reset/actions,s900-reset.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/* SPDX-License-Identifier: (GPL-2.0-or-later OR MIT) */
 //
 // Device Tree binding constants for Actions Semi S900 Reset Management Unit
 //
diff --git a/include/dt-bindings/reset/amlogic,meson-axg-audio-arb.h b/include/dt-bindings/reset/amlogic,meson-axg-audio-arb.h
index 05c36367875c..537a6a4441a7 100644
--- a/include/dt-bindings/reset/amlogic,meson-axg-audio-arb.h
+++ b/include/dt-bindings/reset/amlogic,meson-axg-audio-arb.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: (GPL-2.0 OR MIT)
- *
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
  * Copyright (c) 2018 Baylibre SAS.
  * Author: Jerome Brunet <jbrunet@baylibre.com>
  */
diff --git a/include/dt-bindings/reset/amlogic,meson8b-clkc-reset.h b/include/dt-bindings/reset/amlogic,meson8b-clkc-reset.h
index 1f1b56e57346..7c359e6f7ec8 100644
--- a/include/dt-bindings/reset/amlogic,meson8b-clkc-reset.h
+++ b/include/dt-bindings/reset/amlogic,meson8b-clkc-reset.h
@@ -1,7 +1,7 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 /*
  * Copyright (c) 2017 Martin Blumenstingl <martin.blumenstingl@googlemail.com>.
  *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
 #ifndef _DT_BINDINGS_AMLOGIC_MESON8B_CLKC_RESET_H
diff --git a/include/dt-bindings/reset/sun50i-h6-ccu.h b/include/dt-bindings/reset/sun50i-h6-ccu.h
index 81106f455097..203eee3d6c7f 100644
--- a/include/dt-bindings/reset/sun50i-h6-ccu.h
+++ b/include/dt-bindings/reset/sun50i-h6-ccu.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
 /*
  * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
  */
diff --git a/include/dt-bindings/reset/sun8i-de2.h b/include/dt-bindings/reset/sun8i-de2.h
index 1c36a6ac86d6..157fd232756a 100644
--- a/include/dt-bindings/reset/sun8i-de2.h
+++ b/include/dt-bindings/reset/sun8i-de2.h
@@ -1,7 +1,7 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 /*
  * Copyright (C) 2016 Icenowy Zheng <icenowy@aosc.io>
  *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
 #ifndef _DT_BINDINGS_RESET_SUN8I_DE2_H_
diff --git a/include/dt-bindings/reset/suniv-ccu-f1c100s.h b/include/dt-bindings/reset/suniv-ccu-f1c100s.h
index 6a4b4385fe5a..fd227ed41206 100644
--- a/include/dt-bindings/reset/suniv-ccu-f1c100s.h
+++ b/include/dt-bindings/reset/suniv-ccu-f1c100s.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- *
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
  * Copyright (C) 2018 Icenowy Zheng <icenowy@aosc.xyz>
  *
  */
diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
index 3305ea7f9dc7..1416ef867067 100644
--- a/include/linux/arm_sdei.h
+++ b/include/linux/arm_sdei.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2017 Arm Ltd.
 #ifndef __LINUX_ARM_SDEI_H
 #define __LINUX_ARM_SDEI_H
diff --git a/include/linux/ascii85.h b/include/linux/ascii85.h
index 4cc40201273e..50310e471284 100644
--- a/include/linux/ascii85.h
+++ b/include/linux/ascii85.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * SPDX-License-Identifier: GPL-2.0
  *
  * Copyright (c) 2008 Intel Corporation
  * Copyright (c) 2018 The Linux Foundation. All rights reserved.
diff --git a/include/linux/atomic-fallback.h b/include/linux/atomic-fallback.h
index a7d240e465c0..01984831d56c 100644
--- a/include/linux/atomic-fallback.h
+++ b/include/linux/atomic-fallback.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 
 // Generated by scripts/atomic/gen-atomic-fallback.sh
 // DO NOT MODIFY THIS FILE DIRECTLY
diff --git a/include/linux/clk/davinci.h b/include/linux/clk/davinci.h
index 8a7b5cd7eac0..08d4a5d85674 100644
--- a/include/linux/clk/davinci.h
+++ b/include/linux/clk/davinci.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Clock drivers for TI DaVinci PLL and PSC controllers
  *
diff --git a/include/linux/clk/renesas.h b/include/linux/clk/renesas.h
index 0ebbe2f0b45e..c9f3cca72056 100644
--- a/include/linux/clk/renesas.h
+++ b/include/linux/clk/renesas.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * Copyright 2013 Ideas On Board SPRL
  * Copyright 2013, 2014 Horms Solutions Ltd.
  *
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 3b0ba54cc4d5..7020927e59ae 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  debugfs.h - a tiny little debug file system
  *
diff --git a/include/linux/device.h b/include/linux/device.h
index ae2657b067fe..a841407319f9 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * device.h - generic, centralized driver model
  *
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 666db8eb71e0..3d9b31d1bac9 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /**
  * include/linux/f2fs_fs.h
  *
diff --git a/include/linux/fsi-occ.h b/include/linux/fsi-occ.h
index d4cdc2aa6e33..d058febc23c9 100644
--- a/include/linux/fsi-occ.h
+++ b/include/linux/fsi-occ.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 
 #ifndef LINUX_FSI_OCC_H
 #define LINUX_FSI_OCC_H
diff --git a/include/linux/fsl/ptp_qoriq.h b/include/linux/fsl/ptp_qoriq.h
index f127adb71041..bd4fef9a2260 100644
--- a/include/linux/fsl/ptp_qoriq.h
+++ b/include/linux/fsl/ptp_qoriq.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2010 OMICRON electronics GmbH
  * Copyright 2018 NXP
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 2e8957eac4d4..5923edaf1215 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  hrtimers - High-resolution kernel timers
  *
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 1ab0d624fb36..a9d3ac291b85 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * kobject.h - generic kernel object infrastructure.
  *
diff --git a/include/linux/kobject_ns.h b/include/linux/kobject_ns.h
index 069aa2ebef90..e430cb2babba 100644
--- a/include/linux/kobject_ns.h
+++ b/include/linux/kobject_ns.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Kernel object name space definitions
  *
  * Copyright (c) 2002-2003 Patrick Mochel
diff --git a/include/linux/logic_pio.h b/include/linux/logic_pio.h
index cbd9d8495690..4672f168181d 100644
--- a/include/linux/logic_pio.h
+++ b/include/linux/logic_pio.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2017 HiSilicon Limited, All Rights Reserved.
  * Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
diff --git a/include/linux/mfd/madera/core.h b/include/linux/mfd/madera/core.h
index 4d5d51a9c8a6..75931f61dfd6 100644
--- a/include/linux/mfd/madera/core.h
+++ b/include/linux/mfd/madera/core.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * MFD internals for Cirrus Logic Madera codecs
  *
diff --git a/include/linux/mfd/madera/pdata.h b/include/linux/mfd/madera/pdata.h
index 8dc852402dbb..9b3b1a98ab12 100644
--- a/include/linux/mfd/madera/pdata.h
+++ b/include/linux/mfd/madera/pdata.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Platform data for Cirrus Logic Madera codecs
  *
diff --git a/include/linux/mfd/madera/registers.h b/include/linux/mfd/madera/registers.h
index 977e06101711..6dbd179d1a13 100644
--- a/include/linux/mfd/madera/registers.h
+++ b/include/linux/mfd/madera/registers.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Madera register definitions
  *
diff --git a/include/linux/mtd/sh_flctl.h b/include/linux/mtd/sh_flctl.h
index 78fc2d4218c8..8e30cfdd5473 100644
--- a/include/linux/mtd/sh_flctl.h
+++ b/include/linux/mtd/sh_flctl.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * SuperH FLCTL nand controller
  *
  * Copyright © 2008 Renesas Solutions Corp.
diff --git a/include/linux/nospec.h b/include/linux/nospec.h
index 0c5ef54fd416..4b7ddd99272d 100644
--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright(c) 2018 Linus Torvalds. All rights reserved.
 // Copyright(c) 2018 Alexei Starovoitov. All rights reserved.
 // Copyright(c) 2018 Intel Corporation. All rights reserved.
diff --git a/include/linux/nvme-tcp.h b/include/linux/nvme-tcp.h
index 03d87c0550a9..959e0bd9a913 100644
--- a/include/linux/nvme-tcp.h
+++ b/include/linux/nvme-tcp.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * NVMe over Fabrics TCP protocol header.
  * Copyright (c) 2018 Lightbits Labs. All rights reserved.
diff --git a/include/linux/platform_data/clk-da8xx-cfgchip.h b/include/linux/platform_data/clk-da8xx-cfgchip.h
index de0f77d38669..85b852beebae 100644
--- a/include/linux/platform_data/clk-da8xx-cfgchip.h
+++ b/include/linux/platform_data/clk-da8xx-cfgchip.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * clk-da8xx-cfgchip - TI DaVinci DA8xx CFGCHIP clock driver
  *
diff --git a/include/linux/platform_data/clk-davinci-pll.h b/include/linux/platform_data/clk-davinci-pll.h
index e55dab1d578b..10cd168edf3e 100644
--- a/include/linux/platform_data/clk-davinci-pll.h
+++ b/include/linux/platform_data/clk-davinci-pll.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * PLL clock driver for TI Davinci SoCs
  *
diff --git a/include/linux/platform_data/ehci-sh.h b/include/linux/platform_data/ehci-sh.h
index 219bd79dabfc..d8397df8c6ee 100644
--- a/include/linux/platform_data/ehci-sh.h
+++ b/include/linux/platform_data/ehci-sh.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * EHCI SuperH driver platform data
  *
  * Copyright (C) 2012  Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
diff --git a/include/linux/platform_data/phy-da8xx-usb.h b/include/linux/platform_data/phy-da8xx-usb.h
index 85c2b99381b2..4995b900ebd8 100644
--- a/include/linux/platform_data/phy-da8xx-usb.h
+++ b/include/linux/platform_data/phy-da8xx-usb.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * phy-da8xx-usb - TI DaVinci DA8xx USB PHY driver
  *
diff --git a/include/linux/pti.h b/include/linux/pti.h
index 1a941efcaa62..a202cb8d716a 100644
--- a/include/linux/pti.h
+++ b/include/linux/pti.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _INCLUDE_PTI_H
 #define _INCLUDE_PTI_H
 
diff --git a/include/linux/rslib.h b/include/linux/rslib.h
index 5974cedd008c..e9019aa1f330 100644
--- a/include/linux/rslib.h
+++ b/include/linux/rslib.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Generic Reed Solomon encoder / decoder library
  *
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 3105055c00a7..2be393abb7ed 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * SCMI Message Protocol driver header
  *
diff --git a/include/linux/shdma-base.h b/include/linux/shdma-base.h
index 6dfd05ef5c2d..bfa84de20161 100644
--- a/include/linux/shdma-base.h
+++ b/include/linux/shdma-base.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Dmaengine driver base library for DMA controllers, found on SH-based SoCs
  *
  * extracted from shdma.c and headers
diff --git a/include/linux/slimbus.h b/include/linux/slimbus.h
index 12c9719b2a55..d6d164a571f6 100644
--- a/include/linux/slimbus.h
+++ b/include/linux/slimbus.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2011-2017, The Linux Foundation
  */
diff --git a/include/linux/soc/actions/owl-sps.h b/include/linux/soc/actions/owl-sps.h
index 33d0dbeceb55..2a28eafa69cf 100644
--- a/include/linux/soc/actions/owl-sps.h
+++ b/include/linux/soc/actions/owl-sps.h
@@ -1,7 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 2017 Andreas Färber
  *
- * SPDX-License-Identifier: GPL-2.0+
  */
 #ifndef SOC_ACTIONS_OWL_SPS_H
 #define SOC_ACTIONS_OWL_SPS_H
diff --git a/include/linux/soc/qcom/qmi.h b/include/linux/soc/qcom/qmi.h
index 5efa2b67fa55..80fd1e6ce757 100644
--- a/include/linux/soc/qcom/qmi.h
+++ b/include/linux/soc/qcom/qmi.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2012-2014, The Linux Foundation. All rights reserved.
  * Copyright (c) 2017, Linaro Ltd.
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index 18435e5c6364..699666abe707 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Texas Instruments System Control Interface Protocol
  *
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index df313913e856..244d4e5c2d09 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
 // Copyright(c) 2015-17 Intel Corporation.
 
 #ifndef __SOUNDWIRE_H
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 2b9573b8aedd..13af513d118b 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
 // Copyright(c) 2015-17 Intel Corporation.
 
 #ifndef __SDW_INTEL_H
diff --git a/include/linux/soundwire/sdw_registers.h b/include/linux/soundwire/sdw_registers.h
index df472b1ab410..4150399436b0 100644
--- a/include/linux/soundwire/sdw_registers.h
+++ b/include/linux/soundwire/sdw_registers.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
 // Copyright(c) 2015-17 Intel Corporation.
 
 #ifndef __SDW_REGISTERS_H
diff --git a/include/linux/soundwire/sdw_type.h b/include/linux/soundwire/sdw_type.h
index 9fd553e553e9..c0d7d3f96735 100644
--- a/include/linux/soundwire/sdw_type.h
+++ b/include/linux/soundwire/sdw_type.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright(c) 2015-17 Intel Corporation.
 
 #ifndef __SOUNDWIRE_TYPES_H
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 662b336aa2e4..d1a4617931e9 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later
- *
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
  * Copyright (C) 2005 David Brownell
  */
 
diff --git a/include/linux/stm.h b/include/linux/stm.h
index c6f577ab6f21..38f6891e73e5 100644
--- a/include/linux/stm.h
+++ b/include/linux/stm.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * System Trace Module (STM) infrastructure apis
  * Copyright (C) 2014 Intel Corporation.
diff --git a/include/linux/usb/association.h b/include/linux/usb/association.h
index d7f3cb9b9db5..e6329af2d655 100644
--- a/include/linux/usb/association.h
+++ b/include/linux/usb/association.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Wireless USB - Cable Based Association
  *
diff --git a/include/linux/usb/audio-v2.h b/include/linux/usb/audio-v2.h
index ba4b3e3327ff..53f9dcd01120 100644
--- a/include/linux/usb/audio-v2.h
+++ b/include/linux/usb/audio-v2.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2010 Daniel Mack <daniel@caiaq.de>
  *
diff --git a/include/linux/usb/audio-v3.h b/include/linux/usb/audio-v3.h
index 6b708434b7f9..86829275eb92 100644
--- a/include/linux/usb/audio-v3.h
+++ b/include/linux/usb/audio-v3.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 2017 Ruslan Bilovol <ruslan.bilovol@gmail.com>
  *
diff --git a/include/linux/usb/audio.h b/include/linux/usb/audio.h
index 170acd500ea1..3d8dd662b254 100644
--- a/include/linux/usb/audio.h
+++ b/include/linux/usb/audio.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * <linux/usb/audio.h> -- USB Audio definitions.
  *
diff --git a/include/linux/usb/c67x00.h b/include/linux/usb/c67x00.h
index 2fc39e3b7281..5228321cca22 100644
--- a/include/linux/usb/c67x00.h
+++ b/include/linux/usb/c67x00.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * usb_c67x00.h: platform definitions for the Cypress C67X00 USB chip
  *
diff --git a/include/linux/usb/cdc-wdm.h b/include/linux/usb/cdc-wdm.h
index 9b895f93d8de..3eb66d13e9e3 100644
--- a/include/linux/usb/cdc-wdm.h
+++ b/include/linux/usb/cdc-wdm.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * USB CDC Device Management subdriver
  *
diff --git a/include/linux/usb/cdc.h b/include/linux/usb/cdc.h
index 35d784cf32a4..28808ace9728 100644
--- a/include/linux/usb/cdc.h
+++ b/include/linux/usb/cdc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * USB CDC common helpers
  *
diff --git a/include/linux/usb/cdc_ncm.h b/include/linux/usb/cdc_ncm.h
index 1646c06989df..4e25ea7b8af7 100644
--- a/include/linux/usb/cdc_ncm.h
+++ b/include/linux/usb/cdc_ncm.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
 /*
  * Copyright (C) ST-Ericsson 2010-2012
  * Contact: Alexey Orishko <alexey.orishko@stericsson.com>
diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.h
index 8675e145ea8b..878b7a9e9e19 100644
--- a/include/linux/usb/composite.h
+++ b/include/linux/usb/composite.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * composite.h -- framework for usb gadgets which are composite devices
  *
diff --git a/include/linux/usb/ehci_def.h b/include/linux/usb/ehci_def.h
index a15ce99dfc2d..6749905329a3 100644
--- a/include/linux/usb/ehci_def.h
+++ b/include/linux/usb/ehci_def.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 2001-2002 by David Brownell
  *
diff --git a/include/linux/usb/ehci_pdriver.h b/include/linux/usb/ehci_pdriver.h
index dd742afdc03f..21b64883dc7e 100644
--- a/include/linux/usb/ehci_pdriver.h
+++ b/include/linux/usb/ehci_pdriver.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2012 Hauke Mehrtens <hauke@hauke-m.de>
  *
diff --git a/include/linux/usb/g_hid.h b/include/linux/usb/g_hid.h
index 7581e488c237..bfd2cc296351 100644
--- a/include/linux/usb/g_hid.h
+++ b/include/linux/usb/g_hid.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * g_hid.h -- Header file for USB HID gadget driver
  *
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 7595056b96c1..e4af470cad5c 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * <linux/usb/gadget.h>
  *
diff --git a/include/linux/usb/gpio_vbus.h b/include/linux/usb/gpio_vbus.h
index 804fb06cf6d6..c26715138e22 100644
--- a/include/linux/usb/gpio_vbus.h
+++ b/include/linux/usb/gpio_vbus.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * A simple GPIO VBUS sensing driver for B peripheral only devices
  * with internal transceivers.
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 7dc3a411bece..4ab85a8f259b 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 2001-2002 by David Brownell
  *
diff --git a/include/linux/usb/input.h b/include/linux/usb/input.h
index 974befa72ac0..41d285cbaff9 100644
--- a/include/linux/usb/input.h
+++ b/include/linux/usb/input.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2005 Dmitry Torokhov
  *
diff --git a/include/linux/usb/isp1301.h b/include/linux/usb/isp1301.h
index dedb3b2473e8..b83746d46dad 100644
--- a/include/linux/usb/isp1301.h
+++ b/include/linux/usb/isp1301.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * NXP ISP1301 USB transceiver driver
  *
diff --git a/include/linux/usb/m66592.h b/include/linux/usb/m66592.h
index 2dfe68183495..3d3144869183 100644
--- a/include/linux/usb/m66592.h
+++ b/include/linux/usb/m66592.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * M66592 driver platform data
  *
diff --git a/include/linux/usb/musb-ux500.h b/include/linux/usb/musb-ux500.h
index c4b7ad9850ca..76d3c9e402da 100644
--- a/include/linux/usb/musb-ux500.h
+++ b/include/linux/usb/musb-ux500.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2013 ST-Ericsson AB
  *
diff --git a/include/linux/usb/net2280.h b/include/linux/usb/net2280.h
index 08b85caecfaf..70fcff25f54e 100644
--- a/include/linux/usb/net2280.h
+++ b/include/linux/usb/net2280.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * NetChip 2280 high/full speed USB device controller.
  * Unlike many such controllers, this one talks PCI.
diff --git a/include/linux/usb/of.h b/include/linux/usb/of.h
index dba55ccb9b53..3f60fb844ca5 100644
--- a/include/linux/usb/of.h
+++ b/include/linux/usb/of.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * OF helpers for usb devices.
  *
diff --git a/include/linux/usb/ohci_pdriver.h b/include/linux/usb/ohci_pdriver.h
index 7eb16cf587ee..31943a8c164d 100644
--- a/include/linux/usb/ohci_pdriver.h
+++ b/include/linux/usb/ohci_pdriver.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2012 Hauke Mehrtens <hauke@hauke-m.de>
  *
diff --git a/include/linux/usb/otg-fsm.h b/include/linux/usb/otg-fsm.h
index e78eb577d0fa..1a2d3c85f87c 100644
--- a/include/linux/usb/otg-fsm.h
+++ b/include/linux/usb/otg-fsm.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /* Copyright (C) 2007,2008 Freescale Semiconductor, Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
diff --git a/include/linux/usb/pd_ado.h b/include/linux/usb/pd_ado.h
index 9aa1cf31c93c..5873a49e5fdc 100644
--- a/include/linux/usb/pd_ado.h
+++ b/include/linux/usb/pd_ado.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 2017 Dialog Semiconductor
  *
diff --git a/include/linux/usb/pd_ext_sdb.h b/include/linux/usb/pd_ext_sdb.h
index 0eb83ce19597..f4a94aaf4ce0 100644
--- a/include/linux/usb/pd_ext_sdb.h
+++ b/include/linux/usb/pd_ext_sdb.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 2017 Dialog Semiconductor
  *
diff --git a/include/linux/usb/phy_companion.h b/include/linux/usb/phy_companion.h
index 407f530061cd..80886ac0931f 100644
--- a/include/linux/usb/phy_companion.h
+++ b/include/linux/usb/phy_companion.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * phy-companion.h -- phy companion to indicate the comparator part of PHY
  *
diff --git a/include/linux/usb/r8a66597.h b/include/linux/usb/r8a66597.h
index c0753d026bbf..c5bc7d547c74 100644
--- a/include/linux/usb/r8a66597.h
+++ b/include/linux/usb/r8a66597.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * R8A66597 driver platform data
  *
diff --git a/include/linux/usb/renesas_usbhs.h b/include/linux/usb/renesas_usbhs.h
index 53924f8e840c..9c16f0c8ea61 100644
--- a/include/linux/usb/renesas_usbhs.h
+++ b/include/linux/usb/renesas_usbhs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-1.0+
+/* SPDX-License-Identifier: GPL-1.0+ */
 /*
  * Renesas USB
  *
diff --git a/include/linux/usb/rndis_host.h b/include/linux/usb/rndis_host.h
index 809bccd08455..1b1338201ff9 100644
--- a/include/linux/usb/rndis_host.h
+++ b/include/linux/usb/rndis_host.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Host Side support for RNDIS Networking Links
  * Copyright (C) 2005 by David Brownell
diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
index edc51be4a77c..62af1dd0bab3 100644
--- a/include/linux/usb/role.h
+++ b/include/linux/usb/role.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 
 #ifndef __LINUX_USB_ROLE_H
 #define __LINUX_USB_ROLE_H
diff --git a/include/linux/usb/samsung_usb_phy.h b/include/linux/usb/samsung_usb_phy.h
index dc0071741695..d480e027aebd 100644
--- a/include/linux/usb/samsung_usb_phy.h
+++ b/include/linux/usb/samsung_usb_phy.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2012 Samsung Electronics Co.Ltd
  *		http://www.samsung.com/
diff --git a/include/linux/usb/serial.h b/include/linux/usb/serial.h
index 1c19f77ed541..e25bfd6ca14c 100644
--- a/include/linux/usb/serial.h
+++ b/include/linux/usb/serial.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * USB Serial Converter stuff
  *
diff --git a/include/linux/usb/storage.h b/include/linux/usb/storage.h
index e0240f864548..cfad57f818ca 100644
--- a/include/linux/usb/storage.h
+++ b/include/linux/usb/storage.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __LINUX_USB_STORAGE_H
 #define __LINUX_USB_STORAGE_H
 
diff --git a/include/linux/usb/tegra_usb_phy.h b/include/linux/usb/tegra_usb_phy.h
index 0c5c3ea8b2d7..05186214cb62 100644
--- a/include/linux/usb/tegra_usb_phy.h
+++ b/include/linux/usb/tegra_usb_phy.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2010 Google, Inc.
  *
diff --git a/include/linux/usb/typec_mux.h b/include/linux/usb/typec_mux.h
index 79293f630ee1..7df290e1a259 100644
--- a/include/linux/usb/typec_mux.h
+++ b/include/linux/usb/typec_mux.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 
 #ifndef __USB_TYPEC_MUX
 #define __USB_TYPEC_MUX
diff --git a/include/linux/usb/ulpi.h b/include/linux/usb/ulpi.h
index c515765adab7..e54c6ba88955 100644
--- a/include/linux/usb/ulpi.h
+++ b/include/linux/usb/ulpi.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * ulpi.h -- ULPI defines and function prorotypes
  *
diff --git a/include/linux/usb/usb338x.h b/include/linux/usb/usb338x.h
index 7189e3387bf9..13823cfdaf6a 100644
--- a/include/linux/usb/usb338x.h
+++ b/include/linux/usb/usb338x.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * USB 338x super/high/full speed USB device controller.
  * Unlike many such controllers, this one talks PCI.
diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
index d8860f2d0976..54f28c87ebb8 100644
--- a/include/linux/usb/usbnet.h
+++ b/include/linux/usb/usbnet.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * USB Networking Link Interface
  *
diff --git a/include/linux/usb/wusb-wa.h b/include/linux/usb/wusb-wa.h
index 64a840b5106e..ff15bbaf76ad 100644
--- a/include/linux/usb/wusb-wa.h
+++ b/include/linux/usb/wusb-wa.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Wireless USB Wire Adapter constants and structures.
  *
diff --git a/include/linux/usb/wusb.h b/include/linux/usb/wusb.h
index 9e4a3213f2c2..2483899c6ce6 100644
--- a/include/linux/usb/wusb.h
+++ b/include/linux/usb/wusb.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Wireless USB Standard Definitions
  * Event Size Tables
diff --git a/include/linux/usb/xhci-dbgp.h b/include/linux/usb/xhci-dbgp.h
index 0a37f1283bf0..a1a0313adab1 100644
--- a/include/linux/usb/xhci-dbgp.h
+++ b/include/linux/usb/xhci-dbgp.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Standalone xHCI debug capability driver
  *
diff --git a/include/linux/usbdevice_fs.h b/include/linux/usbdevice_fs.h
index 79aab0065ec8..056b78bb23f0 100644
--- a/include/linux/usbdevice_fs.h
+++ b/include/linux/usbdevice_fs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*****************************************************************************/
 
 /*
diff --git a/include/linux/visorbus.h b/include/linux/visorbus.h
index 0d8bd6769b13..758268ee83bc 100644
--- a/include/linux/visorbus.h
+++ b/include/linux/visorbus.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2010 - 2013 UNISYS CORPORATION
  * All rights reserved.
diff --git a/include/media/drv-intf/renesas-ceu.h b/include/media/drv-intf/renesas-ceu.h
index 52841d1b4763..db41f4c70d6f 100644
--- a/include/media/drv-intf/renesas-ceu.h
+++ b/include/media/drv-intf/renesas-ceu.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * renesas-ceu.h - Renesas CEU driver interface
  *
diff --git a/include/media/dvb_vb2.h b/include/media/dvb_vb2.h
index 8cb88452cd6c..e46e32f0ca3c 100644
--- a/include/media/dvb_vb2.h
+++ b/include/media/dvb_vb2.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * SPDX-License-Identifier: GPL-2.0
  *
  * dvb-vb2.h - DVB driver helper framework for streaming I/O
  *
diff --git a/include/media/i2c/mt9t112.h b/include/media/i2c/mt9t112.h
index cc80d5cc2104..61ae618eb58c 100644
--- a/include/media/i2c/mt9t112.h
+++ b/include/media/i2c/mt9t112.h
@@ -1,4 +1,4 @@
-/*  SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 */
 /* mt9t112 Camera
  *
  * Copyright (C) 2009 Renesas Solutions Corp.
diff --git a/include/media/media-request.h b/include/media/media-request.h
index bd36d7431698..620fa09c8b70 100644
--- a/include/media/media-request.h
+++ b/include/media/media-request.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Media device request objects
  *
diff --git a/include/misc/ocxl-config.h b/include/misc/ocxl-config.h
index 3526fa996a22..50e3fb0f7e2a 100644
--- a/include/misc/ocxl-config.h
+++ b/include/misc/ocxl-config.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 // Copyright 2017 IBM Corp.
 #ifndef _OCXL_CONFIG_H_
 #define _OCXL_CONFIG_H_
diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
index 9ff6ddc28e22..a10039f57b4c 100644
--- a/include/misc/ocxl.h
+++ b/include/misc/ocxl.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 // Copyright 2017 IBM Corp.
 #ifndef _MISC_OCXL_H_
 #define _MISC_OCXL_H_
diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index 694d055e01ef..87ab6ab8f308 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * page_pool.h
  *	Author:	Jesper Dangaard Brouer <netoptimizer@brouer.com>
  *	Copyright (C) 2016 Red Hat, Inc.
diff --git a/include/sound/ac97/codec.h b/include/sound/ac97/codec.h
index 9792d25fa369..df6427d33f9f 100644
--- a/include/sound/ac97/codec.h
+++ b/include/sound/ac97/codec.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  *  Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
  */
 
diff --git a/include/sound/ac97/compat.h b/include/sound/ac97/compat.h
index 57e19afa31ab..0e921b26c584 100644
--- a/include/sound/ac97/compat.h
+++ b/include/sound/ac97/compat.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  *  Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
  *
  * This file is for backward compatibility with snd_ac97 structure and its
diff --git a/include/sound/ac97/controller.h b/include/sound/ac97/controller.h
index 06b5afb7fa6b..736117634bbb 100644
--- a/include/sound/ac97/controller.h
+++ b/include/sound/ac97/controller.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
  */
 
diff --git a/include/sound/ac97/regs.h b/include/sound/ac97/regs.h
index 843f73f3705a..4645d7a674de 100644
--- a/include/sound/ac97/regs.h
+++ b/include/sound/ac97/regs.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  *  Copyright (c) by Jaroslav Kysela <perex@perex.cz>
  *  Universal interface for Audio Codec '97
  *
diff --git a/include/sound/ac97_codec.h b/include/sound/ac97_codec.h
index cc383991c0fe..d7df84099230 100644
--- a/include/sound/ac97_codec.h
+++ b/include/sound/ac97_codec.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  *  Copyright (c) by Jaroslav Kysela <perex@perex.cz>
  *  Universal interface for Audio Codec '97
  *
diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
index c5188ff724d1..8a95a426716d 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  *  compress_driver.h - compress offload driver definations
  *
  *  Copyright (C) 2011 Intel Corporation
diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index 2c4cfaa135a6..9f0349e38dd9 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  *  Copyright (C) 2012, Analog Devices Inc.
  *	Author: Lars-Peter Clausen <lars@metafoo.de>
  */
diff --git a/include/sound/hda_component.h b/include/sound/hda_component.h
index d4804c72d959..cf131a5af09e 100644
--- a/include/sound/hda_component.h
+++ b/include/sound/hda_component.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // HD-Audio helpers to sync with DRM driver
 
 #ifndef __SOUND_HDA_COMPONENT_H
diff --git a/include/sound/sh_fsi.h b/include/sound/sh_fsi.h
index 89eafe23ef88..51ce81b9fc35 100644
--- a/include/sound/sh_fsi.h
+++ b/include/sound/sh_fsi.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Fifo-attached Serial Interface (FSI) support for SH7724
  *
  * Copyright (C) 2009 Renesas Solutions Corp.
diff --git a/include/sound/simple_card.h b/include/sound/simple_card.h
index d264e5463f22..73689237b8fc 100644
--- a/include/sound/simple_card.h
+++ b/include/sound/simple_card.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * ASoC simple sound card support
  *
  * Copyright (C) 2012 Renesas Solutions Corp.
diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 7afe45389972..fc679a2d1850 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * simple_card_utils.h
  *
  * Copyright (c) 2016 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
diff --git a/include/sound/soc-acpi-intel-match.h b/include/sound/soc-acpi-intel-match.h
index bb5e1e4ce8bf..645f191fb798 100644
--- a/include/sound/soc-acpi-intel-match.h
+++ b/include/sound/soc-acpi-intel-match.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2017, Intel Corporation. All rights reserved.
  */
 
diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index 35b38e41e5b2..0b1599247448 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2013-15, Intel Corporation. All rights reserved.
  */
 
diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index f5d70041108f..405b3bf61302 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * linux/sound/soc-dai.h -- ALSA SoC Layer
  *
  * Copyright:	2005-2008 Wolfson Microelectronics. PLC.
diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index c00a0b8ade08..21e4975d0d53 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * linux/sound/soc-dapm.h -- ALSA SoC Dynamic Audio Power Management
  *
  * Author:	Liam Girdwood
diff --git a/include/sound/soc-dpcm.h b/include/sound/soc-dpcm.h
index 4be3a2b7c106..5f253830483e 100644
--- a/include/sound/soc-dpcm.h
+++ b/include/sound/soc-dpcm.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * linux/sound/soc-dpcm.h -- ALSA SoC Dynamic PCM Support
  *
  * Author:		Liam Girdwood <lrg@ti.com>
diff --git a/include/sound/soc-topology.h b/include/sound/soc-topology.h
index 5223896de26f..2915f096d487 100644
--- a/include/sound/soc-topology.h
+++ b/include/sound/soc-topology.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * linux/sound/soc-topology.h -- ALSA SoC Firmware Controls and DAPM
  *
  * Copyright (C) 2012 Texas Instruments Inc.
diff --git a/include/sound/soc.h b/include/sound/soc.h
index eb7db605955b..8ad66cca42e4 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * linux/sound/soc.h -- ALSA SoC Layer
  *
  * Author:	Liam Girdwood
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 08900828d282..c250cbefbc68 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 
 #ifndef _LINUX_KERNEL_TRACE_H
 #define _LINUX_KERNEL_TRACE_H
diff --git a/kernel/trace/trace_benchmark.h b/kernel/trace/trace_benchmark.h
index 79e6fbe5b365..be1d86ff753d 100644
--- a/kernel/trace/trace_benchmark.h
+++ b/kernel/trace/trace_benchmark.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM benchmark
 
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index 06bb2fd9a56c..1d67464ed95e 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * This file defines the trace event structures that go into the ring
  * buffer directly. They are created via macros so that changes for them
diff --git a/kernel/trace/trace_events_filter_test.h b/kernel/trace/trace_events_filter_test.h
index e651dfbd345e..39d7ef4f57cb 100644
--- a/kernel/trace/trace_events_filter_test.h
+++ b/kernel/trace/trace_events_filter_test.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM test
 
diff --git a/kernel/trace/trace_kprobe_selftest.h b/kernel/trace/trace_kprobe_selftest.h
index c4fc7268ba7c..4e10ec41c013 100644
--- a/kernel/trace/trace_kprobe_selftest.h
+++ b/kernel/trace/trace_kprobe_selftest.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Function used during the kprobe self test. This function is in a separate
  * compile unit so it can be compile with CC_FLAGS_FTRACE to ensure that it
diff --git a/kernel/trace/trace_output.h b/kernel/trace/trace_output.h
index 2f742b74e7e6..dbba03ed96de 100644
--- a/kernel/trace/trace_output.h
+++ b/kernel/trace/trace_output.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __TRACE_EVENTS_H
 #define __TRACE_EVENTS_H
 
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 8a63f8bc01bc..1a371fe58a07 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Common header file for probe-based Dynamic events.
  *
diff --git a/kernel/trace/trace_stat.h b/kernel/trace/trace_stat.h
index 8786d17caf49..76d30b4ebe83 100644
--- a/kernel/trace/trace_stat.h
+++ b/kernel/trace/trace_stat.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __TRACE_STAT_H
 #define __TRACE_STAT_H
 
diff --git a/kernel/trace/tracing_map.h b/kernel/trace/tracing_map.h
index a6de61fc22de..053eb92b2d31 100644
--- a/kernel/trace/tracing_map.h
+++ b/kernel/trace/tracing_map.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __TRACING_MAP_H
 #define __TRACING_MAP_H
 
diff --git a/mm/shuffle.h b/mm/shuffle.h
index c1e91ec118be..5afb1f27a21a 100644
--- a/mm/shuffle.h
+++ b/mm/shuffle.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright(c) 2018 Intel Corporation. All rights reserved.
 #ifndef _MM_SHUFFLE_H
 #define _MM_SHUFFLE_H
diff --git a/samples/bpf/hash_func01.h b/samples/bpf/hash_func01.h
index 38255812e376..f6bb56a7a38e 100644
--- a/samples/bpf/hash_func01.h
+++ b/samples/bpf/hash_func01.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: LGPL-2.1
- *
+/* SPDX-License-Identifier: LGPL-2.1 */
+/*
  * Based on Paul Hsieh's (LGPG 2.1) hash function
  * From: http://www.azillionmonkeys.com/qed/hash.html
  */
diff --git a/sound/soc/codecs/ak5558.h b/sound/soc/codecs/ak5558.h
index 61059086f161..2ed4c7cdc677 100644
--- a/sound/soc/codecs/ak5558.h
+++ b/sound/soc/codecs/ak5558.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Audio driver header for AK5558
  *
  * Copyright (C) 2016 Asahi Kasei Microdevices Corporation
diff --git a/sound/soc/codecs/max98373.h b/sound/soc/codecs/max98373.h
index f6a37aa02f26..5764db82bb26 100644
--- a/sound/soc/codecs/max98373.h
+++ b/sound/soc/codecs/max98373.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (c) 2017, Maxim Integrated
 
 #ifndef _MAX98373_H
diff --git a/sound/soc/codecs/pcm1789.h b/sound/soc/codecs/pcm1789.h
index c446d789ed48..3a797addf525 100644
--- a/sound/soc/codecs/pcm1789.h
+++ b/sound/soc/codecs/pcm1789.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Definitions for PCM1789 audio driver
 // Copyright (C) 2018 Bootlin
 // Mylène Josserand <mylene.josserand@bootlin.com>
diff --git a/sound/soc/codecs/pcm186x.h b/sound/soc/codecs/pcm186x.h
index bb3f0c42a1cd..36815a25071e 100644
--- a/sound/soc/codecs/pcm186x.h
+++ b/sound/soc/codecs/pcm186x.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Texas Instruments PCM186x Universal Audio ADC
  *
diff --git a/sound/soc/codecs/tas6424.h b/sound/soc/codecs/tas6424.h
index c67a7835ca66..2886b975b33f 100644
--- a/sound/soc/codecs/tas6424.h
+++ b/sound/soc/codecs/tas6424.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * ALSA SoC Texas Instruments TAS6424 Quad-Channel Audio Amplifier
  *
diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index 2636f2c6bc79..5d6bbff60eda 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * ALSA SoC TLV320AIC31xx CODEC Driver Definitions
  *
diff --git a/sound/soc/codecs/tscs42xx.h b/sound/soc/codecs/tscs42xx.h
index 6b3a21081635..a0310526c624 100644
--- a/sound/soc/codecs/tscs42xx.h
+++ b/sound/soc/codecs/tscs42xx.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // tscs42xx.h -- TSCS42xx ALSA SoC Audio driver
 // Copyright 2017 Tempo Semiconductor, Inc.
 // Author: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
diff --git a/sound/soc/codecs/tscs454.h b/sound/soc/codecs/tscs454.h
index 1142d73d3168..b7f0bc512c39 100644
--- a/sound/soc/codecs/tscs454.h
+++ b/sound/soc/codecs/tscs454.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // tscs454.h -- TSCS454 ALSA SoC Audio driver
 // Copyright 2018 Tempo Semiconductor, Inc.
 // Author: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
diff --git a/sound/soc/meson/axg-tdm-formatter.h b/sound/soc/meson/axg-tdm-formatter.h
index cf947caf3cb1..6c1d1d77e194 100644
--- a/sound/soc/meson/axg-tdm-formatter.h
+++ b/sound/soc/meson/axg-tdm-formatter.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: (GPL-2.0 OR MIT)
- *
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
  * Copyright (c) 2018 Baylibre SAS.
  * Author: Jerome Brunet <jbrunet@baylibre.com>
  */
diff --git a/sound/soc/meson/axg-tdm.h b/sound/soc/meson/axg-tdm.h
index e578b6f40a07..dc8025ee651a 100644
--- a/sound/soc/meson/axg-tdm.h
+++ b/sound/soc/meson/axg-tdm.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: (GPL-2.0 OR MIT)
- *
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
  * Copyright (c) 2018 Baylibre SAS.
  * Author: Jerome Brunet <jbrunet@baylibre.com>
  */
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 605e4b934982..bb544dc31270 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 //
 // Renesas R-Car
 //
diff --git a/sound/soc/sh/siu.h b/sound/soc/sh/siu.h
index 63a508fdfe78..bb99cf9a7f05 100644
--- a/sound/soc/sh/siu.h
+++ b/sound/soc/sh/siu.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 //
 // siu.h - ALSA SoC driver for Renesas SH7343, SH7722 SIU peripheral.
 //
diff --git a/sound/soc/sprd/sprd-pcm-dma.h b/sound/soc/sprd/sprd-pcm-dma.h
index d85a34f1461d..f2052f3fea1f 100644
--- a/sound/soc/sprd/sprd-pcm-dma.h
+++ b/sound/soc/sprd/sprd-pcm-dma.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 
 #ifndef __SPRD_PCM_DMA_H
 #define __SPRD_PCM_DMA_H
diff --git a/tools/include/tools/libc_compat.h b/tools/include/tools/libc_compat.h
index e907ba6f15e5..c9a4678c4c77 100644
--- a/tools/include/tools/libc_compat.h
+++ b/tools/include/tools/libc_compat.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (LGPL-2.0+ OR BSD-2-Clause)
+/* SPDX-License-Identifier: (LGPL-2.0+ OR BSD-2-Clause) */
 /* Copyright (C) 2018 Netronome Systems, Inc. */
 
 #ifndef __TOOLS_LIBC_COMPAT_H
diff --git a/tools/lib/traceevent/event-parse-local.h b/tools/lib/traceevent/event-parse-local.h
index 35833ee32d6c..99c88ba64ad7 100644
--- a/tools/lib/traceevent/event-parse-local.h
+++ b/tools/lib/traceevent/event-parse-local.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: LGPL-2.1
+/* SPDX-License-Identifier: LGPL-2.1 */
 /*
  * Copyright (C) 2009, 2010 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
  *
diff --git a/tools/lib/traceevent/trace-seq.h b/tools/lib/traceevent/trace-seq.h
index d68ec69f8d1a..41565ddf45c2 100644
--- a/tools/lib/traceevent/trace-seq.h
+++ b/tools/lib/traceevent/trace-seq.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: LGPL-2.1
+/* SPDX-License-Identifier: LGPL-2.1 */
 /*
  * Copyright (C) 2009, 2010 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
  *
diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
index 5df7ed9d9020..4539f5443b68 100644
--- a/tools/perf/include/bpf/bpf.h
+++ b/tools/perf/include/bpf/bpf.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _PERF_BPF_H
 #define _PERF_BPF_H
 
diff --git a/tools/perf/include/bpf/pid_filter.h b/tools/perf/include/bpf/pid_filter.h
index 6e61c4bdf548..a44ac7bddee5 100644
--- a/tools/perf/include/bpf/pid_filter.h
+++ b/tools/perf/include/bpf/pid_filter.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: LGPL-2.1
+/* SPDX-License-Identifier: LGPL-2.1 */
 
 #ifndef _PERF_BPF_PID_FILTER_
 #define _PERF_BPF_PID_FILTER_
diff --git a/tools/perf/include/bpf/stdio.h b/tools/perf/include/bpf/stdio.h
index 316af5b2ff35..a6e771a9fa2d 100644
--- a/tools/perf/include/bpf/stdio.h
+++ b/tools/perf/include/bpf/stdio.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 
 #include <bpf.h>
 
diff --git a/tools/perf/include/bpf/unistd.h b/tools/perf/include/bpf/unistd.h
index ca7877f9a976..7689f86d0230 100644
--- a/tools/perf/include/bpf/unistd.h
+++ b/tools/perf/include/bpf/unistd.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: LGPL-2.1
+/* SPDX-License-Identifier: LGPL-2.1 */
 
 #include <bpf.h>
 
diff --git a/tools/perf/util/cpu-set-sched.h b/tools/perf/util/cpu-set-sched.h
index 8cf4e40d322a..9a3d8b7e5068 100644
--- a/tools/perf/util/cpu-set-sched.h
+++ b/tools/perf/util/cpu-set-sched.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: LGPL-2.1
+/* SPDX-License-Identifier: LGPL-2.1 */
 // Definitions taken from glibc for use with older systems, same licensing.
 #ifndef _CPU_SET_SCHED_PERF_H
 #define _CPU_SET_SCHED_PERF_H
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 7e6a8850be4a..1f6ef76af3e7 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * SPDX-License-Identifier: GPL-2.0
  *
  * Copyright(C) 2015-2018 Linaro Limited.
  *
diff --git a/tools/perf/util/map_symbol.h b/tools/perf/util/map_symbol.h
index 5a1aed9f6bb4..532f0b967fb1 100644
--- a/tools/perf/util/map_symbol.h
+++ b/tools/perf/util/map_symbol.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __PERF_MAP_SYMBOL
 #define __PERF_MAP_SYMBOL 1
 
diff --git a/tools/testing/nvdimm/watermark.h b/tools/testing/nvdimm/watermark.h
index ed0528757bd4..23ab8a27fafe 100644
--- a/tools/testing/nvdimm/watermark.h
+++ b/tools/testing/nvdimm/watermark.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright(c) 2018 Intel Corporation. All rights reserved.
 #ifndef _TEST_NVDIMM_WATERMARK_H_
 #define _TEST_NVDIMM_WATERMARK_H_
diff --git a/tools/testing/selftests/bpf/netcnt_common.h b/tools/testing/selftests/bpf/netcnt_common.h
index 81084c1c2c23..0f360dd058cc 100644
--- a/tools/testing/selftests/bpf/netcnt_common.h
+++ b/tools/testing/selftests/bpf/netcnt_common.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __NETCNT_COMMON_H
 #define __NETCNT_COMMON_H
 
diff --git a/tools/testing/selftests/bpf/test_tcpbpf.h b/tools/testing/selftests/bpf/test_tcpbpf.h
index 7bcfa6207005..eae5cd19567f 100644
--- a/tools/testing/selftests/bpf/test_tcpbpf.h
+++ b/tools/testing/selftests/bpf/test_tcpbpf.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 
 #ifndef _TEST_TCPBPF_H
 #define _TEST_TCPBPF_H
diff --git a/tools/testing/selftests/bpf/test_tcpnotify.h b/tools/testing/selftests/bpf/test_tcpnotify.h
index 8b6cea030bfc..b2557e271767 100644
--- a/tools/testing/selftests/bpf/test_tcpnotify.h
+++ b/tools/testing/selftests/bpf/test_tcpnotify.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 
 #ifndef _TEST_TCPBPF_H
 #define _TEST_TCPBPF_H
diff --git a/tools/testing/selftests/powerpc/ptrace/child.h b/tools/testing/selftests/powerpc/ptrace/child.h
index d7275b7b33dc..7d2460db1443 100644
--- a/tools/testing/selftests/powerpc/ptrace/child.h
+++ b/tools/testing/selftests/powerpc/ptrace/child.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Helper functions to sync execution between parent and child processes.
  *
-- 
2.17.1

