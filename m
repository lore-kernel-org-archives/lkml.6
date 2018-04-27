Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-333748-1524839672-2-6191670855045346710
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
    1524839671; b=cHW6H+IWTLJS6j19erLkVpuq6ZXTYlCDfakskX4t2zF0SVgdop
    yhRdApcJTqrY6xBZ4AFaaHqlbF54U4pdaiGzHOMgqCS6x8YUkB6lgJek0gQKCCdo
    ZW1p21R1SOMBESVqZF7IFfT1PmShjoUbcgbnVRxhGYUT013cDn8BeIN2Glm2f/ej
    IG5T2DbeqYhykO/PtI443t33ebJYu7+JHDQo+RlIcKy4V3sZbB0p5/qWaD23WqOF
    HlaKQcL938WUTSuH2LhGCWCmucOE1zuKpZWJO7z1lIKPHYXAFMA2KEFApJ+UF6VE
    7trZdGhm6O0B04NVEQhxd+3YDYgwMBI53OJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524839671; bh=fqiXp/sJboYtn6ClH3pCMlBPCJVp+6
    u3AJj+9sO/vNc=; b=Y0YsqRWe2pARQg3xvF+M5chA6O2Rhv2tcZl3XZesHJ1/5T
    +S0bP8FZkJXrJu4rtGhAo0Q8dlj3btw3lJOPaJQhypUVhcUsyuq7BufScAETGn1k
    H26Gsr3qJ1fsW0NOI3r2+evaltIZPzWH4wTW4jtIrlzyYoOJuaysQPREOX9m+L2j
    h5APcEjTJxYFo/G4PVv2TwqQRul9NUaNfc9KIffmZi4GdqHHmpVUi3KnPPZExLpE
    2omgBOs2d8JqIE33z2O8b7ohr5EHqNSE72vUsCLXK/1+DJSnmSJiMtakwp1QR+XK
    GSeta9sRNmC2ym8YcqSaHT/MXKpO8O7INR+H9Vhw==
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
X-CM-Envelope: MS4wfBWIxi2IbpnPX3NHbUKh4lqlkurADUHpP0S6pTGhOSyz3N5s+y6Rh5vgk15IWKE9Du2KRWjYm2wI4rtdQK7TNUw+YY6HsTa+mfEbjwOCGr5Bd3l5uh5S
    2oQ3hBttjryY4YfgNMufDdbjeElcRPIEUOJGuYkChv68rZrvN29/mJsQEkbT+/SNlzef1wtdoG8QatKvoNlZSVlI506Lv0sECW/hQ0x+69RfQeiaEAdvACfy
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=jIQo8A4GAAAA:8 a=J1Y8HTJGAAAA:8 a=8b9GpE9nAAAA:8 a=ag1SF4gXAAAA:8
    a=jb0liMnZSGKWr6UborIA:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=T3LWEMljR5ZiDmsYVIUa:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934797AbeD0OeR (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:34:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934554AbeD0OKI (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:10:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7581021897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Joao Pinto <jpinto@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH 4.16 20/81] net: stmmac: Disable ACS Feature for GMAC >= 4
Date: Fri, 27 Apr 2018 15:58:22 +0200
Message-Id: <20180427135744.418204069@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jose Abreu <Jose.Abreu@synopsys.com>


[ Upstream commit 565020aaeebfa7c8b3ec077bee38f4c15acc9905 ]

ACS Feature is currently enabled for GMAC >= 4 but the llc_snap status
is never checked in descriptor rx_status callback. This will cause
stmmac to always strip packets even that ACS feature is already
stripping them.

Lets be safe and disable the ACS feature for GMAC >= 4 and always strip
the packets for this GMAC version.

Fixes: 477286b53f55 ("stmmac: add GMAC4 core support")
Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h      |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c |    7 -------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |    7 ++++++-
 3 files changed, 7 insertions(+), 9 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -343,7 +343,7 @@ enum power_event {
 #define MTL_RX_OVERFLOW_INT		BIT(16)
 
 /* Default operating mode of the MAC */
-#define GMAC_CORE_INIT (GMAC_CONFIG_JD | GMAC_CONFIG_PS | GMAC_CONFIG_ACS | \
+#define GMAC_CORE_INIT (GMAC_CONFIG_JD | GMAC_CONFIG_PS | \
 			GMAC_CONFIG_BE | GMAC_CONFIG_DCRS)
 
 /* To dump the core regs excluding  the Address Registers */
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -30,13 +30,6 @@ static void dwmac4_core_init(struct mac_
 
 	value |= GMAC_CORE_INIT;
 
-	/* Clear ACS bit because Ethernet switch tagging formats such as
-	 * Broadcom tags can look like invalid LLC/SNAP packets and cause the
-	 * hardware to truncate packets on reception.
-	 */
-	if (netdev_uses_dsa(dev))
-		value &= ~GMAC_CONFIG_ACS;
-
 	if (mtu > 1500)
 		value |= GMAC_CONFIG_2K;
 	if (mtu > 2000)
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3435,8 +3435,13 @@ static int stmmac_rx(struct stmmac_priv
 
 			/* ACS is set; GMAC core strips PAD/FCS for IEEE 802.3
 			 * Type frames (LLC/LLC-SNAP)
+			 *
+			 * llc_snap is never checked in GMAC >= 4, so this ACS
+			 * feature is always disabled and packets need to be
+			 * stripped manually.
 			 */
-			if (unlikely(status != llc_snap))
+			if (unlikely(priv->synopsys_id >= DWMAC_CORE_4_00) ||
+			    unlikely(status != llc_snap))
 				frame_len -= ETH_FCS_LEN;
 
 			if (netif_msg_rx_status(priv)) {
