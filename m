Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188BEC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B451721767
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oaI4opN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B451721767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbeHILXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:23:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34032 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbeHILXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:23:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id c13-v6so4477021wrt.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 01:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=F7KHAUGCcRku+LbHtcagWA+vrgOv2XDa19iGg6969S8=;
        b=oaI4opN9upeJCU/58x3Ksgl5A2I3sw6YNleoHpt2tl+JuoK3nswJW6zwccE/6bwipm
         Nz9StJceVWLxs1GmVV3PMKXuRLWGRX8Qgld/uXTjaFMWM27ejoURQbSbXUKqfpZc45zc
         tUZEWZzdJy94fQTJGu4TO4F22n9wFmyNP9d+zx3rgIdMtPRayOKhWmVo2DTZORJgpwj/
         mhzQle7MGwBPsQK7DCGSbXC9+LcO48S0onMmzh+Pe22qASg1s1T4Eqv3xacwBSj9dZUr
         mYBEXljzLF1wppn8MctD8fexcRNOgWwztKH73iaJNwyT5wrs80YvYhMj3wTOGn2pCryw
         IsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F7KHAUGCcRku+LbHtcagWA+vrgOv2XDa19iGg6969S8=;
        b=g2b6kg/cpEy/kGxnPe1bpASnI/tU6vn+CkR/8OxGeNdLYEkzI6usjZwF2v46k8xJeW
         TZVXXuWUQ+JCKpQJmsmtJZ1J4NGEEYyN+6MjPcymD6AxCwGdwsctr0qoPwzdOu4/T3hy
         wdHOcj1laZOGFB4UmOhVoy3LvYTxZodPLQdCrr7Z9bGRvTDip+6rQxNr1Hdqs9SiHO8E
         Y6LTveKrybENZDkdP4QmwarJeKET+zO55YzBTv3ggrpkLFLQ8vE99Jq8rZH0jGuTG8u6
         3ddXO6GWJ+svpNVkiB6/Y66wPzDMPW4ygi1EyfpbMAs+8cAv5He2fR/tvMJCOaEi55Qh
         lCqw==
X-Gm-Message-State: AOUpUlH2tQFborWVj2py8FH+IyH816FxP+qWEaGeY0Y5qJRy8pVf0omR
        0C+ET1yAUoqXu/cgrPnp7VMdINxd
X-Google-Smtp-Source: AA+uWPy6tZUAHO9qho/G9ya7Zrzi9ECrrrHGUq2LmMakQD+6WIx54GFG5SEOOj0ZTRa9g+bfA1WRGQ==
X-Received: by 2002:adf:b309:: with SMTP id j9-v6mr800998wrd.207.1533805162758;
        Thu, 09 Aug 2018 01:59:22 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::64])
        by smtp.gmail.com with ESMTPSA id a6-v6sm11219702wmf.22.2018.08.09.01.59.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 01:59:21 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] irqchip/bcm7038-l1: hide cpu offline callback when building for !SMP
Date:   Thu,  9 Aug 2018 10:59:01 +0200
Message-Id: <20180809085901.26568-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling bmips with SMP disabled, the build fails with:

drivers/irqchip/irq-bcm7038-l1.o: In function `bcm7038_l1_cpu_offline':
drivers/irqchip/irq-bcm7038-l1.c:242: undefined reference to `irq_set_affinity_locked'
make[5]: *** [vmlinux] Error 1

Fix this by adding and setting bcm7038_l1_cpu_offline only when actually
compiling for SMP. It wouldn't have been used anyway, as it requires
CPU_HOTPLUG, which in turn requires SMP.

Fixes: 34c535793bcb ("irqchip/bcm7038-l1: Implement irq_cpu_offline() callback")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/irqchip/irq-bcm7038-l1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index faf734ff4cf3..0f6e30e9009d 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -217,6 +217,7 @@ static int bcm7038_l1_set_affinity(struct irq_data *d,
 	return 0;
 }
 
+#ifdef CONFIG_SMP
 static void bcm7038_l1_cpu_offline(struct irq_data *d)
 {
 	struct cpumask *mask = irq_data_get_affinity_mask(d);
@@ -241,6 +242,7 @@ static void bcm7038_l1_cpu_offline(struct irq_data *d)
 	}
 	irq_set_affinity_locked(d, &new_affinity, false);
 }
+#endif
 
 static int __init bcm7038_l1_init_one(struct device_node *dn,
 				      unsigned int idx,
@@ -293,7 +295,9 @@ static struct irq_chip bcm7038_l1_irq_chip = {
 	.irq_mask		= bcm7038_l1_mask,
 	.irq_unmask		= bcm7038_l1_unmask,
 	.irq_set_affinity	= bcm7038_l1_set_affinity,
+#ifdef CONFIG_SMP
 	.irq_cpu_offline	= bcm7038_l1_cpu_offline,
+#endif
 };
 
 static int bcm7038_l1_map(struct irq_domain *d, unsigned int virq,
-- 
2.13.2

