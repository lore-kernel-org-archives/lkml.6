Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13341C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 14:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8C020893
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 14:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="twZFFckF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8C020893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbeG1P4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 11:56:16 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36766 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728990AbeG1P4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 11:56:15 -0400
Received: by mail-wm0-f68.google.com with SMTP id s14-v6so8711759wmc.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 07:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hdD7JaxWCaTLFczyKqlfuss9sJTeczq5yLV4ZxrXBP0=;
        b=twZFFckFCYooxPIbQNlQGL1kHL7JaxBAVOc/cn2hmtdIXlk2eygAxBWWzlww/xnp50
         vkNq/nIKzJIiCJv0z+clQYSxAAsQ0CJx5feRsO02aYyZaeFXJnMwX0uc8fbihdI/qYYQ
         d1+D2H5a5uufV3TSxN8MWnqLpqjeqmyrDe4tvRm6cHGnfVIYZ5U3kn9VTWshKWoOJaYu
         H/3WUfalBk/hW3QvA2FYRcN0b97IBf0hdJ7cl+N0BTgHgAl6NLXshD/JLPShvtf3rj6K
         Awrcwk04unQ1ywl9Q0Zs8BMIYrleGFYPBvlTtyGNvMjF9TX0rISvVkIECMl91VGAhE4o
         9XOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hdD7JaxWCaTLFczyKqlfuss9sJTeczq5yLV4ZxrXBP0=;
        b=Gntyhxr6slNb4a7WJeg08wAMUvnowF30/nohx7OF0ZPQRevxwj2b0jjLF5ZHQ5PGMu
         LkW/PICQLnLRZNQxPqMDA9G1bK/hFfkD4oDyhjRbjdA6CE3RIM6HIcaMPEjjlnk9QLBs
         yr8gy/PpmdTOKZeXc4Cll6v97qYyQCdPI/jCKBFHvT37HGN369h79eyHd/bvn1PDrhSq
         /8oPRloW1QV7V7WGjtII1mRdzvDXK9v7J08HmEI8adixPC/pHje1ft5lpAFL+uYODpc5
         X7bUpWkyilarCHdXV/Gr0PJFDbFIlUn54vwR8MUPjeNyO2w6C1jQNmq/zijfS0pgO6dC
         +82Q==
X-Gm-Message-State: AOUpUlFxrJzbUAN0uAaq6as4rb3jvZ1f4Go8QzxgGMSMk3ieTiADzZmx
        zm9XPy1tD5L3rbmtfi07vM8=
X-Google-Smtp-Source: AAOMgpflP6phdBj8jSBRcHpBXtT95Ef096QLDxSxC3qhcpd5Ryh9X8r2sO84+Q8hZohBuzoG7ouEvQ==
X-Received: by 2002:a1c:8414:: with SMTP id g20-v6mr8885373wmd.90.1532788172558;
        Sat, 28 Jul 2018 07:29:32 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id z8-v6sm13187019wrp.54.2018.07.28.07.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 07:29:32 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: rtl8188eu: replace tabs with spaces
Date:   Sat, 28 Jul 2018 16:29:16 +0200
Message-Id: <20180728142917.1439-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180728142917.1439-1-straube.linux@gmail.com>
References: <20180728142917.1439-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tabs with spaces, clears a checkpatch 'line over 80 characters'
warning.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_xmit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 03b65e9b067a..4265ad84547d 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -23,7 +23,7 @@ static void _init_txservq(struct tx_servq *ptxservq)
 	ptxservq->qcnt = 0;
 }
 
-void	_rtw_init_sta_xmit_priv(struct sta_xmit_priv *psta_xmitpriv)
+void _rtw_init_sta_xmit_priv(struct sta_xmit_priv *psta_xmitpriv)
 {
 	memset((unsigned char *)psta_xmitpriv, 0, sizeof(struct sta_xmit_priv));
 	spin_lock_init(&psta_xmitpriv->lock);
@@ -35,12 +35,12 @@ void	_rtw_init_sta_xmit_priv(struct sta_xmit_priv *psta_xmitpriv)
 	INIT_LIST_HEAD(&psta_xmitpriv->apsd);
 }
 
-s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
+s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 {
 	int i;
 	struct xmit_buf *pxmitbuf;
 	struct xmit_frame *pxframe;
-	int	res = _SUCCESS;
+	int res = _SUCCESS;
 	u32 max_xmit_extbuf_size = MAX_XMIT_EXTBUF_SZ;
 	u32 num_xmit_extbuf = NR_XMIT_EXTBUFF;
 
-- 
2.18.0

