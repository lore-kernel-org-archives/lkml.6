Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C493DC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94289208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94289208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbeJEXPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:15:35 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:42555 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728732AbeJEXPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:15:34 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MG90u-1fwP1z0jdM-00Gb7M; Fri, 05 Oct 2018 18:16:03 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MG90u-1fwP1z0jdM-00Gb7M; Fri, 05 Oct 2018 18:16:03 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: orion: avoid VLA in orion_mpp_conf
Date:   Fri,  5 Oct 2018 18:15:49 +0200
Message-Id: <20181005161601.875388-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:2J/zK62TPNTB0ahRQmIca9GLKOzjXrCwYVcsu0M78+iM1YVeqZm
 P+G/VC7j0rRsgxwlMCBxrxEfO9EUD8IEsh3OvoW+3yo+y70cZwf06CCAObvl3vyduSNMhqd
 5DEsEnlzt0zbrg51JV4UeiXQ5Ibs8t3eLOGePxZz7cLqhWo9coBQ1G8Fe+UaTMPVnGeCCQl
 SKEZnPQ2kT1PD2D9hxB5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3o+SQdWxcm0=:5ef6RnU5lyjEGAk8NZo3WM
 bP3FnN2rI8rfQEeVoFZErI55qMkYymaf/eYwCn0zFeVWxIbkDua3/gbKmtX3fXHJRTb6/ljO0
 7aU0uLIMZpZd9ZyOzUCbvxLm4lNztshc6S9b+6f5NpCP25aKLYxzxhhRvjQybakAHGyqGBYJY
 YgupgikVmDvifYX0+xaP5wFNQjgkSEnf72S1P3Y/tkga7rD6C/D8dx6neD3DZztnYgyoCmCRL
 VQ1+EDJDyul2u10zNuyYPjU+GlyLF5JmgLGxPnyqstk0OtSGR7DYxy33ANWaAWgq38f+erOZY
 8qovbv/sH9KNF/w46U9U24n1EMT3246KITr9aiEvevsSB89iTXWiQcNLjW+UcdApJYy2GL+D/
 5GAVJJx8ZoqSRUZaQwaE94ME7H15M0siwdiQ+9siLBaUm1AI1GMX+40jLyimNcIz18NAoRoe4
 nJbcuvNixo+hpJx4VvyDdM0+0fLmZKsG/Q7jsXxnROpkmVQCV5eXMJXbedQTz3XiEGM5vhWNP
 VlsPDAwNhrUsyH+COjDjpH5Ro1s86xwtiijB0BcFyG+hzm8lecDvpxDFuBHkWs6cZN4UHcCUm
 MoVpb+oyF7k8PhgcxnywuwY+rwTqxjhXpy5hrn5zJyVV2K8n3eWypRJiwFqg3nE4iyCN/lxQY
 kp/a49xGNQ6UD/tnAbcmgjlRpNbY1xQtkJnsBsZZgOXlb9iDONS2v6G+ta5vYI0IlsPE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Testing randconfig builds found an instance of a VLA that was
missed when determining that we have removed them all:

arch/arm/plat-orion/mpp.c: In function 'orion_mpp_conf':
arch/arm/plat-orion/mpp.c:31:2: error: ISO C90 forbids variable length array 'mpp_ctrl' [-Werror=vla]

This one is fairly straightforward: we know what all three
callers are, and the maximum length is not very long.

Fixes: 68664695ae57 ("Makefile: Globally enable VLA warning")
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/plat-orion/mpp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-orion/mpp.c b/arch/arm/plat-orion/mpp.c
index 5b4ff9373c89..8a6880d528b6 100644
--- a/arch/arm/plat-orion/mpp.c
+++ b/arch/arm/plat-orion/mpp.c
@@ -28,10 +28,15 @@ void __init orion_mpp_conf(unsigned int *mpp_list, unsigned int variant_mask,
 			   unsigned int mpp_max, void __iomem *dev_bus)
 {
 	unsigned int mpp_nr_regs = (1 + mpp_max/8);
-	u32 mpp_ctrl[mpp_nr_regs];
+	u32 mpp_ctrl[8];
 	int i;
 
 	printk(KERN_DEBUG "initial MPP regs:");
+	if (mpp_nr_regs > ARRAY_SIZE(mpp_ctrl)) {
+		printk(KERN_ERR "orion_mpp_conf: invalid mpp_max\n");
+		return;
+	}
+
 	for (i = 0; i < mpp_nr_regs; i++) {
 		mpp_ctrl[i] = readl(mpp_ctrl_addr(i, dev_bus));
 		printk(" %08x", mpp_ctrl[i]);
-- 
2.18.0

