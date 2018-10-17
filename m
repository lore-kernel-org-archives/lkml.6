Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607E3ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087A721526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087A721526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeJQRn5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:43:57 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2099 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726691AbeJQRn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:43:57 -0400
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 195FB52B42EFE;
        Wed, 17 Oct 2018 10:49:00 +0100 (IST)
Received: from FRAEML704-CAH.china.huawei.com (10.206.14.35) by
 lhreml701-cah.china.huawei.com (10.201.108.42) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 17 Oct 2018 10:49:01 +0100
Received: from FRAEML521-MBX.china.huawei.com ([169.254.1.206]) by
 FRAEML704-CAH.china.huawei.com ([10.206.14.35]) with mapi id 14.03.0415.000;
 Wed, 17 Oct 2018 11:48:54 +0200
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     kbuild test robot <lkp@intel.com>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        John Garry <john.garry@huawei.com>,
        "pabba@codeaurora.org" <pabba@codeaurora.org>,
        "vkilari@codeaurora.org" <vkilari@codeaurora.org>,
        "rruigrok@codeaurora.org" <rruigrok@codeaurora.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        "neil.m.leeder@gmail.com" <neil.m.leeder@gmail.com>
Subject: RE: [PATCH v4 3/4] perf/smmuv3: Add MSI irq support
Thread-Topic: [PATCH v4 3/4] perf/smmuv3: Add MSI irq support
Thread-Index: AQHUZU7452VJ+Ekpgk2jv+dRJ9wIK6UiqNuAgACFu2A=
Date:   Wed, 17 Oct 2018 09:48:53 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83879F3FB@FRAEML521-MBX.china.huawei.com>
References: <20181016124920.24708-4-shameerali.kolothum.thodi@huawei.com>
 <201810171145.mGVw4SgU%fengguang.wu@intel.com>
In-Reply-To: <201810171145.mGVw4SgU%fengguang.wu@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: kbuild test robot [mailto:lkp@intel.com]
> Sent: 17 October 2018 04:36
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: kbuild-all@01.org; lorenzo.pieralisi@arm.com; robin.murphy@arm.com;
> jean-philippe.brucker@arm.com; will.deacon@arm.com;
> mark.rutland@arm.com; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
> John Garry <john.garry@huawei.com>; pabba@codeaurora.org;
> vkilari@codeaurora.org; rruigrok@codeaurora.org; linux-
> acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Linuxarm <linuxarm@huawei.com>;
> neil.m.leeder@gmail.com
> Subject: Re: [PATCH v4 3/4] perf/smmuv3: Add MSI irq support
> 
> Hi Shameer,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linux-sof-driver/master]
> [also build test ERROR on v4.19-rc8 next-20181016]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Shameer-Kolothum/arm64-
> SMMUv3-PMU-driver-with-IORT-support/20181017-063949
> base:   https://github.com/thesofproject/linux master
> config: sh-allmodconfig (attached as .config)
> compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-
> tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=sh
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/kernel.h:11:0,
>                     from include/linux/list.h:9,
>                     from include/linux/resource_ext.h:17,
>                     from include/linux/acpi.h:26,
>                     from drivers//perf/arm_smmuv3_pmu.c:37:
>    drivers//perf/arm_smmuv3_pmu.c: In function
> 'smmu_pmu_counter_set_value':
>    include/linux/bitops.h:7:24: warning: left shift count >= width of type [-Wshift-
> count-overflow]
>     #define BIT(nr)   (1UL << (nr))
>                            ^
>    drivers//perf/arm_smmuv3_pmu.c:152:31: note: in expansion of macro 'BIT'
>      if (smmu_pmu->counter_mask & BIT(32))
>                                   ^~~
>    drivers//perf/arm_smmuv3_pmu.c: In function
> 'smmu_pmu_counter_get_value':
>    include/linux/bitops.h:7:24: warning: left shift count >= width of type [-Wshift-
> count-overflow]
>     #define BIT(nr)   (1UL << (nr))
>                            ^
>    drivers//perf/arm_smmuv3_pmu.c:162:31: note: in expansion of macro 'BIT'
>      if (smmu_pmu->counter_mask & BIT(32))
>                                   ^~~
>    drivers//perf/arm_smmuv3_pmu.c: In function 'smmu_pmu_free_msis':
> >> drivers//perf/arm_smmuv3_pmu.c:601:2: error: implicit declaration of
> function 'platform_msi_domain_free_irqs'; did you mean
> 'platform_get_device_id'? [-Werror=implicit-function-declaration]
>      platform_msi_domain_free_irqs(dev);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ok. This is probably because of the COMPILE_TEST added to patch #2 and
this one will have dependency on PCI/PCI_MSI. I will remove that in next
revision.

