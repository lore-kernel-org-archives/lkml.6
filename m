Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A06C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD1825BD4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tqbn3eoc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD1825BD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934594AbeFYOzX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 10:55:23 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43584 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934397AbeFYOzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 10:55:20 -0400
Received: by mail-wr0-f193.google.com with SMTP id c5-v6so2843614wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 07:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nBIVaUKyLlJj0dcXNek5qV7yJ+z5gEfpbYtfhnavRgE=;
        b=tqbn3eocry/LToySWMJ8vIFGirCSiHKLHDCT3zqTW/hBpSLchn3A9yhYtA7W3Wmrsx
         6924NZ/7XwhOmLHEuxcpgwELgy0IPQF42IdHb88S21hIj6icMoHgjmUcvT2oZmispOnL
         3Yk1u+CbB0AbAZATwRM+8DuOKktMLSmNUVEInm4mb2ttUhjOxAd8JZQX8ZleeGcc5U8x
         UOJgh5MhTaJA7gi+QKYoIluk7VOZaR8dJaiO2kD46sOaDS3ojYLxHl2T7D7heYbKw/YT
         WE3TSOnE8Mr6EXH4XCgpZxyTuwhB7oSqQZwxpaftFKkL6WMStghXXrLFjuvIuD3QvGz1
         jL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nBIVaUKyLlJj0dcXNek5qV7yJ+z5gEfpbYtfhnavRgE=;
        b=NpgbAQG7CBSqR40JaPa10gOm1+k6dknTggeJGy7iDQUTzS/0Pcg0gGL8CEjWe69jYj
         D3/sIqgO9hu3Fh9+hL4a/a7Xs9txAvrW081bsu0Lpgj8B/c3QVNYAXZ+BBovwzJ8NOCo
         te7v+IzhfpcEWHVzkOfq0QvI07xKh0I/ViD852NCuysiydNCjuuQnDN2jdHcBx++3gcO
         M2n4srrzYJvHq7zReMmgu2J6Cjatb2sH2/RfyixF3BT19F5tcQrUABeIO6ZGDf3MtlM7
         78+qLsHkjXJ4ABH4BsJT+U0QQnNcSfXZOV/VhAultCJKQE0MHIx24Iyd1KohpHEl1yGu
         gcRQ==
X-Gm-Message-State: APt69E3p/0kD/bHfR8H8ncHSWXRGIAk/2sO7LHfmTTSxXDhy14DLSWoG
        MUiaHrEdqiR16U86AvjIntWcMjTwVW8=
X-Google-Smtp-Source: AAOMgpdnhMOX5+lsRJmhBHs8+GZPtyfmb97aLNDSdG+Z3GArMBIMySeUZB+jkaOYMbZVFpBnXDkPgQ==
X-Received: by 2002:adf:f246:: with SMTP id b6-v6mr10172503wrp.235.1529938519703;
        Mon, 25 Jun 2018 07:55:19 -0700 (PDT)
Received: from arch.localdomain (x590e3931.dyn.telefonica.de. [89.14.57.49])
        by smtp.gmail.com with ESMTPSA id q17-v6sm15181320wrr.7.2018.06.25.07.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 07:55:18 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2] staging: rtl8723bs: remove rtw_set_tx_chksum_offload()
Date:   Mon, 25 Jun 2018 16:50:25 +0200
Message-Id: <20180625145025.17394-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function rtw_set_tx_chksum_offload() has empty definition.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c      | 2 --
 drivers/staging/rtl8723bs/include/xmit_osdep.h | 2 --
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c  | 5 -----
 3 files changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index aaabffb0a199..3e7c1f07b8b4 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -845,8 +845,6 @@ static s32 update_attrib(struct adapter *padapter, _pkt *pkt, struct pkt_attrib
 
 	/* pattrib->priority = 5; force to used VI queue, for testing */
 
-	rtw_set_tx_chksum_offload(pkt, pattrib);
-
 exit:
 	return res;
 }
diff --git a/drivers/staging/rtl8723bs/include/xmit_osdep.h b/drivers/staging/rtl8723bs/include/xmit_osdep.h
index 377b453de199..a61412b54ec0 100644
--- a/drivers/staging/rtl8723bs/include/xmit_osdep.h
+++ b/drivers/staging/rtl8723bs/include/xmit_osdep.h
@@ -33,8 +33,6 @@ void rtw_os_xmit_schedule(struct adapter *padapter);
 int rtw_os_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *pxmitbuf, u32 alloc_sz, u8 flag);
 void rtw_os_xmit_resource_free(struct adapter *padapter, struct xmit_buf *pxmitbuf, u32 free_sz, u8 flag);
 
-extern void rtw_set_tx_chksum_offload(_pkt *pkt, struct pkt_attrib *pattrib);
-
 extern uint rtw_remainder_len(struct pkt_file *pfile);
 extern void _rtw_open_pktfile(_pkt *pkt, struct pkt_file *pfile);
 extern uint _rtw_pktfile_read (struct pkt_file *pfile, u8 *rmem, uint rlen);
diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
index 4da0c6f323d1..2cf903c66854 100644
--- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
@@ -46,11 +46,6 @@ sint rtw_endofpktfile(struct pkt_file *pfile)
 	return false;
 }
 
-void rtw_set_tx_chksum_offload(_pkt *pkt, struct pkt_attrib *pattrib)
-{
-
-}
-
 int rtw_os_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *pxmitbuf, u32 alloc_sz, u8 flag)
 {
 	if (alloc_sz > 0) {
-- 
2.18.0

