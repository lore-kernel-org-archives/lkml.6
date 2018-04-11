Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3374234-1523481466-2-507823126461144234
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523481466; b=KpKo2aDTP3umJRu4KZB9ys7TM4JyM2GAjMKMsDLyFd61qHWHAG
    csB8rcChP2a5FoRrYaLBaIy7pOPi+JsEQHmd6FQpD3Oq7kn4akTLuqT5B+JaRvrf
    O7oGqaaxqppx2Qfw6bk/sETA6Or44PdEcK1S4TYe17CLG2nNloJ5Y1ivNWVSLHNC
    lX+EpHet1IF63MVkmXhu+ktVw8LeCYrl4/qLynTGY9bN+rCOXNSVOmSHai7Wcdmn
    e3Xv6bcSshavRTLKuZ/QNEFi62mNIM1PHGkqACw/yqeCPrcVatKJjcebHV/yVh8a
    CSLKz7bRubFZiLwziXPRDapBo4q+VXk2CFiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481466; bh=dOFTOCZQA8xNjxzfEAz0FheLYAnBdx
    iAAAeWN18NVJc=; b=g/Ncb4l/bdMh+LT5FPv7aRnT1aJD+pxpD/lbFVst6GydwO
    Jpk9mTsavv5d1i/5/4zhWMQWPNO2tcWlR+LpPIxMRVnrhje4BKv+Bh28CyIFOlT+
    sgrF1EEy7otOf/kmjAiulzsvfLacTv6mfCzTezQzp41lXVvqJ1TrKM9GtpcNa8I1
    DIF/oW0TEO36AI5rLrxuIQ9mQxCI3DTSi4eDQhC3j1KE8+4T0msTxAdLk9wNQll5
    C5ZXKF/qIHrDL113yEYVpIM/OG2gmxBq84zlGScoMgydamPUlhOZRhT35b5vAvwM
    /6gi/EbLh7EprjoyRB+LFsphVF+hOH9tvqaB1w+g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfLm1XbfW1GtCH0hDisp4umuUPqpOf8pqCqWI1vVHy7wATEuJKJ1ydhh2FukCQr3nk5d46wUtwA/wdbT5wB/7w2GapkBGXO519wD0FQvKpCGhAMH2ffZv
    +ueZJj1GQXBBUgi7D2xV+2o8Xq1nndphf+G1Wz088IKk87H4PGCgq0Bu/YMnB5gGRg9eJ2Wwe/HxZ6FjNT+ci+0DtGmi5NRfn0CusTuTkHYFiHP3BpHe4e5c
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=_Wotqz80AAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=5PhJyk_Jh2pAj1HTYjAA:9 a=QEXdDO2ut3YA:10 a=buJP51TR1BpY-zbLSsyS:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754319AbeDKVRk (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 17:17:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56360 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754572AbeDKSkO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:40:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 058/121] net: freescale: fix potential null pointer dereference
Date: Wed, 11 Apr 2018 20:36:01 +0200
Message-Id: <20180411183459.805988100@linuxfoundation.org>
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

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>


[ Upstream commit 06d2d6431bc8d41ef5ffd8bd4b52cea9f72aed22 ]

Add NULL check before dereferencing pointer _id_ in order to avoid
a potential NULL pointer dereference.

Addresses-Coverity-ID: 1397995
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/fsl_pq_mdio.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -370,7 +370,7 @@ static int fsl_pq_mdio_probe(struct plat
 {
 	const struct of_device_id *id =
 		of_match_device(fsl_pq_mdio_match, &pdev->dev);
-	const struct fsl_pq_mdio_data *data = id->data;
+	const struct fsl_pq_mdio_data *data;
 	struct device_node *np = pdev->dev.of_node;
 	struct resource res;
 	struct device_node *tbi;
@@ -378,6 +378,13 @@ static int fsl_pq_mdio_probe(struct plat
 	struct mii_bus *new_bus;
 	int err;
 
+	if (!id) {
+		dev_err(&pdev->dev, "Failed to match device\n");
+		return -ENODEV;
+	}
+
+	data = id->data;
+
 	dev_dbg(&pdev->dev, "found %s compatible node\n", id->compatible);
 
 	new_bus = mdiobus_alloc_size(sizeof(*priv));
