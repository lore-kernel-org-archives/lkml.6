Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2757788-1519128062-2-7194957097441221199
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endaro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519128061; b=r33bK1o4px8Q3jUOCFrp24+BUMMGJPgPl7QAHBbSF5k/kRi
    zcR5hWQSZSfLUSGY6WxOQRL9wynQoTSf2K8T2yM8lMhtdjVQypViWG2vgpTqBeFa
    JYs+fXdxTo3NwsXmOviLYZGCWj4h4uifmL/4+jbcZzilzQ5v2x1Z+B1pYYxbLYyX
    DtYpjI63OTPgKRjujS7dh/grbi/tQIbJpGkDiY2uapZNJXEXqWi1P8xkP+3BryiA
    m5fYZb8KtSP77nVAClAar/29nptC2QXOjbZj7oJxj6wH4J9ykcQbMDspJfQi+tNh
    7+C6ynbqdhVBH5XeyCI8GFsHOuBqGr0s8oDgVow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519128061;
    bh=N6EkZMfuUIwnmqw8jJC3FYQ/PwLQpvATtKpHkiK5JeI=; b=sVdK4ce06GgP
    NgGkKRZwtnHrUwcIFJnG2gEXL0E2PoKo6vy1NGmLF99w9hmfyrfhlpbyfUY5xrNC
    6NhyjPFrCutXSomIPuMJco4Fu/ByQ+4GT/J4c1d1hkGjKyFYEDM7mvBu7lolOqTg
    Posdwf0u4ds0hghwyhnVnJYu193ySKJAatdpH1domhpFraUqGDyITSohufJ3Py4K
    Ea+5IqjPF82BXqFZuuKW1lGkkfuM+Wsx7CQzDYBHRu1E4ggrGp3yvtWXnzadFR18
    lO2ehGnucpvk4EhJwkr1Gjt1Sww+v7IQ+OZ1PlNDOd5n7lMDadKpERTF9nCRBQRk
    f6SqjYPrQA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbeBTMAk (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 07:00:40 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:48581 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbeBTMAh (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Feb 2018 07:00:37 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        "David S . Miller" <davem@davemloft.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Fabian Frederick <fabf@skynet.be>, netdev@vger.kernel.org
Subject: [4.4-stable 19/22] net: hp100: remove unnecessary #ifdefs
Date: Tue, 20 Feb 2018 12:55:06 +0100
Message-Id: <20180220115527.1806578-20-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220115527.1806578-1-arnd@arndb.de>
References: <20180220115527.1806578-1-arnd@arndb.de>
X-Provags-ID: V03:K0:JC12E5hMP2Urpc49WTS1pU8OIt5BwY+2oKik/gFcb3uI55adkG5
 ZJ+Tkw+nt5mnr7RxVSSceSFjHoXsN04RKCf54q6lM5umWYxkTebkHtitHy8MvguEUznnWRB
 PPLOkJXu3rqulR632AAiRzZdClrf5mZB7E+apa2BbM06bef1bmfqi1IEHmojYLWg1BOgOF3
 cqMr3HymP4F6+iofd8jSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RzR/48J6zoE=:JsDqr9tOAWKRRJa51YyOz7
 myHAeRQiYA9vwO38j1Y+JRiQdQefXeToen51YPteZkVSdsNweyiUKZwAfGRvEQy89aF4NNQ8A
 BLQZgYSc8g+qZmlWMrnZsT74BoxJsV/oXwd6LuuKgdGVPAElGnao7lpftv1quICuUlV457fYd
 m6kGkXV5SFma6Kdf8/fgb2yrq3Bu7Jp0nnDS0BTBVX06VP820Wg7Njt7oNAEKEecxKFAk6GEn
 i0CTmNsH06/2qgMIHIRm7TuSGtG0+hfyHI8esUvaAuBirEWBk73cIeWopL90hg8ruOfa6LZXZ
 125LTO9+yPBcQOwb8d+WicWM9qOHH/LQ0TVdE7NCydnD97Hu8JRoavUZzsH27A/I/uGVAk//r
 g6BsMlcTLEDsl8vmGnRoyw/YHioT8BF14HHng4KfPKyXRTKA2+dyOkeM5uydjTOyhz3R0ZrgP
 Y4qUndRHtpTRjppg2gXDsCaUsA6WTg2ZmYevCnQlty0kCnNoTQuxNnIXPotcHX+TJBiBQSIHg
 SL2kKd3mbkaDKnofgCCg5cHfN52VU2gjwtwZLNpLZFjbN+zt3ousgNw0XH9OPd6yheniHu2Lk
 uqbnMvwviD32tCGulBiJIptOlG4Fgd6wDwMZP2FEF9XwPWwO3tHTpJ/Ug+ghwDKC9EBGb2nvO
 oI87Q6t8SVjYMr+DRNT1hGCBt1hnphUTSJ65oO1/6ZahQC7YvEX3xX+ClEeRHNOtNyg6LzQJI
 qoa/frm9TFaHD9LkQE/2/Wtt2LpqpYBkP7Pdew==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit 747a11279a442b913a57bf38934879babab3b58b upstream.

Building the hp100 ethernet driver causes warnings when both the PCI
and EISA drivers are disabled:

ethernet/hp/hp100.c: In function 'hp100_module_init':
ethernet/hp/hp100.c:3047:2: warning: label 'out3' defined but not used [-Wunused-label]
ethernet/hp/hp100.c: At top level:
ethernet/hp/hp100.c:2828:13: warning: 'cleanup_dev' defined but not used [-Wunused-function]

We can easily avoid the warnings and make the driver look slightly
nicer by removing the #ifdefs that check for the CONFIG_PCI and
CONFIG_EISA, as all the registration functions are designed to
have no effect when the buses are disabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/hp/hp100.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/net/ethernet/hp/hp100.c b/drivers/net/ethernet/hp/hp100.c
index 1d5c3e16d8f4..3daf2d4a7ca0 100644
--- a/drivers/net/ethernet/hp/hp100.c
+++ b/drivers/net/ethernet/hp/hp100.c
@@ -194,7 +194,6 @@ static const char *hp100_isa_tbl[] = {
 };
 #endif
 
-#ifdef CONFIG_EISA
 static struct eisa_device_id hp100_eisa_tbl[] = {
 	{ "HWPF180" }, /* HP J2577 rev A */
 	{ "HWP1920" }, /* HP 27248B */
@@ -205,9 +204,7 @@ static struct eisa_device_id hp100_eisa_tbl[] = {
 	{ "" }	       /* Mandatory final entry ! */
 };
 MODULE_DEVICE_TABLE(eisa, hp100_eisa_tbl);
-#endif
 
-#ifdef CONFIG_PCI
 static const struct pci_device_id hp100_pci_tbl[] = {
 	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_J2585A, PCI_ANY_ID, PCI_ANY_ID,},
 	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_J2585B, PCI_ANY_ID, PCI_ANY_ID,},
@@ -219,7 +216,6 @@ static const struct pci_device_id hp100_pci_tbl[] = {
 	{}			/* Terminating entry */
 };
 MODULE_DEVICE_TABLE(pci, hp100_pci_tbl);
-#endif
 
 static int hp100_rx_ratio = HP100_DEFAULT_RX_RATIO;
 static int hp100_priority_tx = HP100_DEFAULT_PRIORITY_TX;
@@ -2842,7 +2838,6 @@ static void cleanup_dev(struct net_device *d)
 	free_netdev(d);
 }
 
-#ifdef CONFIG_EISA
 static int hp100_eisa_probe(struct device *gendev)
 {
 	struct net_device *dev = alloc_etherdev(sizeof(struct hp100_private));
@@ -2884,9 +2879,7 @@ static struct eisa_driver hp100_eisa_driver = {
 		.remove  = hp100_eisa_remove,
         }
 };
-#endif
 
-#ifdef CONFIG_PCI
 static int hp100_pci_probe(struct pci_dev *pdev,
 			   const struct pci_device_id *ent)
 {
@@ -2955,7 +2948,6 @@ static struct pci_driver hp100_pci_driver = {
 	.probe		= hp100_pci_probe,
 	.remove		= hp100_pci_remove,
 };
-#endif
 
 /*
  *  module section
@@ -3032,23 +3024,17 @@ static int __init hp100_module_init(void)
 	err = hp100_isa_init();
 	if (err && err != -ENODEV)
 		goto out;
-#ifdef CONFIG_EISA
 	err = eisa_driver_register(&hp100_eisa_driver);
 	if (err && err != -ENODEV)
 		goto out2;
-#endif
-#ifdef CONFIG_PCI
 	err = pci_register_driver(&hp100_pci_driver);
 	if (err && err != -ENODEV)
 		goto out3;
-#endif
  out:
 	return err;
  out3:
-#ifdef CONFIG_EISA
 	eisa_driver_unregister (&hp100_eisa_driver);
  out2:
-#endif
 	hp100_isa_cleanup();
 	goto out;
 }
@@ -3057,12 +3043,8 @@ static int __init hp100_module_init(void)
 static void __exit hp100_module_exit(void)
 {
 	hp100_isa_cleanup();
-#ifdef CONFIG_EISA
 	eisa_driver_unregister (&hp100_eisa_driver);
-#endif
-#ifdef CONFIG_PCI
 	pci_unregister_driver (&hp100_pci_driver);
-#endif
 }
 
 module_init(hp100_module_init)
-- 
2.9.0
