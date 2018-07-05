Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FB7C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74161240CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2/lB9nj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74161240CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753846AbeGEViS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:38:18 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33595 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753459AbeGEVg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:36:58 -0400
Received: by mail-pf0-f196.google.com with SMTP id b17-v6so6516145pfi.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 14:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J9WAwt4xEUZ917qiff/mV5JqlsXoe8ynmxaL/LwEFEM=;
        b=N2/lB9njwnNbpTdtqbso15XzJTk+wP30Iez2TNmoTZwiw2GXT72p+y99IDwX9CIcmU
         mmGdnC68b02vUsrAJqSJN71B/LbntJomwlL0uC1LMW6G8bks29ttgYUgm0snkpPyVh+t
         2uKb9YJMNPJDw4UmhmQoVn7G4cXKT2+Z8oIjqH+lZ4DR/A8bOINpbEJTXUe1CLNPuBPu
         sNrUNHJ2XU0+/6uItOfUFGcS3KT2gz5zbnRlO0lXv8OKire5OmRZ/jPwA7yblbXtbdro
         39HhAkL38qxCMvpn69BF5Ac7QIAPA43mkTYTxzqzk2EgpzBqc5r9ODMvLWApzzQYVeao
         wbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J9WAwt4xEUZ917qiff/mV5JqlsXoe8ynmxaL/LwEFEM=;
        b=jKqLbJS6xiZmJCypkq5Ym3aqCiy2IFD+2wCvORdygWlIqp6t4UtCqM2C1SqSrlom2s
         jtdNWDlMBTR9RcH/7bTcbpRRKViQLp94vXtJqidpSkRIC0ntt2StSPjH6buU96ZmGDN8
         GSftOBvHE360D/E55ie+UW51LxYoR/RXdrzr4TFH3M7Zhx0xS7+96jEK8Udpso2cW4lY
         hXpXlDa0OQIFlZ4VKb9QWmhOTfj8GXZykcmGaS7VdyIvSnM2jP1YZ43hqfiJVkBY2K4Y
         /JeX4Jpm7avCfpOoy+SK2AGYA0Pq57RmOZmoOhY2KjBw0gqGlL9cfNodvPA1ZPmzSadS
         thnQ==
X-Gm-Message-State: APt69E2VD0VF+WyZejA0XWkoJJ1XgjkWDFmAknugoVIy/ZtrNupuEBA+
        n0Q2uBfft2xctUlpkH8wdMQ=
X-Google-Smtp-Source: AAOMgpeJ2Bbv892RnPBA6jncIh3kjjIhaiiZbx2F/21P1YmWVUbzk7pR293ER2Vr9ByYIpDrEO4Fdg==
X-Received: by 2002:a65:43cb:: with SMTP id n11-v6mr7010758pgp.234.1530826617576;
        Thu, 05 Jul 2018 14:36:57 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id v89-v6sm20438290pfd.64.2018.07.05.14.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 14:36:57 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org, palmer@sifive.com,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 3/7] riscv: Include asm-generic/compat.h
Date:   Thu,  5 Jul 2018 14:36:00 -0700
Message-Id: <20180705213604.18883-4-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180705213604.18883-1-deepa.kernel@gmail.com>
References: <20180705213604.18883-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

riscv does not enable CONFIG_COMPAT in default configurations:
defconfig, allmodconfig and nomodconfig.
And hence does not inlude definitions for compat data types.

Now that time syscalls are being reused in non CONFIG_COMPAT
modes, include asm-generic definitions for riscv.

Alternative would be to make compat_time.h to be conditional on
CONFIG_COMPAT_32BIT_TIME. But, since riscv is already has an
asm/compat.h include the generic version instead.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: palmer@sifive.com
Cc: linux-riscv@lists.infradead.org
---
 arch/riscv/include/asm/compat.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/include/asm/compat.h b/arch/riscv/include/asm/compat.h
index 044aecff8854..e78c5054e178 100644
--- a/arch/riscv/include/asm/compat.h
+++ b/arch/riscv/include/asm/compat.h
@@ -15,6 +15,9 @@
  */
 #ifndef __ASM_COMPAT_H
 #define __ASM_COMPAT_H
+
+#include <asm-generic/compat.h>
+
 #ifdef CONFIG_COMPAT
 
 #if defined(CONFIG_64BIT)
-- 
2.17.1

