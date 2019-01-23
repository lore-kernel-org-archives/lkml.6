Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D0FC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64482184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCBNV5F4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfAWWnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:43:46 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42487 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfAWWnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:43:45 -0500
Received: by mail-vs1-f65.google.com with SMTP id b74so2349671vsd.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 14:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GmjxcttZm+u1WQUSKpoqFU4nv+eXysQWoROezgTn1co=;
        b=TCBNV5F4OV+iUi3orA3v/HgoP56Q4nm+/9D3lcoeiKftNGlFMhwkRBRPWbMRXFODLY
         I/XYdhk8/EHK0+60cBVUGrrL4VkPbucv1BiznPQFUNMSp9FUX3SyXol6Q3eRsMzbL72l
         K/YNAg05a2L+y2kj6RXUTYnAQK1MRj6vGLGHmfRvYd4qpAC2f3wGA1DWBbIInp8BAFHa
         AO6C5O+q+RHQ4exrhi4XmVWuZIJXiBfF3FvUghycz6gXlGFfl6xHEJLWTK9Bs2H7B/zu
         B8Y1HiHuU8ie8jYqRD1XZU57f3gLJ5xsN4ymTz0WotV7GULYJ7HeNBd+NEuCdnWNKwMf
         czXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GmjxcttZm+u1WQUSKpoqFU4nv+eXysQWoROezgTn1co=;
        b=GAWn9g0/SquXTexZAIo1D5I2wxCj9HC0CgGHyxyoxu7enYlffK2fZ8hF2dBF5GCa4H
         gHJlytG/cPTn8FXmNygRRdB/e2HthyHLYd4m6oRCTFoui4tBt1NNPqtnKyH8BBWOmdLF
         cM4YZq8pMSjE9kt9UuGz2uOR44EKwjYbcffMSlKx5vLnGi+IP+nB9V07wIDMQe88QK7B
         LiULFLrMozD8Hvn/23pd/OBnqmsFLjycLO/GlFMMWbvHAeamXZMbItOQ+mezIGLU0nTv
         sQg7VpvxyfdnNfjfXYER7hicy6By/kCbGUiGHWCpFNGcefluM4vj/dv2mIU3ndF74HPZ
         QQ1Q==
X-Gm-Message-State: AJcUukcK/ye6IZ72RrbMVVFODBOtTUFtJTFBiiT87m0hQHM9xVbOVqSR
        aJ0M+XYmKpIfu1mizDoFItYibRrEee24ZQMgJGk=
X-Google-Smtp-Source: ALg8bN6CqFP9efgPNHB2tDJakO09ZaJbu+f56my3CVEjQrjvxvLEOyp82PkoFJWXOgQK9aZnvJCQJOIf81UULu1RLmQ=
X-Received: by 2002:a67:ea50:: with SMTP id r16mr1668420vso.61.1548283423355;
 Wed, 23 Jan 2019 14:43:43 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <20190123122752.GA2194@rapoport-lnx>
In-Reply-To: <20190123122752.GA2194@rapoport-lnx>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 24 Jan 2019 00:43:18 +0200
Message-ID: <CAFCwf10V7YXN8rk9U6j+WOrkvenn25V66MogpQtTuhUrMBCV8g@mail.gmail.com>
Subject: Re: [PATCH 00/15] Habana Labs kernel driver
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ogabbay@habana.ai
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 2:28 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> Hi,
>
> On Wed, Jan 23, 2019 at 02:00:42AM +0200, Oded Gabbay wrote:
> > Hello,
> >
> > For those who don't know me, my name is Oded Gabbay (Kernel Maintainer
> > for AMD's amdkfd driver, worked at RedHat's Desktop group) and I work at
> > Habana Labs since its inception two and a half years ago.
> >
> > Habana is a leading startup in the emerging AI processor space and we have
> > already started production of our first Goya inference processor PCIe card
> > and delivered it to customers. The Goya processor silicon has been tested
> > since June of 2018 and is production-qualified by now. The Gaudi training
> > processor solution is slated to sample in the second quarter of 2019.
> >
> > This patch-set contains the kernel driver for Habana's AI Processors
> > (AIP) that are designed to accelerate Deep Learning inference and training
> > workloads. The current version supports only the Goya processor and
> > support for Gaudi will be upstreamed after the ASIC will be available to
> > customers.
> >
> > The Goya processor has been designed from the ground up for deep learning
> > inference workloads. It comprises a cluster of eight fully programmable
> > Tensor Processing Cores (TPC). The TPC core is a VLIW SIMD vector
> > processor with ISA and hardware that was tailored to serve deep learning
> > workloads efficiently.
>
> [ ... ]
>
> > I would appricate any feedback, question and/or review.
>
> I've looked at the patches 1,3-5 for now, it seems patch 2 still didn't
> make it to lore.kernel.org.
>
> FWIW, I think it's a good solid work, unless you spoil it in patches 6-14
> ;-)

