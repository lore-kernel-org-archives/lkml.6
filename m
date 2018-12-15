Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F981C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 10:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698BA2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 10:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbeLOKgY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 05:36:24 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32816 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729671AbeLOKgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 05:36:23 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 7550E66C98EF9;
        Sat, 15 Dec 2018 10:36:19 +0000 (GMT)
Received: from FRAEMA702-CHM.china.huawei.com (10.206.14.51) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sat, 15 Dec 2018 10:36:20 +0000
Received: from FRAEML521-MBX.china.huawei.com ([169.254.1.202]) by
 FRAEMA702-CHM.china.huawei.com ([169.254.2.35]) with mapi id 14.03.0415.000;
 Sat, 15 Dec 2018 11:36:11 +0100
From:   Salil Mehta <salil.mehta@huawei.com>
To:     David Miller <davem@davemloft.net>
CC:     "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>,
        "lipeng (Y)" <lipeng321@huawei.com>,
        "mehta.salil@opnsrc.net" <mehta.salil@opnsrc.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH net-next 0/6] net: hns3: Add more commands to Debugfs in
 HNS3 driver
Thread-Topic: [PATCH net-next 0/6] net: hns3: Add more commands to Debugfs
 in HNS3 driver
Thread-Index: AQHUk/yxUCQY1ZH6PECuDb3D6nds5aV+wi6AgADZPJA=
Date:   Sat, 15 Dec 2018 10:36:10 +0000
Message-ID: <F4CC6FACFEB3C54C9141D49AD221F7F93C0A43D4@FRAEML521-MBX.china.huawei.com>
References: <20181211171330.20592-1-salil.mehta@huawei.com>
        <20181214.143046.597375776514311090.davem@davemloft.net>
 <20181214.143631.1081032057703599919.davem@davemloft.net>
In-Reply-To: <20181214.143631.1081032057703599919.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.81.88]
Content-Type: text/plain; charset="iso-8859-7"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: David Miller [mailto:davem@davemloft.net]
> Sent: Friday, December 14, 2018 10:37 PM
> To: Salil Mehta <salil.mehta@huawei.com>
> Cc: Zhuangyuzeng (Yisen) <yisen.zhuang@huawei.com>; lipeng (Y)
> <lipeng321@huawei.com>; mehta.salil@opnsrc.net; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH net-next 0/6] net: hns3: Add more commands to
> Debugfs in HNS3 driver
> 
> From: David Miller <davem@davemloft.net>
> Date: Fri, 14 Dec 2018 14:30:46 -0800 (PST)
> 
> > From: Salil Mehta <salil.mehta@huawei.com>
> > Date: Tue, 11 Dec 2018 17:13:24 +0000
> >
> >> This patch-set adds few more debugfs commands to HNS3 Ethernet
> >> Driver. Support has been added to query info related to below
> >> items:
> >> 1. Packet buffer descriptor ("echo bd info [queue no] [bd index] > cmd")
> >> 2. Manager table("echo dump mng tbl > cmd")
> >> 3. Dfx status register("echo dump reg ssu [prt id] > cmd")
> >> 4. Dcb status register("echo dump reg dcb [port id] > cmd")
> >> 5. Queue map ("echo queue map [queue no] > cmd")
> >> 6. Tm map ("echo tm map [queue no] > cmd")
> >>
> >> NOTE: Above commands are *read-only* and are only intended to
> >> query the information from the SoC(and dump inside the kernel,
> >> for now) and in no way tries to perform write operations for
> >> the purpose of configuration etc.
> >
> > Series applied.
> 
> Actually, reverted.
> 
> Please fix these warnings and resubmit (with gcc version
> "gcc (GCC) 8.2.1 20181105 (Red Hat 8.2.1-5)"):
> 
> In file included from ./include/linux/bitmap.h:9,
>                  from ./include/linux/cpumask.h:12,
>                  from ./arch/x86/include/asm/cpumask.h:5,
>                  from ./arch/x86/include/asm/msr.h:11,
>                  from ./arch/x86/include/asm/processor.h:21,
>                  from ./arch/x86/include/asm/cpufeature.h:8,
>                  from ./arch/x86/include/asm/thread_info.h:53,
>                  from ./include/linux/thread_info.h:38,
>                  from ./arch/x86/include/asm/preempt.h:7,
>                  from ./include/linux/preempt.h:81,
>                  from ./include/linux/spinlock.h:51,
>                  from ./include/linux/wait.h:9,
>                  from ./include/linux/wait_bit.h:8,
>                  from ./include/linux/fs.h:6,
>                  from ./include/linux/debugfs.h:15,
>                  from
> drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c:4:
> In function ¡strncat¢,
>     inlined from ¡hns3_dbg_help¢ at
> drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c:263:2:
> ./include/linux/string.h:320:10: warning: ¡__builtin_strncat¢ specified
> bound 256 equals destination size [-Wstringop-overflow=]
>    return __builtin_strncat(p, q, count);
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In function ¡strncat¢,
>     inlined from ¡hns3_dbg_help¢ at
> drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c:252:2:
> ./include/linux/string.h:320:10: warning: ¡__builtin_strncat¢ specified
> bound 256 equals destination size [-Wstringop-overflow=]
>    return __builtin_strncat(p, q, count);
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from ./include/linux/bitmap.h:9,
>                  from ./include/linux/cpumask.h:12,
>                  from ./arch/x86/include/asm/cpumask.h:5,
>                  from ./arch/x86/include/asm/msr.h:11,
>                  from ./arch/x86/include/asm/processor.h:21,
>                  from ./include/linux/mutex.h:19,
>                  from ./include/linux/kernfs.h:13,
>                  from ./include/linux/sysfs.h:16,
>                  from ./include/linux/kobject.h:20,
>                  from ./include/linux/device.h:16,
>                  from
> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:4:
> In function ¡strncat¢,
>     inlined from ¡hclge_dbg_dump_mng_table¢ at
> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:795:2:
> ./include/linux/string.h:320:10: warning: ¡__builtin_strncat¢ specified
> bound 256 equals destination size [-Wstringop-overflow=]
>    return __builtin_strncat(p, q, count);
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ahh, goodness. Perhaps, I have been using outdated compiler.
I will float the V2 version today after fixing above.

Thanks
Dave
