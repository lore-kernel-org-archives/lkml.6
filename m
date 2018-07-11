Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03A8C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9958D2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9958D2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733191AbeGKM6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:58:13 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:47673 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733079AbeGKM6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:58:12 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MNN9N-1fjX5A0QJN-006zWd; Wed, 11 Jul 2018 14:53:41 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        Breno Leitao <leitao@debian.org>,
        Mathieu Malaterre <malat@debian.org>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] powerpc: xmon: use ktime_get_coarse_boottime64
Date:   Wed, 11 Jul 2018 14:53:23 +0200
Message-Id: <20180711125338.1365368-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:aQmqlEfX5gIb1xrvZhQLQ0kVYizyBD6g1rPrRJQGIegtv5mX8qX
 2XlRYslK4bPnVwQw9gwVkflX6ejx9S0zqd+x4VnWQFfUuaeZeJv7EN1e5Ar1sCBj9OzqbnN
 26rHYxxye48yb3fWpztsLVIf0rkR4fRsOR5GFVXVLcr6SEJmehw5iH9DmYcbrOvrjsW+S6q
 gakmuVFAEhU3jbZpJnIjw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fASEmwXl75Q=:XMHBxE8Q8exiBAlxqis/iI
 FG/Qgmnp/Csi47C8hg1mtEvU0c2vlw7E/3xqBFvtdcg4Mafas7u/vkiNzh+WB1sd8aivfYWDC
 1kTLRFkdAQeIGUO2Wqiw98tyOedJ3aVTGeccnmWY4E/a6oaf3PKAN5GxQoJopApelYNKXwKVf
 Eerd/ElitppYypSy5PvSy04Zs+p8wibB9Sn3LjgPZMiEpl5SX3doo0O5T1DwU0ebJT6ntcTR2
 MxPeFfkT9lVyFPVEkwQ/rmoT7kmV1TfR26GhPdpsxmkSI0l8jjOO+B2Qir9eJxBygKLCMoiUp
 F1uYy4bzXb9DuQymYitKsNjLyGueBllBa/axXaTBZ5HEcqmiThlbus7Z8R5mfMh9NvPiOpK7h
 ZZRBkBoVSlVVBkDD+UWBMh5lnx0GeMZFkWzg/pQN+Hw72k0QruWSkJ3nnWJGOLSMthtDHpgI6
 wem1+E+vnx0zjHE+vfGKlV0zAcxag23W6/7Jg5nhp2K7QcR5qYltWhNZ9ixUkIccY33+Jrvvh
 n3NBjLLSxBo0eRFQNXt4Y0Am+ZF216+gIgdb8kRJ7jhYecMk7dR4F6zbpfsdXwMOvAPX0cpTr
 0Lx0XkelIn0YByWW4b7CWH6DaDotaQ24FVz6QndrJfRfVBj30ag6ie3BcLjn+ZTn9GHA6Y9Ze
 OVlFHcymKXBbHhhDLSOwM7OqQP4pGXudpcHqMjvFl8pP/oim+2r8roD0lDnpKsvmmvFo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_monotonic_boottime() is deprecated, and may not be safe to call in
every context, as it has to read a hardware clocksource.

This changes xmon to print the time using ktime_get_coarse_boottime64()
instead, which avoids the old timespec type and the HW access.

Acked-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Originally sent Jun 18, but this hasn't appeared in linux-next yet.

Resending to make sure this is still on the radar. Please apply
to the powerpc git for 4.19
---
 arch/powerpc/xmon/xmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 47166ad2a669..45e3d0ec1246 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -918,13 +918,13 @@ static void remove_cpu_bpts(void)
 static void
 show_uptime(void)
 {
-	struct timespec uptime;
+	struct timespec64 uptime;
 
 	if (setjmp(bus_error_jmp) == 0) {
 		catch_memory_errors = 1;
 		sync();
 
-		get_monotonic_boottime(&uptime);
+		ktime_get_coarse_boottime_ts64(&uptime);
 		printf("Uptime: %lu.%.2lu seconds\n", (unsigned long)uptime.tv_sec,
 			((unsigned long)uptime.tv_nsec / (NSEC_PER_SEC/100)));
 
-- 
2.9.0

