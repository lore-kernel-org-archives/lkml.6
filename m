Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303684-1523479920-2-3818350417534665229
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
    1523479919; b=DHSpvAMYY+1+fzrPZpbrgo1/zhrj/aY8BQg0OH8VxvpQeCeXM6
    HPsws6e9qGz1PMnPZJBN/7d7utFHv+fO4T6NfOxjdK1/IQgAEny0WRJXT5E3KtuH
    MaNaeC6UBUzOJQY5prXbUPCy3CDHqrMxc36BDkJBB6nArWTR9Voizzqpp171wdph
    oOtJ+cEn+I/zCcl0zyLSfPTBiVkwJb6vm3+4oubKDCKdX0qDojUvPJ89h0eTrh+Y
    M3hYuYxW12U1uFFKECTbByFZAN03ChsAGhYyEhJgP+UdV2HeKzir035xajUzty+5
    A5fcN6fnXVSY5VJDHgoeUn8khqPI3MpD9TkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479919; bh=QMpZigWDCLm4R8rB1iz1MGDJgbAl7z
    54tsARLwLKW84=; b=r/1K8wPXrS+0v6fgq/rPMCPKi/3A5bldEgGkHu6kD7M7/Z
    ap36xkxyimYlS1+yKTJ5J01bmkE091+dDMIBnbfKUQQL2aad/Yi9TANj2MaSSm8j
    nVsKjuWf52UD/3nuc1yvosn5+vWO4njO1pmvhNk+YzLJ1NEMYYl2kk6NrpkC2uks
    j7TEbCLbNdcC1twLi6UlclpbVYSH0x9vkKcxCi+0KB3DiXlc+f94UQ2kOYVzgghJ
    2xzJnTNUeH392kHT8dJRQHOsNXbd3hsZSwXtpP9q34+PLoxTan03WudIPDUwFYy3
    scwnwb0uZV6why9euOCtjc7FX0BySKcugcSDjQPQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP/QFWk81zBp6fc/im5gn77linZBdqI0yULTNPNckhy9a8RzK6CdSukvGH6g0f2JscVycJ8HXjupV2nMvPYc1SdXDaZiqeyi3l/YheSqHn3BbpfVfEBl
    R7leZA9KozVmvv7gtTQ1WB2PlytebcqyRHTjQricZH5pOYE/++s22RUXnHpoZlV4Ohyczjxr/bmroc3DRLoJq2kcSK15MJaO/oWzXEyujOpS/kDWzOdV4xb0
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=P1BnusSwAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=UsjPlrKyebQagM4GtYIA:9 a=QEXdDO2ut3YA:10 a=D0XLA9XvdZm18NrgonBM:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755500AbeDKSpg (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:45:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58632 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755550AbeDKSpe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:45:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 049/190] sh_eth: Use platform device for printing before register_netdev()
Date: Wed, 11 Apr 2018 20:34:55 +0200
Message-Id: <20180411183553.163571273@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>


[ Upstream commit 5f5c5449acad0cd3322e53e1ac68c044483b0aa5 ]

The MDIO initialization failure message is printed using the network
device, before it has been registered, leading to:

     (null): failed to initialise MDIO

Use the platform device instead to fix this:

    sh-eth ee700000.ethernet: failed to initialise MDIO

Fixes: daacf03f0bbfefee ("sh_eth: Register MDIO bus before registering the network device")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/renesas/sh_eth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -3222,7 +3222,7 @@ static int sh_eth_drv_probe(struct platf
 	/* MDIO bus init */
 	ret = sh_mdio_init(mdp, pd);
 	if (ret) {
-		dev_err(&ndev->dev, "failed to initialise MDIO\n");
+		dev_err(&pdev->dev, "failed to initialise MDIO\n");
 		goto out_release;
 	}
 
