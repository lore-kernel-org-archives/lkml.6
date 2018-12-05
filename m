Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A50C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BF320892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdVkJdAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BF320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbeLERDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:03:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46723 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbeLERDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:03:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so20453422wrt.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 09:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5LTEPkcdVnTAqu65MYYOLnK3h5SVxK49vkPbhiWIePU=;
        b=FdVkJdAIF3w3cKRacaZMVvE6QSmDB6jy4Gq5E8rrXYcPMvjdKSKIEvzI79KtIBZb3b
         MU+l9CFOgZKDrugc6WUMsOlE2u42Zfz5pszOFDWOpu2yrepQZspeondrG/dYNL5hZ6D9
         BLt/K4VxUwT0oTdFIjYH2xpgcN+ygvgoI+HIGBUF3X4WKmd9xcsmu+c6BDXpVzNlYzn5
         eStzI+qx/fY3SUDmwWSqFMHwIZLC8ZjqUGX40m6s9kDvpt2Zvzy1t/YugRm2s2zuk9R5
         2/+IJxsCE+97HUN6CeJUtNjzWzIgyJbsUKfsqm6NwJbqT3WF6YUclD/uj8weSkFqtPgB
         3z9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5LTEPkcdVnTAqu65MYYOLnK3h5SVxK49vkPbhiWIePU=;
        b=Vg3HGcf5/EcAuRlmIa2tcdFVJGNx0t3v8tHlMg99XQBs0IV8j/vl2Zms/bLUH7QeKI
         BxbJOaH/qsegjJQdLDqtGC96qLOf7tzcdFMSkwtTgJ1rSw38mzFeOio8D665O3VYkm//
         hlJVjc9p/25JBx1oecKd73+nx7V5LyzzfujoWmpHjj9vDZ45P1Ds6T5AFc58Pu+r1SYj
         UUgVkrE5SpWiZ5M/h5TBGEmhOhiyD1uOKl6AC6GZqz5xhxVil/fMcKpqW4JrvHpyFwxp
         AAkfopRnB11i0UuKZZj/XH6nGv9m4kCe48UlX/YtmLqsgPXjSng0vsCT0gOg+mwE52gn
         EiLg==
X-Gm-Message-State: AA+aEWY/K9ojNbWVlRpNtd/ELMK6cRek9YmNsrIgEEME2WDzc9pan2xJ
        Y7xeoJrw0ZmdaUrchI3jEnk=
X-Google-Smtp-Source: AFSGD/WwDBP6N2LsLVQdYg1/XjhlZRrrtVnqLHJjsXdZbRvgfsDabc5l/cSCpm1xK7IVDwEeDS39iA==
X-Received: by 2002:a5d:4b01:: with SMTP id v1mr21578420wrq.5.1544029388860;
        Wed, 05 Dec 2018 09:03:08 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id n127sm7949825wmd.20.2018.12.05.09.03.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 09:03:08 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 10/12] staging: rtl8188eu: correct indentation in update_wireless_mode()
Date:   Wed,  5 Dec 2018 18:02:45 +0100
Message-Id: <20181205170247.5401-10-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205170247.5401-1-straube.linux@gmail.com>
References: <20181205170247.5401-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct indentation in update_wireless_mode() to clear a checkpatch
warning. WARNING: Statements should start on a tabstop

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 7af3dd910c93..42b9974fab8a 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -1442,7 +1442,7 @@ void update_wireless_mode(struct adapter *padapter)
 
 	if (pmlmeext->cur_wireless_mode & WIRELESS_11B)
 		update_mgnt_tx_rate(padapter, IEEE80211_CCK_RATE_1MB);
-	 else
+	else
 		update_mgnt_tx_rate(padapter, IEEE80211_OFDM_RATE_6MB);
 }
 
-- 
2.19.2

