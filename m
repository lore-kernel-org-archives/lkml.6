Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516026-1519833999-2-17831886817223399942
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519833998; b=T+d9zBum1lLz8JKNF8zAnCTffASYNXaETuENtG0n5mllqT2
    ftfOTNnjx5mH9cVm2Pf9VpD7bHSH1CftuVibPOJXXUTcIVd1r9JFSsCI6tExBPV7
    rQvO5f/1Ie5QKpiWLy0I0FM8CfIS7255P0eyXG6Ie5IdB82K+5aFdWjNNezIbgeD
    pkzQicUDSxAXggdySkf+9uEScdZqhRNL8ISbJnrgPInTlUHX/6kG27EKLEPpOiAb
    GR+FD9QLRIW5a4xD3GuqdYPXQAJNckAdxNPIcYCB3T4rp/p1IP0MHZVu6XvPyrDf
    h6SXpbjbVITHM93lOY5810pW/APmWkWl0yE8KQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519833998; bh=EzTwYMe0yLuC7SBE/C4
    2zhpcAbWM2FMOhovddtQKxj4=; b=H/amOkcWkoOmbj93n2R+Ezus0Jsz2e7aslU
    Gsha/9Ko9T7ZArPeBJjTdh9GweBZFUxEOxuw/PSGWZIpGIss0l80Z5leV+Y/r3m4
    jWTE2RcXuEHTP1MlRS+9orfXg0Dhr19yGyFEdfnhM598yVu2ysAZ2XjmMkObCC+2
    siZAyK8IteXP19aYwjcdAav/sPmiDe2rXobyzBP0ngju2a0ZNyfdLIFivScfr7gB
    jVwOpS68S2yLC6pVg0VQc+8nELe3EUT5wSnEELiueTCdsgJYRyQb/4Vd9wK2IPMS
    D1bX9jckVKQE3Iwu6pQjuuHp4LUrRJtco1l0unZ8NoATmUBHfhg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932709AbeB1QGV (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:06:21 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34900 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752742AbeB1QFj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:05:39 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Saeed Mahameed" <saeedm@mellanox.com>,
        "Moshe Shemesh" <moshe@mellanox.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.222830278@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 135/254] net/mlx5: Stay in polling mode when command
 EQ destroy fails
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

From: Moshe Shemesh <moshe@mellanox.com>

commit a2fba188fd5eadd6061bef4f2f2577a43231ebf3 upstream.

During unload, on mlx5_stop_eqs we move command interface from events
mode to polling mode, but if command interface EQ destroy fail we move
back to events mode.
That's wrong since even if we fail to destroy command interface EQ, we
do release its irq, so no interrupts will be received.

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -502,11 +502,9 @@ void mlx5_stop_eqs(struct mlx5_core_dev
 	mlx5_cmd_use_polling(dev);
 
 	err = mlx5_destroy_unmap_eq(dev, &table->cmd_eq);
-	if (err) {
+	if (err)
 		mlx5_core_err(dev, "failed to destroy command eq, err(%d)\n",
 			      err);
-		mlx5_cmd_use_events(dev);
-	}
 }
 
 int mlx5_core_eq_query(struct mlx5_core_dev *dev, struct mlx5_eq *eq,
