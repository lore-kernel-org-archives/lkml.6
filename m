Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5EFC43143
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 01:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD23206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 01:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="my0XXeKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD23206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbeI3Htd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 03:49:33 -0400
Received: from sonic317-28.consmr.mail.bf2.yahoo.com ([74.6.129.83]:42792 "EHLO
        sonic317-28.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726348AbeI3Htc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 03:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1538270329; bh=UQ428NWUXHL7ibaMcNvOTU21SIKX6kwvSrmgLCGl5KM=; h=Date:From:Subject:To:Cc:From:Subject; b=my0XXeKjW3XuhwERCYrFCwWuV1XPwbUUkvvuDs9UL3Xg+lQciyJ18pYO3anLh8A4jnNQXFxwHWDeKCd5VPqIlewltu39fMIBwatimBzAjNvSI0syzROeDhJSY5Esfv9I6FEnuqlpJ7VgnQm9/cX/y7ZzQBqHN8NTa8d1/9ZmAWgx8K0T9ALRXBv65K6itkD4/JsMZiYTss11HIR4cJ3i6HOypBfBxH36LlToexJOQb24ulb6/AZlNfcz3hryL2Em7vGMGOj6kII4IIelYmUQN/6nPILz9Hokwp5yNSRMNR4WT0TkOJOars5dwq1lsO7zPldI5X2U8zdPTaaWpfF2Uw==
X-YMail-OSG: bV2tFpsVM1lFVFm2PcGcmfIbslA1fS4k0LtY4T5K8RSWEgO8GzqB3cgmayY3fTW
 W8S9VrlHhkn6Wb8Kg_9X.ZSEEiOPV4TjuFgbIKNGNoK5VCM0akBzbI4mIsdhAZ1dOPpaDLxaeF6a
 GcjDiob2zJqIp.jUzlSOMCEJZDgQOjpS7U4inIvCMAh890mZxP3tvKgL3IVkoHH6ptPU3bcEuVC5
 IM8a7OBJdGSsTkbo0ISXgiq4TWBfFMh10zfzLnBG6.bFEehzAaoeQQow4ZU4H4yOxp5HXHelAbnj
 TMz8bKzxyqOoM62e4yP.konE1Wvs0joAFl1WmhhNxmpOxAURzOTd5h_0N2M3eqIaNVC2FNv06LCt
 l6E86ubm7hlUs8BgoYzPhbkfcCjxaGiCSvS9Y6FNt1thvx9Uc69bdc6BocUrk.AXlENElM6Px85a
 uhknIH4rwZsxHwAeRuiKBZ92x9XrXUnXQc7WQXTI0UxqVcD9ppRdCrjPwCD_vf5.yiNUoBUZrX1D
 2Nsb2d3g7_Wyv6HbTeqaSKkMTKinahby5DTyD1IKAusfhEeVBNWkyc3xygWitDSjWFIqEmAAhUlO
 BcLTieJ7.Yn6K5HcxnVqaL_YKbX2jua4BRzdzMGP15_InqOc4eKdXRj2Keo03MFbMR5biJe1C3Op
 D28dLi2O3GRcL58N_.rb3egMajvT4SnwrcxcRdBw8ST4gvVZfhi8zSOIpQOioBa8fQ6Um9o1O21R
 Rwlo_ClcC76dCprgNlaiiqCKwQMTdjOocIkJ9k0loYFP321q8sZbTEEAM2C_LzVQjOq67CF_p4Cr
 Rkv42g96ajm6DVcZNDQKPdytoAzwUA0HqE0Ug3uN6Wu8AXzRVOOGUhpHmQXLURWK7YwsDvJBhGc4
 zWymucwkE2L1dLzAGr8_KQyOGYGovdQLZB1cMMtJjDQ0nGfKGfEroSrQGiJFEc9Oil4CkHSTpaU3
 a9sQEJ33OX2mVlH6x9RethxjtM8vKGyaWCDZEeqSj9nzJyAYenpn8Fle2AKsqkWstzitDQQv9JVF
 ZsJkV_12y4Nw-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Sun, 30 Sep 2018 01:18:49 +0000
Received: from CPE00fc8de26033-CM00fc8de26030.cpe.net.cable.rogers.com (EHLO localhost) ([99.228.156.240])
          by smtp403.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0dc7ae0cad24b72d1b84d4f466369641;
          Sun, 30 Sep 2018 01:18:45 +0000 (UTC)
Date:   Sat, 29 Sep 2018 21:18:41 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: [PATCH net] r8169: always autoneg on resume
To:     linux-netdev@vger.kernel.org
Cc:     hkallweit1@gmail.com, nic_swsd@realtek.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
User-Agent: astroid/0.13.0 (https://github.com/astroidmail/astroid)
Message-Id: <1538270023.zutwcuc82n.astroid@alex-desktop.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This affects at least versions 25 and 33, so assume all cards are broken
and just renegotiate by default.

Fixes: a2965f12fde6 ("r8169: remove rtl8169_set_speed_xmii")
Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
---
 drivers/net/ethernet/realtek/r8169.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/re=
altek/r8169.c
index ab30aaeac6d3..db2f347c1463 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -4072,13 +4072,12 @@ static void rtl8169_init_phy(struct net_device *dev=
, struct rtl8169_private *tp)
=20
 	genphy_soft_reset(dev->phydev);
=20
-	/* It was reported that chip version 33 ends up with 10MBit/Half on a
+	/* It was reported that several chips end up with 10MBit/Half on a
 	 * 1GBit link after resuming from S3. For whatever reason the PHY on
-	 * this chip doesn't properly start a renegotiation when soft-reset.
+	 * these chips doesn't properly start a renegotiation when soft-reset.
 	 * Explicitly requesting a renegotiation fixes this.
 	 */
-	if (tp->mac_version =3D=3D RTL_GIGA_MAC_VER_33 &&
-	    dev->phydev->autoneg =3D=3D AUTONEG_ENABLE)
+	if (dev->phydev->autoneg =3D=3D AUTONEG_ENABLE)
 		phy_restart_aneg(dev->phydev);
 }
=20
--=20
2.19.0
=
