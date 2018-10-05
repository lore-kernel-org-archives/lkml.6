Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B9CC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC32208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC32208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbeJEXOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:14:30 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:42503 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729411AbeJEXO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:14:29 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MbRXd-1fb2fx0XOr-00brf5; Fri, 05 Oct 2018 18:14:40 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MbRXd-1fb2fx0XOr-00brf5; Fri, 05 Oct 2018 18:14:40 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] interconnect: fix build error without DEBUGFS
Date:   Fri,  5 Oct 2018 18:14:26 +0200
Message-Id: <20181005161438.801080-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:YBbGiWIos3Qkal0N8dsXLSd4RJGj/gmFlevjCqFkyIsxRuDqRUt
 mdX9u5Bt/cN/OWajMV7eR91MoDWrYjQWz1/eCH1Qoao5wr30v63kLz6AJkMq8Q8wZ+/Mb8c
 MeBE55I0KUTsPpXegbfP/7bFhJYWPuy/2J1SXeRJuKOyK4Cjun3z3CU8fOzquiPRkSblMAI
 t5WxbJ5WWcWz2jWnxj5aw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zI71+X+cPt8=:aHU1nGMZIW4TmaKqc0Gzo1
 qU0M0LOC4I7ikOfJUp8Xw81IbNKAJJ0Uf7L6snI3C+/VG69NnfHHqXToyrU766O7A2wXcTryg
 kV938AJBnKFMRPSn2+Lqv7lXwZY8o5qEqFBJzAmrXZSjWNmm9wfJywzUyZ4Lij/k1QBz4QeOV
 uwdgfzZsFhrpq7ZaQP+b/UpIuOBfq5f5csS8DBmT9STKT6kJ04F8CwxZArRwn7SRIOIBygjPN
 aeLtlxSKmt0H4H95UI44k7N36gttiOimKBMAUvuBGeNuRMgEZB+/W/FF2QX9mVfSE9PJoBpwh
 /t3ALqkA7MS6aByXqAycRrWXFmHpb7DCD/QDbwkHPrGtgtdQk6VLmfSH1ZYEJm1TPvxjugheW
 d0D8hMqKP26Fiwv+BMWcKw2ORCewP5C36ceLay6q9GSeOnfbmOiveLiPYB7ujaifHqcJHNPJz
 s81hyzBdT5mQvbIu1pdWbfB1qDeCaydpofbU1y5qkmlortECV1Gz91mSL+mykhPGH33OcBCgq
 LP9LJSrYccFOE6A7AIiABQZoHDnrdKU8jXaRbPzwzormleodF2U4mnXUOpyLXmd22iOqHCk8G
 uzd/Agn1wtUzqvbErJ5T6JX0hZQ1z5y4dc359nFGsjcC8FTyBQcMzvgG4i7EqXUDHPOp97HGG
 igCPefJHkBpmKNBxGdvn+4ar9uckeK5cuo6zuLYxdJY+XRZp32XCelT2Cz22i+Qric0Q=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous fix was incorrect, and now we get a build failure
without CONFIG_DEBUG_FS:

drivers/interconnect/core.c: In function 'icc_init':
drivers/interconnect/core.c:710:32: error: 'icc_summary_fops' undeclared (first use in this function)

Removing the last #ifdef as well makes it all work as intended.

Fixes: 8f023d0cb757 ("interconnect: core: Fix unused variable compiler warning")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I had sent a different fix earlier, but that was done fore the
8f023d0cb757 commit got applied and conflicted with it, so this
new version should go on top.
---
 drivers/interconnect/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index ba48aa83a4ac..aac7bdd6c659 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -52,8 +52,6 @@ struct icc_path {
 	struct icc_req reqs[];
 };
 
-#ifdef CONFIG_DEBUG_FS
-
 static void icc_summary_show_one(struct seq_file *s, struct icc_node *n)
 {
 	if (!n)
@@ -106,7 +104,6 @@ static const struct file_operations icc_summary_fops = {
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
-#endif
 
 static struct icc_node *node_find(const int id)
 {
-- 
2.18.0

