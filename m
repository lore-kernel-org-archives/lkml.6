Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDCDC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F22E20896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F22E20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tamalin.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932112AbeFQFbK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 01:31:10 -0400
Received: from mout.perfora.net ([74.208.4.197]:58379 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751711AbeFQFbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 01:31:08 -0400
Received: from kahja.local ([73.231.184.107]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LhuDc-1fza2D33Ja-00n65M;
 Sun, 17 Jun 2018 07:30:59 +0200
From:   Quytelda Kahja <quytelda@tamalin.org>
To:     gregkh@linuxfoundation.org, hadess@hadess.net, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 04/11] staging: rtl8723bs: Combine if statements with equivalent body.
Date:   Sat, 16 Jun 2018 22:30:33 -0700
Message-Id: <20180617053040.5903-4-quytelda@tamalin.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180617053040.5903-1-quytelda@tamalin.org>
References: <20180617053040.5903-1-quytelda@tamalin.org>
X-Provags-ID: V03:K1:pUopszlV3XVIUy0fZ3Uk5SWbi2tbxwvD4q8/CoFrdqddtKH8ct4
 2NbL2TOyNDNVDBopQr+iSSLZXywmCUqoO/x/dTzww1Z2RA/ZPZ3V6yDHAuQbzHi9Td02BwS
 dQ8huecgbR1ioshYfAr5tKZ8/oybpCEa3ePNhGg/3ezrjP1shV6lDCaqIY/y8vTls8wt81i
 bj/4BVMrn/ku69Xa+oHpw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RZXvy+4oNzE=:V6HH45c0lxdolsEPpb3jJD
 F1BEmn49uQ7GjTguBV2kktuPHgWWJv1qOSbXu4oW8oGQHIvP6a+xXVr2MUBAcgGihyTeLdN7p
 pFd3cgVRgQ63Bf4gkm46z0E5YF1KhlcYwsGakLVtlyY3+PrPo8UQfMKWA9REpumkxASfaUxks
 4/Hpx1smIV8wx3pXfTdr3T30G26jPIZgd7Y4BfOoa4G5ETr7MYCIbgBj/vIM1J+jlgvDrapsl
 JcOWSy2vBKOD1k/xxiEyL+BMqJn2xlFH7pYCDsQvauw3e3kVvsRIXLrznWn6AeGGFUynhSwwA
 LEVDQ2NyGUSo2js8sF4zxT8QUvb1NumqegCLnEWVAPW96wTHFQlF4bXDIRVMXpNKt17EDTJ5c
 t7cfa6R4P7hu1WkL9usNnNbK/Tn6qfNV51oeJkhzLQuS5Ek80n2m+s9ieldLpUhj1zzkaiuIl
 TLG6zxc2T2GycXuQx6aQCejzORpmerYlhKRPm9bT3fBuvxdV3aSvOiSZRy0mBwofj7aOjv10k
 qt6Xx9MKPZop5GcF5kR+6FLbDRgJ4IyGk0K2hAiYdk1dhkwBnQ9BMslT8YKJP3XhZdVlAHlEJ
 t7dGzVu0kpK/o2l1sJIbSY/9wVYxrWrKZfuABzXcpLsqzCD/zF9Wowu5gGANyncCld6/7oEed
 QsV5rKpWKU7je1XfflDm11WTZPwJWtbffR2NzQpHSNkcBI6WK3HZGStLqdESv3m+vvRE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two if statements that carry out the same operation can be combined with
a logical OR.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 7e27d7ff29fa..5d44aee44eb1 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -1734,12 +1734,8 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 
 	/*  workaround for wrong index combination to obtain tx power limit, */
 	/*  OFDM only exists in BW 20M */
-	if (idx_rate_sctn == 1)
-		idx_bandwidth = 0;
-
-	/*  workaround for wrong index combination to obtain tx power limit, */
 	/*  CCK table will only be given in BW 20M */
-	if (idx_rate_sctn == 0)
+	if (idx_rate_sctn == 0 || idx_rate_sctn == 1)
 		idx_bandwidth = 0;
 
 	/*  workaround for wrong indxe combination to obtain tx power limit, */
-- 
2.17.1

