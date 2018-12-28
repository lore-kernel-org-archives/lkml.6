Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEFCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A052820869
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMl+2IDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbeL1TSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 14:18:14 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39011 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbeL1TSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 14:18:14 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so19433337ljh.6;
        Fri, 28 Dec 2018 11:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hGM638D2mzXMZSxBmemBa014SEojd7L9erJCWnTP95o=;
        b=rMl+2IDc/f2iBC6rh5TrHA8jOxcetIymFtR2arF/Y0If6XVLJNr8c5deM/x6ub4xp2
         PmkrRMc+8JSVWQMLVaUtxdna7nX7SVUJP3XCiP8SgV3S8GEYgOkm8bVzxH/05wPFTZ27
         AzPgUw42VtdtjPOgNATRkvFPCnMuCUqAiRDBKcXb1wPxW9n5gRaKLYOtQwSs1qVAhYwk
         iGwYj6n82HUfIQwHW/RpWhFEN1a4JbO4ai9toun2VGix4STE/Kh2HDseKAH8rI9ijcrY
         +NkFA2qugYVCnZNM56xgY5vpBPsG6OK8axHjQzDDxE7LpDLoliPDI1h97hLXJxp9lQXj
         ds6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hGM638D2mzXMZSxBmemBa014SEojd7L9erJCWnTP95o=;
        b=oIj1t2rnKYMNkGcOM2DqWxqW7V79I1pckhjce5k8rlLxkjUVYRlpaR7Q3PwFiShYrM
         8whf25dQcx/Hj4N74faogdFoRH5hq0UzfBXsw8drvwE550F8dfJnxs86m3NV5rcLiiUS
         aPirC6HwcEtcwqrE/j7bVhsqh5pLu2r7Ul8PaBYqjgdmLD4XTNTfY24VKWLUJox1tPdT
         wzvoGGTLSS9sTIHM3W3LRu1K4KPRh9Hb6pRojmcZSMm1O15GaJRIIsqtXfdmaLD0fMwZ
         EeDrlIS/N4WDTVjMbWK0p6QWRcNkQt/i9opqPH83i1Wc+d5Se6lFQSbwwOk1dhEht9f2
         FqyA==
X-Gm-Message-State: AJcUukfE8q1g1oHQw1TNNT8YFZUNrM2DsHRQ2AYVXdYcat5tVo3MEprH
        NfH5anM4Rcz2o71L4cmMdnG9UOBZfsNnuJk+nNCQvCP+vF4=
X-Google-Smtp-Source: ALg8bN77KkgPEHgwHdP6gQQEgnFYOFUpO9fJ83e2fXOn+ffKwiFagtHuiHnbUwWY+BlzAFlhFikEIY78YON3hc7I3AY=
X-Received: by 2002:a2e:8945:: with SMTP id b5-v6mr13641352ljk.55.1546024687297;
 Fri, 28 Dec 2018 11:18:07 -0800 (PST)
MIME-Version: 1.0
References: <20181226232258.GA23526@syn-yoga530>
In-Reply-To: <20181226232258.GA23526@syn-yoga530>
From:   Elie Morisse <syniurge@gmail.com>
Date:   Fri, 28 Dec 2018 16:17:55 -0300
Message-ID: <CAC_JBqpJ__Vsb5cLrpzjYXv9XERUrm5ATmoBBHQY+6P52EYdLA@mail.gmail.com>
Subject: Re: [PATCH v15] i2c: Add drivers for the AMD PCIe MP2 I2C controller
To:     linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        Shyam-sundar.S-k@amd.com, sandeep.singh@amd.com,
        linux-kernel@vger.kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>, helgaas@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Nehal isn't responding, while the end of the merge window is closing
in. I addressed his last requests, will this get merged?

Elie

Le mer. 26 d=C3=A9c. 2018 =C3=A0 20:23, Elie Morisse <syniurge@gmail.com> a=
 =C3=A9crit :
