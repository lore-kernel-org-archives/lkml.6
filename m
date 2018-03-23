Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-212613-1521781740-2-1520973126416670205
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521781739; b=YzKOhhFW1UYLpdbqeL9DAvmgmXHy7JBQawH8W1MeQcw35e6
    KSOsLgjrdWVFL45x6ZD3LuJGVx7aNhUaVHQM6LGTDdwRoZQNTLoGOVds7Z/CzEx2
    lFLk18wpLk0yZlxioJ8QxMFsgX0d2cQGfmnFy6+JtxowivI+SOzn5Bj0Ze4wlym5
    d6eBY1lTFieT7fXu2dzs8iOZTan0ErZdoPAlMrmnYpH36OYXNf5oydt6fbs4ZyVp
    J9/oIVCZ/1SD+2UQnGzuRko78UOttGnLWW1LnAL9fLZ8AFfDJC5YC/MHMHvy7luc
    rxhxiWnQqr7qfK9LSeg0kt5+Lg6iPqpvrEXvkDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521781739; bh=3
    awhnL4RC1WoHKEdRD7TzEbMCaMoJBOpZWqNn89pqFk=; b=tMi+KqPp7Fd4vEkks
    lXCeSEkQeIvxRk1EMK5/Q3Ie9MBR0G0+XQyuAbTa1AeuooKav7MUItb+H/CVZAcQ
    LSGkzB3LHx5qOsUxcMiPX3O4ezIxRyiiWRzrRgTHhhTL62LXFY0hkE3ja0wWiHpj
    cfEv5419OZngVkpDrEIY2YifSvvk6lxtWpKX4rlIZAFQvKAT092HKeaB/rx4BN0J
    t9nwwjuWD9O/nhPKN01V/2a40CoWDV75QKUC0nqFAuTk7Yjux8IjnQ7uqyFZznyf
    HCb/pNxcZGHWynybh4BW2TVuqbdzUkGBcBr2f+sP16+aBVDPdEhXAj6ORokPDo+F
    fqBrA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 7/7] staging: ks7010: Remove
 hostif_infrastructure_set2_request_t.
Date: Thu, 22 Mar 2018 22:07:45 -0700
Message-Id: <20180323050745.28903-7-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323050745.28903-1-quytelda@tamalin.org>
References: <20180322172014.GA6801@kroah.com>
 <20180323050745.28903-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:bHb5KyniCC5qQt9MIgHzmKDzAnDQviswDSMyIyuMWO2+nmqPyfS
 ydlGC+MQhNwVOVA/7B+5qG7D/3hNrEdZpFn0JNHQ4ogSXeBJyY266Egp3Vzxc8cGoMT9Bwf
 qSMuFTfUBOJNrvv7N3PUSVeidON8wVD+YzTh3Yr40Y3Q25scFg83+A3DWst3RvQ06IYQxiF
 vY3Kyf1Alt2fnfJ7zYs+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ltC02xX+H4g=:Msr3rNBuExTwNDDNtdOIil
 wEIv1+eGwlKk6DXF3yqYkqJhSvS6YzYoEP0WiSdc/IQi5l/KBVBNZp2GDsfxA+1SZ3bcW7nJE
 AKcjYyqRwntYOcU/nLD+gkwHHw8r2lN1uQkBfTstc2vmsZe2TbmSqZFGX1P0uI4ysI8OL7v+2
 amk65XAQ7B8T8JOExxFiVhdIwGzwlYIKGRvTrKsWbu1J+OjKkFlZmz6BxFcNQDjO1spR5ZaSo
 ikM2jLshuvXYcDsv2hge9ro4Clchx6j49chWlGIQRypKaCLF0SnAdPCqZPBJ2IVrLIfWDUJgC
 0NZ4sUIn6Do9M1Ezv16vPjbGRXUlTcI35ZjWBtuMa6GTnlkMqGFhslFBRfhXF+5cxux9Mq40d
 dKkAjyrArlzwvrM/pEqA9z78un9Xs/uCESlqQFsNRm930Sf16BNii1mrxgS21vphD3vmhyOgL
 nYKQR56WewXhBuEIvy5RkAX47tkUZY53nxARWLy1Rr11BjfNrfa3LFp3JTf1ijzB+cjJel2Nm
 UIvHnAIuj7dZ/SCYVJBM9YDHdE2Nm7ZJIFSTdXGWO5mcO31ElgeDZxql9QtlQgCqBER47Usgi
 Wl9TdMu5catmu3h7+OtfbL4sOeFjSsltODMR8ViUhUrgkmkzl3OW82EaoWxG1hpATHsRe5N7l
 ZAipDW8I0afUzjql1U4JKUtxCOpNENSgSzBMjy3YzG6r13iq4askrgUn1nTxrGcCfRyHXISqD
 VMuHTz5dbCNhn/AhGXrpCESsGQLork9yXXpX1Q==
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

