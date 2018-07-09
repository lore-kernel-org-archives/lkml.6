Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473DBC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F111E20852
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fm+r5i6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F111E20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754564AbeGINuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:50:52 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41324 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbeGINuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:50:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id b12-v6so13992338edt.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 06:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Znkf/qnqvDbB/uWgIjerhWmOx7IhjCXkf43KdgUKkZY=;
        b=Fm+r5i6wEpAljvqfaIFsSOEcIE2mOE3ci9W6c0jfaBVhnsp3V8ZKwiW8bNbvqsevTq
         9OXuSTrXZRJ77wOzYzOVjvS99nUlatoYxVYaj2RTWmSjnav6Wxx5lyPJwTaQ0c6UCl3/
         73KGMx75Xa5tIDziwTcniLLuYbG1rXk0F8I5kan/X23zVNuB0LXgxMF74u8mcZW30YzC
         vhLBGroSy+QqXF/e2U/NTS069sOM1LNICzifH8Rfm54PL7GutKjDiPCe9coOTkSidLU1
         9lcKiCk+QHTjTA/KGQavfN4/V5b5XwzZpRwT4PAn93yZMabh2tmCbbkBTnxFtGrWD+fX
         glNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Znkf/qnqvDbB/uWgIjerhWmOx7IhjCXkf43KdgUKkZY=;
        b=Sr8JLf9KFZ/J8uD0ZlzN5upLSdhJAf6FrWEazSuY3j8bxeFYVy17oRi8gvUyBmR34b
         ZXySrFAqiaAmT1IxT1GiQLU+qA1ZNCFOwdQysQAio1LWb9Ov0QCuQ3jpe64ca+8tf6xY
         7Ph45SSXNQiZcLtWI3KGLMob8w44DMyMKseNcUHQdAQbfosY2uBL2KEDB2w84lf9BwtQ
         PElUr2xz0wbBkP1l37fPwUAt6iU6krQNihjf7i5Pu4qm4TVcUndXQk3e4l/bBq0XNE5Z
         ymd2e6cApG/U6e0fceHsNk0SWS13ru6xypPc9aOpXNpTT+lifhj6PsmvsjYc3wssFDq7
         Zv5Q==
X-Gm-Message-State: APt69E0wSSuXpdQYxdoW6Iqyn2rfJ7Fd0LTPX0ZbNXQ9tkDSXEIlSVnc
        PYxBcYxdGQiSuqeQwmKjhuY=
X-Google-Smtp-Source: AAOMgpfkW4ZJXgEYoOBY4lE2NlYGxxL5lqoFyxHezovoHQhPMJPek8AAzhzQKecwz3XRZPiwFzTHjw==
X-Received: by 2002:a50:8327:: with SMTP id 36-v6mr2557685edh.305.1531144249521;
        Mon, 09 Jul 2018 06:50:49 -0700 (PDT)
Received: from arch.localdomain (x590ca8ad.dyn.telefonica.de. [89.12.168.173])
        by smtp.gmail.com with ESMTPSA id i34-v6sm6958168edc.29.2018.07.09.06.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 06:50:49 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8723bs: use mac_pton()
Date:   Mon,  9 Jul 2018 15:50:39 +0200
Message-Id: <20180709135039.9373-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use mac_pton() instead of custom approach.
Remove the now unused hex2num_i() and hwaddr_aton_i().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 41 +------------------
 1 file changed, 1 insertion(+), 40 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 7dd9521fedfb..ceb2b10fa0b2 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -39,44 +39,6 @@ static const char * const iw_operation_mode[] = {
 	"Auto", "Ad-Hoc", "Managed",  "Master", "Repeater", "Secondary", "Monitor"
 };
 
-static int hex2num_i(char c)
-{
-	if (c >= '0' && c <= '9')
-		return c - '0';
-	if (c >= 'a' && c <= 'f')
-		return c - 'a' + 10;
-	if (c >= 'A' && c <= 'F')
-		return c - 'A' + 10;
-	return -1;
-}
-
-/**
- * hwaddr_aton - Convert ASCII string to MAC address
- * @txt: MAC address as a string (e.g., "00:11:22:33:44:55")
- * @addr: Buffer for the MAC address (ETH_ALEN = 6 bytes)
- * Returns: 0 on success, -1 on failure (e.g., string not a MAC address)
- */
-static int hwaddr_aton_i(const char *txt, u8 *addr)
-{
-	int i;
-
-	for (i = 0; i < 6; i++) {
-		int a, b;
-
-		a = hex2num_i(*txt++);
-		if (a < 0)
-			return -1;
-		b = hex2num_i(*txt++);
-		if (b < 0)
-			return -1;
-		*addr++ = (a << 4) | b;
-		if (i < 5 && *txt++ != ':')
-			return -1;
-	}
-
-	return 0;
-}
-
 void indicate_wx_scan_complete_event(struct adapter *padapter)
 {
 	union iwreq_data wrqu;
@@ -2567,8 +2529,7 @@ static int rtw_get_ap_info(struct net_device *dev,
 
 		pnetwork = LIST_CONTAINOR(plist, struct wlan_network, list);
 
-		/* if (hwaddr_aton_i(pdata->pointer, bssid)) */
-		if (hwaddr_aton_i(data, bssid)) {
+		if (!mac_pton(data, bssid)) {
 			DBG_871X("Invalid BSSID '%s'.\n", (u8 *)data);
 			spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
 			return -EINVAL;
-- 
2.18.0

