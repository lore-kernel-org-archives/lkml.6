Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80119C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5955C2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfAGSDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:03:44 -0500
Received: from mout.gmx.net ([212.227.15.18]:35455 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfAGSDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:03:43 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lm3H7-1hFM1t2jBp-00ZfnU; Mon, 07
 Jan 2019 19:03:16 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>
Subject: [PATCH] kernel/sys.c: Fix UNAME26 for 5.0
Date:   Mon,  7 Jan 2019 19:03:05 +0100
Message-Id: <20190107180306.16602-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fIChN7/aDKLvZxRBnmZ8CjdCsvqvgJYUhKWLMoMEjCS5TLiIOK0
 YPgOOnV0DKlxU4vKbmMV39NNA0HzX0eFbtjd2pnEVUiT3yq/tFCIhc96mCjWN5cS47So8bZ
 9jfbgM8xv+uDax7gQB7qI8cwQA6Qt4Rz0WOPmYM49jWrVEp3+HxXvfKTBNfXMvMlU/7kMUO
 xuLyVMiEqTlSKgi2oIQcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kFYT2+Mbpbg=:sK+Gfi8qc0EDgPLT9WjeMG
 F4eTNbO3GWtuZWs+RKcosAiE1tkZPJ0LjFf0DVV8UEuyBBDrC73+AAIOzd/q6HLD5D1w0fvOi
 9R4jAmGeTfVikqAvwqRkfQYegxrwColflXeJPmd5dvikSf/s6qqf220Icar/jWh05U27O5SdM
 TkjGk2xjmbuYUM5JeD5+eKky77j7ujvrYb7GJR0PkDEwd5mYXHGuem5LKUxXtU8jiA0/csqZj
 0Ea/WL82t6M2pOu0F+djJP7ZG+l80QXAlp1yW8nL0X2POMSi1c9FmjRMqGHl1Mw7wUSrzN+nP
 gifZY6IukZamFYNrWT3L3FBF58rczrKcz06AC72YN/GBWX6IZcvwXfEx29PD9jim2sGK3HcJ/
 QVW4zNOVgwWZORUnqSZUEyfyijOdJj4wWWzEXoLHgAzi1WwThxW3oEVqW5j6nSre0EulijLi/
 XPri8Ru6BbDoEAx1G30krGosJJpISrdIotfG9JPQN7HQoQ/t407th1oHMX5u2k6he9azSwRqg
 KZL9wU858k8tmoU+AgTSaqhwi8YngyFI3aN3aqvMgFdDc2aYziLrKaQ89azQsXWeEIhJETA9f
 XruJAbidMg0mqhwiZ85uHvGurIcK7+4gaRAiIp4R342/KBiF6jSeetQoLw2tK8HbsNPS8yjw3
 gxwOHVsJadUDOkL3fI21jKDSoEiTc1HXb0CXBRoSoZA0WKFpjmA0eL7uDhXUbFLTFcmF2pDYO
 WuYjuLz9l0+7IrJpUM/NLmxAUIOqGaR5gWVJ7ucLtGD4q8aazWkqluwzrBc896gioVbTXGX13
 F+nGh3nWZMtB1j+Bco4dlAsMCrP7I0L9zKRW73exYT0DZYTj7WNMMfI4LZ1jtyUq/i3nYTtB3
 ghYEDR9QOp2Zi2FLPwXnHPwPNQSsQYF9MO9rWi7ydDsfKGNNt6lXqQjKXJxjB+jKNL5Q4R9ot
 9K+foWBR5jw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UNAME26 is a mechanism to report Linux's version as 2.6.x, for
compatibility with old/broken software. Because of the way it is
implemented, it needs to be adjusted to handle version 5.0.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 kernel/sys.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index a48cbf1414b8..479f4ecdb405 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1208,6 +1208,7 @@ DECLARE_RWSEM(uts_sem);
  * Work around broken programs that cannot handle "Linux 3.0".
  * Instead we map 3.x to 2.6.40+x, so e.g. 3.0 would be 2.6.40
  * And we map 4.x to 2.6.60+x, so 4.0 would be 2.6.60.
+ * We map 5.x to 2.6.81+x, so 5.0 would be 2.6.81.
  */
 static int override_release(char __user *release, size_t len)
 {
@@ -1227,7 +1228,7 @@ static int override_release(char __user *release, size_t len)
 				break;
 			rest++;
 		}
-		v = ((LINUX_VERSION_CODE >> 8) & 0xff) + 60;
+		v = ((LINUX_VERSION_CODE >> 8) & 0xff) + 81;
 		copy = clamp_t(size_t, len, 1, sizeof(buf));
 		copy = scnprintf(buf, copy, "2.6.%u%s", v, rest);
 		ret = copy_to_user(release, buf, copy + 1);
-- 
2.20.1

