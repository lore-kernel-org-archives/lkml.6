Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B862C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DE0240F2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="QF1OGan1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33DE0240F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753849AbeGER4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:56:32 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55892 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753451AbeGERzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=bhrgxEVFKj6TQwBDaJNt9819/R+HTLCKfLNY4s4oVLA=; b=QF1OGan1uvWm
        cxzTfSqems6WGadg/o2ZD7Z2MkO8DyHdFEuZ9gBfKnzWgxDR9m6TstbHuKi6ZdifVPRMvDHDWUVVC
        9hhqfKUo/1GyIUjAufYlbbn1EkseB8ZPVXCkkumngQatC2cH18CskL7yh+r6sMRAEknf7qWrCLNTK
        XuN+M=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fb8Tl-00012K-DP; Thu, 05 Jul 2018 17:55:41 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fb8Tk-00027d-W7; Thu, 05 Jul 2018 18:55:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     pascal paillet <p.paillet@st.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        linux-kernel@vger.kernel.org
Subject: Applied "driver core: Add device_link_remove function" to the regulator tree
In-Reply-To:  <1530800748-7300-2-git-send-email-p.paillet@st.com>
Message-Id: <E1fb8Tk-00027d-W7@debutante>
Date:   Thu, 05 Jul 2018 18:55:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   driver core: Add device_link_remove function

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From d8842211b6f63d3f069df973d137de0a85964965 Mon Sep 17 00:00:00 2001
From: pascal paillet <p.paillet@st.com>
Date: Thu, 5 Jul 2018 14:25:56 +0000
Subject: [PATCH] driver core: Add device_link_remove function

Device_link_remove uses the same arguments than device_link_add. The Goal
is to avoid storing the link pointer.

Signed-off-by: pascal paillet <p.paillet@st.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/core.c    | 30 ++++++++++++++++++++++++++++++
 include/linux/device.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 36622b52e419..3b380b1f2768 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -365,6 +365,36 @@ void device_link_del(struct device_link *link)
 }
 EXPORT_SYMBOL_GPL(device_link_del);
 
+/**
+ * device_link_remove - remove a link between two devices.
+ * @consumer: Consumer end of the link.
+ * @supplier: Supplier end of the link.
+ *
+ * The caller must ensure proper synchronization of this function with runtime
+ * PM.
+ */
+void device_link_remove(void *consumer, struct device *supplier)
+{
+	struct device_link *link;
+
+	if (WARN_ON(consumer == supplier))
+		return;
+
+	device_links_write_lock();
+	device_pm_lock();
+
+	list_for_each_entry(link, &supplier->links.consumers, s_node) {
+		if (link->consumer == consumer) {
+			kref_put(&link->kref, __device_link_del);
+			break;
+		}
+	}
+
+	device_pm_unlock();
+	device_links_write_unlock();
+}
+EXPORT_SYMBOL_GPL(device_link_remove);
+
 static void device_links_missing_supplier(struct device *dev)
 {
 	struct device_link *link;
diff --git a/include/linux/device.h b/include/linux/device.h
index 055a69dbcd18..9c1c3b1d5e11 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1316,6 +1316,7 @@ extern const char *dev_driver_string(const struct device *dev);
 struct device_link *device_link_add(struct device *consumer,
 				    struct device *supplier, u32 flags);
 void device_link_del(struct device_link *link);
+void device_link_remove(void *consumer, struct device *supplier);
 
 #ifdef CONFIG_PRINTK
 
-- 
2.18.0.rc2

