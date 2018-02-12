Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2169032-1518466860-2-7520831238737437203
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518466860; b=mzMgGz2SVfqUXhsdYg0Lr24hJ9tRFycYaK2fxP+MEAXpxX2
    9NiUstGzydmdU5eI9JKVgjVHYXySvRs1SbQ47lH6AAbM4Jrf4e4GcI5chrUIQ34c
    EQAAJqYn0ViFXIFMln+Vh/Gy1x+CrNDWJGD772ol18X/MqMa3qn4VwYbesM5prYH
    yE74B170mwwxYyQ7Aa6KSamKEAND2YtN9i15KAlGjqcZHcGRci08D66dgzoQyte4
    UpF7Jx1HN8DUqjwWCRIda6+X8r+v7mNpCmX88pz2WHUxtc0+G9EtctBra5Mh/zDP
    JitfT1VqkNagYJhMtUeMCYagg84DMTN6z7CKjFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518466860; bh=YMjOEin0z0ZLNo1FpZUQpSbL9I
    5hrwYU/ii2do5IZKY=; b=KdSNyOFU6BMldApPFH9lQgbrvi7PvrCO9mphLEztRe
    tQOmsBbU0hHRXTvwlbswM+ZVLwDylF4n2iU7AnDmZ8uZVOB4AAuX5nY22TKpmk2U
    wKpOzUmUJW0TnUFfOHKf+PN5kbHsy9Nkn5f5+n5VCKxAMD2wItrjRqh/l0M0Qk9+
    4Rnk1iAQ8E5umwN0bnHPX3e4160Rct8M5eSFdHbR/ZK2iXJNRKlIeJ/sdGOMY0UO
    xn8bieZWdD3yueUrqsix1Iz5srCanCjCQvff5cTk5GBUUAvMuPf6jl6fOKUQ25x+
    ab+n5Hne7wvd9sowEGyUSj7/KmLTXx16qMoAoLBBXZ2w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=i2se.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=i2se.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=i2se.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=i2se.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932139AbeBLUUn (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 15:20:43 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:46519 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751725AbeBLUUm (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 12 Feb 2018 15:20:42 -0500
From: Stefan Wahren <stefan.wahren@i2se.com>
To: John Youn <johnyoun@synopsys.com>, Felipe Balbi <balbi@kernel.org>
Cc: Gevorg Sahakyan <gevorg.sahakyan@synopsys.com>,
        Minas Harutyunyan <minas.harutyunyan@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH] usb: dwc2: Print error if unable to set DMA coherent mask
Date: Mon, 12 Feb 2018 21:20:08 +0100
Message-Id: <1518466808-30318-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K0:2jNFc0A5hGkCW92jd4oH8ZsdT4xFW4cozKwtn7KMjs0r7P/jfUz
 uQ600Br8TW7TOJDUJo07KXsQO1xphGGTrfnOsCMTtqz2pXCyop88Fkmu5jaJDYtiRAmEu+t
 4sAHVhjX72mf5TE9/fdgHvpiyphrO5lPHKq0ehjReAIvq4IfELhT0bhygU7XPo4OyvVDjP+
 zFoyn95W9wMGpYSWM38zA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NlyBiB39s6M=:KoTosZ6TNET4nX5i5Ps5vo
 WljKs9ZguMznBChBoT2cGx9fkhHfsJXb44hn2mBMFTZLEU1A63kjPuP5wSU4Ax57dsBDMx4aY
 xCkzbQ+tUjXS8t+Mmt2PUt1HINK/CZIs3yhrodNDXlNZDlnqq2qozCJUGY3lQiqqaS5dX60ot
 XSDXEqdyJ4bJqOnkJ+W/uypAAMIqgA4OekvUwfkRC3w0cwmz418wqTzIwIRLhxt6NmzCHz6aB
 nVQioocCCsPteIPsvDPXrF3fC0a3EZ6H8Gncsn05JRq63zJjhOF8hGAZEjM60etOSJ8Zn+Dbn
 rlI0UDkIPur1CiaGRNXOoWQA8FxQP+Sj8SUx9fdfpOjt0AdosdgcMUgw6sg7HBpxsZ+WQs/U0
 3DwenXeZKAwwQENgozMbRaN+kzKKUm5CKHgCp/ABPkEcwcoZ3vFg2uFFfUpDE1iTl2nZAheNT
 uVH/L7jaHYSXAdfAtJLQ4ZtjBNKThaoOEp9OAb1pWNMtAv903V+/+z6lKmPQT8IPAeogbAsLz
 i2E7iXpjueVHq3lGRoCxpoji0r10n3fk5A1tycEiMAUFftAT+qE3jlF+I+a7nshmD+8rG83OO
 TGUIh3cqKb4iM7dztZvb0rKOBBgdfF3snhzZJvBDb9K1a0Bcbv5BSz674Ph1KRzS+nt41xeZe
 KiUyemEuJtFB/IxhGfmipNBnwbrBYRYwew4s7cPaWAwjIBGNDzkLDh3Igxp6HxSPWt/BZLB0h
 5o9c3rRwgrhPi5/ymqD3ZSzjADolOT7iEfgbK9mUHb2eOYBL0C55zE7VMLk=
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We better print an error in case probing of dwc2 fails on
setting the DMA coherent mask.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/usb/dwc2/platform.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 4703478..4ddbdbd 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -382,8 +382,10 @@ static int dwc2_driver_probe(struct platform_device *dev)
 	if (!dev->dev.dma_mask)
 		dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
 	retval = dma_set_coherent_mask(&dev->dev, DMA_BIT_MASK(32));
-	if (retval)
+	if (retval) {
+		dev_err(&dev->dev, "can't set coherent DMA mask: %d\n", retval);
 		return retval;
+	}
 
 	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	hsotg->regs = devm_ioremap_resource(&dev->dev, res);
-- 
2.7.4

