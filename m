Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBC1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB76208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="S8psAK/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB76208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388510AbeKPBUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:20:32 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:58207 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbeKPBUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:20:32 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20181115151214epoutp0273fe3d85d7e7cca1f2537c1f1cc23251~nVOO3D96-2710927109epoutp02g;
        Thu, 15 Nov 2018 15:12:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20181115151214epoutp0273fe3d85d7e7cca1f2537c1f1cc23251~nVOO3D96-2710927109epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542294734;
        bh=fwr7eg+826CJd5XoKqdnGmWJiDrlNkTW8iv/lAOZXKE=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=S8psAK/X4FGv/8c0wTzlGf4zaDiudGAEfrSDGp/ULS5cfFfLH47gxLz2HZWq2v8L1
         9MiXOk+xUMrwruybJiJzfXnpzo71GH16/gzF8IbpAvTEZRXrb9Mj8KOW6ApptElaI9
         yDxi1EXF7kmgaG16QrH+WyLQ801VH/rGp9RJBs70=
Received: from epsmges2p2.samsung.com (unknown [182.195.42.70]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20181115151213epcas2p453f12062298bb318f64cbc352b6791bd~nVONmNbjn0103801038epcas2p4U;
        Thu, 15 Nov 2018 15:12:13 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.0C.04407.CCC8DEB5; Fri, 16 Nov 2018 00:12:12 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20181115151211epcas2p4fdc719d354f2a732f70667ccbd8f1bae~nVOMN5m880889608896epcas2p4f;
        Thu, 15 Nov 2018 15:12:11 +0000 (GMT)
X-AuditID: b6c32a46-7a1ff70000001137-23-5bed8ccc8a07
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 91.28.03702.BCC8DEB5; Fri, 16 Nov
        2018 00:12:11 +0900 (KST)
Received: from AMDC3058.DIGITAL.local ([106.120.53.102]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PI8006WJQ7YQ380@mmp2.samsung.com>; Fri, 16 Nov 2018
        00:12:11 +0900 (KST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 1/9] ARM: EXYNOS: remove secondary startup initialization
 from smp_prepare_cpus
Date:   Thu, 15 Nov 2018 16:11:30 +0100
Message-id: <1542294698-17470-2-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRb0gTcRjH++1uu3M5u6bULw1fDIKUNBsGZ5n0QuSCoojepJQd7pjSpms3
        TQ1USNKWZBmZlIWV9mc5p3PmsjLclkuzmbk0V+vfwGFlEo6UiZnnzXef5/t8H55/OCJ1odF4
        Xr6O0ebTKplIjD62x5EJQzXTWUk+awrpaXMJycW6fozsaDAJyfGAX0jerr8PyFrfT4QcHm7H
        SLNvTEiO9jSKyIbhXgE55ZgHpNHhxcg7XQFsr4RaCNYByvOpnDIbzouozuZyaqb3vYi6aDEA
        atYcewjLFKcqGFVeEaPdnnZCnBuo7MM0HknxV+OSqALcWKsHYTgkkuGM6Z5QD8S4lLAC+NGj
        B3wwB6BJHxSsuiaCoyjHUqIdwLPGct4UBNDcM4JxCRGxC16uMgCOo4g4OL44J+QYIV4isNkN
        OY4kaNjzu29Zx3GU2AJdr3WcLCEo6Fy6jvK9YuFA/5WV0jBiH+x+U4VwvSDhEEHfnDFkSocP
        9B8QniPhD6cF4zkGTho6AF9wDcBfwRaUD0wAtg71h9bZDe3OkdB0EbDavohxE0FCAqvPSXkL
        BSe9f0J3aQRw1G9DL4FNTWCNAWxgNKxaybByjTyRpdVsYb4yMadAbQYrX47PsIJm134bIHAg
        C5cknZ7OkgrpIrZEbQMQR2RRkoyyZUmioEtKGW1BtrZQxbA2EIOjso2SbzE3s6SEktYxJxlG
        w2hXswI8LLoCWJ6+bQ1XRNSmbK6XX231vxpoUVcNPgRJ9vlnO7+/P/IE5vxLPbC+2bGtt7jY
        m54AGPnnhqOyY1sr+46fmkq+1SUsS6Vn2nR/ZxO+CEC86kyt0u1WPE+vfxcVqLF6LU0LY3vU
        67qz7xqdgwcvOHyH08SPXJ2CiY7EF7JMt58tlaFsLr0jHtGy9H/Vfrai4QIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsVy+t9jQd3TPW+jDeZ/l7e4te4cq8XfScfY
        LTbOWM9qcf3Lc1aLhdOWM1r0P37NbHH+/AZ2i02Pr7FaXN41h81ixvl9TBYvj/xgtFh75C67
        xaKtX9gdeD1+/5rE6HHrTr3HplWdbB6bl9R7vN93lc2jb8sqRo/Pm+QC2KO4bFJSczLLUov0
        7RK4Mr60HGQvuMVb8WDtf7YGxtncXYycHBICJhI3f11m6WLk4hASWMco8f54KzOE84tRouf3
        RxaQKjYBK4mJ7asYQWwRAU2J63+/s4IUMQscZZb4PGE7M0hCWCBRYuXGD0ANHBwsAqoS506X
        gIR5BTwkjv+fxQKxTU7i5LHJrCA2p4CnxPaz7WCtQkA1n/+eYZ/AyLOAkWEVo2RqQXFuem6x
        UYFRXmq5XnFibnFpXrpecn7uJkZgSG47rNW/g/HxkvhDjAIcjEo8vAblb6OFWBPLiitzDzFK
        cDArifC61QGFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8/LnH4sUEkhPLEnNTk0tSC2CyTJxcEo1
        MNbH8X7pbmbcvHHB25zpqqyX0p61JH4pYbp5cf5MJs2GDYyrpcIvPGq/71EmJvjqVuCKvx80
        D0Xu/xd2JfR3UwmLgrO1u2OPR/Oc+TNcW2c7brpXobH2/v9V2vX+/CsEjtQrNEoY86fwBdx5
        feGe5CuZWY18XBdehen/2r/ZW1Xy1DJOWS7uQCWW4oxEQy3mouJEALTMJKRFAgAA
X-CMS-MailID: 20181115151211epcas2p4fdc719d354f2a732f70667ccbd8f1bae
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20181115151211epcas2p4fdc719d354f2a732f70667ccbd8f1bae
References: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181115151211epcas2p4fdc719d354f2a732f70667ccbd8f1bae@epcas2p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pankaj Dubey <pankaj.dubey@samsung.com>

We are taking care of setting secondary cpu boot address in
exynos_boot_secondary just before sending ipi to secondary CPUs,
so we can safely remove this setting from smp_prepare_cpus.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/platsmp.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 6a1e682..c39ffd2 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -397,38 +397,12 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
 {
-	int i;
-
 	exynos_sysram_init();
 
 	exynos_set_delayed_reset_assertion(true);
 
 	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9)
 		exynos_scu_enable();
-
-	/*
-	 * Write the address of secondary startup into the
-	 * system-wide flags register. The boot monitor waits
-	 * until it receives a soft interrupt, and then the
-	 * secondary CPU branches to this address.
-	 *
-	 * Try using firmware operation first and fall back to
-	 * boot register if it fails.
-	 */
-	for (i = 1; i < max_cpus; ++i) {
-		unsigned long boot_addr;
-		u32 mpidr;
-		u32 core_id;
-		int ret;
-
-		mpidr = cpu_logical_map(i);
-		core_id = MPIDR_AFFINITY_LEVEL(mpidr, 0);
-		boot_addr = __pa_symbol(exynos4_secondary_startup);
-
-		ret = exynos_set_boot_addr(core_id, boot_addr);
-		if (ret)
-			break;
-	}
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-- 
1.9.1

