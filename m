Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28390C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC54723ED7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC54723ED7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933109AbeGFM5n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:57:43 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:54721 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932569AbeGFM5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:57:41 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MNvNj-1fU1NF0t59-007ULg; Fri, 06 Jul 2018 14:57:34 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Channagoud Kadabi <ckadabi@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom/llcc: add MODULE_LICENSE tag
Date:   Fri,  6 Jul 2018 14:57:19 +0200
Message-Id: <20180706125732.3556371-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:C/uXRRQ2sC70BKUplar3EqKO5QdVY8NNoLp9QdYcC52pABcrWjP
 mivAi37hCrUkzsp8Jz2ZHI5NxMQ7YPpVUTghwSwFGPy8wZ+/O5Ay56H+jbw7W1Cv2Hxk/8G
 nJH+mIKpserbyQOJVfpYTrEdiZ9kGvkyAH6GvMhrkUJAxkQU2mqPlF/WWaCIUdYiWU76j02
 Z7fnB8t8iFwprtF5YSxdw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UaeeyvJN9kM=:j+7H2xGmuo+xVR80Xhx3uH
 LAC7mp2WbfTT1gcggSraSISINvpuDTJh5bcILSkdK/y/gzyU4eHeTsdx3DWBv/BmNN0XH4dza
 NFnJXAuATQXCcObE8x8qWjFJ0V6XXoATyw1h7MRRRuLwlwHC6Bqk6OwbVzxFavL+r8djtusT3
 /hb55Pr3TgZOmqf9YNl1br27ivTYepHXQjd8McHQvAKW3kTO2ceOEynQGhOf5sdMOMZlRwHxH
 7cxfDv4qMtStp6xBpHnog9uRXnkhmAfaUWUJkTikWXqMaDlU3NXiL0duRCkQAclohXxoSSOEU
 AmmtSbosKmdZw6N2nD8ITos8HgVk282o2do164l/6mWZtWASmvYQZFy8g8m1AKdYKHVBNiYw8
 IbmEN9OUVyl2/drsqkw3zLby9xx+6qAhdesA7Yoo2qDR1j/fVD1xIb2g0hudtiUfyr9KaFLz8
 nv498EQOWIVaXeYd4slCKsXVbtqw9hhwkICXzz1F3bJadUvMTwkL21/NMLn3ADW2jA687Cy80
 LMHFvvC1xWglWZmp2DqucsKtQ9cqJBJHaRdlxwfKGdjCkB7szCEeLKzSjIcD8THN3O39DbS0S
 +zZmrhdfMfbRzYVqz2juC+o5J9OF2TCeU0cxSqbMB2QknynBlb3ZCbVTTzWLVOrqyeZ7pe+AD
 nYbC/fWwdzG4rwiT33dBSCgn5LOAp6wSjkQ097FZ2GQHf3A8mrrET6tFsch/eMtVxz7w=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lack of a MODULE_LICENSE tag prevents building the llcc driver
as a loadable module:

FATAL: modpost: GPL-incompatible module llcc-slice.ko uses GPL-only symbol 'ktime_get'

This adds the appropriate license and description tags.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/qcom/llcc-slice.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/qcom/llcc-slice.c b/drivers/soc/qcom/llcc-slice.c
index fcaad1a4b41d..fea6b33dd416 100644
--- a/drivers/soc/qcom/llcc-slice.c
+++ b/drivers/soc/qcom/llcc-slice.c
@@ -14,6 +14,7 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/llcc-qcom.h>
+#include <linux/module.h>
 
 #define ACTIVATE                      BIT(0)
 #define DEACTIVATE                    BIT(1)
@@ -333,3 +334,6 @@ int qcom_llcc_probe(struct platform_device *pdev,
 	return qcom_llcc_cfg_program(pdev);
 }
 EXPORT_SYMBOL_GPL(qcom_llcc_probe);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Qualcomm Last Level Cache Controller");
-- 
2.9.0

