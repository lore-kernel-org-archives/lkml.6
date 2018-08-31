Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A40C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33AD20841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/uQQtZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33AD20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeIADNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:13:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40086 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbeIADNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:13:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id n2-v6so12528925wrw.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 16:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uRO0Wj60NCrQjcO1zavlVZ4z9J2KbXG1nwQS6DaRvzI=;
        b=j/uQQtZN5mqpGlfnp5xZrsnxn8dF60qeE5i9TCFajnRrFdY+wocKW+HngyuyX49sWu
         iFYay1RMgdCW4k/gaEHK5uvqms6mPpxnRpVj1bDAYC88W5/jG5Gvcnk3V/Olp/MJLGx6
         SpruSYudMfNB7PO3IgcHd78vhpeE0snLbxrZ67taT8V6LDxR6Gcukamb1SetMBXn6XNu
         smf5iJHo4QCkTQ+NETB8sZa5MLo3BDRdryrvZu4fvXF8BcNySvKzNQvNjfff27TOMwc9
         FP2uEsRIH1AXFcirE4rcips4g0JDqWQ/byAblVs3GLL7kDrT6hh0gx8LLi7+uGNwGWXr
         lLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uRO0Wj60NCrQjcO1zavlVZ4z9J2KbXG1nwQS6DaRvzI=;
        b=Y5RzZrNyiFo4PvRAtX9qQ+L9hA8tvkRC0Wi8o40sSktqFAWAIw+2+7XWB5SA4DDom4
         kUHVFPebhzR0xsZ7OtvaCJJfkcVyzYeDNL0aaS8PFDvApCiMGgHIza/w3JxpWdU1+W+W
         gbBQjcE9pn/5LceTFQYhh1fHZz7OIG5JHo+lU4Y/G7ddbglfs50dFdSXSDYcnyANXjQM
         aKcEXNNUjYTJqt0ISC6Y3XeNFbY7wD3/m13OoYED40FGyjCcBD3zzcxfJE/fBbHKRs9E
         jm6kM/0MVk3YzTwWlEEMJZ76X/tHIEaVwug6iNkFCYOyPR0L628kbeI7FE+c7tXm1Gcl
         UO9Q==
X-Gm-Message-State: APzg51CdMh39NJrrv2GcCOMUKoslF1TdOBWoeuSIO53+RVxYRGwAEPTl
        2qBhHC0FWkVGI6SiYgd6vSMqLgQyvcM=
X-Google-Smtp-Source: ANB0VdZBDc/VE+60wBn89JfYkObkoc3fSnBW3uFy1wunpBrAkFUDj3xJx1QY1VqmYBpKkwikpshyKQ==
X-Received: by 2002:adf:edd2:: with SMTP id v18-v6mr12896135wro.39.1535756597943;
        Fri, 31 Aug 2018 16:03:17 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o19-v6sm14562267wro.50.2018.08.31.16.03.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:03:17 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 14/20] staging:rtl8192u: Rename Offset - Style
Date:   Sat,  1 Sep 2018 00:02:44 +0100
Message-Id: <20180831230250.16810-15-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831230250.16810-1-johnfwhitmore@gmail.com>
References: <20180831230250.16810-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable 'Offset' to 'offset', this clears the
checkpatch issue with CamelCase naming.

This is a coding style change which should not impact runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h      | 2 +-
 drivers/staging/rtl8192u/r8192U_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index 9931ede1524b..8aaea1d8cf50 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -159,7 +159,7 @@ extern u32 rt_global_debug_component;
 struct tx_desc_819x_usb {
 	/* DWORD 0 */
 	u16	pkt_size;
-	u8	Offset;
+	u8	offset;
 	u8	Reserved0:3;
 	u8	CmdInit:1;
 	u8	LastSeg:1;
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 2a3cb0f1ac07..d4af6cc01fc6 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -1516,7 +1516,7 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
 	/* DWORD 0 */
 	tx_desc->LINIP = 0;
 	tx_desc->CmdInit = 1;
-	tx_desc->Offset =  sizeof(struct tx_fwinfo_819x_usb) + 8;
+	tx_desc->offset =  sizeof(struct tx_fwinfo_819x_usb) + 8;
 	tx_desc->pkt_size = (skb->len - TX_PACKET_SHIFT_BYTES) & 0xffff;
 
 	/*DWORD 1*/
-- 
2.18.0

