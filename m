Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4F2C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 15:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA3D20817
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 15:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t/CPF7Jr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA3D20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeKRCNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 21:13:31 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55551 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeKRCNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 21:13:31 -0500
Received: by mail-it1-f195.google.com with SMTP id o19so2278846itg.5;
        Sat, 17 Nov 2018 07:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iSONLakike+OPLvTDpLg7TloxTyS75YxrFcQZKfIgIM=;
        b=t/CPF7JrzmycPkRPKkFZq0T9zI0MOmXq9X1LrE6IRkO3veLYog45EkLmlrECoDi+Mi
         6tr57vqExJMcVdkbGFJh9i1RHYDlUeWWJ8zwiI+jiZzQR09aE/kGYqjZ9eGqS0wk2Egu
         kOQuZuNWc4Iq85O+cPtrHkQnB6d3CqBi9R8GgPhdKw5TsqrDLlE3qDoYYzeDQu5Wi/NC
         YZsKuyP+SxdEWzYAoSCQATJLD2Rvup+BLPsdCJEisnZEZr5Tcr0ISeOWedLSN0FO9v2E
         Ks0ngYn8nVaPRrt9R92lVR+kCxdmlqYKgXjB60yplcN2DrIKczAsgAL0ygQlRInJm0kc
         pDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iSONLakike+OPLvTDpLg7TloxTyS75YxrFcQZKfIgIM=;
        b=axb4KIZgUicd8UlwJ28NOOWwz1BOj0GySXGIsCGJwrsybhiv4eNEjsIqQLng489cFk
         B6I1DBMzyFzO/E6QgYpom1gQheBkiv0LWL+5WPCQGhauH7Qk2fGRqM9ypqRtFmcy06wy
         jNngUY5nwixd2NPY62utThhqR76TEtPoGwYZLG03/BwcYUz9XjTNP6xCRTYRScDiwATA
         lVLCa2OAxq5ZXUY2emMwpVHRjBuL2kHFNVwBXnQftAmcmEjhr9hXivkBREs1fQy2lgZJ
         3wWo2qbiSKJ9LttsvuaWLKDt50yZlZlrxkjypNTrxYpxanshtxvFyvSL7Opkg5RMjmC+
         4alA==
X-Gm-Message-State: AA+aEWb03Rrsm1V+84dtqTwDhjDREWr31MGvCg1JDj59jqhB7RhS5jDf
        yCowH9BLGztEsHe/6OP/a7I=
X-Google-Smtp-Source: AFSGD/Un5bQRhq/Z3fujd25VdeYrd+fSDZ2pVeDtuWIcL+jIRnsPnwnt44D605LsO4zv76yrx0LEhg==
X-Received: by 2002:a05:660c:8c2:: with SMTP id g2mr2392321itl.22.1542470185782;
        Sat, 17 Nov 2018 07:56:25 -0800 (PST)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id g4sm1164163iop.49.2018.11.17.07.56.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 07:56:25 -0800 (PST)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
To:     svendev@arcx.com, siva.kallam@broadcom.com, prashant@broadcom.com,
        mchan@broadcom.com, andrew@lunn.ch
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, arnd@arndb.de
Subject: [PATCH v1] tg3: optionally use eth_platform_get_mac_address() to get mac address
Date:   Sat, 17 Nov 2018 10:56:18 -0500
Message-Id: <20181117155618.19486-1-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function will try to determine the mac address via the devicetree,
or via an architecture-specific method (e.g. a PROM on SPARC).

The SPARC-specific code in this driver (#ifdef SPARC) did exactly this,
and is therefore removed.

Note that you can now specify the tg3 mac address via the devicetree,
on any platform, not just SPARC:

Devicetree example:
(see Documentation/devicetree/bindings/pci/pci.txt)

&pcie {
	host@0 {
		#address-cells = <3>;
		#size-cells = <2>;
		reg = <0 0 0 0 0>;
		bcm5778: bcm5778@0 {
			reg = <0 0 0 0 0>;
			mac-address = [CA 11 AB 1E 10 01];
		};
	};
};

Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 42 ++---------------------------
 1 file changed, 2 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index e6f28c7942ab..cfffddba06ce 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -66,11 +66,6 @@
 #include <uapi/linux/net_tstamp.h>
 #include <linux/ptp_clock_kernel.h>
 
-#ifdef CONFIG_SPARC
-#include <asm/idprom.h>
-#include <asm/prom.h>
-#endif
-
 #define BAR_0	0
 #define BAR_2	2
 
@@ -16984,32 +16979,6 @@ static int tg3_get_invariants(struct tg3 *tp, const struct pci_device_id *ent)
 	return err;
 }
 
-#ifdef CONFIG_SPARC
-static int tg3_get_macaddr_sparc(struct tg3 *tp)
-{
-	struct net_device *dev = tp->dev;
-	struct pci_dev *pdev = tp->pdev;
-	struct device_node *dp = pci_device_to_OF_node(pdev);
-	const unsigned char *addr;
-	int len;
-
-	addr = of_get_property(dp, "local-mac-address", &len);
-	if (addr && len == ETH_ALEN) {
-		memcpy(dev->dev_addr, addr, ETH_ALEN);
-		return 0;
-	}
-	return -ENODEV;
-}
-
-static int tg3_get_default_macaddr_sparc(struct tg3 *tp)
-{
-	struct net_device *dev = tp->dev;
-
-	memcpy(dev->dev_addr, idprom->id_ethaddr, ETH_ALEN);
-	return 0;
-}
-#endif
-
 static int tg3_get_device_address(struct tg3 *tp)
 {
 	struct net_device *dev = tp->dev;
@@ -17017,10 +16986,8 @@ static int tg3_get_device_address(struct tg3 *tp)
 	int addr_ok = 0;
 	int err;
 
-#ifdef CONFIG_SPARC
-	if (!tg3_get_macaddr_sparc(tp))
+	if (!eth_platform_get_mac_address(&tp->pdev->dev, dev->dev_addr))
 		return 0;
-#endif
 
 	if (tg3_flag(tp, IS_SSB_CORE)) {
 		err = ssb_gige_get_macaddr(tp->pdev, &dev->dev_addr[0]);
@@ -17082,13 +17049,8 @@ static int tg3_get_device_address(struct tg3 *tp)
 		}
 	}
 
-	if (!is_valid_ether_addr(&dev->dev_addr[0])) {
-#ifdef CONFIG_SPARC
-		if (!tg3_get_default_macaddr_sparc(tp))
-			return 0;
-#endif
+	if (!is_valid_ether_addr(&dev->dev_addr[0]))
 		return -EINVAL;
-	}
 	return 0;
 }
 
-- 
2.17.1

