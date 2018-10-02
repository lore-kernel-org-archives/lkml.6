Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6191BC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27AEB20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEu6NqWy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27AEB20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeJBQ0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:26:31 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43163 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbeJBQ0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:26:30 -0400
Received: by mail-lf1-f65.google.com with SMTP id p34-v6so917030lfg.10;
        Tue, 02 Oct 2018 02:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z+hdxFOSe32oMBUjUZfltaG93mOopNPMP9Hnk0qjLPI=;
        b=EEu6NqWyOT6HKwzp1+ad/5E7tTIbAs11gTtQ0nZaSsr1o1pmTKqSySJn1510U9QVeM
         ObKmxzZ7LEstIW2+lwiv+2Dc3l+kN8+VkwRkXQj1z36Tz8MjLJHrQnLUYpDXG1rMY9ah
         ms4iV1Z1E0JTQHT4XFZeQPfwzn1pTv1rHxoDUzq202QDmEAEJJDpbetv2bNwd3v1O/n/
         3jtG+XMUarXbbP6WcAqB8wfWISsgRd0vzUKvIqadbWe/fRXfVLDLaM5BiPe2amYpRmPK
         9V5iS8v9pBYcNZqsb+h9gR3cJvuCbRO+NYbC/cvg+CphVIiZynW+XgReHoeIfH6m6sZo
         /XbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z+hdxFOSe32oMBUjUZfltaG93mOopNPMP9Hnk0qjLPI=;
        b=Ymqpoqd4DDTbKCEoOakuH7h/jsH1e3xUbzgDCSVyIQuYhrOdqilkvGGLBe5eNDqtj5
         pkeYFT5WbhYvQFBteNpnhTDk9uKizKyEeEKTyfiyFHLVF6wYnHrN6WnviKs6tn3MgeR+
         N++xZp93g3wCKqIQh5oqbKx5cE2vdhSlmsTbeDx9h7Sqi6y4hUed8t+L46H8qAk1e9uI
         7mIo0iaYsqFgPzSsKdF1A5VeBH4Rt7pJs7x7ss/RqB2iBCr/fly+5WLlRHNprnZ0mWah
         mK8p7942ljO/r+r7vQ2gBAfeK8WVqN3iO4ZYdhYu4MGsXwCDIyFSYVDH6QpW1ADavlIO
         SV3w==
X-Gm-Message-State: ABuFfoh2ElooTfceLoZcptuIWlFydOYtseyqF2WJudoPWjh9JjNgqD5O
        bLa+egulxXmfWn5jlsatSIQ=
X-Google-Smtp-Source: ACcGV609RoIYSvKGmguJsAkxX2XfrpiW8yQY+ISk6FjHNCWyj09WJf4dzuNcPHfLMcC2Ni1g8CSVrw==
X-Received: by 2002:a19:518a:: with SMTP id g10-v6mr8300461lfl.63.1538473445730;
        Tue, 02 Oct 2018 02:44:05 -0700 (PDT)
Received: from z50.intranet (78-10-164-223.static.ip.netia.com.pl. [78.10.164.223])
        by smtp.gmail.com with ESMTPSA id s140-v6sm3111029lfs.91.2018.10.02.02.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 02:44:04 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-arm-kernel@lists.infradead.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH] ARM: OMAP1: ams-delta: Fix impossible .irq < 0
Date:   Tue,  2 Oct 2018 11:45:29 +0200
Message-Id: <20181002094529.30564-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181001102453.GA18947@mwanda>
References: <20181001102453.GA18947@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the very beginning, unsigned int .irq member of struct
plat_serial8250_port introduced by commit eff443df679e ("OMAP1:
AMS_DELTA: add modem support") was statically initialized to a negative
value -EINVAL.  Moreover, commit 0812db943748 ("ARM: OMAP1: ams-delta:
assign MODEM IRQ from GPIO descriptor") has introduced some new code
which checks for that member carrying a negative value which is
impossible.

Use IRQ_NOTCONNECTED instead of -EINVAL. Also, drop the valueless check
and let the modem device be registered regardless of .irq value, and
the value handled by "serial8250" driver.

Fixes: 0812db943748 ("ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO descriptor")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index af318d958fd2..3d191fd52910 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -773,7 +773,7 @@ static struct plat_serial8250_port ams_delta_modem_ports[] = {
 	{
 		.membase	= IOMEM(MODEM_VIRT),
 		.mapbase	= MODEM_PHYS,
-		.irq		= -EINVAL, /* changed later */
+		.irq		= IRQ_NOTCONNECTED, /* changed later */
 		.flags		= UPF_BOOT_AUTOCONF,
 		.irqflags	= IRQF_TRIGGER_RISING,
 		.iotype		= UPIO_MEM,
@@ -864,8 +864,7 @@ static int __init modem_nreset_init(void)
 
 
 /*
- * This function expects MODEM IRQ number already assigned to the port
- * and fails if it's not.
+ * This function expects MODEM IRQ number already assigned to the port.
  * The MODEM device requires its RESET# pin kept high during probe.
  * That requirement can be fulfilled in several ways:
  * - with a descriptor of already functional modem_nreset regulator
@@ -888,9 +887,6 @@ static int __init ams_delta_modem_init(void)
 	if (!machine_is_ams_delta())
 		return -ENODEV;
 
-	if (ams_delta_modem_ports[0].irq < 0)
-		return ams_delta_modem_ports[0].irq;
-
 	omap_cfg_reg(M14_1510_GPIO2);
 
 	/* Initialize the modem_nreset regulator consumer before use */
-- 
2.16.4

