Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDA9C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 16:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F8D251B7
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 16:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vGD2qNK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F8D251B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755685AbeFXQFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 12:05:30 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33190 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755635AbeFXPk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:40:56 -0400
Received: by mail-wm0-f68.google.com with SMTP id z6-v6so10336450wma.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 08:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5Md8H7iNHuNRqlImkhk8J1WUS54KhEvm1X6fF3w1m4g=;
        b=vGD2qNK/PybbbtU6kUOEiA52rFYLrSvGQ8QUIziUK9788Jya4d4Q0KCPfJeq2Vac4P
         +rw19ogZNhp+GxAY8Y0ylWBk4qee08nsFqM11Mshs8sE/sW0e4jm5QCqVonJ0dj87CeG
         fC+bOzYnmEzL9Y4El+YtnHX6rorpYbbDPxnr5I0bm7qGHvye9YjLrrVgOENBOE6zKo6J
         Jc86v2wfYFScvEnLTTmIPaK+tn1m4qQcpgpq/8+LqIy8R5llqhyy2sATF2S0393+uv/3
         Hz4esdhW+mTGo+h2xYU2PSRAZOZYve53FQYegqvG4nq2BJObfaAJ/yBhX6Sh0LXKxSYc
         IuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5Md8H7iNHuNRqlImkhk8J1WUS54KhEvm1X6fF3w1m4g=;
        b=NyAtKxwzTB92CbYid3F0YUVrMzouKV2RKJYBv9pejLJMaFHlWRrCbCXp21KQ7DbRFg
         VsSrULsUyoN6AtNgToZVVgrCaWg6Y+Rwr7Pk/ZfSLRllAuVc1KDvLNXJzhsjBvv26oGq
         sGH8K34MftnWPP1RW3AuXfTqO/NNDIBwBO33I8iZJ68YWlbXD09k0ZUthBJoJBmQ982o
         oiLnVby8omhzMfP+um3hWVDD05plYbKVkfEbDB8fUcOByJmfqVwdHFEbOqbtyaoVTfzF
         CFXXvtzm5PqcF39d5Pj2Uq6LhaQ2lfndSjDZ+fixnZaGYIslzcdc4fyQNYvlijsChEn6
         KM0g==
X-Gm-Message-State: APt69E3fKmC0xmmjjSjbab93jQGMfpxgXemSDJRRD7hfMuMn6jM3/SYC
        pU/tXBPQIrNus5rpgA/Wm8zthd8t
X-Google-Smtp-Source: ADUXVKJ4DPsUzSe44oSn7/+dCxoz7Jf18YSj7hT/CW5KTK4JafnZ6kO6HP1dnWGNQFNLV09sbPdH0A==
X-Received: by 2002:a1c:e69d:: with SMTP id e29-v6mr3697210wmi.140.1529854854745;
        Sun, 24 Jun 2018 08:40:54 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id w12-v6sm2782920wrp.69.2018.06.24.08.40.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 08:40:53 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v3 2/8] staging: rtl8192u: Correct indentation of switch statement - Coding Style
Date:   Sun, 24 Jun 2018 16:40:21 +0100
Message-Id: <20180624154027.27654-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180624154027.27654-1-johnfwhitmore@gmail.com>
References: <20180624154027.27654-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed an extra indentation from the code of the various case options in a
switch statement.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/rtl819x_HTProc.c       | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 54c48747f5fa..4bfadb49c363 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -753,28 +753,28 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 	case IEEE_A:
 	case IEEE_B:
 	case IEEE_G:
-			//legacy rate routine handled at selectedrate
+		//legacy rate routine handled at selectedrate
 
-			//no MCS rate
-			for (i = 0; i <= 15; i++)
-				pOperateMCS[i] = 0;
-			break;
+		//no MCS rate
+		for (i = 0; i <= 15; i++)
+			pOperateMCS[i] = 0;
+		break;
 
 	case IEEE_N_24G:	//assume CCK rate ok
 	case IEEE_N_5G:
-			// Legacy part we only use 6, 5.5,2,1 for N_24G and 6 for N_5G.
-			// Legacy part shall be handled at SelectRateSet().
-
-			//HT part
-			// TODO: may be different if we have different number of antenna
-			pOperateMCS[0] &= RATE_ADPT_1SS_MASK;	//support MCS 0~7
-			pOperateMCS[1] &= RATE_ADPT_2SS_MASK;
-			pOperateMCS[3] &= RATE_ADPT_MCS32_MASK;
-			break;
+		// Legacy part we only use 6, 5.5,2,1 for N_24G and 6 for N_5G.
+		// Legacy part shall be handled at SelectRateSet().
+
+		//HT part
+		// TODO: may be different if we have different number of antenna
+		pOperateMCS[0] &= RATE_ADPT_1SS_MASK;	//support MCS 0~7
+		pOperateMCS[1] &= RATE_ADPT_2SS_MASK;
+		pOperateMCS[3] &= RATE_ADPT_MCS32_MASK;
+		break;
 
 	//should never reach here
 	default:
-			break;
+		break;
 	}
 
 	return true;
-- 
2.17.1