The handling of hostif_infrastructure_set_request_t and
hostif_infrastructure_set2_request_t is identical, with the exception
of the event type value.  Merge the two structs so they can be handled
by a single function ('hostif_infrastructure_set_request').

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 50 +++-----------------------------------
 drivers/staging/ks7010/ks_hostif.h | 16 ------------
 2 files changed, 4 insertions(+), 62 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 21219d0bbb6a..143413c3cae2 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1345,11 +1345,11 @@ void hostif_ps_adhoc_set_request(struct ks_wlan_private *priv)
 }
 
 static
-void hostif_infrastructure_set_request(struct ks_wlan_private *priv)
+void hostif_infrastructure_set_request(struct ks_wlan_private *priv, int event)
 {
 	struct hostif_infrastructure_set_request_t *pp;
 
-	pp = hostif_generic_request(sizeof(*pp), HIF_INFRA_SET_REQ);
+	pp = hostif_generic_request(sizeof(*pp), event);
 	if (!pp)
 		return;
 
@@ -1385,48 +1385,6 @@ void hostif_infrastructure_set_request(struct ks_wlan_private *priv)
 	ks_wlan_hw_tx(priv, pp, hif_align_size(sizeof(*pp)), NULL, NULL);
 }
 
-static void hostif_infrastructure_set2_request(struct ks_wlan_private *priv)
-{
-	struct hostif_infrastructure_set2_request_t *pp;
-
-	pp = hostif_generic_request(sizeof(*pp), HIF_INFRA_SET2_REQ);
-	if (!pp)
-		return;
-
-	init_request(priv, &pp->request);
-	pp->ssid.size = priv->reg.ssid.size;
-	memcpy(&pp->ssid.body[0], &priv->reg.ssid.body[0], priv->reg.ssid.size);
-	pp->beacon_lost_count =
-	    cpu_to_le16((uint16_t)(priv->reg.beacon_lost_count));
-	pp->auth_type = cpu_to_le16((uint16_t)(priv->reg.authenticate_type));
-
-	pp->channel_list.body[0] = 1;
-	pp->channel_list.body[1] = 8;
-	pp->channel_list.body[2] = 2;
-	pp->channel_list.body[3] = 9;
-	pp->channel_list.body[4] = 3;
-	pp->channel_list.body[5] = 10;
-	pp->channel_list.body[6] = 4;
-	pp->channel_list.body[7] = 11;
-	pp->channel_list.body[8] = 5;
-	pp->channel_list.body[9] = 12;
-	pp->channel_list.body[10] = 6;
-	pp->channel_list.body[11] = 13;
-	pp->channel_list.body[12] = 7;
-	if (priv->reg.phy_type == D_11G_ONLY_MODE) {
-		pp->channel_list.size = 13;
-	} else {
-		pp->channel_list.body[13] = 14;
-		pp->channel_list.size = 14;
-	}
-
-	memcpy(pp->bssid, priv->reg.bssid, ETH_ALEN);
-
-	/* send to device request */
-	ps_confirm_wait_inc(priv);
-	ks_wlan_hw_tx(priv, pp, hif_align_size(sizeof(*pp)), NULL, NULL);
-}
-
 static
 void hostif_adhoc_set_request(struct ks_wlan_private *priv)
 {
@@ -1974,9 +1932,9 @@ void hostif_sme_mode_setup(struct ks_wlan_private *priv)
 	case MODE_INFRASTRUCTURE:
 		/* Infrastructure mode */
 		if (!is_valid_ether_addr((u8 *)priv->reg.bssid)) {
-			hostif_infrastructure_set_request(priv);
+			hostif_infrastructure_set_request(priv, HIF_INFRA_SET_REQ);
 		} else {
-			hostif_infrastructure_set2_request(priv);
+			hostif_infrastructure_set_request(priv, HIF_INFRA_SET2_REQ);
 			netdev_dbg(priv->net_dev,
 				   "Infra bssid = %pM\n", priv->reg.bssid);
 		}
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index fde89bafd7fa..c262fef72806 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -386,22 +386,6 @@ struct hostif_infrastructure_set_request_t {
 	__le16 beacon_lost_count;
 	__le16 auth_type;
 	struct channel_list_t channel_list;
-} __packed;
-
-/**
- * struct hostif_infrastructure_set2_request_t
- * @capability: bit5  : preamble
- *              bit6  : pbcc - Not supported always 0
- *              bit10 : ShortSlotTime
- *              bit13 : DSSS-OFDM - Not supported always 0
- */
-struct hostif_infrastructure_set2_request_t {
-	struct hostif_hdr header;
-	struct hostif_request_t request;
-	struct ssid_t ssid;
-	__le16 beacon_lost_count;
-	__le16 auth_type;
-	struct channel_list_t channel_list;
 	u8 bssid[ETH_ALEN];
 } __packed;
 
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
