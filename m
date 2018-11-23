Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F8BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 01:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE40020672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 01:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE40020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439279AbeKWMGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 07:06:24 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:39687 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733058AbeKWMGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 07:06:24 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 73B9F9B2BDCEA;
        Fri, 23 Nov 2018 09:24:16 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Fri, 23 Nov 2018
 09:24:13 +0800
Subject: Re: [PATCH net-next] ptp: Fix pass zero to ERR_PTR() in
 ptp_clock_register
To:     kbuild test robot <lkp@intel.com>
References: <20181122133202.21908-1-yuehaibing@huawei.com>
 <201811230114.mywyGh81%fengguang.wu@intel.com>
CC:     <kbuild-all@01.org>, <davem@davemloft.net>,
        <richardcochran@gmail.com>, <dmitry.torokhov@gmail.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <bee2cccf-47e8-e26b-3504-c54114ec9141@huawei.com>
Date:   Fri, 23 Nov 2018 09:24:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <201811230114.mywyGh81%fengguang.wu@intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for this, I send a wrong patch.

On 2018/11/23 1:30, kbuild test robot wrote:
> Hi YueHaibing,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on net-next/master]
> 
> url:    https://github.com/0day-ci/linux/commits/YueHaibing/ptp-Fix-pass-zero-to-ERR_PTR-in-ptp_clock_register/20181123-010251
> config: x86_64-randconfig-x017-201846 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/ptp/ptp_clock.c: In function 'ptp_clock_register':
>>> drivers/ptp/ptp_clock.c:269:18: warning: passing argument 1 of 'PTR_ERR' makes pointer from integer without a cast [-Wint-conversion]
>        err = PTR_ERR(-EINVAL);
>                      ^
>    In file included from arch/x86/include/asm/processor.h:32:0,
>                     from arch/x86/include/asm/cpufeature.h:8,
>                     from arch/x86/include/asm/thread_info.h:53,
>                     from include/linux/thread_info.h:38,
>                     from arch/x86/include/asm/preempt.h:7,
>                     from include/linux/preempt.h:81,
>                     from include/linux/radix-tree.h:27,
>                     from include/linux/idr.h:15,
>                     from drivers/ptp/ptp_clock.c:20:
>    include/linux/err.h:29:33: note: expected 'const void *' but argument is of type 'int'
>     static inline long __must_check PTR_ERR(__force const void *ptr)
>                                     ^~~~~~~
>    Cyclomatic Complexity 5 include/linux/compiler.h:__write_once_size
>    Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:fls64
>    Cyclomatic Complexity 1 include/linux/log2.h:__ilog2_u64
>    Cyclomatic Complexity 1 include/linux/list.h:INIT_LIST_HEAD
>    Cyclomatic Complexity 1 include/linux/math64.h:div_u64_rem
>    Cyclomatic Complexity 1 include/asm-generic/getorder.h:__get_order
>    Cyclomatic Complexity 3 include/linux/string.h:memset
>    Cyclomatic Complexity 1 include/linux/err.h:ERR_PTR
>    Cyclomatic Complexity 1 include/linux/err.h:PTR_ERR
>    Cyclomatic Complexity 1 include/linux/spinlock.h:spinlock_check
>    Cyclomatic Complexity 1 include/linux/spinlock.h:spin_unlock_irqrestore
>    Cyclomatic Complexity 1 include/linux/ktime.h:ktime_to_ns
>    Cyclomatic Complexity 1 include/linux/slab.h:kmalloc_type
>    Cyclomatic Complexity 28 include/linux/slab.h:kmalloc_index
>    Cyclomatic Complexity 68 include/linux/slab.h:kmalloc_large
>    Cyclomatic Complexity 4 include/linux/slab.h:kmalloc
>    Cyclomatic Complexity 1 include/linux/slab.h:kzalloc
>    Cyclomatic Complexity 2 drivers/ptp/ptp_private.h:queue_cnt
>    Cyclomatic Complexity 1 drivers/ptp/ptp_clock.c:queue_free
>    Cyclomatic Complexity 2 drivers/ptp/ptp_clock.c:enqueue_external_timestamp
>    Cyclomatic Complexity 1 drivers/ptp/ptp_clock.c:scaled_ppm_to_ppb
>    Cyclomatic Complexity 1 drivers/ptp/ptp_clock.c:ptp_clock_getres
>    Cyclomatic Complexity 1 drivers/ptp/ptp_clock.c:ptp_clock_settime
>    Cyclomatic Complexity 2 drivers/ptp/ptp_clock.c:ptp_clock_gettime
>    Cyclomatic Complexity 1 drivers/ptp/ptp_clock.c:delete_ptp_clock
>    Cyclomatic Complexity 2 drivers/ptp/ptp_clock.c:ptp_aux_kworker
>    Cyclomatic Complexity 2 include/linux/ktime.h:ktime_set
>    Cyclomatic Complexity 1 include/linux/ktime.h:timespec64_to_ktime
>    Cyclomatic Complexity 9 drivers/ptp/ptp_clock.c:ptp_clock_adjtime
>    Cyclomatic Complexity 1 include/linux/err.h:IS_ERR
>    Cyclomatic Complexity 1 include/linux/pps_kernel.h:pps_get_ts
>    Cyclomatic Complexity 1 drivers/ptp/ptp_clock.c:ptp_exit
>    Cyclomatic Complexity 3 drivers/ptp/ptp_clock.c:ptp_init
>    Cyclomatic Complexity 13 drivers/ptp/ptp_clock.c:ptp_clock_register
>    Cyclomatic Complexity 3 drivers/ptp/ptp_clock.c:ptp_clock_unregister
>    Cyclomatic Complexity 4 drivers/ptp/ptp_clock.c:ptp_clock_event
>    Cyclomatic Complexity 1 drivers/ptp/ptp_clock.c:ptp_clock_index
>    Cyclomatic Complexity 5 drivers/ptp/ptp_clock.c:ptp_find_pin
>    Cyclomatic Complexity 1 drivers/ptp/ptp_clock.c:ptp_schedule_worker
> 
> vim +/PTR_ERR +269 drivers/ptp/ptp_clock.c
> 
>    205	
>    206	struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>    207					     struct device *parent)
>    208	{
>    209		struct ptp_clock *ptp;
>    210		int err = 0, index, major = MAJOR(ptp_devt);
>    211	
>    212		if (info->n_alarm > PTP_MAX_ALARMS)
>    213			return ERR_PTR(-EINVAL);
>    214	
>    215		/* Initialize a clock structure. */
>    216		err = -ENOMEM;
>    217		ptp = kzalloc(sizeof(struct ptp_clock), GFP_KERNEL);
>    218		if (ptp == NULL)
>    219			goto no_memory;
>    220	
>    221		index = ida_simple_get(&ptp_clocks_map, 0, MINORMASK + 1, GFP_KERNEL);
>    222		if (index < 0) {
>    223			err = index;
>    224			goto no_slot;
>    225		}
>    226	
>    227		ptp->clock.ops = ptp_clock_ops;
>    228		ptp->clock.release = delete_ptp_clock;
>    229		ptp->info = info;
>    230		ptp->devid = MKDEV(major, index);
>    231		ptp->index = index;
>    232		spin_lock_init(&ptp->tsevq.lock);
>    233		mutex_init(&ptp->tsevq_mux);
>    234		mutex_init(&ptp->pincfg_mux);
>    235		init_waitqueue_head(&ptp->tsev_wq);
>    236	
>    237		if (ptp->info->do_aux_work) {
>    238			kthread_init_delayed_work(&ptp->aux_work, ptp_aux_kworker);
>    239			ptp->kworker = kthread_create_worker(0, "ptp%d", ptp->index);
>    240			if (IS_ERR(ptp->kworker)) {
>    241				err = PTR_ERR(ptp->kworker);
>    242				pr_err("failed to create ptp aux_worker %d\n", err);
>    243				goto kworker_err;
>    244			}
>    245		}
>    246	
>    247		err = ptp_populate_pin_groups(ptp);
>    248		if (err)
>    249			goto no_pin_groups;
>    250	
>    251		/* Create a new device in our class. */
>    252		ptp->dev = device_create_with_groups(ptp_class, parent, ptp->devid,
>    253						     ptp, ptp->pin_attr_groups,
>    254						     "ptp%d", ptp->index);
>    255		if (IS_ERR(ptp->dev)) {
>    256			err = PTR_ERR(ptp->dev);
>    257			goto no_device;
>    258		}
>    259	
>    260		/* Register a new PPS source. */
>    261		if (info->pps) {
>    262			struct pps_source_info pps;
>    263			memset(&pps, 0, sizeof(pps));
>    264			snprintf(pps.name, PPS_MAX_NAME_LEN, "ptp%d", index);
>    265			pps.mode = PTP_PPS_MODE;
>    266			pps.owner = info->owner;
>    267			ptp->pps_source = pps_register_source(&pps, PTP_PPS_DEFAULTS);
>    268			if (!ptp->pps_source) {
>  > 269				err = PTR_ERR(-EINVAL);
>    270				pr_err("failed to register pps source\n");
>    271				goto no_pps;
>    272			}
>    273		}
>    274	
>    275		/* Create a posix clock. */
>    276		err = posix_clock_register(&ptp->clock, ptp->devid);
>    277		if (err) {
>    278			pr_err("failed to create posix clock\n");
>    279			goto no_clock;
>    280		}
>    281	
>    282		return ptp;
>    283	
>    284	no_clock:
>    285		if (ptp->pps_source)
>    286			pps_unregister_source(ptp->pps_source);
>    287	no_pps:
>    288		device_destroy(ptp_class, ptp->devid);
>    289	no_device:
>    290		ptp_cleanup_pin_groups(ptp);
>    291	no_pin_groups:
>    292		if (ptp->kworker)
>    293			kthread_destroy_worker(ptp->kworker);
>    294	kworker_err:
>    295		mutex_destroy(&ptp->tsevq_mux);
>    296		mutex_destroy(&ptp->pincfg_mux);
>    297		ida_simple_remove(&ptp_clocks_map, index);
>    298	no_slot:
>    299		kfree(ptp);
>    300	no_memory:
>    301		return ERR_PTR(err);
>    302	}
>    303	EXPORT_SYMBOL(ptp_clock_register);
>    304	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

