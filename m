Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098E1C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACEA21A0E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="dnwVzbDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BACEA21A0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754485AbeFUSXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:23:18 -0400
Received: from mout01.posteo.de ([185.67.36.65]:49081 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751048AbeFUSXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:23:17 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id ADA3220F49
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 20:23:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1529605395; bh=80MpJqYB4HaQpkqBYVQjeKFQpiNpwW7aKlYt2vDDN6o=;
        h=From:To:Cc:Subject:Date:From;
        b=dnwVzbDXnQ9mZwka9QWIfnsl+wrE0L+XNqU6oVuMwG2YQ0+/wcNvaGO9EaW0+926R
         ldwOwa8C5GYQaNhg8fkQ7/JF53xJHbus1dYrZ/yTAJuDEQCGzbWMLLFDQ5q1XPbrZL
         mQgnot8H/aW6y5FcOrQ75dW32tvk+4yTB18GzO8RhjdS0b9qlA6Irzq1lzkJfujstT
         JsHZv31AI5t4H2mGFMvebLjgmUA/+9G0dAWP49T4dTnLzq9ODAdnA0gg2mWQFfHJbI
         /yQZg9BWM6TdahGbnjXI/wcVJco6DxOGLUg/2PPyDk84aPILbUMJvgSkL3TpBgtoo+
         pMf+WIFvUTuUQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 41BVSL5V8nz9rxY;
        Thu, 21 Jun 2018 20:23:14 +0200 (CEST)
From:   Michael Straube <michael.straube@posteo.de>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <michael.straube@posteo.de>
Subject: [PATCH] staging: rtl8723bs: remove rtw_set_tx_chksum_offload()
Date:   Thu, 21 Jun 2018 20:22:58 +0200
Message-Id: <20180621182258.27869-1-michael.straube@posteo.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function rtw_set_tx_chksum_offload() has empty definition.

Signed-off-by: Michael Straube <michael.straube@posteo.de>
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
2.17.1

