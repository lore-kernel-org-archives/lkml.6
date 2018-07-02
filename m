Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B2EC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61F025B1C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61F025B1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964854AbeGBIb4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 04:31:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53252 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932339AbeGBIbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 04:31:48 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fZuFO-0005hN-5t; Mon, 02 Jul 2018 08:31:46 +0000
From:   Colin King <colin.king@canonical.com>
To:     Harald Welte <laforge@gnumonks.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] char: pcmcia: remove redundant pointer dev
Date:   Mon,  2 Jul 2018 09:31:45 +0100
Message-Id: <20180702083145.14326-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer dev is being assigned but is never used hence it is redundant
and can be removed.

Cleans up clang warning:
warning: variable ‘dev’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/char/pcmcia/cm4000_cs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
index 370e0a64ead1..a219964cb770 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -1748,8 +1748,6 @@ static int cm4000_config_check(struct pcmcia_device *p_dev, void *priv_data)
 
 static int cm4000_config(struct pcmcia_device * link, int devno)
 {
-	struct cm4000_dev *dev;
-
 	link->config_flags |= CONF_AUTO_SET_IO;
 
 	/* read the config-tuples */
@@ -1759,8 +1757,6 @@ static int cm4000_config(struct pcmcia_device * link, int devno)
 	if (pcmcia_enable_device(link))
 		goto cs_release;
 
-	dev = link->priv;
-
 	return 0;
 
 cs_release:
-- 
2.17.1

