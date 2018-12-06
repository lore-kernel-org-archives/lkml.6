Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDD6C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6450220868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNrNrhHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6450220868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbeLFP0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:26:53 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34355 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeLFP0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:26:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id j2so921833wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 07:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DtX6dNPPTmO8fgeltf7XOI+iRx6USDoJtU287CCOJhI=;
        b=oNrNrhHxGhfH9PPwGeGPFhvnXEPcGTvsNLabCdnZMQY7RIez+Fux02hwuIKFAHu/8F
         grEj9k2U45sU78PPWbEgXkYh5Fn4/2oVnZJ6WAA4lStjJenzIdXb1IxdgwUMYEOI2G4S
         tU8xMR1NP6oV3uHANQUNN47qhzY5MXHdcJx4L8NOhRsp35NJaVGHAaXv2/Yd7KHE/2WM
         mSwPNyHw9ZHUbpCyDDCH+30Ihr8wfUL0JQbd2L+xFWTd8JpoNpthkp6sEXLnqFPQPBT1
         n9P/qVnO776PGUeiBjnM+avH2OuhAS+74LxgIyI8T2FEWHZxrM0xBg0WTNmGhcBfjvf0
         tejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DtX6dNPPTmO8fgeltf7XOI+iRx6USDoJtU287CCOJhI=;
        b=tZt1s4XleEFgntkx+SlqQYVpL1EClB2iTKBbACPY1oPZZuaWIEY1iY7Q0RgmFs2+sU
         1Iv2jnY818twq6CbcpsyPmAcGJiZwA5u8K40dWI7poSHRLnAMcdZxwZ2V3g+qRlPtV6D
         cXhV0bb3yGjRVfnrGVblOnrRUBcYJZd8R4yhaeAcoDUpFwVCEJqaBSwk93ik6RaINoe8
         1rjChzVmc8A4/zp3411aL4Yvjgl6mpr3llDqjYO/ddtn/uZw3eLyx7tS8YkAbACimZBT
         qmobmmqB+6Z71wnksH1Wo9CKwcsvyLAH7+2x9a5V/ut1yEgIGChV29XIWlLrLL4adMlV
         Xr6A==
X-Gm-Message-State: AA+aEWaSmCifRWMXxwAL9nZJQCZ69ZIKxckJjRGIoWZ84/AgpbLwNGH0
        MbD2Hl2mvXaf1cDi5GYtqFyGwaKdlyw=
X-Google-Smtp-Source: AFSGD/VGIjpNPa1GOgXmds0Fyod3SWV+qytPU4wWzW2BLRRbEbsBLdCeZNNHq4k6/XrgeVAOSlKhYw==
X-Received: by 2002:adf:c505:: with SMTP id q5mr25237434wrf.84.1544110009804;
        Thu, 06 Dec 2018 07:26:49 -0800 (PST)
Received: from localhost.localdomain (ip-76.net-89-3-178.rev.numericable.fr. [89.3.178.76])
        by smtp.gmail.com with ESMTPSA id w6sm529728wme.46.2018.12.06.07.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 07:26:49 -0800 (PST)
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Subject: [PATCH 2/2] riscv: add HAVE_SYSCALL_TRACEPOINTS to Kconfig
Date:   Thu,  6 Dec 2018 16:26:35 +0100
Message-Id: <20181206152635.1869-3-david.abdurachmanov@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206152635.1869-1-david.abdurachmanov@gmail.com>
References: <20181206152635.1869-1-david.abdurachmanov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I looked into Documentation/trace/ftrace-design.rst and, I think,
we check all the boxes needed for HAVE_SYSCALL_TRACEPOINTS.

Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a4f48f757204..6749c22ee656 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -34,6 +34,7 @@ config RISCV
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_PERF_EVENTS
+	select HAVE_SYSCALL_TRACEPOINTS
 	select IRQ_DOMAIN
 	select RISCV_ISA_A if SMP
 	select SPARSE_IRQ
-- 
2.19.2

