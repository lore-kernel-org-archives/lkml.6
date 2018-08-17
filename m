Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F91C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340FF2151C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ukSle6HT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340FF2151C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbeHQKtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 06:49:49 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44896 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeHQKtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 06:49:49 -0400
Received: by mail-pl0-f66.google.com with SMTP id ba4-v6so3342914plb.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 00:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=SBBxOvMf9SGdC6StdljjQasXyXYJu14HOAXxGb2zPx0=;
        b=ukSle6HTgqgVIiQBUPUIQtfuuO4tuPGjkepv3oYCMZJnLJFVRPj7O9dVI+KAzYyW5V
         eXw0qUX3IA51Aeqqym/1//5k4uwGa73h6iQOelynDsWpjK/wcLLQNDdEfuTs7b3M4+0g
         Zoi6laJfX0CLUUHregAEHv1KaAWKKmbtg4uNPoiby/VjoIJMVbrx+OpUn11NlHTnfwsO
         27vI8yJRhsxZHUZPV/NyfLcV9AOJxxRPNwKOng69fktygH5hn61OyscNqD3DMYyutcJ+
         R0HSxS+z3u1Q2O7h1MXuBRGFDzAAcRUHaWLO3sQVXdUtP5daos6bjK4AKWW83szR2zjx
         vdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SBBxOvMf9SGdC6StdljjQasXyXYJu14HOAXxGb2zPx0=;
        b=afj3LKjCUtsC5S2DCKbL2wvC/hPCzasR0H+F+b8Zza3sWkriJQ7oxDmqNDbYHHTlD6
         qvcKrWek7JDEiIXCBqCQhDZKUj7QPFvSdGbbD+3KeDWCwFBqNd09JApsqtYTXM6g3vym
         GNWdb8fM+GBSOq3oIhqruAU87ZCrtBgQDQQiRSw3hLOWVlTnVnEEEN6Ls0dsk56mC6xd
         gmhVZUwWOLkaRunY9H0Am0Pl867Ea3hzv4t023SMlx2n3fmEpdPH6Tx30k18SYKJlWIH
         ZxcYeo6auradDiYcrS6WsNRXYvFgf2Bd2tIaJ544btXSy6wSnFgLyfjeYWOkFL4xkQDr
         qOGQ==
X-Gm-Message-State: AOUpUlEnLsZLvRB286JsatmeoVuBQz0hTPTrSo9dXjGZUbl0YEA8Nw4b
        xO4PJzBf0+jH09NuABELCZU=
X-Google-Smtp-Source: AA+uWPzdsxa7GRLYgaRncaS9X72KXJSfE8iXbL2w+LBbxXx9bS44WlJeh7jdDcIDQm6c1/K8GGxuAQ==
X-Received: by 2002:a17:902:7896:: with SMTP id q22-v6mr32402725pll.47.1534492048819;
        Fri, 17 Aug 2018 00:47:28 -0700 (PDT)
Received: from Gentoo-PC ([117.204.240.63])
        by smtp.gmail.com with ESMTPSA id l79-v6sm2733768pfb.111.2018.08.17.00.47.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Aug 2018 00:47:28 -0700 (PDT)
Date:   Fri, 17 Aug 2018 13:17:29 +0530
From:   Bhaskar Singh <bhaskar.kernel@gmail.com>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        bhaskar.kernel@gmail.com
Subject: [PATCH] staging: rtl8188eu: Removed code valid for 5GHz
Message-ID: <20180817074729.GA16204@Gentoo-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removed code which are valid for IEEE 802.11a i.e. 5GHz.

This is also mention in the TODO file.

Signed-off-by: Bhaskar Singh <bhaskar.kernel@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
index 7d5cbaf50f1c..3ce20f381827 100644
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
+	  /*  could be pure B, pure G, or B/G */
 		if (rtw_is_cckratesonly_included(rate))
 			return WIRELESS_11B;
 		else if (rtw_is_cckrates_included(rate))
 			return	WIRELESS_11BG;
 		else
 			return WIRELESS_11G;
-	}
 }
 
 u8 *rtw_set_fixed_ie(void *pbuf, unsigned int len, void *source,
-- 
2.16.4

