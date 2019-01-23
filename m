Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A8EC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC47421019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfAWM2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:28:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60378 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725995AbfAWM2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:28:07 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0NCORqC015699
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 07:28:05 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q6qqh9q31-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 07:28:04 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 23 Jan 2019 12:28:02 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 23 Jan 2019 12:27:58 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0NCRvCn9175476
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Jan 2019 12:27:57 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90A4A42042;
        Wed, 23 Jan 2019 12:27:57 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F74C4203F;
        Wed, 23 Jan 2019 12:27:57 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.208])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 23 Jan 2019 12:27:57 +0000 (GMT)
Date:   Wed, 23 Jan 2019 14:27:55 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ogabbay@habana.ai
Subject: Re: [PATCH 00/15] Habana Labs kernel driver
References: <20190123000057.31477-1-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123000057.31477-1-oded.gabbay@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19012312-0016-0000-0000-000002494BB7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012312-0017-0000-0000-000032A389EB
Message-Id: <20190123122752.GA2194@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-23_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901230093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 23, 2019 at 02:00:42AM +0200, Oded Gabbay wrote:
> Hello,
> 
> For those who don't know me, my name is Oded Gabbay (Kernel Maintainer
> for AMD's amdkfd driver, worked at RedHat's Desktop group) and I work at
> Habana Labs since its inception two and a half years ago. 
> 
> Habana is a leading startup in the emerging AI processor space and we have
> already started production of our first Goya inference processor PCIe card
> and delivered it to customers. The Goya processor silicon has been tested
> since June of 2018 and is production-qualified by now. The Gaudi training
> processor solution is slated to sample in the second quarter of 2019.
> 
> This patch-set contains the kernel driver for Habana's AI Processors 
> (AIP) that are designed to accelerate Deep Learning inference and training
> workloads. The current version supports only the Goya processor and
> support for Gaudi will be upstreamed after the ASIC will be available to
> customers.
> 
> The Goya processor has been designed from the ground up for deep learning
> inference workloads. It comprises a cluster of eight fully programmable
> Tensor Processing Cores (TPC). The TPC core is a VLIW SIMD vector
> processor with ISA and hardware that was tailored to serve deep learning
> workloads efficiently. 

[ ... ] 
 
> I would appricate any feedback, question and/or review.

I've looked at the patches 1,3-5 for now, it seems patch 2 still didn't
make it to lore.kernel.org.

FWIW, I think it's a good solid work, unless you spoil it in patches 6-14
;-)

As a general note, maybe drivers/misc is not the most appropriate place for
such a complex beast. How about drivers/accelerator/ai?
 
> p.s. for those who prefer to clone the tree instead of looking at the
> emails, you can grab a copy from our company's page in GitHub:
> 
> https://github.com/HabanaAI/linux/releases/tag/hl_patchset_v1
> 
> Thanks,
> Oded
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
> 
>  CREDITS                                       |    2 +-
>  .../ABI/testing/debugfs-driver-habanalabs     |  127 +
>  .../ABI/testing/sysfs-driver-habanalabs       |  190 +
>  MAINTAINERS                                   |    9 +
>  drivers/misc/Kconfig                          |    1 +
>  drivers/misc/Makefile                         |    1 +
>  drivers/misc/habanalabs/Kconfig               |   22 +
>  drivers/misc/habanalabs/Makefile              |   14 +
>  drivers/misc/habanalabs/asid.c                |   58 +
>  drivers/misc/habanalabs/command_buffer.c      |  425 +
>  drivers/misc/habanalabs/command_submission.c  |  799 ++
>  drivers/misc/habanalabs/context.c             |  216 +
>  drivers/misc/habanalabs/debugfs.c             | 1069 ++
>  drivers/misc/habanalabs/device.c              | 1097 ++
>  drivers/misc/habanalabs/goya/Makefile         |    3 +
>  drivers/misc/habanalabs/goya/goya.c           | 6347 ++++++++++++
>  drivers/misc/habanalabs/goya/goyaP.h          |  161 +
>  drivers/misc/habanalabs/goya/goya_hwmgr.c     |  306 +
>  drivers/misc/habanalabs/goya/goya_security.c  | 2999 ++++++
>  drivers/misc/habanalabs/habanalabs.h          | 1464 +++
>  drivers/misc/habanalabs/habanalabs_drv.c      |  474 +
>  drivers/misc/habanalabs/habanalabs_ioctl.c    |  237 +
>  drivers/misc/habanalabs/hw_queue.c            |  654 ++
>  drivers/misc/habanalabs/hwmon.c               |  449 +
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
>  drivers/misc/habanalabs/include/goya/goya.h   |  117 +
>  .../include/goya/goya_async_events.h          |  186 +
>  .../habanalabs/include/goya/goya_boot_if.h    |   32 +
>  .../habanalabs/include/goya/goya_packets.h    |  234 +
>  .../habanalabs/include/habanalabs_device_if.h |  397 +
>  .../include/hw_ip/mmu/mmu_general.h           |   45 +
>  .../habanalabs/include/hw_ip/mmu/mmu_v1_0.h   |   15 +
>  drivers/misc/habanalabs/irq.c                 |  325 +
>  drivers/misc/habanalabs/memory.c              | 1714 ++++
>  drivers/misc/habanalabs/mmu.c                 |  604 ++
>  drivers/misc/habanalabs/sysfs.c               |  690 ++
>  include/uapi/misc/habanalabs.h                |  412 +
>  145 files changed, 99610 insertions(+), 1 deletion(-)
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
>  create mode 100644 drivers/misc/habanalabs/include/goya/goya_packets.h
>  create mode 100644 drivers/misc/habanalabs/include/habanalabs_device_if.h
>  create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
>  create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v1_0.h
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

