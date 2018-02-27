Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbeB0Wbv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:31:51 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36876 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbeB0Wbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:31:48 -0500
X-Google-Smtp-Source: AG47ELu83ysFOH8AnU12+V6+pndg2ysV8Xy2+tIYv/Blin5RVvSIwAS62Nc7BYSwsuSDEZXo6D4Uhg==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: Ariel.Elior@cavium.com, everest-linux-l2@cavium.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hernan@vanguardiasur.com.ar
Subject: [PATCH] qlogic/qed: Constify *pkt_type_str[]
Date: Tue, 27 Feb 2018 19:31:34 -0300
Message-Id: <1519770694-20678-1-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: This is compile only tested as I have no access to the hw.
Constifying and declaring as static saves 24 bytes.

add/remove: 0/1 grow/shrink: 0/0 up/down: 0/-24 (-24)
Function                                     old     new   delta
pkt_type_str                                  24       -     -24
Total: Before=3599256, After=3599232, chg -0.00%

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
index ca4a81d..03ad4ee 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
@@ -1784,7 +1784,7 @@ enum qed_iwarp_mpa_pkt_type {
 /* fpdu can be fragmented over maximum 3 bds: header, partial mpa, unaligned */
 #define QED_IWARP_MAX_BDS_PER_FPDU 3
 
-char *pkt_type_str[] = {
+static const char * const pkt_type_str[] = {
 	"QED_IWARP_MPA_PKT_PACKED",
 	"QED_IWARP_MPA_PKT_PARTIAL",
 	"QED_IWARP_MPA_PKT_UNALIGNED"
-- 
2.7.4
