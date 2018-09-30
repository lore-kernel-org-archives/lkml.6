Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DDCC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 15:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71409206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 15:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="D4PXt5af"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71409206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbeI3VkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 17:40:08 -0400
Received: from sonic315-8.consmr.mail.gq1.yahoo.com ([98.137.65.32]:34478 "EHLO
        sonic315-8.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727746AbeI3VkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 17:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1538320005; bh=CiGhynYwHUd0QbJmWXOqG4dVzbYAs0R2uRMyea4O9s4=; h=Date:From:Subject:To:Cc:From:Subject; b=D4PXt5afVbOjr8AwCOJC3uwOCzDYM+9YtJ5YFQWGpOSvX1Cm8jwcuW6nirNvu+iMsu5TmdUhTKOPSZOESt3C4AUHOS3nlPemusl1hSi4qggcW+uZcREiGrtZnWkqoxu0/2Ffo+8CAPuPqaUVn9g/7ib/r6Kz7WhDPWLA8YVt3lqWqsx5Rhvyb1ya3zOSMuSi5zW5ekttBFmc3A6f6ybqTt2g/zxxEJoXCUHvB7Qfke2nA0WuETi2s1uNj0yswK8ku0n5uk95zW04OcjpZOAjdcYV7nlr6rqm+BSw+UnDMq6cX7b0ErLW0h9s9WgWQbk/LHnySqK6tprYGxJkt+5qyw==
X-YMail-OSG: TrlKb.8VM1lT4s0dMmASvM8OiH4wSwQ_t.2obIyssGrvjaU81Dpd1Kmi.l3lR.e
 qUaIdx2L1oGLT1nMeFViv1LDIhdcvgK76u5e8PS_qLNrZB8VMwSvEqH8FIR3PxhiIwhWsIpmBPEt
 kZ1l4z6FP5B_vQauO2mcrmTsSKFpT9Vn6FmGoQEVEFSUJluqIVeNOVjhBxP_q3SPWHqcWgsA0wll
 cbl6wdWyhvDf4vrV9Yl57L06quxVEDHDEXPY1NsQFmwMcaCfNGAtqYZf1TuBLMLA7Krc_jsGeI84
 QBMG4gLBQvO.8nNJ3Xk60qkQJGoPyi_2q18lcRUSwAy.krOVBzUyd8JKS0jsmZ8ZpT9FQ.9tWrPv
 5tezAfwZ5r6CFQeStcAcNLYFBjpdkzQlAbe5iQR4NnxWxCN3pNxEyGai6bIjlm8s8dbCgiuDnzww
 B8fP9MqU0WTAG7P5_wl_OenK8zb0wqKpcZ2dIXpn3nOpVi2M3BYiyTz157vgzclnAKhmIvSvcUxT
 zTLDQZ0PAAgqOTLE178LQkjeFzs6o4h0TdoMZMAJnk34pR0G8xSSnDrv0kHLHpWmrb8lAN8HxGIy
 znU2BI0.LZW5TWF4QCYhOoVBvD_6XIcJSviMnJE.aaKEYi8vwurahLKi.4tAx.vQSpXfGBccZhcu
 9zUevtZ6qEbJvMowHwUbUHpasT4Lypp_T2BYdQg0fEp0mhNvBmTF.kaK9E0TP_etMNdn2IS38cTY
 9D6zNibCpacbXexUTpoy1tGO3YPXS4UkKv7exE4fz1F3s3mdiLdRBMp5FNS5haEyEQm8WpE3VgjY
 GgobbyxZqZ9oh62HYq4x2hJxd7Jfar5usUETsuj6jCjCALu3wfPpJDNrjJjkvAWoyAQFJyiXFXTE
 ZhfYGuKC3bj8hEgoAduOfhx_i6ntTZ0GIaRXMTEwmiJzDWMlBiEHl.2Coq2AxC18wMBpJlEZWj9H
 WptlbDf.1uZPAASusoFllOL1ERrn1ei_Covxm5kAQlb8N8vxGwmpFxbDfdLhmEE.5x2MBhsZEbz9
 VGJJQwd.4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Sun, 30 Sep 2018 15:06:45 +0000
Received: from CPE00fc8de26033-CM00fc8de26030.cpe.net.cable.rogers.com (EHLO localhost) ([99.228.156.240])
          by smtp413.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ff2655482ab7b0495e0ed29de7555ab0;
          Sun, 30 Sep 2018 15:06:43 +0000 (UTC)
Date:   Sun, 30 Sep 2018 11:06:39 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: [PATCH net v2] r8169: always autoneg on resume
To:     netdev@vger.kernel.org
Cc:     hkallweit1@gmail.com, nic_swsd@realtek.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
User-Agent: astroid/0.13.0 (https://github.com/astroidmail/astroid)
Message-Id: <1538319728.z22jaatdgh.astroid@alex-desktop.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This affects at least versions 25 and 33, so assume all cards are broken
and just renegotiate by default.

Fixes: 10bc6a6042c9 ("r8169: fix autoneg issue on resume with RTL8168E")
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
