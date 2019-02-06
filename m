Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AEAC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C2C20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbfBFLwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:52:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728829AbfBFLwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:52:49 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x16BnQgT054246
        for <linux-kernel@vger.kernel.org>; Wed, 6 Feb 2019 06:52:48 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qfxarb1ch-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 06:52:48 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 6 Feb 2019 11:52:45 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 6 Feb 2019 11:52:41 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x16Bqeqv60031094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Feb 2019 11:52:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 710B14C040;
        Wed,  6 Feb 2019 11:52:40 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7CC44C05C;
        Wed,  6 Feb 2019 11:52:39 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  6 Feb 2019 11:52:39 +0000 (GMT)
Date:   Wed, 6 Feb 2019 13:52:38 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        olof@lixom.net, ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: Re: [PATCH v3 00/15] Habana Labs kernel driver
References: <20190204203254.4026-1-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204203254.4026-1-oded.gabbay@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19020611-0012-0000-0000-000002F26108
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020611-0013-0000-0000-00002129C247
Message-Id: <20190206115237.GA6750@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-06_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902060094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 10:32:39PM +0200, Oded Gabbay wrote:
> Hello,
> This is v3 of the Habana Labs kernel driver patch-set. It contains minor fixes
> according to reviews done on v2. In addition, it is rebased on v5.0-rc5.
> 
> Link to v2 cover letter: https://lkml.org/lkml/2019/1/30/1003
> 
> Link to v1 cover letter: https://lwn.net/Articles/777342/
> 
> I would appricate any feedback, question and/or review.
> 
> Thanks,
> Oded
> 
> p.s. for those who prefer to clone the tree instead of looking at the
> emails, you can grab a copy from our company's page in GitHub:
> 
> https://github.com/HabanaAI/linux/releases/tag/hl_patchset_v3_20190204
>
> Oded Gabbay (14):
>   habanalabs: add skeleton driver
>   habanalabs: add Goya registers header files
>   habanalabs: add basic Goya support
>   habanalabs: add context and ASID modules
>   habanalabs: add command buffer module
>   habanalabs: add basic Goya h/w initialization
>   habanalabs: add h/w queues module
>   habanalabs: add event queue and interrupts
>   habanalabs: add sysfs and hwmon support
>   habanalabs: add device reset support
>   habanalabs: add command submission module
>   habanalabs: implement INFO IOCTL
>   habanalabs: add debugfs support
>   Update MAINTAINERS and CREDITS with habanalabs info
> 
> Omer Shpigelman (1):
>   habanalabs: add virtual memory and MMU modules

Nit: git am is unhappy about black lines at EOF, e.g:

Applying: habanalabs: add basic Goya support
.git/rebase-apply/patch:29: new blank line at EOF.
+

Aside from that, for patches 1, 3-11 and 13 feel free to add

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

As for the "habanalabs: add virtual memory and MMU modules" and the debugfs
patch I'll need more time to review the changes related to 2M pages.

