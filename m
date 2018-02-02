Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1920597-1517561055-2-7305933064333958457
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517561054; b=C3sy6FhbZexbgq4uKP7h0w/wQe2AVX3T7+LdfU8q35DqTil
    v6EwhRJiiYrtpcVukxQfnJslzNAYv3ahQJNBCSS2W5GDWUfL0LbSmTxiuHIEpWbo
    fuZTfBgLyQTcAf1dhBpi07ZK8NiIjcX8tPOKvJw0bnlUUhDs3aGcQW9ptR6yzyZw
    mU77uwjHGypb69/GBRTuHZn//ko+QcHr82h7/oMOH1IImqUt0WwJ48sFNRyIn4/9
    ZmQ7yJj8NoaZLbTI0mMS4AK/Y/Mu7LviFxDxPrUIvBFaNX5eKpK5T93kyo2/61p3
    LxqTLINXpZK6zFbl11Vb35cJr0oT8dbEpynRkpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517561054; bh=pBDCqlB77hYlgLemXT7qycTov7
    S4VVNHFwh9aUISrzc=; b=msoIHJLWbwTkNy9bP9dvB1EtVbAA6QfgbnfXyavwy2
    +8kvj9fdik6TgW+Er8a5X4Kn6QGbjnRDsa4jyii8BVzZvvHIKznjuu38FUn40z4q
    gqSbz1cnbky74SaHbohZsjQaOmVkTFkwGn9t9Y35bxBCJahH7J7uXE3mHunqxuC1
    ZKuWifqBvzQ0WdXPw7URiJAgM0Hm5dohMgKzaVdgshbojrOEqDBqIiRW7Z9Nv4Yt
    pBUoC9J46k3MpqZTirtRYVEFjQpnmId+q0XG4EVAWJXt5rFcVtHj1YF9bGuwSXIu
    tSn5cAzjhFBaz6eYsO2Rnt5nimTAMpjfjeq0itKMbhpA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=realtek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=realtek.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=realtek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=realtek.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeBBIoE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 03:44:04 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:46689 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751822AbeBBIoB (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 2 Feb 2018 03:44:01 -0500
Authenticated-By: 
X-Remote-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID w128hwc5023476, This message is accepted by code: ctloc85258
From: Hayes Wang <hayeswang@realtek.com>
To: <netdev@vger.kernel.org>
CC: <nic_swsd@realtek.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, Hayes Wang <hayeswang@realtek.com>
Subject: [PATCH net 1/2] r8152: fix wrong checksum status for received IPv4 packets
Date: Fri, 2 Feb 2018 16:43:35 +0800
Message-ID: <1394712342-15778-284-albertk@realtek.com>
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <1394712342-15778-283-albertk@realtek.com>
References: <1394712342-15778-283-albertk@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.177.200]
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The device could only check the checksum of TCP and UDP packets. Therefore,
for the IPv4 packets excluding TCP and UDP, the check of checksum is necessary,
even though the IP checksum is correct.

Take ICMP for example, The IP checksum may be correct, but the ICMP checksum
may be wrong.

Signed-off-by: Hayes Wang <hayeswang@realtek.com>
---
 drivers/net/usb/r8152.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 0657203ffb91..756de9ea8d2e 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -1848,11 +1848,9 @@ static u8 r8152_rx_csum(struct r8152 *tp, struct rx_desc *rx_desc)
 	if (opts2 & RD_IPV4_CS) {
 		if (opts3 & IPF)
 			checksum = CHECKSUM_NONE;
-		else if ((opts2 & RD_UDP_CS) && (opts3 & UDPF))
-			checksum = CHECKSUM_NONE;
-		else if ((opts2 & RD_TCP_CS) && (opts3 & TCPF))
-			checksum = CHECKSUM_NONE;
-		else
+		else if ((opts2 & RD_UDP_CS) && !(opts3 & UDPF))
+			checksum = CHECKSUM_UNNECESSARY;
+		else if ((opts2 & RD_TCP_CS) && !(opts3 & TCPF))
 			checksum = CHECKSUM_UNNECESSARY;
 	} else if (opts2 & RD_IPV6_CS) {
 		if ((opts2 & RD_UDP_CS) && !(opts3 & UDPF))
-- 
2.13.6

