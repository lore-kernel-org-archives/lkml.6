Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-317056-1521781725-2-3863308988038880208
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enrosk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521781724; b=iKSK4SfloPWLP+WyceNQkkEK/zNv2+vmIS7oxQIxhRcDjMy
    cjd3cXKvOGBDZAlRBaQ9ySVg/jbXo+hL6AQOYSO4zOQRDEFGvPUawd9XwV+o7SnM
    sjmbwwZqq50NgtAtx4k6XIhApPEWmkmrJkHxDVcC6XrZvuCPvsqXoWIMbH8Jl+63
    nK2/sjlh+DZ7lXpg2o1thBFoFm2btgA1hu6uSKWEFHw3ZYA7VJLh6UAKVfv/W8ep
    h89OXyKMl09ADzAgtUrmNMAslDJWT7sz5cGpljb8++xaBYgSJIAhNrYCestyZ4vb
    VOsH3Dd2y7it/3lt8DTFL0Oc1TD0YQdOuA+Ed+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521781724; bh=E
    V5M0J8SwLfiILCN8M6jc7gCN+0X7b7twnQ2+Nz8wgk=; b=Fcz59b06z6Fp1OXBb
    q2AG5xxbN0YuJ/9I2YSFwasPHNJvww4rzlbtFUWBMIx+zEiFXA0+K9DS0NuLLrnc
    8ybdNynoQcIeJff7R2ofUXlIdjb6oi3ODPzX09aJt0g2Zi9eS+jmiZPTAtlbAYe9
    rs2qUDa2FpYXz/StI+PUuxrl8E3eBOSw31yzbdLfrxQFLTHLI7E2pFUa2INfzrg+
    hxHF6xnpR7N5EpHGuFQwh4Cbyj6ZyaUoUnU8W7uBm1Xx8rSDb8m+7Sk323eM9B9P
    2VXNCREk5kpPqBAwDB62gfvLOL2MiJ3dLXZdcxlTlLnWWHMNbGt2HpOWnJeJ0rAV
    7MEcA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 2/7] staging: ks7010: Fix lines over 80 characters due to
 comments.
Date: Thu, 22 Mar 2018 22:07:40 -0700
Message-Id: <20180323050745.28903-2-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323050745.28903-1-quytelda@tamalin.org>
References: <20180322172014.GA6801@kroah.com>
 <20180323050745.28903-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:7g7rwKStJKgoWKctekKYPefHq6SDXTL2fCuBzXjsk+PSSKw7MSl
 5zf5gVsctXH8yILv8yKsUIV23rjmsy5PWq1FqppvVpwfWIUhG8XVp24cUABvgs8CGPBK5DZ
 hdfEfNVMYny0OUVqF8/K8LgpgIG1XJ7twNdrobUCp6JqoDns3gOU50MUXCM2kys/4p5fQ34
 5dRrjDLWGDzQsejKyk/zA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OAr6S3alsok=:RefvV79mZ7t+DvRTdyHdxp
 xGaY6gzdrNyl9aFt3RapKTuYSsIhPkT9R7gyGv2DZ+lN3utl/nqFB4AmT94Xrh+hPRWDqV/yu
 7Uwa11+wESoufle/da+hqFEiGGDX/Ge+jdo6EUo2+LcT5+jEWdfj37JFSm3eByEfxkxLX1aBp
 vK2QjLxI1FQtS2O46p8jhUKhGmYub8smVLU13TFkjmk1Abq37kerAKaMJFJX8+VfUkqdcvrZO
 nEj9ccInSOUo6vQKHEmf66WpKb5pKLxoh2M7sW3d30mZ87Aj1HieBDSOPBdBu3P2M6CMgxEH6
 DgoTRd4/6GnXDwSCfWMKEwit9DcrmJ96OjPZEQnq0Jz+qIjv04SU1kM2ekqHt2SurOLF4v6Hc
 SD1n2elwx5Xmhi5VB/wDoq0mWyb1CLy7FzDdvGlVj6LiJipcT+Kav3INoYu0xZkoVPTQhJrot
 eVVCHPxS7fBAyof8af9tLQ4WB67FCGRQYcNouUym6Xv0hMTbopSiC1GE8Ii4PUmvtAUG/Ic1r
 wYGalXZlC4rGj470u/S4zWKSloZh9jy2TrQoLZLM1jvAm4IV6wtxUy4DaLhJajEjp6o2q21/X
 mhTnQrENk90Y9zQPCkjgVdZ8AS6nXnQQY1+IwwDyrAfc2KFTM35tQHTCRWmBAkMExiQpSLA6Y
 yFvCum9veKdJKny58q6t1qwLqTZDXoVJiK6NiD7+8OKg07hxk4bAm6Eqr2NBkJyNUR2/YDAQq
 PzTN9QA3OM1FllQRr/EygrRXkm0lWMG7jueQPw==
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

