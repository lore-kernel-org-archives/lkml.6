Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0972C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 14:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FB920843
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 14:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1FB920843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbeJ0XIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 19:08:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52094 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728616AbeJ0XIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 19:08:31 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gGPYd-0001ZT-SI; Sat, 27 Oct 2018 14:27:19 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: fix typo in function name rtw_sctx_chk_waring_status
Date:   Sat, 27 Oct 2018 15:27:19 +0100
Message-Id: <20181027142719.6269-1-colin.king@canonical.com>
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
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index edb678190b4b..729fd37f440b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -3033,7 +3033,7 @@ int rtw_sctx_wait(struct submit_ctx *sctx, const char *msg)
 	return ret;
 }
 
-static bool rtw_sctx_chk_waring_status(int status)
+static bool rtw_sctx_chk_warning_status(int status)
 {
 	switch (status) {
 	case RTW_SCTX_DONE_UNKNOWN:
@@ -3051,7 +3051,7 @@ static bool rtw_sctx_chk_waring_status(int status)
 void rtw_sctx_done_err(struct submit_ctx **sctx, int status)
 {
 	if (*sctx) {
-		if (rtw_sctx_chk_waring_status(status))
+		if (rtw_sctx_chk_warning_status(status))
 			DBG_871X("%s status:%d\n", __func__, status);
 		(*sctx)->status = status;
 		complete(&((*sctx)->done));
-- 
2.19.1

