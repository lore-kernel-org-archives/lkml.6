Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753084AbeBEBjx (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:39:53 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:43614 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752823AbeBEBhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:37:45 -0500
X-Google-Smtp-Source: AH8x226YMwPeYlGltTfs8anvfG9fo8eKZ8sXZlNS5kfoB8rpdW3CA8CKnLr3AdcCvElWs8u1sOuy+S+H6LQwsvnNDBM=
MIME-Version: 1.0
In-Reply-To: <20180205012146.23981-1-ulfalizer@gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Mon, 5 Feb 2018 02:37:43 +0100
Message-ID: <CAFkk2KQV3VHfuFfAc9+eJ_GUQeebbvCV==2CF_zbg6_Ht7ohOg@mail.gmail.com>
Subject: Re: [PATCH 00/20] Remove references to undefined symbols and fix two
 potential bugs
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        tfiga@chromium.org, paul.burton@mips.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>,
        Linus Walleij <linus.walleij@linaro.org>, vgupta@synopsys.com,
        mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com,
        robh@kernel.org, sboyd@codeaurora.org, paulus@ozlabs.org,
        will.deacon@arm.com, Tony Lindgren <tony@atomide.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 2:21 AM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
> Hello,
>
> This patchset fixes most references to globally undefined symbols in Kconfig
> files, as reported by the
> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
> script. I will send emails in reply to the patchset for some cases where I'm
> not sure what the proper fix is.
>
> All of the fixes are independent. I just created a patchset to track them more
> easily.
>
> Summary of changes:
>
>  - Commits 1 and 2 fix what looks like potential bugs: A broken (intended)
>    select of PL310_ERRATA_753970 for ARM/mvebu, and a misspelled dependency on
>    PPC_PSERIES in KVM/PPC.
>
>  - Commits 3-5 remove leftover AVR32 stuff.
>
>  - Commits 6 and 7 remove some selects of removed symbols from riscv.
>
>  - Commits 8-17 remove various references to removed symbols.
>
>  - Commits 18-20 fix some (harmless) malformed defaults.
>
> Ulf Magnusson (20):
>   ARM: mvebu: Fix broken PL310_ERRATA_753970 selects
>   KVM: PPC: Book3S PR: Fix broken select due to misspelling
>   kconfig: Remove leftover references to AVR32 symbol
>   misc: atmel: Remove CPU_AT32AP700X (AVR32) reference
>   rtc: at32ap700x: Remove PLATFORM_AT32AP dependency
>   riscv: Remove ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE select
>   riscv: Remove ARCH_WANT_OPTIONAL_GPIOLIB select
>   s390/kconfig: Remove ARCH_WANTS_PROT_NUMA_PROT_NONE select
>   clk: sunxi-ng: Remove SUNXI_CCU_* selects
>   lib/Kconfig: Remove leftover select of GENERIC_IO
>   usb: gadget: udc: Remove USB_GADGET_DUALSPEED select
>   ARM: debug: Remove ARCH_MSM dep. from UNCOMPRESS_INCLUDE
>   ore: Remove PNFS_OBJLAYOUT dependency
>   iio: gyro: mpu3050: Remove INPUT_MPU3050 dep. from I2C
>   phy: Remove SOC_EXYNOS4212 dep. from PHY_EXYNOS4X12_USB
>   auxdisplay: img-ascii-lcd: Remove MIPS_SEAD3 dep.
>   media: sec: Remove PLAT_S5P dependency
>   iwlwifi: fix malformed CONFIG_IWLWIFI_PCIE_RTPM default
>   ARC: Fix malformed ARC_EMUL_UNALIGNED default
>   x86/PCI: VMD: Fix malformed default
>
>  arch/arc/Kconfig                           |  1 -
>  arch/arm/Kconfig.debug                     |  2 +-
>  arch/arm/mach-mvebu/Kconfig                |  4 ++--
>  arch/powerpc/kvm/Kconfig                   |  2 +-
>  arch/riscv/Kconfig                         |  2 --
>  arch/s390/Kconfig                          |  1 -
>  drivers/auxdisplay/Kconfig                 |  2 +-
>  drivers/clk/sunxi-ng/Kconfig               |  7 -------
>  drivers/cpufreq/Kconfig                    | 10 ----------
>  drivers/iio/gyro/Kconfig                   |  1 -
>  drivers/media/platform/Kconfig             |  2 +-
>  drivers/misc/Kconfig                       |  1 -
>  drivers/net/wireless/intel/iwlwifi/Kconfig |  1 -
>  drivers/pci/host/Kconfig                   |  1 -
>  drivers/phy/samsung/Kconfig                |  2 +-
>  drivers/pwm/Kconfig                        |  2 +-
>  drivers/rtc/Kconfig                        |  2 +-
>  drivers/spi/Kconfig                        |  2 +-
>  drivers/usb/gadget/udc/Kconfig             |  1 -
>  drivers/video/console/Kconfig              |  2 +-
>  fs/exofs/Kconfig.ore                       |  2 +-
>  lib/Kconfig                                |  1 -
>  22 files changed, 12 insertions(+), 39 deletions(-)
>
> --
> 2.14.1
>

Since 05a4a9527931 ("kernel/watchdog: split up config options"),
lib/Kconfig.debug references a globally undefined symbol
HARDLOCK_DETECTOR_ARCH. My guess is that it was supposed to be defined
alongside HARDLOCK_DETECTOR_PERF in the same file.

Cheers,
Ulf
