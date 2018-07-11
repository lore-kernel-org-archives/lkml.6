Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E739C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E362087C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGOakNDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E362087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390272AbeGKT20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:28:26 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38326 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733240AbeGKT2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:28:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id t2-v6so5410051edr.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 12:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RJbDdxLrwZF1ZSDZkV7K7KQsx9e0rpptRZo/nju3Cfw=;
        b=rGOakNDDB1kr1rNUwn8puPR2J50BM2CP/bZ4RlKh+jJ7fRE3toHE89EvLRFLEY+YMV
         AHLsMA8F1oG2PcbR00OJTHOOVbY37ZlOFP10qxcd/qzmXNagPtw5/kiQ/USAsy9bG+UK
         X2SzouyIfbbVMFnYYZBcCTTLOTG9BcQQZpNMHEUE5zbfFH78Gvb3yoiBuT73sdalf0Cu
         Qmm9a7USFc5zOx4bUQ/FyusWE4fd4DfQO8vFqr6go0HYQ0tpeOJmedr5wcvpXCOhXopz
         r1B7EJoeFJJ2WadO82hUoxsiYVKeNFSO5OG29w7aY2rTUhinFs7j8ecy5V4nRUGAdXWL
         I1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RJbDdxLrwZF1ZSDZkV7K7KQsx9e0rpptRZo/nju3Cfw=;
        b=RJxYPljYWqZzFBAOp+Dk5+AasCcNVS4mODhz7i2vA7aru74Kw6n0bNY4G4/6oPgmMl
         diRs16m3WyjG/UkqJd6rfrcRPx/Xsrb2jyyhnkhDdn2Xsq5/0rLFY7CtDfNkC5qSmxjq
         ip+ZH6jNPI4pa+KI+LvpzadZ6ju/I0M+MuAoGisde6jzgGw1UWCkfaPUfVwsyb4EOyjj
         F7h+T+T9aw2FqaoQf3eSx67+Skt19lqZeBKmLje8RAn8Rm9TYL8aoCwukfQRn1sNumV0
         x19BwBKidztFsLrf0nPpM7adiFNgCMx6xcReM1OYjKmoNxLYdb6l68lO2Iugiyp2u4yE
         69dQ==
X-Gm-Message-State: APt69E3FQLDUnBdZ1EbuRj8ui2DVvXxu8Y2vLyt4N1XJ1wTFAz0uP/Lj
        WtxlykaeIHh6f+JlE9MnuyeBHGQG
X-Google-Smtp-Source: AAOMgpdXFmiv+lQKkIMmepqYGROcQRWyJlQMnfwoqkcvTEYyid3q+L3r4fGh1aJtVnns5a+anmAe2A==
X-Received: by 2002:a50:f04d:: with SMTP id u13-v6mr32678071edl.91.1531336958284;
        Wed, 11 Jul 2018 12:22:38 -0700 (PDT)
Received: from localhost.localdomain ([109.77.228.66])
        by smtp.gmail.com with ESMTPSA id e9-v6sm7107787edc.37.2018.07.11.12.22.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 12:22:37 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 10/10] staging:rtl8192u: Change struct r8192_priv member Rf_Mode from u8 > enum
Date:   Wed, 11 Jul 2018 20:21:49 +0100
Message-Id: <20180711192149.21621-11-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180711192149.21621-1-johnfwhitmore@gmail.com>
References: <20180711192149.21621-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file r8192U.h defines the structure for holding private data for the
driver (typedef struct r8192_priv). This structure includes a member Rf_Mode
which is defined to be of type "u8".

Whilst the variable Rf_Mode is defined to be of type "u8" it is being assigned
enumerated values defined by the enumerated type "enum rf_op_type". Because of
the mismatch in types being used any advantage of using an enumerated type, to
have the compiler check assignments, is nullified.

This patch changes the type of the Rf_Mode member from a u8 to the enumerated
type "enum rf_op_type", so that the compiler can now check assignments.

This change of type would cause a problem if the structure was mapped from a
hardware device and the size and location of members was significant. I
believe that the structure to hold private data for the driver is allocated
from memory and populated with data in the function rtl8192_usb_probe() in the
file r8192U_core.c. As such the physical size of the member variable Rf_Mode
is not significant, so the change should have no impact on code execution, bar
the move from a u8 type to an int, (or whatever size compiler uses for enum).

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index 83bc4cef5b17..3963855ad743 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -334,11 +334,12 @@ struct rx_drvinfo_819x_usb {
 /* Octets for crc32 (FCS, ICV) */
 #define scrclng					4
 
-typedef enum rf_optype {
+enum rf_op_type {
 	RF_OP_By_SW_3wire = 0,
 	RF_OP_By_FW,
 	RF_OP_MAX
-} rf_op_type;
+};
+
 /* 8190 Loopback Mode definition */
 typedef enum _rtl819xUsb_loopback {
 	RTL819xU_NO_LOOPBACK = 0,
@@ -894,7 +895,7 @@ typedef struct r8192_priv {
 	u8      slot_time;
 	bool	bDcut;
 	bool bCurrentRxAggrEnable;
-	u8 Rf_Mode;	/* For Firmware RF -R/W switch */
+	enum rf_op_type Rf_Mode;	/* For Firmware RF -R/W switch */
 	prt_firmware		pFirmware;
 	rtl819xUsb_loopback_e	LoopbackMode;
 	u16 EEPROMTxPowerDiff;
-- 
2.18.0

