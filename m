Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB20C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA768241DB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA768241DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933530AbeFVM2u (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:28:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48281 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933467AbeFVM2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:28:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5MCSZQa066886
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Jun 2018 05:28:35 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5MCSZcX066883;
        Fri, 22 Jun 2018 05:28:35 -0700
Date:   Fri, 22 Jun 2018 05:28:35 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for John Garry <tipbot@zytor.com>
Message-ID: <tip-bed9df97b39e73a4607189f2c4b9fb89cc3f7f59@git.kernel.org>
Cc:     tglx@linutronix.de, julien.thierry@arm.com, marc.zyngier@arm.com,
        john.garry@huawei.com, mingo@kernel.org, hpa@zytor.com,
        andrew@lunn.ch, trivial@kernel.org, linux-kernel@vger.kernel.org,
        kstewart@linuxfoundation.org, will.deacon@arm.com
Reply-To: tglx@linutronix.de, julien.thierry@arm.com, marc.zyngier@arm.com,
          john.garry@huawei.com, mingo@kernel.org, hpa@zytor.com,
          andrew@lunn.ch, trivial@kernel.org, linux-kernel@vger.kernel.org,
          kstewart@linuxfoundation.org, will.deacon@arm.com
In-Reply-To: <1529667333-92959-1-git-send-email-john.garry@huawei.com>
References: <1529667333-92959-1-git-send-email-john.garry@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] irqdesc: Delete irq_desc_get_msi_desc()
Git-Commit-ID: bed9df97b39e73a4607189f2c4b9fb89cc3f7f59
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  bed9df97b39e73a4607189f2c4b9fb89cc3f7f59
Gitweb:     https://git.kernel.org/tip/bed9df97b39e73a4607189f2c4b9fb89cc3f7f59
Author:     John Garry <john.garry@huawei.com>
AuthorDate: Fri, 22 Jun 2018 19:35:33 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Jun 2018 14:22:02 +0200

irqdesc: Delete irq_desc_get_msi_desc()

Function irq_desc_get_msi_desc() is not referenced in the kernel (and does
not seem to have been referenced since e39758e0ea76, 3 years ago), so
delete it.

Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <marc.zyngier@arm.com>
Cc: <will.deacon@arm.com>
Cc: <kstewart@linuxfoundation.org>
Cc: <julien.thierry@arm.com>
Cc: <andrew@lunn.ch>
Cc: <trivial@kernel.org>
Link: https://lkml.kernel.org/r/1529667333-92959-1-git-send-email-john.garry@huawei.com


---
 include/linux/irqdesc.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 25b33b664537..dd1e40ddac7d 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -145,11 +145,6 @@ static inline void *irq_desc_get_handler_data(struct irq_desc *desc)
 	return desc->irq_common_data.handler_data;
 }
 
-static inline struct msi_desc *irq_desc_get_msi_desc(struct irq_desc *desc)
-{
-	return desc->irq_common_data.msi_desc;
-}
-
 /*
  * Architectures call this to let the generic IRQ layer
  * handle an interrupt.
