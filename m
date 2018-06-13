Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0CA7AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C014620891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C014620891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936119AbeFMPVI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:21:08 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:37388 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935961AbeFMPVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:21:03 -0400
Received: from faui49man1 (faui49man1.informatik.uni-erlangen.de [131.188.42.189])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id 3B09758C4FB;
        Wed, 13 Jun 2018 17:14:39 +0200 (CEST)
Received: by faui49man1 (sSMTP sendmail emulation); Wed, 13 Jun 2018 17:14:39 +0200
From:   Jakob Albert <jakob.j.albert@fau.de>
To:     devel@linuxdriverproject.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenz Kaestle <lorenz.kaestle@fau.de>,
        linux-kernel@i4.cs.fau.de, Jakob Albert <jakob.j.albert@fau.de>
Subject: [PATCH v2 3/3] hwmon: (nct7904) Fix UNSPECIFIED_INT warning
Date:   Wed, 13 Jun 2018 17:13:25 +0200
Message-Id: <1528902805-21474-4-git-send-email-jakob.j.albert@fau.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528902805-21474-1-git-send-email-jakob.j.albert@fau.de>
References: <1528902805-21474-1-git-send-email-jakob.j.albert@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix UNSPECIFIED_INT warning reported by checkpatch.pl

Signed-off-by: Lorenz Kaestle <lorenz.kaestle@fau.de>
Signed-off-by: Jakob Albert <jakob.j.albert@fau.de>
---
v1->v2:	Changed patch subject and description

 drivers/hwmon/nct7904.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index 657ce88..7815ddf 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -77,7 +77,7 @@ struct nct7904_data {
 };
 
 /* Access functions */
-static int nct7904_bank_lock(struct nct7904_data *data, unsigned bank)
+static int nct7904_bank_lock(struct nct7904_data *data, unsigned int bank)
 {
 	int ret;
 
@@ -99,7 +99,7 @@ static inline void nct7904_bank_release(struct nct7904_data *data)
 
 /* Read 1-byte register. Returns unsigned reg or -ERRNO on error. */
 static int nct7904_read_reg(struct nct7904_data *data,
-			    unsigned bank, unsigned reg)
+			    unsigned int bank, unsigned int reg)
 {
 	struct i2c_client *client = data->client;
 	int ret;
@@ -117,7 +117,7 @@ static int nct7904_read_reg(struct nct7904_data *data,
  * -ERRNO on error.
  */
 static int nct7904_read_reg16(struct nct7904_data *data,
-			      unsigned bank, unsigned reg)
+			      unsigned int bank, unsigned int reg)
 {
 	struct i2c_client *client = data->client;
 	int ret, hi;
@@ -139,7 +139,7 @@ static int nct7904_read_reg16(struct nct7904_data *data,
 
 /* Write 1-byte register. Returns 0 or -ERRNO on error. */
 static int nct7904_write_reg(struct nct7904_data *data,
-			     unsigned bank, unsigned reg, u8 val)
+			     unsigned int bank, unsigned int reg, u8 val)
 {
 	struct i2c_client *client = data->client;
 	int ret;
-- 
2.7.4

