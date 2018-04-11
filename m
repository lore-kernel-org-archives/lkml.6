Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3374234-1523481152-2-10940089082141484189
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
    1523481151; b=WIRB8Zo8nfL2fz4LvvEXpgX5JIYLEv+Ykq2SY0u1ZpMft+g8Ed
    IqmOvRi00Uqn9Efiy1pM+8eNkEJG74vLGX0s4thItfhf8x6vnrh1yuE6WUeBVAMX
    p0To/8dCVAD6nx84S0K9P2ThHNqrGguHn35VwEXeHKTMtwBTPPcQFT7D9//oQhGp
    6UBRPet3l54SyNW+F3+74A41Zj4c1jfgr6L0DhDqbRLjIeTOHn7Cjz3w4/ssWgMp
    ixlMyez9Nhg7JYjezEQp7ijO9uVpQ6qvJ4oooza9WfyfV2gOaUHSDrlnUSLEh7Ra
    EuMu+UeHqmZ56KzAD3j+79GlBKqj5s82S7Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481151; bh=0KV8ignKlOfaErOpcyQLcBFd3DHiZS
    ktmbGH4E8bAQc=; b=w6b/KmMLWqa5FcI1o9CtoJj8SaPk10JTZpisixpyqPu+AK
    YZy8StnTxcM36U0C0SIFowQY0ua8ZtqNBILzilwDQ8f2PT3wNC1m228Q+UcRJXCz
    yaZ8l9b/e1X5initfFD3baaRn3+fByXN+qjD+1B/M4SMV+V6wvmf4z8qLihZMdMZ
    iwCFWqJUMS9a5qJicjntNXen7KSqOMy7I/VM24ihhB+BVuKUEdcaKsnRiSozNa6G
    /hErXe7S+v8/cyATye0MRwBwi/EfIOvBZDtKEdZrVx5s5qoq5KV6xNNXvg7MWTVx
    djtLFrDrvy14r8KAl+XVcrk7fJ648CajSCgziM5g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfMdipeLchlIXLEn1kFLQm6dJmlRzfW5PHETEONj3zKbk2kRKA4DsrbVjXUH14TPdXn6GYKziyXm/IQ5GWrEXWrifpLOUbcUivX+EPkCYa/BlANqbSIEr
    PtJKtHnR7UWiwIVPAJeQD/QIYCaR9zHXpt3DvZUG4H4/X5PpdcdLs11mz+sI8aykWVLo+DEM9QDn1fFkeUf4tSmibb8Q0ZlyYX7e+8AoO3nBooYAcawyLTIl
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=mK_AVkanAAAA:8 a=KyFl3zXNAAAA:8 a=pGLkceISAAAA:8 a=wN8y-Yx_AAAA:8
    a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=L6mrDz4BGHFqb7Z-ehIA:9
    a=WcQaQKBXoVLEDG7x:21 a=jk2V-N5XDcoAyOmd:21 a=QEXdDO2ut3YA:10
    a=hE-CQoAEJnYA:10 a=3gWm3jAn84ENXaBijsEo:22 a=BhUsNs7XMpJvgoQe9RqM:22
    a=157CbnpJa6P2q4pOZ5fC:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754831AbeDKSl2 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:41:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56804 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754698AbeDKSlX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:41:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Blake <chrisrblake93@gmail.com>,
        Russell Senior <russell@personaltelco.net>,
        Christian Lamparter <chunkeey@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 079/121] net: emac: fix reset timeout with AR8035 phy
Date: Wed, 11 Apr 2018 20:36:22 +0200
Message-Id: <20180411183501.003275697@linuxfoundation.org>
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

From: Christian Lamparter <chunkeey@googlemail.com>


[ Upstream commit 19d90ece81da802207a9b91ce95a29fbdc40626e ]

This patch fixes a problem where the AR8035 PHY can't be
detected on an Cisco Meraki MR24, if the ethernet cable is
not connected on boot.

