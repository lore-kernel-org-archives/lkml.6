Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FA6C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 03:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA9E20856
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 03:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfBCDr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 22:47:29 -0500
Received: from smtprelay0251.hostedemail.com ([216.40.44.251]:37121 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726552AbfBCDr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 22:47:28 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 57EB01801EDC6;
        Sun,  3 Feb 2019 03:47:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: town61_5e18a3e739414
X-Filterd-Recvd-Size: 2399
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Sun,  3 Feb 2019 03:47:26 +0000 (UTC)
Message-ID: <bf397da97e7ed127a838126bb6600a82d63f32f9.camel@perches.com>
Subject: [PATCH] netdevice.h: Add __cold to netdev_<level> logging functions
From:   Joe Perches <joe@perches.com>
To:     David Miller <davem@davemloft.net>
Cc:     netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sat, 02 Feb 2019 19:47:25 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add __cold to the netdev_<level> logging functions similar to
the use of __cold in the generic printk function.

Using __cold moves all the netdev_<level> logging functions
out-of-line possibly improving code locality and runtime
performance.

Signed-off-by: Joe Perches <joe@perches.com>
---
 include/linux/netdevice.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 579d132a75ff..b6c6d2fe17b0 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4671,22 +4671,22 @@ static inline const char *netdev_reg_state(const struct net_device *dev)
 	return " (unknown)";
 }
 
-__printf(3, 4)
+__printf(3, 4) __cold
 void netdev_printk(const char *level, const struct net_device *dev,
 		   const char *format, ...);
-__printf(2, 3)
+__printf(2, 3) __cold
 void netdev_emerg(const struct net_device *dev, const char *format, ...);
-__printf(2, 3)
+__printf(2, 3) __cold
 void netdev_alert(const struct net_device *dev, const char *format, ...);
-__printf(2, 3)
+__printf(2, 3) __cold
 void netdev_crit(const struct net_device *dev, const char *format, ...);
-__printf(2, 3)
+__printf(2, 3) __cold
 void netdev_err(const struct net_device *dev, const char *format, ...);
-__printf(2, 3)
+__printf(2, 3) __cold
 void netdev_warn(const struct net_device *dev, const char *format, ...);
-__printf(2, 3)
+__printf(2, 3) __cold
 void netdev_notice(const struct net_device *dev, const char *format, ...);
-__printf(2, 3)
+__printf(2, 3) __cold
 void netdev_info(const struct net_device *dev, const char *format, ...);
 
 #define netdev_level_once(level, dev, fmt, ...)			\


