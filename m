Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706B2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBEE621852
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XcuUwN/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbfB0PWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 10:22:24 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33850 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfB0PWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 10:22:23 -0500
Received: by mail-pl1-f196.google.com with SMTP id d15so8188298plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 07:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M6Be1LLBfLgPzgyHZc1vO3KUYy1F5nJyzkGDmVg8V2o=;
        b=XcuUwN/KiB8qEgdXCVG1XdTJpEwPpNc28GmL9Iwxw70Ke1oy5Jsd2mFFahW1Vmhyia
         ypskOTiY0eYdaoxaEu84xYZmKv8bstbxGMBqKX7enegZrxS869Kq0T1+ooCLAaX2Gily
         7ZadBJZsWR4otuO3UFbn6pMlgZyl8USWyw+PXAKD+UilwcDM3y20pJNrBQjob1EeTI6b
         lTFbdaUqS6x/H+6U0Nw5I1f5Bu0xoYJCraFfUw6EAJRFa4jZHsUKZhRcq38Fjav4B6HM
         1LS5CpNOpF+EKEiz6ZKQSSV8N0Vy+/V3QFaKucHW4TddLJVlvKOICySZQmOeaLdf1yge
         r96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M6Be1LLBfLgPzgyHZc1vO3KUYy1F5nJyzkGDmVg8V2o=;
        b=HnmbhT0YGkkbegkNFc6wmwFQLnJnsNcD+9QTjE8cZBU50hCwCqgg+zDXc07GYQB4ae
         K8W0jS80L+XFsg1euRQ/JVpaWs6/TcGkZbEnWkwo1h2/sbl4/iFqsKnEFbdwnqWukvRa
         uvgVgo/7X3oqZ3rbIy3Y/4a/cc90QtO7aEQeLUGmhGVBAfyQgt/IQoSSVOlhu6C1e2Jp
         3aeiDSbhryPd8QrX3CDio4aKb+YXUJeVjO6CA2wFdCgVNB9DzbiYXVPKND3+TPc/UFGJ
         Aftz3s0B1ckLQtClbSG+YPZK1tFuO2WQtlhU0G1edDT5w++wKfowqB1TRF6P7dxAczwU
         GWTQ==
X-Gm-Message-State: AHQUAua4BLJ8qjm4hvuDDH76nzBmFTYtTARzkLB4F79qxlhRs6rnX4Gu
        rGD0R/zZMWt2F6Y19klWLFnpmLSlsjanIe3NwFx9Rg==
X-Google-Smtp-Source: AHgI3IbBt0GMksax/e5e9a22QTfkdSTYErg1N3EFIidbmSy+U7p18Afy/09Xv77BaCWJMDpiFLne2vjftz0ysM22n14=
X-Received: by 2002:a17:902:6a4:: with SMTP id 33mr2708509plh.233.1551280941925;
 Wed, 27 Feb 2019 07:22:21 -0800 (PST)
MIME-Version: 1.0
References: <20190221222537.137331-1-venture@google.com> <692c6c5d-9090-4e1f-9324-a03da381b003@www.fastmail.com>
 <CAO=notx+p5PQ1UXW7XKD=5Lb23RvC5+1R+LcJLxXYEnT6vvgkQ@mail.gmail.com>
 <373ab9b9-b43d-41af-9b35-56db922ac00b@www.fastmail.com> <CAO=notw-MVn2uRoR3Xa9bpWkq2gdGK8rUGH-X2KedQfWiqHGyw@mail.gmail.com>
 <1d8f26bf-c97e-41d1-a2ee-6d264e38b9e6@www.fastmail.com>