Thanks! I will go over your comments in the next few days.
>
> As a general note, maybe drivers/misc is not the most appropriate place for
> such a complex beast. How about drivers/accelerator/ai?

I talked to Greg about it a couple of weeks ago and we both agreed
that drivers/misc is the correct place for this driver, at this point
in time.
I don't see any reason why it couldn't be moved later on, when there
will be other drivers, but for now I just don't see the need to open a
new subsystem in the kernel.
Oded

>
> > p.s. for those who prefer to clone the tree instead of looking at the
> > emails, you can grab a copy from our company's page in GitHub:
> >
> > https://github.com/HabanaAI/linux/releases/tag/hl_patchset_v1
> >
> > Thanks,
> > Oded
> >
> > Oded Gabbay (14):
> >   habanalabs: add skeleton driver
> >   habanalabs: add Goya registers header files
> >   habanalabs: add basic Goya support
> >   habanalabs: add context and ASID modules
> >   habanalabs: add command buffer module
> >   habanalabs: add basic Goya h/w initialization
> >   habanalabs: add h/w queues module
> >   habanalabs: add event queue and interrupts
> >   habanalabs: add sysfs and hwmon support
> >   habanalabs: add device reset support
> >   habanalabs: add command submission module
> >   habanalabs: implement INFO IOCTL
> >   habanalabs: add debugfs support
> >   Update MAINTAINERS and CREDITS with habanalabs info
> >
> > Omer Shpigelman (1):
> >   habanalabs: add virtual memory and MMU modules
> >
> >  CREDITS                                       |    2 +-
> >  .../ABI/testing/debugfs-driver-habanalabs     |  127 +
> >  .../ABI/testing/sysfs-driver-habanalabs       |  190 +
> >  MAINTAINERS                                   |    9 +
> >  drivers/misc/Kconfig                          |    1 +
> >  drivers/misc/Makefile                         |    1 +
> >  drivers/misc/habanalabs/Kconfig               |   22 +
> >  drivers/misc/habanalabs/Makefile              |   14 +
> >  drivers/misc/habanalabs/asid.c                |   58 +
> >  drivers/misc/habanalabs/command_buffer.c      |  425 +
> >  drivers/misc/habanalabs/command_submission.c  |  799 ++
> >  drivers/misc/habanalabs/context.c             |  216 +
> >  drivers/misc/habanalabs/debugfs.c             | 1069 ++
> >  drivers/misc/habanalabs/device.c              | 1097 ++
> >  drivers/misc/habanalabs/goya/Makefile         |    3 +
> >  drivers/misc/habanalabs/goya/goya.c           | 6347 ++++++++++++
> >  drivers/misc/habanalabs/goya/goyaP.h          |  161 +
> >  drivers/misc/habanalabs/goya/goya_hwmgr.c     |  306 +
> >  drivers/misc/habanalabs/goya/goya_security.c  | 2999 ++++++
> >  drivers/misc/habanalabs/habanalabs.h          | 1464 +++
> >  drivers/misc/habanalabs/habanalabs_drv.c      |  474 +
> >  drivers/misc/habanalabs/habanalabs_ioctl.c    |  237 +
> >  drivers/misc/habanalabs/hw_queue.c            |  654 ++
> >  drivers/misc/habanalabs/hwmon.c               |  449 +
> >  .../include/goya/asic_reg/cpu_ca53_cfg_regs.h |  213 +
> >  .../include/goya/asic_reg/cpu_if_regs.h       |  110 +
> >  .../include/goya/asic_reg/cpu_pll_regs.h      |  186 +
> >  .../include/goya/asic_reg/ddr_mc_ch0_regs.h   | 1158 +++
> >  .../include/goya/asic_reg/ddr_mc_ch1_regs.h   | 1158 +++
> >  .../include/goya/asic_reg/ddr_misc_ch0_regs.h |  156 +
> >  .../include/goya/asic_reg/ddr_misc_ch1_regs.h |  156 +
> >  .../include/goya/asic_reg/dma_ch_0_regs.h     |  512 +
> >  .../include/goya/asic_reg/dma_ch_1_regs.h     |  512 +
> >  .../include/goya/asic_reg/dma_ch_2_regs.h     |  512 +
> >  .../include/goya/asic_reg/dma_ch_3_regs.h     |  512 +
> >  .../include/goya/asic_reg/dma_ch_4_regs.h     |  512 +
> >  .../include/goya/asic_reg/dma_macro_regs.h    |  242 +
> >  .../include/goya/asic_reg/dma_nrtr_regs.h     |  380 +
> >  .../include/goya/asic_reg/dma_qm_0_regs.h     |  543 +
> >  .../include/goya/asic_reg/dma_qm_1_regs.h     |  543 +
> >  .../include/goya/asic_reg/dma_qm_2_regs.h     |  543 +
> >  .../include/goya/asic_reg/dma_qm_3_regs.h     |  543 +
> >  .../include/goya/asic_reg/dma_qm_4_regs.h     |  543 +
> >  .../include/goya/asic_reg/gic_regs.h          | 9079 +++++++++++++++++
> >  .../include/goya/asic_reg/goya_blocks.h       | 1372 +++
> >  .../include/goya/asic_reg/goya_masks.h        |  262 +
> >  .../include/goya/asic_reg/goya_regs.h         |  119 +
> >  .../include/goya/asic_reg/ic_pll_regs.h       |  186 +
> >  .../include/goya/asic_reg/mc_pll_regs.h       |  186 +
> >  .../include/goya/asic_reg/mme1_rtr_regs.h     |  876 ++
> >  .../include/goya/asic_reg/mme2_rtr_regs.h     |  876 ++
> >  .../include/goya/asic_reg/mme3_rtr_regs.h     |  876 ++
> >  .../include/goya/asic_reg/mme4_rtr_regs.h     |  876 ++
> >  .../include/goya/asic_reg/mme5_rtr_regs.h     |  876 ++
> >  .../include/goya/asic_reg/mme6_rtr_regs.h     |  876 ++
> >  .../include/goya/asic_reg/mme_cmdq_regs.h     |  431 +
> >  .../include/goya/asic_reg/mme_qm_regs.h       |  543 +
> >  .../include/goya/asic_reg/mme_regs.h          | 2422 +++++
> >  .../include/goya/asic_reg/mmu_regs.h          |  158 +
> >  .../include/goya/asic_reg/pci_nrtr_regs.h     |  380 +
> >  .../include/goya/asic_reg/pcie_aux_regs.h     |  476 +
> >  .../include/goya/asic_reg/pcie_dbi_regs.h     | 2909 ++++++
> >  .../goya/asic_reg/psoc_emmc_pll_regs.h        |  186 +
> >  .../goya/asic_reg/psoc_global_conf_regs.h     | 1119 ++
> >  .../include/goya/asic_reg/psoc_mme_pll_regs.h |  186 +
> >  .../include/goya/asic_reg/psoc_pci_pll_regs.h |  186 +
> >  .../include/goya/asic_reg/psoc_spi_regs.h     |  427 +
> >  .../goya/asic_reg/sram_y0_x0_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y0_x1_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y0_x2_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y0_x3_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y0_x4_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y1_x0_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y1_x1_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y1_x2_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y1_x3_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y1_x4_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y2_x0_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y2_x1_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y2_x2_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y2_x3_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y2_x4_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y3_x0_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y3_x1_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y3_x2_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y3_x3_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y3_x4_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y4_x0_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y4_x1_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y4_x2_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y4_x3_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y4_x4_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y5_x0_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y5_x1_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y5_x2_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y5_x3_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y5_x4_rtr_regs.h       |  215 +
> >  .../include/goya/asic_reg/stlb_regs.h         |  133 +
> >  .../include/goya/asic_reg/sync_mngr_regs.h    | 4930 +++++++++
> >  .../include/goya/asic_reg/tpc0_cfg_regs.h     | 2110 ++++
> >  .../include/goya/asic_reg/tpc0_cmdq_regs.h    |  431 +
> >  .../include/goya/asic_reg/tpc0_eml_cfg_regs.h |  580 ++
> >  .../include/goya/asic_reg/tpc0_nrtr_regs.h    |  380 +
> >  .../include/goya/asic_reg/tpc0_qm_regs.h      |  543 +
> >  .../include/goya/asic_reg/tpc1_cfg_regs.h     | 2110 ++++
> >  .../include/goya/asic_reg/tpc1_cmdq_regs.h    |  431 +
> >  .../include/goya/asic_reg/tpc1_qm_regs.h      |  543 +
> >  .../include/goya/asic_reg/tpc1_rtr_regs.h     |  848 ++
> >  .../include/goya/asic_reg/tpc2_cfg_regs.h     | 2110 ++++
> >  .../include/goya/asic_reg/tpc2_cmdq_regs.h    |  431 +
> >  .../include/goya/asic_reg/tpc2_qm_regs.h      |  543 +
> >  .../include/goya/asic_reg/tpc2_rtr_regs.h     |  848 ++
> >  .../include/goya/asic_reg/tpc3_cfg_regs.h     | 2110 ++++
> >  .../include/goya/asic_reg/tpc3_cmdq_regs.h    |  431 +
> >  .../include/goya/asic_reg/tpc3_qm_regs.h      |  543 +
> >  .../include/goya/asic_reg/tpc3_rtr_regs.h     |  848 ++
> >  .../include/goya/asic_reg/tpc4_cfg_regs.h     | 2110 ++++
> >  .../include/goya/asic_reg/tpc4_cmdq_regs.h    |  431 +
> >  .../include/goya/asic_reg/tpc4_qm_regs.h      |  543 +
> >  .../include/goya/asic_reg/tpc4_rtr_regs.h     |  848 ++
> >  .../include/goya/asic_reg/tpc5_cfg_regs.h     | 2110 ++++
> >  .../include/goya/asic_reg/tpc5_cmdq_regs.h    |  431 +
> >  .../include/goya/asic_reg/tpc5_qm_regs.h      |  543 +
> >  .../include/goya/asic_reg/tpc5_rtr_regs.h     |  848 ++
> >  .../include/goya/asic_reg/tpc6_cfg_regs.h     | 2110 ++++
> >  .../include/goya/asic_reg/tpc6_cmdq_regs.h    |  431 +
> >  .../include/goya/asic_reg/tpc6_qm_regs.h      |  543 +
> >  .../include/goya/asic_reg/tpc6_rtr_regs.h     |  848 ++
> >  .../include/goya/asic_reg/tpc7_cfg_regs.h     | 2110 ++++
> >  .../include/goya/asic_reg/tpc7_cmdq_regs.h    |  431 +
> >  .../include/goya/asic_reg/tpc7_nrtr_regs.h    |  380 +
> >  .../include/goya/asic_reg/tpc7_qm_regs.h      |  543 +
> >  .../include/goya/asic_reg/tpc_pll_regs.h      |  186 +
> >  drivers/misc/habanalabs/include/goya/goya.h   |  117 +
> >  .../include/goya/goya_async_events.h          |  186 +
> >  .../habanalabs/include/goya/goya_boot_if.h    |   32 +
> >  .../habanalabs/include/goya/goya_packets.h    |  234 +
> >  .../habanalabs/include/habanalabs_device_if.h |  397 +
> >  .../include/hw_ip/mmu/mmu_general.h           |   45 +
> >  .../habanalabs/include/hw_ip/mmu/mmu_v1_0.h   |   15 +
> >  drivers/misc/habanalabs/irq.c                 |  325 +
> >  drivers/misc/habanalabs/memory.c              | 1714 ++++
> >  drivers/misc/habanalabs/mmu.c                 |  604 ++
> >  drivers/misc/habanalabs/sysfs.c               |  690 ++
> >  include/uapi/misc/habanalabs.h                |  412 +
> >  145 files changed, 99610 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/ABI/testing/debugfs-driver-habanalabs
> >  create mode 100644 Documentation/ABI/testing/sysfs-driver-habanalabs
> >  create mode 100644 drivers/misc/habanalabs/Kconfig
> >  create mode 100644 drivers/misc/habanalabs/Makefile
> >  create mode 100644 drivers/misc/habanalabs/asid.c
> >  create mode 100644 drivers/misc/habanalabs/command_buffer.c
> >  create mode 100644 drivers/misc/habanalabs/command_submission.c
> >  create mode 100644 drivers/misc/habanalabs/context.c
> >  create mode 100644 drivers/misc/habanalabs/debugfs.c
> >  create mode 100644 drivers/misc/habanalabs/device.c
> >  create mode 100644 drivers/misc/habanalabs/goya/Makefile
> >  create mode 100644 drivers/misc/habanalabs/goya/goya.c
> >  create mode 100644 drivers/misc/habanalabs/goya/goyaP.h
> >  create mode 100644 drivers/misc/habanalabs/goya/goya_hwmgr.c
> >  create mode 100644 drivers/misc/habanalabs/goya/goya_security.c
> >  create mode 100644 drivers/misc/habanalabs/habanalabs.h
> >  create mode 100644 drivers/misc/habanalabs/habanalabs_drv.c
> >  create mode 100644 drivers/misc/habanalabs/habanalabs_ioctl.c
> >  create mode 100644 drivers/misc/habanalabs/hw_queue.c
> >  create mode 100644 drivers/misc/habanalabs/hwmon.c
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/cpu_ca53_cfg_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/cpu_if_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/cpu_pll_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/ddr_mc_ch0_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/ddr_mc_ch1_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/ddr_misc_ch0_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/ddr_misc_ch1_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_0_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_1_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_2_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_3_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_4_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_macro_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_nrtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_0_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_1_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_2_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_3_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_4_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/gic_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/goya_blocks.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/goya_masks.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/goya_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/ic_pll_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mc_pll_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme1_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme2_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme3_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme4_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme5_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme6_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_cmdq_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_qm_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mmu_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/pci_nrtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/pcie_aux_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/pcie_dbi_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_emmc_pll_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_global_conf_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_mme_pll_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_pci_pll_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_spi_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x0_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x1_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x2_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x3_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x4_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y1_x0_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y1_x1_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y1_x2_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y1_x3_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y1_x4_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y2_x0_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y2_x1_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y2_x2_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y2_x3_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y2_x4_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y3_x0_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y3_x1_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y3_x2_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y3_x3_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y3_x4_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y4_x0_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y4_x1_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y4_x2_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y4_x3_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y4_x4_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y5_x0_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y5_x1_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y5_x2_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y5_x3_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y5_x4_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/stlb_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sync_mngr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cfg_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cmdq_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_eml_cfg_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_nrtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_qm_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc1_cfg_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc1_cmdq_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc1_qm_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc1_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc2_cfg_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc2_cmdq_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc2_qm_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc2_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc3_cfg_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc3_cmdq_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc3_qm_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc3_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc4_cfg_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc4_cmdq_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc4_qm_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc4_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc5_cfg_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc5_cmdq_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc5_qm_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc5_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc6_cfg_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc6_cmdq_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc6_qm_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc6_rtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc7_cfg_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc7_cmdq_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc7_nrtr_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc7_qm_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc_pll_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/goya.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/goya_async_events.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/goya_boot_if.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/goya_packets.h
> >  create mode 100644 drivers/misc/habanalabs/include/habanalabs_device_if.h
> >  create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
> >  create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v1_0.h
> >  create mode 100644 drivers/misc/habanalabs/irq.c
> >  create mode 100644 drivers/misc/habanalabs/memory.c
> >  create mode 100644 drivers/misc/habanalabs/mmu.c
> >  create mode 100644 drivers/misc/habanalabs/sysfs.c
> >  create mode 100644 include/uapi/misc/habanalabs.h
> >
> > --
> > 2.17.1
> >
>
> --
> Sincerely yours,
> Mike.
>
