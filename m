Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C72C282CC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D672083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9bTmgDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfBDWKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:10:01 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55876 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfBDWJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 17:09:58 -0500
Received: by mail-it1-f195.google.com with SMTP id m62so3681694ith.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 14:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NCVAts3n2tDe0LNoEqLUdjE98FKwB9oUA9NWkCPnm+Y=;
        b=f9bTmgDpBLc8Y7EjYzMx1A1I1lU4U9a7k+jmejalOUYW8w/lWnNjXqbLThbHDoSrq3
         hzwBhWoLj95UxTxG/Hca4Knfdkgi7m+axnMRRKfpFtzRxggvv9IZSAsUJS7pyIqzVnk/
         N3e9wAB7gH2A2UIydSNtmsqVmMnsl7Yc8RLuAtFoYE14LBGrkVg/WU4eDrJCSnAfSQFJ
         2tDx1PZ6DtxG9GHgMRDedzzZgFxg/Pn4iEgznkYUH2QKo7CHiYNaziiIIwl40WeS0DTt
         6HUDxcPJYt4bKpKJkigDflqj6yMbIjmQBbzpebbA+0r5E06RvuQcwo5/pMmKsB6pGrXy
         uZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NCVAts3n2tDe0LNoEqLUdjE98FKwB9oUA9NWkCPnm+Y=;
        b=GbI4cgK3UXEct112xHkoyCJXaKchfCyuyHVHkuJNBXpaDKXgGfx2q+N9bZ8u9PULfL
         Nd6BDd7O4uDjrNSlT/a7kI9v2RyMjiyu1X0BXwJPZ+COJ0fajP2O55B+62Ay5Y3Q1jcU
         1TSo/B70ojl8VoLikyLaAZ7Btk6lIT35NnMzlD+ew5Vu/yK24qrXCSzsHJCZDIdV7zx9
         ncNIpKZasuPdEFwuxusti65eJ0aEjeuCE1Ek5kS3/134FnSGl7B6xnd6QN3pQeSRb9sO
         htVdM33AsEtdG9b8amKqEnUJHv08C9XCNGUeamX6RabMfReWC+MJXz+JSv+Nvrd4ELRx
         q6eg==
X-Gm-Message-State: AHQUAubZIlPA0yaSVoQ75gcJlTG7aGpr3MgfbA1aY60S//UrVUUeT0AR
        /dAmsx+0E0F+i4MYIIuNd2k=
X-Google-Smtp-Source: AHgI3IbcNsCake/rC5M8NrCjHzvy9k2l738Vp/SS49lODzwj/KiA/s2InMN0WNn8F0Sm3CTBa4YmdQ==
X-Received: by 2002:a24:a542:: with SMTP id w2mr827285iti.64.1549318197480;
        Mon, 04 Feb 2019 14:09:57 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id z1sm531602ioi.77.2019.02.04.14.09.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 14:09:56 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@googlemail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: [RFC v1 1/3] workqueue: Add resource-managed version of INIT_[DELAYED_]WORK()
Date:   Mon,  4 Feb 2019 17:09:50 -0500
Message-Id: <20190204220952.30761-2-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190204220952.30761-1-TheSven73@googlemail.com>
References: <20190204220952.30761-1-TheSven73@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In modules which extensively use devm_ resource management, it is often
easy to overlook (delayed) work that is left pending or running after the
module is unloaded. This could introduce user-after-free issues.

Nudge kernel developers into 'doing the right thing' by introducing a
resource-managed version of INIT_[DELAYED_]WORK(). This can be used as
an elegant way to ensure that work is not left pending or running after
its dependencies are released.

Functions introduced in workqueue.h :
- devm_init_work()
- devm_init_delayed_work()

Signed-off-by: Sven Van Asbroeck <TheSven73@googlemail.com>
---
 include/linux/workqueue.h |  7 +++++
 kernel/workqueue.c        | 54 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 60d673e15632..eee148eb9908 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -15,6 +15,7 @@
 #include <linux/cpumask.h>
 #include <linux/rcupdate.h>
 
+struct device;
 struct workqueue_struct;
 
 struct work_struct;
@@ -670,4 +671,10 @@ int workqueue_offline_cpu(unsigned int cpu);
 int __init workqueue_init_early(void);
 int __init workqueue_init(void);
 
+int __must_check devm_init_work(struct device *dev, struct work_struct *work,
+					work_func_t func);
+int __must_check devm_init_delayed_work(struct device *dev,
+					struct delayed_work *dw,
+					work_func_t func);
+
 #endif
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index fc5d23d752a5..ab814b0b6c81 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5837,3 +5837,57 @@ int __init workqueue_init(void)
 
 	return 0;
 }
+
+static void devm_work_release(void *data)
+{
+	struct work_struct *work = data;
+
+	cancel_work_sync(work);
+}
+
+/**
+ * devm_init_work - resource-controlled version of INIT_WORK()
+ * @dev: valid struct device pointer
+ * @work: work pointer to initialize
+ * @func: work function to initialize 'work' with
+ *
+ * Initialize the work pointer just like INIT_WORK(), but use resource control
+ * to help ensure work is not left running or pending when dev is destroyed.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __must_check devm_init_work(struct device *dev, struct work_struct *work,
+					work_func_t func)
+{
+	INIT_WORK(work, func);
+	return devm_add_action(dev, devm_work_release, work);
+}
+EXPORT_SYMBOL_GPL(devm_init_work);
+
+static void devm_delayed_work_release(void *data)
+{
+	struct delayed_work *dw = data;
+
+	cancel_delayed_work_sync(dw);
+}
+
+/**
+ * devm_init_delayed_work - resource-controlled version of INIT_DELAYED_WORK()
+ * @dev: valid struct device pointer
+ * @dw: delayed_work pointer to initialize
+ * @func: work function to initialize 'dw' with
+ *
+ * Initialize the delayed_work pointer just like INIT_DELAYED_WORK(), but use
+ * resource control to help ensure delayed work is not left running or pending
+ * when dev is destroyed.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __must_check devm_init_delayed_work(struct device *dev,
+					struct delayed_work *dw,
+					work_func_t func)
+{
+	INIT_DELAYED_WORK(dw, func);
+	return devm_add_action(dev, devm_delayed_work_release, dw);
+}
+EXPORT_SYMBOL_GPL(devm_init_delayed_work);
-- 
2.17.1

