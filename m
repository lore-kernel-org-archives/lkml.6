Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF299C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576C42145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576C42145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeJRR0i convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:26:38 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2100 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727363AbeJRR0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:26:38 -0400
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 5C5B186727397;
        Thu, 18 Oct 2018 10:26:28 +0100 (IST)
Received: from FRAEMA701-CHM.china.huawei.com (10.206.14.50) by
 lhreml705-cah.china.huawei.com (10.201.108.46) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 18 Oct 2018 10:26:28 +0100
Received: from FRAEML521-MBX.china.huawei.com ([169.254.1.206]) by
 FRAEMA701-CHM.china.huawei.com ([169.254.1.199]) with mapi id 14.03.0415.000;
 Thu, 18 Oct 2018 11:26:20 +0200
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
Subject: RE: [PATCH v4 2/4] perf: add arm64 smmuv3 pmu driver
Thread-Topic: [PATCH v4 2/4] perf: add arm64 smmuv3 pmu driver
Thread-Index: AQHUZU76kAGwo851I0CXtUrI2KE5/aUj22aAgADhz1A=
Date:   Thu, 18 Oct 2018 09:26:19 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83879FFDA@FRAEML521-MBX.china.huawei.com>
References: <20181016124920.24708-3-shameerali.kolothum.thodi@huawei.com>
 <201810180536.3mHoIqvz%fengguang.wu@intel.com>
