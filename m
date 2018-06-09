Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Xan/BjrRG1sCbgAAmS7hNA
	; Sat, 09 Jun 2018 13:08:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EC9C1608BA; Sat,  9 Jun 2018 13:08:09 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIIDDBhS"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 643B26074D;
	Sat,  9 Jun 2018 13:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 643B26074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753256AbeFINIH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 09:08:07 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36188 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753175AbeFINIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 09:08:06 -0400
Received: by mail-pl0-f65.google.com with SMTP id a7-v6so7287028plp.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 06:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lOGdgsogbCjVMUN7Ghgm9ndaH3WDFvknMaCm4TobH14=;
        b=dIIDDBhSVyawWzDPDFdeE+6iiS4clHDTO1VUh4j2InpXAuoevl4VNRqsx+fE1DHQ+J
         M7bjTUYDiDyGsz5MJXuGiLMezP1hUqGEnoo572lXc9Q5wqZvR+pHJc9ju8G1+nqV9Y5t
         MZQdV2yeXY7uJmoYzzbrnXLkilyUJX9d9HCTPqpAyFSIh70R92ZW7JHDuycA9NABEyFT
         UhZ95GDCdepjSVaaFCvSiNQE25hmF6+ZQW1FhKBAvvGsmVpiWOBy1Y9SRABmd9B0Ko4W
         oCH3S9bleZcyM9YDI9Evx5Rq84fB2a6Mq0PTHOhN2ygwWxpIxAco/Iv/C8KrEVB2Sq9U
         qeug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lOGdgsogbCjVMUN7Ghgm9ndaH3WDFvknMaCm4TobH14=;
        b=c6FteFH8apqbzkACI+jVYZca6BXr8oOkFHCJKGhhKbaQjb3Z1APxCeBmwC4gtdSo7M
         P+Ska6/SKE/0b8QEZbEytzlLsAKjdQjVf5IJ3fcnjkhJFPEpX8OIm0ABZiNtQCJhYY57
         QtMOE38nVYx07pz1d2XEzny97LfIe8rALZMehlLbUdffYLPLBlPCDGDSm4GGQ5aEu/7G
         wXUkxgfzjmeS0Scd61oXGb1tIpS8D9K+9NL36ii/iHAm+4c1Mb7EEQOpVKxfZzXzAFq8
         jNyigGJ8vXWl2d9nPj+lzITpdK0Er48w7sOB3fJKFR02hLwc4xx8mCJB1Kz3UZChkeZD
         9uDg==
X-Gm-Message-State: APt69E0pMWvybjGWeaLNS9NiR3f2rTBbDLdVa78y+X/yRV036Z99kwG2
        XHmxid9Zy/mKNdnNEx/sgYRbsA==
X-Google-Smtp-Source: ADUXVKI8hLzho1yQI0CrGeUD6erSe4bId6p8eNigl4o5Xer5TkulC/wjN1fXed8ZeCAU+tNuBIFCOQ==
X-Received: by 2002:a17:902:ba87:: with SMTP id k7-v6mr10849863pls.271.1528549685693;
        Sat, 09 Jun 2018 06:08:05 -0700 (PDT)
Received: from nihaal-Latitude-E6410 ([157.50.53.245])
        by smtp.gmail.com with ESMTPSA id 10-v6sm70963235pgb.40.2018.06.09.06.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Jun 2018 06:08:05 -0700 (PDT)
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: gregkh@linuxfoundation.org
Cc: matthias.bgg@gmail.com, neil@brown.name,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Abdun Nihaal <abdun.nihaal@gmail.com>
Subject: [PATCH] staging: mt7621-pci: Fix coding style error
Date: Sat,  9 Jun 2018 18:37:42 +0530
Message-Id: <20180609130742.31917-1-abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes space after * to fix the following checkpatch error:

ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index 17f2105ec698..0543ff7d7f40 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -184,7 +184,7 @@ static int pcie_link_status = 0;
 #define PCI_ACCESS_WRITE_4 5
 
 static int config_access(unsigned char access_type, struct pci_bus *bus,
-			unsigned int devfn, unsigned int where, u32 * data)
+			unsigned int devfn, unsigned int where, u32 *data)
 {
 	unsigned int slot = PCI_SLOT(devfn);
 	u8 func = PCI_FUNC(devfn);
@@ -225,19 +225,19 @@ static int config_access(unsigned char access_type, struct pci_bus *bus,
 }
 
 static int
-read_config_byte(struct pci_bus *bus, unsigned int devfn, int where, u8 * val)
+read_config_byte(struct pci_bus *bus, unsigned int devfn, int where, u8 *val)
 {
 	return config_access(PCI_ACCESS_READ_1, bus, devfn, (unsigned int)where, (u32 *)val);
 }
 
 static int
-read_config_word(struct pci_bus *bus, unsigned int devfn, int where, u16 * val)
+read_config_word(struct pci_bus *bus, unsigned int devfn, int where, u16 *val)
 {
 	return config_access(PCI_ACCESS_READ_2, bus, devfn, (unsigned int)where, (u32 *)val);
 }
 
 static int
-read_config_dword(struct pci_bus *bus, unsigned int devfn, int where, u32 * val)
+read_config_dword(struct pci_bus *bus, unsigned int devfn, int where, u32 *val)
 {
 	return config_access(PCI_ACCESS_READ_4, bus, devfn, (unsigned int)where, (u32 *)val);
 }
@@ -270,7 +270,7 @@ write_config_dword(struct pci_bus *bus, unsigned int devfn, int where, u32 val)
 }
 
 static int
-pci_config_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 * val)
+pci_config_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val)
 {
 	switch (size) {
 	case 1:
-- 
2.17.0
