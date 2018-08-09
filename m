Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BDCC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518C821AA7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Da9UJSk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518C821AA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732669AbeHIT1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:27:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40884 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730419AbeHIT1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:27:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id h15-v6so5752515wrs.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 10:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xOXiqYEqP6UlZAJdXnjMY9VCMLzIFKoOEKYMMIJPKb8=;
        b=Da9UJSk5bTAPXJJDSNXP2zMtPLu9GbkxOHMJCdPcrs64zAx55OEfCyBT6/SPNC2J6n
         rsZ/06QtKR/+T8qoFp50QRrLCNG88Cmdey2vNJi8IUHrYiBCx6xBlyVr2zoQ182/QXVp
         1XSzWe8d0fO5Lw3XOKDBt6WM+yYw0LSR7KSX0kTpH6HsaOnhP0zCnjN4LDDFQq/qkg+e
         Eddz4PJMlKoB03+RYqNxYtzAGyoYYbOTya+/YE+viF4OPqDgPKVE5ZmfyqQE3W8Q2yXD
         BtmQCHEkVAYN/M5llrLQlBWMGcC/JJmFe7ur9Ngg4CW9NVWqRi1GH2aCsbMZgGcXBsOC
         TQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xOXiqYEqP6UlZAJdXnjMY9VCMLzIFKoOEKYMMIJPKb8=;
        b=IwqBaCUx8B3FokojaLJHDdQQwLyPiEkOmjHVRqGPWOXgHoO7GQTaKt/xL2JRPJuP4s
         PiEzevQnYqys/7s2a8Lb0GJ3WnKbb2ZAO4jR8Z7SX1fjlFoZedCfamC3B11FmYd2iJXu
         yBwZ5hq8oj3VC6dpe5wwJZzZZpv20pBFJis5Z37pU/B6LWqUNcxZFY+ZEauy3ZSfNKCG
         eruMaKFh0U2N0irR8vnKhioz94XWSosMORv+rtGg0fPFaPmzDZ2b4HkF0rGBq5/IAhd1
         avm+12+t1Ck2ekz0urMNOHtOh6IaTtDE6cjFDxpVlq7uHThLlkjN+y6Zx9xan0E8heR3
         0wBA==
X-Gm-Message-State: AOUpUlFn2BZGCWyRnI0C72Xg9INUJp4ThaBJEIPf9OZHlpQRa0SXzy5N
        aib4lC8+QKDBxCmPBDkjoG8=
X-Google-Smtp-Source: AA+uWPw0is9o6im1aHwefMDcW+ysNdyQUwYY27zKtvD30HxM2TeTAl39QR/Q/QSBM3hM5+9uhk+pfA==
X-Received: by 2002:a5d:51cf:: with SMTP id n15-v6mr1963205wrv.107.1533834112180;
        Thu, 09 Aug 2018 10:01:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id b6-v6sm10389440wru.66.2018.08.09.10.01.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 10:01:51 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/5] staging: rtl8188eu: remove unused IS_MCAST
Date:   Thu,  9 Aug 2018 19:01:30 +0200
Message-Id: <20180809170131.29279-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809170131.29279-1-straube.linux@gmail.com>
References: <20180809170131.29279-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the now unused IS_MCAST.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/include/wifi.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/wifi.h b/drivers/staging/rtl8188eu/include/wifi.h
index 4a56e54e38f6..0a952edf8a81 100644
--- a/drivers/staging/rtl8188eu/include/wifi.h
+++ b/drivers/staging/rtl8188eu/include/wifi.h
@@ -257,14 +257,6 @@ enum WIFI_REG_DOMAIN {
 
 #define GetAddr4Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 24))
 
-static inline int IS_MCAST(unsigned char *da)
-{
-	if ((*da) & 0x01)
-		return true;
-	else
-		return false;
-}
-
 static inline unsigned char *get_da(unsigned char *pframe)
 {
 	unsigned char	*da;
-- 
2.18.0

