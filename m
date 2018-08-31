Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5387C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5A620841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiNo6m2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D5A620841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbeIADM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:12:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38138 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbeIADM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:12:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id w11-v6so12526596wrc.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 16:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8ajAWVFOgnoL8fTjlX13MJRp626fQ6R24JRz+4WO0Wk=;
        b=GiNo6m2aEV+Oi78zVUWM+0tlEgMI1CGivDNiWGJSoWiVJrcC1CxWlji8RbMUOhKG2D
         iEsU7lBthgKtp5yt8SfmM/33Xd0TDw6YZUapYzMWzabBUPiytkX7vzurALOh+ykS327F
         NUn8NVnD5e+Kd2yI4DVzIzRuUO2+x1nxxju4nu+br71NCORGVPcDTFDwIDz6DfQo2/dc
         srUtHIRjqOESHPa3ly8H3mn/3cxoPfoZ4VTL0rCkiTWzKbWCwbelMIBZvkJXI6EfocJ2
         pPXTpFWSsacGmxrgFm38d2xgxwMUVykumGUq9AVQ5ZT3pJJ2nxEzvEIuyS3GsduNbC5C
         XrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8ajAWVFOgnoL8fTjlX13MJRp626fQ6R24JRz+4WO0Wk=;
        b=jRLHOmM2uTgODrNmdAQOA78KXlucwfMJJt4+VWvR/YGf0mzrBFG3A5ymsv/fIsV8RT
         PNGNh5Ju1jAyCe9u4peqFtXAjnP6TrFX29s5U5Kc204BokTq4jllARaE8mSL/E8as+8r
         lRntjWVjeHlNfxkgREQU42DTQ2jr5o64g5nMXBg6/cm/gKCzxcsT97yAcKqm8fRMjshj
         yLwycDnr29LFiefVyVTjElRYnDKI55cW7Xi17pF3jolCnaOQj/iBPnK8zJJTsUWhkQET
         0ya3zNO4gWUtWZwRSZ1jvqjYYI3y5ZF61P4NRAw9qkFewfkGGddNeGuMGLHBg7secQPF
         c3jg==
X-Gm-Message-State: APzg51CJtr/92alUwhnhubrng3rdm2LVQqNNpBpovegYuutopvJp5JO6
        Td2oK/zGo+gPEBmES6AhZh9twl1R3RU=
X-Google-Smtp-Source: ANB0VdZt+rzotDB/hAlugJjPz7v5dz0xhzNRKlDSbfvsxzrJKe2skOcw7A+3epMgQSQmUYP21cobGA==
X-Received: by 2002:adf:b243:: with SMTP id y3-v6mr12501920wra.90.1535756596123;
        Fri, 31 Aug 2018 16:03:16 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o19-v6sm14562267wro.50.2018.08.31.16.03.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:03:15 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 13/20] staging:rtl8192u: Rename PktSize Style
Date:   Sat,  1 Sep 2018 00:02:43 +0100
Message-Id: <20180831230250.16810-14-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831230250.16810-1-johnfwhitmore@gmail.com>
References: <20180831230250.16810-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable 'PktSize' to 'pkt_size', this change
clears the checkpatch issue with CamelCase naming.

This is a simple coding style change which should not impact runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h      | 2 +-
 drivers/staging/rtl8192u/r8192U_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index e86a4b35a1f4..9931ede1524b 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -158,7 +158,7 @@ extern u32 rt_global_debug_component;
 /* For rtl819x */
 struct tx_desc_819x_usb {
 	/* DWORD 0 */
-	u16	PktSize;
+	u16	pkt_size;
 	u8	Offset;
 	u8	Reserved0:3;
 	u8	CmdInit:1;
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 4d43176bdb6c..2a3cb0f1ac07 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -1517,7 +1517,7 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
 	tx_desc->LINIP = 0;
 	tx_desc->CmdInit = 1;
 	tx_desc->Offset =  sizeof(struct tx_fwinfo_819x_usb) + 8;
-	tx_desc->PktSize = (skb->len - TX_PACKET_SHIFT_BYTES) & 0xffff;
+	tx_desc->pkt_size = (skb->len - TX_PACKET_SHIFT_BYTES) & 0xffff;
 
 	/*DWORD 1*/
 	tx_desc->SecCAMID = 0;
-- 
2.18.0