Russell Senior provided steps to reproduce the issue:
|Disconnect ethernet cable, apply power, wait until device has booted,
|plug in ethernet, check for interfaces, no eth0 is listed.
|
|This appears to be a problem during probing of the AR8035 Phy chip.
|When ethernet has no link, the phy detection fails, and eth0 is not
|created. Plugging ethernet later has no effect, because there is no
|interface as far as the kernel is concerned. The relevant part of
|the boot log looks like this:
|this is the failing case:
|
|[    0.876611] /plb/opb/emac-rgmii@ef601500: input 0 in RGMII mode
|[    0.882532] /plb/opb/ethernet@ef600c00: reset timeout
|[    0.888546] /plb/opb/ethernet@ef600c00: can't find PHY!
|and the succeeding case:
|
|[    0.876672] /plb/opb/emac-rgmii@ef601500: input 0 in RGMII mode
|[    0.883952] eth0: EMAC-0 /plb/opb/ethernet@ef600c00, MAC 00:01:..
|[    0.890822] eth0: found Atheros 8035 Gigabit Ethernet PHY (0x01)

Based on the comment and the commit message of
commit 23fbb5a87c56 ("emac: Fix EMAC soft reset on 460EX/GT").
This is because the AR8035 PHY doesn't provide the TX Clock,
if the ethernet cable is not attached. This causes the reset
to timeout and the PHY detection code in emac_init_phy() is
unable to detect the AR8035 PHY. As a result, the emac driver
bails out early and the user left with no ethernet.

In order to stay compatible with existing configurations, the driver
tries the current reset approach at first. Only if the first attempt
timed out, it does perform one more retry with the clock temporarily
switched to the internal source for just the duration of the reset.

LEDE-Bug: #687 <https://bugs.lede-project.org/index.php?do=details&task_id=687>

Cc: Chris Blake <chrisrblake93@gmail.com>
Reported-by: Russell Senior <russell@personaltelco.net>
Fixes: 23fbb5a87c56e98 ("emac: Fix EMAC soft reset on 460EX/GT")
Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ibm/emac/core.c |   26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -349,6 +349,7 @@ static int emac_reset(struct emac_instan
 {
 	struct emac_regs __iomem *p = dev->emacp;
 	int n = 20;
+	bool __maybe_unused try_internal_clock = false;
 
 	DBG(dev, "reset" NL);
 
@@ -361,6 +362,7 @@ static int emac_reset(struct emac_instan
 	}
 
 #ifdef CONFIG_PPC_DCR_NATIVE
+do_retry:
 	/*
 	 * PPC460EX/GT Embedded Processor Advanced User's Manual
 	 * section 28.10.1 Mode Register 0 (EMACx_MR0) states:
@@ -368,10 +370,19 @@ static int emac_reset(struct emac_instan
 	 * of the EMAC. If none is present, select the internal clock
 	 * (SDR0_ETH_CFG[EMACx_PHY_CLK] = 1).
 	 * After a soft reset, select the external clock.
+	 *
+	 * The AR8035-A PHY Meraki MR24 does not provide a TX Clk if the
+	 * ethernet cable is not attached. This causes the reset to timeout
+	 * and the PHY detection code in emac_init_phy() is unable to
+	 * communicate and detect the AR8035-A PHY. As a result, the emac
+	 * driver bails out early and the user has no ethernet.
+	 * In order to stay compatible with existing configurations, the
+	 * driver will temporarily switch to the internal clock, after
+	 * the first reset fails.
 	 */
 	if (emac_has_feature(dev, EMAC_FTR_460EX_PHY_CLK_FIX)) {
-		if (dev->phy_address == 0xffffffff &&
-		    dev->phy_map == 0xffffffff) {
+		if (try_internal_clock || (dev->phy_address == 0xffffffff &&
+					   dev->phy_map == 0xffffffff)) {
 			/* No PHY: select internal loop clock before reset */
 			dcri_clrset(SDR0, SDR0_ETH_CFG,
 				    0, SDR0_ETH_CFG_ECS << dev->cell_index);
@@ -389,8 +400,15 @@ static int emac_reset(struct emac_instan
 
 #ifdef CONFIG_PPC_DCR_NATIVE
 	if (emac_has_feature(dev, EMAC_FTR_460EX_PHY_CLK_FIX)) {
-		if (dev->phy_address == 0xffffffff &&
-		    dev->phy_map == 0xffffffff) {
+		if (!n && !try_internal_clock) {
+			/* first attempt has timed out. */
+			n = 20;
+			try_internal_clock = true;
+			goto do_retry;
+		}
+
+		if (try_internal_clock || (dev->phy_address == 0xffffffff &&
+					   dev->phy_map == 0xffffffff)) {
 			/* No PHY: restore external clock source after reset */
 			dcri_clrset(SDR0, SDR0_ETH_CFG,
 				    SDR0_ETH_CFG_ECS << dev->cell_index, 0);
