Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-196919-1522174077-2-17779405151404034417
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522174076; b=OjyC69kpWj0ls8M0QzeQTNpa0FmHhTBktH1Rq0cbQhtL0dH
    PNioC9dWSbw4/g5vPOqt/t2N/toRgFAketimN0UbUJ9K5mv8w534Cp8/+YOeWNAH
    9n/TSclrY8uI2IxFuRUB4kU+TkcuP/tSGrb9GCsIpmRdFWOw8pH8iU7H/89pGycB
    mvDiG+7jY4TIb0M77tJFuBnN+SLzqjvxlqK5/gasIOapx0J3B9cI1BVAAOjdX/rO
    DqC0ZkDjJBAjTvuOaKqC4CMQEqkYhNvhAyJsacIzmxfNW86mfuyW84oHKpRWpZq9
    6FrTWOrAiR2StGRe6N9UgW2qIu+3Hn4pCTWmmzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522174076; bh=6qb6DmrGsAgSWJscIglH26KCJF
    UNu2KgRLDIu3GF45E=; b=qoYXfLKHInypFDiWc1Mb5tfd0JGQyVReT9tEHlKRif
    SbGOw0aUxZBYDWrEjmc3Erxislmvc5huWwYYyRYE1SftdR8DxPuvN6ll6rq3v4ov
    2/ctKcNtGQx4/++oCul8fAgFFCWMFfs9qN/Sw98yHApGpAioHlxeCXJYNOcurusX
    VPfgORgORUfArSuHiY5WXrg0+g2kXNNu6Z9uFlk6Zns+uq8yO3O2jQXs5yHppCzV
    ngDspqXZtVdi9mCf5gkb2H9Epd+Rz22lC5p2zM8Um47ptxeO7F+xOUdMnhovH8aS
    9C5uyAvZOMcPIBKA3+HIv69WFlRt0JKDq3N7/j1xV5rg==
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
X-CM-Envelope: MS4wfGdK6LahxWWjigskggOVRxxeqfEPogcUU5RFW4YJq+9tLy00CLbcGyqBEDHPjOPLaNP2LTEIkN4sQVXsEhXwGZt3q4qPwecNd0dXkX84xEdWg+vlHqOd
    /z08aBJoPDfzrinvcJjRGgjwBX9Ud+/rPxVOqUq6cqVlJ9x7JE6vgT82gG1Sxvv+jVcTBMenYwtRoqakJRnAd/mN9IMqJV6sTbv24hHaTYCFQbhK/iUOdpRq
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=Q-fNiiVtAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=LpQP-O61AAAA:8
    a=ag1SF4gXAAAA:8 a=3oUHvglTmf5OvcW-gugA:9 a=fA8_a03Z_LmKL3AX:21
    a=oHILxQmG4MTx7fCt:21 a=QEXdDO2ut3YA:10 a=Fp8MccfUoT0GBdDC_Lng:22
    a=AjGcO6oz07-iQ99wixmX:22 a=pioyyrs4ZptJ924tMmac:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbeC0Q3b (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:29:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41346 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbeC0Q32 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:29:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.4 26/43] brcmfmac: fix P2P_DEVICE ethernet address generation
Date: Tue, 27 Mar 2018 18:27:30 +0200
Message-Id: <20180327162717.887133241@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arend Van Spriel <arend.vanspriel@broadcom.com>

commit 455f3e76cfc0d893585a5f358b9ddbe9c1e1e53b upstream.

The firmware has a requirement that the P2P_DEVICE address should
be different from the address of the primary interface. When not
specified by user-space, the driver generates the MAC address for
the P2P_DEVICE interface using the MAC address of the primary
interface and setting the locally administered bit. However, the MAC
address of the primary interface may already have that bit set causing
the creation of the P2P_DEVICE interface to fail with -EBUSY. Fix this
by using a random address instead to determine the P2P_DEVICE address.

Cc: stable@vger.kernel.org # 3.10.y
Reported-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/brcm80211/brcmfmac/p2p.c |   24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

--- a/drivers/net/wireless/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/brcm80211/brcmfmac/p2p.c
@@ -461,25 +461,23 @@ static int brcmf_p2p_set_firmware(struct
  * @dev_addr: optional device address.
  *
  * P2P needs mac addresses for P2P device and interface. If no device
- * address it specified, these are derived from the primary net device, ie.
- * the permanent ethernet address of the device.
+ * address it specified, these are derived from a random ethernet
+ * address.
  */
 static void brcmf_p2p_generate_bss_mac(struct brcmf_p2p_info *p2p, u8 *dev_addr)
 {
-	struct brcmf_if *pri_ifp = p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif->ifp;
-	bool local_admin = false;
+	bool random_addr = false;
 
-	if (!dev_addr || is_zero_ether_addr(dev_addr)) {
-		dev_addr = pri_ifp->mac_addr;
-		local_admin = true;
-	}
+	if (!dev_addr || is_zero_ether_addr(dev_addr))
+		random_addr = true;
 
-	/* Generate the P2P Device Address.  This consists of the device's
-	 * primary MAC address with the locally administered bit set.
+	/* Generate the P2P Device Address obtaining a random ethernet
+	 * address with the locally administered bit set.
 	 */
-	memcpy(p2p->dev_addr, dev_addr, ETH_ALEN);
-	if (local_admin)
-		p2p->dev_addr[0] |= 0x02;
+	if (random_addr)
+		eth_random_addr(p2p->dev_addr);
+	else
+		memcpy(p2p->dev_addr, dev_addr, ETH_ALEN);
 
 	/* Generate the P2P Interface Address.  If the discovery and connection
 	 * BSSCFGs need to simultaneously co-exist, then this address must be