>
> MP2 controllers have two separate busses, so may accommodate up to two I2=
C
> adapters. Those adapters are listed in the ACPI namespace with the
> "AMDI0011" HID, and probed by a platform driver.
>
> Communication with the MP2 takes place through MMIO registers, or through
> DMA for more than 32 bytes transfers.
>
> This is major rework of the patch submitted by Nehal-bakulchandra Shah fr=
om
> AMD (https://patchwork.kernel.org/patch/10597369/).
>
> Most of the event handling of v3 was rewritten to make it work with more
> than one bus (e.g on Ryzen-based Lenovo Yoga 530), and this version
> contains many other improvements.
>
> Signed-off-by: Elie Morisse <syniurge@gmail.com>
> ---
> Changes since v1 (https://www.spinics.net/lists/linux-i2c/msg34650.html):
> -> Add fix for IOMMU
> -> Add dependency of ACPI
> -> Add locks to avoid the crash
>
> Changes since v2 (https://patchwork.ozlabs.org/patch/961270/):
>
> -> fix for review comments
> -> fix for more than 32 bytes write issue
>
> Changes since v3 (https://patchwork.kernel.org/patch/10597369/) by Elie M=
.:
>
> -> support more than one bus/adapter
> -> support more than one slave per bus
> -> use the bus speed specified by the slaves declared in the DSDT instead=
 of
>    assuming speed =3D=3D 400kbits/s
> -> instead of kzalloc'ing a buffer for every less than 32 bytes reads, si=
mply
>    use i2c_msg.buf
> -> fix buffer overreads/overflows when (<=3D32 bytes) message lengths are=
n't a
>    multiple of 4 by using memcpy_fromio and memcpy_toio
> -> use streaming DMA mappings instead of allocating a coherent DMA buffer=
 for
>    every >32 bytes read/write
> -> properly check for timeouts during i2c_amd_xfer and increase it from 5=
0
>    jiffies to 250 msecs (which is more in line with other drivers)
> -> complete amd_i2c_dev.msg even if the device doesn't return a xxx_succe=
ss
>    event, instead of stalling i2c_amd_xfer
> -> removed the spinlock and mdelay during i2c_amd_pci_configure, I didn't=
 see
>    the point since it's already waiting for a i2c_busenable_complete even=
t
> -> add an adapter-specific mutex lock for i2c_amd_xfer, since we don't wa=
nt
>    parallel calls writing to AMD_C2P_MSG0 (or AMD_C2P_MSG1)
> -> add a global mutex lock for registers AMD_C2P_MSG2 to AMD_C2P_MSG9,  w=
hich
>    are shared across the two busses/adapters
> -> add MODULE_DEVICE_TABLE to automatically load i2c-amd-platdrv if the D=
SDT
>    enumerates devices with the "AMDI0011" HID
> -> set maximum length of reads/writes to 4095 (event's length field is 12=
 bits)
> -> basic PM support
> -> style corrections to match the kernel code style, and tried to reduce =
code
>    duplication whenever possible
>
> Changes since v4 by Elie M.:
>
> -> fix missing typecast warning
> -> removed the duplicated entry in Kconfig
>
> Changes since v5 by Elie M.:
>
> -> move DMA mapping from the platform driver to the PCI driver
> -> attempt to find the platform device's PCI parent through the _DEP ACPI=
 method
>    (if not found take the first MP2 device registred in the i2c-amd-pci-m=
p2
>    driver, like before)
> -> do not assume anymore that the PCI device is owned by the i2c-amd-pci-=
mp2
>    driver
> -> address other review comments by Bjorn Helgaas (meant for v3)
>
> Changes since v6 by Elie M.:
>
> -> remove unnecessary memcpy from the DMA buffer during i2c_amd_read_comp=
letion
>
> Changes since v7 by Elie M.:
>
> -> merge the two modules into one named i2c-amd-mp2, delete now useless e=
xports
> -> unlock the C2P mutex if i2c_amd_xfer_msg timeouts, to prevent stalling=
 the
>    MP2 controller if a slave doesn't respond to a read or write request
> -> unmap the DMA buffer before read/write_complete
> -> fix bus_disable commands handling (no more errors during module exit)
> -> prefer managed versions of pci_ and dev_ functions whenever possible
> -> increase adapter retries from 0 to 3
> -> reduce code duplication in debugfs functions
> -> address other review points by Bjorn Helgaas (except regarding the _DE=
P
>    hint)
>
> Changes since v8 by Elie M.:
>
> -> remove mostly redundant amd_i2c_rw_config, refer to i2c_msg whenever
> possible
> -> use i2c_get_dma_safe_msg_buf and i2c_put_dma_safe_msg_buf
> -> defer probe() by the platform driver if no MP2 device has been probed
> yet by the PCI driver (which should address Bjorn Helgaas' concern while
> preserving the platform driver)
> -> if the interrupt following a command doesn't get handled after 250ms,
> zero AMD_P2C_MSG_INTEN to prevent the MP2 from stalling for a few more
> seconds
> -> include AMD_P2C_MSG3 and fix typo in debugfs output
> -> cosmetic fixes, code reduction, and better comments
> -> add Nehal Shah and Shyam Sundar S K from AMD to the list of maintainer=
s
>
> Changes since v9 by Elie M.:
>
> -> remove the xfer_lock mutex which was redundant with i2c_adapter.bus_lo=
ck
> -> platform device remove() fixes (protection against the very unlikely
> case that both the PCI and platform devices get detached manually and
> simultaneously)
> -> fix manually unbinding the PCI device and then rebinding, there was an
> interrupt that wouldn't get serviced and thus the line got disabled
> -> look for the MP2 device corresponding to an AMDI0011 ACPI device in
> every device enumerated by _DEP, not just the first one
> -> set i2c_adapter.nr to pdev->id and call i2c_add_numbered_adapter()
> -> add Documentation/i2c/busses/ entry
> -> minor enhancements
>
> Changes since v10 by Elie M.:
>
> -> runtime PM support
> -> synchronisation fixes for <=3D32 bytes reads/writes through C2P regist=
ers,
> no more timeouts or "irq: nobody cared" errors on Lenovo Ideapad 530s
> -> remove the isr spinlock, not needed since isr aren't re-entrant
> -> remove the delayed_work field, make the isr complete .cmd_complete
> directly
> -> xfer now returns -EIO if the MP2 response isn't the expected one
> -> check that the adapter still exists at the beginning of xfer
> -> less code duplication in amd_mp2_read/write
> -> better names (bus_xnable =3D> bus_enable_set, _msg =3D> _cmd) and othe=
r
> minor enhancements
>
> Changes since v11 by Elie M.:
>
> -> remove the ACPI _DEP hint, Nehal from AMD said that there's no plan to
> have more than one MP2 device per system and this wasn't _DEP's purpose
> -> use device links between the two drivers to simplify the .remove logic
> -> do not hardcode the i2c adapter timeout
> -> code reduction and comment fixes
>
> Changes since v12 by Elie M.:
>
> -> fix the two warnings by the kbuild test bot
>
> Changes since v13 by Elie M., requested by Nehal Shah from AMD:
>
> -> split the i2c-amd-mp2 module back into two, i2c-amd-mp2-pci and
> i2c-amd-mp2-plat
> -> move DMA mapping back into the platform driver
>
> Changes since v14 by Elie M.:
>
> -> fix build failure if CONFIG_PM isn't defined
>
>  Documentation/i2c/busses/i2c-amd-mp2  |  24 +
>  MAINTAINERS                           |   8 +
>  drivers/i2c/busses/Kconfig            |  21 +
>  drivers/i2c/busses/Makefile           |   2 +
>  drivers/i2c/busses/i2c-amd-mp2-pci.c  | 650 ++++++++++++++++++++++++++
>  drivers/i2c/busses/i2c-amd-mp2-plat.c | 392 ++++++++++++++++
>  drivers/i2c/busses/i2c-amd-mp2.h      | 223 +++++++++
>  7 files changed, 1320 insertions(+)
>  create mode 100644 Documentation/i2c/busses/i2c-amd-mp2
>  create mode 100644 drivers/i2c/busses/i2c-amd-mp2-pci.c
>  create mode 100644 drivers/i2c/busses/i2c-amd-mp2-plat.c
>  create mode 100644 drivers/i2c/busses/i2c-amd-mp2.h
>
> diff --git a/Documentation/i2c/busses/i2c-amd-mp2 b/Documentation/i2c/bus=
ses/i2c-amd-mp2
> new file mode 100644
> index 000000000000..4b3d4b804413
> --- /dev/null
> +++ b/Documentation/i2c/busses/i2c-amd-mp2
> @@ -0,0 +1,24 @@
> +Kernel driver i2c-amd-mp2
> +
> +Supported adapters:
> +  * AMD MP2 PCIe interface
> +
> +Datasheet: not publicly available.
> +
> +Authors:
> +       Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> +       Nehal Shah <nehal-bakulchandra.shah@amd.com>
> +       Elie Morisse <syniurge@gmail.com>
> +
> +Description
> +-----------
> +
> +The MP2 is an ARM processor programmed as an I2C controller and communic=
ating
> +with the x86 host through PCI.
> +
> +If you see something like this:
> +
> +03:00.7 Non-VGA unclassified device: Advanced Micro Devices, Inc. [AMD] =
Device
> +                                                                       1=
5e6
> +
> +in your 'lspci -v', then this driver is for your device.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d27401df091f..76f8b3c40132 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -808,6 +808,14 @@ F: drivers/gpu/drm/amd/include/vi_structs.h
>  F:     drivers/gpu/drm/amd/include/v9_structs.h
>  F:     include/uapi/linux/kfd_ioctl.h
>
> +AMD MP2 I2C DRIVER
> +M:     Elie Morisse <syniurge@gmail.com>
> +M:     Nehal Shah <nehal-bakulchandra.shah@amd.com>
> +M:     Shyam Sundar S K <shyam-sundar.s-k@amd.com>
> +L:     linux-i2c@vger.kernel.org
> +S:     Maintained
> +F:     drivers/i2c/busses/i2c-amd-mp2*
> +
>  AMD POWERPLAY
>  M:     Rex Zhu <rex.zhu@amd.com>
>  M:     Evan Quan <evan.quan@amd.com>
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index f2c681971201..ef7617dd5d01 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -77,6 +77,27 @@ config I2C_AMD8111
>           This driver can also be built as a module.  If so, the module
>           will be called i2c-amd8111.
>
> +config I2C_AMD_MP2_PCI
> +       tristate "AMD MP2 PCIe"
> +       depends on PCI
> +       help
> +         If you say yes to this option, support will be included for the=
 AMD
> +         MP2 PCIe I2C adapter.
> +
> +         This driver can also be built as a module.  If so, the module
> +         will be called i2c-amd-mp2-pci.
> +
> +config I2C_AMD_MP2_PLATFORM
> +       tristate "AMD MP2 Platform"
> +       select I2C_AMD_MP2_PCI
> +       depends on ACPI
> +       help
> +         If you say yes to this option, support will be included for the=
 AMD
> +         MP2 I2C adapter.
> +
> +         This driver can also be built as a module.  If so, the module
> +         will be called i2c-amd-mp2-plat.
> +
>  config I2C_HIX5HD2
>         tristate "Hix5hd2 high-speed I2C driver"
>         depends on ARCH_HISI || ARCH_HIX5HD2 || COMPILE_TEST
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 5f0cb6915969..4fa829dccf68 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -33,6 +33,8 @@ obj-$(CONFIG_I2C_POWERMAC)    +=3D i2c-powermac.o
>
>  # Embedded system I2C/SMBus host controller drivers
>  obj-$(CONFIG_I2C_ALTERA)       +=3D i2c-altera.o
> +obj-$(CONFIG_I2C_AMD_MP2_PCI)  +=3D i2c-amd-mp2-pci.o
> +obj-$(CONFIG_I2C_AMD_MP2_PLATFORM)     +=3D i2c-amd-mp2-plat.o
>  obj-$(CONFIG_I2C_ASPEED)       +=3D i2c-aspeed.o
>  obj-$(CONFIG_I2C_AT91)         +=3D i2c-at91.o
>  obj-$(CONFIG_I2C_AU1550)       +=3D i2c-au1550.o
> diff --git a/drivers/i2c/busses/i2c-amd-mp2-pci.c b/drivers/i2c/busses/i2=
c-amd-mp2-pci.c
> new file mode 100644
> index 000000000000..3abbb673acd3
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-amd-mp2-pci.c
> @@ -0,0 +1,650 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/*
> + * AMD MP2 PCIe communication driver
> + *
> + * Authors: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> + *          Elie Morisse <syniurge@gmail.com>
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +
> +#include "i2c-amd-mp2.h"
> +
> +#define DRIVER_NAME    "i2c_amd_mp2"
> +#define DRIVER_DESC    "AMD(R) PCI-E MP2 I2C Controller Driver"
> +#define DRIVER_VER     "1.0"
> +
> +static inline void write64(u64 val, void __iomem *mmio)
> +{
> +       writel(val, mmio);
> +       writel(val >> 32, mmio + sizeof(u32));
> +}
> +
> +static inline u64 read64(void __iomem *mmio)
> +{
> +       u64 low, high;
> +
> +       low =3D readl(mmio);
> +       high =3D readl(mmio + sizeof(u32));
> +       return low | (high << 32);
> +}
> +
> +static void amd_mp2_c2p_mutex_lock(struct amd_i2c_common *i2c_common)
> +{
> +       struct amd_mp2_dev *privdata =3D i2c_common->mp2_dev;
> +
> +       /* there is only one data mailbox for two i2c adapters */
> +       mutex_lock(&privdata->c2p_lock);
> +       privdata->c2p_lock_busid =3D i2c_common->bus_id;
> +}
> +
> +static void amd_mp2_c2p_mutex_unlock(struct amd_i2c_common *i2c_common)
> +{
> +       struct amd_mp2_dev *privdata =3D i2c_common->mp2_dev;
> +
> +       if (unlikely(privdata->c2p_lock_busid !=3D i2c_common->bus_id)) {
> +               dev_warn(ndev_dev(privdata),
> +                        "bus %d attempting to unlock C2P locked by bus %=
d\n",
> +                        i2c_common->bus_id, privdata->c2p_lock_busid);
> +               return;
> +       }
> +
> +       mutex_unlock(&privdata->c2p_lock);
> +}
> +
> +static int amd_mp2_cmd(struct amd_i2c_common *i2c_common,
> +                      union i2c_cmd_base i2c_cmd_base)
> +{
> +       struct amd_mp2_dev *privdata =3D i2c_common->mp2_dev;
> +       void __iomem *reg;
> +
> +       i2c_common->reqcmd =3D i2c_cmd_base.s.i2c_cmd;
> +
> +       reg =3D privdata->mmio + ((i2c_cmd_base.s.bus_id =3D=3D 1) ?
> +                               AMD_C2P_MSG1 : AMD_C2P_MSG0);
> +       writel(i2c_cmd_base.ul, reg);
> +
> +       return 0;
> +}
> +
> +int amd_mp2_bus_enable_set(struct amd_i2c_common *i2c_common, bool enabl=
e)
> +{
> +       struct amd_mp2_dev *privdata =3D i2c_common->mp2_dev;
> +       union i2c_cmd_base i2c_cmd_base;
> +
> +       dev_dbg(ndev_dev(privdata), "%s id: %d\n", __func__,
> +               i2c_common->bus_id);
> +
> +       i2c_cmd_base.ul =3D 0;
> +       i2c_cmd_base.s.i2c_cmd =3D enable ? i2c_enable : i2c_disable;
> +       i2c_cmd_base.s.bus_id =3D i2c_common->bus_id;
> +       i2c_cmd_base.s.i2c_speed =3D i2c_common->i2c_speed;
> +
> +       amd_mp2_c2p_mutex_lock(i2c_common);
> +
> +       return amd_mp2_cmd(i2c_common, i2c_cmd_base);
> +}
> +EXPORT_SYMBOL_GPL(amd_mp2_bus_enable_set);
> +
> +static void amd_mp2_cmd_rw_fill(struct amd_i2c_common *i2c_common,
> +                               union i2c_cmd_base *i2c_cmd_base,
> +                               enum i2c_cmd reqcmd)
> +{
> +       i2c_cmd_base->s.i2c_cmd =3D reqcmd;
> +       i2c_cmd_base->s.bus_id =3D i2c_common->bus_id;
> +       i2c_cmd_base->s.i2c_speed =3D i2c_common->i2c_speed;
> +       i2c_cmd_base->s.slave_addr =3D i2c_common->msg->addr;
> +       i2c_cmd_base->s.length =3D i2c_common->msg->len;
> +}
> +
> +static int amd_mp2_rw(struct amd_i2c_common *i2c_common, enum i2c_cmd re=
qcmd)
> +{
> +       struct amd_mp2_dev *privdata =3D i2c_common->mp2_dev;
> +       union i2c_cmd_base i2c_cmd_base;
> +
> +       amd_mp2_cmd_rw_fill(i2c_common, &i2c_cmd_base, reqcmd);
> +       amd_mp2_c2p_mutex_lock(i2c_common);
> +
> +       if (i2c_common->msg->len <=3D 32) {
> +               i2c_cmd_base.s.mem_type =3D use_c2pmsg;
> +               if (reqcmd =3D=3D i2c_write)
> +                       memcpy_toio(privdata->mmio + AMD_C2P_MSG2,
> +                                   i2c_common->msg->buf,
> +                                   i2c_common->msg->len);
> +       } else {
> +               i2c_cmd_base.s.mem_type =3D use_dram;
> +               write64((u64)i2c_common->dma_addr,
> +                       privdata->mmio + AMD_C2P_MSG2);
> +       }
> +
> +       return amd_mp2_cmd(i2c_common, i2c_cmd_base);
> +}
> +
> +int amd_mp2_read(struct amd_i2c_common *i2c_common)
> +{
> +       struct amd_mp2_dev *privdata =3D i2c_common->mp2_dev;
> +
> +       dev_dbg(ndev_dev(privdata), "%s addr: %x id: %d\n", __func__,
> +               i2c_common->msg->addr, i2c_common->bus_id);
> +
> +       return amd_mp2_rw(i2c_common, i2c_read);
> +}
> +EXPORT_SYMBOL_GPL(amd_mp2_read);
> +
> +int amd_mp2_write(struct amd_i2c_common *i2c_common)
> +{
> +       struct amd_mp2_dev *privdata =3D i2c_common->mp2_dev;
> +
> +       dev_dbg(ndev_dev(privdata), "%s addr: %x id: %d\n", __func__,
> +               i2c_common->msg->addr, i2c_common->bus_id);
> +
> +       return amd_mp2_rw(i2c_common, i2c_write);
> +}
> +EXPORT_SYMBOL_GPL(amd_mp2_write);
> +
> +static void amd_mp2_pci_check_rw_event(struct amd_i2c_common *i2c_common=
)
> +{
> +       struct amd_mp2_dev *privdata =3D i2c_common->mp2_dev;
> +       int len =3D i2c_common->eventval.r.length;
> +       u32 slave_addr =3D i2c_common->eventval.r.slave_addr;
> +       bool err =3D false;
> +
> +       if (unlikely(len !=3D i2c_common->msg->len)) {
> +               dev_err(ndev_dev(privdata),
> +                       "length %d in event doesn't match buffer length %=
d!\n",
> +                       len, i2c_common->msg->len);
> +               err =3D true;
> +       }
> +
> +       if (unlikely(slave_addr !=3D i2c_common->msg->addr)) {
> +               dev_err(ndev_dev(privdata),
> +                       "unexpected slave address %x (expected: %x)!\n",
> +                       slave_addr, i2c_common->msg->addr);
> +               err =3D true;
> +       }
> +
> +       if (!err)
> +               i2c_common->cmd_success =3D true;
> +}
> +
> +static void __amd_mp2_process_event(struct amd_i2c_common *i2c_common)
> +{
> +       struct amd_mp2_dev *privdata =3D i2c_common->mp2_dev;
> +       enum status_type sts =3D i2c_common->eventval.r.status;
> +       enum response_type res =3D i2c_common->eventval.r.response;
> +       int len =3D i2c_common->eventval.r.length;
> +
> +       if (res !=3D command_success) {
> +               if (res =3D=3D command_failed)
> +                       dev_err(ndev_dev(privdata), "i2c command failed!\=
n");
> +               else
> +                       dev_err(ndev_dev(privdata), "invalid response to =
i2c command!\n");
> +               return;
> +       }
> +
> +       switch (i2c_common->reqcmd) {
> +       case i2c_read:
> +               if (sts =3D=3D i2c_readcomplete_event) {
> +                       amd_mp2_pci_check_rw_event(i2c_common);
> +                       if (len <=3D 32)
> +                               memcpy_fromio(i2c_common->msg->buf,
> +                                             privdata->mmio + AMD_C2P_MS=
G2,
> +                                             i2c_common->msg->len);
> +               } else if (sts =3D=3D i2c_readfail_event) {
> +                       dev_err(ndev_dev(privdata), "i2c read failed!\n")=
;
> +               } else {
> +                       dev_err(ndev_dev(privdata),
> +                               "invalid i2c status after read (%d)!\n", =
sts);
> +               }
> +               break;
> +       case i2c_write:
> +               if (sts =3D=3D i2c_writecomplete_event)
> +                       amd_mp2_pci_check_rw_event(i2c_common);
> +               else if (sts =3D=3D i2c_writefail_event)
> +                       dev_err(ndev_dev(privdata), "i2c write failed!\n"=
);
> +               else
> +                       dev_err(ndev_dev(privdata),
> +                               "invalid i2c status after write (%d)!\n",=
 sts);
> +               break;
> +       case i2c_enable:
> +               if (sts =3D=3D i2c_busenable_failed)
> +                       dev_err(ndev_dev(privdata), "i2c bus enable faile=
d!\n");
> +               else if (sts !=3D i2c_busenable_complete)
> +                       dev_err(ndev_dev(privdata),
> +                               "invalid i2c status after bus enable (%d)=
!\n",
> +                               sts);
> +               else
> +                       i2c_common->cmd_success =3D true;
> +               break;
> +       case i2c_disable:
> +               if (sts =3D=3D i2c_busdisable_failed)
> +                       dev_err(ndev_dev(privdata), "i2c bus disable fail=
ed!\n");
> +               else if (sts !=3D i2c_busdisable_complete)
> +                       dev_err(ndev_dev(privdata),
> +                               "invalid i2c status after bus disable (%d=
)!\n",
> +                               sts);
> +               else
> +                       i2c_common->cmd_success =3D true;
> +               break;
> +       default:
> +               break;
> +       }
> +}
> +
> +void amd_mp2_process_event(struct amd_i2c_common *i2c_common)
> +{
> +       struct amd_mp2_dev *privdata =3D i2c_common->mp2_dev;
> +
> +       if (unlikely(i2c_common->reqcmd =3D=3D i2c_none)) {
> +               dev_warn(ndev_dev(privdata),
> +                        "received msg but no cmd was sent (bus =3D %d)!\=
n",
> +                        i2c_common->bus_id);
> +               return;
> +       }
> +
> +       __amd_mp2_process_event(i2c_common);
> +
> +       i2c_common->reqcmd =3D i2c_none;
> +       amd_mp2_c2p_mutex_unlock(i2c_common);
> +}
> +EXPORT_SYMBOL_GPL(amd_mp2_process_event);
> +
> +static irqreturn_t amd_mp2_irq_isr(int irq, void *dev)
> +{
> +       struct amd_mp2_dev *privdata =3D dev;
> +       struct amd_i2c_common *i2c_common;
> +       u32 val;
> +       unsigned int bus_id;
> +       void __iomem *reg;
> +       enum irqreturn ret =3D IRQ_NONE;
> +
> +       for (bus_id =3D 0; bus_id < 2; bus_id++) {
> +               i2c_common =3D privdata->busses[bus_id];
> +               if (!i2c_common)
> +                       continue;
> +
> +               reg =3D privdata->mmio + ((bus_id =3D=3D 0) ?
> +                                       AMD_P2C_MSG1 : AMD_P2C_MSG2);
> +               val =3D readl(reg);
> +               if (val !=3D 0) {
> +                       writel(0, reg);
> +                       writel(0, privdata->mmio + AMD_P2C_MSG_INTEN);
> +                       i2c_common->eventval.ul =3D val;
> +                       i2c_common->cmd_completion(i2c_common);
> +
> +                       ret =3D IRQ_HANDLED;
> +               }
> +       }
> +
> +       if (ret !=3D IRQ_HANDLED) {
> +               val =3D readl(privdata->mmio + AMD_P2C_MSG_INTEN);
> +               if (unlikely(val !=3D 0)) {
> +                       writel(0, privdata->mmio + AMD_P2C_MSG_INTEN);
> +                       dev_warn(ndev_dev(privdata),
> +                                "received irq without message\n");
> +                       ret =3D IRQ_HANDLED;
> +               }
> +       }
> +
> +       return ret;
> +}
> +
> +void amd_mp2_rw_timeout(struct amd_i2c_common *i2c_common)
> +{
> +       i2c_common->reqcmd =3D i2c_none;
> +       amd_mp2_c2p_mutex_unlock(i2c_common);
> +}
> +EXPORT_SYMBOL_GPL(amd_mp2_rw_timeout);
> +
> +int amd_mp2_register_cb(struct amd_i2c_common *i2c_common)
> +{
> +       struct amd_mp2_dev *privdata =3D i2c_common->mp2_dev;
> +
> +       if (i2c_common->bus_id > 1)
> +               return -EINVAL;
> +
> +       if (privdata->busses[i2c_common->bus_id]) {
> +               dev_err(ndev_dev(privdata),
> +                       "Bus %d already taken!\n", i2c_common->bus_id);
> +               return -EINVAL;
> +       }
> +
> +       privdata->busses[i2c_common->bus_id] =3D i2c_common;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(amd_mp2_register_cb);
> +
> +int amd_mp2_unregister_cb(struct amd_i2c_common *i2c_common)
> +{
> +       struct amd_mp2_dev *privdata =3D i2c_common->mp2_dev;
> +
> +       privdata->busses[i2c_common->bus_id] =3D NULL;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(amd_mp2_unregister_cb);
> +
> +#ifdef CONFIG_DEBUG_FS
> +static const struct file_operations amd_mp2_debugfs_info;
> +static struct dentry *debugfs_root_dir;
> +
> +static ssize_t amd_mp2_debugfs_read(struct file *filp, char __user *ubuf=
,
> +                                   size_t count, loff_t *offp)
> +{
> +       struct amd_mp2_dev *privdata =3D filp->private_data;
> +       size_t buf_size =3D min_t(size_t, count, 0x800);
> +       u8 *buf;
> +       ssize_t ret, off =3D 0;
> +       u32 v32;
> +       int i;
> +
> +       buf =3D kmalloc(buf_size, GFP_KERNEL);
> +       if (!buf)
> +               return -ENOMEM;
> +
> +       off +=3D scnprintf(buf + off, buf_size - off,
> +                        "MP2 Device Information:\n"
> +                        "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D\n"
> +                        "\tMP2 C2P Message Register Dump:\n\n");
> +
> +       for (i =3D 0; i < 10; i++) {
> +               v32 =3D readl(privdata->mmio + AMD_C2P_MSG0 + i * 4);
> +               off +=3D scnprintf(buf + off, buf_size - off,
> +                                "AMD_C2P_MSG%d -\t\t\t%#06x\n", i, v32);
> +       }
> +
> +       off +=3D scnprintf(buf + off, buf_size - off,
> +                       "\n\tMP2 P2C Message Register Dump:\n\n");
> +
> +       for (i =3D 0; i < 3; i++) {
> +               v32 =3D readl(privdata->mmio + AMD_P2C_MSG1 + i * 4);
> +               off +=3D scnprintf(buf + off, buf_size - off,
> +                                "AMD_P2C_MSG%d -\t\t\t%#06x\n", i + 1, v=
32);
> +       }
> +
> +       v32 =3D readl(privdata->mmio + AMD_P2C_MSG_INTEN);
> +       off +=3D scnprintf(buf + off, buf_size - off,
> +                       "AMD_P2C_MSG_INTEN -\t\t%#06x\n", v32);
> +
> +       v32 =3D readl(privdata->mmio + AMD_P2C_MSG_INTSTS);
> +       off +=3D scnprintf(buf + off, buf_size - off,
> +                       "AMD_P2C_MSG_INTSTS -\t\t%#06x\n", v32);
> +
> +       ret =3D simple_read_from_buffer(ubuf, count, offp, buf, off);
> +       kfree(buf);
> +       return ret;
> +}
> +
> +static const struct file_operations amd_mp2_debugfs_info =3D {
> +       .owner =3D THIS_MODULE,
> +       .open =3D simple_open,
> +       .read =3D amd_mp2_debugfs_read,
> +};
> +
> +static void amd_mp2_init_debugfs(struct amd_mp2_dev *privdata)
> +{
> +       if (!debugfs_root_dir)
> +               return;
> +
> +       privdata->debugfs_dir =3D debugfs_create_dir(ndev_name(privdata),
> +                                                  debugfs_root_dir);
> +       if (!privdata->debugfs_dir) {
> +               privdata->debugfs_info =3D NULL;
> +       } else {
> +               privdata->debugfs_info =3D debugfs_create_file
> +                       ("info", 0400, privdata->debugfs_dir,
> +                        privdata, &amd_mp2_debugfs_info);
> +       }
> +}
> +#endif /* CONFIG_DEBUG_FS */
> +
> +static void amd_mp2_clear_reg(struct amd_mp2_dev *privdata)
> +{
> +       int reg;
> +
> +       for (reg =3D AMD_C2P_MSG0; reg <=3D AMD_C2P_MSG9; reg +=3D 4)
> +               writel(0, privdata->mmio + reg);
> +
> +       for (reg =3D AMD_P2C_MSG1; reg <=3D AMD_P2C_MSG2; reg +=3D 4)
> +               writel(0, privdata->mmio + reg);
> +}
> +
> +static int amd_mp2_pci_init(struct amd_mp2_dev *privdata,
> +                           struct pci_dev *pci_dev)
> +{
> +       int rc;
> +
> +       pci_set_drvdata(pci_dev, privdata);
> +
> +       rc =3D pcim_enable_device(pci_dev);
> +       if (rc) {
> +               dev_err(ndev_dev(privdata), "Failed to enable MP2 PCI dev=
ice\n");
> +               goto err_pci_enable;
> +       }
> +
> +       rc =3D pcim_iomap_regions(pci_dev, 1 << 2, pci_name(pci_dev));
> +       if (rc) {
> +               dev_err(ndev_dev(privdata), "I/O memory remapping failed\=
n");
> +               goto err_pci_enable;
> +       }
> +       privdata->mmio =3D pcim_iomap_table(pci_dev)[2];
> +
> +       pci_set_master(pci_dev);
> +
> +       rc =3D pci_set_dma_mask(pci_dev, DMA_BIT_MASK(64));
> +       if (rc) {
> +               rc =3D pci_set_dma_mask(pci_dev, DMA_BIT_MASK(32));
> +               if (rc)
> +                       goto err_dma_mask;
> +       }
> +
> +       /* Set up intx irq */
> +       writel(0, privdata->mmio + AMD_P2C_MSG_INTEN);
> +       pci_intx(pci_dev, 1);
> +       rc =3D devm_request_irq(&pci_dev->dev, pci_dev->irq, amd_mp2_irq_=
isr,
> +                             IRQF_SHARED, dev_name(&pci_dev->dev), privd=
ata);
> +       if (rc)
> +               dev_err(&pci_dev->dev, "Failure requesting irq %i: %d\n",
> +                       pci_dev->irq, rc);
> +
> +       return rc;
> +
> +err_dma_mask:
> +       pci_clear_master(pci_dev);
> +err_pci_enable:
> +       pci_set_drvdata(pci_dev, NULL);
> +       return rc;
> +}
> +
> +static int amd_mp2_pci_probe(struct pci_dev *pci_dev,
> +                            const struct pci_device_id *id)
> +{
> +       struct amd_mp2_dev *privdata;
> +       int rc;
> +       static bool first_probe =3D true;
> +
> +       if (first_probe) {
> +               pr_info("%s: %s Version: %s\n", DRIVER_NAME,
> +                       DRIVER_DESC, DRIVER_VER);
> +               first_probe =3D false;
> +       }
> +
> +       dev_info(&pci_dev->dev, "MP2 device found [%04x:%04x] (rev %x)\n"=
,
> +                pci_dev->vendor, pci_dev->device, pci_dev->revision);
> +
> +       privdata =3D devm_kzalloc(&pci_dev->dev, sizeof(*privdata), GFP_K=
ERNEL);
> +       if (!privdata)
> +               return -ENOMEM;
> +
> +       rc =3D amd_mp2_pci_init(privdata, pci_dev);
> +       if (rc)
> +               return rc;
> +
> +       mutex_init(&privdata->c2p_lock);
> +       privdata->pci_dev =3D pci_dev;
> +
> +       pm_runtime_set_autosuspend_delay(&pci_dev->dev, 1000);
> +       pm_runtime_use_autosuspend(&pci_dev->dev);
> +       pm_runtime_put_autosuspend(&pci_dev->dev);
> +       pm_runtime_allow(&pci_dev->dev);
> +
> +       amd_mp2_init_debugfs(privdata);
> +       dev_info(&pci_dev->dev, "MP2 device registered.\n");
> +       return 0;
> +}
> +
> +static bool amd_mp2_pci_is_probed(struct pci_dev *pci_dev)
> +{
> +       struct amd_mp2_dev *privdata =3D pci_get_drvdata(pci_dev);
> +
> +       if (!privdata)
> +               return false;
> +       return privdata->pci_dev !=3D NULL;
> +}
> +
> +static void amd_mp2_pci_remove(struct pci_dev *pci_dev)
> +{
> +       struct amd_mp2_dev *privdata =3D pci_get_drvdata(pci_dev);
> +
> +       pm_runtime_forbid(&pci_dev->dev);
> +       pm_runtime_get_noresume(&pci_dev->dev);
> +
> +#ifdef CONFIG_DEBUG_FS
> +       debugfs_remove_recursive(privdata->debugfs_dir);
> +#endif /* CONFIG_DEBUG_FS */
> +
> +       pci_intx(pci_dev, 0);
> +       pci_clear_master(pci_dev);
> +
> +       amd_mp2_clear_reg(privdata);
> +}
> +
> +#ifdef CONFIG_PM
> +static int amd_mp2_pci_suspend(struct device *dev)
> +{
> +       struct pci_dev *pci_dev =3D to_pci_dev(dev);
> +       struct amd_mp2_dev *privdata =3D pci_get_drvdata(pci_dev);
> +       struct amd_i2c_common *i2c_common;
> +       unsigned int bus_id;
> +       int ret =3D 0;
> +
> +       for (bus_id =3D 0; bus_id < 2; bus_id++) {
> +               i2c_common =3D privdata->busses[bus_id];
> +               if (i2c_common)
> +                       i2c_common->suspend(i2c_common);
> +       }
> +
> +       ret =3D pci_save_state(pci_dev);
> +       if (ret) {
> +               dev_err(ndev_dev(privdata),
> +                       "pci_save_state failed =3D %d\n", ret);
> +               return ret;
> +       }
> +
> +       pci_disable_device(pci_dev);
> +       return ret;
> +}
> +
> +static int amd_mp2_pci_resume(struct device *dev)
> +{
> +       struct pci_dev *pci_dev =3D to_pci_dev(dev);
> +       struct amd_mp2_dev *privdata =3D pci_get_drvdata(pci_dev);
> +       struct amd_i2c_common *i2c_common;
> +       unsigned int bus_id;
> +       int ret =3D 0;
> +
> +       pci_restore_state(pci_dev);
> +       ret =3D pci_enable_device(pci_dev);
> +       if (ret < 0) {
> +               dev_err(ndev_dev(privdata),
> +                       "pci_enable_device failed =3D %d\n", ret);
> +               return ret;
> +       }
> +
> +       for (bus_id =3D 0; bus_id < 2; bus_id++) {
> +               i2c_common =3D privdata->busses[bus_id];
> +               if (i2c_common) {
> +                       ret =3D i2c_common->resume(i2c_common);
> +                       if (ret < 0)
> +                               return ret;
> +               }
> +       }
> +
> +       return ret;
> +}
> +
> +static UNIVERSAL_DEV_PM_OPS(amd_mp2_pci_pm_ops, amd_mp2_pci_suspend,
> +                           amd_mp2_pci_resume, NULL);
> +#endif /* CONFIG_PM */
> +
> +static const struct pci_device_id amd_mp2_pci_tbl[] =3D {
> +       {PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_MP2)},
> +       {0}
> +};
> +MODULE_DEVICE_TABLE(pci, amd_mp2_pci_tbl);
> +
> +static struct pci_driver amd_mp2_pci_driver =3D {
> +       .name           =3D DRIVER_NAME,
> +       .id_table       =3D amd_mp2_pci_tbl,
> +       .probe          =3D amd_mp2_pci_probe,
> +       .remove         =3D amd_mp2_pci_remove,
> +#ifdef CONFIG_PM
> +       .driver =3D {
> +               .pm     =3D &amd_mp2_pci_pm_ops,
> +       },
> +#endif
> +};
> +
> +static int amd_mp2_device_match(struct device *dev, void *data)
> +{
> +       return 1;
> +}
> +
> +struct amd_mp2_dev *amd_mp2_find_device(void)
> +{
> +       struct device *dev;
> +       struct pci_dev *pci_dev;
> +
> +       dev =3D driver_find_device(&amd_mp2_pci_driver.driver, NULL, NULL=
,
> +                                amd_mp2_device_match);
> +       if (!dev)
> +               return NULL;
> +
> +       pci_dev =3D to_pci_dev(dev);
> +       if (!amd_mp2_pci_is_probed(pci_dev))
> +               return NULL;
> +       return (struct amd_mp2_dev *)pci_get_drvdata(pci_dev);
> +}
> +EXPORT_SYMBOL_GPL(amd_mp2_find_device);
> +
> +static int __init amd_mp2_drv_init(void)
> +{
> +#ifdef CONFIG_DEBUG_FS
> +       debugfs_root_dir =3D debugfs_create_dir(KBUILD_MODNAME, NULL);
> +#endif /* CONFIG_DEBUG_FS */
> +
> +       return pci_register_driver(&amd_mp2_pci_driver);
> +}
> +module_init(amd_mp2_drv_init);
> +
> +static void __exit amd_mp2_drv_exit(void)
> +{
> +       pci_unregister_driver(&amd_mp2_pci_driver);
> +
> +#ifdef CONFIG_DEBUG_FS
> +       debugfs_remove_recursive(debugfs_root_dir);
> +#endif /* CONFIG_DEBUG_FS */
> +}
> +module_exit(amd_mp2_drv_exit);
> +
> +MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_VERSION(DRIVER_VER);
> +MODULE_AUTHOR("Shyam Sundar S K <Shyam-sundar.S-k@amd.com>");
> +MODULE_AUTHOR("Elie Morisse <syniurge@gmail.com>");
> +MODULE_LICENSE("Dual BSD/GPL");
> diff --git a/drivers/i2c/busses/i2c-amd-mp2-plat.c b/drivers/i2c/busses/i=
2c-amd-mp2-plat.c
> new file mode 100644
> index 000000000000..06cf2b6658e5
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-amd-mp2-plat.c
> @@ -0,0 +1,392 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/*
> + * AMD MP2 platform driver
> + *
> + * Setup the I2C adapters enumerated in the ACPI namespace.
> + * MP2 controllers have 2 separate busses, up to 2 I2C adapters may be l=
isted.
> + *
> + * Authors: Nehal Bakulchandra Shah <Nehal-bakulchandra.shah@amd.com>
> + *          Elie Morisse <syniurge@gmail.com>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#include "i2c-amd-mp2.h"
> +
> +#define AMD_MP2_I2C_MAX_RW_LENGTH ((1 << 12) - 1)
> +#define AMD_I2C_TIMEOUT (msecs_to_jiffies(250))
> +
> +/**
> + * struct amd_i2c_dev - MP2 bus/i2c adapter context
> + * @common: shared context with the MP2 PCI driver
> + * @pdev: platform driver node
> + * @adap: i2c adapter
> + * @cmd_complete: xfer completion object
> + */
> +struct amd_i2c_dev {
> +       struct amd_i2c_common common;
> +       struct platform_device *pdev;
> +       struct i2c_adapter adap;
> +       struct completion cmd_complete;
> +};
> +
> +#define amd_i2c_dev_common(__common) \
> +       container_of(__common, struct amd_i2c_dev, common)
> +
> +static int i2c_amd_dma_map(struct amd_i2c_common *i2c_common)
> +{
> +       struct device *dev_pci =3D &i2c_common->mp2_dev->pci_dev->dev;
> +       struct amd_i2c_dev *i2c_dev =3D amd_i2c_dev_common(i2c_common);
> +       enum dma_data_direction dma_direction =3D
> +                       i2c_common->msg->flags & I2C_M_RD ?
> +                       DMA_FROM_DEVICE : DMA_TO_DEVICE;
> +
> +       i2c_common->dma_buf =3D i2c_get_dma_safe_msg_buf(i2c_common->msg,=
 0);
> +       i2c_common->dma_addr =3D dma_map_single(dev_pci, i2c_common->dma_=
buf,
> +                                             i2c_common->msg->len,
> +                                             dma_direction);
> +
> +       if (unlikely(dma_mapping_error(dev_pci, i2c_common->dma_addr))) {
> +               dev_err(&i2c_dev->pdev->dev,
> +                       "Error while mapping dma buffer %p\n",
> +                       i2c_common->dma_buf);
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +static void i2c_amd_dma_unmap(struct amd_i2c_common *i2c_common)
> +{
> +       struct device *dev_pci =3D &i2c_common->mp2_dev->pci_dev->dev;
> +       enum dma_data_direction dma_direction =3D
> +                       i2c_common->msg->flags & I2C_M_RD ?
> +                       DMA_FROM_DEVICE : DMA_TO_DEVICE;
> +
> +       dma_unmap_single(dev_pci, i2c_common->dma_addr,
> +                        i2c_common->msg->len, dma_direction);
> +
> +       i2c_put_dma_safe_msg_buf(i2c_common->dma_buf, i2c_common->msg, tr=
ue);
> +}
> +
> +static const char *i2c_amd_cmd_name(enum i2c_cmd cmd)
> +{
> +       switch (cmd) {
> +       case i2c_read:
> +               return "i2c read";
> +       case i2c_write:
> +               return "i2c write";
> +       case i2c_enable:
> +               return "bus enable";
> +       case i2c_disable:
> +               return "bus disable";
> +       case number_of_sensor_discovered:
> +               return "'number of sensors discovered' cmd";
> +       case is_mp2_active:
> +               return "'is mp2 active' cmd";
> +       default:
> +               return "invalid cmd";
> +       }
> +}
> +
> +static void i2c_amd_start_cmd(struct amd_i2c_dev *i2c_dev)
> +{
> +       struct amd_i2c_common *i2c_common =3D &i2c_dev->common;
> +
> +       reinit_completion(&i2c_dev->cmd_complete);
> +       i2c_common->cmd_success =3D false;
> +}
> +
> +static void i2c_amd_cmd_completion(struct amd_i2c_common *i2c_common)
> +{
> +       struct amd_i2c_dev *i2c_dev =3D amd_i2c_dev_common(i2c_common);
> +       union i2c_event *event =3D &i2c_common->eventval;
> +
> +       if (event->r.status =3D=3D i2c_readcomplete_event)
> +               dev_dbg(&i2c_dev->pdev->dev, "%s readdata:%*ph\n",
> +                       __func__, event->r.length,
> +                       i2c_common->msg->buf);
> +
> +       complete(&i2c_dev->cmd_complete);
> +}
> +
> +static int i2c_amd_check_cmd_completion(struct amd_i2c_dev *i2c_dev)
> +{
> +       struct amd_i2c_common *i2c_common =3D &i2c_dev->common;
> +       unsigned long timeout;
> +
> +       timeout =3D wait_for_completion_timeout(&i2c_dev->cmd_complete,
> +                                             i2c_dev->adap.timeout);
> +       if (unlikely(timeout =3D=3D 0)) {
> +               dev_err(&i2c_dev->pdev->dev, "%s timed out\n",
> +                       i2c_amd_cmd_name(i2c_common->reqcmd));
> +               amd_mp2_rw_timeout(i2c_common);
> +       }
> +
> +       if ((i2c_common->reqcmd =3D=3D i2c_read ||
> +            i2c_common->reqcmd =3D=3D i2c_write) &&
> +           i2c_common->msg->len > 32)
> +               i2c_amd_dma_unmap(i2c_common);
> +
> +       if (unlikely(timeout =3D=3D 0))
> +               return -ETIMEDOUT;
> +
> +       amd_mp2_process_event(i2c_common);
> +
> +       if (!i2c_common->cmd_success)
> +               return -EIO;
> +
> +       return 0;
> +}
> +
> +static int i2c_amd_enable_set(struct amd_i2c_dev *i2c_dev, bool enable)
> +{
> +       struct amd_i2c_common *i2c_common =3D &i2c_dev->common;
> +
> +       i2c_amd_start_cmd(i2c_dev);
> +       amd_mp2_bus_enable_set(i2c_common, enable);
> +
> +       return i2c_amd_check_cmd_completion(i2c_dev);
> +}
> +
> +static int i2c_amd_xfer_msg(struct amd_i2c_dev *i2c_dev, struct i2c_msg =
*pmsg)
> +{
> +       struct amd_i2c_common *i2c_common =3D &i2c_dev->common;
> +
> +       i2c_amd_start_cmd(i2c_dev);
> +       i2c_common->msg =3D pmsg;
> +
> +       if (pmsg->len > 32)
> +               if (i2c_amd_dma_map(i2c_common))
> +                       return -EIO;
> +
> +       if (pmsg->flags & I2C_M_RD)
> +               amd_mp2_read(i2c_common);
> +       else
> +               amd_mp2_write(i2c_common);
> +
> +       return i2c_amd_check_cmd_completion(i2c_dev);
> +}
> +
> +static int i2c_amd_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, =
int num)
> +{
> +       struct amd_i2c_dev *i2c_dev =3D i2c_get_adapdata(adap);
> +       int i;
> +       struct i2c_msg *pmsg;
> +       int err;
> +
> +       /* the adapter might have been deleted while waiting for the bus =
lock */
> +       if (unlikely(!i2c_dev->common.mp2_dev))
> +               return -EINVAL;
> +
> +       amd_mp2_pm_runtime_get(i2c_dev->common.mp2_dev);
> +
> +       for (i =3D 0; i < num; i++) {
> +               pmsg =3D &msgs[i];
> +               err =3D i2c_amd_xfer_msg(i2c_dev, pmsg);
> +               if (err)
> +                       break;
> +       }
> +
> +       amd_mp2_pm_runtime_put(i2c_dev->common.mp2_dev);
> +       return err ? err : num;
> +}
> +
> +static u32 i2c_amd_func(struct i2c_adapter *a)
> +{
> +       return I2C_FUNC_I2C;
> +}
> +
> +static const struct i2c_algorithm i2c_amd_algorithm =3D {
> +       .master_xfer =3D i2c_amd_xfer,
> +       .functionality =3D i2c_amd_func,
> +};
> +
> +#ifdef CONFIG_PM
> +static int i2c_amd_suspend(struct amd_i2c_common *i2c_common)
> +{
> +       struct amd_i2c_dev *i2c_dev =3D amd_i2c_dev_common(i2c_common);
> +
> +       i2c_amd_enable_set(i2c_dev, false);
> +       return 0;
> +}
> +
> +static int i2c_amd_resume(struct amd_i2c_common *i2c_common)
> +{
> +       struct amd_i2c_dev *i2c_dev =3D amd_i2c_dev_common(i2c_common);
> +
> +       return i2c_amd_enable_set(i2c_dev, true);
> +}
> +#endif
> +
> +static enum speed_enum i2c_amd_get_bus_speed(struct platform_device *pde=
v)
> +{
> +       u32 acpi_speed;
> +       int i;
> +       static const u32 supported_speeds[] =3D {
> +               0, 100000, 400000, 1000000, 1400000, 3400000
> +       };
> +
> +       acpi_speed =3D i2c_acpi_find_bus_speed(&pdev->dev);
> +       /* round down to the lowest standard speed */
> +       for (i =3D 1; i < ARRAY_SIZE(supported_speeds); i++) {
> +               if (acpi_speed < supported_speeds[i])
> +                       break;
> +       }
> +       acpi_speed =3D supported_speeds[i - 1];
> +
> +       switch (acpi_speed) {
> +       case 100000:
> +               return speed100k;
> +       case 400000:
> +               return speed400k;
> +       case 1000000:
> +               return speed1000k;
> +       case 1400000:
> +               return speed1400k;
> +       case 3400000:
> +               return speed3400k;
> +       default:
> +               return speed400k;
> +       }
> +}
> +
> +static const struct i2c_adapter_quirks amd_i2c_dev_quirks =3D {
> +       .max_read_len =3D AMD_MP2_I2C_MAX_RW_LENGTH,
> +       .max_write_len =3D AMD_MP2_I2C_MAX_RW_LENGTH,
> +};
> +
> +static int i2c_amd_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +       struct amd_i2c_dev *i2c_dev;
> +       acpi_handle handle =3D ACPI_HANDLE(&pdev->dev);
> +       struct acpi_device *adev;
> +       struct amd_mp2_dev *mp2_dev;
> +       const char *uid;
> +
> +       if (acpi_bus_get_device(handle, &adev))
> +               return -ENODEV;
> +
> +       /* The ACPI namespace doesn't contain information about which MP2=
 PCI
> +        * device an AMDI0011 ACPI device is related to, so assume that t=
here's
> +        * only one MP2 PCI device per system.
> +        */
> +       mp2_dev =3D amd_mp2_find_device();
> +       if (!mp2_dev)
> +               /* The MP2 PCI device might get probed later */
> +               return -EPROBE_DEFER;
> +
> +       i2c_dev =3D devm_kzalloc(&pdev->dev, sizeof(*i2c_dev), GFP_KERNEL=
);
> +       if (!i2c_dev)
> +               return -ENOMEM;
> +
> +       i2c_dev->common.mp2_dev =3D mp2_dev;
> +       i2c_dev->pdev =3D pdev;
> +       platform_set_drvdata(pdev, i2c_dev);
> +
> +       i2c_dev->common.cmd_completion =3D &i2c_amd_cmd_completion;
> +#ifdef CONFIG_PM
> +       i2c_dev->common.suspend =3D &i2c_amd_suspend;
> +       i2c_dev->common.resume =3D &i2c_amd_resume;
> +#endif
> +
> +       uid =3D adev->pnp.unique_id;
> +       if (!uid) {
> +               dev_err(&pdev->dev, "missing UID/bus id!\n");
> +               return -EINVAL;
> +       } else if (strcmp(uid, "0") =3D=3D 0) {
> +               i2c_dev->common.bus_id =3D 0;
> +       } else if (strcmp(uid, "1") =3D=3D 0) {
> +               i2c_dev->common.bus_id =3D 1;
> +       } else {
> +               dev_err(&pdev->dev, "incorrect UID/bus id \"%s\"!\n", uid=
);
> +               return -EINVAL;
> +       }
> +       dev_dbg(&pdev->dev, "bus id is %u\n", i2c_dev->common.bus_id);
> +
> +       /* Register the adapter */
> +       amd_mp2_pm_runtime_get(mp2_dev);
> +
> +       i2c_dev->common.reqcmd =3D i2c_none;
> +       if (amd_mp2_register_cb(&i2c_dev->common))
> +               return -EINVAL;
> +       device_link_add(&i2c_dev->pdev->dev, &mp2_dev->pci_dev->dev,
> +                       DL_FLAG_AUTOREMOVE_CONSUMER);
> +
> +       i2c_dev->common.i2c_speed =3D i2c_amd_get_bus_speed(pdev);
> +
> +       /* Setup i2c adapter description */
> +       i2c_dev->adap.owner =3D THIS_MODULE;
> +       i2c_dev->adap.algo =3D &i2c_amd_algorithm;
> +       i2c_dev->adap.quirks =3D &amd_i2c_dev_quirks;
> +       i2c_dev->adap.dev.parent =3D &pdev->dev;
> +       i2c_dev->adap.algo_data =3D i2c_dev;
> +       i2c_dev->adap.nr =3D pdev->id;
> +       i2c_dev->adap.timeout =3D AMD_I2C_TIMEOUT;
> +       ACPI_COMPANION_SET(&i2c_dev->adap.dev, ACPI_COMPANION(&pdev->dev)=
);
> +       i2c_dev->adap.dev.of_node =3D pdev->dev.of_node;
> +       snprintf(i2c_dev->adap.name, sizeof(i2c_dev->adap.name),
> +                "AMD MP2 i2c bus %u", i2c_dev->common.bus_id);
> +       i2c_set_adapdata(&i2c_dev->adap, i2c_dev);
> +
> +       init_completion(&i2c_dev->cmd_complete);
> +
> +       /* Enable the bus */
> +       if (i2c_amd_enable_set(i2c_dev, true))
> +               dev_err(&pdev->dev, "initial bus enable failed\n");
> +
> +       /* Attach to the i2c layer */
> +       ret =3D i2c_add_numbered_adapter(&i2c_dev->adap);
> +
> +       amd_mp2_pm_runtime_put(mp2_dev);
> +
> +       if (ret < 0)
> +               dev_err(&pdev->dev, "i2c add adapter failed =3D %d\n", re=
t);
> +
> +       return ret;
> +}
> +
> +static int i2c_amd_remove(struct platform_device *pdev)
> +{
> +       struct amd_i2c_dev *i2c_dev =3D platform_get_drvdata(pdev);
> +       struct amd_i2c_common *i2c_common =3D &i2c_dev->common;
> +
> +       i2c_lock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
> +
> +       i2c_amd_enable_set(i2c_dev, false);
> +       amd_mp2_unregister_cb(i2c_common);
> +       i2c_common->mp2_dev =3D NULL;
> +
> +       i2c_unlock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
> +
> +       i2c_del_adapter(&i2c_dev->adap);
> +       return 0;
> +}
> +
> +static const struct acpi_device_id i2c_amd_acpi_match[] =3D {
> +       { "AMDI0011" },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(acpi, i2c_amd_acpi_match);
> +
> +static struct platform_driver i2c_amd_plat_driver =3D {
> +       .probe =3D i2c_amd_probe,
> +       .remove =3D i2c_amd_remove,
> +       .driver =3D {
> +               .name =3D "i2c_amd_mp2",
> +               .acpi_match_table =3D ACPI_PTR(i2c_amd_acpi_match),
> +       },
> +};
> +module_platform_driver(i2c_amd_plat_driver);
> +
> +MODULE_DESCRIPTION("AMD(R) MP2 I2C Platform Driver");
> +MODULE_VERSION("1.0");
> +MODULE_AUTHOR("Nehal Shah <nehal-bakulchandra.shah@amd.com>");
> +MODULE_AUTHOR("Elie Morisse <syniurge@gmail.com>");
> +MODULE_LICENSE("Dual BSD/GPL");
> diff --git a/drivers/i2c/busses/i2c-amd-mp2.h b/drivers/i2c/busses/i2c-am=
d-mp2.h
> new file mode 100644
> index 000000000000..aff9a4e4369e
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-amd-mp2.h
> @@ -0,0 +1,223 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> +/*
> + * AMD MP2 I2C adapter driver
> + *
> + * Authors: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> + *          Elie Morisse <syniurge@gmail.com>
> + */
> +
> +#ifndef I2C_AMD_PCI_MP2_H
> +#define I2C_AMD_PCI_MP2_H
> +
> +#include <linux/i2c.h>
> +#include <linux/pci.h>
> +#include <linux/pm_runtime.h>
> +
> +#define PCI_DEVICE_ID_AMD_MP2  0x15E6
> +
> +struct amd_i2c_common;
> +struct amd_mp2_dev;
> +
> +enum {
> +       /* MP2 C2P Message Registers */
> +       AMD_C2P_MSG0 =3D 0x10500,                 /* MP2 Message for I2C0=
 */
> +       AMD_C2P_MSG1 =3D 0x10504,                 /* MP2 Message for I2C1=
 */
> +       AMD_C2P_MSG2 =3D 0x10508,                 /* DRAM Address Lo / Da=
ta 0 */
> +       AMD_C2P_MSG3 =3D 0x1050c,                 /* DRAM Address HI / Da=
ta 1 */
> +       AMD_C2P_MSG4 =3D 0x10510,                 /* Data 2 */
> +       AMD_C2P_MSG5 =3D 0x10514,                 /* Data 3 */
> +       AMD_C2P_MSG6 =3D 0x10518,                 /* Data 4 */
> +       AMD_C2P_MSG7 =3D 0x1051c,                 /* Data 5 */
> +       AMD_C2P_MSG8 =3D 0x10520,                 /* Data 6 */
> +       AMD_C2P_MSG9 =3D 0x10524,                 /* Data 7 */
> +
> +       /* MP2 P2C Message Registers */
> +       AMD_P2C_MSG0 =3D 0x10680,                 /* Do not use */
> +       AMD_P2C_MSG1 =3D 0x10684,                 /* I2C0 interrupt regis=
ter */
> +       AMD_P2C_MSG2 =3D 0x10688,                 /* I2C1 interrupt regis=
ter */
> +       AMD_P2C_MSG3 =3D 0x1068C,                 /* MP2 debug info */
> +       AMD_P2C_MSG_INTEN =3D 0x10690,            /* MP2 interrupt gen re=
gister */
> +       AMD_P2C_MSG_INTSTS =3D 0x10694,           /* Interrupt status */
> +};
> +
> +/* Command register data structures */
> +
> +#define i2c_none (-1)
> +enum i2c_cmd {
> +       i2c_read =3D 0,
> +       i2c_write,
> +       i2c_enable,
> +       i2c_disable,
> +       number_of_sensor_discovered,
> +       is_mp2_active,
> +       invalid_cmd =3D 0xF,
> +};
> +
> +enum speed_enum {
> +       speed100k =3D 0,
> +       speed400k =3D 1,
> +       speed1000k =3D 2,
> +       speed1400k =3D 3,
> +       speed3400k =3D 4
> +};
> +
> +enum mem_type {
> +       use_dram =3D 0,
> +       use_c2pmsg =3D 1,
> +};
> +
> +/**
> + * union i2c_cmd_base : bit access of C2P commands
> + * @i2c_cmd: bit 0..3 i2c R/W command
> + * @bus_id: bit 4..7 i2c bus index
> + * @slave_addr: bit 8..15 slave address
> + * @length: bit 16..27 read/write length
> + * @i2c_speed: bit 28..30 bus speed
> + * @mem_type: bit 31 0-DRAM; 1-C2P msg o/p
> + */
> +union i2c_cmd_base {
> +       u32 ul;
> +       struct {
> +               enum i2c_cmd i2c_cmd : 4;
> +               u8 bus_id : 4;
> +               u32 slave_addr : 8;
> +               u32 length : 12;
> +               enum speed_enum i2c_speed : 3;
> +               enum mem_type mem_type : 1;
> +       } s;
> +};
> +
> +enum response_type {
> +       invalid_response =3D 0,
> +       command_success =3D 1,
> +       command_failed =3D 2,
> +};
> +
> +enum status_type {
> +       i2c_readcomplete_event =3D 0,
> +       i2c_readfail_event =3D 1,
> +       i2c_writecomplete_event =3D 2,
> +       i2c_writefail_event =3D 3,
> +       i2c_busenable_complete =3D 4,
> +       i2c_busenable_failed =3D 5,
> +       i2c_busdisable_complete =3D 6,
> +       i2c_busdisable_failed =3D 7,
> +       invalid_data_length =3D 8,
> +       invalid_slave_address =3D 9,
> +       invalid_i2cbus_id =3D 10,
> +       invalid_dram_addr =3D 11,
> +       invalid_command =3D 12,
> +       mp2_active =3D 13,
> +       numberof_sensors_discovered_resp =3D 14,
> +       i2c_bus_notinitialized
> +};
> +
> +/**
> + * union i2c_event : bit access of P2C events
> + * @response: bit 0..1 i2c response type
> + * @status: bit 2..6 status_type
> + * @mem_type: bit 7 0-DRAM; 1-C2P msg o/p
> + * @bus_id: bit 8..11 i2c bus id
> + * @length: bit 12..23 message length
> + * @slave_addr: bit 24-31 slave address
> + */
> +union i2c_event {
> +       u32 ul;
> +       struct {
> +               enum response_type response : 2;
> +               enum status_type status : 5;
> +               enum mem_type mem_type : 1;
> +               u8 bus_id : 4;
> +               u32 length : 12;
> +               u32 slave_addr : 8;
> +       } r;
> +};
> +
> +/**
> + * struct amd_i2c_common - per bus/i2c adapter context, shared
> + *     between the pci and the platform driver
> + * @eventval: MP2 event value set by the IRQ handler
> + * @mp2_dev: MP2 pci device this adapter is part of
> + * @msg: i2c message
> + * @cmd_completion: function called by the IRQ handler to signal
> + *                 the platform driver
> + * @reqcmd: requested i2c command type
> + * @cmd_success: set to true if the MP2 responded to a command with
> + *              the expected status and response type
> + * @bus_id: bus index
> + * @i2c_speed: i2c bus speed determined by the slowest slave
> + * @dma_buf: if msg length > 32, holds the DMA buffer virtual address
> + * @dma_addr: if msg length > 32, holds the DMA buffer address
> + */
> +struct amd_i2c_common {
> +       union i2c_event eventval;
> +       struct amd_mp2_dev *mp2_dev;
> +       struct i2c_msg *msg;
> +       void (*cmd_completion)(struct amd_i2c_common *i2c_common);
> +       enum i2c_cmd reqcmd;
> +       u8 cmd_success;
> +       u8 bus_id;
> +       enum speed_enum i2c_speed;
> +       u8 *dma_buf;
> +       dma_addr_t dma_addr;
> +#ifdef CONFIG_PM
> +       int (*suspend)(struct amd_i2c_common *i2c_common);
> +       int (*resume)(struct amd_i2c_common *i2c_common);
> +#endif /* CONFIG_PM */
> +};
> +
> +/**
> + * struct amd_mp2_dev - per PCI device context
> + * @pci_dev: PCI driver node
> + * @busses: MP2 devices may have up to two busses,
> + *         each bus corresponding to an i2c adapter
> + * @mmio: iommapped registers
> + * @c2p_lock: controls access to the C2P mailbox shared between
> + *           the two adapters
> + * @c2p_lock_busid: id of the adapter which locked c2p_lock
> + */
> +struct amd_mp2_dev {
> +       struct pci_dev *pci_dev;
> +       struct amd_i2c_common *busses[2];
> +       void __iomem *mmio;
> +       struct mutex c2p_lock;
> +       u8 c2p_lock_busid;
> +#ifdef CONFIG_DEBUG_FS
> +       struct dentry *debugfs_dir;
> +       struct dentry *debugfs_info;
> +#endif /* CONFIG_DEBUG_FS */
> +};
> +
> +#define ndev_pdev(ndev) ((ndev)->pci_dev)
> +#define ndev_name(ndev) pci_name(ndev_pdev(ndev))
> +#define ndev_dev(ndev) (&ndev_pdev(ndev)->dev)
> +#define work_amd_i2c_common(__work) \
> +       container_of(__work, struct amd_i2c_common, work.work)
> +
> +/* PCIe communication driver */
> +
> +int amd_mp2_read(struct amd_i2c_common *i2c_common);
> +int amd_mp2_write(struct amd_i2c_common *i2c_common);
> +int amd_mp2_bus_enable_set(struct amd_i2c_common *i2c_common, bool enabl=
e);
> +
> +void amd_mp2_process_event(struct amd_i2c_common *i2c_common);
> +
> +void amd_mp2_rw_timeout(struct amd_i2c_common *i2c_common);
> +
> +int amd_mp2_register_cb(struct amd_i2c_common *i2c_common);
> +int amd_mp2_unregister_cb(struct amd_i2c_common *i2c_common);
> +
> +struct amd_mp2_dev *amd_mp2_find_device(void);
> +
> +static inline void amd_mp2_pm_runtime_get(struct amd_mp2_dev *mp2_dev)
> +{
> +       pm_runtime_get_sync(&mp2_dev->pci_dev->dev);
> +}
> +
> +static inline void amd_mp2_pm_runtime_put(struct amd_mp2_dev *mp2_dev)
> +{
> +       pm_runtime_mark_last_busy(&mp2_dev->pci_dev->dev);
> +       pm_runtime_put_autosuspend(&mp2_dev->pci_dev->dev);
> +}
> +
> +#endif
> --
> 2.17.1
>
