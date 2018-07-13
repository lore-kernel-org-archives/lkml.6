Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8849BECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4326C208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4326C208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeGMJTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:19:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58954 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbeGMJTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:19:23 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fdu19-0002pE-JS; Fri, 13 Jul 2018 09:05:35 +0000
From:   Colin King <colin.king@canonical.com>
To:     "Guilherme G . Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial: jsm: remove redundant pointer ch
Date:   Fri, 13 Jul 2018 10:05:35 +0100
Message-Id: <20180713090535.3205-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer ch is being assigned but is never used hence it is redundant
and can be removed.

Cleans up clang warning:
warning: variable 'ch' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/tty/serial/jsm/jsm_tty.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index b6bd6e15e07b..689774c073ca 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -430,7 +430,6 @@ int jsm_uart_port_init(struct jsm_board *brd)
 {
 	int i, rc;
 	unsigned int line;
-	struct jsm_channel *ch;
 
 	if (!brd)
 		return -ENXIO;
@@ -444,7 +443,7 @@ int jsm_uart_port_init(struct jsm_board *brd)
 	brd->nasync = brd->maxports;
 
 	/* Set up channel variables */
-	for (i = 0; i < brd->nasync; i++, ch = brd->channels[i]) {
+	for (i = 0; i < brd->nasync; i++) {
 
 		if (!brd->channels[i])
 			continue;
-- 
2.17.1

