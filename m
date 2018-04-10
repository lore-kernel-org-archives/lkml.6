Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-807177-1523400237-2-17152416112410707692
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
    1523400237; b=rF1inJOSz7RoEXDt2yRfgnxwxB2ZoyZJsqej3LEmsjO+U8Fcmx
    Oayam2oG60FoMKolSu84pBZtAzKLEDoMNzrcD5X97OTR28b/KIQtWFS0khBVBSZ7
    AZfPKEfPJgNec6csl2dIqLHTn/IhK0bcyZDV8n4uKdy59wWxH2kh6kX3HfiQY9SK
    N+TMD3M/w8g59qoN0znZtLxAnAukEes2JURSmW4ruspqM96ENbNDfySdjhiaSn1K
    QxCC7hAo6Qax3LB0PGwu6MxRA3mx57WpVLawWfkIdf/c+lFoKJWb1dXmbYF/t6wj
    rT30tDPYQPhfdtqsM+S1lN9u6l+rG57Ypnjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523400237; bh=HE86ngVMMgmBj9iih70xM/vEvyKtJe
    wJJjWrBYNy74s=; b=Ytf2y4PwNwcRVV3LWSyj9i4r1cQNeeS5DF8lrNGhkXx2Gf
    9z/gnFo5iWutzw9iR4ssye2/bNpC0VKmeRsJJNxmX4ERv32ECZatEwQVQN741cLh
    nxwwyQTGQoS2ogiNPHjV7c/Wkd2fpDlJGaQtKo3Wmy4vcFiKJpZ0IcketCPQ7Ir2
    pnEyGXz+dDYGlhCZiP7KZ2mDkOLp1+ot/M2SPKTZCqpaQlqQiFJ3rZ8B2e53+aSG
    dRpNdZ1xL+M0E+jmJiB2Q3KDnppmOsZIxeNZ5BEeFWaC334VbxUKkOSleQCyY1I3
    h3gyaHznMI88ptbpQJwwAYFwBZWAUBFZghJ8aZFQ==
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
X-CM-Envelope: MS4wfE8oHRbZ3sBNdNfbp3Izu7qaegCdVduXbu69Ivsmo7yRdOcLsrNU1cirvWpAdSUcQiy6sWEbErXRJP1d6GFR8t78Ys3iY8kxDOL+UoNqM35YfCEmB+BD
    QiBlJHZ7yeYjlkw84EL7vImIvv+Vc5tPPxNNKWRz9cT9yq4tWmJOzXFyfNFSD9C7dOnHb86yF+9oJb011FHVjuLzGY3amGIRemItRs8NnMbEGdr0a87zuF2L
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=DfNHnWVPAAAA:8 a=danhDmx_AAAA:8 a=VwQbUJbxAAAA:8 a=J1Y8HTJGAAAA:8
    a=ag1SF4gXAAAA:8 a=gJjcm8xDonOmdvZi31gA:9 a=QEXdDO2ut3YA:10
    a=rjTVMONInIDnV1a_A2c_:22 a=P4VdviVPEcjfz_PVVggX:22 a=AjGcO6oz07-iQ99wixmX:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753991AbeDJWjd (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:39:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45262 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932636AbeDJWjc (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:39:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 110/138] sky2: Increase D3 delay to sky2 stops working after suspend
Date: Wed, 11 Apr 2018 00:25:00 +0200
Message-Id: <20180410212914.971331458@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
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

From: Kai-Heng Feng <kai.heng.feng@canonical.com>


[ Upstream commit afb133637071be6deeb8b3d0e55593ffbf63c527 ]

The sky2 ethernet stops working after system resume from suspend:
[ 582.852065] sky2 0000:04:00.0: Refused to change power state, currently in D3

The current 150ms delay is not enough, change it to 200ms can solve the
issue.

BugLink: https://bugs.launchpad.net/bugs/1758507
Cc: Stable <stable@vger.kernel.org>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/sky2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -5087,7 +5087,7 @@ static int sky2_probe(struct pci_dev *pd
 	INIT_WORK(&hw->restart_work, sky2_restart);
 
 	pci_set_drvdata(pdev, hw);
-	pdev->d3_delay = 150;
+	pdev->d3_delay = 200;
 
 	return 0;
 
