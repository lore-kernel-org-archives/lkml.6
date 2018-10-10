Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAA3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3EB2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C3EB2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeJJVDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:03:04 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:53960 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeJJVDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:03:02 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id lpgl1y00d3XaVaC01pglyf; Wed, 10 Oct 2018 15:40:47 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1gAEjF-00006u-Sr; Wed, 10 Oct 2018 15:40:45 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gAEjF-0002Ae-RL; Wed, 10 Oct 2018 15:40:45 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] eeprom: at25: Drop obsolete cast in at25_ee_write()
Date:   Wed, 10 Oct 2018 15:40:34 +0200
Message-Id: <20181010134036.8296-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181010134036.8296-1-geert+renesas@glider.be>
References: <20181010134036.8296-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 01973a01f9ec34b7 ("eeprom: at25: remove nvmem regmap
dependency") changed the type of "off" from "loff_t" to "unsigned int",
there is no longer a need to cast it to "unsigned".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/misc/eeprom/at25.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 840afb398f9e4c88..7707d3fb49b526d9 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -160,7 +160,7 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 	do {
 		unsigned long	timeout, retries;
 		unsigned	segment;
-		unsigned	offset = (unsigned) off;
+		unsigned	offset = off;
 		u8		*cp = bounce;
 		int		sr;
 		u8		instr;
-- 
2.17.1

