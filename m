Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1993817-1519108594-2-7130926525881809439
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES rosk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519108593; b=vr4N/cTRf+fzXUo2T0V2sUk1SXzfKzkwg1V/5RBcdcpoD6u
    ICioAaUl/sxjUZID352s3eeKOSxXq3ts0/SJQeTXvABAtSYCfYYZ2kxnUKVBNgPQ
    irYXDF1KpVhRg/ox5tZrDOocNL79AryAZXk7tae3EHVpySxl/ZERHIPzzMyIML/4
    9RC2YL0kDRCGMaiQpB5fGsorwlWgqldX5GEVAmncQ3+tSUN6FzqSAkdqMf6rrfI2
    NWf8XbKkZBAzN0irp4kyHljyQbpaNsY4Tj8+gLXyfo/1WhE2QDA7iWJPIi8hHO3H
    uxs6FRwgkqfds3rIgOhgYA0ugz1vBKuxGHfGsWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519108593; bh=M
    tkvkjmzfjdzcBDzaeb8kQAApqIrfCYkZ8jK61pqixY=; b=q96P4e+uWP7Q2iPg4
    KNYUjMs/l1bUveN3R1RxLxA3Y0vkw7ZffCAaagVhElKxOxprvOSszV/vFaNVYkiE
    V4EALTKd2aq8bjs7pdkL4/ExkPvNVsNnM+7yOKeGqJWf8KNry/jc/AkAIQ/7oCz+
    AHEtpFLgs+aALyAoq02Ful9XqVUDSVgxwA4Gqq2mQ9JKQjqBfty0PyyXN6vssS6h
    2rz+KMeSSz4gmF3Cj3AE5pP5uTAhbFmQxho+hk806VjV9nmpn9erxtjlfiFqLq2Z
    LqWlz2uOiucZ56OAv+ms+WntW1ZBOLR1FoqcpkXtsLgzOz86Zio2dTCKHmKATczU
    ctEOA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH v2 1/3] Staging: ks7010: sdio: Convert RX/TX queue macros into
 real functions.
Date: Mon, 19 Feb 2018 22:35:36 -0800
Message-Id: <20180220063538.6471-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180219170839.GA3632@kroah.com>
References: <20180219170839.GA3632@kroah.com>
X-Provags-ID: V03:K0:jdwpnpf8YzQKKoDLbfpDLZhQRTWhuVFAjSiGG508fb0D7pajW7p
 Qg98kMWRg+4jjFwlBHEHDNU6eKl75vJsXaDbBPVLbxVyAYtHSw/zCyKUVuy+d2iXhN2/+8L
 uSH0s5oG89MgAelZ3l9rhy0+mvmdBx40mWPW1TNmgqNscNoTGTw1l+4GPEfftn9zGQHyRfv
 K9OUes2HsDN4h3e9totDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UhwW3o74s/U=:cuditR7ySJcqJtU6YRJHEq
 aPPO/pTIZd6pts++jV2JEV1F3bWAhS/Oh4CVvHke7zJYIdJG2tiBdRWO8fN7xkqzZH8Uh5sWP
 mtfjMtYYfhkTXT+GnSG+sn4J5EaTej4GlkfPp2JNIs0yeiNKm7tDNECL+8qzDfhgRWRW1u+4w
 TYXdmriVT8sUWND36l9/IOUzzWRsVpDMlBumHkIB+oWG5/5DDWl/Ub177h+ZmMjRPKJB5QMs5
 E84I5rFR4ow57s5W+BHykxHKEqFkSH28AA8GQJQLAlxs/CzEaTCVNHiMXOQ2L44YDyu27A7/w
 Eg0bjPShDFVg9rqqPXp0oHlszMfc8JznvbOTkJti3hsjCNGVhrrd7mN629mtD2dbnzztYiHvh
 /3nzYZS+oU0pUcfTQeBjJAYQkaTgAmuuwiY9sTz2XHVqGvnDpp6q/PnAU/WzeguZSRX0d7zsj
 gloBWrJVSUtmIefbbFmKOxxXxTv6MG4MYMTV0WPae3NL+OCy4fHeYjAZ8OAbpTp5p0FCysk+s
 LociJXXg/0tCT8FpyXOf/cHezggJ1Md+4yDoMFxnpFfItTaG0W+CjX4DM/YgHOQ81VP7hHABq
 gSHTZGdXZ/f2s1rP1XfXwYpdl5SKQb8L5XXrv/5E/h0PJ8NEW8poUsqK9a7fs0enjLh7rn1H5
 Vc5Si3HDXYKci63zCCG2kEw7/BqtQIDXBPvpuL/G/bCy1UeikRdfVGGuwFOomO7tY4bD0B0zb
 gL/dbMAn5ztLhKoGg75su6F+xLEShvhNPmRuWg==
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Quytelda Kahja <quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Convert the unsafe macros into inline functions.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks7010_sdio.c | 46 ++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
index 8cfdff198334..7de78d1758b8 100644
--- a/drivers/staging/ks7010/ks7010_sdio.c
+++ b/drivers/staging/ks7010/ks7010_sdio.c
@@ -32,19 +32,39 @@ static const struct sdio_device_id ks7010_sdio_ids[] = {
 };
 MODULE_DEVICE_TABLE(sdio, ks7010_sdio_ids);
 
