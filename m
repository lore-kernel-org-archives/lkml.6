Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC7BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 14:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248D7214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 14:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLkVpqGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbeLZOJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 09:09:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36189 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbeLZOJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 09:09:41 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so7628298pgm.3;
        Wed, 26 Dec 2018 06:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=y85zGKOTx0Tqi7DozW6mORIo44USvHnVcVjSBJz/9Ww=;
        b=dLkVpqGnn0EOalMXMfrFtZRy7AfkZXQ1NElkvDzvyGNqnbzX1uX25sGNUTaCdyeVoJ
         BMy7ORPMQaMNv/lpr76AbmbOz3rZVNi8hd/W6UY91kFmmqzJg2gcEWlR0f94b+VVG8Jh
         niruZHsdzJtWo7oGzI1IQjHFeep8SITMYYMupLHOzA/2hc8LiE34T5dAVQpnBONyTywv
         BKMIvFtPry3X0gIvxTkOVHc3eGwoFAfIqXY/ibvSv7SAUUWqDgwdTe/xPT9UfjRWUwiI
         MtElMfCzZs2TYeO5rA6FYKzGgOIfRuLmZgsXBN0vM0nEFfl/queT6fOWlTa1+A+Dg2MN
         eTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y85zGKOTx0Tqi7DozW6mORIo44USvHnVcVjSBJz/9Ww=;
        b=AUCCzjTR6KlwlZ8qd5838GDSmkW6Rw3DWt7pRpIigsKTdkJtzyzS7q3F/XFTddW7M4
         HQqr482CD8+KuJ5G2eTg/i9gPkgc/x5lcIkmiMO4GPuQH09Rgd3/rlKWOrkhK8aoteX+
         PJiY5GMZb762MAJ5w12DmQgdtS1N9b8ZCXiH6J17sw02EYUpxlgv0eHGq9J3v1dabAtU
         S5go4RTRD0iL9xm66kjpi6bNgf881W640c2aZ3nZKn9+RuJDl5U1a7g/tJBQkWTIcyDo
         PoS5T6WncErcXGMOGduNhGmUITKs1Zr2c77rumFEthdOrRElKkqfqiwIXlzZfQndnaHk
         nzjQ==
X-Gm-Message-State: AJcUukc+DeHWTMOOnFoK0elMRSDwAm1BdaEiPGlgtl5UHFUr4RbdxMjc
        anIP3upC/u2h3IR256DZi7izG2dS
X-Google-Smtp-Source: ALg8bN4F3gkpG+h46tDeWhwyt5cqgggEly4LqEnUgNsCKE818YHJh9gd1mY77v+mD24vixQXLB03EA==
X-Received: by 2002:a62:9f1b:: with SMTP id g27mr3994348pfe.87.1545833381191;
        Wed, 26 Dec 2018 06:09:41 -0800 (PST)
Received: from localhost.localdomain ([2402:f000:1:4414:a8df:74f3:1213:8d3d])
        by smtp.gmail.com with ESMTPSA id u8sm52661093pfl.16.2018.12.26.06.09.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 06:09:40 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     isdn@linux-pingi.de, davem@davemloft.net, natechancellor@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] isdn: hisax: hfc_pci: Fix a possible concurrency use-after-free bug in HFCPCI_l1hw()
Date:   Wed, 26 Dec 2018 22:09:34 +0800
Message-Id: <20181226140934.12903-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In drivers/isdn/hisax/hfc_pci.c, the functions hfcpci_interrupt() and
HFCPCI_l1hw() may be concurrently executed.

HFCPCI_l1hw()
  line 1173: if (!cs->tx_skb)

hfcpci_interrupt()
  line 942: spin_lock_irqsave();
  line 1066: dev_kfree_skb_irq(cs->tx_skb);

Thus, a possible concurrency use-after-free bug may occur 
in HFCPCI_l1hw().

To fix these bugs, the calls to spin_lock_irqsave() and
spin_unlock_irqrestore() are added in HFCPCI_l1hw(), to protect the
access to cs->tx_skb.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/isdn/hisax/hfc_pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/isdn/hisax/hfc_pci.c b/drivers/isdn/hisax/hfc_pci.c
index ea0e4c6de3fb..0109e0e8bcb6 100644
--- a/drivers/isdn/hisax/hfc_pci.c
+++ b/drivers/isdn/hisax/hfc_pci.c
@@ -1170,11 +1170,13 @@ HFCPCI_l1hw(struct PStack *st, int pr, void *arg)
 		if (cs->debug & L1_DEB_LAPD)
 			debugl1(cs, "-> PH_REQUEST_PULL");
 #endif
+		spin_lock_irqsave(&cs->lock, flags);
 		if (!cs->tx_skb) {
 			test_and_clear_bit(FLG_L1_PULL_REQ, &st->l1.Flags);
 			st->l1.l1l2(st, PH_PULL | CONFIRM, NULL);
 		} else
 			test_and_set_bit(FLG_L1_PULL_REQ, &st->l1.Flags);
+		spin_unlock_irqrestore(&cs->lock, flags);
 		break;
 	case (HW_RESET | REQUEST):
 		spin_lock_irqsave(&cs->lock, flags);
-- 
2.17.0

