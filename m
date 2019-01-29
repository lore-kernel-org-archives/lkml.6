Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5612C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D91520989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Si+Lg0Hb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfA2Frt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 00:47:49 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37105 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfA2Frt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 00:47:49 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so8874949plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 21:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ewYfN0obHUWrYcAHPIT7FDVvvTZ/xG9S0yTO7uTJHbk=;
        b=Si+Lg0HbfuR6gXaB9ex7WhkWhJ//j4sVTekUi6vhExllS2dSCZGi24olpXRs1Ej4Nk
         0QVknIFuI07/kB/CQA268OWZ5kUKtUVB4ELyH7XUJNKHrOSIdAj4Y5eC1C/4vG657lfr
         QMoXuO0x/aj1xiirVp46Ao1R+ESmFcsdqVyF764etiNiHESVKQsH0BdvLfRKZh6odo/A
         8t5tqmAGzslstJZsuwx5bzhtx6WMU5f6r8gO4aE11BhitQ3RBvskCWmjzGtxU4oVYeaW
         /tkUGKNFKQMZ37V47asncoyJCrYK3oT9T8BvQx3CzFPLhSNf7wsBGmB8pWeIUpLdQqoi
         9LdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ewYfN0obHUWrYcAHPIT7FDVvvTZ/xG9S0yTO7uTJHbk=;
        b=bhum50SHAcgGdvQnE2dk4cV7sPVUyz5aQuCiDRymC6bMWiAyY/oD9ahguYxCsY3IBV
         9DS6s6iQIYAz4TLO3+jP3LuTycCV+GvwU9BlU0WRlQqomLh1OlHk60dLremFiIYkNUlV
         CCvl3T9zLAh2uE5U7U2n2RZmy8YEml855WRp5wEnx8zL1qYhJGU31uFFE2aEGUYIOQBN
         n8BVL8QACEfmXCPDn2YzZoaMTkLvhkfHhf3l9xh6Wpeq/zBe6LWI7EUzqOhKgSYQUGqO
         Ru1gy0FSiWp8Lg7pzZUxaAtsSzD+mFZi+fo2jwy+3NZp7D1CCSPzSvJROjx6A7b/bX2n
         1+oQ==
X-Gm-Message-State: AJcUukcqPvwmAjjKWzIKUL39xsM7pmxpmdWzKWWAds2z0dZzHXk1k3e1
        EHsQbsur7akBYhINpxsauOE=
X-Google-Smtp-Source: ALg8bN7u+qoN1deGQmWkozQMOFcJ3yTrAbjup8Kv32SUsEv9LFyheaGNA5bLvRaHuWCbe0JTSxVDCg==
X-Received: by 2002:a17:902:108a:: with SMTP id c10mr25008673pla.131.1548740868942;
        Mon, 28 Jan 2019 21:47:48 -0800 (PST)
Received: from test-System-Product-Name.sunix.com.tw (114-36-229-251.dynamic-ip.hinet.net. [114.36.229.251])
        by smtp.gmail.com with ESMTPSA id s15sm12396851pgv.59.2019.01.28.21.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 21:47:48 -0800 (PST)
From:   saumah <saumah@gmail.com>
To:     sudipm.mukherjee@gmail.com
Cc:     morris_ku@sunix.com, linux-kernel@vger.kernel.org,
        saumah <saumah@gmail.com>
Subject: [PATCH] parport_pc.c change for fix hanging problem while suspend machine. parport_pc.c has the samevendor id and device id definition as sunix multi-I/O board driver, when the sunix multi-io board driver is installed, it will cause operation error
Date:   Tue, 29 Jan 2019 13:47:32 +0800
Message-Id: <20190129054732.3036-1-saumah@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: saumah <saumah@gmail.com>
---
 parport_pc.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/parport_pc.c b/parport_pc.c
index 380916b..8c163b9 100644
--- a/parport_pc.c
+++ b/parport_pc.c
@@ -2622,11 +2622,6 @@ enum parport_pc_pci_cards {
 	lava_parallel_dual_b,
 	boca_ioppar,
 	plx_9050,
-	timedia_4006a,
-	timedia_4014,
-	timedia_4008a,
-	timedia_4018,
-	timedia_9018a,
 	syba_2p_epp,
 	syba_1p_ecp,
 	titan_010l,
@@ -2679,11 +2674,7 @@ static struct parport_pc_pci {
 	/* lava_parallel_dual_b */	{ 1, { { 0, -1 }, } },
 	/* boca_ioppar */		{ 1, { { 0, -1 }, } },
 	/* plx_9050 */			{ 2, { { 4, -1 }, { 5, -1 }, } },
-	/* timedia_4006a */             { 1, { { 0, -1 }, } },
-	/* timedia_4014  */             { 2, { { 0, -1 }, { 2, -1 }, } },
-	/* timedia_4008a */             { 1, { { 0, 1 }, } },
-	/* timedia_4018  */             { 2, { { 0, 1 }, { 2, 3 }, } },
-	/* timedia_9018a */             { 2, { { 0, 1 }, { 2, 3 }, } },
+
 					/* SYBA uses fixed offsets in
 					   a 1K io window */
 	/* syba_2p_epp AP138B */	{ 2, { { 0, 0x078 }, { 0, 0x178 }, } },
@@ -2738,12 +2729,6 @@ static const struct pci_device_id parport_pc_pci_tbl[] = {
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, boca_ioppar },
 	{ PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
 	  PCI_SUBVENDOR_ID_EXSYS, PCI_SUBDEVICE_ID_EXSYS_4014, 0, 0, plx_9050 },
-	/* PCI_VENDOR_ID_TIMEDIA/SUNIX has many differing cards ...*/
-	{ 0x1409, 0x7268, 0x1409, 0x0101, 0, 0, timedia_4006a },
-	{ 0x1409, 0x7268, 0x1409, 0x0102, 0, 0, timedia_4014 },
-	{ 0x1409, 0x7268, 0x1409, 0x0103, 0, 0, timedia_4008a },
-	{ 0x1409, 0x7268, 0x1409, 0x0104, 0, 0, timedia_4018 },
-	{ 0x1409, 0x7268, 0x1409, 0x9018, 0, 0, timedia_9018a },
 	{ PCI_VENDOR_ID_SYBA, PCI_DEVICE_ID_SYBA_2P_EPP,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, syba_2p_epp },
 	{ PCI_VENDOR_ID_SYBA, PCI_DEVICE_ID_SYBA_1P_ECP,
--
2.17.1

