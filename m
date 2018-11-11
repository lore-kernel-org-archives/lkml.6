Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49081C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1429120871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1429120871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbeKLFsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:02 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49278 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729551AbeKLFsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:01 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsN-0000l7-M0; Sun, 11 Nov 2018 19:58:31 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsN-0001MG-Gh; Sun, 11 Nov 2018 19:58:31 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.998061524@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 003/366] staging: vt6656: Fix misleading indentation
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben@decadent.org.uk>

Fix the compiler warnings:

drivers/staging/vt6656/dpc.c:712:5: warning: this 'if' clause does not guard...
drivers/staging/vt6656/main_usb.c:1101:7: warning: this 'if' clause does not guard...

by reducing indentation of the following statements in
RXbBulkInProcessData() and reformatting the kstrstr() function to
kernel coding style.

Both functions have been removed in a later version, so there is no
corresponding upstream commit.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -1092,17 +1092,18 @@ out:
 
 /* find out the start position of str2 from str1 */
 static unsigned char *kstrstr(const unsigned char *str1,
-			      const unsigned char *str2) {
-  int str1_len = strlen(str1);
-  int str2_len = strlen(str2);
+			      const unsigned char *str2)
+{
+	int str1_len = strlen(str1);
+	int str2_len = strlen(str2);
 
-  while (str1_len >= str2_len) {
-       str1_len--;
-      if(memcmp(str1,str2,str2_len)==0)
-	return (unsigned char *) str1;
-        str1++;
-  }
-  return NULL;
+	while (str1_len >= str2_len) {
+		str1_len--;
+		if (memcmp(str1, str2, str2_len) == 0)
+			return (unsigned char *)str1;
+		str1++;
+	}
+	return NULL;
 }
 
 static int Config_FileGetParameter(unsigned char *string,
--- a/drivers/staging/vt6656/dpc.c
+++ b/drivers/staging/vt6656/dpc.c
@@ -712,8 +712,8 @@ int RXbBulkInProcessData(struct vnt_priv
     if (FrameSize < 12)
         return false;
 
-	skb->data += cbHeaderOffset;
-	skb->tail += cbHeaderOffset;
+    skb->data += cbHeaderOffset;
+    skb->tail += cbHeaderOffset;
     skb_put(skb, FrameSize);
     skb->protocol=eth_type_trans(skb, skb->dev);
     skb->ip_summed=CHECKSUM_NONE;

