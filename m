Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF0EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18E02145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOAXeH9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18E02145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733027AbeKNXze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 18:55:34 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:56110 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731746AbeKNXzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 18:55:33 -0500
Received: by mail-it1-f196.google.com with SMTP id o19so14740641itg.5;
        Wed, 14 Nov 2018 05:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2mDXyzbueqEFyyK00gWyNKmVjRgscRRsKN4+Ys04Ahg=;
        b=LOAXeH9erY6aHFjxtQRRKeiOEN1UhiQjAP/svDLblD30iHuedwwUP8RJ4v1PjSc+Jk
         tKGyMQFqMEAlJTpcAv1J1C8oJGkYdwhJQuSqDTVc2x7lMVVJxGW6/PnXRe0OmJL/l9Q7
         gHnuFr9IHnAn0jYYX4cT0bCzPDkPqf4v0PmTP53E/Rxh9yKMvuSOm7ucqmZuL/9MTftt
         otxnLt4Kofi2StiYgac2+aoksRE+DdIPGGOeYSBw3SFmPDuII01ECyIZAYXGma9OWlPp
         sXLdhwBQ6GQc8D0E9Letfc5lseoTqBSFO0aRpg3G9zqrwk5eQ6EtHk6xpmgRGlJEHP1T
         t1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2mDXyzbueqEFyyK00gWyNKmVjRgscRRsKN4+Ys04Ahg=;
        b=rMzfzqTPELUztbaiCqPkwLtb41XvOq1bfJWqwhnbTB6JC2qL/exNp8ITUrv9/4n9tF
         49Ra9ZUI9rEKDmA6ZWvdla7fpCxmXcMW/3T2sLp9UDqvdy3q+SJo1HJnglSO4g28qu5r
         ZjCwTZDN/fSaUWeupRV2g/v7Zi8Si3brVlZ3U1ONOBKyhKY9qR7T+W2TDjpWbmaLUzqB
         lcl605hOO7yclA+cV2ITTlY0iCfQE2FDWAzVXQItkMgOQThMRdjHFHb//is6z32aIVpQ
         N8VyYEFeqcWyhdCwsZh3wM2W3TxHZEBV2/+MpASCS0RgqO64QmKinh3kI4Mwyt4+J3mX
         cKGQ==
X-Gm-Message-State: AGRZ1gJ5DXDinR/aYHH3sUPO/RfeKJSrkDvcJIpKusBhaxXrFpNagfcg
        FqUkPfXfLhAv0tUI6mg88oC/6Wqt
X-Google-Smtp-Source: AJdET5dFf+aObUDTwRe1zY66zQXR7V+3ntYHlSvVaqA7erZYRgfQShhjX9Nz52UQjN7XoQuc9vNvcA==
X-Received: by 2002:a05:660c:706:: with SMTP id l6mr2096504itk.34.1542203532755;
        Wed, 14 Nov 2018 05:52:12 -0800 (PST)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id s22-v6sm7876443iog.67.2018.11.14.05.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 05:52:12 -0800 (PST)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
To:     svendev@arcx.com, siva.kallam@broadcom.com, prashant@broadcom.com,
        mchan@broadcom.com, andrew@lunn.ch
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, arnd@arndb.de
Subject: [PATCH v2] tg3: optionally get mac address from devicetree
Date:   Wed, 14 Nov 2018 08:52:01 -0500
Message-Id: <20181114135202.27104-1-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the tg3 has a device node, and that node contains a valid
mac address property, use that as the tg3's mac address.

This behaviour was previously only present on SPARC, using a
conditional compile (#ifdef CONFIG_SPARC), presumably because
at the time, devicetree nodes for pci devices only worked on
SPARC. However, this has recently been made universal, see
commit 98d9f30c820d ("pci/of: Match PCI devices to OF nodes dynamically")

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
v2:
	removed redundant call to is_valid_ether_addr()

 drivers/net/ethernet/broadcom/tg3.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 89295306f161..e49112cac1fd 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -55,6 +55,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/crc32poly.h>
+#include <linux/of_net.h>
 
 #include <net/checksum.h>
 #include <net/ip.h>
@@ -16959,23 +16960,21 @@ static int tg3_get_invariants(struct tg3 *tp, const struct pci_device_id *ent)
 	return err;
 }
 
-#ifdef CONFIG_SPARC
-static int tg3_get_macaddr_sparc(struct tg3 *tp)
+static int tg3_of_get_macaddr(struct tg3 *tp)
 {
-	struct net_device *dev = tp->dev;
-	struct pci_dev *pdev = tp->pdev;
-	struct device_node *dp = pci_device_to_OF_node(pdev);
-	const unsigned char *addr;
-	int len;
+	struct device_node *np = pci_device_to_OF_node(tp->pdev);
+	const void *mac;
 
-	addr = of_get_property(dp, "local-mac-address", &len);
-	if (addr && len == ETH_ALEN) {
-		memcpy(dev->dev_addr, addr, ETH_ALEN);
-		return 0;
-	}
-	return -ENODEV;
+	if (!np)
+		return -ENODEV;
+	mac = of_get_mac_address(np);
+	if (!mac)
+		return -EINVAL;
+	memcpy(tp->dev->dev_addr, mac, ETH_ALEN);
+	return 0;
 }
 
+#ifdef CONFIG_SPARC
 static int tg3_get_default_macaddr_sparc(struct tg3 *tp)
 {
 	struct net_device *dev = tp->dev;
@@ -16992,10 +16991,8 @@ static int tg3_get_device_address(struct tg3 *tp)
 	int addr_ok = 0;
 	int err;
 
-#ifdef CONFIG_SPARC
-	if (!tg3_get_macaddr_sparc(tp))
+	if (!tg3_of_get_macaddr(tp))
 		return 0;
-#endif
 
 	if (tg3_flag(tp, IS_SSB_CORE)) {
 		err = ssb_gige_get_macaddr(tp->pdev, &dev->dev_addr[0]);
-- 
2.17.1

