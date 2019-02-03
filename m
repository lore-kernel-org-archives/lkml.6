Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5903C282DB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 11:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D4521773
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 11:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfBCLuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 06:50:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60246 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726970AbfBCLuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 06:50:10 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x13BhOPi166715
        for <linux-kernel@vger.kernel.org>; Sun, 3 Feb 2019 06:50:06 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qdsn9bj27-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 06:50:06 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sun, 3 Feb 2019 11:50:04 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 3 Feb 2019 11:50:01 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x13Bo0r131850702
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 3 Feb 2019 11:50:00 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2CE652050;
        Sun,  3 Feb 2019 11:50:00 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 28DE75204E;
        Sun,  3 Feb 2019 11:50:00 +0000 (GMT)
Date:   Sun, 3 Feb 2019 13:49:58 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        olof@lixom.net, ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: Re: [PATCH v2 00/15] Habana Labs kernel driver
References: <20190130220617.4862-1-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130220617.4862-1-oded.gabbay@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19020311-0008-0000-0000-000002BA7E5B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020311-0009-0000-0000-0000222689C4
Message-Id: <20190203114957.GD8620@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-03_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902030100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oded,

On Thu, Jan 31, 2019 at 12:06:02AM +0200, Oded Gabbay wrote:
> Hello,
> This is v2 of the Habana Labs kernel driver patch-set. It contains fixes
> for almost everything that was brought up in the review of v1.
> 
> In addition to local changes in each patch that are detailed in each
> patch's commit message, the global/major changes are:
> 
> - Rebased on v5.0-rc4
> - Removed all bitfields from interface files to H/W and F/W
> - Use __le16/32/64 instead of __u16/32/64 in F/W or H/W structures

For v2 I had comments only for "[PATCH v2 07/15] habanalabs: add h/w queues
module".

There are still several over-exited printk calls with three exclamation
marks. ;-)

I've also spotted several places where checkpatch.pl may complain, but I
was to lazy to actually check it.
 
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
> https://github.com/HabanaAI/linux/releases/tag/hl_patchset_v2_20190130
> 
> Oded Gabbay (14):
>   habanalabs: add skeleton driver
>   habanalabs: add Goya registers header files

