Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2068237-1522510939-2-2247662419231338308
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522510938; b=GZLWfP4e/Kqlgx0n/RJ2pjXzTOZGo9+V+CuinE+K9TMXuVC1Xi
    1mq00edLAzgWmTQP45yWeFOvp6aQIvmxneHYg2SKb7zy1UHCekCAWR7HgEfSHyKK
    GDWDX3ilPKPs+Zp1x+kFQZcrwoaoB/9RJ+MrVjkCacYm2pWfTUbEKRZfDez3ukZ9
    O8wdqw07OfrlAfeDRQRbImJZ9QpPM23n9TgEPjIcw3zTRVDNWVvz1hj4Alt/Hh2v
    A301m8o/8+uS/y7wnXlh6eFSKrcw7iVFnFTjYFwKsayQ3xE0jnQWdfW+JzjrOtdL
    k9keYRU21o9xV4LASS7LGbmPfoCG+DSWA4fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1522510938; bh=CMMeFIHUvEgdD4fdsxJu9YXk2Zy+Qk
    jhXG9k/UsAWO0=; b=s7bjQHLrWgv6qJbXgzbYFZu0cfE8VmuYvXV3b4tvWjwu0c
    vZ1yiH9mStDqp0RlM8GpSlPifG8s+6TW/DF0PHGnppfnj5SrVLI0BbewN1UmPGE8
    RnJpE/+74skMPF12ti5tkPNMNKyQvl+awKVznnTrH3dbWqsARZxyzSL8QOsa9fl/
    hYmXwIZ6rpXr2beW2ry6bcl90m1AJ9mjx9ybJahuOPQkXc9W7AgiPM7/qIStPit1
    jiRGBtcYBAcDH90lEYcBv7BXgaiGJ5Apse5Y/n1lAvtQ++XUkk0nXRxl+OH95jJ0
    TdalQ9oeqRCcMpVi3Puwvr+PKKZKf6DMBt47ZC9w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO3rkasa+GtNCg3oYV1w5ZQ4A6D92Y9Y0Ac2X97fYoqLTeqreSKs2DDnT8wb9F237WdlKtp6hxMYROUCENOsxuj+wnYIO30qowWsKRcUYdPG4bX2CQEi
    Es9u7njNLGKXVx+Kj68vtZoX8w8E0roB3BWd4MDOuvZPGDqo2itlVtMOemmKV1AYB54ldrRGFxPnqlbRotnWvYV6g2oozB4FT9mWgsTsncQhMVUtub0zUOfq
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=danhDmx_AAAA:8
    a=VwQbUJbxAAAA:8 a=DfNHnWVPAAAA:8 a=APxziFbbeBc5x69s2ecA:9
    a=P4VdviVPEcjfz_PVVggX:22 a=AjGcO6oz07-iQ99wixmX:22 a=rjTVMONInIDnV1a_A2c_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752598AbeCaPmO (ORCPT <rfc822;greg@kroah.com>);
        Sat, 31 Mar 2018 11:42:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48245 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752423AbeCaPmO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 31 Mar 2018 11:42:14 -0400
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: mlindner@marvell.com, stephen@networkplumber.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Stable <stable@vger.kernel.org>
Subject: [PATCH] sky2: Increase D3 delay to sky2 stops working after suspend
Date: Sat, 31 Mar 2018 23:42:03 +0800
Message-Id: <20180331154203.5562-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.15.1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The sky2 ethernet stops working after system resume from suspend:
[ 582.852065] sky2 0000:04:00.0: Refused to change power state, currently in D3

The current 150ms delay is not enough, change it to 200ms can solve the
issue.

BugLink: https://bugs.launchpad.net/bugs/1758507
Cc: Stable <stable@vger.kernel.org>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/net/ethernet/marvell/sky2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index 9fe85300e7b6..5754116a6a4d 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -5087,7 +5087,7 @@ static int sky2_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_WORK(&hw->restart_work, sky2_restart);
 
 	pci_set_drvdata(pdev, hw);
-	pdev->d3_delay = 150;
+	pdev->d3_delay = 200;
 
 	return 0;
 
-- 
2.15.1
