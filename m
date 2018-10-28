Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15D2C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969112064C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=steffenvogel.de header.i=@steffenvogel.de header.b="dpv0nhlo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969112064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=steffenvogel.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeJ2HF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 03:05:59 -0400
Received: from nag.0l.de ([207.154.252.120]:33454 "EHLO nag.0l.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbeJ2HF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 03:05:58 -0400
From:   Steffen Vogel <post@steffenvogel.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540764601; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wpHckjG4eFJkyhwxZ3FFmBUzBL+hdnq1M27xexV9fjw=;
        b=dpv0nhlo/x95+aP4bMDX+4ke3ZgUxqdeVHg3D3goRcNoOYfkJAKb27VPKp1ytz5iUL1mgU
        1NonLojhP7qiZJtsVCnGol3lclNckHMq+Xdcu/3iYPgEPgA+cKMfQcSsgTyZtqZMVTm/cV
        0gwkNXvUVB4tGYVgpoa++K9dpr/ShIZkrhQjajAleJ3Sk0yTVPB83s35pGP7cZh4rnz/Fu
        yPYEZx2NoS1QiiUEs/wyK2bQBaqpUi14Gm2VvXnXa5KfjlIq73Kp9arYWnSuJCzO0Lq7zA
        cPF0kqlEFWRPd2wN8tOeJiljA9yEfqY1q4qO0DUJxmj/mXaxUcwpNLFB0EBaVw==
To:     linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Steffen Vogel <post@steffenvogel.de>
Subject: [PATCH 8/9] w1: fix whitespaces of struct declarations
Date:   Sun, 28 Oct 2018 23:09:27 +0100
Message-Id: <20181028220927.56227-9-post@steffenvogel.de>
In-Reply-To: <20181028220927.56227-1-post@steffenvogel.de>
References: <20181028220927.56227-1-post@steffenvogel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540764601; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wpHckjG4eFJkyhwxZ3FFmBUzBL+hdnq1M27xexV9fjw=;
        b=heJeAJwC+4ANz0IEA04gRkuRhHAWQIMPRu1vBx07FAvWGd4a/90ZwZ4tATEe1zAyf+9u/w
        Y+wsWxZgv7kX+fSj9Ax1K7v0d6op93aEfzck0TVLrJMfg0oVSzjdmZeVyRRGOV/zGviYO+
        01tNzRlBpZB25uBQ9Elp6dnGEJiqjLvm7N9bZvde4fboEV9NEZRmHKzS81vsAXJIG8O1NL
        Z71XhfAYxsXYUqkuyR+zuv3iCtSOfSKNxlBmxcMMvDl94jRs1lGQxQcykXubpC7JlIhUpk
        KZDpO0Xwguo0MgDmpGuIdrnU3xOzDo8XGnXCrh5rk+uK75hXUy96R663Qu9zww==
ARC-Seal: i=1; s=2017; d=steffenvogel.de; t=1540764601; a=rsa-sha256;
        cv=none;
        b=i+gUItJDK2SeWPv9gIibgs0vjx51K/W7okvzZAtiSuwkTR7L0639FXJ4Zadf/iA8lHq6JODsXocpdxUTP2Xd6X/6TkMjPZ/Qfbwuvnl2HAqsDIEz8QsfxI4Dnm2LqEkhh5bhRRj+FAkEWPQFepZ3Fywq/v2evCYRKtVXVm5vhFqF+/sj1MGfBbFcKxaHECRUnkW9NBu4IbHmwFCNIl2KEE8yLnL4dl/T5Ktbjy9VDqB9rFbozSfKZnLBHJ2aX/FwOx+QiCcwVGuznLJ/LAR0gu/bD7ohThX8FHWwpxUFQfVMW0nYvFZlx9tWZojnA3ZBaNuycFFX149s74eI9Bpyzw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a warning raised by the checkpatch tool.

Signed-off-by: Steffen Vogel <post@steffenvogel.de>
---
 drivers/w1/w1_netlink.h | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/w1/w1_netlink.h b/drivers/w1/w1_netlink.h
index 08cbf08f3649..7873eb54352e 100644
--- a/drivers/w1/w1_netlink.h
+++ b/drivers/w1/w1_netlink.h
@@ -61,19 +61,18 @@ enum w1_netlink_message_types {
  * The netlink connector data sequence is, struct nlmsghdr, struct cn_msg,
  * then one or more struct w1_netlink_msg (each with optional data).
  */
-struct w1_netlink_msg
-{
-	__u8				type;
-	__u8				status;
-	__u16				len;
+struct w1_netlink_msg {
+	__u8 type;
+	__u8 status;
+	__u16 len;
 	union {
-		__u8			id[8];
+		__u8 id[8];
 		struct w1_mst {
-			__u32		id;
-			__u32		res;
+			__u32 id;
+			__u32 res;
 		} mst;
 	} id;
-	__u8				data[0];
+	__u8 data[0];
 };
 
 /**
@@ -117,12 +116,11 @@ enum w1_commands {
  * One or more struct w1_netlink_cmd is placed starting at w1_netlink_msg.data
  * each with optional data.
  */
-struct w1_netlink_cmd
-{
-	__u8				cmd;
-	__u8				res;
-	__u16				len;
-	__u8				data[0];
+struct w1_netlink_cmd {
+	__u8 cmd;
+	__u8 res;
+	__u16 len;
+	__u8 data[0];
 };
 
 #ifdef __KERNEL__
-- 
2.11.0

