Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-617694-1519837692-2-2598702637004481345
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
    t=1519837691; b=kJk5ijDdpqIxwRoMuEX8A+xwQUCMmHKpv1UTCKTzdmhUn2s
    Kw0i86nyycQCcANvhIQz8A4Br5+k+Q0rwptVJeJexN8c0GKOLNNnJnSNJ8CJRwI7
    TdnWz6C/TJdUYu4Nat1kGjk9ziD/50q5ym7J4skiou02gFS3kknluO/AElRxAWdD
    HTBaEKYhx0SxIHGvs5iKYyNB6rJbcBM/kQGKyT9tAZ/5e6ZGJNQ3h4vZ+l26HJgN
    VzZu2U51EfT+my/XnsFovScfYoR7VcYl3vI+U2x5YzmoQ1Lm3TAquJIzSgQVQJmi
    0t6ktlm17PnMNhdM64X5A5m/KBxqjCd8oL7OZbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519837691; bh=FTx03NvTK7nbWePrFwR
    1w0KaBFMgL9MD5U3Hp/B1LJ0=; b=wD5Jp4UV61vI9WfftW5qSdqGrfkLUFaa9uK
    Dz0LZw+ZD4xEdhBXv3tdJWkYNZfFVKZWNtUd5Sy69gGOOkXttXU+1anjylzgiZcW
    FW18fons77+gRqn588SeYAQR/HPNVVa8SgZQY2l+VwDrgvEWAAPe4FJocfBe83VF
    FO4xWXer9qJHPo698G/8BYdWI7VomM0FlxrLiyHOH7GmbGil2E5UFa1VN08ZvXOW
    fQVDdi+2QaKMF352ReuBPlwR/KTFMDnrVaVbLaYjgV+JjN+HNTTy8Xk7dzylqMrJ
    cCSbOf8lWO7zVVEGSTIMy8GqjSsDjMYRPcQ+vfvT+CxlHVL7NmA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933161AbeB1PuN (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:50:13 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34307 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933643AbeB1PuL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:50:11 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Moshe Shemesh" <moshe@mellanox.com>,
        "Saeed Mahameed" <saeedm@mellanox.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.890912608@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 134/254] net/mlx5: Cleanup IRQs in case of unload failure
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

commit d6b2785cd55ee72e9608762650b3ef299f801b1b upstream.

When mlx5_stop_eqs fails to destroy any of the eqs it returns with an error.
In such failure flow the function will return without
releasing all EQs irqs and then pci_free_irq_vectors will fail.
Fix by only warn on destroy EQ failure and continue to release other
EQs and their irqs.

It fixes the following kernel trace:
kernel: kernel BUG at drivers/pci/msi.c:352!
...
...
kernel: Call Trace:
kernel: pci_disable_msix+0xd3/0x100
kernel: pci_free_irq_vectors+0xe/0x20
kernel: mlx5_load_one.isra.17+0x9f5/0xec0 [mlx5_core]

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
[bwh: Backported to 3.16: there's no pfault_eq]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -485,23 +485,28 @@ err1:
 	return err;
 }
 
-int mlx5_stop_eqs(struct mlx5_core_dev *dev)
+void mlx5_stop_eqs(struct mlx5_core_dev *dev)
 {
 	struct mlx5_eq_table *table = &dev->priv.eq_table;
 	int err;
 
 	err = mlx5_destroy_unmap_eq(dev, &table->pages_eq);
 	if (err)
-		return err;
+		mlx5_core_err(dev, "failed to destroy pages eq, err(%d)\n",
+			      err);
 
-	mlx5_destroy_unmap_eq(dev, &table->async_eq);
+	err = mlx5_destroy_unmap_eq(dev, &table->async_eq);
+	if (err)
+		mlx5_core_err(dev, "failed to destroy async eq, err(%d)\n",
+			      err);
 	mlx5_cmd_use_polling(dev);
 
 	err = mlx5_destroy_unmap_eq(dev, &table->cmd_eq);
-	if (err)
+	if (err) {
+		mlx5_core_err(dev, "failed to destroy command eq, err(%d)\n",
+			      err);
 		mlx5_cmd_use_events(dev);
-
-	return err;
+	}
 }
 
 int mlx5_core_eq_query(struct mlx5_core_dev *dev, struct mlx5_eq *eq,
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -759,7 +759,7 @@ int mlx5_create_map_eq(struct mlx5_core_
 		       int nent, u64 mask, const char *name, struct mlx5_uar *uar);
 int mlx5_destroy_unmap_eq(struct mlx5_core_dev *dev, struct mlx5_eq *eq);
 int mlx5_start_eqs(struct mlx5_core_dev *dev);
-int mlx5_stop_eqs(struct mlx5_core_dev *dev);
+void mlx5_stop_eqs(struct mlx5_core_dev *dev);
 int mlx5_core_attach_mcg(struct mlx5_core_dev *dev, union ib_gid *mgid, u32 qpn);
 int mlx5_core_detach_mcg(struct mlx5_core_dev *dev, union ib_gid *mgid, u32 qpn);
 
