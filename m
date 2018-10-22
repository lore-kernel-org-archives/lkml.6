Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9553C7112C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE51C20652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE51C20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbeJVU53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:57:29 -0400
Received: from mout.web.de ([212.227.15.14]:37707 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbeJVU53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 16:57:29 -0400
Received: from platinum.office.videantis.de ([89.15.236.141]) by smtp.web.de
 (mrweb003 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0LbIyo-1fmQjv2Wwk-00kymJ; Mon, 22 Oct 2018 14:38:53 +0200
Received: from platinum.office.videantis.de ([89.15.236.141]) by smtp.web.de
 (mrweb003 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0LbIyo-1fmQjv2Wwk-00kymJ; Mon, 22 Oct 2018 14:38:53 +0200
From:   Soeren Moch <smoch@web.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Soeren Moch <smoch@web.de>, stable@vger.kernel.org,
        Andrea Greco <a.greco@4sigma.it>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: ds1307: fix ds1339 wakealarm support
Date:   Mon, 22 Oct 2018 14:38:12 +0200
Message-Id: <20181022123812.5782-1-smoch@web.de>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:5dvL17tsLjuBfsGnrx4j7NmCp3XhBwCLEvdIJ9sjZwqslfFJs11
 Gk4sfJYN9Jb2ruV+QxWsASKo4V0+WRUcnq5ocA9A2xFQM34zpuyuyz8VZ/LA6t+/6x+mFGx
 /sOXL0Z8exo7cnFznYVnJXwb982FGtzR4uNHDNz/jmqUmaX4x2kgei/WgSNAE98QJmkw2tr
 CxHRgy3fs2iFoimabAo4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qhXWm5vHZ84=:HpkF749QFWzc6gtAcg1ajn
 x7Gv29nteEHgnQ/I4CKCe53A4qzAQt2NEHvN4lLLRIJha32IkAQKyUQ0fd6TtNj3j4fxCKnYA
 OqwIrRxFAUUA7wsmr0xJtHaw8XQoX5kGrNhHCA76oNhH385tr2bSY1E0QWciYPgAyGckdwo5a
 H01NqmJnkkG2AAD0IyotSgmQ+DoDUwgKmD/8oTFj76OoDdzqUXQhT2DISLPB8WsOVn+s4nn23
 b3JM5gfAFAEV7ew6JGA8YHn56AaK7fyeyITzz0RSlG2X3pAvjWuPtDWNggsXpqVOSoa0uwrIm
 6r+q6xIzSWhkNYC/rWVbxZRYf8U9WHoyKfLrU4xhnXyD+mvgMDOqBMpjWfR8faTm/oU48DDHu
 jOgTDtyP5FSP/Et7HyWp4fvE2ZGnE+aEeoM2VPP18lTgIlQ2EAbaHkel9E0uVDu/woKSbB5v3
 vKUBdM5NBaHIloGcHY8WAlEASNym8GenzZ410wDAy2ljHGglirJ2w4XFUJwI0OaaxUF6Ui4BZ
 RDRTOkahqbLu0dDEhsdFiwebkP6Y1GzvRVIVaHl28LosgjHiAECszl1dg4ohz5TABGmR9bnpW
 3G1J/TLAIcY7JEIyjLzwAoUGkt8WUaZjMKGlCuV3IVFnFdcbgDGJ2y68lWvt3pNXsqtmyniBT
 ysbmjRbCKznS8e5QXVoAVlb+5QLlxEfk8wKwcHW9srya5153MAn07wSGdzllF/QFbFLVBR4Hr
 QzmmnWCZG1Y2jv/M8+hEZsef7+WynSYAvdp0n0sIOgWqy/p5/KH5jPPV3YqvpBNSsW9Janf7w
 IBtiZxdYkva9VrKe79qofRdPw+sjw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 51ed73eb998a1c79a2b0e9bed68f75a8a2c93b9b ("rtc: ds1340: Add support
for trickle charger.") breaks ds1339 wakealarm support by limiting
accessible registers. Fix this.

Fixes: 51ed73eb998a ("rtc: ds1340: Add support for trickle charger.")
Cc: stable@vger.kernel.org
Signed-off-by: Soeren Moch <smoch@web.de>
--
Cc: Andrea Greco <a.greco@4sigma.it>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/rtc/rtc-ds1307.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 4b2b4627daeb..71396b62dc52 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1384,7 +1384,6 @@ static void ds1307_clks_register(struct ds1307 *ds1307)
 static const struct regmap_config regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.max_register = 0x9,
 };
 
 static int ds1307_probe(struct i2c_client *client,
-- 
2.17.1

