Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3118118-1523473402-2-13707191444294370981
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523473401; b=HZslZDRXUoSGlTiORmLQ/Sq0pY9Av+adKQRn5U4D7LW/n/iH91
    IEu4YiW7g/LVxrlrgTQYe9Hqw+Aa9R3i7W00cSEN8LRLu/92b10Q8LCUc//Fmu5J
    xpqbNRHkN7YoVo8U55ZnUCQYkUijFwXEONz6zUsebY6NXqjv4B//lt6cJOs6OFM7
    laRlMmj+n2EGeKyNOdZI7i/hwKLzM8gnFD6Gm7TKwKcGBg4x2TmsRb66j+n2A/Dx
    mnZo3FZl6oMmZdIKhJlMErGBXSE0N2CkW7gkIWTjLCWIWjdHRZ5Wr3Wn7/1Avqi9
    Tz/EjnRd3OA5oJaT3jovO+b4CtaWJdHMNB7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473401; bh=Vb4v2lAC9KmCu5bMuCaTCaoNNdAEOI
    FuILyywHKKnw8=; b=b6IT50WgH4fF7s6HVVkIZg3vq2D+7ov6euGbWdHAnsnd92
    0fYg4Zi9HoAL06FM/Jm4RJODzJYDTgLkSgihkXCV7lMJa0CFv3J/ajQm8BjkiGA9
    uPjyKxi84EwMgpzFOJxNjlKYeXAVc8qc+fiOxy6upinhrrarSZcP9s7q0yIwolEU
    vyi4NSXVYn8/6mSjdxd7qhrVcTi2zqyvFMypQlho1TitEpSSs28ddo5Q6ja3KOv2
    FqK6RvYcuMTNLsTctURC9naVM/5XAevCc9SJF9c5M+i51d5D1CLeBSjJ2V0t2SIQ
    nAOYAgDfKkrQ5X7SlZlDgATSytxNVTRXkAqjW9sg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH/laqnGHIxhpFaZsFidSOipXZNFdJ9eVIdO0rdGBJTSavn63EsWwkESBe7soAfznkcn/nxSIomv92vDi3myxuGj9yMbXBV23tO+7RtBGcvJRsLWlNnb
    muntA5agL/HIXQs5ES/NpAKIedlzN8DpZupZ26PvCUk0ZO2YVxhMKfWgbDzLWT11iuTx28U5wofLoo/e+3lklZ9ImV6LHoG/JrfmcwMrUhtHRj7eXtTLzouK
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=bwp1d1LMin3rYjiltOcA:9
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933409AbeDKTDR (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:03:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38862 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934625AbeDKTDP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:03:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mario Molitor <mario_molitor@web.de>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 232/310] stmmac: fix ptp header for GMAC3 hw timestamp
Date: Wed, 11 Apr 2018 20:36:11 +0200
Message-Id: <20180411183632.489154920@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Molitor <mario_molitor@web.de>


[ Upstream commit fd6720aefde06eacf17404eed2cad65c6ec103e1 ]

According the CYCLON V documention only the bit 16 of snaptypesel should
set.
(more information see Table 17-20 (cv_5v4.pdf) :
 Timestamp Snapshot Dependency on Register Bits)

Fixes: d2042052a0aa ("stmmac: update the PTP header file")
Signed-off-by: Mario Molitor <mario_molitor@web.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |   15 ++++++++++++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h  |    3 ++-
 2 files changed, 14 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -478,7 +478,10 @@ static int stmmac_hwtstamp_ioctl(struct
 			/* PTP v1, UDP, any kind of event packet */
 			config.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
 			/* take time stamp for all event messages */
-			snap_type_sel = PTP_TCR_SNAPTYPSEL_1;
+			if (priv->plat->has_gmac4)
+				snap_type_sel = PTP_GMAC4_TCR_SNAPTYPSEL_1;
+			else
+				snap_type_sel = PTP_TCR_SNAPTYPSEL_1;
 
 			ptp_over_ipv4_udp = PTP_TCR_TSIPV4ENA;
 			ptp_over_ipv6_udp = PTP_TCR_TSIPV6ENA;
@@ -510,7 +513,10 @@ static int stmmac_hwtstamp_ioctl(struct
 			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			/* take time stamp for all event messages */
-			snap_type_sel = PTP_TCR_SNAPTYPSEL_1;
+			if (priv->plat->has_gmac4)
+				snap_type_sel = PTP_GMAC4_TCR_SNAPTYPSEL_1;
+			else
+				snap_type_sel = PTP_TCR_SNAPTYPSEL_1;
 
 			ptp_over_ipv4_udp = PTP_TCR_TSIPV4ENA;
 			ptp_over_ipv6_udp = PTP_TCR_TSIPV6ENA;
@@ -544,7 +550,10 @@ static int stmmac_hwtstamp_ioctl(struct
 			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			/* take time stamp for all event messages */
-			snap_type_sel = PTP_TCR_SNAPTYPSEL_1;
+			if (priv->plat->has_gmac4)
+				snap_type_sel = PTP_GMAC4_TCR_SNAPTYPSEL_1;
+			else
+				snap_type_sel = PTP_TCR_SNAPTYPSEL_1;
 
 			ptp_over_ipv4_udp = PTP_TCR_TSIPV4ENA;
 			ptp_over_ipv6_udp = PTP_TCR_TSIPV6ENA;
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
@@ -63,7 +63,8 @@
 /* Enable Snapshot for Messages Relevant to Master */
 #define	PTP_TCR_TSMSTRENA	BIT(15)
 /* Select PTP packets for Taking Snapshots */
-#define	PTP_TCR_SNAPTYPSEL_1	GENMASK(17, 16)
+#define	PTP_TCR_SNAPTYPSEL_1	BIT(16)
+#define	PTP_GMAC4_TCR_SNAPTYPSEL_1	GENMASK(17, 16)
 /* Enable MAC address for PTP Frame Filtering */
 #define	PTP_TCR_TSENMACADDR	BIT(18)
 
