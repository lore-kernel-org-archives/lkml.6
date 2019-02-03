Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556E4C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 03:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C42A2070B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 03:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfBCDuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 22:50:21 -0500
Received: from smtprelay0099.hostedemail.com ([216.40.44.99]:55582 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726552AbfBCDuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 22:50:20 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 5387E81D5;
        Sun,  3 Feb 2019 03:50:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lace44_77219e0379226
X-Filterd-Recvd-Size: 2495
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Sun,  3 Feb 2019 03:50:18 +0000 (UTC)
Message-ID: <f0737d2d4ba1ccbe0e5054d8dad9bb6385fda91f.camel@perches.com>
Subject: [PATCH] device.h: Add __cold to dev_<level> logging functions
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Sat, 02 Feb 2019 19:50:17 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add __cold to the dev_<level> logging functions similar to
the use of __cold in the generic printk function.

Using __cold moves all the dev_<level> logging functions
out-of-line possibly improving code locality and runtime
performance.

Signed-off-by: Joe Perches <joe@perches.com>
---
 include/linux/device.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 5663003a95eb..df719f7fb5f0 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1381,28 +1381,28 @@ void device_link_remove(void *consumer, struct device *supplier);
 
 #ifdef CONFIG_PRINTK
 
-__printf(3, 0)
+__printf(3, 0) __cold
 int dev_vprintk_emit(int level, const struct device *dev,
 		     const char *fmt, va_list args);
-__printf(3, 4)
+__printf(3, 4) __cold
 int dev_printk_emit(int level, const struct device *dev, const char *fmt, ...);
 
-__printf(3, 4)
+__printf(3, 4) __cold
 void dev_printk(const char *level, const struct device *dev,
 		const char *fmt, ...);
-__printf(2, 3)
+__printf(2, 3) __cold
 void _dev_emerg(const struct device *dev, const char *fmt, ...);
-__printf(2, 3)
+__printf(2, 3) __cold
 void _dev_alert(const struct device *dev, const char *fmt, ...);
-__printf(2, 3)
+__printf(2, 3) __cold
 void _dev_crit(const struct device *dev, const char *fmt, ...);
-__printf(2, 3)
+__printf(2, 3) __cold
 void _dev_err(const struct device *dev, const char *fmt, ...);
-__printf(2, 3)
+__printf(2, 3) __cold
 void _dev_warn(const struct device *dev, const char *fmt, ...);
-__printf(2, 3)
+__printf(2, 3) __cold
 void _dev_notice(const struct device *dev, const char *fmt, ...);
-__printf(2, 3)
+__printf(2, 3) __cold
 void _dev_info(const struct device *dev, const char *fmt, ...);
 
 #else


