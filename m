Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6427C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801FF20A8B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tohhMhQY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801FF20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeH0A6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 20:58:50 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42976 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbeH0A6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 20:58:48 -0400
Received: by mail-ed1-f65.google.com with SMTP id r10-v6so9100325edp.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 14:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CHc8EJU6AgQ0l3nt3ln3GdDUgn+n9uF9IG0iXxa5sSo=;
        b=tohhMhQYhbJ0o1Iextps3suSyLVkdUrCOktH6EPBrFG3Fo9are9B4UOfK7LDrG7crs
         51CNGpfEWl2mOytK8Pl7K07p1ckgsEKI1Jg951G8BEpiuYmhp6x7Vxlg0fpsJKnEpVk0
         GUrbhDOioE8xMXoYbELzIQS/hiezjNYGqr5YynV9NONkE+CpnxlCwfxlqjbpZqOcxcrA
         4YdfcAhebePiDRVQLTmm4J65Za7MPoeeG95BI+FP5WFdujHt7CgndJFbvVn0LsaXiv6t
         6WiAUkEpPy1Sep9kbnBXIHQupnUPx3uCff8pYmqsFyeZGOUiOGP7tXL1/uPV1bs+YBkJ
         M06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CHc8EJU6AgQ0l3nt3ln3GdDUgn+n9uF9IG0iXxa5sSo=;
        b=nSFxOWdAG4WJdiCJmpCuDlS4j5pxGbnHj86RwWWaZC1azTK9T0tkyRT1zoD0CeeGBQ
         ZeyehRhqqxBeNcvWN9i4dax97oc/cfjAprcKNAOSjZX4NwHcIFzq77uPsN+KZecWSB0i
         DYTKkEcVFqnmUsMjfN3F6E5qgDguQr4GbtTDVfrqU3ofy7+Iv+nHq28X/L5XZETcwAzZ
         aejJyeL+AhQIBHI7AGQVhJyTNI+cP+Ts5UXz2XUyLRVfvI4UB/zMNhqxGPc/2GC61V0x
         PwIrp2Tzqn9lui55u96LUfXrRqM1s7jSg3/Wx4VzDC3/yFxgUYzFx1IyXTPr+lH/MpmF
         b+cw==
X-Gm-Message-State: APzg51CWSBhAfVOwdKoRZSBstFOPV8IUy++Djo14yPPRATSQWwkItFTW
        PBxNc1K5co5s2YcZFYFglmXRV1c5
X-Google-Smtp-Source: ANB0VdYKP4rJ23+bQXDToLNIlLDp/NPxBpRhzuu2U0wLjLi0zaSWWV1rGj9tkGVTeOlsf0oWwcJbqQ==
X-Received: by 2002:a50:f5ae:: with SMTP id u43-v6mr13875238edm.75.1535318104109;
        Sun, 26 Aug 2018 14:15:04 -0700 (PDT)
Received: from localhost.localdomain ([109.78.216.151])
        by smtp.gmail.com with ESMTPSA id b47-v6sm5937300eda.79.2018.08.26.14.15.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 14:15:03 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 06/21] staging:rtl8192u: Reorder enum _RTL8192Usb_HW members - Style
Date:   Sun, 26 Aug 2018 22:14:24 +0100
Message-Id: <20180826211439.14326-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826211439.14326-1-johnfwhitmore@gmail.com>
References: <20180826211439.14326-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder the members of enum _RTL8192Usb_HW so that they are in order.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_hw.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_hw.h b/drivers/staging/rtl8192u/r8192U_hw.h
index ddb88fa098d5..22f837f5b709 100644
--- a/drivers/staging/rtl8192u/r8192U_hw.h
+++ b/drivers/staging/rtl8192u/r8192U_hw.h
@@ -65,6 +65,8 @@
 
 //#endif
 enum _RTL8192Usb_HW {
+	MAC0			= 0x000,
+	MAC4			= 0x004,
 
 #define	BB_GLOBAL_RESET_BIT	0x1
 	BB_GLOBAL_RESET		= 0x020, // BasebandGlobal Reset Register
@@ -180,8 +182,8 @@ enum _RTL8192Usb_HW {
 #define RRSR_48M					BIT(10)
 #define RRSR_54M					BIT(11)
 #define BRSR_AckShortPmb			BIT(23)		// CCK ACK: use Short Preamble or not.
-	RATR0			= 0x320, // Rate Adaptive Table register1
 	UFWP			= 0x318,
+	RATR0			= 0x320, // Rate Adaptive Table register1
 	DRIVER_RSSI		= 0x32c,					// Driver tell Firmware current RSSI
 //----------------------------------------------------------------------------
 //       8190 Rate Adaptive Table Register	(offset 0x320, 4 byte)
@@ -236,9 +238,6 @@ enum _RTL8192Usb_HW {
 #define EPROM_CK_BIT BIT(2)
 #define EPROM_W_BIT  BIT(1)
 #define EPROM_R_BIT  BIT(0)
-
-	MAC0			= 0x000,
-	MAC4			= 0x004,
 };
 //----------------------------------------------------------------------------
 //       818xB AnaParm & AnaParm2 Register
-- 
2.18.0

