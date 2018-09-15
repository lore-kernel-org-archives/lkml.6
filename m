Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27266ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 06:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9B720881
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 06:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC9B720881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeIOMEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 08:04:46 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41534 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726619AbeIOMEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 08:04:46 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B86D735D5A00A;
        Sat, 15 Sep 2018 14:46:45 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.399.0; Sat, 15 Sep 2018
 14:46:43 +0800
Message-ID: <5B9CAAD2.70501@huawei.com>
Date:   Sat, 15 Sep 2018 14:46:42 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     kbuild test robot <lkp@intel.com>
CC:     <kbuild-all@01.org>, <jason@lakedaemon.net>, <andrew@lunn.ch>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm: common: use match_string() helper to simplify the
 code
References: <1536937519-31611-1-git-send-email-zhongjiang@huawei.com> <201809150710.kyiQ0EXh%fengguang.wu@intel.com>
In-Reply-To: <201809150710.kyiQ0EXh%fengguang.wu@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/15 7:52, kbuild test robot wrote:
> Hi zhong,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on arm-soc/for-next]
> [also build test ERROR on v4.19-rc3 next-20180913]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/zhong-jiang/arm-common-use-match_string-helper-to-simplify-the-code/20180915-035510
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git for-next
> config: arm-multi_v5_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=arm 
>
> All errors (new ones prefixed by >>):
>
>    arch/arm/plat-orion/common.c: In function 'orion_ge00_switch_init':
>>> arch/arm/plat-orion/common.c:487:23: error: passing argument 1 of 'match_string' from incompatible pointer type [-Werror=incompatible-pointer-types]
>      index = match_string(d->port_names, ARRAY_SIZE(d->port_names), "cpu");
>                           ^
>    In file included from include/linux/bitmap.h:9:0,
>                     from include/linux/cpumask.h:12,
>                     from include/linux/rcupdate.h:44,
>                     from include/linux/radix-tree.h:28,
>                     from include/linux/idr.h:15,
>                     from include/linux/kernfs.h:14,
>                     from include/linux/sysfs.h:16,
>                     from include/linux/kobject.h:20,
>                     from include/linux/device.h:16,
>                     from include/linux/platform_device.h:14,
>                     from arch/arm/plat-orion/common.c:13:
>    include/linux/string.h:184:5: note: expected 'const char * const*' but argument is of type 'char **'
>     int match_string(const char * const *array, size_t n, const char *string);
>         ^~~~~~~~~~~~
>    cc1: some warnings being treated as errors
I am sorry for that. :-[    Will repost in v2.

Thanks,
zhong jiang
> vim +/match_string +487 arch/arm/plat-orion/common.c
>
>    479	
>    480	void __init orion_ge00_switch_init(struct dsa_chip_data *d)
>    481	{
>    482		int index;
>    483	
>    484		if (!IS_BUILTIN(CONFIG_PHYLIB))
>    485			return;
>    486	
>  > 487		index = match_string(d->port_names, ARRAY_SIZE(d->port_names), "cpu");
>    488		if (index >= 0)
>    489			d->netdev[index] = &orion_ge00.dev;
>    490	
>    491		orion_ge00_switch_board_info.mdio_addr = d->sw_addr;
>    492		orion_ge00_switch_board_info.platform_data = d;
>    493	
>    494		mdiobus_register_board_info(&orion_ge00_switch_board_info, 1);
>    495	}
>    496	#endif
>    497	
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


