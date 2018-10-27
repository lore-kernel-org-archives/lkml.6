Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3C3C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 14:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC4E20843
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 14:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC4E20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbeJ0XHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 19:07:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52084 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbeJ0XHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 19:07:30 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gGPXe-0001VF-Ur; Sat, 27 Oct 2018 14:26:19 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: fix typo in function name rtw_sctx_chk_waring_status
Date:   Sat, 27 Oct 2018 15:26:18 +0100
Message-Id: <20181027142618.6207-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to typo in function name, rename it to
rtw_sctx_chk_warning_status.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtl8188eu/core/rtw_xmit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 0a3e710590ed..b218b9deff7b 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -2029,7 +2029,7 @@ int rtw_sctx_wait(struct submit_ctx *sctx)
 	return ret;
 }
 
-static bool rtw_sctx_chk_waring_status(int status)
+static bool rtw_sctx_chk_warning_status(int status)
 {
 	switch (status) {
 	case RTW_SCTX_DONE_UNKNOWN:
@@ -2047,7 +2047,7 @@ static bool rtw_sctx_chk_waring_status(int status)
 void rtw_sctx_done_err(struct submit_ctx **sctx, int status)
 {
 	if (*sctx) {
-		if (rtw_sctx_chk_waring_status(status))
+		if (rtw_sctx_chk_warning_status(status))
 			DBG_88E("%s status:%d\n", __func__, status);
 		(*sctx)->status = status;
 		complete(&((*sctx)->done));
-- 
2.19.1

