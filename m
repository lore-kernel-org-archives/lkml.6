Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5FDC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E2B20854
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u2L8gXnT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E2B20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbeIADMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:12:52 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54958 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbeIADMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:12:51 -0400
Received: by mail-wm0-f66.google.com with SMTP id c14-v6so6529655wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 16:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=csE7XKhkorMZuVB1+Vr2mRzORC0lOiSM7L22kn5srZk=;
        b=u2L8gXnTBOhwT8KGGp/XPpOZJ21ABek1u7PZCZa/7iENvPKi8hRnyNPaVqfzEWxhWb
         IioMtpmjwFXAfBwZJVlpYC7zW9fcuRM4dC4G+9/UGBAM/r8hKYDMbSC6W5rQWFUinj+Q
         aqeVrn1Lr8sP9i+S6HquaXt3Y14mTrtF5+HmHcwEIwjdxmi52lwEMrpIVBr+4ow2vngM
         kudKVR0k6fhb/s/6wDgcjOHrjXQxgc62ROReM6sV1aDNrQQE4kjdL+kKK8K5E2oMsxNe
         Ovaznk3vK4ByA37RBdjR2JWfOF7UQC8DFX+XuLf2mNR7c9lF5da6AjttR4qaMbzh5Mkm
         8FBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=csE7XKhkorMZuVB1+Vr2mRzORC0lOiSM7L22kn5srZk=;
        b=HWQ2CbzM2d9kc3D+lOKJbG0KNVhhkgpC4m35+a5VY4YpxPnx23gxnpun2woQw1PgxC
         DAb0kEsyfObp8a6VbZG8A7vf07KAbjyWH4/wasBRbJp8bN/aMrwzPD/vJ6HkrtNfA9d6
         YjpH1yX0EwF9Ndil0h2GfqmGQ1AZO3H0FfKn1i/+PvueAkWJOUcnDASPUY0V1k0yhxNr
         YuUr8dn4KYgDNnJKDo7E7c8O4RDZMNxS5WIEZhlSBYNaH/ESp4q1PHBWvo3zA0qRHUNc
         IYg7GjG9HJ8EVYf8G/8TwJVoNq1McWrIKC6iifTniPjwgkJOT7XKcI+SpjKN2JRAzl9o
         9ktg==
X-Gm-Message-State: APzg51D1RovCFyB+jyyMm1OzKxvdq2UVuVj0PknsXq41y1cgJYXRlUHS
        0PsTZeYPCyCICeyVimuCM9Jzqs4IbfE=
X-Google-Smtp-Source: ANB0VdbYlCYM8rjpgm9wVnYLMRe5o0lvLOFvx6+NNYUMzDb2xi17h2Zq12rLIpqXnZeZpvEtx6Hqqg==
X-Received: by 2002:a1c:8893:: with SMTP id k141-v6mr5949246wmd.36.1535756589041;
        Fri, 31 Aug 2018 16:03:09 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o19-v6sm14562267wro.50.2018.08.31.16.03.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:03:08 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 09/20] staging:rtl8192u: Remove RT_DEBUG_DATA - Style
Date:   Sat,  1 Sep 2018 00:02:39 +0100
Message-Id: <20180831230250.16810-10-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831230250.16810-1-johnfwhitmore@gmail.com>
References: <20180831230250.16810-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the RT_DEBUG_DATA Macro. The macro causes a number of
checkpatch issues, and is not actually used in code, so can simply
be removed without issue.

This is a coding style change which should not impact runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index e65a893fd084..528c50be3894 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -103,28 +103,8 @@ extern u32 rt_global_debug_component;
 				 #expr, __FILE__, __func__, __LINE__);	\
 		}							\
 	} while (0)
-/*
- * Debug out data buf.
- * If you want to print DATA buffer related BA,
- * please set ieee80211_debug_level to DATA|BA
- */
-#define RT_DEBUG_DATA(level, data, datalen) \
-	do {								\
-		if ((rt_global_debug_component & (level)) == (level)) {	\
-			int i;						\
-			u8 *pdata = (u8 *)data;				\
-			pr_debug("RTL8192U: %s()\n", __func__);		\
-			for (i = 0; i < (int)(datalen); i++) {		\
-				printk("%2x ", pdata[i]);               \
-				if ((i+1)%16 == 0)			\
-					printk("\n");			\
-			}						\
-			printk("\n");					\
-		}							\
-	} while (0)
 #else
 #define RTL8192U_ASSERT(expr) do {} while (0)
-#define RT_DEBUG_DATA(level, data, datalen) do {} while (0)
 #endif /* RTL8169_DEBUG */
 
 /* Queue Select Value in TxDesc */
-- 
2.18.0

