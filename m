Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940DDC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4460721924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDTFTGll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfBHWFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:05:52 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:42964 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbfBHWFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 17:05:49 -0500
Received: by mail-ua1-f65.google.com with SMTP id d21so1630596uap.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 14:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B8lrx4z+ZYKYQjXY8dFvbSd9MeGo+vdRw53QUi8L9Co=;
        b=FDTFTGll26owwCIln7dALUqVqAiOFykGpW3ZmbMHZuXA9efsQLHgDziUuVhjPDqkJr
         yPs/4C17GWowtifhL9JsowJHh00xMNBBxtuKLJGvJfhrS1HUdsveB1wHtF1WG45RxHo3
         5+64EmeTQ8IqgPJpAm+ABq6A0CVjzRPG9G/fCAxsckCtQHStrR6iJ7SD0mGtWpMCD6VA
         ej7bLO5/mUaUgm4xE25Z4vMf4ff/o8sUXsMKj7zy4acK1d/ZmjJkKlqXqMSrp85aPkL4
         LmFTwuhRNoU9EO1oZLopfdKy4xRgV2aHjhnlCk3XvsKwNmjTwiisiengD5Vy65EkDaO2
         9UOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B8lrx4z+ZYKYQjXY8dFvbSd9MeGo+vdRw53QUi8L9Co=;
        b=cgFuRHZ8r0qfYEWhTuFN6Lf0I3r6Ys26kmPATiTDILvm3BRgloZQhtDHKGQmGDzQf3
         jPCpfmkPUc3b+G1UEC7WefrOxRzKw9phpPfRAt0mqcVHMg1W5VPlxu47c5kxjkE73+UI
         5TbIuWtMcep/+SdsdAZQmAdzCgqefe1nKz/kAPPE/dGBwXTQI0xtDYq5Bbs3ggrCpZlP
         VyCLQlub7DTRCIv68VfYT2UvbC69gyBnezWJyNmCKRTbXiQw2fjD+hfkE75jnU6akYpc
         G7zYmRlLE/cqFVj9hbvP52fP8jeEoQYNu134WtgjBi+nO65F1FHK2ElXyiffhwFd7MZZ
         lN3Q==
X-Gm-Message-State: AHQUAuazdrKXkfgHP+0XQ5Lxkcysv9uaOWpWU21/P5GVqvkOdG8l1KuE
        eZQXh+DN0xDZyQHy7KE6M7aL/5f92gpQlSez38U=
X-Google-Smtp-Source: AHgI3IafR+QFq91D9cocA6LwlVNO0MdXkdEeSXzAUDwdodYk6qFkXJx7p+s39yVvgUJEVhaEdRknsga5iGfe3f2kcrI=
X-Received: by 2002:ab0:69ca:: with SMTP id u10mr8852533uaq.57.1549663547309;
 Fri, 08 Feb 2019 14:05:47 -0800 (PST)
MIME-Version: 1.0
References: <20190130220617.4862-1-oded.gabbay@gmail.com> <20190203114957.GD8620@rapoport-lnx>
 <CAFCwf12pB9e++ReBaPYNwW-Am1_Op4p_rQzdS5C6ndFTdbXX3w@mail.gmail.com>