In-Reply-To: <201810180536.3mHoIqvz%fengguang.wu@intel.com>
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
> Sent: 17 October 2018 22:53
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: kbuild-all@01.org; lorenzo.pieralisi@arm.com; robin.murphy@arm.com;
> jean-philippe.brucker@arm.com; will.deacon@arm.com;
> mark.rutland@arm.com; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
> John Garry <john.garry@huawei.com>; pabba@codeaurora.org;
> vkilari@codeaurora.org; rruigrok@codeaurora.org; linux-
> acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Linuxarm <linuxarm@huawei.com>;
> neil.m.leeder@gmail.com
> Subject: Re: [PATCH v4 2/4] perf: add arm64 smmuv3 pmu driver
> 
> Hi Neil,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linux-sof-driver/master]
> [also build test ERROR on v4.19-rc8 next-20181017]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Shameer-Kolothum/arm64-
> SMMUv3-PMU-driver-with-IORT-support/20181017-063949
> base:   https://github.com/thesofproject/linux master
> config: xtensa-allyesconfig (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 8.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-
> tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.1.0 make.cross ARCH=xtensa
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/kernel.h:11,
>                     from include/linux/list.h:9,
>                     from include/linux/resource_ext.h:17,
>                     from include/linux/acpi.h:26,
>                     from drivers//perf/arm_smmuv3_pmu.c:37:
>    drivers//perf/arm_smmuv3_pmu.c: In function
> 'smmu_pmu_counter_set_value':
>    include/linux/bitops.h:7:24: warning: left shift count >= width of type [-Wshift-
> count-overflow]
>     #define BIT(nr)   (1UL << (nr))
>                            ^~
>    drivers//perf/arm_smmuv3_pmu.c:145:31: note: in expansion of macro 'BIT'
>      if (smmu_pmu->counter_mask & BIT(32))
>                                   ^~~
>    drivers//perf/arm_smmuv3_pmu.c:146:3: error: implicit declaration of
> function 'writeq'; did you mean 'writel'? [-Werror=implicit-function-
> declaration]
>       writeq(value, smmu_pmu->reloc_base + SMMU_PMCG_EVCNTR(idx, 8));
>       ^~~~~~
>       writel
>    In file included from include/linux/kernel.h:11,
>                     from include/linux/list.h:9,
>                     from include/linux/resource_ext.h:17,
>                     from include/linux/acpi.h:26,
>                     from drivers//perf/arm_smmuv3_pmu.c:37:
>    drivers//perf/arm_smmuv3_pmu.c: In function
> 'smmu_pmu_counter_get_value':
>    include/linux/bitops.h:7:24: warning: left shift count >= width of type [-Wshift-
> count-overflow]
>     #define BIT(nr)   (1UL << (nr))
>                            ^~
>    drivers//perf/arm_smmuv3_pmu.c:155:31: note: in expansion of macro 'BIT'
>      if (smmu_pmu->counter_mask & BIT(32))
>                                   ^~~
>    drivers//perf/arm_smmuv3_pmu.c:156:11: error: implicit declaration of
> function 'readq'; did you mean 'readl'? [-Werror=implicit-function-declaration]
>       value = readq(smmu_pmu->reloc_base + SMMU_PMCG_EVCNTR(idx, 8));
>               ^~~~~
>               readl

Right. This again is linked to the COMPILE_TEST added in this version of the series.
It looks like these functions has dependency on architecture (CONFIG_64BIT). I will 
take care of this in next revision.

Thanks,
Shameer

>    drivers//perf/arm_smmuv3_pmu.c: In function 'smmu_pmu_reset':
>    drivers//perf/arm_smmuv3_pmu.c:607:2: error: implicit declaration of
> function 'writeq_relaxed'; did you mean 'writel_relaxed'? [-Werror=implicit-
> function-declaration]
>      writeq_relaxed(smmu_pmu->counter_present_mask,
>      ^~~~~~~~~~~~~~
>      writel_relaxed
>    drivers//perf/arm_smmuv3_pmu.c: In function 'smmu_pmu_probe':
> >> drivers//perf/arm_smmuv3_pmu.c:666:15: error: implicit declaration of
> function 'readq_relaxed'; did you mean 'readl_relaxed'? [-Werror=implicit-
> function-declaration]
>      ceid_64[0] = readq_relaxed(smmu_pmu->reg_base +
> SMMU_PMCG_CEID0);
>                   ^~~~~~~~~~~~~
>                   readl_relaxed
>    drivers//perf/arm_smmuv3_pmu.c:687:64: warning: format '%llx' expects
> argument of type 'long long unsigned int', but argument 4 has type
> 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
>      name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "smmuv3_pmcg_%llx",
>                                                                 ~~~^
>                                                                 %x
>    cc1: some warnings being treated as errors
> 
> vim +666 drivers//perf/arm_smmuv3_pmu.c
> 
>    601
>    602	static void smmu_pmu_reset(struct smmu_pmu *smmu_pmu)
>    603	{
>    604		smmu_pmu_disable(&smmu_pmu->pmu);
>    605
>    606		/* Disable counter and interrupt */
>  > 607		writeq_relaxed(smmu_pmu->counter_present_mask,
>    608			       smmu_pmu->reg_base +
> SMMU_PMCG_CNTENCLR0);
>    609		writeq_relaxed(smmu_pmu->counter_present_mask,
>    610			       smmu_pmu->reg_base +
> SMMU_PMCG_INTENCLR0);
>    611		writeq_relaxed(smmu_pmu->counter_present_mask,
>    612			       smmu_pmu->reloc_base +
> SMMU_PMCG_OVSCLR0);
>    613	}
>    614
>    615	static int smmu_pmu_probe(struct platform_device *pdev)
>    616	{
>    617		struct smmu_pmu *smmu_pmu;
>    618		struct resource *res_0, *res_1;
>    619		u32 cfgr, reg_size;
>    620		u64 ceid_64[2];
>    621		int irq, err;
>    622		char *name;
>    623		struct device *dev = &pdev->dev;
>    624
>    625		smmu_pmu = devm_kzalloc(dev, sizeof(*smmu_pmu),
> GFP_KERNEL);
>    626		if (!smmu_pmu)
>    627			return -ENOMEM;
>    628
>    629		smmu_pmu->dev = dev;
>    630		platform_set_drvdata(pdev, smmu_pmu);
>    631
>    632		smmu_pmu->pmu = (struct pmu) {
>    633			.task_ctx_nr    = perf_invalid_context,
>    634			.pmu_enable	= smmu_pmu_enable,
>    635			.pmu_disable	= smmu_pmu_disable,
>    636			.event_init	= smmu_pmu_event_init,
>    637			.add		= smmu_pmu_event_add,
>    638			.del		= smmu_pmu_event_del,
>    639			.start		= smmu_pmu_event_start,
>    640			.stop		= smmu_pmu_event_stop,
>    641			.read		= smmu_pmu_event_read,
>    642			.attr_groups	= smmu_pmu_attr_grps,
>    643		};
>    644
>    645		res_0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>    646		smmu_pmu->reg_base = devm_ioremap_resource(dev, res_0);
>    647		if (IS_ERR(smmu_pmu->reg_base))
>    648			return PTR_ERR(smmu_pmu->reg_base);
>    649
>    650		cfgr = readl_relaxed(smmu_pmu->reg_base +
> SMMU_PMCG_CFGR);
>    651
>    652		/* Determine if page 1 is present */
>    653		if (cfgr & SMMU_PMCG_CFGR_RELOC_CTRS) {
>    654			res_1 = platform_get_resource(pdev,
> IORESOURCE_MEM, 1);
>    655			smmu_pmu->reloc_base =
> devm_ioremap_resource(dev, res_1);
>    656			if (IS_ERR(smmu_pmu->reloc_base))
>    657				return PTR_ERR(smmu_pmu->reloc_base);
>    658		} else {
>    659			smmu_pmu->reloc_base = smmu_pmu->reg_base;
>    660		}
>    661
>    662		irq = platform_get_irq(pdev, 0);
>    663		if (irq > 0)
>    664			smmu_pmu->irq = irq;
>    665
>  > 666		ceid_64[0] = readq_relaxed(smmu_pmu->reg_base +
> SMMU_PMCG_CEID0);
>    667		ceid_64[1] = readq_relaxed(smmu_pmu->reg_base +
> SMMU_PMCG_CEID1);
>    668		bitmap_from_arr32(smmu_pmu->supported_events, (u32
> *)ceid_64,
>    669				  SMMU_ARCH_MAX_EVENTS);
>    670
>    671		smmu_pmu->num_counters =
> FIELD_GET(SMMU_PMCG_CFGR_NCTR_MASK, cfgr) + 1;
>    672		smmu_pmu->counter_present_mask = GENMASK(smmu_pmu-
> >num_counters - 1, 0);
>    673
>    674		smmu_pmu->sid_filter_global = !!(cfgr &
> SMMU_PMCG_CFGR_SID_FILTER_TYPE);
>    675
>    676		reg_size = FIELD_GET(SMMU_PMCG_CFGR_SIZE_MASK, cfgr);
>    677		smmu_pmu->counter_mask = GENMASK_ULL(reg_size, 0);
>    678
>    679		smmu_pmu_reset(smmu_pmu);
>    680
>    681		err = smmu_pmu_setup_irq(smmu_pmu);
>    682		if (err) {
>    683			dev_err(dev, "Setup irq failed, PMU @%pa\n", &res_0-
> >start);
>    684			return err;
>    685		}
>    686
>    687		name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> "smmuv3_pmcg_%llx",
>    688				      (res_0->start) >> SMMU_PA_SHIFT);
>    689		if (!name) {
>    690			dev_err(dev, "Create name failed, PMU @%pa\n",
> &res_0->start);
>    691			return -EINVAL;
>    692		}
>    693
>    694		/* Pick one CPU to be the preferred one to use */
>    695		smmu_pmu->on_cpu = get_cpu();
>    696		WARN_ON(irq_set_affinity(smmu_pmu->irq,
> cpumask_of(smmu_pmu->on_cpu)));
>    697
>    698		err = cpuhp_state_add_instance_nocalls(cpuhp_state_num,
>    699						       &smmu_pmu->node);
>    700		if (err) {
>    701			dev_err(dev, "Error %d registering hotplug, PMU
> @%pa\n",
>    702				err, &res_0->start);
>    703			goto out_cpuhp_err;
>    704		}
>    705
>    706		err = perf_pmu_register(&smmu_pmu->pmu, name, -1);
>    707		if (err) {
>    708			dev_err(dev, "Error %d registering PMU @%pa\n",
>    709				err, &res_0->start);
>    710			goto out_unregister;
>    711		}
>    712
>    713		put_cpu();
>    714		dev_info(dev, "Registered PMU @ %pa using %d counters with
> %s filter settings\n",
>    715			 &res_0->start, smmu_pmu->num_counters,
>    716			 smmu_pmu->sid_filter_global ? "Global(Counter0)" :
>    717			 "Individual");
>    718
>    719		return 0;
>    720
>    721	out_unregister:
>    722		cpuhp_state_remove_instance_nocalls(cpuhp_state_num,
> &smmu_pmu->node);
>    723	out_cpuhp_err:
>    724		put_cpu();
>    725		return err;
>    726	}
>    727
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
