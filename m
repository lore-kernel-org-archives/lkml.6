Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FB4C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A1C20851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="R1lcCpmB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A1C20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbeLCOg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:36:56 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33497 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeLCOg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:36:56 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181203143540euoutp01fe4f03636ecf86e2e72f4f43bfd601bb~s2VcMJrD21751617516euoutp01X
        for <linux-kernel@vger.kernel.org>; Mon,  3 Dec 2018 14:35:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181203143540euoutp01fe4f03636ecf86e2e72f4f43bfd601bb~s2VcMJrD21751617516euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543847740;
        bh=F5OMi9qP46OwVAZaxbN7qwwgaJ8XmSBzAVOD5Huj0sM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=R1lcCpmBq72bp9n2IXUijkAOiKpT5m6qXkBwN6mwCDPbqVU9oR15l3fVOGVm3MEyi
         9sV8xY1nRW57JkjXR7HJgHZAe4UyXMXC0/IY1t8v/ds1gsilod/KOSFXQMGJqvh0lG
         m3g94f0JCRvtIj6vvywILWF4AIKU9ZMVZcyropcw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181203143539eucas1p2a68f40cc6bfa418b6f03e646c677a1e0~s2Vbiivfi2896328963eucas1p27;
        Mon,  3 Dec 2018 14:35:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A9.72.04294.B3F350C5; Mon,  3
        Dec 2018 14:35:39 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181203143538eucas1p123757014233b5c57ad6c739a326628dd~s2VaoAuRR0920709207eucas1p13;
        Mon,  3 Dec 2018 14:35:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181203143538eusmtrp1a5a47a22aad975caa7d5eb069b4d038e~s2VaZn1jn1795817958eusmtrp1g;
        Mon,  3 Dec 2018 14:35:38 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-a0-5c053f3bb027
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 41.99.04128.A3F350C5; Mon,  3
        Dec 2018 14:35:38 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181203143537eusmtip16ddeb6aa649c93a4b53658a8bb270d82~s2VZ8OmqD1062410624eusmtip1h;
        Mon,  3 Dec 2018 14:35:37 +0000 (GMT)
