Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9032C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FA1217AA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ha1f8eBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FA1217AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbeHCVXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 17:23:11 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34310 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729322AbeHCVXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 17:23:11 -0400
Received: by mail-wm0-f66.google.com with SMTP id l2-v6so5775322wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 12:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=2nzbf5uLbLail8qbQo9csGf0aO862k37I7eMMZwsvhQ=;
        b=ha1f8eBO9u2ZeKOOtmWQ5sstnWVzq8mCvRr7OFbVoNxaruwEEhDUUvL5Ed15f1LdcJ
         EOFjLCuGhZ6n/34PIlNjKGigwf/lnW3XLm/9TUAwyaPnoM29bVlN2LELeA12w6UY4URR
         TG/DyfFZXsCJUJu0thUhcTk/agFz/+vgd+hNYpM70KBF7eE7nPU4HswMK2BnBC1Fgfzx
         Qd9Yu4TlYwBSNNn5ehKdbn+lrtyZIarZESRtHhdVad1fS9vqS6NUUQb4bx8Jql1UqcQ0
         9i3xhnhZjZiPkh4R/nX+v5t8QPnhDPbi5iPtnd7Z1OhrvhFe2XJdkKlvGGDed7Pb6HDH
         ibKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=2nzbf5uLbLail8qbQo9csGf0aO862k37I7eMMZwsvhQ=;
        b=tOaHFG03tDIaLyBjHplXNiGn0jHMawQZGiIS6VaP2uT8QUFOmyF8R0pJHR39WNhXtr
         9If9c5Pyn0afnws7DKyeIkaoGegcMOukicCTmLrT8ZrsVVmkJhJ1e5aM1/HMO7Teqo0F
         NKLCgqhBA6lBBdpaYpK4SRfVuhjkgikyUD/0lrKVdi0lQLJ0vCPNjiqOzmtd/m0QMxwN
         36roiCoJzzhccYfFpp1Biy75cE3+J1qWFiYdd8vTdOA1UF2zFxQIqdtWWqRQ4obvtV4G
         zVmKs3tOrvitT+S3aaWxqKE5+qz6JkAwQ8/aKtHKAOQGiSQ0TT8jORJ49YRoghRsX3oc
         5m+Q==
X-Gm-Message-State: AOUpUlGSpjGnrA1lZnA8dvONB4k0aE1dRyKNUnTOzzTv0ziyr5cqd4Ln
        3JIa8kCIx3suqltnfEienbc=
X-Google-Smtp-Source: AAOMgpdw7HvawBSEqrro0BPPbK8urjD7GL320FiBpYwhw+a62A8tO6UOSw6YY0hmuBODiEicAFDg8w==
X-Received: by 2002:a1c:f703:: with SMTP id v3-v6mr5620358wmh.48.1533324332633;
        Fri, 03 Aug 2018 12:25:32 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:d600:9545:19fe:eae2:90aa? (p200300EA8BD4D600954519FEEAE290AA.dip0.t-ipconnect.de. [2003:ea:8bd4:d600:9545:19fe:eae2:90aa])
        by smtp.googlemail.com with ESMTPSA id t186-v6sm296590wmf.14.2018.08.03.12.25.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 12:25:31 -0700 (PDT)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: genirq: Consider domain hierarchy when checking for
 IRQCHIP_ONESHOT_SAFE
Message-ID: <7673cadf-b9dd-bd99-787f-bcab4d71422d@gmail.com>
Date:   Fri, 3 Aug 2018 21:12:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of a domain hierarchy we may miss the IRQCHIP_ONESHOT_SAFE
flag because we look at top of the stack only. See also discussion
here: https://marc.info/?l=linux-kernel&m=153301773524685&w=2

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 kernel/irq/manage.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index a66c58f9..1a28f068 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1156,6 +1156,16 @@ setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
 	return 0;
 }
 
+static bool irq_data_oneshot_safe(struct irq_data *data)
+{
+#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
+	/* check topmost irq_chip only */
+	while (data->parent_data)
+		data = data->parent_data;
+#endif
+	return !!(data->chip->flags & IRQCHIP_ONESHOT_SAFE);
+}
+
 /*
  * Internal function to register an irqaction - typically used to
  * allocate special interrupts that are part of the architecture.
@@ -1243,7 +1253,7 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	 * chip flags, so we can avoid the unmask dance at the end of
 	 * the threaded handler for those.
 	 */
-	if (desc->irq_data.chip->flags & IRQCHIP_ONESHOT_SAFE)
+	if (irq_data_oneshot_safe(&desc->irq_data))
 		new->flags &= ~IRQF_ONESHOT;
 
 	/*
-- 
2.18.0