-#define inc_txqhead(priv) \
-	(priv->tx_dev.qhead = (priv->tx_dev.qhead + 1) % TX_DEVICE_BUFF_SIZE)
-#define inc_txqtail(priv) \
-	(priv->tx_dev.qtail = (priv->tx_dev.qtail + 1) % TX_DEVICE_BUFF_SIZE)
-#define cnt_txqbody(priv) \
-	(((priv->tx_dev.qtail + TX_DEVICE_BUFF_SIZE) - (priv->tx_dev.qhead)) % TX_DEVICE_BUFF_SIZE)
-
-#define inc_rxqhead(priv) \
-	(priv->rx_dev.qhead = (priv->rx_dev.qhead + 1) % RX_DEVICE_BUFF_SIZE)
-#define inc_rxqtail(priv) \
-	(priv->rx_dev.qtail = (priv->rx_dev.qtail + 1) % RX_DEVICE_BUFF_SIZE)
-#define cnt_rxqbody(priv) \
-	(((priv->rx_dev.qtail + RX_DEVICE_BUFF_SIZE) - (priv->rx_dev.qhead)) % RX_DEVICE_BUFF_SIZE)
+static inline void inc_txqhead(struct ks_wlan_private *priv)
+{
+	priv->tx_dev.qhead = (priv->tx_dev.qhead + 1) % TX_DEVICE_BUFF_SIZE;
+}
+
+static inline void inc_txqtail(struct ks_wlan_private *priv)
+{
+	priv->tx_dev.qtail = (priv->tx_dev.qtail + 1) % TX_DEVICE_BUFF_SIZE;
+}
+
+static inline unsigned int cnt_txqbody(struct ks_wlan_private *priv)
+{
+	unsigned int tx_cnt = priv->tx_dev.qtail - priv->tx_dev.qhead;
+
+	return (tx_cnt + TX_DEVICE_BUFF_SIZE) % TX_DEVICE_BUFF_SIZE;
+}
+
+static inline void inc_rxqhead(struct ks_wlan_private *priv)
+{
+	priv->rx_dev.qhead = (priv->rx_dev.qhead + 1) % RX_DEVICE_BUFF_SIZE;
+}
+
+static inline void inc_rxqtail(struct ks_wlan_private *priv)
+{
+	priv->rx_dev.qtail = (priv->rx_dev.qtail + 1) % RX_DEVICE_BUFF_SIZE;
+}
+
+static inline unsigned int cnt_rxqbody(struct ks_wlan_private *priv)
+{
+	unsigned int rx_cnt = priv->rx_dev.qtail - priv->rx_dev.qhead;
+
+	return (rx_cnt + RX_DEVICE_BUFF_SIZE) % RX_DEVICE_BUFF_SIZE;
+}
 
 /* Read single byte from device address into byte (CMD52) */
 static int ks7010_sdio_readb(struct ks_wlan_private *priv, unsigned int address,
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