Thanks,
Shameer

>      platform_get_device_id
>    drivers//perf/arm_smmuv3_pmu.c: In function 'smmu_pmu_setup_msi':
> >> drivers//perf/arm_smmuv3_pmu.c:632:8: error: implicit declaration of
> function 'platform_msi_domain_alloc_irqs'; did you mean
> 'platform_device_alloc'? [-Werror=implicit-function-declaration]
>      ret = platform_msi_domain_alloc_irqs(dev, 1, smmu_pmu_write_msi_msg);
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>            platform_device_alloc
>    In file included from include/linux/list.h:9:0,
>                     from include/linux/resource_ext.h:17,
>                     from include/linux/acpi.h:26,
>                     from drivers//perf/arm_smmuv3_pmu.c:37:
>    include/linux/msi.h:114:38: error: 'struct device' has no member named
> 'msi_list'
>     #define dev_to_msi_list(dev)  (&(dev)->msi_list)
>                                          ^
>    include/linux/kernel.h:961:26: note: in definition of macro 'container_of'
>      void *__mptr = (void *)(ptr);     \
>                              ^~~
>    include/linux/list.h:377:2: note: in expansion of macro 'list_entry'
>      list_entry((ptr)->next, type, member)
>      ^~~~~~~~~~
>    include/linux/msi.h:116:2: note: in expansion of macro 'list_first_entry'
>      list_first_entry(dev_to_msi_list((dev)), struct msi_desc, list)
>      ^~~~~~~~~~~~~~~~
>    include/linux/msi.h:116:19: note: in expansion of macro 'dev_to_msi_list'
>      list_first_entry(dev_to_msi_list((dev)), struct msi_desc, list)
>                       ^~~~~~~~~~~~~~~
> >> drivers//perf/arm_smmuv3_pmu.c:638:9: note: in expansion of macro
> 'first_msi_entry'
>      desc = first_msi_entry(dev);
>             ^~~~~~~~~~~~~~~
>    In file included from include/linux/ioport.h:13:0,
>                     from include/linux/acpi.h:25,
>                     from drivers//perf/arm_smmuv3_pmu.c:37:
>    include/linux/msi.h:114:38: error: 'struct device' has no member named
> 'msi_list'
>     #define dev_to_msi_list(dev)  (&(dev)->msi_list)
>                                          ^
>    include/linux/compiler.h:316:19: note: in definition of macro
> '__compiletime_assert'
>       bool __cond = !(condition);    \
>                       ^~~~~~~~~
>    include/linux/compiler.h:339:2: note: in expansion of macro
> '_compiletime_assert'
>      _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>      ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:45:37: note: in expansion of macro
> 'compiletime_assert'
>     #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                         ^~~~~~~~~~~~~~~~~~
>    include/linux/kernel.h:962:2: note: in expansion of macro
> 'BUILD_BUG_ON_MSG'
>      BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
>      ^~~~~~~~~~~~~~~~
>    include/linux/kernel.h:962:20: note: in expansion of macro '__same_type'
>      BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
>                        ^~~~~~~~~~~
>    include/linux/list.h:366:2: note: in expansion of macro 'container_of'
>      container_of(ptr, type, member)
>      ^~~~~~~~~~~~
>    include/linux/list.h:377:2: note: in expansion of macro 'list_entry'
>      list_entry((ptr)->next, type, member)
>      ^~~~~~~~~~
>    include/linux/msi.h:116:2: note: in expansion of macro 'list_first_entry'
>      list_first_entry(dev_to_msi_list((dev)), struct msi_desc, list)
>      ^~~~~~~~~~~~~~~~
>    include/linux/msi.h:116:19: note: in expansion of macro 'dev_to_msi_list'
>      list_first_entry(dev_to_msi_list((dev)), struct msi_desc, list)
>                       ^~~~~~~~~~~~~~~
> >> drivers//perf/arm_smmuv3_pmu.c:638:9: note: in expansion of macro
> 'first_msi_entry'
>      desc = first_msi_entry(dev);
>             ^~~~~~~~~~~~~~~
>    include/linux/msi.h:114:38: error: 'struct device' has no member named
> 'msi_list'
>     #define dev_to_msi_list(dev)  (&(dev)->msi_list)
>                                          ^
>    include/linux/compiler.h:316:19: note: in definition of macro
> '__compiletime_assert'
>       bool __cond = !(condition);    \
>                       ^~~~~~~~~
>    include/linux/compiler.h:339:2: note: in expansion of macro
> '_compiletime_assert'
>      _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>      ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:45:37: note: in expansion of macro
> 'compiletime_assert'
>     #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                         ^~~~~~~~~~~~~~~~~~
>    include/linux/kernel.h:962:2: note: in expansion of macro
> 'BUILD_BUG_ON_MSG'
>      BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
>      ^~~~~~~~~~~~~~~~
>    include/linux/kernel.h:963:6: note: in expansion of macro '__same_type'
>         !__same_type(*(ptr), void),   \
>          ^~~~~~~~~~~
>    include/linux/list.h:366:2: note: in expansion of macro 'container_of'
>      container_of(ptr, type, member)
>      ^~~~~~~~~~~~
>    include/linux/list.h:377:2: note: in expansion of macro 'list_entry'
>      list_entry((ptr)->next, type, member)
>      ^~~~~~~~~~
>    include/linux/msi.h:116:2: note: in expansion of macro 'list_first_entry'
>      list_first_entry(dev_to_msi_list((dev)), struct msi_desc, list)
>      ^~~~~~~~~~~~~~~~
>    include/linux/msi.h:116:19: note: in expansion of macro 'dev_to_msi_list'
>      list_first_entry(dev_to_msi_list((dev)), struct msi_desc, list)
>                       ^~~~~~~~~~~~~~~
> >> drivers//perf/arm_smmuv3_pmu.c:638:9: note: in expansion of macro
> 'first_msi_entry'
>      desc = first_msi_entry(dev);
>             ^~~~~~~~~~~~~~~
>    drivers//perf/arm_smmuv3_pmu.c: In function 'smmu_pmu_probe':
>    drivers//perf/arm_smmuv3_pmu.c:745:64: warning: format '%llx' expects
> argument of type 'long long unsigned int', but argument 4 has type
> 'resource_size_t {aka unsigned int}' [-Wformat=]
>      name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "smmuv3_pmcg_%llx",
>                                                                 ~~~^
>                                                                 %x
>    cc1: some warnings being treated as errors
> 
> vim +601 drivers//perf/arm_smmuv3_pmu.c
> 
>    596
>    597	static void smmu_pmu_free_msis(void *data)
>    598	{
>    599		struct device *dev = data;
>    600
>  > 601		platform_msi_domain_free_irqs(dev);
>    602	}
>    603
>    604	static void smmu_pmu_write_msi_msg(struct msi_desc *desc, struct
> msi_msg *msg)
>    605	{
>    606		phys_addr_t doorbell;
>    607		struct device *dev = msi_desc_to_dev(desc);
>    608		struct smmu_pmu *pmu = dev_get_drvdata(dev);
>    609
>    610		doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
>    611		doorbell &= MSI_CFG0_ADDR_MASK;
>    612
>    613		writeq_relaxed(doorbell, pmu->reg_base +
> SMMU_PMCG_IRQ_CFG0);
>    614		writel_relaxed(msg->data, pmu->reg_base +
> SMMU_PMCG_IRQ_CFG1);
>    615		writel_relaxed(MSI_CFG2_MEMATTR_DEVICE_nGnRE,
>    616			       pmu->reg_base + SMMU_PMCG_IRQ_CFG2);
>    617	}
>    618
>    619	static void smmu_pmu_setup_msi(struct smmu_pmu *pmu)
>    620	{
>    621		struct msi_desc *desc;
>    622		struct device *dev = pmu->dev;
>    623		int ret;
>    624
>    625		/* Clear MSI address reg */
>    626		writeq_relaxed(0, pmu->reg_base +
> SMMU_PMCG_IRQ_CFG0);
>    627
>    628		/* MSI supported or not */
>    629		if (!(readl(pmu->reg_base + SMMU_PMCG_CFGR) &
> SMMU_PMCG_CFGR_MSI))
>    630			return;
>    631
>  > 632		ret = platform_msi_domain_alloc_irqs(dev, 1,
> smmu_pmu_write_msi_msg);
>    633		if (ret) {
>    634			dev_warn(dev, "failed to allocate MSIs\n");
>    635			return;
>    636		}
>    637
>  > 638		desc = first_msi_entry(dev);
>    639		if (desc)
>    640			pmu->irq = desc->irq;
>    641
>    642		/* Add callback to free MSIs on teardown */
>    643		devm_add_action(dev, smmu_pmu_free_msis, dev);
>    644	}
>    645
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
