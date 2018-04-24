Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3069549-1524575946-2-2107447222004090659
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524575946; b=mT/oUR76EgGOxDseC0oFbXLHfSd2djiUx9cXgWUOvuasF/4GZt
    aMqKsKXzQ+KiuRJednVJmlBHyfX9IraKDT/HWYoKfrkUR0ZM1BnNqD7MCqr448e/
    PxiQ6OQZPV+h4vOR4NFpCAU+s3huLG9XIJngD1bprN/t1mRWCRNMkhg9hWIyA/AU
    tt37t9qOlKnT5jjzEzk3XodtdzF98UzgW0dTyxMv+0VOa6Y39VVZ5fR9HcmM11rI
    NSRIzzzKCskx/TGfHK4ejOfaybaE6cBgXJlQxZTCGrzvEv/RfNTU/ye3oy2hr9J+
    W7/riu6mQkM/q04TLTtCwJ62uFHkt+ARpw+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524575946; bh=ja6lj
    hcYy2ION0XtJRC3gLT40ke90BJNqr+vI7iJoyc=; b=RbNnsLASVS3kxwqIvmsGL
    c4oFXyLXYTPtGeyneXRBBckpiLU4w66KETbzojATb/sc1sDXH8j6aF90GimJryN5
    I0ut0Vov/8jlyxNq2PzWxS5bUahvOi92+MoOxX9HWkz2Ll3dev7U8REmW1KGdmNO
    G2JA9wplmIqlncKt4O9+C8pQj1+SwjJBufhwaq2At9uTtFkOxCiqapWD5lNggzT8
    hg3S7a0EuCWZqapI5Xt0h/DzqGaYh7/+Cpuiwagpdr/JL6FWkjamqS7yr6xGEobt
    MOQcKxnGEiDWefXSmRQeTgKrhE2FTipjJcUbfZE4jtQ+AAg9abp7NL3mqYqysGdz
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HcuKoJWp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iRvFw2VH;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HcuKoJWp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iRvFw2VH;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPGBYz/fUzBqU/U9V79fP6yhi7UVRoDaaTl5kKYDNmoLT6x7cEpugGQkk+qS/7iZMqXiHBH2yR/y+aaXKDqyeLvPUHBBaknsHkF7R7ElFCImdG62JB+1
    Io4enVpc4fhMR+Ju8TYQfR/Rus2fw92Kg0iTwl3WrUZ+CDKSYilK7Kmvud3U/sBbHEEXegrYBPFWyVpkZwaGI+dr2eXZghQuNm64GdazryN7+YFVidWHrOPJ
    UrtDj6i00lVCYvGEmcU0XQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=UWLGKgljVrAA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=w9j5uuQj-3BbXOR1XwgA:9
    a=S72Gwef-e_TOMxmf:21 a=KOc_-KXR5j8uQGP7:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx484Yg5NYSao4yfnzkjLo9A2+9UPktymcb4K3/UIKTUScGO7xuiX1cfi4OU61IYhhTbrkSxnzw==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] staging/wilc1000: fix wilc_mac_xmit()'s return type
Date: Tue, 24 Apr 2018 15:18:57 +0200
Message-Id: <20180424131857.5668-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, Ganesh Krishna <ganesh.krishna@microchip.com>,
 Aditya Shankar <aditya.shankar@microchip.com>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, but the implementation in this
driver returns an 'int'.

Fix this by returning 'netdev_tx_t' in this driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/staging/wilc1000/linux_wlan.c | 2 +-
 drivers/staging/wilc1000/wilc_wlan.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/wilc1000/linux_wlan.c b/drivers/staging/wilc1000/linux_wlan.c
index 38a83bd31..e06aaed5e 100644
--- a/drivers/staging/wilc1000/linux_wlan.c
+++ b/drivers/staging/wilc1000/linux_wlan.c
@@ -941,7 +941,7 @@ static void linux_wlan_tx_complete(void *priv, int status)
 	kfree(pv_data);
 }
 
-int wilc_mac_xmit(struct sk_buff *skb, struct net_device *ndev)
+netdev_tx_t wilc_mac_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct wilc_vif *vif;
 	struct tx_complete_data *tx_data = NULL;
diff --git a/drivers/staging/wilc1000/wilc_wlan.h b/drivers/staging/wilc1000/wilc_wlan.h
index fa157a67b..d3b5a6b38 100644
--- a/drivers/staging/wilc1000/wilc_wlan.h
+++ b/drivers/staging/wilc1000/wilc_wlan.h
@@ -298,7 +298,7 @@ void wilc_chip_sleep_manually(struct wilc *wilc);
 
 void wilc_enable_tcp_ack_filter(bool value);
 int wilc_wlan_get_num_conn_ifcs(struct wilc *wilc);
-int wilc_mac_xmit(struct sk_buff *skb, struct net_device *dev);
+netdev_tx_t wilc_mac_xmit(struct sk_buff *skb, struct net_device *dev);
 
 void WILC_WFI_p2p_rx(struct net_device *dev, u8 *buff, u32 size);
 void host_wakeup_notify(struct wilc *wilc);
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
