Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239A3C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD39120868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVg1RZDu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD39120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbeLFP0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:26:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39644 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeLFP0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:26:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id f81so1446680wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 07:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UMyQ0l8+47IG6BmvT/+HBiVzvTDCovW0W1P3gCfHncc=;
        b=hVg1RZDurGz7XeOvzS137o1lccXwXH7Q8+VSheaXlUkJT1DFHTAq9KOI+HM5yZ5V21
         EJfX0EN3j7Hf+Q7vOBbOmBZCWd9/oL4jl5tGPbuymSFUK2OTchG0umHOC8/jPgXzk0t6
         BmP5RQiIfFf8qxxr8hJmE/x3KfWnEw4m9f7CPb40UTeFRzGsjLQK5DEw+uMnla1P5jut
         5SGXqVIEl9JajuNKqoIkdB9K7kF1GPIgokIrrDbkcFkB2AZ92COLNAgFr9JyDuJtu7Zy
         IALaiQKedPwuG89HuJUn5zULHxn3vlFW4nfZrxaNi+fyp+at7P1S3BSM7TRvretBsEFW
         bDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UMyQ0l8+47IG6BmvT/+HBiVzvTDCovW0W1P3gCfHncc=;
        b=KQ6612bFCTGX3uSwBEKnKoM/E2cZcJYMBOcmTrBNf08vzOJKW6uIbbs84mcU6UkuPH
         RwMe56rSTtAG6J61UFBFE3RyEYSD5JWeQBN+3RUQ+a96atR6eTtL3m6nJqORkFef9jed
         x/ELDKr+0+OiEoXC8HFqKnma7X5IMP4EOvjuhZBINF/ew4h8r58u7xHazAioMChKS99J
         GcF9rPE5N5kuDsGxXv6mstbw7RuXxGFGtT8cXb/wwaDufkSNi2Hunv0s4OGaNfaH3x16
         aRkLJYMCLMdyRLnehJO4eL1T9xh+fy0kTldxImcYNGviAiBQjF30eZLa3xBD5eyJY27B
         lyiQ==
X-Gm-Message-State: AA+aEWaqETAdm17HYC1uS14syzbJYYLnEztxqLSX4gjHvNYSYnN6VDSJ
        g7L3+ndTFohxSQutCJKMaVg=
X-Google-Smtp-Source: AFSGD/W9W6wYjJuqQqRRih6JBEIdEae18Xjv/h0/qgKCz1CNQwzm2KLnHJYOhjElTRzGJFQTEtp0IA==
X-Received: by 2002:a1c:3a8d:: with SMTP id h135-v6mr19942350wma.92.1544110006437;
        Thu, 06 Dec 2018 07:26:46 -0800 (PST)
Received: from localhost.localdomain (ip-76.net-89-3-178.rev.numericable.fr. [89.3.178.76])
        by smtp.gmail.com with ESMTPSA id w6sm529728wme.46.2018.12.06.07.26.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 07:26:45 -0800 (PST)
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Subject: [PATCH 1/2] riscv: fix trace_sys_exit hook
Date:   Thu,  6 Dec 2018 16:26:34 +0100
Message-Id: <20181206152635.1869-2-david.abdurachmanov@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206152635.1869-1-david.abdurachmanov@gmail.com>
References: <20181206152635.1869-1-david.abdurachmanov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix compilation error.

Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
---
 arch/riscv/kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index c1b51539c3e2..2fd9ec48106b 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -177,6 +177,6 @@ void do_syscall_trace_exit(struct pt_regs *regs)
 
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
-		trace_sys_exit(regs, regs->regs[0]);
+		trace_sys_exit(regs, regs_return_value(regs));
 #endif
 }
-- 
2.19.2

