Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1421698-1521023394-2-15985483496590602892
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521023393; b=aVBw4p1PJIB1mTH4dKoL1wHOwWDkTgBts0DQIsdxs//+OwM
    zx9D9bBXOChNL4OA2v1Of4s80cTPv7e6pmmvZdHxQpvayjd9anannZtBBLU9bzxe
    qk7tdPqWKC4oniPWIcGw+EgPcMqbvVj2FSujZMz5+BTNhZGWg8rNxmmvZlKphYb8
    lwpqd3Pp9105NKbbKgadGnNaa/6X+hBL5Qhv6p1cQ6VlF7Q4Bf3Ks4+OOziRtas6
    9/YysiEqSv8nVdj+qqPyzVOtMKckU/7LKHZipWm/JRNc2z/P3c9wsBE91YEAV9hV
    FT/pXFuiYdprTaByGnAx164C0R4NHpi4pZQmZsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521023393; bh=X4Msc/ZAasOFmRIFEtw534yhdm
    uktokdhTWHtDiT9xU=; b=SksOzAYxcAGEI3cp6ZpLwSnmKuEwYSO/jTVvFL+0KM
    F87uyxAr7hRKgI28wmb/9xS3mWFKjsKNVpwjyNdIdvTHyIgHpfitJeu9UWqfT/q8
    4TA0kpxsph4GQSv68riYjPe3nodMROQLWD/3kswOXIqbBRCo8Dxu4jS0xVBy1E+3
    wsCscwJuRN3YySu92IxGH4WV/nLu+vHJ014nAlDW/EVZFR6ecWhjq0DPx8Vuj9JL
    5sTbiB24V1jMoC4UxZRCi3f1/1cXHnGdosDTijqUl1998HFvHVHCIV6URBdnlJU4
    ne/Zb0gN6gbgSuPDbumUd59zwQFwI/7rKiJ5MJv2DrLQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=g0hl1n.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=40 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=g0hl1n.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=g0hl1n.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=40 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=g0hl1n.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbeCNK3u (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 06:29:50 -0400
Received: from relay09.alfahosting-server.de ([109.237.142.247]:23680 "EHLO
        relay09.alfahosting-server.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751228AbeCNK3u (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 14 Mar 2018 06:29:50 -0400
X-Remote-Spam-DCC: : 
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1000.0 required=7.0 tests=BAYES_50,D_SENT_WITH_SASL
        autolearn=disabled version=3.2.5
From: Richard Leitner <dev@g0hl1n.net>
To: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        bhelgaas@google.com, richard.leitner@skidata.com
Subject: [PATCH 0/3] usb: host: pci: PCI ID consolidation
Date: Wed, 14 Mar 2018 11:29:30 +0100
Message-Id: <20180314102933.21367-1-dev@g0hl1n.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Richard Leitner <richard.leitner@skidata.com>

Centralize some hardcoded PCI IDs as definitions in the global
include/linux/pci_ids.h file. This is done to reduce the amount of
scattered PCI ID definitions and hardcoded values across the kernel.

Richard Leitner (3):
  usb: host: pci: use existing Intel PCI ID macros
  usb: host: pci: introduce PCI vendor ID for Netlogic
  usb: host: pci: replace hardcoded renesas PCI IDs

 drivers/usb/host/pci-quirks.c | 16 +++++++++-------
 drivers/usb/host/xhci-pci.c   |  7 ++++---
 include/linux/pci_ids.h       |  5 +++++
 3 files changed, 18 insertions(+), 10 deletions(-)

-- 
2.11.0

