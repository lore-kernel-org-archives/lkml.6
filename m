Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D4CECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67DC420854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAkjWBsm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67DC420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387804AbeGVXJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:09:16 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37964 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387780AbeGVXJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:09:15 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so5253351wmi.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 15:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7kaTXi69kVCwaOItbRb78RkaiDSmcdhi+pavysVfoeY=;
        b=NAkjWBsm8ne9OQrixN+0AXqk39WblHXkJAjnuKxvA3zhiWVqBDeih6VVyfp8lHxChS
         ohq37yCK2Pj9rvJuPIWbfQVf4pW5pbW3lzlpPxmP3q45wP+EAZORKIWXtl6R8FvaY5sk
         /9x31QgZa+zRKkP1VYOuwC52+Mlm+k4TGH0LxFfIhEuh8pHeg+DvTTEQP41cL7sMjmzM
         TAQA8t+HdVWCIn6fdpno1fTIwgFUQonoHftvJKv1yGw81bXCgZPIqSkQMalglrY5zFrE
         RDtbRZiSVnbVhTjA5Pmme6kmBChz8xpSsNYvgSZ1bQoAPWqfVf5MP2POm/tV/HV3ZPhp
         wPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7kaTXi69kVCwaOItbRb78RkaiDSmcdhi+pavysVfoeY=;
        b=o33YeWLGk5uNInXou5CaRntjVkeK723aQIU6Fo+ORMXJvmDw/5H7W2R9xH9+V2ucdT
         6aQm1im1ebOcvoxIgOItMfkq87pVsTyEK6Q0MfTPGwiYtNJwsT1bwmr53Yb8uH0Ln89A
         t2Q+t0tGI6D+a2jvyMzIDOUSDwHLD7tTNUDpmCEEygurQpeU+tQauBZzHyBTefa8K/IT
         qNY7aBMVdmuwwI7VJ3wfA0G99+pcKpJ6MxL3Ftms1FsndN3Hy+rMU9KXiCmJIaDQJcuS
         FCCUL5EOe6/pDeYJmivJ4mQJEhplUhpk7MxhhkoQ9u1m956zogEIG4ul9qZjL6AI1GFq
         HTqQ==
X-Gm-Message-State: AOUpUlG5/EnSn1PRizryV5uoLwLayBR3zL8yE0rS1vla14HBy82/utG6
        mvtDH3B1xtRE2z/MdBF0QOf35zgCOU4=
X-Google-Smtp-Source: AAOMgpfPodIfuIs7P3ewM+4rlTqTa1R0vNqf43a4pfHHr0nQvI4QO4dOHuVNmzHKA2u6eOPqYCtbwQ==
X-Received: by 2002:a1c:1d2:: with SMTP id 201-v6mr5669297wmb.4.1532297463616;
        Sun, 22 Jul 2018 15:11:03 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e12-v6sm5870824wrt.29.2018.07.22.15.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 15:11:02 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 10/20] staging:rtl8192u: Remove unused page-1 Bit Masks - Style
Date:   Sun, 22 Jul 2018 23:10:25 +0100
Message-Id: <20180722221035.14453-11-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180722221035.14453-1-johnfwhitmore@gmail.com>
References: <20180722221035.14453-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused 'page-1' Bit Masks. These definitions fail the
checkpatch CamelCase naming test. To avoid renaming the definitions
have simply been removed. This is a coding style change which should
have no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phyreg.h | 48 +-----------------------
 1 file changed, 1 insertion(+), 47 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phyreg.h b/drivers/staging/rtl8192u/r819xU_phyreg.h
index 5352ae64ab97..fb0b388f6759 100644
--- a/drivers/staging/rtl8192u/r819xU_phyreg.h
+++ b/drivers/staging/rtl8192u/r819xU_phyreg.h
@@ -105,54 +105,8 @@
 #define rGlobalCtrl				0
 
 /* Bit Mask
- * page-1
+ * page-8
  */
-#define bBBResetB					0x100
-#define bGlobalResetB				0x200
-#define bOFDMTxStart				0x4
-#define bCCKTxStart					0x8
-#define bCRC32Debug				0x100
-#define bPMACLoopback				0x10
-#define bTxLSIG						0xffffff
-#define bOFDMTxRate				0xf
-#define bOFDMTxReserved				0x10
-#define bOFDMTxLength				0x1ffe0
-#define bOFDMTxParity				0x20000
-#define bTxHTSIG1					0xffffff
-#define bTxHTMCSRate				0x7f
-#define bTxHTBW						0x80
-#define bTxHTLength				0xffff00
-#define bTxHTSIG2					0xffffff
-#define bTxHTSmoothing				0x1
-#define bTxHTSounding				0x2
-#define bTxHTReserved				0x4
-#define bTxHTAggreation				0x8
-#define bTxHTSTBC					0x30
-#define bTxHTAdvanceCoding			0x40
-#define bTxHTShortGI				0x80
-#define bTxHTNumberHT_LTF			0x300
-#define bTxHTCRC8					0x3fc00
-#define bCounterReset				0x10000
-#define bNumOfOFDMTx				0xffff
-#define bNumOfCCKTx				0xffff0000
-#define bTxIdleInterval					0xffff
-#define bOFDMService				0xffff0000
-#define bTxMACHeader				0xffffffff
-#define bTxDataInit					0xff
-#define bTxHTMode				0x100
-#define bTxDataType				0x30000
-#define bTxRandomSeed				0xffffffff
-#define bCCKTxPreamble				0x1
-#define bCCKTxSFD					0xffff0000
-#define bCCKTxSIG					0xff
-#define bCCKTxService				0xff00
-#define bCCKLengthExt				0x8000
-#define bCCKTxLength				0xffff0000
-#define bCCKTxCRC16				0xffff
-#define bCCKTxStatus				0x1
-#define bOFDMTxStatus				0x2
-
-/* page-8 */
 #define bRFMOD						0x1
 #define bJapanMode				0x2
 #define bCCKTxSC					0x30
-- 
2.18.0

