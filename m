Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3374234-1523482011-2-15267742520450051018
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523482010; b=UZkQKG4avRkWzgRSFnNVEVK4BTsmP9jzgsxA+kzBeDdq0mrAgY
    im46EDA/lhNfyLUGtavAVQ6fgivhj5C0K0bNPUSVn+VHExY6JDFyzqzSOopWsww5
    diX2wcpceP2iiIGfe78+e/bp1vo7YOXXOtcl15JFss+9aOYiMu0TqBDqjfmlGlhb
    k7JIK/y1ztENIbGJeG4TACvYqkRFTnmceRHUZ60w73M+ifrf0RyToQi6XKnKpszT
    X8+eVsxbWi9CAvLmzy6CejgBGXT94iR8gQhS2r0iwnBChEL8g7HTPXiPV+W8TH6j
    xSUBE2IFn6B8iU9lxh0pc059Sq9zjPTgbXHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523482010; bh=SBv6cPUfPSesPUq8Il8lz3iX0s+3FU
    mjVVcHVPHonjg=; b=QnXrs9PCw+k66qe8PamqmCLfjaI/zGgg6RtJpTaFiMaUmI
    WaKZTOFyHx+ekufCheOwbxdWQ9Zv7btOT6/9KGVj+ro+SOHULxC43mPZW9pKBrDw
    K0/XJxfP/328RyWq9ANs3I6Dk8rAeVvrygxch6w1yXafDzg5CimdoLLHqh5yyMBC
    xCSqTDHNPjVvfVVwQf6w1oeX+1+CgODkEj6278irpTnJ2USjRyOb6NGn7sMqDbLt
    TH+g2yx6ET4MxJ+LRC2I2t4b3Acbkpe2A+OVPO7XUG1MdIb30bNm8t6KnW889aig
    rfYse/aLNl6jhx+hhuOQRF1dpmac62A4ssgF7bxw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfMvCppVq91f8+grENHajzKxW/pzD7iqUW5AH2PKkfprVReevIHZU1rBVdQmOdxPf0QKPrVANb6Ke9MuCPd8g95zTHXdvHKTPR51tl7wTa92jPKFXA3pz
    oLWnqaLvRch0pFu50BlGc6Sqcnyi+iaLXWfFtMYKrjwDG2BV55OTdMEQEozYIxFqZgFyTSKnhKS9BI4zaKt/O6N4VQzUd2Ebr1QmR+C1SPyGWy6wcbHCXWL+
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=sozttTNsAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=d1UQarb68PLNqGhgFE4A:9 a=QEXdDO2ut3YA:10 a=aeg5Gbbo78KNqacMgKqU:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754008AbeDKSiQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:38:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55290 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753958AbeDKSiO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:38:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Schuyler Patton <spatton@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 007/121] net: ethernet: ti: cpsw: adjust cpsw fifos depth for fullduplex flow control
Date: Wed, 11 Apr 2018 20:35:10 +0200
Message-Id: <20180411183456.677529170@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Grygorii Strashko <grygorii.strashko@ti.com>


[ Upstream commit 48f5bccc60675f8426a6159935e8636a1fd89f56 ]

When users set flow control using ethtool the bits are set properly in the
CPGMAC_SL MACCONTROL register, but the FIFO depth in the respective Port n
Maximum FIFO Blocks (Pn_MAX_BLKS) registers remains set to the minimum size
reset value. When receive flow control is enabled on a port, the port's
associated FIFO block allocation must be adjusted. The port RX allocation
must increase to accommodate the flow control runout. The TRM recommends
numbers of 5 or 6.

Hence, apply required Port FIFO configuration to
Pn_MAX_BLKS.Pn_TX_MAX_BLKS=0xF and Pn_MAX_BLKS.Pn_RX_MAX_BLKS=0x5 during
interface initialization.

Cc: Schuyler Patton <spatton@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ti/cpsw.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -293,6 +293,10 @@ struct cpsw_ss_regs {
 /* Bit definitions for the CPSW1_TS_SEQ_LTYPE register */
 #define CPSW_V1_SEQ_ID_OFS_SHIFT	16
 
+#define CPSW_MAX_BLKS_TX		15
+#define CPSW_MAX_BLKS_TX_SHIFT		4
+#define CPSW_MAX_BLKS_RX		5
+
 struct cpsw_host_regs {
 	u32	max_blks;
 	u32	blk_cnt;
@@ -1120,11 +1124,23 @@ static void cpsw_slave_open(struct cpsw_
 	switch (priv->version) {
 	case CPSW_VERSION_1:
 		slave_write(slave, TX_PRIORITY_MAPPING, CPSW1_TX_PRI_MAP);
+		/* Increase RX FIFO size to 5 for supporting fullduplex
+		 * flow control mode
+		 */
+		slave_write(slave,
+			    (CPSW_MAX_BLKS_TX << CPSW_MAX_BLKS_TX_SHIFT) |
+			    CPSW_MAX_BLKS_RX, CPSW1_MAX_BLKS);
 		break;
 	case CPSW_VERSION_2:
 	case CPSW_VERSION_3:
 	case CPSW_VERSION_4:
 		slave_write(slave, TX_PRIORITY_MAPPING, CPSW2_TX_PRI_MAP);
+		/* Increase RX FIFO size to 5 for supporting fullduplex
+		 * flow control mode
+		 */
+		slave_write(slave,
+			    (CPSW_MAX_BLKS_TX << CPSW_MAX_BLKS_TX_SHIFT) |
+			    CPSW_MAX_BLKS_RX, CPSW2_MAX_BLKS);
 		break;
 	}
 
