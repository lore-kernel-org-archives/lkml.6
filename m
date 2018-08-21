Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2031EC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF19921770
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXroVWRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF19921770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbeHUEyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 00:54:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35354 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeHUEyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 00:54:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id z4-v6so2673655pgv.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 18:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Ky5QxZNlGnZ9hIbxzcjyo3a1Sr0fJd2TrN0ioRUyJFY=;
        b=BXroVWRXThF0rwx2Zq0M9v8H+BHE3OwHQuMqIwGZ4wCoLzAqUDg9Dgmwl7KO36j5nQ
         Xec0h/YoVcuvczQV0yEQfSn2ihYx/qfeQeaanNPr4bkLutZ+QNavX6IyU/OHCJkk9PfG
         nX1fTMmeleRdXIKD53Y5ykVSfy0ruDJzLnzKfdL9Mx1fcc6xiXB4rbn6NTAa+E3d8bZ7
         3ZfG3tB6h7kPoPPeTIcRbgzVR2jFkBwpuWsHzvTzZqOGYptrjqRWPUMSQ+Fepo+58sXA
         o391IVZPqevJ2DKlrH1ycSdFSxhHbGMrG2sJGFopOyQ66bMJHbnAkSrboIOOvDqi2G4Y
         fQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Ky5QxZNlGnZ9hIbxzcjyo3a1Sr0fJd2TrN0ioRUyJFY=;
        b=Ub2cLxBnfRy1FdOVX8ERNfsXg+ZFfy3KfZNs65A0quwyRL4CFTEzxlMJoItjdeBGyU
         dqmtyuB1429qTOk3l74vzVGBh+QxSJcnJZKNSRlSEhcCgCTq2aHlDZTCxbr+sp2T3EZd
         zKvDUdP+qzVRTaHAArZMMCJN50aLBgZ8eEGR7EEOJosD/1XuYY+8O53j4sgKeDhfirpL
         zxp336wBYB/KKAQW0nj71AFO4RlEA1p+WsylMgYfCPwl0Aw1co20dQUUagTcGoXW3HBZ
         bAgD9t2CHEU9amQ1eQ0XxwsjrzruxkvWSxCQ8SidrhHhXc0LxsVusRQSciG0hHGXE4u9
         1gHQ==
X-Gm-Message-State: AOUpUlE2KM1kGCFHptQxH/ytne7PZHRTdKDa8EGl1YBGsjDNPLpKhElB
        355JcidIh32v7r06XJU9oCw=
X-Google-Smtp-Source: AA+uWPzrs/TLr/0h/FeOO/+B5u2pHtR/Fw2PRnID6axAyN7tfBeciK4aildtuXMUw5uDvGK2TN/sWQ==
X-Received: by 2002:a63:d20e:: with SMTP id a14-v6mr45157551pgg.226.1534815361878;
        Mon, 20 Aug 2018 18:36:01 -0700 (PDT)
Received: from Gentoo-PC ([117.204.240.63])
        by smtp.gmail.com with ESMTPSA id 16-v6sm17961930pfp.6.2018.08.20.18.36.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 Aug 2018 18:36:01 -0700 (PDT)
Date:   Tue, 21 Aug 2018 07:06:03 +0530
From:   Bhaskar Singh <bhaskar.kernel@gmail.com>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        bhaskar.kernel@gmail.com, dan.carpenter@oracle.com
Subject: [PATCH v2] staging: rtl8188eu: Removed code valid for 5GHz
Message-ID: <20180821013603.GA7589@Gentoo-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes support for channels > 14. That is from the TODO which
says:

	-find and remove remaining code valid only for 5HGz. Most of
	obvious ones have been removed, but things like channel > 14 still
	exist.

Signed-off-by: Bhaskar Singh <bhaskar.kernel@gmail.com>
---

Changes in v2:
- Make the commit message more clearer.
- Rectify indentation as per Linux kernel coding style.
---
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
index 7d5cbaf50f1c..9e5c7e62d26f 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
@@ -100,19 +100,13 @@ bool rtw_is_cckratesonly_included(u8 *rate)
 
 int rtw_check_network_type(unsigned char *rate, int ratelen, int channel)
 {
-	if (channel > 14) {
-		if (rtw_is_cckrates_included(rate))
-			return WIRELESS_INVALID;
-		else
-			return WIRELESS_11A;
-	} else {  /*  could be pure B, pure G, or B/G */
-		if (rtw_is_cckratesonly_included(rate))
-			return WIRELESS_11B;
-		else if (rtw_is_cckrates_included(rate))
-			return	WIRELESS_11BG;
-		else
-			return WIRELESS_11G;
-	}
+	/*  could be pure B, pure G, or B/G */
+	if (rtw_is_cckratesonly_included(rate))
+		return WIRELESS_11B;
+	else if (rtw_is_cckrates_included(rate))
+		return	WIRELESS_11BG;
+	else
+		return WIRELESS_11G;
 }
 
 u8 *rtw_set_fixed_ie(void *pbuf, unsigned int len, void *source,
-- 
2.16.4

