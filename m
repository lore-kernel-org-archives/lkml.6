Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362BBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044822084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pxfeb/FI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbfBUQGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:06:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47044 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfBUQGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:06:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id i16so22975284wrs.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 08:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ix2Vfi3TxMNne3XI3bfEIFgST33qrzDbpsClRE/1Tfk=;
        b=Pxfeb/FIZSHE91Y0SiCLMcDKzAT3UtLmNzzArN1YUWuiCcxVTuqJoZ0CuqK0tR7jt9
         qJMUbgliTAQaOH4fu+EE5p3Uk4eNsFpUH0rCYk0RNA0LyJeqGyn3k1NykAN5zs+xnW1g
         5WHZXDhmuEO7rIHZz6Iw+5xQIn1FotJ51jMiGNxvf8O/SOocnI3fIymcjoEFs9RgsLAa
         w6C+ai6dlSmqGSxreHDLJNzizv6YVHDJGbDuM5VZASKPRFEcxW0ZtIlZGXTNrYzL+joh
         Tz4ShPToQFvZt+RU/GIHMNPvYtcCOGTnAErhhe4+zxYCmBftXb2IgqIw9TX58VZOaap4
         0Oyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ix2Vfi3TxMNne3XI3bfEIFgST33qrzDbpsClRE/1Tfk=;
        b=d7vPhkDfA0n4MGBtNsa0+qJ0mQzhUjRVGZA9cLVxqeMGTlyATCgQOxsJ9T852DhQBU
         J1ysW+XKdZe+wEc0NeCYbrRH129zTq3JGF4ajySIakBFpc6kCkr0P3jAmy3Kg6bO8HHZ
         kg4I0EX/9zIUyXmKV4RAb5fdwgTGRXLQV0KHJotnrB6EEY1dHaLDyvw+OJ5PocXHGAt3
         BecWgAsM+L9eZ3dRymYdw2geLTs8ZTZ3BE/a73x7ZDKxzAVROcDS+k4NqsH9aUjf/aJL
         ph59up+5zJmmonlSDRjp8Mjgva1MnPI25R8OvrdgD2VfJKuc2OgQGezRBdagY/5+8HQf
         GWRQ==
X-Gm-Message-State: AHQUAuZG88hmLMnVMlaACaa6g5E0/SdDdQ7rZTHiRoE2ouDeMd4NMoVm
        dscdAsdqN6KZeEgW/zrkZhEML6FO7BI=
X-Google-Smtp-Source: AHgI3Ibw/btakj3hWKfaULIcAyZqlPE4DBOGlYD9pe8TDFWVDPAhvSaIbL+t7etHqQ4GzL6ULJXYSA==
X-Received: by 2002:a5d:5681:: with SMTP id f1mr29071672wrv.95.1550765213574;
        Thu, 21 Feb 2019 08:06:53 -0800 (PST)
Received: from localhost.localdomain (85-169-74-166.rev.numericable.fr. [85.169.74.166])
        by smtp.gmail.com with ESMTPSA id c18sm28578384wre.32.2019.02.21.08.06.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 08:06:52 -0800 (PST)
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Subject: [PATCH][RESEND] Make ARM_TIMER_SP804 depend on (ARM || ARM64)
Date:   Thu, 21 Feb 2019 17:06:48 +0100
Message-Id: <20190221160648.29785-1-david.abdurachmanov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending to incl. a proper mailing list and maintainers (not suggested
by scripts/get_maintainer.pl)

This is only used on arm and arm64 platforms. Other timers also seem
to depend on (ARM || ARM64).

After I moved Fedora/RISCV kernel to 5.0.0-0.rc2 it keeps asking me to
add CONFIG_ARM_TIMER_SP804=n to my config. This patch resolved the issue.

Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
---
 drivers/clocksource/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a9e26f6a81a1..7593d80e1c88 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -369,7 +369,7 @@ config ARM_GLOBAL_TIMER
 
 config ARM_TIMER_SP804
 	bool "Support for Dual Timer SP804 module"
-	depends on GENERIC_SCHED_CLOCK && CLKDEV_LOOKUP
+	depends on (ARM || ARM64) && GENERIC_SCHED_CLOCK && CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select TIMER_OF if OF
 
-- 
2.20.1

