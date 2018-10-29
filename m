Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11FEC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC632075D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=steffenvogel.de header.i=@steffenvogel.de header.b="VQFg8UOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC632075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=steffenvogel.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbeJ2L7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 07:59:42 -0400
Received: from nag.0l.de ([207.154.252.120]:44806 "EHLO nag.0l.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729137AbeJ2L7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 07:59:41 -0400
From:   Steffen Vogel <post@steffenvogel.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540782275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G+cnrY+PphmN7096bgQRGIW67/lbza3AsPj54wLHHXY=;
        b=VQFg8UOFTWycMWwdkIw3gOVxXveGc+fplfkfOsZLmnP3gcCXfcCzE4aL/jSqPU3MCifeID
        afESUXiFuESY9mDVhuKzxm/ZLzGjtBiKg+lzmS4GG6K4RQ8QjCsVWkSY1nrpGbY/z8A+/o
        sZ3ZMJIHRPvgVhsLxIoooqUUZY6Y8e8EDgJIpU45JRKoVhgKOrnrJcv6FIIwVFSRX6D8bR
        FDhtiYVesA+jCCmtcFQDoNmrua+zwXA6Leu3p3XPY9l86fIVgvAL4b3RRk3OX3I8c9ExA8
        I/2Clf7orSOFLfDqwiUPv4R2ObHLRQ5bIGk+C83fKKUsrNdKiylb98omznpQqQ==
To:     linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>, Joe Perches <joe@perches.com>,
        Steffen Vogel <post@steffenvogel.de>
Subject: [PATCH v2 08/12] w1: improve code-style of struct declarations
Date:   Mon, 29 Oct 2018 04:03:38 +0100
Message-Id: <978fc1676896e84c7ca7ce9942de25c4db00708b.1540782140.git.post@steffenvogel.de>
In-Reply-To: <cover.1540782140.git.post@steffenvogel.de>
References: <cover.1540782140.git.post@steffenvogel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540782275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G+cnrY+PphmN7096bgQRGIW67/lbza3AsPj54wLHHXY=;
        b=kN1AwZVtIVEiiWwfpCLukFbDUMJSgPD4wntySWh/fj+Ey+eBAbUDALOakbjW54ptNuw5Pz
        0dB9G/wtanLe0qljES5i7C1MFNmSuqa2AGV7lRcWw1ZAATAd4BeuMidZWw8tUI4M8APFk1
        PwjSA0qDlPR1oYNuZuaKR7XHJrYKJNqFKlm7o8H5iuuCgUutLOePnwxxJ0ranGsssU5obh
        u+M4ZkAFRZsYjj7EsPUbZYDTaHs48Cj1cjtB6IWETKv8nq4ONmfFzCIT8wcXRwOrUVMAde
        /VH+maJN4x+guZDkm1n7SSOyIXj6deYzouZ5nuoB+oxtJ1Tbcx8YeczI1L8viA==
ARC-Seal: i=1; s=2017; d=steffenvogel.de; t=1540782275; a=rsa-sha256;
        cv=none;
        b=omY/mBDXuZJvZU75WMpL/pxPx1DS6+DNPT15IEm9PD7E8F6xjVc+6jrzZjkegaEZ+Pz6yQFyswY2QoATYiJI37nby4NUnp4vj1nLeP6hM/7QOd0t4arNZY2CXAAnOa8rtiVobYjBQkw6ADQMAIP8rKtG7fxaVQZbsq0AKkAKzAMk3pBZYj6jGjj8ShgH4wMoOcveR1/4yVMJxBWSIcqWLLodOd/7tOHxxNLSw3H/sjlhMAMySyhb+LtROz6WfB5IJIbvwqfDlKyX2yqsgjxeRq8WvM5+gMyOK3rJBviBloaaLHAO/ymJpYIswN9MMrt/efa/F58QhHWhophIeecsuw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Among improving the readability of the struct declarations,
this fixes a warning about incorrect brace placement
raised by the checkpatch tool.

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

