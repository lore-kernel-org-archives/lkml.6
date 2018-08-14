Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728C2C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A99821742
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A99821742
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732637AbeHNPtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:49:06 -0400
Received: from mout.perfora.net ([74.208.4.197]:36461 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731882AbeHNPtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:49:06 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M1pkK-1g8bwi0Dhi-00tmKq; Tue, 14 Aug 2018 15:01:58 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [RESEND PATCH] mfd: stmpe: honor gpio interrupt probe deferral
Date:   Tue, 14 Aug 2018 15:01:54 +0200
Message-Id: <20180814130155.29973-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:5KhEqUK1zHZprMCsSUftmPIUE9YfDMc1sXlu/R/MmDyC1eMhdxh
 dHlrsS9gimmB73J8FSf+HNLqOr+z3CObAC0984SowB5YisMbwyY3yyDtEES/sCb5+EEXThZ
 PlrLIXhS2Ewet3NQ9kn3yeJX4C63FzBTL55+h85HPETmiQlZW+lkSY/Qv2yckTRtTZnOhCT
 ZfA54Pu3t6S+ofk+fsu0g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EoxYi9syyg0=:Y+atF18TxvuqtYrSIMKKw6
 BoPXgv3fvkg/nBt/vLfWxNvUlZbhH/FFag4bHXDVjNepsLfXSIpVI028f5sIOo4cTA8KakHw1
 sKx7QwcXshXWZCtIhBjLOVsINwuCssgIvTRGK4MKohhA7pBGUd39jqW9mvC9mFITN9/1Lc93t
 1DxE8xKgW0bojOUJwBNtpnwTuxfwqHfC7ng9dA7G8Lvgx/8Q1qHRlPs3b9pvjsTDGR4zqQpvC
 A4ArLzbU2hSeYImxSPtIPTdQrIuaOyhdvsihqHvLETESrfoAYJDATwpTiFnqO5eTG9/tgKv0v
 WWqUyJ7ahhru0o2G/oa1BLxyO/XdTu+NPUFSadvawUZpHnDHxH5zm5H2LS1NKmgpaAkWF93pe
 scHtVnIzn1xM77dOR0Hcm9RuK7gGyHATZ8KkXqvQjhspD4aEIMabAdhcSCLnXamj7N26K5ZsB
 qtVMe+kiYVQ6oJW2JZTAgeFrvfDvrm5+3MK9vlT7UkN2P7Xk7j6dHH4l2CKtkeTYKZ8NCj0K/
 4z8wIRUZ82vG5G72z8qabYiF7LxXqmGTNGz8dQ7c0xjZH0sKXpeM00pQC0rA4fhlLQE/KQatW
 ZIL/RsYMe4LAaYghF0ALo+LfcirYxYcooLGx9pRfh9ncPO0voCtC+FqLVO7MiWiSkkG+KkUPw
 +P/iTNi53gp+EEQGfwmARrb6EHKDL0ulFx0/54UQ9LyFBNG1wvCVTfn0GLYvOUZR3c+g=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Actually honor probe deferral in trying to get the GPIO interrupt as
of_get_named_gpio_flags() in stmpe_of_probe() may as well just do so.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 drivers/mfd/stmpe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index 566caca4efd8..4d6ffd3ef398 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -1331,6 +1331,8 @@ int stmpe_probe(struct stmpe_client_info *ci, enum stmpe_partnum partnum)
 		return -ENOMEM;
 
 	stmpe_of_probe(pdata, np);
+	if (-EPROBE_DEFER == pdata->irq_gpio)
+		return -EPROBE_DEFER;
 
 	if (of_find_property(np, "interrupts", NULL) == NULL)
 		ci->irq = -1;
-- 
2.14.4

