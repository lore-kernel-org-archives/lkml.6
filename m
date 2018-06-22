Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBA8C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2591C249C1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XXhM3BxL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2591C249C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754750AbeFVXVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 19:21:18 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33366 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933953AbeFVXVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 19:21:15 -0400
Received: by mail-pl0-f66.google.com with SMTP id 6-v6so4147807plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 16:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=r+Zfqatxq2UKXyREXnElCHhZrB60pZTvi6QO8NUS/TM=;
        b=XXhM3BxLecWeu3OYt6JbIbQq05x7EZaZ824dgrlZnTV0RMxT9HxKh32NCQP9cAOZRZ
         8wZpKJMKeKHSlDId8/OPMpxkRZ9Mgm4JucJlJFBovcFYjhpDxCdrFeWekbICoKtJVyuz
         /CJcumAcjc1/P5utPs6+FU/HCZ9OWfJ9YI+Bsx1q3OEd2ks5KumnsSGUT1FcJoDuwBN2
         9eVe5hOpiHgfcROTLR+ZgWY3YMFEKrc5KUJzWlMgv2jWGt67y8w3kuF2MOhRrHTtG173
         GduTcI+nqcZ5qaqJOVigCJMvbAHW92jYRnvtySf96Ob8zshqXoI/DnIN1b40trb1nOn9
         I/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=r+Zfqatxq2UKXyREXnElCHhZrB60pZTvi6QO8NUS/TM=;
        b=DTxa0Kc9ad7x1dnI0VPnYhiMkFF/BJIy08k5DnFO83xx00nhuYRc/tUyzk6j/UgCLl
         o4jVzt7I3SHDRL/sb6o1+S6ncSgslhYHJbimckPXQ/omazyy9B+88kYTYBcmGuBrDSIK
         3UMp9WPyNcY82YVhgXWifDbNaxerbMSF3W1sepsnCJypRr168zeEjPWknFkF7MHl7pln
         zzhO2cpfSNhVGx43vuK38oCh5XXxdf8UnOgPpdhT4FM/jdqAOnJWofQIXMe2qvBWIic9
         dV5yuSMVXQQynSsgwRorIwxB+n1faD6m4fcpOn4+wdpgd3/yRbCSqQWeVo2A8GUTHbnp
         FuPg==
X-Gm-Message-State: APt69E0Ps9aWNuieVxtY6MofhNKT1ylJjYBPEmyoDMlgOE1tle32syo1
        MUUO7nvGL95SvZSa0Y/ypaowTw==
X-Google-Smtp-Source: ADUXVKLQO/7rQfcC4I99l1jBjxR+xPSWupkKmtDqFvjeg6ridNZGdaJFfWXJxcokhxTpBshKsujFuQ==
X-Received: by 2002:a17:902:bf43:: with SMTP id u3-v6mr3473101pls.322.1529709674941;
        Fri, 22 Jun 2018 16:21:14 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id m22-v6sm20155372pfg.61.2018.06.22.16.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 16:21:14 -0700 (PDT)
Subject: [PATCH 1/3] RISC-V: Don't include irq-riscv-intc.h
Date:   Fri, 22 Jun 2018 16:20:04 -0700
Message-Id: <20180622232006.12158-2-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180622232006.12158-1-palmer@sifive.com>
References: <20180622232006.12158-1-palmer@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        shorne@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file has never existed in the upstream kernel, but it's guarded by
an #ifdef that's also never existed in the upstream kernel.  As a part
of our interrupt controller refactoring this header is no longer
necessary, but this reference managed to sneak in anyway.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/riscv/kernel/irq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index b74cbfbce2d0..7bcdaed15703 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -16,10 +16,6 @@
 #include <linux/irqchip.h>
 #include <linux/irqdomain.h>
 
-#ifdef CONFIG_RISCV_INTC
-#include <linux/irqchip/irq-riscv-intc.h>
-#endif
-
 void __init init_IRQ(void)
 {
 	irqchip_init();
-- 
2.16.4

