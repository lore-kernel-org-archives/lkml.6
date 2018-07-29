Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E07C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 17:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4AD620857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 17:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMtxXC5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4AD620857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbeG2Ske (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 14:40:34 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37743 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbeG2Skc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 14:40:32 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11-v6so11020742wmc.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 10:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p/mqgId/OJ5eG38015tRYnXFdGCIzpiPT2AHLzMUc2w=;
        b=ZMtxXC5N9rTXsWY4WB27DuyCs0hJTir/iZzA3WPVEw3cHhmTr5IoKRinQWuZ8bJCtP
         mRvG5IXEtYBofzKWeTA+ImWsXFuXEpx8oksDAyoy1f5bInOxNMQ4T/LUm5n7utNdoEwC
         lxc+HKZ+Q8LLcaJuGwCCyISue3MnQE9IJxY8BAcReNeugmG011eWfwHZvz8qpm7XdIDj
         j4DrmaqHfuON18QVjUCGCt0DGCJi7hD4Qxm0sI/W8OQfX6ZrK1a/1FPPAR8WfEi5kOZ9
         IH7K9O2i2gqSeGh0aukbUlBavfvFaj1wkjSDUj8l2F0Gt/4DMK7fj8+a0OVh5y3XJLyO
         jD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p/mqgId/OJ5eG38015tRYnXFdGCIzpiPT2AHLzMUc2w=;
        b=OTasdMIFEkkqPJaOaHI8fQP3AX0j7ti6r0WsV81lulCx/mM5U8GF770HN6WzjF7MiP
         E3wdjfKq4EcO5GYMgdwlD542wXglmSh1ZWmztjxxD7O553aU31n1tGrDr7qRep04+x62
         ZHQfkm8Zaf5WOlNbNqpTovwHDRDaVSVHRYa+HZvTQYvKwzAMsDu5IZiUXyaip4sCLnh9
         JPtEcpGnRa4fWdcIWb/LwaOXN/xNOhwM7lpfofX9BgLOJMOLwQfZbtGTUWv3Q65sHPFF
         iZblEEn1bsyPVJf1g+4isICxp+VSZIaSR/JubHnlMy/PkecMYJrX3Aj/Mui7J9zUGjAH
         S52g==
X-Gm-Message-State: AOUpUlGQFBEIgllNLEhygwljBtg8VuSn66mJOX8+KhwjLeX9BpecS9Kw
        42W+qWvzyGdWBqQo158H8+Ac1dCX
X-Google-Smtp-Source: AAOMgpc8/GVbmmj5XYAkTNjUo+SJqKfrqcmW/XQQNws4fm1gCxh4w+xbFGFPeIxUxkGQc0uTRGloeg==
X-Received: by 2002:a1c:3314:: with SMTP id z20-v6mr11552156wmz.95.1532884165768;
        Sun, 29 Jul 2018 10:09:25 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id v1-v6sm19916360wrs.34.2018.07.29.10.09.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 10:09:25 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 8/8] staging: rtl8188eu: use is_broadcast_ether_addr
Date:   Sun, 29 Jul 2018 19:08:51 +0200
Message-Id: <20180729170851.2581-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729170851.2581-1-straube.linux@gmail.com>
References: <20180729170851.2581-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use is_broadcast_ether_addr instead of checking each byte of the
address array for 0xff. Shortens the code and improves readability.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8188eu/os_dep/ioctl_linux.c    | 34 ++++++-------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index 221fae22bab6..4a8124570e6e 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -361,9 +361,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 		goto exit;
 	}
 
-	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
-	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
-	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff) {
+	if (is_broadcast_ether_addr(param->sta_addr)) {
 		if (param->u.crypt.idx >= WEP_KEYS) {
 			ret = -EINVAL;
 			goto exit;
@@ -2208,9 +2206,7 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 		ret =  -EINVAL;
 		goto exit;
 	}
-	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
-	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
-	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff) {
+	if (is_broadcast_ether_addr(param->sta_addr)) {
 		if (param->u.crypt.idx >= WEP_KEYS) {
 			ret = -EINVAL;
 			goto exit;
@@ -2471,9 +2467,7 @@ static int rtw_add_sta(struct net_device *dev, struct ieee_param *param)
 	if (!check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)))
 		return -EINVAL;
 
-	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
-	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
-	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff)
+	if (is_broadcast_ether_addr(param->sta_addr))
 		return -EINVAL;
 
 	psta = rtw_get_stainfo(pstapriv, param->sta_addr);
@@ -2528,9 +2522,7 @@ static int rtw_del_sta(struct net_device *dev, struct ieee_param *param)
 	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true)
 		return -EINVAL;
 
-	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
-	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
-	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff)
+	if (is_broadcast_ether_addr(param->sta_addr))
 		return -EINVAL;
 
 	psta = rtw_get_stainfo(pstapriv, param->sta_addr);
@@ -2566,9 +2558,7 @@ static int rtw_ioctl_get_sta_data(struct net_device *dev, struct ieee_param *par
 	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true)
 		return -EINVAL;
 
-	if (param_ex->sta_addr[0] == 0xff && param_ex->sta_addr[1] == 0xff &&
-	    param_ex->sta_addr[2] == 0xff && param_ex->sta_addr[3] == 0xff &&
-	    param_ex->sta_addr[4] == 0xff && param_ex->sta_addr[5] == 0xff)
+	if (is_broadcast_ether_addr(param_ex->sta_addr))
 		return -EINVAL;
 
 	psta = rtw_get_stainfo(pstapriv, param_ex->sta_addr);
@@ -2622,9 +2612,7 @@ static int rtw_get_sta_wpaie(struct net_device *dev, struct ieee_param *param)
 	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true)
 		return -EINVAL;
 
-	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
-	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
-	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff)
+	if (is_broadcast_ether_addr(param->sta_addr))
 		return -EINVAL;
 
 	psta = rtw_get_stainfo(pstapriv, param->sta_addr);
@@ -2779,10 +2767,9 @@ static int rtw_ioctl_acl_remove_sta(struct net_device *dev, struct ieee_param *p
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
 		return -EINVAL;
 
-	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
-	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
-	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff)
+	if (is_broadcast_ether_addr(param->sta_addr))
 		return -EINVAL;
+
 	return rtw_acl_remove_sta(padapter, param->sta_addr);
 }
 
@@ -2794,10 +2781,9 @@ static int rtw_ioctl_acl_add_sta(struct net_device *dev, struct ieee_param *para
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
 		return -EINVAL;
 
-	if (param->sta_addr[0] == 0xff && param->sta_addr[1] == 0xff &&
-	    param->sta_addr[2] == 0xff && param->sta_addr[3] == 0xff &&
-	    param->sta_addr[4] == 0xff && param->sta_addr[5] == 0xff)
+	if (is_broadcast_ether_addr(param->sta_addr))
 		return -EINVAL;
+
 	return rtw_acl_add_sta(padapter, param->sta_addr);
 }
 
-- 
2.18.0

