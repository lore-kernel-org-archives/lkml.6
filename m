Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521806212-2-5603287341917981871
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
    t=1521806212; b=AgL5NKIMW6lABx3FlDN9Zzlqx0tRlWpW5ZVbsxG2SVawE1U
    57uxbuwPEOzRqr5ftdrDn1Eh5hgVKVC+qvCTE2v9SgMhXMF/4tzieCiHoCJ5s+m4
    n/CZ5XpKcjtV5nxqxVzfOh2v69atPZ7AMb5Fpp56bpTSZ6jp153fRSxK6CN/zMpd
    i5JW2bJPUP6UZ5yoVP4RLOY8iYVxGyjJnRZGvncvwZx6S5aQrHAHXjZq1Eg6i5wx
    5y8GWoXkNUKbacsPjugT8oYD3qU7SvMmwum9mCIqkIaA1+ygXS341GGe42pQ7Af7
    GyTXfI3XDMyKZCM/X2ppS4z9JowCMna5QYBdGNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806212; bh=qxIOjwhFrtZnVpb/SyE9AXSH4K
    1P3jL0TLTonOI6Q5s=; b=oTTBHKs/pWYHfx2jXPCClrTrlZ3+0WmslIEl+Jk1Fm
    TJ22Tx0s8oV+6Ag031q89IN1ZUpuUag+Ysh98tCF/XFAmEh/FYEK7Bu88Peb+g5p
    W4P6cd74gGdEyC92VEQryxz3AwVETUTAJF+FAj5Ww0M1DsvdqD6u3g+/hxU1Ig0o
    cVtk9+9eKj/obKtYeCsmdJjfwx0kOQUgl62HjdM/it7IaAy7s64Q0dsipsI+jzzw
    vAT47t6aGYLaHaeiGasUy5wd27+2W/R7W8ZZtRI2Rc3PxFcnLVvox+LR1jS8XSWZ
    fIFcliTr8krQ+Tap742RasSa2s+nYFdrR5Ibe/4lqesg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753735AbeCWKAu (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:00:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37340 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753282AbeCWKAs (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:00:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Richard Leitner <richard.leitner@skidata.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 08/77] net: fec: add phy_reset_after_clk_enable() support
Date: Fri, 23 Mar 2018 10:53:42 +0100
Message-Id: <20180323094142.763285240@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
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

From: Richard Leitner <richard.leitner@skidata.com>


[ Upstream commit 1b0a83ac04e383e3bed21332962b90710fcf2828 ]

Some PHYs (for example the SMSC LAN8710/LAN8720) doesn't allow turning
the refclk on and off again during operation (according to their
datasheet). Nonetheless exactly this behaviour was introduced for power
saving reasons by commit e8fcfcd5684a ("net: fec: optimize the clock management to save power").
Therefore add support for the phy_reset_after_clk_enable function from
phylib to mitigate this issue.

Generally speaking this issue is only relevant if the ref clk for the
PHY is generated by the SoC and therefore the PHY is configured to
"REF_CLK In Mode". In our specific case (PCB) this problem does occur at
about every 10th to 50th POR of an LAN8710 connected to an i.MX6SOLO
SoC. The typical symptom of this problem is a "swinging" ethernet link.
Similar issues were reported by users of the NXP forum:
	https://community.nxp.com/thread/389902
	https://community.nxp.com/message/309354
With this patch applied the issue didn't occur for at least a few
hundret PORs of our board.

Fixes: e8fcfcd5684a ("net: fec: optimize the clock management to save power")
Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/fec_main.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1872,6 +1872,8 @@ static int fec_enet_clk_enable(struct ne
 		ret = clk_prepare_enable(fep->clk_ref);
 		if (ret)
 			goto failed_clk_ref;
+
+		phy_reset_after_clk_enable(ndev->phydev);
 	} else {
 		clk_disable_unprepare(fep->clk_ahb);
 		clk_disable_unprepare(fep->clk_enet_out);
@@ -2844,6 +2846,7 @@ fec_enet_open(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	int ret;
+	bool reset_again;
 
 	ret = pm_runtime_get_sync(&fep->pdev->dev);
 	if (ret < 0)
@@ -2854,6 +2857,17 @@ fec_enet_open(struct net_device *ndev)
 	if (ret)
 		goto clk_enable;
 
+	/* During the first fec_enet_open call the PHY isn't probed at this
+	 * point. Therefore the phy_reset_after_clk_enable() call within
+	 * fec_enet_clk_enable() fails. As we need this reset in order to be
+	 * sure the PHY is working correctly we check if we need to reset again
+	 * later when the PHY is probed
+	 */
+	if (ndev->phydev && ndev->phydev->drv)
+		reset_again = false;
+	else
+		reset_again = true;
+
 	/* I should reset the ring buffers here, but I don't yet know
 	 * a simple way to do that.
 	 */
@@ -2870,6 +2884,12 @@ fec_enet_open(struct net_device *ndev)
 	if (ret)
 		goto err_enet_mii_probe;
 
+	/* Call phy_reset_after_clk_enable() again if it failed during
+	 * phy_reset_after_clk_enable() before because the PHY wasn't probed.
+	 */
+	if (reset_again)
+		phy_reset_after_clk_enable(ndev->phydev);
+
 	if (fep->quirks & FEC_QUIRK_ERR006687)
 		imx6q_cpuidle_fec_irqs_used();
 
