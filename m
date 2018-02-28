Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519835887-2-1229771975990845729
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enit,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835886; b=HOjWppP8LwN9lZpyThyI9Z1/V6yPcYeTMoG0Dlr2+p5kuiR
    0/oXRiy4PLfnyGSoGIp1BKFCTfwodB8dB1Jeffmtt3RnlLlrUH9uFaPsvEJ0hrL/
    qHy0DO/DLDuDH41tMks4f6ibfZGystkZi7mKtw12Qa5mvexo30sf7w6UoMWQEDrj
    Rs2J8Zw26AgZgVoFdl4CadjHwNgUsyqYyc2CO1w57otN6ROfh35eytwD0L4LDLP+
    cwr7jVTtf4g3uCvq8RSJYojW3vP1z73vTZ0onaWkMrtXHLq6Mmft7PYQrkkkGIyp
    mi4PMcrXCnnRNqK715EXxKdf7UNejcQhjfqgxYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835886; bh=F9A6hIaSFSVipa39orJ
    h5k5m0fh6qvXCArSFKWh2r60=; b=X+8Xqd9kKQLz2Sk7ikXRbJARc+DDioDOgYq
    0bWS6mBO5ibeRlQ2MtDVc1VeqFnClkXCU463lrlsmOynCGpygMYtUHvCO84qV0R4
    j4Oxsn6BZLRCVj/AFeGat63y5+9i02F+/hEjQrHTcRRPDchBT0tCZEU2wm1FkjUn
    XWUYW1u9B5+dgwG51JDerb6Pxsq8VCk/K60v0kDFLHaRufA/tJbqXnN9i7SLY6gV
    keTN3TCP5hItee57Zdo4SAcb10ZzQxfXVVSKWUq32iBeeidwLjCOtUiPlsmwtkNB
    6NokJiO3dAHeYc9+eNOdOoi4qBo8qHGsugmRMHTQdYHgPPu5BvA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753190AbeB1QE1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:04:27 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34819 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752569AbeB1QEY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:04:24 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Saeed Mahameed" <saeedm@mellanox.com>,
        "Eugenia Emantayev" <eugenia@mellanox.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.172101379@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 133/254] net/mlx5: Fix misspelling in the error
 message and comment
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eugenia Emantayev <eugenia@mellanox.com>

commit 777ec2b2a3f2760505db395de1a9fa4115d74548 upstream.

Fix misspelling in word syndrome.

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Eugenia Emantayev <eugenia@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
[bwh: Backported to 3.16: drop change in health.c]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -261,7 +261,7 @@ static int mlx5_eq_int(struct mlx5_core_
 			break;
 		case MLX5_EVENT_TYPE_CQ_ERROR:
 			cqn = be32_to_cpu(eqe->data.cq_err.cqn) & 0xffffff;
-			mlx5_core_warn(dev, "CQ error on CQN 0x%x, syndrom 0x%x\n",
+			mlx5_core_warn(dev, "CQ error on CQN 0x%x, syndrome 0x%x\n",
 				       cqn, eqe->data.cq_err.syndrome);
 			mlx5_cq_event(dev, cqn, eqe->type);
 			break;
