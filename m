Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AD1C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35EC2174E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QFXh6uYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E35EC2174E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbeI1UBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:01:05 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34521 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeI1UBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:01:05 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180928133715euoutp02d0b16f9ec4ace52a4497406138afc506~Yk9ml1kxQ1716017160euoutp02m
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 13:37:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180928133715euoutp02d0b16f9ec4ace52a4497406138afc506~Yk9ml1kxQ1716017160euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538141835;
        bh=FDYGOMSm8FDpz6EcvrEqCjGSbgWUG4C5PTyozgGeWMY=;
        h=To:Cc:From:Subject:Date:References:From;
        b=QFXh6uYwfseKQ3VwNR6aLAercSSs5OJsbIjveXtSItpeeESib2GzfxLh9QVAyUnRa
         uNbXVV80ueVj3iQkMx5y32uYAucO18v/pGyX+B0zsySd4POsC0D/hGiqFuzbDnXy35
         N7LS9pWfW15SupH1lsK5vNaDi5v0wQItnCcjLdcA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180928133714eucas1p112322ce36e7bd1f9c8425c59c1a77eb5~Yk9lxTx7P0435904359eucas1p1Y;
        Fri, 28 Sep 2018 13:37:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6B.D4.04806.A8E2EAB5; Fri, 28
        Sep 2018 14:37:14 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180928133713eucas1p16a15a68b61de9aa3310737f7fd77d20d~Yk9kqY_Ga2124121241eucas1p1b;
        Fri, 28 Sep 2018 13:37:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180928133713eusmtrp26fc4b4ec996c5188ea3013112824a862~Yk9kZU3aM0120601206eusmtrp2n;
        Fri, 28 Sep 2018 13:37:13 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-51-5bae2e8af23e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A5.6A.04284.98E2EAB5; Fri, 28
        Sep 2018 14:37:13 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180928133713eusmtip297c3da43a5ffc532f88889b6058ff17b~Yk9kDNZOC2726027260eusmtip2g;
        Fri, 28 Sep 2018 13:37:12 +0000 (GMT)
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] ARM: SAMSUNG: limit SAMSUNG_PM_DEBUG config option to
 non-Exynos platforms
