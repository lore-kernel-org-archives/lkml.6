Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9220DC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A46F20645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q34XbAXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A46F20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbeLESbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:31:22 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38493 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeLESbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:31:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so20723699wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 10:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6nbnJvAi8MiAFv+idmpPrgbmyBaPbkigzPuXBzF1Rw4=;
        b=q34XbAXCMjQT4vNaVTYWnITlB8/otdM8nie70w5sQj+j/Tj1q5dF11s6sEabK6POJd
         owbLVNxQwaPVzUuxET1LdtfiomnYzKDzB9HsETlhZZwmaCsPAyd/7w9LfRKMQUYK0LGq
         X0OMdAgDFXLyJltrBJrKIBKvQv6TMopXScjC3/Z2NwPk4+W1xJP80rEpEb40nfFwWAYU
         vZNGYApL3vvGhoSpWwYIqO/0HdavzXlyl/+2Q1ny1ZSfhtniF9J9wCxZmQGjLhjBF3VB
         SLkW8NdJUNjDG8MPBv7tV+zcSW/TtZbFcuxAgSDaaNCsazr3ZJKdyotFt/YunOoEcvqB
         TRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6nbnJvAi8MiAFv+idmpPrgbmyBaPbkigzPuXBzF1Rw4=;
        b=RxAApSpwY7h1S7K/n7X35UHZ8rM8PwZN8os9AnIZW+GtJ7ty5Cnu7UoH9cuTRv+SVC
         iAKxyGEGlbK5ZyVRfrZdT9QwcqReJeeBvPW/BaKXvTzfydCBZkxoMhhGR9pKmI4NYE4w
         avYZLTqJGilC0+pWqGM39j/5KsWNk9gjYuiJQy7qFEM4479W3pSV6xTGIrAMF/m5666a
         WL8rvPtajeZHCX0GLKzIZmZZj+BldG6ANB2NYSiB4yBt8EtJHTRHqfZc4Xc5xZF/ZNmG
         8RVSw3l3NTO97bjWhbsZ2P2peg81xaunOzBPhYiBedF7sbwcMqlow77YIpA9WJ8VjsXG
         6jRg==
X-Gm-Message-State: AA+aEWZfojumWOmVNxYQwgysD8tUwnYLCWY6pdg+iRhUuFwTgQ+Qa7p4
        cdSakiPzs2AlwN1l2z20Z8o=
X-Google-Smtp-Source: AFSGD/WnveOZpuMOHDDQqBT4PI28rV+sd5B30zB3f8ye7+M/N2ZoZG9WP1AGEd9biSEaqu0mJQK5MA==
X-Received: by 2002:adf:e911:: with SMTP id f17mr24064724wrm.126.1544034676445;
        Wed, 05 Dec 2018 10:31:16 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id a18sm27860998wrp.13.2018.12.05.10.31.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 10:31:15 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 03/12] staging: rtl8188eu: simplify array initializations
Date:   Wed,  5 Dec 2018 19:30:51 +0100
Message-Id: <20181205183100.16828-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205183100.16828-1-straube.linux@gmail.com>
References: <20181205183100.16828-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplfy initialization of arrays with zero only values
to improve readability and save a line.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index fac1c1c20b2f..76c7010c3a5c 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -455,9 +455,8 @@ void write_cam(struct adapter *padapter, u8 entry, u16 ctrl, u8 *mac, u8 *key)
 
 void clear_cam_entry(struct adapter *padapter, u8 entry)
 {
-	u8 null_sta[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
-	u8 null_key[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-			 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
+	u8 null_sta[ETH_ALEN] = {};
+	u8 null_key[16] = {};
 
 	write_cam(padapter, entry, 0, null_sta, null_key);
 }
-- 
2.19.2