This one is 4.3M which is 6 times the entire habanalabs driver without
those headers.
Any chance some of it can be dropped?

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
> 
>  CREDITS                                       |    2 +-
>  .../ABI/testing/debugfs-driver-habanalabs     |  127 +
>  .../ABI/testing/sysfs-driver-habanalabs       |  190 +
>  MAINTAINERS                                   |    9 +
>  drivers/misc/Kconfig                          |    1 +
>  drivers/misc/Makefile                         |    1 +
>  drivers/misc/habanalabs/Kconfig               |   22 +
>  drivers/misc/habanalabs/Makefile              |   15 +
>  drivers/misc/habanalabs/asid.c                |   58 +
>  drivers/misc/habanalabs/command_buffer.c      |  432 +
>  drivers/misc/habanalabs/command_submission.c  |  787 ++
>  drivers/misc/habanalabs/context.c             |  216 +
>  drivers/misc/habanalabs/debugfs.c             | 1071 ++
>  drivers/misc/habanalabs/device.c              | 1110 ++
>  drivers/misc/habanalabs/goya/Makefile         |    4 +
>  drivers/misc/habanalabs/goya/goya.c           | 5338 ++++++++++
>  drivers/misc/habanalabs/goya/goyaP.h          |  193 +
>  drivers/misc/habanalabs/goya/goya_hwmgr.c     |  306 +
>  drivers/misc/habanalabs/goya/goya_security.c  | 2999 ++++++
>  drivers/misc/habanalabs/habanalabs.h          | 1448 +++
>  drivers/misc/habanalabs/habanalabs_drv.c      |  469 +
>  drivers/misc/habanalabs/habanalabs_ioctl.c    |  234 +
>  drivers/misc/habanalabs/hw_queue.c            |  654 ++
>  drivers/misc/habanalabs/hwmon.c               |  449 +
>  drivers/misc/habanalabs/include/armcp_if.h    |  335 +
>  .../include/goya/asic_reg/cpu_ca53_cfg_regs.h |  213 +
>  .../include/goya/asic_reg/cpu_if_regs.h       |  110 +
>  .../include/goya/asic_reg/cpu_pll_regs.h      |  186 +
>  .../include/goya/asic_reg/ddr_mc_ch0_regs.h   | 1158 +++
>  .../include/goya/asic_reg/ddr_mc_ch1_regs.h   | 1158 +++
>  .../include/goya/asic_reg/ddr_misc_ch0_regs.h |  156 +
>  .../include/goya/asic_reg/ddr_misc_ch1_regs.h |  156 +
>  .../include/goya/asic_reg/dma_ch_0_regs.h     |  512 +
>  .../include/goya/asic_reg/dma_ch_1_regs.h     |  512 +
>  .../include/goya/asic_reg/dma_ch_2_regs.h     |  512 +
>  .../include/goya/asic_reg/dma_ch_3_regs.h     |  512 +
>  .../include/goya/asic_reg/dma_ch_4_regs.h     |  512 +
>  .../include/goya/asic_reg/dma_macro_regs.h    |  242 +
>  .../include/goya/asic_reg/dma_nrtr_regs.h     |  380 +
>  .../include/goya/asic_reg/dma_qm_0_regs.h     |  543 +
>  .../include/goya/asic_reg/dma_qm_1_regs.h     |  543 +
>  .../include/goya/asic_reg/dma_qm_2_regs.h     |  543 +
>  .../include/goya/asic_reg/dma_qm_3_regs.h     |  543 +
>  .../include/goya/asic_reg/dma_qm_4_regs.h     |  543 +
>  .../include/goya/asic_reg/gic_regs.h          | 9079 +++++++++++++++++
>  .../include/goya/asic_reg/goya_blocks.h       | 1372 +++
>  .../include/goya/asic_reg/goya_masks.h        |  262 +
>  .../include/goya/asic_reg/goya_regs.h         |  119 +
>  .../include/goya/asic_reg/ic_pll_regs.h       |  186 +
>  .../include/goya/asic_reg/mc_pll_regs.h       |  186 +
>  .../include/goya/asic_reg/mme1_rtr_regs.h     |  876 ++
>  .../include/goya/asic_reg/mme2_rtr_regs.h     |  876 ++
>  .../include/goya/asic_reg/mme3_rtr_regs.h     |  876 ++
>  .../include/goya/asic_reg/mme4_rtr_regs.h     |  876 ++
>  .../include/goya/asic_reg/mme5_rtr_regs.h     |  876 ++
>  .../include/goya/asic_reg/mme6_rtr_regs.h     |  876 ++
>  .../include/goya/asic_reg/mme_cmdq_regs.h     |  431 +
>  .../include/goya/asic_reg/mme_qm_regs.h       |  543 +
>  .../include/goya/asic_reg/mme_regs.h          | 2422 +++++
>  .../include/goya/asic_reg/mmu_regs.h          |  158 +
>  .../include/goya/asic_reg/pci_nrtr_regs.h     |  380 +
>  .../include/goya/asic_reg/pcie_aux_regs.h     |  476 +
>  .../include/goya/asic_reg/pcie_dbi_regs.h     | 2909 ++++++
>  .../goya/asic_reg/psoc_emmc_pll_regs.h        |  186 +
>  .../goya/asic_reg/psoc_global_conf_regs.h     | 1119 ++
>  .../include/goya/asic_reg/psoc_mme_pll_regs.h |  186 +
>  .../include/goya/asic_reg/psoc_pci_pll_regs.h |  186 +
>  .../include/goya/asic_reg/psoc_spi_regs.h     |  427 +
>  .../goya/asic_reg/sram_y0_x0_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y0_x1_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y0_x2_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y0_x3_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y0_x4_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y1_x0_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y1_x1_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y1_x2_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y1_x3_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y1_x4_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y2_x0_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y2_x1_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y2_x2_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y2_x3_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y2_x4_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y3_x0_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y3_x1_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y3_x2_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y3_x3_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y3_x4_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y4_x0_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y4_x1_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y4_x2_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y4_x3_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y4_x4_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y5_x0_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y5_x1_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y5_x2_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y5_x3_rtr_regs.h       |  215 +
>  .../goya/asic_reg/sram_y5_x4_rtr_regs.h       |  215 +
>  .../include/goya/asic_reg/stlb_regs.h         |  133 +
>  .../include/goya/asic_reg/sync_mngr_regs.h    | 4930 +++++++++
>  .../include/goya/asic_reg/tpc0_cfg_regs.h     | 2110 ++++
>  .../include/goya/asic_reg/tpc0_cmdq_regs.h    |  431 +
>  .../include/goya/asic_reg/tpc0_eml_cfg_regs.h |  580 ++
>  .../include/goya/asic_reg/tpc0_nrtr_regs.h    |  380 +
>  .../include/goya/asic_reg/tpc0_qm_regs.h      |  543 +
>  .../include/goya/asic_reg/tpc1_cfg_regs.h     | 2110 ++++
>  .../include/goya/asic_reg/tpc1_cmdq_regs.h    |  431 +
>  .../include/goya/asic_reg/tpc1_qm_regs.h      |  543 +
>  .../include/goya/asic_reg/tpc1_rtr_regs.h     |  848 ++
>  .../include/goya/asic_reg/tpc2_cfg_regs.h     | 2110 ++++
>  .../include/goya/asic_reg/tpc2_cmdq_regs.h    |  431 +
>  .../include/goya/asic_reg/tpc2_qm_regs.h      |  543 +
>  .../include/goya/asic_reg/tpc2_rtr_regs.h     |  848 ++
>  .../include/goya/asic_reg/tpc3_cfg_regs.h     | 2110 ++++
>  .../include/goya/asic_reg/tpc3_cmdq_regs.h    |  431 +
>  .../include/goya/asic_reg/tpc3_qm_regs.h      |  543 +
>  .../include/goya/asic_reg/tpc3_rtr_regs.h     |  848 ++
>  .../include/goya/asic_reg/tpc4_cfg_regs.h     | 2110 ++++
>  .../include/goya/asic_reg/tpc4_cmdq_regs.h    |  431 +
>  .../include/goya/asic_reg/tpc4_qm_regs.h      |  543 +
>  .../include/goya/asic_reg/tpc4_rtr_regs.h     |  848 ++
>  .../include/goya/asic_reg/tpc5_cfg_regs.h     | 2110 ++++
>  .../include/goya/asic_reg/tpc5_cmdq_regs.h    |  431 +
>  .../include/goya/asic_reg/tpc5_qm_regs.h      |  543 +
>  .../include/goya/asic_reg/tpc5_rtr_regs.h     |  848 ++
>  .../include/goya/asic_reg/tpc6_cfg_regs.h     | 2110 ++++
>  .../include/goya/asic_reg/tpc6_cmdq_regs.h    |  431 +
>  .../include/goya/asic_reg/tpc6_qm_regs.h      |  543 +
>  .../include/goya/asic_reg/tpc6_rtr_regs.h     |  848 ++
>  .../include/goya/asic_reg/tpc7_cfg_regs.h     | 2110 ++++
>  .../include/goya/asic_reg/tpc7_cmdq_regs.h    |  431 +
>  .../include/goya/asic_reg/tpc7_nrtr_regs.h    |  380 +
>  .../include/goya/asic_reg/tpc7_qm_regs.h      |  543 +
>  .../include/goya/asic_reg/tpc_pll_regs.h      |  186 +
>  drivers/misc/habanalabs/include/goya/goya.h   |   41 +
>  .../include/goya/goya_async_events.h          |  186 +
>  .../habanalabs/include/goya/goya_boot_if.h    |   30 +
>  .../misc/habanalabs/include/goya/goya_fw_if.h |   28 +
>  .../habanalabs/include/goya/goya_packets.h    |  129 +
>  .../include/hw_ip/mmu/mmu_general.h           |   45 +
>  .../habanalabs/include/hw_ip/mmu/mmu_v1_0.h   |   15 +
>  drivers/misc/habanalabs/include/qman_if.h     |   56 +
>  drivers/misc/habanalabs/irq.c                 |  325 +
>  drivers/misc/habanalabs/memory.c              | 1713 ++++
>  drivers/misc/habanalabs/mmu.c                 |  604 ++
>  drivers/misc/habanalabs/sysfs.c               |  691 ++
>  include/uapi/misc/habanalabs.h                |  444 +
>  147 files changed, 98492 insertions(+), 1 deletion(-)
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
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/ddr_mc_ch0_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/ddr_mc_ch1_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/ddr_misc_ch0_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/ddr_misc_ch1_regs.h
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
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/gic_regs.h
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
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/pcie_dbi_regs.h
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
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y1_x0_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y1_x1_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y1_x2_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y1_x3_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y1_x4_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y2_x0_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y2_x1_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y2_x2_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y2_x3_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y2_x4_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y3_x0_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y3_x1_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y3_x2_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y3_x3_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y3_x4_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y4_x0_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y4_x1_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y4_x2_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y4_x3_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y4_x4_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y5_x0_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y5_x1_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y5_x2_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y5_x3_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y5_x4_rtr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/stlb_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sync_mngr_regs.h
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
>  create mode 100644 drivers/misc/habanalabs/include/goya/goya_boot_if.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/goya_fw_if.h
>  create mode 100644 drivers/misc/habanalabs/include/goya/goya_packets.h
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

