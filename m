Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90894C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 23:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4705F206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 23:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4705F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbeJAFpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 01:45:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56812 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeJAFpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 01:45:47 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1g6krU-0003lE-DL; Sun, 30 Sep 2018 23:10:52 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: clean up clang warning on extraneous parentheses
Date:   Mon,  1 Oct 2018 00:10:51 +0100
Message-Id: <20180930231051.18867-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are extraneous parantheses that are causing clang to produce a
warning so remove these.

Clean up 3 clang warnings:
equality comparison with extraneous parentheses [-Wparentheses-equality]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c      | 5 ++---
 drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.c | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 6c8ac9e86c9f..240818b4a2c9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -1543,7 +1543,7 @@ u32 rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
 	pframe = ((struct xmit_frame *)pxmitframe)->buf_addr + hw_hdr_offset;
 
 	/* 4 start to encrypt each fragment */
-	if ((pattrib->encrypt == _AES_)) {
+	if (pattrib->encrypt == _AES_) {
 		RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("rtw_aes_encrypt: stainfo!= NULL!!!\n"));
 
 		if (IS_MCAST(pattrib->ra))
@@ -1866,8 +1866,7 @@ u32 rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
 
 	pframe = (unsigned char *)((union recv_frame *)precvframe)->u.hdr.rx_data;
 	/* 4 start to encrypt each fragment */
-	if ((prxattrib->encrypt == _AES_)) {
-
+	if (prxattrib->encrypt == _AES_) {
 		stainfo = rtw_get_stainfo(&padapter->stapriv, &prxattrib->ta[0]);
 		if (stainfo != NULL) {
 			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("rtw_aes_decrypt: stainfo!= NULL!!!\n"));
diff --git a/drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.c b/drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.c
index acc64fa8f166..0e674f39ef03 100644
--- a/drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.c
+++ b/drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.c
@@ -97,7 +97,7 @@ void odm_EdcaTurboCheckCE(void *pDM_VOID)
 		return;
 	}
 
-	if ((pregpriv->wifi_spec == 1)) {
+	if (pregpriv->wifi_spec == 1) {
 		precvpriv->bIsAnyNonBEPkts = false;
 		return;
 	}
-- 
2.17.1

