Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2879036-1517591222-2-17369814761383614620
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591222; b=E/jMxKGCLWjkuK1QosHbbAHt15VWl4ntwofLQWieouWcH9C
    W9Z8V+6Qgds+UlGrZxUpAqLn1WciP+3rBAC3R65/l227RIQXlBSABwcUEFo5kepn
    MIO5qbuz29TDXqMG/NkPBZ9VWOEEWxKwPf7zhWMK5oW+kqEus8tEHmq6dtQsXnrP
    B2zFWxcQdHCk9WoKWRPg+Yetla11Dm2C4kmd2jfDHKbJrEEBKhXPzLhd5lr0oYhX
    h9beUb6x0O6wnklChWJg3M+exl7fhkfypY2gml/O30NUAdonCs/dq+GER8avO0oI
    dkXIsoyLFzBMYmA0J3xhk7TY9/OQtXZcQAuCFUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591222; bh=OkW1CoW2y6dAXllRFn0vbKZlO+
    DoE0sF9L7m0KxJw6I=; b=Bcj20IN/AcUl2pHTK2CoIqSUW41i+r0PbjHf9vPIJj
    cMI9F8CY7TlFuY11bziI20tpeQnpIkOwsTrmiZD8yM2tF08muwFT8Zv5TIQxUWJI
    w7YKskEW+xPgMOMs7H6B4j3zNpZLHDxSNGboKvFl33Vwr6oUPCX64jyiqf+v1H5U
    5/IR9t+Qt7uVO4QoxxL+AG4JyEAORopGK2gDz2Xeek58qqelC4m/Yc8vg50nXbLA
    q/g3JmW2eHYmU/M+EzxE7HRbD6LzY2q8kQeYJXMGg2SUfJ6h/z18DAhUtvSutNvw
    v2DCtzqrcAzQsBmdNnK5Vu+zPG3XDEUuUD7E5PZ2l7cA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752895AbeBBRGz (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:06:55 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36888 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752578AbeBBRGx (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:06:53 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 47/86] bnxt_en: Fix an error handling path in bnxt_get_module_eeprom()
Date: Fri,  2 Feb 2018 17:58:07 +0100
Message-Id: <20180202140826.626849930@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


[ Upstream commit dea521a2b9f96e905fa2bb2f95e23ec00c2ec436 ]

Error code returned by 'bnxt_read_sfp_module_eeprom_info()' is handled a
few lines above when reading the A0 portion of the EEPROM.
The same should be done when reading the A2 portion of the EEPROM.

In order to correctly propagate an error, update 'rc' in this 2nd call as
well, otherwise 0 (success) is returned.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1843,8 +1843,8 @@ static int bnxt_get_module_eeprom(struct
 	/* Read A2 portion of the EEPROM */
 	if (length) {
 		start -= ETH_MODULE_SFF_8436_LEN;
-		bnxt_read_sfp_module_eeprom_info(bp, I2C_DEV_ADDR_A2, 1, start,
-						 length, data);
+		rc = bnxt_read_sfp_module_eeprom_info(bp, I2C_DEV_ADDR_A2, 1,
+						      start, length, data);
 	}
 	return rc;
 }
