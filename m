Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4419C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A56420823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N83Hw7rW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A56420823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeJ3SyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:54:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38178 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbeJ3SyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:54:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id d10-v6so11848929wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 03:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PyDDzwHXyMj+C+OLQdTaYPyj7+co5RvLTagufcNFpVY=;
        b=N83Hw7rWQmTs1BhwxhbXr3l2e0O97q0i49fFu6bwUEBWMsvK5BHua7294+uuQC9Cd1
         94Ypjctq67FCZxGcXeRJIHREgj0SRIBKvOMz9DvQXVnfkSe9DfZwiEKtuct8TTbMrO1f
         BI6gKApdDTIF5xzmW2uGgD0O7YsLOC8OvQrfRGgrOCRXw4WpqdDQhFbEokntiQ1v7Yml
         xeTIwcgPcyrsa0OMEJf3wQ7u3yr8ToUmQgkIxjoemvlIBtIFJON7f3iTxvnEArjCfP1U
         bwbSCkS7EMkm79FbIT4Ru68Y1rRGyHqXqaCQt/gxAKupB+dPZ57TuaNzgAMGmZIg/qxP
         O7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PyDDzwHXyMj+C+OLQdTaYPyj7+co5RvLTagufcNFpVY=;
        b=U/WdnnEKaMV9TBcCEZSlELqShiiHCnG/VOu0i/76dF1tgjS2TMM66xXHh0qMbW3TBb
         OVHP8oaLanOmSwYWp6kYxtwF1YzFeZyQlm4l97zzA4DlqP8xtXPewgx6psnjtOW86ULM
         3xB+l+6rCJ4G8yrjFF0tjjbGQtGozWdhtVMqAB6PgVgWzj7OPuSGAWQ247zIRD+4UpZB
         QbohQ3i+3wYYrN4DXkhUcA44hYdoRSEKAQb9VvhifTQmw/k7A8YFfuP0eN/mlI2XXqJA
         eo12OUAQGcTGmroh7oSufwE8hrMU+kbjY2XBB7bSPb/IcX4rhmQQnFN3OodjaTC7HSZd
         tH3w==
X-Gm-Message-State: AGRZ1gI+4qQu0GPlzLogErtqhA7uqeYyySY3h79IrtRKnoclBtzEhThE
        z8ly245vEcIhFm91IBAq34Q=
X-Google-Smtp-Source: AJdET5eDJ3Vv7Wh6CqIymLAytfrTnCbc1rS8td6DgwmOlj9RLRjpFqRLTEuJo9YmmyMYtmpzUwd7mg==
X-Received: by 2002:adf:fcc1:: with SMTP id f1-v6mr17961330wrs.172.1540893679373;
        Tue, 30 Oct 2018 03:01:19 -0700 (PDT)
Received: from localhost.localdomain (ip-76.net-89-3-178.rev.numericable.fr. [89.3.178.76])
        by smtp.gmail.com with ESMTPSA id f1-v6sm18420825wme.23.2018.10.30.03.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 03:01:18 -0700 (PDT)
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu, green.hu@gmail.com,
        deanbo422@gmail.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Subject: [PATCH 1/2] riscv: add ARCH_HAS_SG_CHAIN
Date:   Tue, 30 Oct 2018 11:01:06 +0100
Message-Id: <20181030100107.4590-2-david.abdurachmanov@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181030100107.4590-1-david.abdurachmanov@gmail.com>
References: <20181030100107.4590-1-david.abdurachmanov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to be needed for virtio-gpu.

Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
Reported-by: Michael Forney <mforney@mforney.org>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a344980287a5..b54f2ade769b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -44,6 +44,7 @@ config RISCV
 	select RISCV_TIMER
 	select GENERIC_IRQ_MULTI_HANDLER
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_SG_CHAIN
 
 config MMU
 	def_bool y
-- 
2.17.2

