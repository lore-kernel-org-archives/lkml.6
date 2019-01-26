Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18293C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5C521903
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="XU9M3dUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfAZPlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 10:41:21 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25420 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfAZPlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 10:41:20 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548517228; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=IMmfPZQvmuKTOrkZDdvb/HcmOwQ0EsigLD2NqEENUFltcqZ7z6LQQuGbOfAAPakdMcMtX4yQkemF906jQY8t7Mp74s1XvXc+SB45bKz6KFjTJcNWzeXP9fPTxG1SU6sXUwm2S8BMrmjVP8Iqoj3NN04bv2VG6MGWQiSYxE53s8I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548517228; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=CIR4N9NKNS2/If32h/96P6I9JiAh8bR768I9OBpTwkA=; 
        b=dc6B/6wMwEqM/B4cx4eg/2lHeePAIdmS15v9QW6HNa0/D+wq1Phm3wpEYpVsgY06lJz6d2tIVAxThgHX1cl07irYswov5HOA0dYDTe1OrN7x67A9TuDRmJjOxn7GzWP+iXyZwJrxQAYWYKxx3pQG8LbeC2qjTqY8P4EzoPv8/Vo=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=DQ/y0ZHlMegD9tlpozkvglxMRvN9MbPYmnUz4w1gQO8FnUQchH36lN26wnenCQW75EcamjMV9Dpn
    DNz+1CcEDZJ+TAZZtsF6Eb6TMQ9he5fRNCjF9voz0uDImmkaa1tY  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548517228;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=1406; bh=CIR4N9NKNS2/If32h/96P6I9JiAh8bR768I9OBpTwkA=;
        b=XU9M3dUAD/1zNxqrVup8csyy6pwmLb+dG7QmqpXum8tPekmW+wj7mCJRlhmXQqlY
        2s2l0O5pztcT6aYHL6Y2x/RxuLzPJ9eannv4SiU/cS0YyBw8ri5sxPW/6COVJlvOrjV
        /6DOrj7vSxnW3rGlNDmg5F/uTITzWnlUaFuUpwl4=
Received: from localhost.localdomain (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548517227851231.18598983505547; Sat, 26 Jan 2019 07:40:27 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, mark.rutland@arm.com,
        marc.zyngier@arm.com, jason@lakedaemon.net, tglx@linutronix.de,
        syq@debian.org, jiaxun.yang@flygoat.com, 772753199@qq.com
Subject: [PATCH 2/4] Irqchip: Ingenic: Unify the function name prefix to "ingenic_intc_".
Date:   Sat, 26 Jan 2019 23:38:41 +0800
Message-Id: <1548517123-60058-3-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548517123-60058-1-git-send-email-zhouyanjie@zoho.com>
References: <1548517123-60058-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the sake of uniform style, function "intc_irq_set_mask" is
changed to "ingenic_intc_intc_irq_set_mask".

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---
 drivers/irqchip/irq-ingenic.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index 2713ec4..69be219 100644
--- a/drivers/irqchip/irq-ingenic.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -64,7 +64,8 @@ static void ingenic_chained_handle_irq(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static void intc_irq_set_mask(struct irq_chip_generic *gc, uint32_t mask)
+static void ingenic_intc_irq_set_mask(struct irq_chip_generic *gc,
+						uint32_t mask)
 {
 	struct irq_chip_regs *regs = &gc->chip_types->regs;
 
@@ -75,13 +76,13 @@ static void intc_irq_set_mask(struct irq_chip_generic *gc, uint32_t mask)
 void ingenic_intc_irq_suspend(struct irq_data *data)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
-	intc_irq_set_mask(gc, gc->wake_active);
+	ingenic_intc_irq_set_mask(gc, gc->wake_active);
 }
 
 void ingenic_intc_irq_resume(struct irq_data *data)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
-	intc_irq_set_mask(gc, gc->mask_cache);
+	ingenic_intc_irq_set_mask(gc, gc->mask_cache);
 }
 
 static int __init ingenic_intc_of_init(struct device_node *node,
-- 
2.7.4


