Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5D1C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D8120862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1uQO5Ov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D8120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbeICWqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:46:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54782 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeICWqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:46:20 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so1994917wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 11:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MB06zeQ68BjbkZh186seByYWf+LaSderwY8FRwdwOlo=;
        b=b1uQO5OvKBwgjXf6eBHCNCTXVrtv4J8iSdDQD6SKXiVSMDPcfEzaSo3ijN2KscZZHD
         pIqujA8gYdzz+TctC0mMz3XIHOZnOYl3DEAH6btNEblFcsPZNxpEPX+dxYS4QT4FAgA+
         BA2nIUOyBHb4wQ7gKn9gEZvOezNquD5Wcln5xEfUxry8cyX7DxDwalFhBxDRdHvOyXYn
         5RnQwCosG5Cj50iiDIJkIwgNer2da/+KEZxgoj7526JiW49DAx7Ob6LrGhX4oHq+N2ek
         A73IzpeNG4anUZd3LGxu9TwxIR8BTUhU4rtDJRyz0+2B6z9TWzYivn7fp8at+UJfbLDp
         At0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MB06zeQ68BjbkZh186seByYWf+LaSderwY8FRwdwOlo=;
        b=XhmIOr6cpf/tWrcWZrbNjumxwMOPh0nHPHeJ77fTAEGDERwL5WdgilrM2uxGg/lCyg
         pfyVb0rhdhTFpjTm719BJHSE3cd30ZxI3BlyvtYdfT8R/68mU5sHaR4cxfdR0AxhGtik
         Wmbx6ZTke4i5Q97xnwB1UZvTDZBIF4ZJiJPyEpoMUucvEwiog8eByqu/zALVivzeMKhV
         xOa9dF7aKJA16u7aGln7XlE0cgKEe9M/F/sKZRuKvmfZYA6hwTETPhT11OwETtJKGW9y
         xnfpckGSX03IJnU0CuhUq+WmNHM1PVn8xWC3lox3NpUK7BEUsqg+tTHPCPJIkKQ3BfWa
         fW3Q==
X-Gm-Message-State: APzg51BZ2FYbzg2kpb9QJ/KMTqh71p4q0yptYzON8ZLftYAw/FFEABU/
        LgEPUd8mRXOWkriRHHrBPy1jqaYi
X-Google-Smtp-Source: ANB0VdYVYguBCZnkB2Vd2MyPtVNyWr4MYoa97FKe7yF+s4A4RVWxxfWovRUpAwHEotG6zxz2GcUSUQ==
X-Received: by 2002:a1c:3:: with SMTP id 3-v6mr5317351wma.99.1535999095809;
        Mon, 03 Sep 2018 11:24:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id v46-v6sm24201349wrc.63.2018.09.03.11.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 11:24:55 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/4] staging: rtl8188eu: Remove code valid only for 5 GHz
Date:   Mon,  3 Sep 2018 20:24:42 +0200
Message-Id: <20180903182445.1969-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove code that is only valid for channels > 14.
This addresses the below TODO item.

- find and remove remaining code valid only for 5 GHz. Most of the obvious
  ones have been removed, but things like channel > 14 still exist.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8188eu/core/rtw_wlan_util.c    | 47 +++++++------------
 1 file changed, 17 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index b9406583e501..8f87db11f87e 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -110,22 +110,16 @@ u8 judge_network_type(struct adapter *padapter, unsigned char *rate, int ratelen
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
 
-	if (pmlmeext->cur_channel > 14) {
-		if (pmlmeinfo->HT_enable)
-			network_type = WIRELESS_11_5N;
+	if (pmlmeinfo->HT_enable)
+		network_type = WIRELESS_11_24N;
+
+	if ((cckratesonly_included(rate, ratelen)) == true)
+		network_type |= WIRELESS_11B;
+	else if ((cckrates_included(rate, ratelen)) == true)
+		network_type |= WIRELESS_11BG;
+	else
+		network_type |= WIRELESS_11G;
 
-		network_type |= WIRELESS_11A;
-	} else {
-		if (pmlmeinfo->HT_enable)
-			network_type = WIRELESS_11_24N;
-
-		if ((cckratesonly_included(rate, ratelen)) == true)
-			network_type |= WIRELESS_11B;
-		else if ((cckrates_included(rate, ratelen)) == true)
-			network_type |= WIRELESS_11BG;
-		else
-			network_type |= WIRELESS_11G;
-	}
 	return	network_type;
 }
 
@@ -1429,22 +1423,15 @@ void update_wireless_mode(struct adapter *padapter)
 	if ((pmlmeinfo->HT_info_enable) && (pmlmeinfo->HT_caps_enable))
 		pmlmeinfo->HT_enable = 1;
 
-	if (pmlmeext->cur_channel > 14) {
-		if (pmlmeinfo->HT_enable)
-			network_type = WIRELESS_11_5N;
+	if (pmlmeinfo->HT_enable)
+		network_type = WIRELESS_11_24N;
 
-		network_type |= WIRELESS_11A;
-	} else {
-		if (pmlmeinfo->HT_enable)
-			network_type = WIRELESS_11_24N;
-
-		if ((cckratesonly_included(rate, ratelen)) == true)
-			network_type |= WIRELESS_11B;
-		else if ((cckrates_included(rate, ratelen)) == true)
-			network_type |= WIRELESS_11BG;
-		else
-			network_type |= WIRELESS_11G;
-	}
+	if ((cckratesonly_included(rate, ratelen)) == true)
+		network_type |= WIRELESS_11B;
+	else if ((cckrates_included(rate, ratelen)) == true)
+		network_type |= WIRELESS_11BG;
+	else
+		network_type |= WIRELESS_11G;
 
 	pmlmeext->cur_wireless_mode = network_type & padapter->registrypriv.wireless_mode;
 
-- 
2.18.0