Date:   Fri, 28 Sep 2018 15:37:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsWy7djPc7pdeuuiDZ4tkLfYOGM9q0X/49fM
        FufPb2C32PT4GqvF5V1z2CxmnN/HZHFo6l5GB3aPy9cuMntsWtXJ5rF5Sb1H35ZVjB6fN8kF
        sEZx2aSk5mSWpRbp2yVwZfy/fZq5YAZnxbrvx5gbGB+zdzFyckgImEhMaHsCZgsJrGCUmLek
        vouRC8j+wihx8O4CRgjnM6PE1Z5XbDAdi79/ZIVILGeUWN/4EKrqPaNEw6W5YLNEBDQlrv/9
        DlbFLPAKKDF7LxNIgk3ASmJi+ypGEFtYIFZi7Zr5zCA2i4CqxK7XW4BsDg5RgQiJ/jPqIGFe
        AUGJkzOfsIDYzALyEtvfzmEGmSkh0M0usWPqNTaIojKJVx37GCHOc5FontLBDGELS7w6vgXq
        URmJ/zvnM0E0T2eUePNrKQuEs55RYs2ZY0wQVdYSh49fZAW5ghnohfW79CHCjhJtmyGOkxDg
        k7jxVhDiID6JSdumQ4V5JTrahCCq1SQ2LNvABrO2a+dKqHM8JCbsOM4KCetYiYstbSwTGBVm
        IXlzFpI3ZyHcsICReRWjeGppcW56arFxXmq5XnFibnFpXrpecn7uJkZgqjn97/jXHYz7/iQd
        YhTgYFTi4U14tCZaiDWxrLgy9xCjBAezkgjvvuq10UK8KYmVValF+fFFpTmpxYcYpTlYlMR5
        +bTSooUE0hNLUrNTUwtSi2CyTBycUg2M0pvXyx3+yuvwTMB3TfqDLT3On5IMWL8c9Zl7eVqz
        0rlz1w4liy6o7DuQM+vYgrPi7RxiwQ9rFzdVMtqUFLaHp07/H8m2/PL8/0umX9596iDrnYIX
        Jf2yRu+2Wb+cd+JuIKew576nvRPPXbimom7B6v1nc5G9ldfLkJN/d3lzzrFvVJPdnzxntxJL
        cUaioRZzUXEiAOyBu1kxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42I5/e/4Pd1OvXXRBoffCVtsnLGe1aL/8Wtm
        i/PnN7BbbHp8jdXi8q45bBYzzu9jsjg0dS+jA7vH5WsXmT02repk89i8pN6jb8sqRo/Pm+QC
        WKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mv7f
        Ps1cMIOzYt33Y8wNjI/Zuxg5OSQETCQWf//I2sXIxSEksJRR4u3UiYxdjBxACRmJ4+vLIGqE
        Jf5c62KDqHnLKNG77gwrSEJEQFPi+t/vYM3MAq8YJfZMPM8IkmATsJKY2L4KzBYWiJVYu2Y+
        M4jNK2AnsWHKGTCbRUBVYtfrLWC2qECExK2HHSwQNYISJ2c+AbOZBdQl/sy7xAxhy0tsfzuH
        eQIj/ywkZbOQlM1CUraAkXkVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYExsO/Zz8w7GSxuD
        DzEKcDAq8fAmPFoTLcSaWFZcmXuIUYKDWUmEd1/12mgh3pTEyqrUovz4otKc1OJDjKZAh09k
        lhJNzgfGa15JvKGpobmFpaG5sbmxmYWSOO95g8ooIYH0xJLU7NTUgtQimD4mDk6pBkbutqAT
        RuafgyYs0G34kTb31A2V7teiJx3OvWs8ILBX4MKqOenChhNPCMx+zaMiXSTOXc2xsHbZ9oZP
        q2Y5KHeIHG4/veElm+LGhU8i4nesUF0f/v3S/3dP5GV/p7I1C/++Yi1W0uwYP7t/zvoptf/O
        WaY7OVmHiC49uk+tPfnXnC01k/bcO5OvxFKckWioxVxUnAgAhSnUtJ8CAAA=
Message-Id: <20180928133713eucas1p16a15a68b61de9aa3310737f7fd77d20d~Yk9kqY_Ga2124121241eucas1p1b@eucas1p1.samsung.com>
X-CMS-MailID: 20180928133713eucas1p16a15a68b61de9aa3310737f7fd77d20d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180928133713eucas1p16a15a68b61de9aa3310737f7fd77d20d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180928133713eucas1p16a15a68b61de9aa3310737f7fd77d20d
References: <CGME20180928133713eucas1p16a15a68b61de9aa3310737f7fd77d20d@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Samsung PM Suspend debug" feature (controlled by SAMSUNG_PM_DEBUG
config option) is not working properly (debug messages are not
displayed after resume) on Exynos platforms because GPIOs restore
code is not implemented.

Add PLAT_S3C24XX, ARCH_S3C64XX and ARCH_S5PV210 dependencies to
SAMSUNG_PM_DEBUG config option to hide it on Exynos platforms.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/plat-samsung/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/arch/arm/plat-samsung/Kconfig
===================================================================
--- a/arch/arm/plat-samsung/Kconfig	2018-09-28 15:20:06.041911426 +0200
+++ b/arch/arm/plat-samsung/Kconfig	2018-09-28 15:20:06.037911426 +0200
@@ -238,7 +238,8 @@ comment "Power management"
 
 config SAMSUNG_PM_DEBUG
 	bool "Samsung PM Suspend debug"
-	depends on PM && DEBUG_KERNEL
+	depends on DEBUG_KERNEL
+	depends on PM && (PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210)
 	depends on DEBUG_EXYNOS_UART || DEBUG_S3C24XX_UART || DEBUG_S3C2410_UART
 	help
 	  Say Y here if you want verbose debugging from the PM Suspend and

