Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23952ECDE47
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 20:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86D020831
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 20:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdGKI4wy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D86D020831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbeJ1FLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 01:11:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46902 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbeJ1FLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 01:11:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id i4-v6so4548995wrr.13
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 13:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uP3oqkM/tXA7CPG7qqBtvoR4qqkJnf+qvcHSMbJKF4g=;
        b=IdGKI4wyoLPYJBXSeAAOibOUmzdA7aodVxpv2oRk8M19NCC8jPSkDoYDPQDa2w+klL
         wdfpEtV9XgyDE+tm0sEZDSBX9oWUOe7fqIpv6umdrbqarx/6WkmRFmk6VrHhIc4n3I2b
         JH7KPrEDgoiVhGOQhlNxVbRS5sKD/9zJAi/9jxSCnrVnRbhn1ka0TLRn+zOaW5ZpU8T0
         imqFlaL+MvVx0OpTStCzpc4aZln0vPgP/+AUzCSNZFqmtEkewayXMINOgJQFvFgLvMqa
         7PdkcKzubRDy9WAbxSECwG28Bh00BK9C4JC8o42dT94dfSuGLYRKNOv4GL7oyoHX1Sul
         dG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uP3oqkM/tXA7CPG7qqBtvoR4qqkJnf+qvcHSMbJKF4g=;
        b=lvlUGIVNxrwoeIv8SMfmssgCFWSWJGl8GLyVp5p7fV/lRvZw9fBhHughjEhHxcdu7r
         PQQKz1ybpUJVSMOO2iGbGr85aYMSs83blrMqrDFE2N4zAzd01JCReDFWjLEpn2eF/SZ/
         q/+Rwp5uvtuQrHdNPX3bS6ePkGrXHIjNmaVkjPogGUg0hOPgoL9RWwRS0QITQpJVbUOf
         rVwNZh0mEaKbKYklR9qrhe9DmpJ5GioR77LI/LgsTbwlOKuRJs+ovMB1E8IK7YV1Lrmm
         FWkR1Aqw6d07LLQw3EFYe+BWkBa3i3Bh8+cGXEE8ER/BMdIF+90dYpUWD2Mz5g9wAHfD
         0Bdw==
X-Gm-Message-State: AGRZ1gKNqH1+5hCEH97UmZCJsIqiazV00pDCu4bPKQGZOCP319zSOEHX
        1GxjffY18R/89lVy6q0HeL8=
X-Google-Smtp-Source: AJdET5ec9zxGo08kdE5aogF3TCgrBKyjtR/cyspzUAcpSm8Y9C164Obq1lN3aUEyWtSgAs7RD3ys0w==
X-Received: by 2002:adf:82c9:: with SMTP id 67-v6mr9252280wrc.131.1540672142142;
        Sat, 27 Oct 2018 13:29:02 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id v16-v6sm5335784wrt.32.2018.10.27.13.29.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 13:29:01 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/5] staging: rtl8188eu: change return type of rtl8188eu_xmitframe_complete()
Date:   Sat, 27 Oct 2018 22:28:48 +0200
Message-Id: <20181027202850.25636-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181027202850.25636-1-straube.linux@gmail.com>
References: <20181027202850.25636-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function rtl8188eu_xmitframe_complete() returns true or false.
Change the return type from s32 to bool.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c    | 3 ++-
 drivers/staging/rtl8188eu/include/rtl8188e_xmit.h | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
index a11bee16d070..69a0edd27710 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
@@ -412,7 +412,8 @@ static u32 xmitframe_need_length(struct xmit_frame *pxmitframe)
 	return len;
 }
 
-s32 rtl8188eu_xmitframe_complete(struct adapter *adapt, struct xmit_priv *pxmitpriv)
+bool rtl8188eu_xmitframe_complete(struct adapter *adapt,
+				  struct xmit_priv *pxmitpriv)
 {
 	struct xmit_frame *pxmitframe = NULL;
 	struct xmit_frame *pfirstframe = NULL;
diff --git a/drivers/staging/rtl8188eu/include/rtl8188e_xmit.h b/drivers/staging/rtl8188eu/include/rtl8188e_xmit.h
index 20d35480dab8..421e9f45306f 100644
--- a/drivers/staging/rtl8188eu/include/rtl8188e_xmit.h
+++ b/drivers/staging/rtl8188eu/include/rtl8188e_xmit.h
@@ -149,8 +149,8 @@ s32 rtl8188eu_init_xmit_priv(struct adapter *padapter);
 s32 rtl8188eu_xmit_buf_handler(struct adapter *padapter);
 #define hal_xmit_handler rtl8188eu_xmit_buf_handler
 void rtl8188eu_xmit_tasklet(void *priv);
-s32 rtl8188eu_xmitframe_complete(struct adapter *padapter,
-				 struct xmit_priv *pxmitpriv);
+bool rtl8188eu_xmitframe_complete(struct adapter *padapter,
+				  struct xmit_priv *pxmitpriv);
 
 void handle_txrpt_ccx_88e(struct adapter *adapter, u8 *buf);
 
-- 
2.19.1