Subject: Re: [PATCH 00/13 v2] Regulator ena_gpiod fixups
To:     Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <d6b5f384-51aa-0e99-7e88-a1debcf5eca3@samsung.com>
Date:   Mon, 3 Dec 2018 15:35:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181201154151.14890-1-linus.walleij@linaro.org>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3fOzs7MyXEqPszosqIoyEv1YaKoUcH8EOxTlA1tuYMTb3PH
        a1mtRNOhsa7qcWZlpWhMnG3ZUEEjhwmmZqmVeEkSjKHoqCzJPJ4ufvs/z/N7eP7/l5fEpI1C
        GZmcnkUb0jWpcsILd/Qs9++PiBaqQxdqvBWemle44vbUDKEYLrIhxdfhEoHi1kq9QPHGaSFi
        COX8aJFI+ZwdFyltjaWE8uO7dkJZYVlFyiXbVhUR5xWppVOTc2hDSNQZL53b9kygXz6VZ7Wb
        cSNyHDchkgTqEIyU5pqQmJRSDQg+OU6akNea9iDoW2oR8cUSgtqyaRFHcQvXCi8L+UE9gm93
        xzC+mEcwVV27TvlRCnjSM4447U9lwcNiJ+IgjCpCYDN3YtyAoMLA5DYRnJZQUfDZel/IaZza
        BSx7Rcj5C6DU4Jwt4BFf6K2awTktXsO7Oh+v4xi1DQrt1RivA+H9TK2AuwWUVQR3Wicx3vZR
        GBh5LeC1H8y5nv6JswX6bpbh/EIhgquVrIgvyhDYLW0ET0XAC9fguiOM2gvNzhC+fRicUxMC
        /iF9YNTty5vwgRuOCoxvS6CkWMrTu4F1Wf+d7RoYwsxIzm6Ixm6Iw26Iw/6/ew/hjSiQzmbS
        kmjmQDqdG8xo0pjs9KTgxIw0G1r7QX2/XJ425Fw5240oEsm9JTEJuFoq1OQw+WndCEhM7i/R
        Z661JFpN/jnakJFgyE6lmW4UROLyQMn5TZOnpVSSJotOoWk9bfg7FZBimREpW16qmuwPUlRG
        v4Y9vY8SzZ3tlROtmeW0KuiDri5gYjAEhgSYpblk1Z4cu30ox1270C+LPjirNsZ5mC95CbrK
        pqq3i+HhYx1zjovxsjCH5PpOLebYMZ13Yrmg/HtwDNGqXYzvOPLzQmzNZu9LI3rwOdZurQv9
        YRrdMYlFiuU4o9OE7cMMjOY38iBYmz0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsVy+t/xu7pW9qwxBqv+clh8mXuKxWLqwyds
        FldaNzFafLvSwWQx5c9yJovLu+awObB5vL/Ryu6xc9Zddo9NqzrZPO5c28PmMX3Of0aPz5vk
        Atii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DLe
        btrOVPAzsmLd1gksDYzbfLsYOTkkBEwk+pobWbsYuTiEBJYySux4cIEdIiEjcXJaAyuELSzx
        51oXG0TRW0aJedvPMoEkhAUsJNYcu8sIYosIlEh82L+THaSIWaCVUeLR4xtQHRMZJT5tfwc2
        ik3AUKLrLcgoTg5eATuJZ+sWgsVZBFQkZs1qArNFBWIkplx+zQpRIyhxcuYTFhCbE6j+4L5l
        YHFmAXWJP/MuMUPY8hLNW2dD2eISt57MZ5rAKDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpu
        sZFecWJucWleul5yfu4mRmDkbTv2c8sOxq53wYcYBTgYlXh4HeJZYoRYE8uKK3MPMUpwMCuJ
        8BYUAoV4UxIrq1KL8uOLSnNSiw8xmgI9N5FZSjQ5H5gU8kriDU0NzS0sDc2NzY3NLJTEec8b
        VEYJCaQnlqRmp6YWpBbB9DFxcEo1MHJUJZ6pf5Kxfz3rrLecMhObJn8PYiv43v3Jq3jm3XsC
        j895sHayZ1/m6zV+7dSbmzohiC07bVsVs4V8y+P+Ke8FT6VfdX7/PSGPsbbyr8u76ge2Wowl
        U/yTjO7PWf1bqf1N2fOvL8V2OymmOCrs49hY7qq541TvkdCEL71WC5d+enB8x8retUosxRmJ
        hlrMRcWJAHv8XcnSAgAA
X-CMS-MailID: 20181203143538eucas1p123757014233b5c57ad6c739a326628dd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181201154428epcas4p3a1a5c9c576027b1c56f8dd1510b32187
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181201154428epcas4p3a1a5c9c576027b1c56f8dd1510b32187
References: <CGME20181201154428epcas4p3a1a5c9c576027b1c56f8dd1510b32187@epcas4p3.samsung.com>
        <20181201154151.14890-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 2018-12-01 16:41, Linus Walleij wrote:
> Here is a second iteration of these fixups after thinking
> over Charles Keepax excellent comments on the first series
> of fixes.
>
> To make sure GPIO descriptors are never left dangling
> (as far as I can tell!) I use this stepwise approach:
>
> 1. Fix the regulator_register() in the core to guarantee
>    that after calling this with a valid GPIO descriptor
>    in ena_gpiod it will be gpiod_put() if there is any
>    problem.
>
> 2. Fix up simple descriptor consumers to just gpiod_get()
>    and let the core take over the descriptor. Only handle
>    the errorpath up to this point.
>
> 3. Export gpiod_get_from_of_node() and let max77686
>    obtain a GPIO descriptor from the device tree without
>    any devres make-up in the DT parsing callback.
>
> 4. Invent devm_gpiod_unhinge() that will remove the devres
>    monitoring of a devm_* allocated GPIO descriptor
>    right before handling it over to the regulator core,
>    and use this in the otherwise hairy da9211,
>    s5m8767, tps65090 and s2mps11 drivers.


The idea is good imho, but it looks that there are some missing cases in
the code. Here are some logs from the boards I have access to:


Artik5 evaluation board (arch/arm/boot/dts/exynos3250-artik5-eval.dtb):

