Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520453014-2-11080341962302050567
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520453014; b=E+mQR5l8Wzp3AjwJdrHqUHPIiPnseswItqq16hVocWL0rjZ
    jIyj77ghmlTSAKOIKdewoR3q6nkJFq1CH4jse3aypWfyOWrgcx2AUjdp9un5ZKxS
    +4cbrT2GG51cOjqd16mFdGM1F/v8xfnumzuOwPCGNIEv81mcpT1U5QJkwbGfjr3d
    kjcXsNfn7CVnWtnFIAt2Bb9bjWwFHj9CZECyw/AMfYlLQ1PAMAescT/kdwVCGFkv
    MOKM7WoLhltVifBtq5o4qhlQ0JNK80KlOGGOgMofJTxh2EKK7F0YBzNZ3Q+TDYzt
    +6tD6qBgAIC5rgZ6hKcW+JBSvKQJaqOV0cmLCKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520453014; bh=NEkXSw6S9sK89uMEmQc91OHUtu
    g9aTwkQzdni98TcVw=; b=qdMeCwzvo0nzI+H06yxd5NMAWucdzuANnlt2NjAJqm
    2DwD5kMkcRN15QiWKff3MFynyAFZql54Lw2q4zKzl/YjLL9Emdlojhvn5xbSZ/C4
    qYZTEUnPyfQT/HBz1k+w3XgF8uIAZEueAMcO57wHjJkUUTVnAE10kiV/FEkPFWi5
    kM4DRZro/dB+5colNmiKTyc3kpYqzg/BktSkETaaZCAhOpbEZv0G78W0HsF7egka
    uOxwZt/6JWxxCW+7c5KjI//AHebcFAThy6VOPGXumziwclfRLhSBLGJM20EyUVP6
    wpvM0HvgKrbMgfA1yNzaHqNDRdjZLJEgSxRzkI1Nz6xA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934778AbeCGUDQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 15:03:16 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44692 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965572AbeCGTqk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:46:40 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 067/110] amd-xgbe: Restore PCI interrupt enablement setting on resume
Date: Wed,  7 Mar 2018 11:38:50 -0800
Message-Id: <20180307191048.100824197@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Lendacky <thomas.lendacky@amd.com>


[ Upstream commit cfd092f2db8b4b6727e1c03ef68a7842e1023573 ]

After resuming from suspend, the PCI device support must re-enable the
interrupt setting so that interrupts are actually delivered.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -426,6 +426,8 @@ static int xgbe_pci_resume(struct pci_de
 	struct net_device *netdev = pdata->netdev;
 	int ret = 0;
 
+	XP_IOWRITE(pdata, XP_INT_EN, 0x1fffff);
+
 	pdata->lpm_ctrl &= ~MDIO_CTRL1_LPOWER;
 	XMDIO_WRITE(pdata, MDIO_MMD_PCS, MDIO_CTRL1, pdata->lpm_ctrl);
 
