Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5F5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81EE220684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ghev7q5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81EE220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437103AbeKWAcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:32:07 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36031 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437076AbeKWAcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:32:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id s11so9237861wmh.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 05:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/EcXHX2qsOwyLUgkC2dAd+0XZzGI2xxxDyTZR6xw/SA=;
        b=Ghev7q5OsLA7kbAL2PnQdNFfjoE6HAiPgVSLjOlQqGvtaWfHfgkqSoSp6Tq400V5Xc
         lcDGP1iK670VYyg9vx4xHKVrmi7M9IF53SoLkOdAheW0aIN9vz1quyjwifBQUPHnHPeT
         UK28qhAYRyR1Wjh41LUnUzEfnwew2EwuYyD9h9V2sAfH1GrFzIM8q3LsmxwgzW0+3aVd
         221RClt6/r/kWt0d/TF0WYr9fx/7/m6L0oD8V208xHNYcYenp2gwZP3Cari0By4O52/T
         EH5KM8doHWSMk3CY2Ljy5qBJRClRcMgRoNqYPCJAYqnCdJQMml2EfUj9CK1cuCRZ/jIi
         epXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/EcXHX2qsOwyLUgkC2dAd+0XZzGI2xxxDyTZR6xw/SA=;
        b=TH0u/c1baqkZDcCoALAO+CBI28OMzXDzVG3DYoc4R5w3OKVnT7690mcnsS+zZ+1+HY
         iOindPC1K9SKhcv3EQMihX5gkVrY8MUXgZ+QJS//x6K1Fa1I56nXozGofCp18SfGOsUr
         ipSkSpEzFjDlLB641pekAvFgCJnr+w6DN5NWlwW7+cJ2tGA/GInsAltPVXpg9gPSzTme
         dqCHfz4gv18bx/QZY2k8J9NpC5DNb1f+iUEH8NPlNuPYSbDgXtOd4SQVL9/wjQlLQfsF
         Inr65rcd5CpBTv5rzG7o6VXS90xkPuyN32Q44CzsxCGOnsvuOKqWJMoYzV6wUpeapqF9
         6/Uw==
X-Gm-Message-State: AGRZ1gLSaODDPLlaVJJxUWE883ImIzYjrPcP5ehWp4fBbppj1i/iV1wu
        CQsNjdUDucVyd4Hl8uiWmT0=
X-Google-Smtp-Source: AJdET5fKfjOohoaMzl+M9B8Br0uEoZii8R+IsDxexV5O05gNvoNVWLkhQMqcvpeR3+TlSg/3ZIWWww==
X-Received: by 2002:a1c:af89:: with SMTP id y131mr9608164wme.137.1542894757340;
        Thu, 22 Nov 2018 05:52:37 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id c188-v6sm2393285wma.39.2018.11.22.05.52.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 05:52:36 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/8] staging: rtl8188eu: add spaces around '>>' and '&'
Date:   Thu, 22 Nov 2018 14:52:16 +0100
Message-Id: <20181122135218.1703-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122135218.1703-1-straube.linux@gmail.com>
References: <20181122135218.1703-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '>>' and '&' to follow kernel coding style.
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
index 73d2d312e8ab..4821ce2fa762 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
@@ -173,7 +173,7 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 		pkt_copy = NULL;
 
 		if (transfer_len > 0 && pkt_cnt == 0)
-			pkt_cnt = (le32_to_cpu(prxstat->rxdw2)>>16) & 0xff;
+			pkt_cnt = (le32_to_cpu(prxstat->rxdw2) >> 16) & 0xff;
 
 	} while ((transfer_len > 0) && (pkt_cnt > 0));
 
@@ -299,7 +299,7 @@ u8 usb_read8(struct adapter *adapter, u32 addr)
 	requesttype = 0x01;/* read_in */
 	index = 0;/* n/a */
 
-	wvalue = (u16)(addr&0x0000ffff);
+	wvalue = (u16)(addr & 0x0000ffff);
 	len = 1;
 
 	usbctrl_vendorreq(adapter, request, wvalue, index, &data, len, requesttype);
@@ -319,11 +319,11 @@ u16 usb_read16(struct adapter *adapter, u32 addr)
 	request = 0x05;
 	requesttype = 0x01;/* read_in */
 	index = 0;/* n/a */
-	wvalue = (u16)(addr&0x0000ffff);
+	wvalue = (u16)(addr & 0x0000ffff);
 	len = 2;
 	usbctrl_vendorreq(adapter, request, wvalue, index, &data, len, requesttype);
 
-	return (u16)(le32_to_cpu(data)&0xffff);
+	return (u16)(le32_to_cpu(data) & 0xffff);
 }
 
 u32 usb_read32(struct adapter *adapter, u32 addr)
@@ -339,7 +339,7 @@ u32 usb_read32(struct adapter *adapter, u32 addr)
 	requesttype = 0x01;/* read_in */
 	index = 0;/* n/a */
 
-	wvalue = (u16)(addr&0x0000ffff);
+	wvalue = (u16)(addr & 0x0000ffff);
 	len = 4;
 
 	usbctrl_vendorreq(adapter, request, wvalue, index, &data, len, requesttype);
@@ -520,7 +520,7 @@ int usb_write8(struct adapter *adapter, u32 addr, u8 val)
 	request = 0x05;
 	requesttype = 0x00;/* write_out */
 	index = 0;/* n/a */
-	wvalue = (u16)(addr&0x0000ffff);
+	wvalue = (u16)(addr & 0x0000ffff);
 	len = 1;
 	data = val;
 	return usbctrl_vendorreq(adapter, request, wvalue,
@@ -540,7 +540,7 @@ int usb_write16(struct adapter *adapter, u32 addr, u16 val)
 	requesttype = 0x00;/* write_out */
 	index = 0;/* n/a */
 
-	wvalue = (u16)(addr&0x0000ffff);
+	wvalue = (u16)(addr & 0x0000ffff);
 	len = 2;
 
 	data = cpu_to_le32(val & 0x0000ffff);
@@ -562,7 +562,7 @@ int usb_write32(struct adapter *adapter, u32 addr, u32 val)
 	requesttype = 0x00;/* write_out */
 	index = 0;/* n/a */
 
-	wvalue = (u16)(addr&0x0000ffff);
+	wvalue = (u16)(addr & 0x0000ffff);
 	len = 4;
 	data = cpu_to_le32(val);
 
-- 
2.19.1

