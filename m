Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C7EC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2743B20811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ulrfSqP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfBHVdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 16:33:54 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33109 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfBHVdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 16:33:53 -0500
Received: by mail-vs1-f67.google.com with SMTP id k11so53798vsm.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 13:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yhQbpZiiOCrUFmF4Enb6j0SBjYID4O8d9pMfZujhwK8=;
        b=ulrfSqP5/Ugmp2IoqAaEIJzdQQfM0W9C2yFcEoejm/fIuLi/fj6tYhD8/qpyqwhX1B
         RNBKNMBE98uxB5fWGckhXx1C0OON58wGafOkvD/Qo6ztKUkZQQ45NoVZEnNu6L6Fnk5p
         OEsjD6TjJDIfuIJd9VYChP7nebMWywAjLm5va1crsmSV7AKlQJeIjE7fRUcbYhH6YNuB
         cpsXXaRkVX6bkwTzIZINtoYjHv+95+GrK2palj1ffxSq8Q+UdAxYfwR8HUVpG3I8OKlG
         pxP4mAvXlM1xQ+mtRai1xeaC5R4Y3u/TVRrqGcSmHLGDYz5D8CBW8bbzKfREIez1xYvu
         3tuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yhQbpZiiOCrUFmF4Enb6j0SBjYID4O8d9pMfZujhwK8=;
        b=QXs9RmcqdC+93HDnuCLENW9ktGMYYOFh4V8x/yYv9VBxA25aBVeuxQhZlXECuY4qwc
         /WM/N8iOtIBP3oxA1CQmp45Tb4dgImn0SH95/JneY+3zd4EFGH1d3+ILLDKtu6e4/LOe
         OKnE0RW/E4FAY72akVAEyGDm4xFc6vJjVe99cKwbUqJIhp+qgoXxeRPkKviGm+GJvgB/
         V+Qd/zrPqB5PlCoCT84sBD4FSDTPKECRo8h0CR49EmD06QPFXccx8nPaMhO5lXT5Uev2
         LRqZy1sRPujnbXK/iwUdaU68Vlj4dUWBY55G5vheu7fwUj9Vg5d7HG2aF++zlX3dHgzg
         iI3A==
X-Gm-Message-State: AHQUAuY2aa+gQur1dsrDgpwkNzjXj32bhfVXMw8TWfbAu86qSjW1s2F0
        pw5z//cwuUW5pXvSaIBqEbZT41UB4xL2tdI+I4c=
X-Google-Smtp-Source: AHgI3IaJ2k9u7QU5JQKDM2zOrXkJnyKKOw/Et1zXAA7gIFHhbSt+EIs0EptSGTM4Uo+ZIk/rKwKfJUOIxnXl8AVUYgI=
X-Received: by 2002:a67:44c8:: with SMTP id y69mr7005142vsf.172.1549661631822;
 Fri, 08 Feb 2019 13:33:51 -0800 (PST)
MIME-Version: 1.0
References: <20190204203254.4026-1-oded.gabbay@gmail.com> <20190206115237.GA6750@rapoport-lnx>
In-Reply-To: <20190206115237.GA6750@rapoport-lnx>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Fri, 8 Feb 2019 23:33:27 +0200
Message-ID: <CAFCwf10K9Ejqm_=jrtOyXAs4yL-6zs1X79O=dwjg=2jmB3PPYA@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] Habana Labs kernel driver
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

On Wed, Feb 6, 2019 at 1:52 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Mon, Feb 04, 2019 at 10:32:39PM +0200, Oded Gabbay wrote:
> > Hello,
> > This is v3 of the Habana Labs kernel driver patch-set. It contains minor fixes
> > according to reviews done on v2. In addition, it is rebased on v5.0-rc5.
> >
> > Link to v2 cover letter: https://lkml.org/lkml/2019/1/30/1003
> >
> > Link to v1 cover letter: https://lwn.net/Articles/777342/
> >
> > I would appricate any feedback, question and/or review.
> >
> > Thanks,
> > Oded
> >
> > p.s. for those who prefer to clone the tree instead of looking at the
> > emails, you can grab a copy from our company's page in GitHub:
> >
> > https://github.com/HabanaAI/linux/releases/tag/hl_patchset_v3_20190204
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
>
> Nit: git am is unhappy about black lines at EOF, e.g:
>
> Applying: habanalabs: add basic Goya support
> .git/rebase-apply/patch:29: new blank line at EOF.
> +
Yes, but on the other hand, joe perches gave me a comment about
missing newline at end of Makefile.
So either diff will complain or git am.

>
> Aside from that, for patches 1, 3-11 and 13 feel free to add
>
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
>
Thanks for the review!
Oded

