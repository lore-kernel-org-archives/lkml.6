Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C49C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5903A2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QS5iLLQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5903A2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbeLEREE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:04:04 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32836 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbeLERDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:03:06 -0500
Received: by mail-wm1-f68.google.com with SMTP id r24so12227682wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 09:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bk8nNVekZI9AjQvGfZEA9xfq+U1PngaXCZ0EqdfByfY=;
        b=QS5iLLQljh11h3g3Sn4+sonasNgWtaM+mAqJUZUQXmkybpIHtaFW0HP+mR42wrrCVh
         E5z2Km1rrsR+XCRvfJICa+QvFPCxnyKB7EwX9ztzPy5+XWxplk1/FjdSqJUsBy16RIVy
         JC8YaR6q1n0sTza6i1nxzAvEdCca6RQOhSsdtuY/S2q/cPq6c5Jzd/H8oYhpF9Hapdhi
         ftxPbyW+Z2XaLYyvNQ1kxxAh+7QVLqRRxBJjrEMaA1BEBcNSx1PniGTpDoYw2JBmSir5
         3TOX+cfn5GKCs64vKE6bm7aBCIFmVMgK/TKO17fpUR/a48eZuSHyG9Le8P7nr+wmCqHB
         lFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bk8nNVekZI9AjQvGfZEA9xfq+U1PngaXCZ0EqdfByfY=;
        b=h4nNDal9BprBXVrYC/oeIvx07wFEt/CRMvuu6/3KZZXMJitSMfVpA5R60CeGechVJH
         oF+9gy940VqwbogrFj8iOtQVstoAO7cd00b7MXhLh1in2t18zxCz83nPQEyv5OuJDmDw
         i4kEfpJiSPaosI/aEbDt79UVhOK8NpD3oVSIRABDPdQ1+ItY75CIuuCEH8hM+rPTwG5F
         wWVj6epijrkWYDiYzPKSmkkgIKZoWFGK75J4FPyzH9PWptKVvYFvxfXH05ZJBX0wS9Z8
         Bqz/l9XIUoAODYH/TCMzKmaP188iJtiVnk/b6X2FXrB2r6rcTaJLFqtLXMLGzqyO7aP7
         wEzA==
X-Gm-Message-State: AA+aEWZJSKqPUoSGXcV5J9pnMK7nzt1DHIg2F2pQw0B6BRfF0ABf5SwP
        UtuyoCmz0ReY+w4BpiXyGLc=
X-Google-Smtp-Source: AFSGD/XSW1qXvHOAh9gh8IYmaXb4K/J3VoI3aOj6RhqzntnYFM2INi5GdzgLiFICZRoiaPsKIsKcCg==
X-Received: by 2002:a1c:5604:: with SMTP id k4mr16147525wmb.107.1544029384941;
        Wed, 05 Dec 2018 09:03:04 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id n127sm7949825wmd.20.2018.12.05.09.03.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 09:03:04 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 06/12] staging: rtl8188eu: cleanup block comment in rtw_wlan_util.c
Date:   Wed,  5 Dec 2018 18:02:41 +0100
Message-Id: <20181205170247.5401-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205170247.5401-1-straube.linux@gmail.com>
References: <20181205170247.5401-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup a block comment to clear a checkpatch warning.
WARNING: Block comments use * on subsequent lines

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index e61fc7ce65e8..956a331beda2 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -760,11 +760,11 @@ void HTOnAssocRsp(struct adapter *padapter)
 		return;
 	}
 
-	/* handle A-MPDU parameter field */
-	/*
-		AMPDU_para [1:0]:Max AMPDU Len => 0:8k , 1:16k, 2:32k, 3:64k
-		AMPDU_para [4:2]:Min MPDU Start Spacing
-	*/
+	/* handle A-MPDU parameter field
+	 *
+	 * AMPDU_para [1:0]:Max AMPDU Len => 0:8k , 1:16k, 2:32k, 3:64k
+	 * AMPDU_para [4:2]:Min MPDU Start Spacing
+	 */
 	max_AMPDU_len = pmlmeinfo->HT_caps.ampdu_params_info & 0x03;
 
 	min_MPDU_spacing = (pmlmeinfo->HT_caps.ampdu_params_info & 0x1c) >> 2;
-- 
2.19.2

