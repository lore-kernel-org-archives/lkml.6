Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182439-1521807636-2-11130213654517996419
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
    t=1521807636; b=P4G+b84YG+N0XY4+EtnYz2U19v67ZzfDpdcdTrIruDCl4Hz
    u2/TdMrGAaIP5SqGwk21wMFaooplDBR8dGIfZuxbZoGkLK3MtSG17kwxP713s6+4
    PE5VTjwqv+c1xiDzvgtNW7F5aiUikSyHPIcv7GRjeYLbndGtWYHoXc8WgEews+o7
    VGak4OG8f1ECky9ZIp+QnpYMMsnuY2EDjwFJo4D368JKKOIwtzFNB6TjojabafFk
    QzdsfcMT0ZjUnzdYUY9W470sqivkvmzH2t2t8o5e2qfOpJVUz8QynRLq3SsZUq1i
    9RJOAdjDxBZKh801IShd3hydRdx6qBlyKN8COIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521807636; bh=ZFaAEZO0J2WDQvXmVJWIRAn7cf
    LU7SuV0x5gKhJwUNo=; b=KqDDkvTu3cqaRRhJ42u+GLX+M7Q2WWqnhIZ1xouvMo
    tbepI4EcrXRBPiW/BD9FWhdcsVufqYcd7foCton7LhEhvDGbAvRXfMowcwZIYFR4
    tKhRZr1hNlmWQ0Bp0ySBWHp31Mc7NF59vKESzzdHf5XcDQ8SM6S3xMqZ5HbHEP0G
    AwCqXHN887tntd36rUQ1wKZ87RSQo9TNSsJE1ggB3ZQHNBOalou26x2ylQXxQXNP
    kyulzt9Js12A+F9cZJthgL+gzRZ235rMS/ONWoXC9dbijmG8OfWQMouakbtWpyUD
    89I2gJkKBPqtEDwcjGT1mBbg3+IFzpQq6xfIA5oHB+eA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
        id S1752427AbeCWJz7 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:55:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33808 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbeCWJz6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:55:58 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuval Shaia <yuval.shaia@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 10/84] IB/ipoib: Warn when one port fails to initialize
Date: Fri, 23 Mar 2018 10:53:24 +0100
Message-Id: <20180323095413.485430317@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuval Shaia <yuval.shaia@oracle.com>


[ Upstream commit ac6dbf7fa4707c75a247b540cc0b5c881f3d0ba8 ]

If one port fails to initialize an error message should indicate the
reason and driver should continue serving the working port(s) and other
HCA(s).

Fixes: e4b2d06892c7 ("IB/ipoib: Remove device when one port fails to init").
Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -2207,8 +2207,10 @@ static struct net_device *ipoib_add_port
 	int result = -ENOMEM;
 
 	priv = ipoib_intf_alloc(hca, port, format);
-	if (!priv)
+	if (!priv) {
+		pr_warn("%s, %d: ipoib_intf_alloc failed\n", hca->name, port);
 		goto alloc_mem_failed;
+	}
 
 	SET_NETDEV_DEV(priv->dev, hca->dev.parent);
 	priv->dev->dev_id = port - 1;
@@ -2337,8 +2339,7 @@ static void ipoib_add_one(struct ib_devi
 	}
 
 	if (!count) {
-		pr_err("Failed to init port, removing it\n");
-		ipoib_remove_one(device, dev_list);
+		kfree(dev_list);
 		return;
 	}
 
