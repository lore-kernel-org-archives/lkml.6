Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BBAC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14629208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14629208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933389AbeFRPMQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:12:16 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:42417 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754321AbeFRPMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:12:12 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LnBO9-1g9EC42oKD-00hJhV; Mon, 18 Jun 2018 17:12:01 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Daniel Drake <dsd@gentoo.org>, Ulrich Kunitz <kune@deine-taler.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] zd1211rw: stop using deprecated get_seconds()
Date:   Mon, 18 Jun 2018 17:11:15 +0200
Message-Id: <20180618151142.1214422-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180618151142.1214422-1-arnd@arndb.de>
References: <20180618151142.1214422-1-arnd@arndb.de>
X-Provags-ID: V03:K1:Ei5MIm6yM4wBsY2O+tJ/g5PyqDStFsygF1ivgCfqqi7iSma4DY5
 4UQbV5zVhaqZqCNKF32kEw5I+oxDsSl4JZG4oZGHySAV3Jieq/bdMjpIPG0qXgqHKGdyVO3
 5VYRz09thRudlwHvElmJ6fFmVdwgQNldNNHDJ1Mla16/PVkFf74rVYiUooaLH4OchChi2qh
 ByBy32xRrTDaiJJpIMTEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f57maYKLt48=:kvjviJDgce0N1adDqxaBZI
 TUNW9Ab4AyhcGqinN5u8QqWjiNRpXQFUQUrFFvt3MrWVuOthCEc272I9/5K2bPNOuTUJf6k1D
 majueNK/ZNoMUeBzAJCq4wjjCLfZVpH7Uxz4d0ksUqY4Q6v4xcmWiXSHCkwh0CyncMznps5F6
 8A/33iwiRYNZilunbz5PjDWcT49owwxUZoEfIte5vguPPiObhVIXIgO8TVTfLxqXmwnpI4AIg
 gBYBF6ACFkBAfnWRW2Ua4SL2gWS+4XdWcfTUboMk6Ny1U5O9KMD0Ngvhx1NT/mMpiLjLXAum1
 CD0h6L3Piz2YaLnJH0Lj7cHqpSrkKrXvSigOGpFhXksydVVZIGVftQOe2vqmBvuSLx+0RDrT3
 0piie7q7Q63e+afKqN+LRr4PSKfSHsy1GGe9l9fQZmZ6A3MsbEkcXIcMhtJw7PS+2mtj4NPXj
 1jzO+gqQCQ3xxEifiut9RlXY1HlwEYGiEwsJHsdr4Uq0tLrGnPWry7dt1tkUCTF6BVVx+eQTT
 lMXY+PUsmYX5+NlUwJHkkZq8sfULC7JB8qO7LgQ24e5hE+sXS/pKeFC68dFc6QTxQKsr+OdkW
 u3f64Ptt/neRwraS0aHjbPNVo7269P1sjt7n4baENUNzchnpGimmYnv0ZZBnSVcfOpGmf2GOO
 JlvUWXfHM/WojsvuSbkDNk+BeX9O/pgznyeO5NeqjgsHAVU0XqFPniqaSlz2GBsmlbi8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_seconds() function is deprecated because of the y2038 overflow.
In zd1211rw we don't even care about the absolute value, so this is
not a problem, but it's equally trivial to change to the non-deprecated
ktime_get_seconds().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/zydas/zd1211rw/zd_chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_chip.c b/drivers/net/wireless/zydas/zd1211rw/zd_chip.c
index 07b94eda9604..dd6a86b899eb 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_chip.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_chip.c
@@ -1341,7 +1341,7 @@ int zd_chip_control_leds(struct zd_chip *chip, enum led_status status)
 	case ZD_LED_SCANNING:
 		ioreqs[0].value = FW_LINK_OFF;
 		ioreqs[1].value = v[1] & ~other_led;
-		if (get_seconds() % 3 == 0) {
+		if ((u32)ktime_get_seconds() % 3 == 0) {
 			ioreqs[1].value &= ~chip->link_led;
 		} else {
 			ioreqs[1].value |= chip->link_led;
-- 
2.9.0

