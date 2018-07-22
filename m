Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924ACC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D9C20854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l917x2VK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D9C20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387979AbeGVXJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:09:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37975 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387926AbeGVXJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:09:32 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so5253638wmi.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 15:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b+Nf5guHiURoLZzfLJ+ux3vdQ8MooNFy4nTLdoMJBRc=;
        b=l917x2VKPk2/+EAuBshvTj0yewiKRkJF84EZnw7orSv3f7XWoOpSFyJNaaUgCc4V4P
         NjbfQL5vOl3Q68D5m8Q33ZDNVQYHUKzTc3GlQ2adUrvcPw1Xt7K3PyL4AxbRnayME6Rj
         VzC7oAoTVZ7/vuwoAQ/h3UCBOfIFCplGkEU0rSRd9nHLDum9XX7/zh3z2olWgDIRM504
         mU6ETDzNZDpziydjqYqEeOuE6hbxOHW+OL0iOptBKocCBNGI2VOwC9N2qdqFOdF0Ltmr
         Y8gtBIb9ZLuHgwydGx6duiwnyfTfyBgR2GdVxUsZEjfvyozaRHlCss8hvgWm9y+rUAtN
         JyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b+Nf5guHiURoLZzfLJ+ux3vdQ8MooNFy4nTLdoMJBRc=;
        b=g22Hgq7AtTryS+Fz0042qiGscdolS/ldQLN2b03H7Pn/+gHymOb4JeFRZgPmvbIomg
         3Dpc1gVn+PDxpgZI30Rb69IyZUBdTnI9/7Gzw77SFkfaZhxZLHo0bBMxIlp1h3GY8wZS
         WuexOP4YVJcykrIkll5Cu2hgRy4DxtqPxl+KrdSzDLqs8RSk94tglXUGI/kNRMQt57GL
         Wf8SEW9dGu9//MPOl2MCMAsllhB+EF3D4qLAO8f3rcU22UyvOpHM7PPT7jZMyP5AHart
         3O79TIoZwzMilPsSysxywFgxI4fwd2QF43MYLzeu4I9j67RrZ+O+9FHPDpbENqi1/kz6
         QrRA==
X-Gm-Message-State: AOUpUlH7XsBTIx6bahQKigaFpg6LBjjOknn6igXCpr/qExebNzUIHHtX
        IfKsiMDGkCt3NWYg00ZdsZG/IRbqiFE=
X-Google-Smtp-Source: AAOMgpfy0Qdxt5X0GtXEm+hYGuPBiRCRs5cGSdu/KMFg9hPxa+i3XUwxcKAogqdyi5LdKfk6cgafDw==
X-Received: by 2002:a1c:e304:: with SMTP id a4-v6mr6025245wmh.0.1532297480465;
        Sun, 22 Jul 2018 15:11:20 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e12-v6sm5870824wrt.29.2018.07.22.15.11.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 15:11:19 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 20/20] staging:rtl8192u: Remove unused RTL8258 bit mask definitions - Style
Date:   Sun, 22 Jul 2018 23:10:35 +0100
Message-Id: <20180722221035.14453-21-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180722221035.14453-1-johnfwhitmore@gmail.com>
References: <20180722221035.14453-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused 'RTL8258' bit mask definitions. These definitions fail
the checkpatch CamelCase naming tests. Since the definitions are unused
in code they have been removed, rather then renaming.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phyreg.h | 59 ------------------------
 1 file changed, 59 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phyreg.h b/drivers/staging/rtl8192u/r819xU_phyreg.h
index 708dae62c644..65ee6088324c 100644
--- a/drivers/staging/rtl8192u/r819xU_phyreg.h
+++ b/drivers/staging/rtl8192u/r819xU_phyreg.h
@@ -132,24 +132,10 @@
 #define bZebra1_ChannelNum        0xf80
 
 /* RTL8258 */
-#define bRTL8258_TxLPFBW          0xc
-#define bRTL8258_RxLPFBW          0xc00
-#define bRTL8258_RSSILPFBW        0xc0
-
-/* byte endable for sb_write */
-#define bByte0                    0x1
-#define bByte1                    0x2
-#define bByte2                    0x4
-#define bByte3                    0x8
-#define bWord0                    0x3
-#define bWord1                    0xc
-#define bDWord                    0xf
-
 /* for PutRegsetting & GetRegSetting BitMask */
 #define bMaskByte0                0xff
 #define bMaskByte1                0xff00
 #define bMaskByte2                0xff0000
-#define bMaskByte3                0xff000000
 #define bMaskHWord                0xffff0000
 #define bMaskLWord                0x0000ffff
 #define bMaskDWord                0xffffffff
@@ -157,49 +143,4 @@
 /* for PutRFRegsetting & GetRFRegSetting BitMask */
 #define bMask12Bits               0xfff
 
-#define bEnable                   0x1
-#define bDisable                  0x0
-
-#define LeftAntenna               0x0
-#define RightAntenna              0x1
-
-#define tCheckTxStatus            500   /* 500ms */
-#define tUpdateRxCounter          100   /* 100ms */
-
-#define rateCCK     0
-#define rateOFDM    1
-#define rateHT      2
-
-/* define Register-End */
-#define bPMAC_End                 0x1ff
-#define bFPGAPHY0_End             0x8ff
-#define bFPGAPHY1_End             0x9ff
-#define bCCKPHY0_End              0xaff
-#define bOFDMPHY0_End             0xcff
-#define bOFDMPHY1_End             0xdff
-
-/* define max debug item in each debug page
- * #define bMaxItem_FPGA_PHY0        0x9
- * #define bMaxItem_FPGA_PHY1        0x3
- * #define bMaxItem_PHY_11B          0x16
- * #define bMaxItem_OFDM_PHY0        0x29
- * #define bMaxItem_OFDM_PHY1        0x0
- */
-
-#define bPMACControl              0x0
-#define bWMACControl              0x1
-#define bWNICControl              0x2
-
-#define PathA                     0x0
-#define PathB                     0x1
-#define PathC                     0x2
-#define PathD                     0x3
-
-#define	rRTL8256RxMixerPole		0xb
-#define		bZebraRxMixerPole		0x6
-#define		rRTL8256TxBBOPBias        0x9
-#define		bRTL8256TxBBOPBias       0x400
-#define		rRTL8256TxBBBW             19
-#define		bRTL8256TxBBBW			0x18
-
 #endif	/* __INC_HAL8190PCIPHYREG_H */
-- 
2.18.0

