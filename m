Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3308147-1523479289-2-7685625571001734579
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523479289; b=tNUucn1icBjnfx0QEvu/EM541FqjxvaeROJkExAGZ7pJdMxIOX
    WbE6H7TqSDboHcrWwMsp97/5JiNnvulVN71o3umc66KVgqIwtsf9tOhc0csUUTXB
    bnmLb0quUUXiSCxi3Jf61fligfrUkBAlsm1NfnHsvhhFCn6JXqUQ6N3NF+r/5aOK
    5vN4k84TJREn930Loge+zd4x2Q4BOkOsjLeeP+b2m1Pdh4Rtdo8r5hc4t04nFP0C
    eC++FMMxjvcKYSqUJAp4vLYT446hKZLOcE9bGRbX3YLxV1YvEC4RzWFshGVuyO2f
    fC0Cym6wdOBUermfdSyT45oTT+sf9KDEcz6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479289; bh=I919yoIn509U++qgdUEMFdRP4MbB7t
    GgIRUvVchbT4A=; b=QilNi74p88uhcQ4YRaCKHYPMKYn+F+6uj91abx9Zx06ld9
    ARdcDfWtaeEXTGU41n5UjwrSPO0Hz7REPTPFKqQnFSh84ZxEWqlmm+nkfh8ZmUMm
    cw7o4x84GYAnIHOGg13kfQNTkGHLEWIEkTLs/eHd7wWVgycGWgCnbZdU5Q5BoGxN
    OSxaODcyDwJaCkHx8OS7rXyCTJDammRx/XBwNbhG1Y4JUW9CH8ebRJm6bKvj2t+I
    FDWEYKT6xKkNMWXbGb2YqyC6yj4vD7scuFkx0ymCqQgt2YKyV87Q6UDpZ2uIzvMn
    UtDpsh7zSgw4N5GsKL+k6XEqDLytrasGesOsreZg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIJd/vkJdDnDcEDUXrgjnT1o/LbASFPVjhbCGFFbsf+VEpfG9WEjMEXZMfdvR4V9CwBfqeLVm7hV5LUTMVx0QcQjeipgG24BoOSYIPGthIJqJIfd8Y+I
    w+Jn5ng3/G30d2UVsNtBgsmB1ezWuJKyUy8qOaxgiHpBxThU2U5KwOos190PBxuDZu/lPLnPlk0eMzGR3S7SshMxT4okxq9iDunfspH8ycwyLWDVHyfsR4hS
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=CbDCq_QkAAAA:8 a=FOH2dFAWAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=DHvo-kCpbA9waA3HB68A:9 a=QEXdDO2ut3YA:10 a=1qrBK16LubpBFNPVNq2M:22
    a=i3VuKzQdj-NEYjvDI-p3:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755987AbeDKSru (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:47:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59452 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755970AbeDKSrs (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:47:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tariq Toukan <tariqt@mellanox.com>,
        kernel-team@fb.com, Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 063/190] net/mlx5: Tolerate irq_set_affinity_hint() failures
Date: Wed, 11 Apr 2018 20:35:09 +0200
Message-Id: <20180411183553.993115012@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tariq Toukan <tariqt@mellanox.com>


[ Upstream commit b665d98edc9ab295169be2fc5bb4e89a46de0a1a ]

Add tolerance to failures of irq_set_affinity_hint().
Its role is to give hints that optimizes performance,
and should not block the driver load.

In non-SMP systems, functionality is not available as
there is a single core, and all these calls definitely
fail.  Hence, do not call the function and avoid the
warning prints.

Fixes: db058a186f98 ("net/mlx5_core: Set irq affinity hints")
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Cc: kernel-team@fb.com
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c |   15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -513,7 +513,6 @@ static int mlx5_irq_set_affinity_hint(st
 	struct mlx5_priv *priv  = &mdev->priv;
 	struct msix_entry *msix = priv->msix_arr;
 	int irq                 = msix[i + MLX5_EQ_VEC_COMP_BASE].vector;
-	int err;
 
 	if (!zalloc_cpumask_var(&priv->irq_info[i].mask, GFP_KERNEL)) {
 		mlx5_core_warn(mdev, "zalloc_cpumask_var failed");
@@ -523,18 +522,12 @@ static int mlx5_irq_set_affinity_hint(st
 	cpumask_set_cpu(cpumask_local_spread(i, priv->numa_node),
 			priv->irq_info[i].mask);
 
-	err = irq_set_affinity_hint(irq, priv->irq_info[i].mask);
-	if (err) {
-		mlx5_core_warn(mdev, "irq_set_affinity_hint failed,irq 0x%.4x",
-			       irq);
-		goto err_clear_mask;
-	}
+#ifdef CONFIG_SMP
+	if (irq_set_affinity_hint(irq, priv->irq_info[i].mask))
+		mlx5_core_warn(mdev, "irq_set_affinity_hint failed, irq 0x%.4x", irq);
+#endif
 
 	return 0;
-
-err_clear_mask:
-	free_cpumask_var(priv->irq_info[i].mask);
-	return err;
 }
 
 static void mlx5_irq_clear_affinity_hint(struct mlx5_core_dev *mdev, int i)
