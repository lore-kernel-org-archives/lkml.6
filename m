Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1293-1519299624-2-5832670707487173733
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='fr',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519299623; b=Bf5YGXYYewg/mrZ4wZALvR0CHkLtZYJdqNZ+nJvnNSd7pHp
    yezEB+BvfpfgbLt7E5ph5WWxd7nkwZLvDQ0OOcMy75yOXO5gSUuYFT46iuQqXIol
    RPruZG0V3qSQzASbaN48fSfb3A/Yrt2G4bF+aDD5mptO8VxPEaRBtAzf0R2/aZdW
    eAwea1I1Wx8JQQ9NjIhJsB2vk1I+j2Ml66wTZa5nl5R6kWt9ln1vkgYfMxdSN2c3
    qwDYOeupXmZincm6i7OsaZ5kPEyX7Y3GOucwHHxu1IuzPbHKhjpgQV+jaKcIfhKh
    w3bV5ustk9cB3q509gdkksvkPMSrXk3WaNZk9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519299623; bh=2KaTXoukIgt9GWwwwEnkFyCPSp
    0V8RCcOKVJerkc9Ys=; b=tjhxFvPwUySLUXFT5ywRO+/NbS9eVXnjXmINSmzT/m
    zTAGfa6rGXAN+kDpxgWNwEwrSHCX/0pYZp5deHyCEWLjOgXzGvWnVCiUsLygJYKX
    wQfhj2fiJIvShDGi0oRmSEkmiKQQMG9i12XhctktnY59J/ZOc4U3TJYKENN2bACt
    xDRV0jKXJGhaAK9ctoRAavL8mjAXgNYwjzUuSFIWjR14tuP2MVuGre675PTDDE0l
    xbrmxmC7Ex7W5shYS3iwhE2zyy2DqHLPOaO6cTpGasefKbYFUQcxFIs84eT3cQrK
    xjG18hABNzO3oemFItFziIUeCAo5hs/yVT/XW3as1PdQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=mobile-devices.fr header.i=@mobile-devices.fr header.b=ocDtMq/q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mobile-devices.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=COo6PLfJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mobile-devices.fr header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=mobile-devices.fr header.i=@mobile-devices.fr header.b=ocDtMq/q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mobile-devices.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=COo6PLfJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mobile-devices.fr header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753668AbeBVLkU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 06:40:20 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52508 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753515AbeBVLkS (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Feb 2018 06:40:18 -0500
X-Google-Smtp-Source: AH8x224fqELk0dNGi3o72Kc5OwnnBkzYHHHRJXR28/GNTLdmhDTZqk6zTwt/dj9+LDMa6ReNqUsZGQ==
From: Maxime Jayat <maxime.jayat@mobile-devices.fr>
To: Ludovic Desroches <ludovic.desroches@microchip.com>,
        Vinod Koul <vinod.koul@intel.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Jayat <maxime.jayat@mobile-devices.fr>,
        stable@vger.kernel.org
Subject: [PATCH] dmaengine: at_xdmac: fix rare residue corruption
Date: Thu, 22 Feb 2018 12:39:55 +0100
Message-Id: <20180222113955.4043-1-maxime.jayat@mobile-devices.fr>
X-Mailer: git-send-email 2.14.1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Despite the efforts made to correctly read the NDA and CUBC registers,
the order in which the registers are read could sometimes lead to an
inconsistent state.

Re-using the timeline from the comments, this following timing of
registers reads could lead to reading NDA with value "@desc2" and
CUBC with value "MAX desc1":

 INITD --------                    ------------
              |____________________|
       _______________________  _______________
 NDA       @desc2             \/   @desc3
       _______________________/\_______________
       __________  ___________  _______________
 CUBC       0    \/ MAX desc1 \/  MAX desc2
       __________/\___________/\_______________
        |  |          |  |
Events:(1)(2)        (3)(4)

(1) check_nda = @desc2
(2) initd = 1
(3) cur_ubc = MAX desc1
(4) cur_nda = @desc2

This is allowed by the condition ((check_nda == cur_nda) && initd),
despite cur_ubc and cur_nda being in the precise state we don't want.

This error leads to incorrect residue computation.

Fix it by inversing the order in which CUBC and INITD are read. This
makes sure that NDA and CUBC are always read together either _before_
INITD goes to 0 or _after_ it is back at 1.
The case where NDA is read before INITD is at 0 and CUBC is read after
INITD is back at 1 will be rejected by check_nda and cur_nda being
different.

Fixes: 53398f488821 ("dmaengine: at_xdmac: fix residue corruption")
Cc: stable@vger.kernel.org
Signed-off-by: Maxime Jayat <maxime.jayat@mobile-devices.fr>
---
Hi,

I had a bug where the serial ports on the Atmel SAMA5D2 were sometimes
returning the same data twice, for up to 4096 bytes.

After investigation, I noticed that the ring buffer used in
atmel_serial (in rx dma mode) had sometimes a incorrect "head" value,
which made the ring buffer do a complete extraneous loop of data
pushed to the tty layer.

I tracked it down to the residue of the dma being wrong, and after
more head scratching, I found this bug in the reading of the
registers.

Before fixing this, I was able to reproduce the bug reliably in a few
minutes. With this patch applied, the bug did not reappear after
several hours in testing.


 drivers/dma/at_xdmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index c00e3923d7d8..94236ec9d410 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1471,10 +1471,10 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	for (retry = 0; retry < AT_XDMAC_RESIDUE_MAX_RETRIES; retry++) {
 		check_nda = at_xdmac_chan_read(atchan, AT_XDMAC_CNDA) & 0xfffffffc;
 		rmb();
-		initd = !!(at_xdmac_chan_read(atchan, AT_XDMAC_CC) & AT_XDMAC_CC_INITD);
-		rmb();
 		cur_ubc = at_xdmac_chan_read(atchan, AT_XDMAC_CUBC);
 		rmb();
+		initd = !!(at_xdmac_chan_read(atchan, AT_XDMAC_CC) & AT_XDMAC_CC_INITD);
+		rmb();
 		cur_nda = at_xdmac_chan_read(atchan, AT_XDMAC_CNDA) & 0xfffffffc;
 		rmb();
 
-- 
2.14.1
