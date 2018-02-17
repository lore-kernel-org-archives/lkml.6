Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1614509-1518834149-8-5616305024031328333
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518834149; b=RJ5vrFLhv6UKtIZFuundZZJGZMSRUv2jupnRxGKnk4Nv71+
    ACkoPUjbXdPhp6WryFOsZi24u7nz76etR1qvaLSdF7eY4dDXWkjIUa8eA/1cWL2z
    IsEHePCLBjfdiiAYRTLKXavLiv8alu4dJxPhhWJHeqXHb61X8NaxkooBI4KyBQ/K
    khKiXCVSY5jtTQRlBmWhwZLbvAQn8GdXDyB6A2a0k17ToMjDuwkwfK954Ota+p9/
    CcyY3rCMq3aCqAaT9p2V8wYHFk9BZAyHUCBjH+yz4U1iprq4T+tqZoWQVLw6TARa
    NCkYSLk1OUMfnNvCtem2zfXa4t07BwtosdA0J7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518834149; bh=O
    aPirRJN3Eo/ol/hrVM89B92cc/txOLdiZZo+WNDTdM=; b=EUn6LpW26lXsgI7es
    HFTYiz60wMq1HrFkc5I3gBY8ydeo0XbmyedCM5kAvNHTM0NatnDddIzWz1gVkcFT
    QjeKabaSpxhsrPJachO1QfixROM5xXEOGGQyWtvDfWFg5yN8S0iWKe7+TB2SZpHP
    1iRiEwgSgXBBCD0l3+cZ8W+FpHXjHR60bwwO5FF6QUVpUN54A8G5XEVuInjl5eeN
    dYM0mOvCzAhd2oBIDx9BQdJ2U5ETJvKktmwVMMHwoB8AjYZuTpVrY3FgPU50AplN
    YxTirLw/7keAzi2z4U5+9Yb4I7csQE8m1k98n4RzsQKaoiAj7PntFp/TA4eVBD6A
    iA9aw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 1/4] Staging: ks7010: sdio: Fix multiple use of arguments in
 RX/TX queue macros.
Date: Fri, 16 Feb 2018 18:20:50 -0800
Message-Id: <20180217022053.24692-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.1
X-Provags-ID: V03:K0:KD96NyNk9JiAK667iTKoGcXrSC5cBb4ifqlAy/vfhREuq09SCnO
 apmX694ZlbJrwXkH5BIQ3xHujs/Ud1+9JJwrpVUkuaYugqLb7Zv8o2um5UJMVAOxK53HNN1
 ACfnp/ARRQaEq+e3pAivM10AONUBKRCMG6ZJToHo7SYR+nT0fLf13URyLiaHs4iTz5+H1Sf
 7RFRT1jWqNYHMnQbXotDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FQezg3TZkOU=:5cW8r/7WR7PtrB5FytvyNX
 EGsxC3DzAca+IuVyrzYhnCnq3tPgmq0pLwnXHAI2Id9D0xLgw2zuPQwOoGFxvL4pIciMLFCpC
 MmiQX/No0xF72bX+a9CvhpyRIMvAx4oWqvceZ940LWfGvpEAHcB0KoqxBPGegf1iwKcGKEaf2
 5bmJe9BQsdmO5PfkrS681L9HdBh2/kH2cKHCaBEAFHkkusp66d1HnBrM2qUK5MtUTNS/Dqx0L
 0ZW3HNEATwqi0AyHTZo7oz9ArDoFnEOd5Wx7BB8tE1aTXPLyPL0y6gJXZEFdRf0iglszg4+D0
 uwKTkLsIU9RoEcAna/WF4VPbtn8NO8bky0M83N0eiaWsSNmjeSG97BvUAxUFXezc3ZA6h4d7S
 Euef3MfnkqTEGsjPQg3G0Fof1Z/GdD7e7YD9dYmOlOAnlLOug7hOsDVS33CCAMIzuTZYJsj6g
 qOclNKO/W9Ahx3wQ9itt75E3p7WkZzJN+KlMWWgxUkied3/csXCsGLnB37DcF2QZX4ds5n2hF
 ycs5VUXgdhSYLC3TGgLk4rTKiQQbKULMfn9ppRdZ907pXPmbTs+EieUBerT6JnBtwviINzI48
 5UK2URw2xCoeTigYKCxILU3P7uIFvcHvowOIC4nqqQcLKjOx2hPTVnauhynvEnRprVd8oApSt
 Bp9S+uOVbACGQR7AO/ip2k9bGp7YOhvnU7pRSnzoYyzwVtg7KvNlT/EWFQvqXzD8m0SiJ9cEW
 OLkT971JRXYRZP66CdtD/AxyEOJqA5sGLbxFwg==
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

Use GCC extensions to prevent macro arguments from accidentally being evaluated
multiple times when the macro is called.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks7010_sdio.c | 40 ++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
index 8cfdff198334..ffa7e2382353 100644
--- a/drivers/staging/ks7010/ks7010_sdio.c
+++ b/drivers/staging/ks7010/ks7010_sdio.c
@@ -32,19 +32,33 @@ static const struct sdio_device_id ks7010_sdio_ids[] = {
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
+#define inc_txqhead(priv)						\
+	({ typeof(priv) priv_ = (priv);					\
+		unsigned int next_qhead = priv_->tx_dev.qhead + 1;	\
+		priv_->tx_dev.qhead = next_qhead % TX_DEVICE_BUFF_SIZE; })
+#define inc_txqtail(priv)						\
+	({ typeof(priv) priv_ = (priv);					\
+		unsigned int next_qtail = priv_->tx_dev.qtail + 1;	\
+		priv_->tx_dev.qtail = next_qtail % TX_DEVICE_BUFF_SIZE; })
+#define cnt_txqbody(priv)						\
+	({ typeof(priv) priv_ = (priv);					\
+		unsigned int left_cnt =					\
+			priv_->tx_dev.qtail + TX_DEVICE_BUFF_SIZE;	\
+		(left_cnt - (priv_->tx_dev.qhead)) % TX_DEVICE_BUFF_SIZE; })
+
+#define inc_rxqhead(priv)						\
+	({ typeof(priv) priv_ = (priv);					\
+		unsigned int next_qhead = priv_->rx_dev.qhead + 1;	\
+		priv_->rx_dev.qhead = next_qhead % RX_DEVICE_BUFF_SIZE; })
+#define inc_rxqtail(priv)						\
+	({ typeof(priv) priv_ = (priv);					\
+		unsigned int next_qtail = priv_->rx_dev.qtail + 1;	\
+		priv_->rx_dev.qtail = next_qtail % RX_DEVICE_BUFF_SIZE; })
+#define cnt_rxqbody(priv)						\
+	({ typeof(priv) priv_ = (priv);					\
+		unsigned int left_cnt =					\
+			priv_->rx_dev.qtail + RX_DEVICE_BUFF_SIZE;	\
+		(left_cnt - (priv_->rx_dev.qhead)) % RX_DEVICE_BUFF_SIZE; })
 
 /* Read single byte from device address into byte (CMD52) */
 static int ks7010_sdio_readb(struct ks_wlan_private *priv, unsigned int address,
-- 
2.16.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