>  CREDITS                                       |    2 +-
>  .../ABI/testing/debugfs-driver-habanalabs     |  127 +
>  .../ABI/testing/sysfs-driver-habanalabs       |  190 +
>  MAINTAINERS                                   |    9 +
>  drivers/misc/Kconfig                          |    1 +
>  drivers/misc/Makefile                         |    1 +
>  drivers/misc/habanalabs/Kconfig               |   22 +
>  drivers/misc/habanalabs/Makefile              |   15 +
>  drivers/misc/habanalabs/asid.c                |   58 +
>  drivers/misc/habanalabs/command_buffer.c      |  432 ++
>  drivers/misc/habanalabs/command_submission.c  |  782 +++
>  drivers/misc/habanalabs/context.c             |  216 +
>  drivers/misc/habanalabs/debugfs.c             | 1071 ++++
>  drivers/misc/habanalabs/device.c              | 1111 ++++
>  drivers/misc/habanalabs/goya/Makefile         |    4 +
>  drivers/misc/habanalabs/goya/goya.c           | 5344 +++++++++++++++++
>  drivers/misc/habanalabs/goya/goyaP.h          |  193 +
>  drivers/misc/habanalabs/goya/goya_hwmgr.c     |  306 +
>  drivers/misc/habanalabs/goya/goya_security.c  | 2999 +++++++++
>  drivers/misc/habanalabs/habanalabs.h          | 1441 +++++
>  drivers/misc/habanalabs/habanalabs_drv.c      |  465 ++
>  drivers/misc/habanalabs/habanalabs_ioctl.c    |  234 +
>  drivers/misc/habanalabs/hw_queue.c            |  636 ++
>  drivers/misc/habanalabs/hwmon.c               |  449 ++
>  drivers/misc/habanalabs/include/armcp_if.h    |  335 ++
>  .../include/goya/asic_reg/cpu_ca53_cfg_regs.h |  213 +
>  .../include/goya/asic_reg/cpu_if_regs.h       |  110 +
>  .../include/goya/asic_reg/cpu_pll_regs.h      |  186 +
>  .../include/goya/asic_reg/dma_ch_0_regs.h     |  512 ++
>  .../include/goya/asic_reg/dma_ch_1_regs.h     |  512 ++
>  .../include/goya/asic_reg/dma_ch_2_regs.h     |  512 ++
>  .../include/goya/asic_reg/dma_ch_3_regs.h     |  512 ++
>  .../include/goya/asic_reg/dma_ch_4_regs.h     |  512 ++
>  .../include/goya/asic_reg/dma_macro_regs.h    |  242 +
>  .../include/goya/asic_reg/dma_nrtr_regs.h     |  380 ++
>  .../include/goya/asic_reg/dma_qm_0_regs.h     |  543 ++
>  .../include/goya/asic_reg/dma_qm_1_regs.h     |  543 ++
>  .../include/goya/asic_reg/dma_qm_2_regs.h     |  543 ++
>  .../include/goya/asic_reg/dma_qm_3_regs.h     |  543 ++
>  .../include/goya/asic_reg/dma_qm_4_regs.h     |  543 ++
>  .../include/goya/asic_reg/goya_blocks.h       | 1372 +++++
>  .../include/goya/asic_reg/goya_masks.h        |  262 +
>  .../include/goya/asic_reg/goya_regs.h         |   99 +
>  .../include/goya/asic_reg/ic_pll_regs.h       |  186 +
>  .../include/goya/asic_reg/mc_pll_regs.h       |  186 +
>  .../include/goya/asic_reg/mme1_rtr_regs.h     |  876 +++
>  .../include/goya/asic_reg/mme2_rtr_regs.h     |  876 +++
>  .../include/goya/asic_reg/mme3_rtr_regs.h     |  876 +++
>  .../include/goya/asic_reg/mme4_rtr_regs.h     |  876 +++
>  .../include/goya/asic_reg/mme5_rtr_regs.h     |  876 +++
>  .../include/goya/asic_reg/mme6_rtr_regs.h     |  876 +++
>  .../include/goya/asic_reg/mme_cmdq_regs.h     |  431 ++
>  .../include/goya/asic_reg/mme_qm_regs.h       |  543 ++
>  .../include/goya/asic_reg/mme_regs.h          | 2422 ++++++++
>  .../include/goya/asic_reg/mmu_regs.h          |  158 +
>  .../include/goya/asic_reg/pci_nrtr_regs.h     |  380 ++
>  .../include/goya/asic_reg/pcie_aux_regs.h     |  476 ++
>  .../goya/asic_reg/psoc_emmc_pll_regs.h        |  186 +
>  .../goya/asic_reg/psoc_global_conf_regs.h     | 1119 ++++
>  .../include/goya/asic_reg/psoc_mme_pll_regs.h |  186 +
>  .../include/goya/asic_reg/psoc_pci_pll_regs.h |  186 +
>  .../include/goya/asic_reg/psoc_spi_regs.h     |  427 ++
>  .../goya/asic_reg/sram_y0_x0_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y0_x1_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y0_x2_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y0_x3_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y0_x4_rtr_regs.h       |  215 +
>  .../include/goya/asic_reg/stlb_regs.h         |  133 +
>  .../include/goya/asic_reg/tpc0_cfg_regs.h     | 2110 +++++++
>  .../include/goya/asic_reg/tpc0_cmdq_regs.h    |  431 ++
>  .../include/goya/asic_reg/tpc0_eml_cfg_regs.h |  580 ++
>  .../include/goya/asic_reg/tpc0_nrtr_regs.h    |  380 ++
>  .../include/goya/asic_reg/tpc0_qm_regs.h      |  543 ++
>  .../include/goya/asic_reg/tpc1_cfg_regs.h     | 2110 +++++++
>  .../include/goya/asic_reg/tpc1_cmdq_regs.h    |  431 ++
>  .../include/goya/asic_reg/tpc1_qm_regs.h      |  543 ++
>  .../include/goya/asic_reg/tpc1_rtr_regs.h     |  848 +++
>  .../include/goya/asic_reg/tpc2_cfg_regs.h     | 2110 +++++++
>  .../include/goya/asic_reg/tpc2_cmdq_regs.h    |  431 ++
>  .../include/goya/asic_reg/tpc2_qm_regs.h      |  543 ++
>  .../include/goya/asic_reg/tpc2_rtr_regs.h     |  848 +++
>  .../include/goya/asic_reg/tpc3_cfg_regs.h     | 2110 +++++++
>  .../include/goya/asic_reg/tpc3_cmdq_regs.h    |  431 ++
>  .../include/goya/asic_reg/tpc3_qm_regs.h      |  543 ++
>  .../include/goya/asic_reg/tpc3_rtr_regs.h     |  848 +++
>  .../include/goya/asic_reg/tpc4_cfg_regs.h     | 2110 +++++++
>  .../include/goya/asic_reg/tpc4_cmdq_regs.h    |  431 ++
>  .../include/goya/asic_reg/tpc4_qm_regs.h      |  543 ++
>  .../include/goya/asic_reg/tpc4_rtr_regs.h     |  848 +++
>  .../include/goya/asic_reg/tpc5_cfg_regs.h     | 2110 +++++++
>  .../include/goya/asic_reg/tpc5_cmdq_regs.h    |  431 ++
>  .../include/goya/asic_reg/tpc5_qm_regs.h      |  543 ++
>  .../include/goya/asic_reg/tpc5_rtr_regs.h     |  848 +++
>  .../include/goya/asic_reg/tpc6_cfg_regs.h     | 2110 +++++++
>  .../include/goya/asic_reg/tpc6_cmdq_regs.h    |  431 ++
>  .../include/goya/asic_reg/tpc6_qm_regs.h      |  543 ++
>  .../include/goya/asic_reg/tpc6_rtr_regs.h     |  848 +++
>  .../include/goya/asic_reg/tpc7_cfg_regs.h     | 2110 +++++++
>  .../include/goya/asic_reg/tpc7_cmdq_regs.h    |  431 ++
>  .../include/goya/asic_reg/tpc7_nrtr_regs.h    |  380 ++
>  .../include/goya/asic_reg/tpc7_qm_regs.h      |  543 ++
>  .../include/goya/asic_reg/tpc_pll_regs.h      |  186 +
>  drivers/misc/habanalabs/include/goya/goya.h   |   41 +
>  .../include/goya/goya_async_events.h          |  186 +
>  .../misc/habanalabs/include/goya/goya_fw_if.h |   28 +
>  .../habanalabs/include/goya/goya_packets.h    |  129 +
>  drivers/misc/habanalabs/include/hl_boot_if.h  |   30 +
>  .../include/hw_ip/mmu/mmu_general.h           |   45 +
>  .../habanalabs/include/hw_ip/mmu/mmu_v1_0.h   |   15 +
>  drivers/misc/habanalabs/include/qman_if.h     |   56 +
>  drivers/misc/habanalabs/irq.c                 |  325 +
>  drivers/misc/habanalabs/memory.c              | 1722 ++++++
>  drivers/misc/habanalabs/mmu.c                 |  604 ++
>  drivers/misc/habanalabs/sysfs.c               |  691 +++
>  include/uapi/misc/habanalabs.h                |  444 ++
>  115 files changed, 73533 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/debugfs-driver-habanalabs
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-habanalabs
>  create mode 100644 drivers/misc/habanalabs/Kconfig
>  create mode 100644 drivers/misc/habanalabs/Makefile
>  create mode 100644 drivers/misc/habanalabs/asid.c
>  create mode 100644 drivers/misc/habanalabs/command_buffer.c
>  create mode 100644 drivers/misc/habanalabs/command_submission.c
>  create mode 100644 drivers/misc/habanalabs/context.c
>  create mode 100644 drivers/misc/habanalabs/debugfs.c
>  create mode 100644 drivers/misc/habanalabs/device.c
>  create mode 100644 drivers/misc/habanalabs/goya/Makefile
>  create mode 100644 drivers/misc/habanalabs/goya/goya.c
>  create mode 100644 drivers/misc/habanalabs/goya/goyaP.h
>  create mode 100644 drivers/misc/habanalabs/goya/goya_hwmgr.c
>  create mode 100644 drivers/misc/habanalabs/goya/goya_security.c
>  create mode 100644 drivers/misc/habanalabs/habanalabs.h
>  create mode 100644 drivers/misc/habanalabs/habanalabs_drv.c
>  create mode 100644 drivers/misc/habanalabs/habanalabs_ioctl.c
>  create mode 100644 drivers/misc/habanalabs/hw_queue.c
>  create mode 100644 drivers/misc/habanalabs/hwmon.c
>  create mode 100644 drivers/misc/habanalabs/include/armcp_if.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/cpu_ca53_cfg_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/cpu_if_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/cpu_pll_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_0_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_1_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_2_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_3_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_4_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_macro_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_nrtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_0_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_1_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_2_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_3_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_4_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/goya_blocks.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/goya_masks.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/goya_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/ic_pll_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mc_pll_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme1_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme2_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme3_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme4_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme5_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme6_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_cmdq_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_qm_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mmu_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/pci_nrtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/pcie_aux_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_emmc_pll_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_global_conf_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_mme_pll_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_pci_pll_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_spi_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x0_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x1_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x2_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x3_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x4_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/stlb_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cfg_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cmdq_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_eml_cfg_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_nrtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_qm_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc1_cfg_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc1_cmdq_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc1_qm_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc1_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc2_cfg_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc2_cmdq_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc2_qm_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc2_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc3_cfg_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc3_cmdq_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc3_qm_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc3_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc4_cfg_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc4_cmdq_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc4_qm_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc4_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc5_cfg_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc5_cmdq_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc5_qm_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc5_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc6_cfg_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc6_cmdq_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc6_qm_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc6_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc7_cfg_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc7_cmdq_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc7_nrtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc7_qm_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc_pll_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/goya.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/goya_async_events.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/goya_fw_if.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/goya_packets.h
>  create mode 100644 drivers/misc/habanalabs/include/hl_boot_if.h
>  create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
>  create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v1_0.h
>  create mode 100644 drivers/misc/habanalabs/include/qman_if.h
>  create mode 100644 drivers/misc/habanalabs/irq.c
>  create mode 100644 drivers/misc/habanalabs/memory.c
>  create mode 100644 drivers/misc/habanalabs/mmu.c
>  create mode 100644 drivers/misc/habanalabs/sysfs.c
>  create mode 100644 include/uapi/misc/habanalabs.h
> 
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