s2mps11-pmic s2mps14-regulator: Failed to get control GPIO for 11/LDO12
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1 at drivers/gpio/gpiolib-devres.c:336
s2mps11_pmic_probe+0x1c4/0x49c
Modules linked in:
CPU: 1 PID: 1 Comm: swapper/0 Not tainted
4.20.0-rc5-next-20181203-00020-gf6d64d46ca8c #1156
Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[<c01125fc>] (unwind_backtrace) from [<c010e140>] (show_stack+0x10/0x14)
[<c010e140>] (show_stack) from [<c0a510bc>] (dump_stack+0x98/0xc4)
[<c0a510bc>] (dump_stack) from [<c0127078>] (__warn+0x10c/0x124)
[<c0127078>] (__warn) from [<c01271a4>] (warn_slowpath_null+0x40/0x48)
[<c01271a4>] (warn_slowpath_null) from [<c04e5c94>]
(s2mps11_pmic_probe+0x1c4/0x49c)
[<c04e5c94>] (s2mps11_pmic_probe) from [<c0583e60>]
(platform_drv_probe+0x48/0x9c)
[<c0583e60>] (platform_drv_probe) from [<c0581858>]
(really_probe+0x274/0x400)
[<c0581858>] (really_probe) from [<c0581ba0>]
(driver_probe_device+0x78/0x1b8)
[<c0581ba0>] (driver_probe_device) from [<c0581e08>]
(__driver_attach+0x128/0x144)
[<c0581e08>] (__driver_attach) from [<c057f71c>]
(bus_for_each_dev+0x68/0xb4)
[<c057f71c>] (bus_for_each_dev) from [<c0580a1c>]
(bus_add_driver+0x1a8/0x268)
[<c0580a1c>] (bus_add_driver) from [<c0582e44>] (driver_register+0x78/0x10c)
[<c0582e44>] (driver_register) from [<c0103154>]
(do_one_initcall+0x8c/0x410)
[<c0103154>] (do_one_initcall) from [<c0f0124c>]
(kernel_init_freeable+0x3c8/0x4d0)
[<c0f0124c>] (kernel_init_freeable) from [<c0a6afd4>]
(kernel_init+0x8/0x10c)
random: fast init done
[<c0a6afd4>] (kernel_init) from [<c01010b4>] (ret_from_fork+0x14/0x20)
Exception stack(0xd8cc1fb0 to 0xd8cc1ff8)
1fa0:                                     00000000 00000000 00000000
00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
irq event stamp: 98209
hardirqs last  enabled at (98217): [<c0192e14>] console_unlock+0x4ac/0x698
hardirqs last disabled at (98256): [<c0192a34>] console_unlock+0xcc/0x698
softirqs last  enabled at (98276): [<c0102618>] __do_softirq+0x4f0/0x5e0
softirqs last disabled at (98289): [<c012f2f4>] irq_exit+0x160/0x16c
---[ end trace fed5502b2c7cd57b ]---
Unable to handle kernel paging request at virtual address fffffff0
pgd = (ptrval)
[fffffff0] *pgd=597ce841, *pte=00000000, *ppte=00000000
Internal error: Oops: 27 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W        
4.20.0-rc5-next-20181203-00020-gf6d64d46ca8c #1156
Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
PC is at devm_gpiod_match+0x4/0x18
LR is at devres_remove+0x68/0xb8
...
Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 4000406a  DAC: 00000051
Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
Stack: (0xd8cc1d58 to 0xd8cc2000)
...
[<c04a6f1c>] (devm_gpiod_match) from [<c05854b8>] (devres_remove+0x68/0xb8)
[<c05854b8>] (devres_remove) from [<c0585cdc>] (devres_destroy+0x8/0x24)
[<c0585cdc>] (devres_destroy) from [<c04a74a4>]
(devm_gpiod_unhinge+0x1c/0x38)
[<c04a74a4>] (devm_gpiod_unhinge) from [<c04e5c94>]
(s2mps11_pmic_probe+0x1c4/0x49c)
[<c04e5c94>] (s2mps11_pmic_probe) from [<c0583e60>]
(platform_drv_probe+0x48/0x9c)
[<c0583e60>] (platform_drv_probe) from [<c0581858>]
(really_probe+0x274/0x400)
[<c0581858>] (really_probe) from [<c0581ba0>]
(driver_probe_device+0x78/0x1b8)
[<c0581ba0>] (driver_probe_device) from [<c0581e08>]
(__driver_attach+0x128/0x144)
[<c0581e08>] (__driver_attach) from [<c057f71c>]
(bus_for_each_dev+0x68/0xb4)
[<c057f71c>] (bus_for_each_dev) from [<c0580a1c>]
(bus_add_driver+0x1a8/0x268)
[<c0580a1c>] (bus_add_driver) from [<c0582e44>] (driver_register+0x78/0x10c)
[<c0582e44>] (driver_register) from [<c0103154>]
(do_one_initcall+0x8c/0x410)
[<c0103154>] (do_one_initcall) from [<c0f0124c>]
(kernel_init_freeable+0x3c8/0x4d0)
[<c0f0124c>] (kernel_init_freeable) from [<c0a6afd4>]
(kernel_init+0x8/0x10c)
[<c0a6afd4>] (kernel_init) from [<c01010b4>] (ret_from_fork+0x14/0x20)
Exception stack(0xd8cc1fb0 to 0xd8cc1ff8)
...
---[ end trace fed5502b2c7cd57c ]---


