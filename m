Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A95BC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A1D2190A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q93woXll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfBGPeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:34:14 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43084 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfBGPeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:34:13 -0500
Received: by mail-pl1-f194.google.com with SMTP id gn14so77659plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 07:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lTDvIo5BH2sX/hciZuDMeKwY4O6WdABkEHtqcun6bhQ=;
        b=q93woXll3D8CXokGmxd6G03nsrF5MDS0UCDkrHdNYcTuUvFjK/Qt7WNVaizBqixfv4
         O6jeEKLnP/oszrR9HcWuRBHszHjcpNum6NhOf+C7oNzCARNuGK4+Z32SxzAxvjN8iPoW
         NIXIHoV2nyk1pPFi00fuSL+RsVYMra+fUVFddg2ofw/YPDZZ/mNNHwfH5BbQuwRyNsez
         tCGCHpjHtoa9h6f+bER2ZypQK93frF0uEeiDwWSJshQhKVS7Nw7864b/5rgKR7dozDoG
         F0kb88cwC2nEnM5Yq8gjdcBauuvA2FHl9siPOvOsCgfAB//eiDQAwjj9CO7snXfC27AD
         xGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lTDvIo5BH2sX/hciZuDMeKwY4O6WdABkEHtqcun6bhQ=;
        b=ry+jt+3Yx3KXNoWRTCQXrLdJda2GqtbK7JZq7cMCGPB4tADLwYBZ4levSeGbccJZmt
         nsO8yGZSP/Ueg9jYGBZxvGLgz5FXPhH4iDxUNKzs1a/cpXD/4KuHaFSQwRw+AhReK4/i
         FGbwLlfoe1uxYqBQ5OO83bnhPiEaOsEC++tmk1bSETBlx4Kwstcxd9bXMRMkHaU6TM1q
         7MI1qyx/qJkK5GLkOZ1+LSV2pGMTrGQ6lwhcIHUSCCammimXi/DuMRU6eASToERnAImT
         UtZPN2VrYCHSlascfQrqZbpyWVPauR31d97X8QHv0djXrQSTaCRdWYjpLIz2BCmHeA9N
         lg7A==
X-Gm-Message-State: AHQUAubclJ398kLcy4n8P/yD7aRoScdxx8GMA6gqVuf/QbgLPbmlRIPo
        GR3O7wzXHNgVQHsXpFFMksM=
X-Google-Smtp-Source: AHgI3IYv0mMewznr/zJVaS1cIlwPG7Zw1ShmPRZGIE/xYMuyEVZVEush6ItSmr9zwEdjirsHS4pbTA==
X-Received: by 2002:a17:902:3283:: with SMTP id z3mr17254137plb.76.1549553653161;
        Thu, 07 Feb 2019 07:34:13 -0800 (PST)
Received: from tianyukernel.corp.microsoft.com ([167.220.255.93])
        by smtp.googlemail.com with ESMTPSA id j6sm16493945pfg.126.2019.02.07.07.34.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Feb 2019 07:34:12 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, joro@8bytes.org, mchehab+samsung@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        iommu@lists.linux-foundation.org, michael.h.kelley@microsoft.com,
        vkuznets@redhat.com, alex.williamson@redhat.com,
        dan.carpenter@oracle.com
Subject: [PATCH V3 1/3] x86/Hyper-V: Set x2apic destination mode to physical when x2apic is available
Date:   Thu,  7 Feb 2019 23:33:47 +0800
Message-Id: <1549553629-8414-2-git-send-email-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549553629-8414-1-git-send-email-Tianyu.Lan@microsoft.com>
References: <1549553629-8414-1-git-send-email-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
set x2apic destination mode to physcial mode when x2apic is available
and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs have
8-bit APIC id.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v2:
       - Fix compile error due to x2apic_phys
       - Fix comment indent
Change since v1:
       - Remove redundant extern for x2apic_phys
---
 arch/x86/kernel/cpu/mshyperv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e81a2db..0c29e4e 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -328,6 +328,16 @@ static void __init ms_hyperv_init_platform(void)
 # ifdef CONFIG_SMP
 	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
 # endif
+
+	/*
+	 * Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
+	 * set x2apic destination mode to physcial mode when x2apic is available
+	 * and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs
+	 * have 8-bit APIC id.
+	 */
+	if (IS_ENABLED(CONFIG_X86_X2APIC) && x2apic_supported())
+		x2apic_phys = 1;
+
 #endif
 }
 
-- 
2.7.4

