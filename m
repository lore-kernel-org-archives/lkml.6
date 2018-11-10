Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55B6C0044B
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 17:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F4120840
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 17:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQI/vP9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F4120840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbeKKDk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 22:40:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45360 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeKKDku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 22:40:50 -0500
Received: by mail-wr1-f66.google.com with SMTP id k15-v6so5058337wre.12
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 09:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cbGaPS/cq0E9h5B+LU3H0Gj2rQrCncikE6SQ6rVR9HM=;
        b=iQI/vP9HTuQXMgm4Y8kJ85e0FvFpLKZAsZZM3MSkxkm0I+qt2i3VxYXzFkHncf6/+r
         Qlz0Re4YWgX6z0y9xA3q3iflTyYKi2Luy01LQF92ZW6a9qe05dKEYMFM7lSLHhPvrKRj
         9Wx41tWo1/I9LcEOzfEaV9rPmJzUYD2no3uTtBr8soDcjWakQmLtV3JTcfRe0eh27eoD
         xekjGyfTJ5ifpYxFlDg/6ddUTgsRhYn7vxaL3XfttFY9AryG6WLj3kBzU6Ggqpm3MNNh
         S66FYzT+Ja6UtFmMNwiziruwHMDj99nLaJZbarKlqaVauNJYTtiYTPo/MOa66QSHGO8m
         1tNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cbGaPS/cq0E9h5B+LU3H0Gj2rQrCncikE6SQ6rVR9HM=;
        b=H0cH+ohnDtcnC2cSbLtaC0CQyRSyTYPkbjXDtsDaEloPikHEBW9a7OdN2zvOqX6xjc
         03g/h0j+w9GzYlpM3ImtkWjJW7WCp8N60J+iWURKKCQ2Wf7rmqfVHAVnWTqBqVoJjpfF
         AOSBS3m0PxvhOln4DTWL1o/Uz8MaFO/66lzni98CtpoAT9zo8ns7HkwWNSy8mEX4qLkP
         t0vEhwhh6uv3rPoGR290KIIPqZ1PHUviw9BRf5+rDQuxrTs9A5i2jkgClaIsg4PmzMNb
         YjEmBw5NkPQRHjKyrvxxiQn1wS1/dxR2FtcZxwYd2DGsTowiTrk2swD+4iK5iGAkj5K0
         8dIw==
X-Gm-Message-State: AGRZ1gLlCeNHWHk8a0iNQJnYBy7GD2d2bnDt2UdtGMgJU/jwP6hlcph/
        +o99SLHsyC8xJpbvjFIV/6Q=
X-Google-Smtp-Source: AJdET5ddhUtCTmZvvsElHd7y54lTpJ3irGYecAPTKrOHqQ3HzFVLjeo2OyCZwehNCWL/H4TqLDYxJA==
X-Received: by 2002:a5d:4682:: with SMTP id u2-v6mr11763809wrq.39.1541872499967;
        Sat, 10 Nov 2018 09:54:59 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id y81-v6sm1446407wmd.11.2018.11.10.09.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 09:54:59 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: rtl8188eu: remove unnecessary parentheses in recv_linux.c
Date:   Sat, 10 Nov 2018 18:54:46 +0100
Message-Id: <20181110175446.16224-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181110175446.16224-1-straube.linux@gmail.com>
References: <20181110175446.16224-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/recv_linux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/recv_linux.c b/drivers/staging/rtl8188eu/os_dep/recv_linux.c
index 0d253a84904d..9c9339863a4a 100644
--- a/drivers/staging/rtl8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/recv_linux.c
@@ -69,8 +69,8 @@ int rtw_recv_indicatepkt(struct adapter *padapter,
 	struct sk_buff *skb;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	precvpriv = &(padapter->recvpriv);
-	pfree_recv_queue = &(precvpriv->free_recv_queue);
+	precvpriv = &padapter->recvpriv;
+	pfree_recv_queue = &precvpriv->free_recv_queue;
 
 	skb = precv_frame->pkt;
 	if (!skb) {
-- 
2.19.1