In-Reply-To: <1d8f26bf-c97e-41d1-a2ee-6d264e38b9e6@www.fastmail.com>
From:   Patrick Venture <venture@google.com>
Date:   Wed, 27 Feb 2019 07:22:10 -0800
Message-ID: <CAO=notxgZH6aGpwx8BjvROfGOU1-LSZgW70rwfbkNJtLxDSimw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers/misc: Add Aspeed P2A control driver
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 9:53 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Wed, 27 Feb 2019, at 13:04, Patrick Venture wrote:
> > On Tue, Feb 26, 2019 at 5:05 PM Andrew Jeffery <andrew@aj.id.au> wrote:
> > >
> > >
> > >
> > > On Wed, 27 Feb 2019, at 08:12, Patrick Venture wrote:
> > > > On Sun, Feb 24, 2019 at 5:26 PM Andrew Jeffery <andrew@aj.id.au> wrote:
> > > > >
> > > > > On Fri, 22 Feb 2019, at 08:55, Patrick Venture wrote:
> > > > > > The ASPEED AST2400, and AST2500 in some configurations include a
> > > > > > PCI-to-AHB MMIO bridge.  This bridge allows a server to read and write
> > > > > > in the BMC's memory space.
> > > > >
> > > > > Bit of a nit, but I think s/memory space/physical address space/ makes
> > > > > the power of the interface a bit clearer.
> > > > >
> > > > > >  This feature is especially useful when using
> > > > > > this bridge to send large files to the BMC.
> > > > > >
> > > > > > The host may use this to send down a firmware image by staging data at a
> > > > > > specific memory address, and in a coordinated effort with the BMC's
> > > > > > software stack and kernel, transmit the bytes.
> > > > > >
> > > > > > This driver enables the BMC to unlock the PCI bridge on demand, and
> > > > > > configure it via ioctl to allow the host to write bytes to an agreed
> > > > > > upon location.  In the primary use-case, the region to use is known
> > > > > > apriori on the BMC, and the host requests this information.  Once this
> > > > > > request is received, the BMC's software stack will enable the bridge and
> > > > > > the region and then using some software flow control (possibly via IPMI
> > > > > > packets), copy the bytes down.  Once the process is complete, the BMC
> > > > > > will disable the bridge and unset any region involved.
> > > > >
> > > > > I feel the description is a little subtle. You mention locations and regions
> > > > > without really defining their relationship. We have the means to prevent
> > > > > writes via the P2A to following regions in the BMC's physical address space:
> > > > >
> > > > > * BMC flash MMIO window
> > > > > * System flash MMIO windows
> > > > > * SOC IO (peripheral MMIO)
> > > > > * DRAM
> > > > >
> > > > > So what I think should be made clear is once we allow the host to write
> > > > > to e.g. DRAM, it can write to *all* of DRAM, regardless of what location the
> > > > > BMC recommended, i.e. the BMC is at the mercy of the host wrt
> > > > > confidentiality once the P2A is enabled (host can always read anywhere)
> > > > > and integrity when the DRAM write filter is disabled.
> > > >
> > > > Ok, I can try to work that phrasing in.
> > > >
> > > > >
> > > > > There is no way to specify and constrain P2A writes to specific locations
> > > > > in DRAM.
> > > > >
> > > > > >
> > > > > > The default behavior of this bridge when present is: enabled and all
> > > > > > regions marked read-write.  This driver will fix the regions to be
> > > > > > read-only and then disable the bridge entirely.
> > > > > >
> > > > > > Signed-off-by: Patrick Venture <venture@google.com>
> > > > > > ---
> > > > > >  drivers/misc/Kconfig                 |   8 +
> > > > > >  drivers/misc/Makefile                |   1 +
> > > > > >  drivers/misc/aspeed-p2a-ctrl.c       | 498 +++++++++++++++++++++++++++
> > > > > >  include/uapi/linux/aspeed-p2a-ctrl.h |  46 +++
> > > > > >  4 files changed, 553 insertions(+)
> > > > > >  create mode 100644 drivers/misc/aspeed-p2a-ctrl.c
> > > > > >  create mode 100644 include/uapi/linux/aspeed-p2a-ctrl.h
> > > > > >
> > > > > > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > > > > > index f417b06e11c5..54ed265a26f0 100644
> > > > > > --- a/drivers/misc/Kconfig
> > > > > > +++ b/drivers/misc/Kconfig
> > > > > > @@ -485,6 +485,14 @@ config VEXPRESS_SYSCFG
> > > > > >         bus. System Configuration interface is one of the possible means
> > > > > >         of generating transactions on this bus.
> > > > > >
> > > > > > +config ASPEED_P2A_CTRL
> > > > > > +     depends on (ARCH_ASPEED || COMPILE_TEST)
> > > > > > +     tristate "Aspeed ast2400/2500 HOST P2A VGA MMIO to BMC bridge control"
> > > > > > +     help
> > > > > > +       Control Aspeed ast2400/2500 HOST P2A VGA MMIO to BMC mappings
> > > > > > through
> > > > > > +       ioctl()s, the driver also provides an interface for userspace
> > > > > > mappings to
> > > > > > +       a pre-defined region.
> > > > > > +
> > > > > >  config ASPEED_LPC_CTRL
> > > > > >       depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
> > > > > >       tristate "Aspeed ast2400/2500 HOST LPC to BMC bridge control"
> > > > > > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > > > > > index e39ccbbc1b3a..57577aee354f 100644
> > > > > > --- a/drivers/misc/Makefile
> > > > > > +++ b/drivers/misc/Makefile
> > > > > > @@ -55,6 +55,7 @@ obj-$(CONFIG_VEXPRESS_SYSCFG)       += vexpress-syscfg.o
> > > > > >  obj-$(CONFIG_CXL_BASE)               += cxl/
> > > > > >  obj-$(CONFIG_ASPEED_LPC_CTRL)        += aspeed-lpc-ctrl.o
> > > > > >  obj-$(CONFIG_ASPEED_LPC_SNOOP)       += aspeed-lpc-snoop.o
> > > > > > +obj-$(CONFIG_ASPEED_P2A_CTRL)        += aspeed-p2a-ctrl.o
> > > > > >  obj-$(CONFIG_PCI_ENDPOINT_TEST)      += pci_endpoint_test.o
> > > > > >  obj-$(CONFIG_OCXL)           += ocxl/
> > > > > >  obj-y                                += cardreader/
> > > > > > diff --git a/drivers/misc/aspeed-p2a-ctrl.c
> > > > > > b/drivers/misc/aspeed-p2a-ctrl.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..a3cf00de9038
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/misc/aspeed-p2a-ctrl.c
> > > > > > @@ -0,0 +1,498 @@
> > > > > > +/*
> > > > > > + * Copyright 2019 Google Inc
> > > > > > + *
> > > > > > + * This program is free software; you can redistribute it and/or
> > > > > > + * modify it under the terms of the GNU General Public License
> > > > > > + * as published by the Free Software Foundation; either version
> > > > > > + * 2 of the License, or (at your option) any later version.
> > > > > > + *
> > > > > > + * Provides a simple driver to control the ASPEED P2A interface which
> > > > > > allows
> > > > > > + * the host to read and write to various regions of the BMC's memory.
> > > > > > + */
> > > > > > +
> > > > > > +#include <linux/fs.h>
> > > > > > +#include <linux/io.h>
> > > > > > +#include <linux/miscdevice.h>
> > > > > > +#include <linux/mm.h>
> > > > > > +#include <linux/module.h>
> > > > > > +#include <linux/mutex.h>
> > > > > > +#include <linux/of_address.h>
> > > > > > +#include <linux/of_device.h>
> > > > > > +#include <linux/platform_device.h>
> > > > > > +#include <linux/slab.h>
> > > > > > +#include <linux/uaccess.h>
> > > > > > +
> > > > > > +#include <linux/aspeed-p2a-ctrl.h>
> > > > > > +
> > > > > > +#define DEVICE_NAME  "aspeed-p2a-ctrl"
> > > > > > +
> > > > > > +#define SCU180_ENP2A BIT(0)
> > > > > > +
> > > > > > +/* The ast2400/2500 both have six ranges. */
> > > > > > +#define P2A_REGION_COUNT 6
> > > > > > +
> > > > > > +struct region {
> > > > > > +     u32 min;
> > > > > > +     u32 max;
> > > > > > +     u32 bit;
> > > > > > +};
> > > > > > +
> > > > > > +struct aspeed_p2a_model_data {
> > > > > > +     /* min, max, bit */
> > > > > > +     struct region regions[P2A_REGION_COUNT];
> > > > > > +};
> > > > > > +
> > > > > > +struct aspeed_p2a_ctrl {
> > > > > > +     struct miscdevice miscdev;
> > > > > > +
> > > > > > +     /* Lock access to the registers so they're is consistent. */
> > > > > > +     struct mutex lo_mutex;
> > > > > > +     void __iomem *loregs;
> > > > > > +     struct mutex hi_mutex;
> > > > > > +     void __iomem *hiregs;
> > > > >
> > > > > The naming here seems to have failed to climb the abstraction ladder.
> > > > > loregs represents the register where the P2A write control filter bits live,
> > > > > hiregs represents the PCI feature control register. I'd much prefer we name
> > > > > them as such, that way I'm not jumping through abstractions in my head
> > > > > whilst trying to understand the code. Where they live relative to eachother
> > > > > is irrelevant. ASPEED could reverse the register locations on the AST2600
> > > > > and the names wouldn't make any sense as they are now.
> > > > >
> > > > > Anyway.
> > > > >
> > > > > The SCU in general is a mess of bits controlling random parts of the SoC.
> > > > > State controlling a feature is usually mixed in with state controlling some
> > > > > other irrelevant features. This is true for the write filter controls, which live
> > > > > in e.g. SCU2C, which I assume is what you're covering with lo_mutex here.
> > > > >
> > > > > We already have a solution for this to prevent the proliferation of random
> > > > > locks - the SCU is described as a "syscon" in the devicetree - this registers
> > > > > a globally accessible regmap instance which handles all of the locking
> > > > > for you. There are a bunch of ways you can go about finding the syscon
> > > > > (see include/linux/mfd/syscon.h):
> > > > >
> > > > > extern struct regmap *syscon_node_to_regmap(struct device_node *np);
> > > > > extern struct regmap *syscon_regmap_lookup_by_compatible(const char *s);
> > > > > extern struct regmap *syscon_regmap_lookup_by_pdevname(const char *s);
> > > > > extern struct regmap *syscon_regmap_lookup_by_phandle(
> > > > >                                         struct device_node *np,
> > > > >                                         const char *property);
> > > > >
> > > > > Please rework the code to use the syscon we already have to avoid drivers
> > > > > stomping on each-other's SCU state.
> > > > >
> > > > > > +
> > > > > > +     const struct aspeed_p2a_model_data *config;
> > > > >
> > > > > We only hold one of instance of this struct at the struct aspeed_p2a_ctrl
> > > > > don't we? Why not embed it directly instead of going through a pointer?
> > > >
> > > > We only hold one, but it's based on the platform - ast2400 v 2500.  I
> > > > was of the impression this was the idiomatic way to do that.
> > >
> > > But the struct is still the same, and we can't be running on both architectures
> > > at once. It's still not clear to me why it needs to be a pointer. I could just be
> > > misunderstanding though.
> >
> > I'm honestly a little confused - probably related to all this being
> > over email and not a two-second conversation in person, c'est la vie.
> > It's a pointer because that's how I grab the correct region array for
> > the architecture at run-time in probe.  Are you suggesting I just have
> > a pointer to the array and skip the array-only structure?  It's a
> > structure partially because that's more idiomatic... at least from the
> > several drivers I examined.
> >
> > Or are you suggesting something at compile-time?  Where I have
> > defined(ARCH_G5) or something similar and just embed the data in the
> > definition of the structure?
>
> Never mind, I just wasn't clear on what was going on and hadn't tracked it
> down. That's fixed now, disregard :)
>
> >
> > >
> > > >
> > > > >
> > > > > > +
> > > > > > +     /* Access to these needs to be locked, held via probe, mapping ioctl,
> > > > > > +      * and release, remove.
> > > > > > +      */
> > > > > > +     struct mutex tracking;
> > > > > > +     u32 readers;
> > > > > > +     u32 readerwriters[P2A_REGION_COUNT];
> > > > >
> > > > > Might be better to use refcount_t here instead of u32?
> > > >
> > > > Ack
> > > >
> > > > >
> > > > > > +
> > > > > > +     phys_addr_t mem_base;
> > > > > > +     resource_size_t mem_size;
> > > > > > +     /* Because the memory_region is optional, this tracks whether it was
> > > > > > +      * set.
> > > > > > +      */
> > > > > > +     bool region_specified;
> > > > >
> > > > > Can't we imply this from e.g. `mem_base == 0 && mem_size == 0`? Can you
> > > > > just implement that in a static inline helper and avoid the extra state?
> > > >
> > > > Ack
> > > >
> > > > >
> > > > > > +};
> > > > > > +
> > > > > > +static inline u32 aspeed_p2a_read(void __iomem *base)
> > > > > > +{
> > > > > > +     return readl((void *)base);
> > > > > > +}
> > > > > > +
> > > > > > +static inline void aspeed_p2a_write(void __iomem *base, u32 val)
> > > > > > +{
> > > > > > +     writel(val, (void *)base);
> > > > > > +}
> > > > >
> > > > > I don't think these two are necessary, and you can replace them with the
> > > > > regmap helpers anyway.
> > > >
> > > > Ack
> > > >
> > > > >
> > > > > > +
> > > > > > +struct aspeed_p2a_user {
> > > > > > +     struct file *file;
> > > > > > +     struct aspeed_p2a_ctrl *parent;
> > > > > > +
> > > > > > +     /** The entire memory space is opened for reading once the bridge is
> > > > > > +      * enabled, therefore this needs only to be tracked once per user.
> > > > > > +      * If any user has it open for read, the bridge must stay enabled.
> > > > > > +      */
> > > > > > +     u32 read;
> > > > > > +
> > > > > > +     /** Each entry of the array corresponds to a P2A Region.  If the user
> > > > > > +      * opens for read or readwrite, the reference goes up here.  On
> > > > > > release,
> > > > > > +      * this array is walked and references adjusted accordingly.
> > > > > > +      */
> > > > > > +     u32 readwrite[P2A_REGION_COUNT];
> > > > >
> > > > > Do we have a scenario where a user will open the same region multiple
> > > > > times from the one fd? Supporting that seems to add a fair chunk of
> > > > > complexity and I'm not convinced it's warranted unless we have a concrete
> > > > > use case for it.
> > > >
> > > > I didn't want to restrict the driver to my one use-case.  One could
> > > > conceivably use this without the mmap portion, and use it to unlock
> > > > different regions.
> > >
> > > The question still applies in that case though - what's the use-case for unlocking
> > > one region multiple times on the one fd? Obviously we need to handle multiple
> > > fds each unlocking a region once, but I'm struggling to think of a convincing
> > > scenario where we're doing it multiple times on the one descriptor. Surely we
> > > would already have accounting in userspace to avoid the unnecesary syscall?
> >
> > I don't have an explicit use-case.  It just seemed out of place to
> > write the driver only for the use-cases I could think of, versus
> > writing a generic driver to control the P2A bridge.  What some future
> > userspace application or applications have in mind is beyond my scope.
> > Perhaps they want to unlock to disjoint regions -- ?  I'm not doing
> > this, I did it in testing to verify it worked as expected, but my
> > use-case is just unlock the region specified by the memory-address
> > used in the device-tree, and mmap that, and bob's your uncle.
> >
> > >
> > > >
> > > > >
> > > > > > +};
> > > > > > +
> > > > > > +static void aspeed_p2a_enable_bridge(struct aspeed_p2a_ctrl *p2a_ctrl)
> > > > > > +{
> > > > > > +     u32 curr_value;
> > > > > > +
> > > > > > +     mutex_lock(&p2a_ctrl->hi_mutex);
> > > > > > +     curr_value = aspeed_p2a_read(p2a_ctrl->hiregs);
> > > > > > +     curr_value |= SCU180_ENP2A;
> > > > > > +     aspeed_p2a_write(p2a_ctrl->hiregs, curr_value);
> > > > > > +     mutex_unlock(&p2a_ctrl->hi_mutex);
> > > > >
> > > > > This becomes regmap_update_bits(). Same below.
> > > >
> > > > Ack
> > > >
> > > > >
> > > > > > +}
> > > > > > +
> > > > > > +/** The bridge is controlled by bit 0 of SCU180. */
> > > > >
> > > > > The P2A is controlled by bit 1, not bit 0. Bit 0 enables/disables the entire VGA
> > > > > device on the PCI bus. I think just remove the comment? If you want it, put
> > > > > it next to the #define for SCU180_ENP2A.
> > > >
> > > > That's interesting.  During my testing, I a slightly different result,
> > > > but per the documentation you are correct...
> > >
> > > Uh, what was your slightly different result? What behaviour did you see?
> >
> > It's possible I had the system in a bad state at the time, since those
> > registers persist over BMC reboots.  So, given it's working as
> > expected at this point, I'm perfectly happy to leave it.
>
> Right.
>
> >
> > >
> > > >
> > > > >
> > > > > > +static void aspeed_p2a_disable_bridge(struct aspeed_p2a_ctrl *p2a_ctrl)
> > > > > > +{
> > > > > > +     u32 curr_value;
> > > > > > +
> > > > > > +     mutex_lock(&p2a_ctrl->hi_mutex);
> > > > > > +     curr_value = aspeed_p2a_read(p2a_ctrl->hiregs);
> > > > > > +     curr_value &= ~SCU180_ENP2A;
> > > > > > +     aspeed_p2a_write(p2a_ctrl->hiregs, curr_value);
> > > > > > +     mutex_unlock(&p2a_ctrl->hi_mutex);
> > > > > > +}
> > > > > > +
> > > > > > +static int aspeed_p2a_mmap(struct file *file, struct vm_area_struct
> > > > > > *vma)
> > > > > > +{
> > > > > > +     struct aspeed_p2a_user *priv = file->private_data;
> > > > > > +     struct aspeed_p2a_ctrl *ctrl = priv->parent;
> > > > > > +
> > > > > > +     if (!ctrl->region_specified)
> > > > > > +             return -EINVAL;
> > > > > > +
> > > > > > +     unsigned long vsize = vma->vm_end - vma->vm_start;
> > > > > > +     pgprot_t prot = vma->vm_page_prot;
> > > > > > +
> > > > > > +     if (vma->vm_pgoff + vsize > ctrl->mem_base + ctrl->mem_size)
> > > > > > +             return -EINVAL;
> > > > > > +
> > > > > > +     /* ast2400/2500 AHB accesses are not cache coherent */
> > > > > > +     prot = pgprot_noncached(prot);
> > > > > > +
> > > > > > +     if (remap_pfn_range(vma, vma->vm_start,
> > > > > > +             (ctrl->mem_base >> PAGE_SHIFT) + vma->vm_pgoff,
> > > > > > +             vsize, prot))
> > > > > > +             return -EAGAIN;
> > > > > > +
> > > > > > +     return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static void aspeed_p2a_region_search(struct aspeed_p2a_user *priv,
> > > > > > +             struct aspeed_p2a_ctrl *ctrl,
> > > > > > +             struct aspeed_p2a_ctrl_mapping *map)
> > > > >
> > > > > Bit of a bikeshed, but maybe this could be called
> > > > > aspeed_p2a_region_update() or aspeed_p2a_region_acquire() instead?
> > > > > Search implies it won't change any state, but that's not true.
> > > >
> > > > Ack.
> > > >
> > > > >
> > > > > > +{
> > > > > > +     int i;
> > > > > > +     u32 base, end;
> > > > > > +     u32 value;
> > > > > > +
> > > > > > +     base = map->addr;
> > > > > > +     end = map->addr + (map->length - 1);
> > > > > > +
> > > > > > +     /* If the value is a legal u32, it will find a match. */
> > > > > > +     for (i = 0; i < P2A_REGION_COUNT; i++) {
> > > > > > +             const struct region *curr = &ctrl->config->regions[i];
> > > > > > +
> > > > > > +             /* If the top of this region is lower than your base, skip it.
> > > > > > +              */
> > > > > > +             if (curr->max < base)
> > > > > > +                     continue;
> > > > > > +
> > > > > > +             /* If the bottom of this region is higher than your end, bail.
> > > > > > +              */
> > > > > > +             if (curr->min > end)
> > > > > > +                     break;
> > > > > > +
> > > > > > +             /* Lock this and update it, therefore it someone else is
> > > > > > +              * closing their file out, this'll preserve the increment.
> > > > > > +              */
> > > > > > +             mutex_lock(&ctrl->tracking);
> > > > > > +             ctrl->readerwriters[i] += 1;
> > > > > > +             mutex_unlock(&ctrl->tracking);
> > > > > > +
> > > > > > +             /* Track with the user, so when they close their file, we can
> > > > > > +              * decrement properly.
> > > > > > +              */
> > > > > > +             priv->readwrite[i] += 1;
> > > > > > +
> > > > > > +             /* Enable the region as read-write. */
> > > > > > +             mutex_lock(&ctrl->lo_mutex);
> > > > > > +             value = aspeed_p2a_read(ctrl->loregs);
> > > > > > +             value &= ~curr->bit;
> > > > > > +             aspeed_p2a_write(ctrl->loregs, value);
> > > > > > +             mutex_unlock(&ctrl->lo_mutex);
> > > > > > +     }
> > > > > > +}
> > > > > > +
> > > > > > +static long aspeed_p2a_ioctl(struct file *file, unsigned int cmd,
> > > > > > +             unsigned long data)
> > > > > > +{
> > > > > > +     struct aspeed_p2a_user *priv = file->private_data;
> > > > > > +     struct aspeed_p2a_ctrl *ctrl = priv->parent;
> > > > > > +     void __user *arg = (void __user *)data;
> > > > > > +     struct aspeed_p2a_ctrl_mapping map;
> > > > > > +     int i;
> > > > > > +
> > > > > > +     switch (cmd) {
> > > > > > +     case ASPEED_P2A_CTRL_IOCTL_SET_WINDOW:
> > > > > > +             if (copy_from_user(&map, arg, sizeof(map)))
> > > > > > +                     return -EFAULT;
> > > > > > +
> > > > > > +             /* If they want a region to be read-only, since the entire
> > > > > > +              * region is read-only once enabled, we just need to track this
> > > > > > +              * user wants to read from the bridge, and if it's not enabled.
> > > > > > +              * Enable it.
> > > > > > +              */
> > > > > > +             if (map.flags == ASPEED_P2A_CTRL_READ_ONLY) {
> > > > > > +                     mutex_lock(&ctrl->tracking);
> > > > > > +                     ctrl->readers += 1;
> > > > > > +                     mutex_unlock(&ctrl->tracking);
> > > > > > +
> > > > > > +                     /* Track with the user, so when they close their file,
> > > > > > +                      * we can decrement properly.
> > > > > > +                      */
> > > > > > +                     priv->read += 1;
> > > > > > +             } else if (map.flags == ASPEED_P2A_CTRL_READWRITE) {
> > > > > > +                     aspeed_p2a_region_search(priv, ctrl, &map);
> > > > >
> > > > > See, this looks a bit strange with the function called _search(), as you're
> > > > > not doing anything with a result - and there can't be a result as the function
> > > > > returns void.
> > > >
> > > > Ack
> > > >
> > > > >
> > > > > > +             } else {
> > > > > > +                     /* Invalid map flags. */
> > > > > > +                     return -EINVAL;
> > > > > > +             }
> > > > > > +
> > > > > > +             aspeed_p2a_enable_bridge(ctrl);
> > > > > > +             return 0;
> > > > > > +     }
> > > > > > +
> > > > > > +     return -EINVAL;
> > > > > > +}
> > > > > > +
> > > > > > +
> > > > > > +/**
> > > > > > + * When a user opens this file, we create a structure to track their
> > > > > > mappings.
> > > > > > + *
> > > > > > + * A user can map a region as read-only (bridge enabled), or
> > > > > > read-write (bit
> > > > > > + * flipped, and bridge enabled).  Either way, this tracking is used,
> > > > > > s.t. when
> > > > > > + * they release the device references are handled.
> > > > > > + *
> > > > > > + * The bridge is not enabled until a user calls an ioctl to map a
> > > > > > region,
> > > > > > + * simply opening the device does not enable it.
> > > > > > + */
> > > > > > +static int aspeed_p2a_open(struct inode *inode, struct file *file)
> > > > > > +{
> > > > > > +     struct aspeed_p2a_user *priv;
> > > > > > +
> > > > > > +     priv = kmalloc(sizeof(*priv), GFP_KERNEL);
> > > > > > +     if (!priv)
> > > > > > +             return -ENOMEM;
> > > > > > +
> > > > > > +     priv->file = file;
> > > > > > +     priv->read = 0;
> > > > > > +     memset(priv->readwrite, 0, sizeof(priv->readwrite));
> > > > > > +
> > > > > > +     /* The file's private_data is initialized to the p2a_ctrl. */
> > > > > > +     priv->parent = file->private_data;
> > > > > > +
> > > > > > +     /* Set the file's private_data to the user's data. */
> > > > > > +     file->private_data = priv;
> > > > > > +
> > > > > > +     return 0;
> > > > > > +}
> > > > > > +
> > > > > > +/**
> > > > > > + * This will close the users mappings.  It will go through what they
> > > > > > had opened
> > > > > > + * for readwrite, and decrement those counts.  If at the end, this is
> > > > > > the last
> > > > > > + * user, it'll close the bridge.
> > > > > > + */
> > > > > > +static int aspeed_p2a_release(struct inode *inode, struct file *file)
> > > > > > +{
> > > > > > +     int i;
> > > > > > +     u32 value;
> > > > > > +     u32 bits = 0;
> > > > > > +     bool open_regions = false;
> > > > > > +     struct aspeed_p2a_user *priv = file->private_data;
> > > > > > +
> > > > > > +     mutex_lock(&priv->parent->tracking);
> > > > > > +     priv->parent->readers -= priv->read;
> > > > > > +
> > > > > > +     for (i = 0; i < P2A_REGION_COUNT; i++) {
> > > > > > +             priv->parent->readerwriters[i] -= priv->readwrite[i];
> > > > > > +
> > > > > > +             if (priv->parent->readerwriters[i] > 0)
> > > > > > +                     open_regions = true;
> > > > > > +             else
> > > > > > +                     bits |= priv->parent->config->regions[i].bit;
> > > > > > +     }
> > > > > > +
> > > > > > +     /* Setting a bit to 1 disables the region, so let's just OR with the
> > > > > > +      * above to disable any.
> > > > > > +      */
> > > > > > +
> > > > > > +     /* Note, if another user is trying to ioctl, they can't grab tracking,
> > > > > > +      * and therefore can't grab either register mutex.
> > > > > > +      * If another user is trying to close, they can't grab tracking
> > > > > > either.
> > > > > > +      */
> > > > > > +     mutex_lock(&priv->parent->lo_mutex);
> > > > > > +     value = aspeed_p2a_read(priv->parent->loregs);
> > > > > > +     value |= bits;
> > > > > > +     aspeed_p2a_write(priv->parent->loregs, value);
> > > > > > +     mutex_unlock(&priv->parent->lo_mutex);
> > > > > > +
> > > > > > +     /* If parent->readers is zero and open windows is 0, disable the
> > > > > > +      * bridge.
> > > > > > +      */
> > > > > > +     if (!open_regions && priv->parent->readers == 0)
> > > > > > +             aspeed_p2a_disable_bridge(priv->parent);
> > > > > > +
> > > > > > +     mutex_unlock(&priv->parent->tracking);
> > > > > > +
> > > > > > +     kfree(priv);
> > > > > > +
> > > > > > +     return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static const struct file_operations aspeed_p2a_ctrl_fops = {
> > > > > > +     .owner = THIS_MODULE,
> > > > > > +     .mmap = aspeed_p2a_mmap,
> > > > > > +     .unlocked_ioctl = aspeed_p2a_ioctl,
> > > > > > +     .open = aspeed_p2a_open,
> > > > > > +     .release = aspeed_p2a_release,
> > > > > > +};
> > > > > > +
> > > > > > +/** The regions are controlled by SCU2C */
> > > > > > +static void aspeed_p2a_disable_all(struct aspeed_p2a_ctrl *p2a_ctrl)
> > > > > > +{
> > > > > > +     int i;
> > > > > > +     u32 value = 0;
> > > > > > +     u32 curr_value;
> > > > > > +
> > > > > > +     for (i = 0; i < P2A_REGION_COUNT; i++)
> > > > > > +             value |= p2a_ctrl->config->regions[i].bit;
> > > > > > +
> > > > > > +     mutex_lock(&p2a_ctrl->lo_mutex);
> > > > > > +     curr_value = aspeed_p2a_read(p2a_ctrl->loregs);
> > > > > > +     curr_value |= value;
> > > > > > +     aspeed_p2a_write(p2a_ctrl->loregs, curr_value);
> > > > > > +     mutex_unlock(&p2a_ctrl->lo_mutex);
> > > > > > +
> > > > > > +     /* Disable the bridge. */
> > > > > > +     aspeed_p2a_disable_bridge(p2a_ctrl);
> > > > > > +}
> > > > > > +
> > > > > > +static int aspeed_p2a_ctrl_probe(struct platform_device *pdev)
> > > > > > +{
> > > > > > +     struct aspeed_p2a_ctrl *p2a_ctrl;
> > > > > > +     struct device *dev;
> > > > > > +     struct resource *res, resm;
> > > > > > +     struct device_node *node;
> > > > > > +     int rc = 0;
> > > > > > +     u32 twosee, oneeighty;
> > > > >
> > > > > How about "misc_ctrl" and "pci_cscr"?
> > > >
> > > > Ack
> > > >
> > > > >
> > > > > > +
> > > > > > +     dev = &pdev->dev;
> > > > > > +
> > > > > > +     p2a_ctrl = devm_kzalloc(dev, sizeof(*p2a_ctrl), GFP_KERNEL);
> > > > > > +     if (!p2a_ctrl)
> > > > > > +             return -ENOMEM;
> > > > > > +
> > > > > > +     mutex_init(&p2a_ctrl->tracking);
> > > > > > +     p2a_ctrl->readers = 0;
> > > > > > +     memset(p2a_ctrl->readerwriters, 0, sizeof(p2a_ctrl->readerwriters));
> > > > > > +
> > > > > > +     p2a_ctrl->mem_size = 0;
> > > > > > +     p2a_ctrl->mem_base = 0;
> > > > > > +     p2a_ctrl->region_specified = false;
> > > > > > +
> > > > > > +     /* optional. */
> > > > > > +     node = of_parse_phandle(dev->of_node, "memory-region", 0);
> > > > > > +     if (node) {
> > > > > > +             rc = of_address_to_resource(node, 0, &resm);
> > > > > > +             of_node_put(node);
> > > > > > +             if (rc) {
> > > > > > +                     dev_err(dev, "Couldn't address to resource for reserved memory\n");
> > > > > > +                     return -ENOMEM;
> > > > > > +             }
> > > > > > +
> > > > > > +             p2a_ctrl->mem_size = resource_size(&resm);
> > > > > > +             p2a_ctrl->mem_base = resm.start;
> > > > > > +             p2a_ctrl->region_specified = true;
> > > > > > +     }
> > > > > > +
> > > > > > +     p2a_ctrl->config = of_device_get_match_data(dev);
> > > > > > +
> > > > > > +     /* This is the SCU2C handle. */
> > > > > > +     mutex_init(&p2a_ctrl->lo_mutex);
> > > > > > +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > > > > +     p2a_ctrl->loregs = devm_ioremap_resource(dev, res);
> > > > > > +     if (IS_ERR(p2a_ctrl->loregs)) {
> > > > > > +             dev_err(dev, "Unable to remap resource 0\n");
> > > > > > +             return PTR_ERR(p2a_ctrl->loregs);
> > > > > > +     }
> > > > > > +
> > > > > > +     twosee = aspeed_p2a_read(p2a_ctrl->loregs);
> > > > >
> > > > > You don't use this value? Why read it?
> > > >
> > > > Originally I was printing it as a sanity-test.  Deleted the printing
> > > > and not this.
> > > > >
> > > > > > +
> > > > > > +     /* This is the SCU180 handle. */
> > > > > > +     mutex_init(&p2a_ctrl->hi_mutex);
> > > > > > +     res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > > > > > +     p2a_ctrl->hiregs = devm_ioremap_resource(dev, res);
> > > > > > +     if (IS_ERR(p2a_ctrl->hiregs)) {
> > > > > > +             dev_err(dev, "Unable to remap resource 1\n");
> > > > > > +             return PTR_ERR(p2a_ctrl->hiregs);
> > > > > > +     }
> > > > > > +
> > > > > > +     oneeighty = aspeed_p2a_read(p2a_ctrl->hiregs);
> > > > >
> > > > > You don't use this value, why read ti?
> > > >
> > > > Same as above.  Debug leftovers.
> > > > >
> > > > > > +
> > > > > > +     dev_set_drvdata(&pdev->dev, p2a_ctrl);
> > > > > > +
> > > > > > +     p2a_ctrl->miscdev.minor = MISC_DYNAMIC_MINOR;
> > > > > > +     p2a_ctrl->miscdev.name = DEVICE_NAME;
> > > > > > +     p2a_ctrl->miscdev.fops = &aspeed_p2a_ctrl_fops;
> > > > > > +     p2a_ctrl->miscdev.parent = dev;
> > > > > > +     rc = misc_register(&p2a_ctrl->miscdev);
> > > > > > +     if (rc) {
> > > > > > +             dev_err(dev, "Unable to register device\n");
> > > > > > +             goto err;
> > > > > > +     }
> > > > > > +
> > > > > > +     aspeed_p2a_disable_all(p2a_ctrl);
> > > > >
> > > > > Do this before registering the misc device otherwise I think you're at
> > > > > risk of racing userspace to initialising the P2A state. Maybe that's not
> > > > > a problem, but we don't have to try reason about it if you move it up.
> > > >
> > > > Ack
> > > >
> > > > >
> > > > > > +
> > > > > > +err:
> > > > > > +     return rc;
> > > > > > +}
> > > > > > +
> > > > > > +static int aspeed_p2a_ctrl_remove(struct platform_device *pdev)
> > > > > > +{
> > > > > > +     struct aspeed_p2a_ctrl *p2a_ctrl = dev_get_drvdata(&pdev->dev);
> > > > > > +
> > > > > > +     misc_deregister(&p2a_ctrl->miscdev);
> > > > > > +
> > > > > > +     return 0;
> > > > > > +}
> > > > > > +
> > > > > > +/*
> > > > > > + * bit | SCU2C | ast2400
> > > > > > + *  25 | DRAM  | 0x40000000 - 0x5FFFFFFF
> > > > > > + *  24 | SPI   | 0x30000000 - 0x3FFFFFFF
> > > > > > + *  23 | SOC   | 0x18000000 - 0x1FFFFFFF, 0x60000000 - 0xFFFFFFFF
> > > > > > + *  22 | FLASH | 0x00000000 - 0x17FFFFFF, 0x20000000 - 0x2FFFFFFF
> > > > > > + *
> > > > > > + * bit | SCU2C | ast2500
> > > > > > + *  25 | DRAM  | 0x80000000 - 0xFFFFFFFF
> > > > > > + *  24 | SPI   | 0x60000000 - 0x7FFFFFFF
> > > > > > + *  23 | SOC   | 0x10000000 - 0x1FFFFFFF, 0x40000000 - 0x5FFFFFFF
> > > > > > + *  22 | FLASH | 0x00000000 - 0x0FFFFFFF, 0x20000000 - 0x3FFFFFFF
> > > > > > + */
> > > > > > +
> > > > > > +#define SCU2C_DRAM   BIT(25)
> > > > > > +#define SCU2C_SPI    BIT(24)
> > > > > > +#define SCU2C_SOC    BIT(23)
> > > > > > +#define SCU2C_FLASH  BIT(22)
> > > > > > +
> > > > > > +static const struct aspeed_p2a_model_data ast2400_model_data = {
> > > > > > +     .regions = {
> > > > > > +             {0x00000000, 0x17FFFFFF, SCU2C_FLASH},
> > > > > > +             {0x18000000, 0x1FFFFFFF, SCU2C_SOC},
> > > > > > +             {0x20000000, 0x2FFFFFFF, SCU2C_FLASH},
> > > > > > +             {0x30000000, 0x3FFFFFFF, SCU2C_SPI},
> > > > > > +             {0x40000000, 0x5FFFFFFF, SCU2C_DRAM},
> > > > > > +             {0x60000000, 0xFFFFFFFF, SCU2C_SOC},
> > > > > > +     }
> > > > > > +};
> > > > > > +
> > > > > > +static const struct aspeed_p2a_model_data ast2500_model_data = {
> > > > > > +     .regions = {
> > > > > > +             {0x00000000, 0x0FFFFFFF, SCU2C_FLASH},
> > > > > > +             {0x10000000, 0x1FFFFFFF, SCU2C_SOC},
> > > > > > +             {0x20000000, 0x3FFFFFFF, SCU2C_FLASH},
> > > > > > +             {0x40000000, 0x5FFFFFFF, SCU2C_SOC},
> > > > > > +             {0x60000000, 0x7FFFFFFF, SCU2C_SPI},
> > > > > > +             {0x80000000, 0xFFFFFFFF, SCU2C_DRAM},
> > > > > > +     }
> > > > > > +};
> > > > > > +
> > > > > > +static const struct of_device_id aspeed_p2a_ctrl_match[] = {
> > > > > > +     { .compatible = "aspeed,ast2400-p2a-ctrl",
> > > > > > +       .data = &ast2400_model_data },
> > > > > > +     { .compatible = "aspeed,ast2500-p2a-ctrl",
> > > > > > +       .data = &ast2500_model_data },
> > > > > > +     { },
> > > > > > +};
> > > > > > +
> > > > > > +static struct platform_driver aspeed_p2a_ctrl_driver = {
> > > > > > +     .driver = {
> > > > > > +             .name           = DEVICE_NAME,
> > > > > > +             .of_match_table = aspeed_p2a_ctrl_match,
> > > > > > +     },
> > > > > > +     .probe = aspeed_p2a_ctrl_probe,
> > > > > > +     .remove = aspeed_p2a_ctrl_remove,
> > > > > > +};
> > > > > > +
> > > > > > +module_platform_driver(aspeed_p2a_ctrl_driver);
> > > > > > +
> > > > > > +MODULE_DEVICE_TABLE(of, aspeed_p2a_ctrl_match);
> > > > > > +MODULE_LICENSE("GPL");
> > > > > > +MODULE_AUTHOR("Patrick Venture <venture@google.com>");
> > > > > > +MODULE_DESCRIPTION("Control for aspeed 2400/2500 P2A VGA HOST to BMC
> > > > > > mappings");
> > > > > > diff --git a/include/uapi/linux/aspeed-p2a-ctrl.h
> > > > > > b/include/uapi/linux/aspeed-p2a-ctrl.h
> > > > > > new file mode 100644
> > > > > > index 000000000000..473b62efb94c
> > > > > > --- /dev/null
> > > > > > +++ b/include/uapi/linux/aspeed-p2a-ctrl.h
> > > > > > @@ -0,0 +1,46 @@
> > > > > > +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> > > > > > +/*
> > > > > > + * Copyright 2019 Google Inc
> > > > > > + *
> > > > > > + * This program is free software; you can redistribute it and/or
> > > > > > + * modify it under the terms of the GNU General Public License
> > > > > > + * as published by the Free Software Foundation; either version
> > > > > > + * 2 of the License, or (at your option) any later version.
> > > > > > + *
> > > > > > + * Provides a simple driver to control the ASPEED P2A interface which
> > > > > > allows
> > > > > > + * the host to read and write to various regions of the BMC's memory.
> > > > > > + */
> > > > > > +
> > > > > > +#ifndef _UAPI_LINUX_ASPEED_P2A_CTRL_H
> > > > > > +#define _UAPI_LINUX_ASPEED_P2A_CTRL_H
> > > > > > +
> > > > > > +#include <linux/ioctl.h>
> > > > > > +#include <linux/types.h>
> > > > > > +
> > > > > > +#define ASPEED_P2A_CTRL_READ_ONLY 0
> > > > > > +#define ASPEED_P2A_CTRL_READWRITE 1
> > > > > > +
> > > > > > +/*
> > > > > > + * This driver provides a mechanism for enabling or disabling the
> > > > > > read-write
> > > > > > + * property of specific windows into the ASPEED BMC's memory.
> > > > > > + *
> > > > > > + * A user can map a region of the BMC's memory as read-only or
> > > > > > read-write, with
> > > > > > + * the caveat that once any region is mapped, all regions are unlocked
> > > > > > for
> > > > > > + * reading.
> > > > > > + */
> > > > > > +
> > > > > > +/**
> > > > > > + * Unlock a region of BMC physical memory for access from the host.
> > > > > > + */
> > > > > > +struct aspeed_p2a_ctrl_mapping {
> > > > > > +     __u32 addr;
> > > > > > +     __u32 length;
> > > > > > +     __u32 flags;
> > > > > > +};
> > > > > > +
> > > > > > +#define __ASPEED_P2A_CTRL_IOCTL_MAGIC 0xb3
> > > > > > +
> > > > > > +#define ASPEED_P2A_CTRL_IOCTL_SET_WINDOW
> > > > > > _IOW(__ASPEED_P2A_CTRL_IOCTL_MAGIC, \
> > > > > > +             0x00, struct aspeed_p2a_ctrl_mapping)
> > > > > > +
> > > > > > +#endif /* _UAPI_LINUX_ASPEED_P2A_CTRL_H */
> > > > >
> > > > > How does the BMC report to the host what region of memory to write
> > > > > to? Are you scraping around in sysfs to learn the address of the
> > > > > reserved memory region? Or are you enforcing some ABI between
> > > > > the BMC and the host that defines the address? There's no means
> > > > > exposed here to learn the address.
> > > >
> > > > Right now, there, as you can see, is no way for this to be read
> > > > (similarly to the aspeed-lpc-ctrl driver).
> > >
> > > We can learn the size of the mapped memory via an ioctl() on the
> > > aspeed-lpc-ctrl chardev (ASPEED_LPC_CTRL_IOCTL_GET_SIZE), and then
> > > the LPC FWH address can be inferred from there (always measure backwards
> > > from the top of the FWH address space).
> >
> > FWH?  I'm not sure what this means.
>
> Expands to FirmWare Hub. An LPC firmware memory cycle. It can address up to
> 28 bits worth of data on a device.

Ok, well, with the PCI address, knowing the size is insufficient.
Because the base address could be anywhere.  What if I have an ioctl
that returns the memory-region configuration?  Base & Size.
