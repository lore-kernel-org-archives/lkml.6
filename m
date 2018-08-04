Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB722C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7B02177A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7B02177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389134AbeHDLLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:11:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50188 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732670AbeHDLLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:11:10 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6A38FBC6;
        Sat,  4 Aug 2018 09:11:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 094/124] media: si470x: fix __be16 annotations
Date:   Sat,  4 Aug 2018 11:01:23 +0200
Message-Id: <20180804082705.999618035@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082702.434482435@linuxfoundation.org>
References: <20180804082702.434482435@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>

[ Upstream commit 90db5c829692a0a7845e977e45719b4699216bd4 ]

The annotations there are wrong as warned:
   drivers/media/radio/si470x/radio-si470x-i2c.c:107:35: warning: cast to restricted __be16
   drivers/media/radio/si470x/radio-si470x-i2c.c:107:35: warning: cast to restricted __be16
   drivers/media/radio/si470x/radio-si470x-i2c.c:107:35: warning: cast to restricted __be16
   drivers/media/radio/si470x/radio-si470x-i2c.c:107:35: warning: cast to restricted __be16
   drivers/media/radio/si470x/radio-si470x-i2c.c:129:24: warning: incorrect type in assignment (different base types)
   drivers/media/radio/si470x/radio-si470x-i2c.c:129:24:    expected unsigned short [unsigned] [short] <noident>
   drivers/media/radio/si470x/radio-si470x-i2c.c:129:24:    got restricted __be16 [usertype] <noident>
   drivers/media/radio/si470x/radio-si470x-i2c.c:163:39: warning: cast to restricted __be16
   drivers/media/radio/si470x/radio-si470x-i2c.c:163:39: warning: cast to restricted __be16
   drivers/media/radio/si470x/radio-si470x-i2c.c:163:39: warning: cast to restricted __be16
   drivers/media/radio/si470x/radio-si470x-i2c.c:163:39: warning: cast to restricted __be16

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/radio/si470x/radio-si470x-i2c.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/media/radio/si470x/radio-si470x-i2c.c
+++ b/drivers/media/radio/si470x/radio-si470x-i2c.c
@@ -96,7 +96,7 @@ MODULE_PARM_DESC(max_rds_errors, "RDS ma
  */
 int si470x_get_register(struct si470x_device *radio, int regnr)
 {
-	u16 buf[READ_REG_NUM];
+	__be16 buf[READ_REG_NUM];
 	struct i2c_msg msgs[1] = {
 		{
 			.addr = radio->client->addr,
@@ -121,7 +121,7 @@ int si470x_get_register(struct si470x_de
 int si470x_set_register(struct si470x_device *radio, int regnr)
 {
 	int i;
-	u16 buf[WRITE_REG_NUM];
+	__be16 buf[WRITE_REG_NUM];
 	struct i2c_msg msgs[1] = {
 		{
 			.addr = radio->client->addr,
@@ -151,7 +151,7 @@ int si470x_set_register(struct si470x_de
 static int si470x_get_all_registers(struct si470x_device *radio)
 {
 	int i;
-	u16 buf[READ_REG_NUM];
+	__be16 buf[READ_REG_NUM];
 	struct i2c_msg msgs[1] = {
 		{
 			.addr = radio->client->addr,


