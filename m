Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7FCC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DCAC2087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJx0dnlT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DCAC2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeJLD0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:26:55 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46133 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeJLD0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:26:15 -0400
Received: by mail-ed1-f65.google.com with SMTP id g32-v6so9384690edg.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 12:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=43kwxWQ/0j0GlQW34e1reyy0fO8CkEPNjCWEt6wkBvs=;
        b=NJx0dnlT1f/o5oGBQC/OoZnu2A4NvUDfxoscYBjWTw2Jnyag6lbutjGvoRshY1+Q9W
         RwRlGEV5uMV0S/7wx+ojEG/HpQOUGm0CeijE62ub7lhBeB5SRsrVp/ndf3V+rICcMcZ3
         icC26sPGn7Mqb4tcXfuje27Kx0yeqfB+eXUbTgp6HF0KncPcr1GJhROjnK/x7vc6UL53
         MuSJsam+UjB6xI+NThf685xmNO5WzevP9lDuNTcepz+m9JDWgZ4eE49sIWleAR8flUEc
         rBOYX+My6A0co48lHWOpWdcN6lDRf5xTFI0Oyq9/A9TM2b5x17IeeJ3KAFPfYctdClVO
         VaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=43kwxWQ/0j0GlQW34e1reyy0fO8CkEPNjCWEt6wkBvs=;
        b=bcmAUg9xxONLdZfbqJEQXSPD6hDlNay3P+Tp8zfnIADyAKMNhdPP9v1yxNi0ORf8kO
         Amta7Q4eoWcGMaFiKmWM+Rrzq3ghqc+iiQ+hFMxeNV4b5z20SoUJik4Ka/UYS2a9DAIv
         Bkjf7fc9oXEKwqcG9hEg6xF+CduEfJYEtW72vCPwN67uBJ6pygTxiOf++O38vh9g0Bx0
         qesNrdERbXWw/R9xjJ64xlUa6MHdA9a1I1ofMHfoFJPl9r5r2LG3yLpHnoZ5aanHi/cV
         7jMrE9G1x9aRgLovZoft7OcegCskgWKEP+qXXTn6wdJkYbeFcJ68uy3AeijER+rz3ztp
         /OFQ==
X-Gm-Message-State: ABuFfoi+q2oSpcOCgV1l3QtZoMFlLNwtvitF31x/JW5Gg2oh4DuQNMhv
        MwF63T6K+ffOWlsHVBBQSio=
X-Google-Smtp-Source: ACcGV63G4rXyGWswfkW1Q9NppL+tAQcSYDV+IxGlfqGM5FimKcblytA+axPs6mtSRCOZsbSxgY+9uQ==
X-Received: by 2002:a50:97c8:: with SMTP id f8-v6mr4927471edb.243.1539287847587;
        Thu, 11 Oct 2018 12:57:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:8569:71c8:6dba:bb41])
        by smtp.gmail.com with ESMTPSA id k22-v6sm919408eja.23.2018.10.11.12.57.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 12:57:27 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/8] staging: rtl8188eu: use __func__ in qos_acm()
Date:   Thu, 11 Oct 2018 21:57:06 +0200
Message-Id: <20181011195712.1472-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011195712.1472-1-straube.linux@gmail.com>
References: <20181011195712.1472-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use __func__ instead of hardcoded name in qos_acm().
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_xmit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 8336a7252440..07b6e680377f 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -368,7 +368,8 @@ u8	qos_acm(u8 acm_mask, u8 priority)
 			change_priority = 5;
 		break;
 	default:
-		DBG_88E("qos_acm(): invalid pattrib->priority: %d!!!\n", priority);
+		DBG_88E("%s(): invalid pattrib->priority: %d!!!\n",
+			__func__, priority);
 		break;
 	}
 
-- 
2.19.1