In-Reply-To: <CAFCwf12pB9e++ReBaPYNwW-Am1_Op4p_rQzdS5C6ndFTdbXX3w@mail.gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sat, 9 Feb 2019 00:05:23 +0200
Message-ID: <CAFCwf13Jcrr6qHaDRXHPy67NsG-7WuxocZp_uMG-7vZ=AW1Pqw@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] Habana Labs kernel driver
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>, ogabbay@habana.ai,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 3, 2019 at 10:35 PM Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> On Sun, Feb 3, 2019 at 1:50 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > Hi Oded,
> >
> > On Thu, Jan 31, 2019 at 12:06:02AM +0200, Oded Gabbay wrote:
> > > Hello,
> > > This is v2 of the Habana Labs kernel driver patch-set. It contains fixes
> > > for almost everything that was brought up in the review of v1.
> > >
> > > In addition to local changes in each patch that are detailed in each
> > > patch's commit message, the global/major changes are:
> > >
> > > - Rebased on v5.0-rc4
> > > - Removed all bitfields from interface files to H/W and F/W
> > > - Use __le16/32/64 instead of __u16/32/64 in F/W or H/W structures
> >
> > For v2 I had comments only for "[PATCH v2 07/15] habanalabs: add h/w queues
> > module".
> >
> > There are still several over-exited printk calls with three exclamation
> > marks. ;-)
> >
> > I've also spotted several places where checkpatch.pl may complain, but I
> > was to lazy to actually check it.
> >
> > > Link to v1 cover letter: https://lwn.net/Articles/777342/
> > >
> > > I would appricate any feedback, question and/or review.
> > >
> > > Thanks,
> > > Oded
> > >
> > > p.s. for those who prefer to clone the tree instead of looking at the
> > > emails, you can grab a copy from our company's page in GitHub:
> > >
> > > https://github.com/HabanaAI/linux/releases/tag/hl_patchset_v2_20190130
> > >
> > > Oded Gabbay (14):
> > >   habanalabs: add skeleton driver
> > >   habanalabs: add Goya registers header files
> >
> > This one is 4.3M which is 6 times the entire habanalabs driver without
> > those headers.
> > Any chance some of it can be dropped?
> Hi Mike,
> Managed to remove about 30 files (~1.5MB) from this patch. The patch
> now is around 2.9MB
> Unfortunately, I don't see how I can reduce it much more without
> seriously reducing the readability and maintainability of the driver.
>
> Oded
Thought about another idea how to reduce the size of this patch.
I will separate the registers from the MASK and SHIFT defines into two
files per H/W block.
For most of the blocks, I only need the registers file, without all
the MASK and SHIFT defines of the fields, so I think this will reduce
most of the patch size.
I'm talking to our devOps to create for me the new set of files from
the H/W database and will update on the results, probably by end of
next week.

Oded

