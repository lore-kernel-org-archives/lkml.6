Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8822C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C72216F8
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C72216F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932942AbeGFMhQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:37:16 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:49715 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932648AbeGFMhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:37:15 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MWKkb-1fdGZh3Pg1-00XMr5; Fri, 06 Jul 2018 14:36:52 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Santosh Shilimkar <ssantosh@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Keerthy <j-keerthy@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] soc: ti: wkup_m3_ipc: mark PM functions as __maybe_unused
Date:   Fri,  6 Jul 2018 14:36:42 +0200
Message-Id: <20180706123651.2792927-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:XO7zxN80Y7OMNqU6s/2rICIJBdA+43v8Yxil0Xoo5s9+UG8hWmU
 9Y11rhkEw4wZJARQ++MjS3cf4EigmAPokXZ+1RLOCX6wIBzWuvfChRgnYOKJMFGfoMIwfj+
 Lhjggt+0FAOY965KfWShOUZ2fWOr94CZhQij2aR+o4zbL9pZKcQ3WL+13T/abBh6C/fZyzQ
 +ivtTuDQBGJt2r9n05L+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7UGE06OWmNA=:Xist6ZLdGTs/5o/003lSW8
 7hx4zsNftk8DpSTJ7NHlgYl9I5K7tPbN05m+E702dF5JuVI4hvyWi5WvnOGF6IEx/QElAAZtU
 MFXI/aLIPJ1t3XJsPyLkLNeYrWV8j/52ZABVcTPaLf3Z01a/vI44xFX8Qo2rbWJBbR24W2Ifq
 h/NEPNTg3kWIzW24SIDayCCs2k8YuQpzKMwyskBnZ5y9dNQj7uYUB9rDEvdKKfixzQBP+WoXx
 cTZF/0mXvUipCL282aHMKu8DvxpM/tpWofTRW8HBX3Au4yA37PdrHRl5L3UgORzsi0thCtxDT
 bb4QeYynjBjLbjzNZ+Tbs7WZvEgUtic2BH3Tuj9UciHzOLaE+wRWc6ohB8afJyuIqaJIr0XvS
 yXrrSPs4xXvTb4r8FvGCuxdckSoJ+hbIo2E1+eKw3VmtPANRjEi1GLQEihxjgd2lQATph4BKk
 6pp+c1uSEMGmVisQwSUOxTFIqCd0lply69BuXYZU2k7+RXj+ChWNadpw8mh5JwR8ODRR4xRu3
 zmtTBGqrHZl67bQWtAXVjiHM093OFSPwRHYmv+BX8ZL7DTxT4zD8V0WmvH1QWD7e9C1TxMwIH
 CO++BfO95KhXKkAeE3zpnGA2MzuVpWgYwTd9HToA4HMPtAqgthVDnYdbIKOQ9KHcJE51Lqy1B
 0g2xgRlMH2UbQyv5DCzcK/84GK14jS8UZv747t7KsQKctsc759TMdPeh3FT4mcJGg3Js=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone gets these #ifdefs wrong, leading to another warning here:

drivers/soc/ti/wkup_m3_ipc.c:547:12: error: 'wkup_m3_ipc_resume' defined but not used [-Werror=unused-function]
 static int wkup_m3_ipc_resume(struct device *dev)
drivers/soc/ti/wkup_m3_ipc.c:539:12: error: 'wkup_m3_ipc_suspend' defined but not used [-Werror=unused-function]
 static int wkup_m3_ipc_suspend(struct device *dev)

The easiest way to get it right is to remove all the #ifdefs and
let the compiler drop the unused functions silently after we
mark them as __maybe_unused.

Fixes: 7a872b6fb7fd ("soc: ti: wkup_m3_ipc: Add rtc_only with ddr in self refresh mode support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/ti/wkup_m3_ipc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index 6840688236b9..f5cb8c0af09f 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -535,8 +535,7 @@ static int wkup_m3_ipc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int wkup_m3_ipc_suspend(struct device *dev)
+static int __maybe_unused wkup_m3_ipc_suspend(struct device *dev)
 {
 	/*
 	 * Nothing needs to be done on suspend even with rtc_only flag set
@@ -544,7 +543,7 @@ static int wkup_m3_ipc_suspend(struct device *dev)
 	return 0;
 }
 
-static int wkup_m3_ipc_resume(struct device *dev)
+static int __maybe_unused wkup_m3_ipc_resume(struct device *dev)
 {
 	if (m3_ipc_state->is_rtc_only) {
 		rproc_shutdown(m3_ipc_state->rproc);
@@ -559,7 +558,6 @@ static int wkup_m3_ipc_resume(struct device *dev)
 static const struct dev_pm_ops wkup_m3_ipc_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(wkup_m3_ipc_suspend, wkup_m3_ipc_resume)
 };
-#endif
 
 static const struct of_device_id wkup_m3_ipc_of_match[] = {
 	{ .compatible = "ti,am3352-wkup-m3-ipc", },
@@ -574,9 +572,7 @@ static struct platform_driver wkup_m3_ipc_driver = {
 	.driver = {
 		.name = "wkup_m3_ipc",
 		.of_match_table = wkup_m3_ipc_of_match,
-#ifdef CONFIG_PM
 		.pm = &wkup_m3_ipc_pm_ops,
-#endif
 	},
 };
 
-- 
2.9.0

