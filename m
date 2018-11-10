Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002ACC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 17:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB35720840
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 17:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBjwN+hp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB35720840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeKKDkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 22:40:49 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45358 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeKKDkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 22:40:49 -0500
Received: by mail-wr1-f66.google.com with SMTP id k15-v6so5058290wre.12
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 09:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yGq85GIncEnByTJ+O5LRd/+xPNVDSW552KrtB5f/85Q=;
        b=LBjwN+hpQAUcXBmK6tOn705hXOAhNzfGEkh1Mccujz5ckyAfL9YrTjrQir6JL7Wy+n
         51wD7nYOyY0vhFPSvyi4K7h1k5Q0us/l38BgnD2+A+CjLNYW1JfW9G6cGYUIhIGIcC+m
         zji2YQ1yClGVugp1dDUqv1qHpE8a5+S9NF4xgD0ZDFqKsYxPbIQsm+fEuLmmP74uN1LR
         sjmQ6rQmO6AYSeNHXF8Y/umeH3T6DYcpP7KdH8y6jn/SFd0uvvn2Usa4xWVUBjmVrVTi
         Ubkixni9i6j8+4lKNLK66eeFCb92djUIskMZm2CUKDbyI76Se+tMSh7ooLATcLDkJFYe
         fftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yGq85GIncEnByTJ+O5LRd/+xPNVDSW552KrtB5f/85Q=;
        b=nYJcwpKQUQ6bGiP+Ue9VA6IzrQ2QNp1Guku9qaMBGLHenG8Hli2sOTkRwp4hEevAJF
         NatiL1Tv+8vXv/n/HM9RCM5hoyl93dELRMCzzS0Vu0TabdDGg/1Jn2mKx0RZ4VOu2v5A
         PYQ1iG7RRP4A7tW24sDUybCE2K+WEB2X/XVFCRn01RUNiJSqZJmZgQCWZjYsValfRNLD
         ExS5pP4eoaEXklFP1kXtUtVikQ6pvds1MDN0PMBmlS6I3x61nhzwkQy0tUidAE7YHYlo
         +3Q76rKl3M91lX6q2LckoRKEH4H8rQe6zZABpNR5l0SAzKR0Cu7QCp5YH+MbAv6h11KC
         +CyA==
X-Gm-Message-State: AGRZ1gLjtaQyxCR7Efc/f4SvHo8Rfa7dCduu/DpT7Rvc4Qdh2MRIgncQ
        Tpm/M14bitArHFd4Bwv/Mtw=
X-Google-Smtp-Source: AJdET5dk0QUouYV8eow6p+uKD7OpIKvstzXUJV0ZSvduRuSJSC9lg+dCiKcH7t/dGOzOAk72j+px5w==
X-Received: by 2002:adf:c6c3:: with SMTP id c3-v6mr12440439wrh.243.1541872498106;
        Sat, 10 Nov 2018 09:54:58 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id y81-v6sm1446407wmd.11.2018.11.10.09.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 09:54:57 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/3] staging: rtl8188eu: use __func__ in recv_linux.c
Date:   Sat, 10 Nov 2018 18:54:44 +0100
Message-Id: <20181110175446.16224-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use __func__ instead of hardcoded function name.
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/recv_linux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/recv_linux.c b/drivers/staging/rtl8188eu/os_dep/recv_linux.c
index 6f74f49bf3ab..764d33c4e839 100644
--- a/drivers/staging/rtl8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/recv_linux.c
@@ -75,7 +75,7 @@ int rtw_recv_indicatepkt(struct adapter *padapter,
 	skb = precv_frame->pkt;
 	if (!skb) {
 		RT_TRACE(_module_recv_osdep_c_, _drv_err_,
-			 ("rtw_recv_indicatepkt():skb == NULL something wrong!!!!\n"));
+			 ("%s():skb == NULL something wrong!!!!\n", __func__));
 		goto _recv_indicatepkt_drop;
 	}
 
@@ -126,7 +126,7 @@ int rtw_recv_indicatepkt(struct adapter *padapter,
 	rtw_free_recvframe(precv_frame, pfree_recv_queue);
 
 	RT_TRACE(_module_recv_osdep_c_, _drv_info_,
-		 ("\n rtw_recv_indicatepkt :after netif_rx!!!!\n"));
+		 ("\n %s :after netif_rx!!!!\n", __func__));
 
 	return _SUCCESS;
 
-- 
2.19.1