There are several instances where comments are spaced so far to the
right they cause the line to go over the 80 character limit.  Move
these comments to above the statements they describe instead.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 534cca95bfb9..653f6aae3420 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -277,7 +277,8 @@ int get_ap_information(struct ks_wlan_private *priv, struct ap_info_t *ap_info,
 			memcpy(ap->rsn_ie.body, bp + 2, ap->rsn_ie.size);
 			break;
 		case WLAN_EID_VENDOR_SPECIFIC: /* WPA */
-			if (memcmp(bp + 2, CIPHER_ID_WPA_WEP40, 4) == 0) { /* WPA OUI check */
+			/* WPA OUI check */
+			if (memcmp(bp + 2, CIPHER_ID_WPA_WEP40, 4) == 0) {
 				ap->wpa_ie.id = *bp;
 				if (*(bp + 1) <= RSN_IE_BODY_MAX)
 					ap->wpa_ie.size = *(bp + 1);
@@ -469,13 +470,16 @@ void hostif_data_indication(struct ks_wlan_private *priv)
 		netdev_dbg(priv->net_dev, "NETBEUI/NetBIOS rx_ind_size=%d\n",
 			   rx_ind_size);
 
-		skb_put_data(skb, priv->rxp, 12);	/* 8802/FDDI MAC copy */
+		/* 8802/FDDI MAC copy */
+		skb_put_data(skb, priv->rxp, 12);
 
-		temp[0] = (((rx_ind_size - 12) >> 8) & 0xff);	/* NETBEUI size add */
+		/* NETBEUI size add */
+		temp[0] = (((rx_ind_size - 12) >> 8) & 0xff);
 		temp[1] = ((rx_ind_size - 12) & 0xff);
 		skb_put_data(skb, temp, 2);
 
-		skb_put_data(skb, priv->rxp + 12, rx_ind_size - 14);	/* copy after Type */
+		/* copy after Type */
+		skb_put_data(skb, priv->rxp + 12, rx_ind_size - 14);
 
 		aa1x_hdr = (struct ieee802_1x_hdr *)(priv->rxp + 14);
 		break;
@@ -1090,8 +1094,8 @@ int hostif_data_request(struct ks_wlan_private *priv, struct sk_buff *skb)
 		return 0;
 	}
 
-	/* for PowerSave */
-	if (atomic_read(&priv->psstatus.status) == PS_SNOOZE) {	/* power save wakeup */
+	/* power save wakeup */
+	if (atomic_read(&priv->psstatus.status) == PS_SNOOZE) {
 		if (!netif_queue_stopped(priv->net_dev))
 			netif_stop_queue(priv->net_dev);
 	}
@@ -1163,11 +1167,12 @@ int hostif_data_request(struct ks_wlan_private *priv, struct sk_buff *skb)
 	}
 
 	if (priv->wpa.rsn_enabled && priv->wpa.key[0].key_len) {
+		/* no encryption */
 		if (eth_proto == ETH_P_PAE &&
 		    priv->wpa.key[1].key_len == 0 &&
 		    priv->wpa.key[2].key_len == 0 &&
 		    priv->wpa.key[3].key_len == 0) {
-			pp->auth_type = cpu_to_le16((uint16_t)TYPE_AUTH);	/* no encryption */
+			pp->auth_type = cpu_to_le16((uint16_t)TYPE_AUTH);
 		} else {
 			if (priv->wpa.pairwise_suite == IW_AUTH_CIPHER_TKIP) {
 				MichaelMICFunction(&michael_mic,
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
