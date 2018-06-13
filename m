Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 14F18C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D6C208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D6C208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936082AbeFMPVI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:21:08 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:37385 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935680AbeFMPVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:21:03 -0400
Received: from faui49man1 (faui49man1.informatik.uni-erlangen.de [131.188.42.189])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id 2B0A958C4FA;
        Wed, 13 Jun 2018 17:14:13 +0200 (CEST)
Received: by faui49man1 (sSMTP sendmail emulation); Wed, 13 Jun 2018 17:14:13 +0200
From:   Jakob Albert <jakob.j.albert@fau.de>
To:     devel@linuxdriverproject.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenz Kaestle <lorenz.kaestle@fau.de>,
        linux-kernel@i4.cs.fau.de, Jakob Albert <jakob.j.albert@fau.de>
Subject: [PATCH v2 1/3] hwmon: (nct7904) Fix SPACING errors
Date:   Wed, 13 Jun 2018 17:13:23 +0200
Message-Id: <1528902805-21474-2-git-send-email-jakob.j.albert@fau.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528902805-21474-1-git-send-email-jakob.j.albert@fau.de>
References: <1528902805-21474-1-git-send-email-jakob.j.albert@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix SPACING errors reported by checkpatch.pl

Signed-off-by: Lorenz Kaestle <lorenz.kaestle@fau.de>
Signed-off-by: Jakob Albert <jakob.j.albert@fau.de>
---
v1->v2:	Changed patch subject and description

 drivers/hwmon/nct7904.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index 95a68ab..7de2421 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -159,7 +159,7 @@ static int nct7904_read_fan(struct device *dev, u32 attr, int channel,
 	unsigned int cnt, rpm;
 	int ret;
 
-	switch(attr) {
+	switch (attr) {
 	case hwmon_fan_input:
 		ret = nct7904_read_reg16(data, BANK_0,
 					 FANIN1_HV_REG + channel * 2);
@@ -200,7 +200,7 @@ static int nct7904_read_in(struct device *dev, u32 attr, int channel,
 
 	index = nct7904_chan_to_index[channel];
 
-	switch(attr) {
+	switch (attr) {
 	case hwmon_in_input:
 		ret = nct7904_read_reg16(data, BANK_0,
 					 VSEN1_HV_REG + index * 2);
@@ -236,7 +236,7 @@ static int nct7904_read_temp(struct device *dev, u32 attr, int channel,
 	struct nct7904_data *data = dev_get_drvdata(dev);
 	int ret, temp;
 
-	switch(attr) {
+	switch (attr) {
 	case hwmon_temp_input:
 		if (channel == 0)
 			ret = nct7904_read_reg16(data, BANK_0, LTD_HV_REG);
@@ -276,7 +276,7 @@ static int nct7904_read_pwm(struct device *dev, u32 attr, int channel,
 	struct nct7904_data *data = dev_get_drvdata(dev);
 	int ret;
 
-	switch(attr) {
+	switch (attr) {
 	case hwmon_pwm_input:
 		ret = nct7904_read_reg(data, BANK_3, FANCTL1_OUT_REG + channel);
 		if (ret < 0)
@@ -301,7 +301,7 @@ static int nct7904_write_pwm(struct device *dev, u32 attr, int channel,
 	struct nct7904_data *data = dev_get_drvdata(dev);
 	int ret;
 
-	switch(attr) {
+	switch (attr) {
 	case hwmon_pwm_input:
 		if (val < 0 || val > 255)
 			return -EINVAL;
@@ -322,7 +322,7 @@ static int nct7904_write_pwm(struct device *dev, u32 attr, int channel,
 
 static umode_t nct7904_pwm_is_visible(const void *_data, u32 attr, int channel)
 {
-	switch(attr) {
+	switch (attr) {
 	case hwmon_pwm_input:
 	case hwmon_pwm_enable:
 		return S_IRUGO | S_IWUSR;
-- 
2.7.4

