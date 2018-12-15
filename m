Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83091C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB4F2080F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SV0dUkfc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeLOQqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 11:46:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39318 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbeLOQqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 11:46:31 -0500
Received: by mail-wm1-f67.google.com with SMTP id f81so8609025wmd.4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 08:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vEfWUpT9cIBwVyzYLcN+unBDZ/0dXe3jcxcWZpF4cVY=;
        b=SV0dUkfcvO1ku1yZhUonrgL+y2Aq2ercA2h0ZBmdp0jrET8PJvWMhZmE7hpZFc8Gqx
         ScVll9OLFEqBjw3yvmXd+aSlXI4jSjJc16bVfvybohuXrtxxg5GAOil3sD7uSCj2FH71
         ObFLjiH8mH/Z4fqd0iaKX6DaGlQWEtsy6OXBY5DtXwSb996lh4HIh6rSdW+vK9K993sZ
         3wrssYxmDpHdhYPbAo3ooFmOpinBk55e3aHW8JEZe6NiRWvx5SlVc0DgXyimIFQmmkO0
         44Ig215vdDqnijB0/eVi8wulP1tLvyY6fx+94tebrWb3jmJuxbP0NElrpV7vkYWE+deV
         AftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vEfWUpT9cIBwVyzYLcN+unBDZ/0dXe3jcxcWZpF4cVY=;
        b=XW0oWVy+urEKltv8pNFu4F7BgBzsgO/490RiZPRCJlLRz8MPF+pi2Y71ZVbl2OiX3f
         t9XKymbH9WYgW3DN6jywn5vPKp42AHPPNH7jqC5yBcrhnk2+4hkgF30stiA1SrzzUtQb
         zFLZMf8OdBd/ygCmaVj3ki5UcSxz0ZIGOZMe9xRFWR8eOXiirHCHLXb6A29/TmfRdGdV
         Tb/bzEv7ESbNoWr/Z6JN9V+xEuqnbTK/uDcy1of5oLXhA7IBPJdRB/vBlSSxZ7ZCM1Hx
         vnB5ApXCg+X1xMtSv4Ym6tdb/OHzknwhgIxGNhPVOpXCkTUDtQsQlyXwNoOCLpsxSg2q
         H64w==
X-Gm-Message-State: AA+aEWbMLFdQoZFyOVxu95K2UjeTS45UuvVK6ZdSCnrj6Bn1+ILfGvzp
        MQhgUHqD0ygBFXHOxoGhiDA=
X-Google-Smtp-Source: AFSGD/VXfW6yi4jPtv2tYyMTDXJ36r22LmnAqwqfJz4g4giE4QzxmKs2Mpua+Nefo2kWoq4Vmewpfw==
X-Received: by 2002:a1c:cec1:: with SMTP id e184mr6869775wmg.75.1544892389930;
        Sat, 15 Dec 2018 08:46:29 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id i186sm8820935wmd.19.2018.12.15.08.46.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 08:46:29 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/9] staging: rtl8188eu: remove unused arrays WFD_OUI and WMM_INFO_OUI
Date:   Sat, 15 Dec 2018 17:46:10 +0100
Message-Id: <20181215164616.2643-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181215164616.2643-1-straube.linux@gmail.com>
References: <20181215164616.2643-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arrays WFD_OUI and WMM_INFO_OUI are not used anywhere,
so remove them.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c    | 2 --
 drivers/staging/rtl8188eu/include/rtw_mlme_ext.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 16c449d2e6c2..eda11eff5051 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -26,9 +26,7 @@ unsigned char RTW_WPA_OUI[] = {0x00, 0x50, 0xf2, 0x01};
 unsigned char WMM_OUI[] = {0x00, 0x50, 0xf2, 0x02};
 unsigned char WPS_OUI[] = {0x00, 0x50, 0xf2, 0x04};
 unsigned char P2P_OUI[] = {0x50, 0x6F, 0x9A, 0x09};
-unsigned char WFD_OUI[] = {0x50, 0x6F, 0x9A, 0x0A};
 
-unsigned char WMM_INFO_OUI[] = {0x00, 0x50, 0xf2, 0x02, 0x00, 0x01};
 unsigned char WMM_PARA_OUI[] = {0x00, 0x50, 0xf2, 0x02, 0x01, 0x01};
 
 unsigned char WPA_TKIP_CIPHER[4] = {0x00, 0x50, 0xf2, 0x02};
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
index 0ade33df16d2..62999bc06de5 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
@@ -84,10 +84,8 @@
 extern unsigned char RTW_WPA_OUI[];
 extern unsigned char WMM_OUI[];
 extern unsigned char WPS_OUI[];
-extern unsigned char WFD_OUI[];
 extern unsigned char P2P_OUI[];
 
-extern unsigned char WMM_INFO_OUI[];
 extern unsigned char WMM_PARA_OUI[];
 
 /*  Channel Plan Type. */
-- 
2.20.0

