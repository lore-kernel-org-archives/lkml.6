Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518324442-2-10993157610332917348
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324442; b=p3a/AKyeVziVYOn2VortDgTcRSrRA5DTOUpACj1ZacqCTvU
    b7DwUt25dk3nBvB6+B3iEy3E2bMktGd1IJxVMzoVUfMLJ5LHOISv/wz7Gi0RJVdS
    gKogk654zVILrZWP2LSZswe8hm93Gd5kT3nLZYfh7y+Ih1ygr4JKIwOA9ueboU91
    7taXelXxTOg34h1a4WZIcdBy1hMV52RBN1y6YjUQjcsiYYmbvqyDToHftObUnGPP
    yR28a4597OQYBpQPyRX9FbAxVrsEPAA/98mLN4lbCrDFVqVNJT0c3A8L0fZxGtlx
    IyYJzAT4i7rgzznVqPM2tFchcYhPTHlmG53aaVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324442; bh=/egQlynq3BYaJgCnvWH
    qAV9J4iTQD1FkmcwD4pn5Ltg=; b=gnKYTrEaagEORNHw8YXOjU2Gt8fYly3nEcJ
    tTAl6LDU9+EPs6haZScpn7IW/eGb0HG+lUtbe+G4+7vWoQ+oDNscxDAFm17jJbq5
    LRhoh7+h9BKA58kO3ES+BJtH+czlfpO4OjBt7K4J13goHUDX301ejhTvlxy9MJrN
    7h+/ItGdIfqfYs1I94pidN6zWrNFFmGQgNm5Y7+puMApipznUaNwmTlL/BMyaOUn
    EtnRgilzF5amLscUZgxZ8AU/X5xiz+4MZXyeqU4NFnGY8OiWVO9xyMmcYEyjAf8G
    gdU7vZbeL3MjKyX7mZwVRjwu5W3TzDoQZKSgPYiwOfsZELGRXWQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752943AbeBKEpN (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:45:13 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41869 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752857AbeBKEd7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:59 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Yishai Hadas" <yishaih@mellanox.com>,
        "Doug Ledford" <dledford@redhat.com>,
        "Majd Dibbiny" <majd@mellanox.com>,
        "Leon Romanovsky" <leon@kernel.org>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.753721851@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 077/136] IB/mlx5: Assign send CQ and recv CQ of UMR QP
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Majd Dibbiny <majd@mellanox.com>

commit 31fde034a8bd964a5c7c1a5663fc87a913158db2 upstream.

The UMR's QP is created by calling mlx5_ib_create_qp directly, and
therefore the send CQ and the recv CQ on the ibqp weren't assigned.

Assign them right after calling the mlx5_ib_create_qp to assure
that any access to those pointers will work as expected and won't
crash the system as might happen as part of reset flow.

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Majd Dibbiny <majd@mellanox.com>
Reviewed-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/hw/mlx5/main.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1164,6 +1164,8 @@ static int create_umr_res(struct mlx5_ib
 	qp->real_qp    = qp;
 	qp->uobject    = NULL;
 	qp->qp_type    = MLX5_IB_QPT_REG_UMR;
+	qp->send_cq    = init_attr->send_cq;
+	qp->recv_cq    = init_attr->recv_cq;
 
 	attr->qp_state = IB_QPS_INIT;
 	attr->port_num = 1;
