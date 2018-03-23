Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182439-1521806991-2-3023508532529627061
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521806973; b=KEC88WvhEqTkybQjqLg093G5Xc7F/CNfS5omkPhrywfSLIO
    7a8gT2Q6uxqS1c+YB3Ob5vqkhyLFlp13KyiwUIkP4bVoMZ8ni86nrd2Iy7Px3VBV
    sBSRRCfIgHgPwARvrBKrcQCsXYYxfuC+N3RvWZA96meNrgG27Qv5zpSFdrfo/ZNB
    uLWjdBsYMSjljWGcL8EbK8cERPR+lG1p3udGbkpu3UbVHgcvMr9OA27QVTWfJfoK
    XCIBbwVcztefdqMqrz4K1aX3eAUAOxmqKTs6dpdou0rcFsqBVoKPPufR7hQQ6K92
    eM8NFoi0LhhUvUjXe4xv2/G+KdjikTq8COSMoGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806973; bh=i3hueus1PPMl7PT7URzZnfmcSl
    Pga3U0Z1vEA9z8IHs=; b=nuf/Sk12fME/NE3l2ltrv+YF4Wben0mVdq7L5hVtFa
    ZCYnSCJFncK+SAroNlN2qIhl/HsD/xaigCO9svgoN4GC4fU9hlLSvTSWGkfAOsae
    WyovrBw48EjFtHIzJsfK+SOXHIjFZtG2CNErihdROQt6hOVvYxCCzEb8/O3vH82u
    /z/3Bmnh0c8ySYnC+1vdy6Y7I6moPIvSW9MxcNviuAhS4+E+PLgXynma+HSacwlt
    HojWPGgM3G7KYBAguvnDD2J2RDE0WQ8Xvn2bLcvc9YILGDE4S1PN9WLvv7j3oAHJ
    VialF9naQeOmTuG02rjfOKMrCeqy8AKYglTetQF1lGUw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753093AbeCWJ6X (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:58:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35672 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753054AbeCWJ6S (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:58:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Parav Pandit <parav@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 40/84] RDMA/cma: Use correct size when writing netlink stats
Date: Fri, 23 Mar 2018 10:53:54 +0100
Message-Id: <20180323095418.049917282@linuxfoundation.org>
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

From: Parav Pandit <parav@mellanox.com>


[ Upstream commit 7baaa49af3716fb31877c61f59b74d029ce15b75 ]

The code was using the src size when formatting the dst. They are almost
certainly the same value but it reads wrong.

Fixes: ce117ffac2e9 ("RDMA/cma: Export AF_IB statistics")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/cma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4432,7 +4432,7 @@ static int cma_get_id_stats(struct sk_bu
 					  RDMA_NL_RDMA_CM_ATTR_SRC_ADDR))
 				goto out;
 			if (ibnl_put_attr(skb, nlh,
-					  rdma_addr_size(cma_src_addr(id_priv)),
+					  rdma_addr_size(cma_dst_addr(id_priv)),
 					  cma_dst_addr(id_priv),
 					  RDMA_NL_RDMA_CM_ATTR_DST_ADDR))
 				goto out;
