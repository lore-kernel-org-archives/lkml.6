Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx49A1VSEbGpiQefPc4360h3xpFvtZHEj+luQ6uD9+0CCX9su6/F251W7lqIqp1qPBDtCQ7Ph
ARC-Seal: i=1; a=rsa-sha256; t=1522393805; cv=none;
        d=google.com; s=arc-20160816;
        b=N6y4MDaOQLTreUB1O+6DmN/rnnS2dvO7IZZNVGJoBC/HlZZnZtE1nvaRqh4YdaojVA
         zDYEDM57/QXF/IuBCIBiRh+15hMQHBOy2KIZzYS2Un6aIEA3lD1lga+WFHihYrllMlHK
         pwQb9jRbzgMu5Riv+Y0jLgqAOZgCxAVHg8YNYGd+NutP8Md4I8yZzGgCYjGzhb5YjAQC
         U+jwF2prrnZAdDIBI8ox4PAKtT2xk8c3pAYno8pxQ0lPWSB7DLLU6VdZuaap9zvXEDLY
         GRAxpvbaSXHpgRcmeP2R1GgIMmleVp2d2zY6HMPq7FzEvCUOuquKB+4ERE1mFlSjDpNF
         ANsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=nPYJKSMoemtGcRdsDl6FYvfa5ye80cE0Br+2q9YDlm0=;
        b=ttgWpAC1XhOAleq7PWXbX6XddbyoAELJqysHXdXSDb2pUtJUIaVye+kaIRK1YCPQmH
         NFQahHpSOcwMe8dpFOjMXDEWYknzdpkeoZgkCUAbCgMApkFy0o2b+xhiDsv5uKMeJ8NY
         5FaHxVQ6MixkekTROYFseUXZFOaNmAFvhWjQNZkQ4LmEKZesMmOPNCVGFwPeZe9cV9L8
         jf5uplJLSSSTjQ7Zg6HcBifbojc09jW50ak+uGqhMNQugy42G/QRmNbQM0ZeIRD/Fa4U
         D5Jn3pX/kvbJ8W7WMxpcyiGIyLU/qOoTHtyyd756Bd+ccH8jmwTMTH4yGjx7CTrysPGl
         UZvg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 75/76] staging: ks7010: Replace memcmp() with ether_addr_equal().
Date: Fri, 30 Mar 2018 00:08:41 -0700
Message-Id: <20180330070842.25224-78-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:IGiZBqw7qgxUFKCBwRVH4mfi7ro8puucdc9fsiCesjJ+K4Prh1l
 AZ3HHMCj63t1Xkt6sevcI4JM0cOwi2xz8NoO1cQaFvWS6It+ERNO0gRu1iciA2450WrZbbm
 PMNed+pKi8kLk0mT4gK/AWWm8XmdBDgHUgRGvgka/ta1kj/1rYNmRoZwLljRtjPQuc2PRjI
 s74FQB71EiGfGFdeWdplw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QpXqQf0T1Js=:lJkDmXNM1WCtNhKknuTlKm
 JgrXaoYs1fwySl7bg2Je34pQVoQhySXslvKpG1wpnH3ZBny9rwYXd6tpyMCusPkq4QyLJMPY1
 zJjc4DP2bYb8w6XIGb82bGiDXlr9llYBqocyHD7k+9jhLrK3EPr3mF83aa/FOO1vPiF8DmZCx
 bZu2Z4fDEpf1kH+giOg474R6l0lZRINpcfxyjgOvv5EsCk+22DxkPHT3B+jI9jbbtUhdEEWLu
 VGv4+C+aYDIoynuesvsG8701iqCHkSq0VYnEKcoFLQ5wkeYvOOGf9yuTZ0XLJdJzE+UHQ3fM4
 mYT4xTupp0VLs5RzAdEtkLHwkSRC8khCvoI2UFMFQW5II1C0jWsC+Aun9flriPngA71Py32K3
 yki37UN6Rzs/l9GVJ4zqFgAtl071D2Jo7ne4ml/7FUibv5im9/ApS6QAtSpeIn/X+Kzml1DFc
 gZf7ulOPRFU/XMOy7kUHGrcr4WBCsCdwaon7asxbbfj/+CNrkntP/59qzlLTcjPDwBe5aFmFD
 pu6uvCuN4H+KaTY3oozPSKSGBoYNmqeG6hGf6ABLQIj3ZszyzRwUh39cAALmJo67uNVJgtAq7
 xA2GTyg2/gXfisCdvp4DoyZerpXAQbT6SkYgu3PmliPW57quYW1ESi9G/fJXBBfYUdFHQXBoG
 iH33/974AfmNN81GWwTY70V+CDuD0mMwBKKJNJlBNUbnqnLPgt0ol6/liayrkuXv4ZQ5MvHBc
 dMwJRMNFjY8JqGaEE0SeBzy+OEvwxpcRb7Oq1g==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345606770862181?=
X-GMAIL-MSGID: =?utf-8?q?1596345606770862181?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ether_addr_equal() is the function for comparing HW addresses,
so remove the manual memcmp operation and replace it with
ether_addr_equals().

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index b97080f8ebd2..fd1bf5d7ecd4 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -411,7 +411,7 @@ void hostif_data_indication(struct ks_wlan_private *priv)
 	eth_proto = ntohs(eth_hdr->h_proto);
 
 	/* source address check */
-	if (memcmp(dev->dev_addr, eth_hdr->h_source, ETH_ALEN) == 0) {
+	if (ether_addr_equal(dev->dev_addr, eth_hdr->h_source)) {
 		netdev_err(dev, "invalid : source is own mac address !!\n");
 		netdev_err(dev,
 			   "eth_hdrernet->h_dest=%02X:%02X:%02X:%02X:%02X:%02X\n",
@@ -1103,7 +1103,7 @@ int hostif_data_request(struct ks_wlan_private *priv, struct sk_buff *skb)
 
 	/* skb check */
 	eth = (struct ethhdr *)skb->data;
-	if (memcmp(priv->net_dev->dev_addr, eth->h_source, ETH_ALEN) != 0) {
+	if (ether_addr_equal(priv->net_dev->dev_addr, eth->h_source)) {
 		netdev_err(priv->net_dev, "invalid mac address !!\n");
 		netdev_err(priv->net_dev, "ethernet->h_source=%pM\n", eth->h_source);
 		ret = -ENXIO;
-- 
2.16.3