Rinato (arch/arm/boot/dts/exynos3250-rinato.dtb):

s2mps11-pmic s2mps14-regulator: Failed to get control GPIO for 11/LDO12
random: fast init done
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at drivers/gpio/gpiolib-devres.c:336
s2mps11_pmic_probe+0x1c4/0x49c
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted
4.20.0-rc5-next-20181203-00020-gf6d64d46ca8c #1156
Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[<c01125fc>] (unwind_backtrace) from [<c010e140>] (show_stack+0x10/0x14)
[<c010e140>] (show_stack) from [<c0a510bc>] (dump_stack+0x98/0xc4)
[<c0a510bc>] (dump_stack) from [<c0127078>] (__warn+0x10c/0x124)
[<c0127078>] (__warn) from [<c01271a4>] (warn_slowpath_null+0x40/0x48)
[<c01271a4>] (warn_slowpath_null) from [<c04e5c94>]
(s2mps11_pmic_probe+0x1c4/0x49c)
[<c04e5c94>] (s2mps11_pmic_probe) from [<c0583e60>]
(platform_drv_probe+0x48/0x9c)
[<c0583e60>] (platform_drv_probe) from [<c0581858>]
(really_probe+0x274/0x400)
[<c0581858>] (really_probe) from [<c0581ba0>]
(driver_probe_device+0x78/0x1b8)
[<c0581ba0>] (driver_probe_device) from [<c0581e08>]
(__driver_attach+0x128/0x144)
[<c0581e08>] (__driver_attach) from [<c057f71c>]
(bus_for_each_dev+0x68/0xb4)
[<c057f71c>] (bus_for_each_dev) from [<c0580a1c>]
(bus_add_driver+0x1a8/0x268)
[<c0580a1c>] (bus_add_driver) from [<c0582e44>] (driver_register+0x78/0x10c)
[<c0582e44>] (driver_register) from [<c0103154>]
(do_one_initcall+0x8c/0x410)
[<c0103154>] (do_one_initcall) from [<c0f0124c>]
(kernel_init_freeable+0x3c8/0x4d0)
[<c0f0124c>] (kernel_init_freeable) from [<c0a6afd4>]
(kernel_init+0x8/0x10c)
[<c0a6afd4>] (kernel_init) from [<c01010b4>] (ret_from_fork+0x14/0x20)
Exception stack(0xd94c1fb0 to 0xd94c1ff8)
...
irq event stamp: 114729
hardirqs last  enabled at (114747): [<c0192e14>] console_unlock+0x4ac/0x698
hardirqs last disabled at (114764): [<c0192a34>] console_unlock+0xcc/0x698
softirqs last  enabled at (114762): [<c0102618>] __do_softirq+0x4f0/0x5e0
softirqs last disabled at (114781): [<c012f2f4>] irq_exit+0x160/0x16c
---[ end trace 5961f9fa5249019f ]---
Unable to handle kernel paging request at virtual address fffffff0
pgd = (ptrval)
[fffffff0] *pgd=5fece841, *pte=00000000, *ppte=00000000
Internal error: Oops: 27 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W        
4.20.0-rc5-next-20181203-00020-gf6d64d46ca8c #1156
Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
PC is at devm_gpiod_match+0x4/0x18
LR is at devres_remove+0x68/0xb8
...
Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 4000406a  DAC: 00000051
Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
Stack: (0xd94c1d58 to 0xd94c2000)
...
[<c04a6f1c>] (devm_gpiod_match) from [<c05854b8>] (devres_remove+0x68/0xb8)
[<c05854b8>] (devres_remove) from [<c0585cdc>] (devres_destroy+0x8/0x24)
[<c0585cdc>] (devres_destroy) from [<c04a74a4>]
(devm_gpiod_unhinge+0x1c/0x38)
[<c04a74a4>] (devm_gpiod_unhinge) from [<c04e5c94>]
(s2mps11_pmic_probe+0x1c4/0x49c)
[<c04e5c94>] (s2mps11_pmic_probe) from [<c0583e60>]
(platform_drv_probe+0x48/0x9c)
[<c0583e60>] (platform_drv_probe) from [<c0581858>]
(really_probe+0x274/0x400)
[<c0581858>] (really_probe) from [<c0581ba0>]
(driver_probe_device+0x78/0x1b8)
[<c0581ba0>] (driver_probe_device) from [<c0581e08>]
(__driver_attach+0x128/0x144)
[<c0581e08>] (__driver_attach) from [<c057f71c>]
(bus_for_each_dev+0x68/0xb4)
[<c057f71c>] (bus_for_each_dev) from [<c0580a1c>]
(bus_add_driver+0x1a8/0x268)
[<c0580a1c>] (bus_add_driver) from [<c0582e44>] (driver_register+0x78/0x10c)
[<c0582e44>] (driver_register) from [<c0103154>]
(do_one_initcall+0x8c/0x410)
[<c0103154>] (do_one_initcall) from [<c0f0124c>]
(kernel_init_freeable+0x3c8/0x4d0)
[<c0f0124c>] (kernel_init_freeable) from [<c0a6afd4>]
(kernel_init+0x8/0x10c)
[<c0a6afd4>] (kernel_init) from [<c01010b4>] (ret_from_fork+0x14/0x20)
Exception stack(0xd94c1fb0 to 0xd94c1ff8)
...
---[ end trace 5961f9fa524901a0 ]---


