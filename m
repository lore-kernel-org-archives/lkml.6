Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADB3C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2583521763
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2583521763
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbeHNMF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:05:58 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:50048 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbeHNMF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:05:58 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0M5CnP-1g5d9o0UxT-00zViv; Tue, 14 Aug 2018 11:19:07 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jiri Kosina <jikos@kernel.org>, x86@kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86: apm: mark proc_apm_show as __maybe_unused
Date:   Tue, 14 Aug 2018 11:18:45 +0200
Message-Id: <20180814091904.2186262-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:TPE3A5+lvBRh6ZNmEst+uvvh7Ewirgg7myx05RLeD8uKaTf/OgZ
 nBhtl5pSOib9WqR/1zTqgQ8DZEOyw3LlBKQv0i6MuDT1taEU0l4K7Dup+NfRy4TD/rbVJCf
 cWbf4POaX6VXZNaeUZwRdV7JWFV7ys7/nFANAIXGCoHLoBHzJxvhoyDCzXFt9hq+Uwb4ugb
 ldO8WcZh+D1mAvCk167vQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mmUeFJAVrhY=:rj6WeoUacqLMlIxtsJ+8e5
 UNMxcX5q1BtUoG+XY4oGhXVp+mihiqyMNj220kr+se0f8qefYb/JpsB2s8woQRuiorTl7V1d0
 RXCOeCUJnetHOWoOItygtkBbF2nse1Ho+yllNVspDpl8FPYvEEccFCMhdpQJqc/6waoxVx1sV
 N9RokeCCs5pb6YoniQgXkTC4UCD9gNwbFGTxYmpzru+g0sjDi+FgwHjUFzHOt+sTJMMcTzuq6
 +sivVR26nclwiISh05pX8OdpI7W4VZIu6AhG6HR3rk2I44ZBVvWtK/4uWflXG0Uxu2jSzxITx
 FVWbU9VGQ1cUc9iNnDwGspDnzOgVSjQJpH+15JRt8rDME7ptpN/ZtV7FXhQF9uNH54usIZZR/
 /ySw+PU7hAwxTPrX+WGxkfOXLhr/2R9bKQ82sgWPwmN8lg5ELGxha+VYx1/w1Eyrgf3EWr43x
 MOt9uP6frAaLeAtSivFTeYCChdNeuwqIklMuJNurQnbim30z0XO0yqkPq6HjudgbvYQbK8Sx+
 r2xSfo/JkXMuZD7K1RBoGaeZnGusBT9RAqmZyPCzP71KGaBZ5ZbmjqGwWZ2ARxgbBxfISja+4
 DQRiTl52MqzmoAD73Gn42tsctsAD0qRKIqk/QqBYmYK7/Z25zf3+UqMpjt7CqtU/znSLsspfp
 7q27duFQcMED3KID1tFUBacWRV6ap/qefPr+Dvgbym2op8QQMsyx/n+16/maNMJJG6aA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new build error appeared with CONFIG_PROC_FS disabled:

arch/x86/kernel/apm_32.c:1643:12: error: 'proc_apm_show' defined but not used [-Werror=unused-function]

This marks the function as __maybe_unused to let the compiler drop
it silently.

Fixes: 3f3942aca6da ("proc: introduce proc_create_single{,_data}")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/kernel/apm_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index ec00d1ff5098..79b5ed518471 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -1640,7 +1640,7 @@ static int do_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static int proc_apm_show(struct seq_file *m, void *v)
+static int __maybe_unused proc_apm_show(struct seq_file *m, void *v)
 {
 	unsigned short	bx;
 	unsigned short	cx;
-- 
2.18.0

