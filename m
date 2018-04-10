Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713595-1523400144-2-10835468461019350845
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
    1523400143; b=rMTIJpAHOwAJbXVUsoz2Md6a1/D5V6lcqrZ+jqw9ckx3lK4qaO
    Vb7yHso6BoTRSE9zsrG0pianbEYTf47yPQgKd2/zzXxbfPsD4jOyQlxlOXFdiUYs
    l3w8PdiLFFTWMJwR7YOVMjFFZ59wNTY1/Z/4yKo9LTHiLfuIdLuZLZxcvg/D29Jq
    WQDnh0JwwIMeS3Fe9q6M7oYKnxsuGcuYZ6h4j/yZxRV1vR9p7hcc2AhUH9vmO+PT
    Hu76pDQodBqF6sBxHJob1s0aNWUFYHoyoqn/bumDXc4T9HXiFdm4UiBGLCLRwPhY
    A+NOLNHhydaR6AyIUxMmx6Sh9OornrRAfhdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523400143; bh=qdanhGiwzJgW5xrsd3MevEr1MqjilV
    1OWz6DMlDnwLY=; b=HHPOMeSQxNuzrpWIMmY9/VDn8liGqxX/ozxVt4bX0IT8OE
    VE3ZsNTXBCcMOP6Hdwc50UII4nD1rJWTnzoc4qL9BxYV+cSSKPE4aBpihg8Kd4Wy
    Tch6tXp9LJjH7p5oboqzzQUnVNr8HM3rhPmGlyXquw7pvbt0edXaXVzoB67lb65e
    sXrW22D7twZ8J0VwCFQWg7skzGpBzav4trWSeSSlL2CDKj2jPKmhFhrnTiUrgJc9
    rjS4LkRmicqYsInJm9AKLlrRTQP34/rXTb7Vq+hpAprJhI45j9BTYQyqOISLNG1S
    qX0hbjN42SMl+A3qLUOTmg7gUcCAdSkpaz6bqGXw==
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
X-CM-Envelope: MS4wfJRrdB9DaRYR9N+VGEKM4iK44f5YE6+aF3eznYWRyx/WHhS395lUtfNb7fjgq0zo5eY5trPE63PfSY5YSqETbGbKN3qD2MZg6Yd9jAlNR7HAtkgkxDK6
    7ZuYzoB0zLN2SpWQWlBxk7DENcB3SKOhZU5wMNeZZE9SXh5+DWVGTC8b/ZD27F9VCE3dbRvV2pev6iLmE+HbrZQD0Tq7l3zJjHTaXEcvkDsfkFqUajWw0bUa
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=CbDCq_QkAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=jKXu83aJfUeL4nnnRXAA:9
    a=QEXdDO2ut3YA:10 a=1qrBK16LubpBFNPVNq2M:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756115AbeDJWkG (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:40:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46366 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756113AbeDJWkF (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:40:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 138/138] net/mlx4_core: Fix memory leak while delete slaves resources
Date: Wed, 11 Apr 2018 00:25:28 +0200
Message-Id: <20180410212918.281451781@linuxfoundation.org>
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

From: Moshe Shemesh <moshe@mellanox.com>


[ Upstream commit 461d5f1b59490ce0096dfda45e10038c122a7892 ]

mlx4_delete_all_resources_for_slave in resource tracker should free all
memory allocated for a slave.
While releasing memory of fs_rule, it misses releasing memory of
fs_rule->mirr_mbox.

Fixes: 78efed275117 ('net/mlx4_core: Support mirroring VF DMFS rules on both ports')
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c
+++ b/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c
@@ -5089,6 +5089,7 @@ static void rem_slave_fs_rule(struct mlx
 						 &tracker->res_tree[RES_FS_RULE]);
 					list_del(&fs_rule->com.list);
 					spin_unlock_irq(mlx4_tlock(dev));
+					kfree(fs_rule->mirr_mbox);
 					kfree(fs_rule);
 					state = 0;
 					break;
