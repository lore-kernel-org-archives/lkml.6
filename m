Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7C8ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF935214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF935214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbeIQS6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:58:51 -0400
Received: from smtp17.cstnet.cn ([159.226.251.17]:58218 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728189AbeIQS6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:58:51 -0400
Received: from pw-vbox.higon.com (unknown [182.150.46.145])
        by APP-09 (Coremail) with SMTP id swCowAD3_5OkrJ9bCrmlCg--.397S2;
        Mon, 17 Sep 2018 21:31:20 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
To:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Pu Wen <puwen@hygon.cn>
Subject: [PATCH v7 08/16] x86/apic: Add Hygon Dhyana support to APIC
Date:   Mon, 17 Sep 2018 21:31:15 +0800
Message-Id: <d429e252efc4e306ac4e9def3779013e034a0cde.1537182523.git.puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1537182523.git.puwen@hygon.cn>
References: <cover.1537182523.git.puwen@hygon.cn>
X-CM-TRANSID: swCowAD3_5OkrJ9bCrmlCg--.397S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF13tFykKFWUAw4UKFW5GFg_yoW8Xw13pr
        WUAF4kJFs0gF93Xas7trZ7WryUZ3ZI9w13Ww45Cry3JFWYvry3Zrs2yw1xC34jqrZ5Cr1r
        ta1kZayYva1UJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6x
        AIw20EY4v20xvaj40_Gr0_Zr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY
        1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JULTmhUUUUU=
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Hygon Dhyana support to the APIC subsystem as it uses modern APIC.
When running on 32 bit mode, bigsmp should be enabled if there are
more than 8 cores online.

Signed-off-by: Pu Wen <puwen@hygon.cn>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/apic/apic.c     | 7 +++++++
 arch/x86/kernel/apic/probe_32.c | 1 +
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 84132ed..ab731ab 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -224,6 +224,11 @@ static int modern_apic(void)
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
 	    boot_cpu_data.x86 >= 0xf)
 		return 1;
+
+	/* Hygon systems use modern APIC */
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		return 1;
+
 	return lapic_get_version() >= 0x14;
 }
 
@@ -1912,6 +1917,8 @@ static int __init detect_init_APIC(void)
 		    (boot_cpu_data.x86 >= 15))
 			break;
 		goto no_apic;
+	case X86_VENDOR_HYGON:
+		break;
 	case X86_VENDOR_INTEL:
 		if (boot_cpu_data.x86 == 6 || boot_cpu_data.x86 == 15 ||
 		    (boot_cpu_data.x86 == 5 && boot_cpu_has(X86_FEATURE_APIC)))
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 02e8acb..47ff297 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -185,6 +185,7 @@ void __init default_setup_apic_routing(void)
 				break;
 			}
 			/* If P4 and above fall through */
+		case X86_VENDOR_HYGON:
 		case X86_VENDOR_AMD:
 			def_to_bigsmp = 1;
 		}
-- 
2.7.4