> As for the "habanalabs: add virtual memory and MMU modules" and the debugfs
> patch I'll need more time to review the changes related to 2M pages.
>
> >  CREDITS                                       |    2 +-
> >  .../ABI/testing/debugfs-driver-habanalabs     |  127 +
> >  .../ABI/testing/sysfs-driver-habanalabs       |  190 +
> >  MAINTAINERS                                   |    9 +
> >  drivers/misc/Kconfig                          |    1 +
> >  drivers/misc/Makefile                         |    1 +
> >  drivers/misc/habanalabs/Kconfig               |   22 +
> >  drivers/misc/habanalabs/Makefile              |   15 +
> >  drivers/misc/habanalabs/asid.c                |   58 +
> >  drivers/misc/habanalabs/command_buffer.c      |  432 ++
> >  drivers/misc/habanalabs/command_submission.c  |  782 +++
> >  drivers/misc/habanalabs/context.c             |  216 +
> >  drivers/misc/habanalabs/debugfs.c             | 1071 ++++
> >  drivers/misc/habanalabs/device.c              | 1111 ++++
> >  drivers/misc/habanalabs/goya/Makefile         |    4 +
> >  drivers/misc/habanalabs/goya/goya.c           | 5344 +++++++++++++++++
> >  drivers/misc/habanalabs/goya/goyaP.h          |  193 +
> >  drivers/misc/habanalabs/goya/goya_hwmgr.c     |  306 +
> >  drivers/misc/habanalabs/goya/goya_security.c  | 2999 +++++++++
> >  drivers/misc/habanalabs/habanalabs.h          | 1441 +++++
> >  drivers/misc/habanalabs/habanalabs_drv.c      |  465 ++
> >  drivers/misc/habanalabs/habanalabs_ioctl.c    |  234 +
> >  drivers/misc/habanalabs/hw_queue.c            |  636 ++
> >  drivers/misc/habanalabs/hwmon.c               |  449 ++
> >  drivers/misc/habanalabs/include/armcp_if.h    |  335 ++
> >  .../include/goya/asic_reg/cpu_ca53_cfg_regs.h |  213 +
> >  .../include/goya/asic_reg/cpu_if_regs.h       |  110 +
> >  .../include/goya/asic_reg/cpu_pll_regs.h      |  186 +
> >  .../include/goya/asic_reg/dma_ch_0_regs.h     |  512 ++
> >  .../include/goya/asic_reg/dma_ch_1_regs.h     |  512 ++
> >  .../include/goya/asic_reg/dma_ch_2_regs.h     |  512 ++
> >  .../include/goya/asic_reg/dma_ch_3_regs.h     |  512 ++
> >  .../include/goya/asic_reg/dma_ch_4_regs.h     |  512 ++
> >  .../include/goya/asic_reg/dma_macro_regs.h    |  242 +
> >  .../include/goya/asic_reg/dma_nrtr_regs.h     |  380 ++
> >  .../include/goya/asic_reg/dma_qm_0_regs.h     |  543 ++
> >  .../include/goya/asic_reg/dma_qm_1_regs.h     |  543 ++
> >  .../include/goya/asic_reg/dma_qm_2_regs.h     |  543 ++
> >  .../include/goya/asic_reg/dma_qm_3_regs.h     |  543 ++
> >  .../include/goya/asic_reg/dma_qm_4_regs.h     |  543 ++
> >  .../include/goya/asic_reg/goya_blocks.h       | 1372 +++++
> >  .../include/goya/asic_reg/goya_masks.h        |  262 +
> >  .../include/goya/asic_reg/goya_regs.h         |   99 +
> >  .../include/goya/asic_reg/ic_pll_regs.h       |  186 +
> >  .../include/goya/asic_reg/mc_pll_regs.h       |  186 +
> >  .../include/goya/asic_reg/mme1_rtr_regs.h     |  876 +++
> >  .../include/goya/asic_reg/mme2_rtr_regs.h     |  876 +++
> >  .../include/goya/asic_reg/mme3_rtr_regs.h     |  876 +++
> >  .../include/goya/asic_reg/mme4_rtr_regs.h     |  876 +++
> >  .../include/goya/asic_reg/mme5_rtr_regs.h     |  876 +++
> >  .../include/goya/asic_reg/mme6_rtr_regs.h     |  876 +++
> >  .../include/goya/asic_reg/mme_cmdq_regs.h     |  431 ++
> >  .../include/goya/asic_reg/mme_qm_regs.h       |  543 ++
> >  .../include/goya/asic_reg/mme_regs.h          | 2422 ++++++++
> >  .../include/goya/asic_reg/mmu_regs.h          |  158 +
> >  .../include/goya/asic_reg/pci_nrtr_regs.h     |  380 ++
> >  .../include/goya/asic_reg/pcie_aux_regs.h     |  476 ++
> >  .../goya/asic_reg/psoc_emmc_pll_regs.h        |  186 +
> >  .../goya/asic_reg/psoc_global_conf_regs.h     | 1119 ++++
> >  .../include/goya/asic_reg/psoc_mme_pll_regs.h |  186 +
> >  .../include/goya/asic_reg/psoc_pci_pll_regs.h |  186 +
> >  .../include/goya/asic_reg/psoc_spi_regs.h     |  427 ++
> >  .../goya/asic_reg/sram_y0_x0_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y0_x1_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y0_x2_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y0_x3_rtr_regs.h       |  215 +
> >  .../goya/asic_reg/sram_y0_x4_rtr_regs.h       |  215 +
> >  .../include/goya/asic_reg/stlb_regs.h         |  133 +
> >  .../include/goya/asic_reg/tpc0_cfg_regs.h     | 2110 +++++++
> >  .../include/goya/asic_reg/tpc0_cmdq_regs.h    |  431 ++
> >  .../include/goya/asic_reg/tpc0_eml_cfg_regs.h |  580 ++
> >  .../include/goya/asic_reg/tpc0_nrtr_regs.h    |  380 ++
> >  .../include/goya/asic_reg/tpc0_qm_regs.h      |  543 ++
> >  .../include/goya/asic_reg/tpc1_cfg_regs.h     | 2110 +++++++
> >  .../include/goya/asic_reg/tpc1_cmdq_regs.h    |  431 ++
> >  .../include/goya/asic_reg/tpc1_qm_regs.h      |  543 ++
> >  .../include/goya/asic_reg/tpc1_rtr_regs.h     |  848 +++
> >  .../include/goya/asic_reg/tpc2_cfg_regs.h     | 2110 +++++++
> >  .../include/goya/asic_reg/tpc2_cmdq_regs.h    |  431 ++
> >  .../include/goya/asic_reg/tpc2_qm_regs.h      |  543 ++
> >  .../include/goya/asic_reg/tpc2_rtr_regs.h     |  848 +++
> >  .../include/goya/asic_reg/tpc3_cfg_regs.h     | 2110 +++++++
> >  .../include/goya/asic_reg/tpc3_cmdq_regs.h    |  431 ++
> >  .../include/goya/asic_reg/tpc3_qm_regs.h      |  543 ++
> >  .../include/goya/asic_reg/tpc3_rtr_regs.h     |  848 +++
> >  .../include/goya/asic_reg/tpc4_cfg_regs.h     | 2110 +++++++
> >  .../include/goya/asic_reg/tpc4_cmdq_regs.h    |  431 ++
> >  .../include/goya/asic_reg/tpc4_qm_regs.h      |  543 ++
> >  .../include/goya/asic_reg/tpc4_rtr_regs.h     |  848 +++
> >  .../include/goya/asic_reg/tpc5_cfg_regs.h     | 2110 +++++++
> >  .../include/goya/asic_reg/tpc5_cmdq_regs.h    |  431 ++
> >  .../include/goya/asic_reg/tpc5_qm_regs.h      |  543 ++
> >  .../include/goya/asic_reg/tpc5_rtr_regs.h     |  848 +++
> >  .../include/goya/asic_reg/tpc6_cfg_regs.h     | 2110 +++++++
> >  .../include/goya/asic_reg/tpc6_cmdq_regs.h    |  431 ++
> >  .../include/goya/asic_reg/tpc6_qm_regs.h      |  543 ++
> >  .../include/goya/asic_reg/tpc6_rtr_regs.h     |  848 +++
> >  .../include/goya/asic_reg/tpc7_cfg_regs.h     | 2110 +++++++
> >  .../include/goya/asic_reg/tpc7_cmdq_regs.h    |  431 ++
> >  .../include/goya/asic_reg/tpc7_nrtr_regs.h    |  380 ++
> >  .../include/goya/asic_reg/tpc7_qm_regs.h      |  543 ++
> >  .../include/goya/asic_reg/tpc_pll_regs.h      |  186 +
> >  drivers/misc/habanalabs/include/goya/goya.h   |   41 +
> >  .../include/goya/goya_async_events.h          |  186 +
> >  .../misc/habanalabs/include/goya/goya_fw_if.h |   28 +
> >  .../habanalabs/include/goya/goya_packets.h    |  129 +
> >  drivers/misc/habanalabs/include/hl_boot_if.h  |   30 +
> >  .../include/hw_ip/mmu/mmu_general.h           |   45 +
> >  .../habanalabs/include/hw_ip/mmu/mmu_v1_0.h   |   15 +
> >  drivers/misc/habanalabs/include/qman_if.h     |   56 +
> >  drivers/misc/habanalabs/irq.c                 |  325 +
> >  drivers/misc/habanalabs/memory.c              | 1722 ++++++
> >  drivers/misc/habanalabs/mmu.c                 |  604 ++
> >  drivers/misc/habanalabs/sysfs.c               |  691 +++
> >  include/uapi/misc/habanalabs.h                |  444 ++
> >  115 files changed, 73533 insertions(+), 1 deletion(-)
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
> >  create mode 100644 drivers/misc/habanalabs/include/armcp_if.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/cpu_ca53_cfg_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/cpu_if_regs.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/cpu_pll_regs.h
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
> >  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/stlb_regs.h
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
> >  create mode 100644 drivers/misc/habanalabs/include/goya/goya_fw_if.h
> >  create mode 100644 drivers/misc/habanalabs/include/goya/goya_packets.h
> >  create mode 100644 drivers/misc/habanalabs/include/hl_boot_if.h
> >  create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
> >  create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v1_0.h
> >  create mode 100644 drivers/misc/habanalabs/include/qman_if.h
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