>
> >
> > >   habanalabs: add basic Goya support
> > >   habanalabs: add context and ASID modules
> > >   habanalabs: add command buffer module
> > >   habanalabs: add basic Goya h/w initialization
> > >   habanalabs: add h/w queues module
> > >   habanalabs: add event queue and interrupts
> > >   habanalabs: add sysfs and hwmon support
> > >   habanalabs: add device reset support
> > >   habanalabs: add command submission module
> > >   habanalabs: implement INFO IOCTL
> > >   habanalabs: add debugfs support
> > >   Update MAINTAINERS and CREDITS with habanalabs info
> > >
> > > Omer Shpigelman (1):
> > >   habanalabs: add virtual memory and MMU modules
> > >
> > >  CREDITS                                       |    2 +-
> > >  .../ABI/testing/debugfs-driver-habanalabs     |  127 +
> > >  .../ABI/testing/sysfs-driver-habanalabs       |  190 +
> > >  MAINTAINERS                                   |    9 +
> > >  drivers/misc/Kconfig                          |    1 +
> > >  drivers/misc/Makefile                         |    1 +
> > >  drivers/misc/habanalabs/Kconfig               |   22 +
> > >  drivers/misc/habanalabs/Makefile              |   15 +
> > >  drivers/misc/habanalabs/asid.c                |   58 +
> > >  drivers/misc/habanalabs/command_buffer.c      |  432 +
> > >  drivers/misc/habanalabs/command_submission.c  |  787 ++
> > >  drivers/misc/habanalabs/context.c             |  216 +
> > >  drivers/misc/habanalabs/debugfs.c             | 1071 ++
> > >  drivers/misc/habanalabs/device.c              | 1110 ++
> > >  drivers/misc/habanalabs/goya/Makefile         |    4 +
> > >  drivers/misc/habanalabs/goya/goya.c           | 5338 ++++++++++
> > >  drivers/misc/habanalabs/goya/goyaP.h          |  193 +
> > >  drivers/misc/habanalabs/goya/goya_hwmgr.c     |  306 +
> > >  drivers/misc/habanalabs/goya/goya_security.c  | 2999 ++++++
> > >  drivers/misc/habanalabs/habanalabs.h          | 1448 +++
> > >  drivers/misc/habanalabs/habanalabs_drv.c      |  469 +
> > >  drivers/misc/habanalabs/habanalabs_ioctl.c    |  234 +
> > >  drivers/misc/habanalabs/hw_queue.c            |  654 ++
> > >  drivers/misc/habanalabs/hwmon.c               |  449 +
> > >  drivers/misc/habanalabs/include/armcp_if.h    |  335 +
> > >  .../include/goya/asic_reg/cpu_ca53_cfg_regs.h |  213 +
> > >  .../include/goya/asic_reg/cpu_if_regs.h       |  110 +
> > >  .../include/goya/asic_reg/cpu_pll_regs.h      |  186 +
> > >  .../include/goya/asic_reg/ddr_mc_ch0_regs.h   | 1158 +++
> > >  .../include/goya/asic_reg/ddr_mc_ch1_regs.h   | 1158 +++
> > >  .../include/goya/asic_reg/ddr_misc_ch0_regs.h |  156 +
> > >  .../include/goya/asic_reg/ddr_misc_ch1_regs.h |  156 +
> > >  .../include/goya/asic_reg/dma_ch_0_regs.h     |  512 +
> > >  .../include/goya/asic_reg/dma_ch_1_regs.h     |  512 +
> > >  .../include/goya/asic_reg/dma_ch_2_regs.h     |  512 +
> > >  .../include/goya/asic_reg/dma_ch_3_regs.h     |  512 +
> > >  .../include/goya/asic_reg/dma_ch_4_regs.h     |  512 +
> > >  .../include/goya/asic_reg/dma_macro_regs.h    |  242 +
> > >  .../include/goya/asic_reg/dma_nrtr_regs.h     |  380 +
> > >  .../include/goya/asic_reg/dma_qm_0_regs.h     |  543 +
> > >  .../include/goya/asic_reg/dma_qm_1_regs.h     |  543 +
> > >  .../include/goya/asic_reg/dma_qm_2_regs.h     |  543 +
> > >  .../include/goya/asic_reg/dma_qm_3_regs.h     |  543 +
> > >  .../include/goya/asic_reg/dma_qm_4_regs.h     |  543 +
> > >  .../include/goya/asic_reg/gic_regs.h          | 9079 +++++++++++++++++
> > >  .../include/goya/asic_reg/goya_blocks.h       | 1372 +++
> > >  .../include/goya/asic_reg/goya_masks.h        |  262 +
> > >  .../include/goya/asic_reg/goya_regs.h         |  119 +
> > >  .../include/goya/asic_reg/ic_pll_regs.h       |  186 +
> > >  .../include/goya/asic_reg/mc_pll_regs.h       |  186 +
> > >  .../include/goya/asic_reg/mme1_rtr_regs.h     |  876 ++
> > >  .../include/goya/asic_reg/mme2_rtr_regs.h     |  876 ++
> > >  .../include/goya/asic_reg/mme3_rtr_regs.h     |  876 ++
> > >  .../include/goya/asic_reg/mme4_rtr_regs.h     |  876 ++
> > >  .../include/goya/asic_reg/mme5_rtr_regs.h     |  876 ++
> > >  .../include/goya/asic_reg/mme6_rtr_regs.h     |  876 ++
> > >  .../include/goya/asic_reg/mme_cmdq_regs.h     |  431 +
> > >  .../include/goya/asic_reg/mme_qm_regs.h       |  543 +
> > >  .../include/goya/asic_reg/mme_regs.h          | 2422 +++++
> > >  .../include/goya/asic_reg/mmu_regs.h          |  158 +
> > >  .../include/goya/asic_reg/pci_nrtr_regs.h     |  380 +
> > >  .../include/goya/asic_reg/pcie_aux_regs.h     |  476 +
> > >  .../include/goya/asic_reg/pcie_dbi_regs.h     | 2909 ++++++
> > >  .../goya/asic_reg/psoc_emmc_pll_regs.h        |  186 +
> > >  .../goya/asic_reg/psoc_global_conf_regs.h     | 1119 ++
> > >  .../include/goya/asic_reg/psoc_mme_pll_regs.h |  186 +
> > >  .../include/goya/asic_reg/psoc_pci_pll_regs.h |  186 +
> > >  .../include/goya/asic_reg/psoc_spi_regs.h     |  427 +
> > >  .../goya/asic_reg/sram_y0_x0_rtr_regs.h       |  215 +
> > >  .../goya/asic_reg/sram_y0_x1_rtr_regs.h       |  215 +
> > >  .../goya/asic_reg/sram_y0_x2_rtr_regs.h       |  215 +
> > >  .../goya/asic_reg/sram_y0_x3_rtr_regs.h       |  215 +
> > >  .../goya/asic_reg/sram_y0_x4_rtr_regs.h       |  215 +
> > >  .../goya/asic_reg/sram_y1_x0_rtr_regs.h       |  215 +
> > >  .../goya/asic_reg/sram_y1_x1_rtr_regs.h       |  215 +
> > >  .../goya/asic_reg/sram_y1_x2_rtr_regs.h       |  215 +
> > >  .../goya/asic_reg/sram_y1_x3_rtr_regs.h       |  215 +
> > >  .../goya/asic_reg/sram_y1_x4_rtr_regs.h       |  215 +
> > >  .../goya/asic_reg/sram_y2_x0_rtr_regs.h       |  215 +
> > >  .../goya/asic_reg/sram_y2_x1_rtr_regs.h       |  215 +
> > >  .../goya/asic_reg/sram_y2_x2_rtr_regs.h       |  215 +
> > >  .../goya/asic_reg/sram_y2_x3_rtr_regs.h       |  215 +
> > >  .../goya/asic_reg/sram_y2_x4_rtr_regs.h       |  215 +
> > >  .../goya/asic_reg/sram_y3_x0_rtr_regs.h       |  215 +
> > >  .../goya/asic_reg/sram_y3_x1_rtr_regs.h       |  215 +
> > >  .../goya/asic_reg/sram_y3_x2_rtr_regs.h       |  215 +
> > >  .../goya/asic_reg/sram_y3_x3_rtr_regs.h       |  215 +
> > >  .../goya/asic_reg/sram_y3_x4_rtr_regs.h       |  215 +
> > >  .../goya/asic_reg/sram_y4_x0_rtr_regs.h       |  215 +
> > >  .../goya/asic_reg/sram_y4_x1_rtr_regs.h       |  215 +
> > >  .../goya/asic_reg/sram_y4_x2_rtr_regs.h       |  215 +
> > >  .../goya/asic_reg/sram_y4_x3_rtr_regs.h       |  215 +
> > >  .../goya/asic_reg/sram_y4_x4_rtr_regs.h       |  215 +
> > >  .../goya/asic_reg/sram_y5_x0_rtr_regs.h       |  215 +
> > >  .../goya/asic_reg/sram_y5_x1_rtr_regs.h       |  215 +
> > >  .../goya/asic_reg/sram_y5_x2_rtr_regs.h       |  215 +
> > >  .../goya/asic_reg/sram_y5_x3_rtr_regs.h       |  215 +
> > >  .../goya/asic_reg/sram_y5_x4_rtr_regs.h       |  215 +
> > >  .../include/goya/asic_reg/stlb_regs.h         |  133 +
> > >  .../include/goya/asic_reg/sync_mngr_regs.h    | 4930 +++++++++
> > >  .../include/goya/asic_reg/tpc0_cfg_regs.h     | 2110 ++++
> > >  .../include/goya/asic_reg/tpc0_cmdq_regs.h    |  431 +
> > >  .../include/goya/asic_reg/tpc0_eml_cfg_regs.h |  580 ++
> > >  .../include/goya/asic_reg/tpc0_nrtr_regs.h    |  380 +
> > >  .../include/goya/asic_reg/tpc0_qm_regs.h      |  543 +
> > >  .../include/goya/asic_reg/tpc1_cfg_regs.h     | 2110 ++++
> > >  .../include/goya/asic_reg/tpc1_cmdq_regs.h    |  431 +
> > >  .../include/goya/asic_reg/tpc1_qm_regs.h      |  543 +
> > >  .../include/goya/asic_reg/tpc1_rtr_regs.h     |  848 ++
> > >  .../include/goya/asic_reg/tpc2_cfg_regs.h     | 2110 ++++
> > >  .../include/goya/asic_reg/tpc2_cmdq_regs.h    |  431 +
> > >  .../include/goya/asic_reg/tpc2_qm_regs.h      |  543 +
> > >  .../include/goya/asic_reg/tpc2_rtr_regs.h     |  848 ++
> > >  .../include/goya/asic_reg/tpc3_cfg_regs.h     | 2110 ++++
> > >  .../include/goya/asic_reg/tpc3_cmdq_regs.h    |  431 +
> > >  .../include/goya/asic_reg/tpc3_qm_regs.h      |  543 +
> > >  .../include/goya/asic_reg/tpc3_rtr_regs.h     |  848 ++
> > >  .../include/goya/asic_reg/tpc4_cfg_regs.h     | 2110 ++++
> > >  .../include/goya/asic_reg/tpc4_cmdq_regs.h    |  431 +
> > >  .../include/goya/asic_reg/tpc4_qm_regs.h      |  543 +
> > >  .../include/goya/asic_reg/tpc4_rtr_regs.h     |  848 ++
> > >  .../include/goya/asic_reg/tpc5_cfg_regs.h     | 2110 ++++
> > >  .../include/goya/asic_reg/tpc5_cmdq_regs.h    |  431 +
> > >  .../include/goya/asic_reg/tpc5_qm_regs.h      |  543 +
> > >  .../include/goya/asic_reg/tpc5_rtr_regs.h     |  848 ++
> > >  .../include/goya/asic_reg/tpc6_cfg_regs.h     | 2110 ++++
> > >  .../include/goya/asic_reg/tpc6_cmdq_regs.h    |  431 +
> > >  .../include/goya/asic_reg/tpc6_qm_regs.h      |  543 +
> > >  .../include/goya/asic_reg/tpc6_rtr_regs.h     |  848 ++
> > >  .../include/goya/asic_reg/tpc7_cfg_regs.h     | 2110 ++++
> > >  .../include/goya/asic_reg/tpc7_cmdq_regs.h    |  431 +
> > >  .../include/goya/asic_reg/tpc7_nrtr_regs.h    |  380 +
> > >  .../include/goya/asic_reg/tpc7_qm_regs.h      |  543 +
> > >  .../include/goya/asic_reg/tpc_pll_regs.h      |  186 +
> > >  drivers/misc/habanalabs/include/goya/goya.h   |   41 +
> > >  .../include/goya/goya_async_events.h          |  186 +
> > >  .../habanalabs/include/goya/goya_boot_if.h    |   30 +
> > >  .../misc/habanalabs/include/goya/goya_fw_if.h |   28 +
> > >  .../habanalabs/include/goya/goya_packets.h    |  129 +
> > >  .../include/hw_ip/mmu/mmu_general.h           |   45 +
> > >  .../habanalabs/include/hw_ip/mmu/mmu_v1_0.h   |   15 +
> > >  drivers/misc/habanalabs/include/qman_if.h     |   56 +
> > >  drivers/misc/habanalabs/irq.c                 |  325 +
> > >  drivers/misc/habanalabs/memory.c              | 1713 ++++
> > >  drivers/misc/habanalabs/mmu.c                 |  604 ++
> > >  drivers/misc/habanalabs/sysfs.c               |  691 ++
> > >  include/uapi/misc/habanalabs.h                |  444 +
> > >  147 files changed, 98492 insertions(+), 1 deletion(-)
> > >  create mode 100644 Documentation/ABI/testing/debugfs-driver-habanalabs
> > >  create mode 100644 Documentation/ABI/testing/sysfs-driver-habanalabs
> > >  create mode 100644 drivers/misc/habanalabs/Kconfig
> > >  create mode 100644 drivers/misc/habanalabs/Makefile
> > >  create mode 100644 drivers/misc/habanalabs/asid.c
> > >  create mode 100644 drivers/misc/habanalabs/command_buffer.c
> > >  create mode 100644 drivers/misc/habanalabs/command_submission.c
> > >  create mode 100644 drivers/misc/habanalabs/context.c
> > >  create mode 100644 drivers/misc/habanalabs/debugfs.c
> > >  create mode 100644 drivers/misc/habanalabs/device.c
> > >  create mode 100644 drivers/misc/habanalabs/goya/Makefile
> > >  create mode 100644 drivers/misc/habanalabs/goya/goya.c
> > >  create mode 100644 drivers/misc/habanalabs/goya/goyaP.h
> > >  create mode 100644 drivers/misc/habanalabs/goya/goya_hwmgr.c
> > >  create mode 100644 drivers/misc/habanalabs/goya/goya_security.c
> > >  create mode 100644 drivers/misc/habanalabs/habanalabs.h
> > >  create mode 100644 drivers/misc/habanalabs/habanalabs_drv.c
> > >  create mode 100644 drivers/misc/habanalabs/habanalabs_ioctl.c
> > >  create mode 100644 drivers/misc/habanalabs/hw_queue.c
> > >  create mode 100644 drivers/misc/habanalabs/hwmon.c
> > >  create mode 100644 drivers/misc/habanalabs/include/armcp_if.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/cpu_ca53_cfg_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/cpu_if_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/cpu_pll_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/ddr_mc_ch0_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/ddr_mc_ch1_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/ddr_misc_ch0_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/ddr_misc_ch1_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_0_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_1_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_2_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_3_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_4_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_macro_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_nrtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_0_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_1_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_2_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_3_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_4_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/gic_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/goya_blocks.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/goya_masks.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/goya_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/ic_pll_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mc_pll_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme1_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme2_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme3_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme4_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme5_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme6_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_cmdq_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_qm_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mmu_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/pci_nrtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/pcie_aux_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/pcie_dbi_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_emmc_pll_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_global_conf_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_mme_pll_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_pci_pll_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_spi_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x0_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x1_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x2_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x3_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x4_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y1_x0_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y1_x1_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y1_x2_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y1_x3_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y1_x4_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y2_x0_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y2_x1_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y2_x2_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y2_x3_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y2_x4_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y3_x0_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y3_x1_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y3_x2_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y3_x3_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y3_x4_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y4_x0_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y4_x1_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y4_x2_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y4_x3_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y4_x4_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y5_x0_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y5_x1_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y5_x2_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y5_x3_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y5_x4_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/stlb_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sync_mngr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cfg_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cmdq_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_eml_cfg_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_nrtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_qm_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc1_cfg_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc1_cmdq_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc1_qm_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc1_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc2_cfg_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc2_cmdq_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc2_qm_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc2_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc3_cfg_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc3_cmdq_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc3_qm_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc3_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc4_cfg_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc4_cmdq_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc4_qm_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc4_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc5_cfg_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc5_cmdq_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc5_qm_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc5_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc6_cfg_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc6_cmdq_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc6_qm_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc6_rtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc7_cfg_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc7_cmdq_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc7_nrtr_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc7_qm_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc_pll_regs.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/goya.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/goya_async_events.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/goya_boot_if.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/goya_fw_if.h
> > >  create mode 100644 drivers/misc/habanalabs/include/goya/goya_packets.h
> > >  create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
> > >  create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v1_0.h
> > >  create mode 100644 drivers/misc/habanalabs/include/qman_if.h
> > >  create mode 100644 drivers/misc/habanalabs/irq.c
> > >  create mode 100644 drivers/misc/habanalabs/memory.c
> > >  create mode 100644 drivers/misc/habanalabs/mmu.c
> > >  create mode 100644 drivers/misc/habanalabs/sysfs.c
> > >  create mode 100644 include/uapi/misc/habanalabs.h
> > >
> > > --
> > > 2.17.1
> > >
> >
> > --
> > Sincerely yours,
> > Mike.
> >