Other boards with other variants of s2mps11 or other PMICs works fine.




>
> Linus Walleij (13):
>   regulator: core: Track dangling GPIO descriptors
>   regulator: fixed: Let core handle GPIO descriptor
>   regulator: lm363x: Let core handle GPIO descriptor
>   regulator: lp8788-ldo: Let core handle GPIO descriptor
>   regulator: max8952: Let core handle GPIO descriptor
>   regulator: max8973: Let core handle GPIO descriptor
>   gpio: Export gpiod_get_from_of_node()
>   regulator: max77686: Let core handle GPIO descriptor
>   gpio: Add devm_gpiod_unhinge()
>   regulator: da9211: Hand over GPIO to regulator core
>   regulator: s5m8767: Hand over GPIO to regulator core
>   regulator: tps65090: Hand over GPIO to regulator core
>   regulator: s2mps11: Hand over GPIO to regulator core
>
>  Documentation/driver-model/devres.txt  |  1 +
>  drivers/gpio/gpiolib-devres.c          | 17 ++++++++
>  drivers/gpio/gpiolib.h                 |  6 ---
>  drivers/regulator/core.c               | 55 +++++++++++++++++++++-----
>  drivers/regulator/da9211-regulator.c   |  6 +++
>  drivers/regulator/fixed.c              |  6 ++-
>  drivers/regulator/lm363x-regulator.c   |  8 +++-
>  drivers/regulator/lp8788-ldo.c         |  8 +++-
>  drivers/regulator/max77686-regulator.c | 14 ++++---
>  drivers/regulator/max8952.c            | 10 +++--
>  drivers/regulator/max8973-regulator.c  | 23 +++++++----
>  drivers/regulator/s2mps11.c            |  7 +++-
>  drivers/regulator/s5m8767.c            |  9 ++++-
>  drivers/regulator/tps65090-regulator.c |  6 +++
>  include/linux/gpio/consumer.h          | 23 +++++++++++
>  15 files changed, 161 insertions(+), 38 deletions(-)
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

