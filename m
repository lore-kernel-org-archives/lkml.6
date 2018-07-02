Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0481C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845D925C1A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845D925C1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030235AbeGBKYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:24:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55726 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965314AbeGBKYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:24:41 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fZw0a-0004vP-Ce; Mon, 02 Jul 2018 10:24:36 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: dac: remove redundant variable 'shift'
Date:   Mon,  2 Jul 2018 11:24:35 +0100
Message-Id: <20180702102435.16724-1-colin.king@canonical.com>
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

Variable shift is being assigned but is never used hence it is
redundant and can be removed.

Cleans up two clang warnings:
warning: variable ‘shift’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/dac/ti-dac5571.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
index dd21eebed6a8..e39d1e901353 100644
--- a/drivers/iio/dac/ti-dac5571.c
+++ b/drivers/iio/dac/ti-dac5571.c
@@ -97,9 +97,6 @@ static int dac5571_cmd_quad(struct dac5571_data *data, int channel, u16 val)
 
 static int dac5571_pwrdwn_single(struct dac5571_data *data, int channel, u8 pwrdwn)
 {
-	unsigned int shift;
-
-	shift = 12 - data->spec->resolution;
 	data->buf[1] = 0;
 	data->buf[0] = pwrdwn << DAC5571_SINGLE_PWRDWN_BITS;
 
@@ -111,9 +108,6 @@ static int dac5571_pwrdwn_single(struct dac5571_data *data, int channel, u8 pwrd
 
 static int dac5571_pwrdwn_quad(struct dac5571_data *data, int channel, u8 pwrdwn)
 {
-	unsigned int shift;
-
-	shift = 16 - data->spec->resolution;
 	data->buf[2] = 0;
 	data->buf[1] = pwrdwn << DAC5571_QUAD_PWRDWN_BITS;
 	data->buf[0] = (channel << DAC5571_CHANNEL_SELECT) |
-- 
2.17.1

