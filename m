Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAC4C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671C220818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="mLvKm8fa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfBLKjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:39:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55569 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729101AbfBLKjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:39:33 -0500
Received: by mail-wm1-f68.google.com with SMTP id r17so2326108wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hwmA55py1DDIb9fQ+5X5dpksNWX0bjdVZC1l1Y9UfNg=;
        b=mLvKm8faBmaSZPHhItRIrOvDCDbvaF74ATZ9/dNkb0nIZKKBbdor5rGls7iviDTPQf
         9nf/8vXwNbd6qj1fLcOyn01tHibzGG6oelnOQ5JAuEbLnHVcFrDWQ5JBiZevuiAj5QxS
         6cVh3EtDraj+vfcOQtkK9FRYQooStyuElkq9Pwfd0t3LPOXFe4CgdulB7xwYPUkYzsVr
         boZd4X1emt2mfICY/z+e/cFlSt4BzNRZ+j7/4lCLilOUfNUGSGEt723bUUzDtDYQ98M0
         Tow2dQDvp+5DsjM8EbCMeOptuDhhPwmUimYeBGGxLYXvNjFV5uh5Q1Hm2g61mzfAVA0p
         a7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hwmA55py1DDIb9fQ+5X5dpksNWX0bjdVZC1l1Y9UfNg=;
        b=URw2NsAY/ozx/Cih3kAC9t9nkupFeRC+p8M8Bddb5qjy6CZ/30y1+8x4JIslKXyOtX
         nLBHI0T0H1qIvS/GezYSpGeVPgzSWObMfIaNuEajzDTEIQGph1mK/kIrxWWKbC4oq6VY
         1XoHnYsT7m6iI0py5aMVItQ1OxLLO28D5mB5SWCJvbLecVa7+yX81cJq/jqF23zummVa
         Ps8yXx1xG9Mzv3G8F6Sw6G1tbKeaSb9PTvAI80tCEq5sNHDZyvI96LSkEt3YaBLmhQ/d
         sVvu516hdmMvFiFQHojr3/p0VMCGWImMjf9JGKh4MML52cEZshcCOvX6BMC2IxBhofuN
         fghw==
X-Gm-Message-State: AHQUAuYrF4aX8nRUJkk5ko45lBPpIzA7QCa1YznflGgYLnmCrtcwyN+d
        Y8KN3XXQld8p4jFeMP7JfqiFkw==
X-Google-Smtp-Source: AHgI3Ibx+3G3YCOQ/z6DfdWlABUsf04RZB2zekk9W4VeB74BGyH7ukL7QCGXdthZbAf/BelDZCV3FQ==
X-Received: by 2002:a1c:7710:: with SMTP id t16mr2232819wmi.81.1549967971406;
        Tue, 12 Feb 2019 02:39:31 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:39:30 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 30/37] ARM: davinci: cp-intc: request the memory region before remapping it
Date:   Tue, 12 Feb 2019 11:38:28 +0100
Message-Id: <20190212103835.7768-31-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a missing call to request_mem_region() before calling ioremap() to
make sure it's not been requested by another user.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index f56a4275083f..6ab56af3be6b 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -164,6 +164,15 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 {
 	unsigned int num_regs = BITS_TO_LONGS(config->num_irqs);
 	int offset, irq_base;
+	void __iomem *req;
+
+	req = request_mem_region(config->reg.start,
+				 resource_size(&config->reg),
+				 "davinci-cp-intc");
+	if (!req) {
+		pr_err("%s: register range busy\n", __func__);
+		return -EBUSY;
+	}
 
 	davinci_cp_intc_base = ioremap(config->reg.start,
 				       resource_size(&config->reg));
-- 
2.20.1

