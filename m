Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB26BECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B287E20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B287E20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeKHXO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:14:28 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:47953 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeKHXO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:14:28 -0500
Received: from stefan-Vostro-260.fritz.box ([109.104.42.245]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MeToK-1fkaMB2Xw4-00aVS7; Thu, 08 Nov 2018 14:38:51 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Michael Heimpold <michael.heimpold@i2se.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH net-next] net: qca_spi: Add available buffer space verification
Date:   Thu,  8 Nov 2018 14:38:21 +0100
Message-Id: <1541684301-15824-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:9zpyaVlgkVrImLr6vqY24pxVFL2gKar0IhwRASfl8YzquB8rojv
 PWQANDDEB89xU7mPjML4dE9Ctat8oX2bJHZF63ZEf/qPt5ZDBbABoHB3QzhYntIh01lFAeo
 SsyWylLr/3vNnGhTKhaju2tJj8/1uAhe/6E5bJZcsv6CoIuqCAIod+NGASLtphD2OFG+Oij
 t6/xkNn2Ai6e+r5c0ET0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zlm/KCpZ3/o=:u0vSTVXi1qsfqkYCkweG6H
 oV0UUSP2o0PE096ukP6tzlVZlErgzE7tNjy0KWecyE57JbvkcdVWZk8uWGlgiIajcOY3WTrNq
 btWwOn1MxRRvazXsGdqilzlXQ9KG2rf1Fl4K3WBRKA0MPXjlFE1Foop59RN6XCyJW86SqhpXV
 rHLIsMakupZ05B0aYXY6kaz7lnfFPtYRk1gWBkHkVFiBQbNa+n/ty0jK3b3SUtCbMMFFOFSRK
 0o+ZgxdXeLgQpQ9M9eyXHp78VRi8IbOCBj3gj39OkFwO968q3MsIOx08KrJ0WELN4vZA0C5le
 xkOz08rcCtVWFL93XLCW3oDFn4KBMSwB2ogzVcoFWnSpUadsT0EgGWpT6HtE+4WzHVVJdkU+c
 IRD6lArLKpRlO1n7ogo76Z5Q7/m4RGSh7p7GEg4F/Kn+dGEmJDFkV+4wa6eoRDfNEJ3dcOg0Y
 t2OJ+XTMfHB/vNiU1hrw1hOoNf5yFTMD/6O7WNQja/n1Jqm09b7ovfhjXCH67vreLTNf1VPCQ
 TQ4FR7dy2lfBpw2MbGXHIHLBMcull0itvmIxe/+OTDpFBO3wrakzafYPqRl9Ke1sisxNC/7Dj
 ikr7d82qzanW9sZ3/U3ts9111Q9wIVa24N71A8UmmRLTeEAhitJnw2rq9m+kERh+vgfE8FC9b
 iwufi+ufddTP2cvZd8j9ClxHy0wxzCS+QnuhZEJww/JNdBE8Pldc4fPIUwFV8iXfkPMZNOXph
 zp7ArKd2bvm6AVbMrK7usj+DOQ+DioDIJArJOblTNoGNHyCDwpPQLgB0jrqmqbh0TrGdzOG9C
 hgPib+IEV2FZcZUfIkdYbvJZACRlg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interferences on the SPI line could distort the response of
available buffer space. So at least we should check that the
response doesn't exceed the maximum available buffer space.
In error case increase a new error counter and retry it later.
This behavior avoids buffer errors in the QCA7000, which
results in an unnecessary chip reset including packet loss.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/net/ethernet/qualcomm/qca_debug.c |  1 +
 drivers/net/ethernet/qualcomm/qca_spi.c   | 16 +++++++++++++++-
 drivers/net/ethernet/qualcomm/qca_spi.h   |  1 +
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_debug.c b/drivers/net/ethernet/qualcomm/qca_debug.c
index a9f1bc0..1450f38 100644
--- a/drivers/net/ethernet/qualcomm/qca_debug.c
+++ b/drivers/net/ethernet/qualcomm/qca_debug.c
@@ -61,6 +61,7 @@ static const char qcaspi_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"Transmit ring full",
 	"SPI errors",
 	"Write verify errors",
+	"Buffer available errors",
 };
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
index d531050..97f9295 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -289,6 +289,14 @@ qcaspi_transmit(struct qcaspi *qca)
 
 	qcaspi_read_register(qca, SPI_REG_WRBUF_SPC_AVA, &available);
 
+	if (available > QCASPI_HW_BUF_LEN) {
+		/* This could only happen by interferences on the SPI line.
+		 * So retry later ...
+		 */
+		qca->stats.buf_avail_err++;
+		return -1;
+	}
+
 	while (qca->txr.skb[qca->txr.head]) {
 		pkt_len = qca->txr.skb[qca->txr.head]->len + QCASPI_HW_PKT_LEN;
 
@@ -355,7 +363,13 @@ qcaspi_receive(struct qcaspi *qca)
 	netdev_dbg(net_dev, "qcaspi_receive: SPI_REG_RDBUF_BYTE_AVA: Value: %08x\n",
 		   available);
 
-	if (available == 0) {
+	if (available > QCASPI_HW_BUF_LEN) {
+		/* This could only happen by interferences on the SPI line.
+		 * So retry later ...
+		 */
+		qca->stats.buf_avail_err++;
+		return -1;
+	} else if (available == 0) {
 		netdev_dbg(net_dev, "qcaspi_receive called without any data being available!\n");
 		return -1;
 	}
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.h b/drivers/net/ethernet/qualcomm/qca_spi.h
index 2d2c497..eb9af45 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.h
+++ b/drivers/net/ethernet/qualcomm/qca_spi.h
@@ -74,6 +74,7 @@ struct qcaspi_stats {
 	u64 ring_full;
 	u64 spi_err;
 	u64 write_verify_failed;
+	u64 buf_avail_err;
 };
 
 struct qcaspi {
-- 
2.7.4

