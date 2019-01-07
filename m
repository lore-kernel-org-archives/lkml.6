Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721D9C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433732147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VkVhLmNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfAGOx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:53:28 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35340 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbfAGOx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:53:27 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so269042plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 06:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=13qvNhqz5adh8H7HAMhUD3/uHkd4DMTPZ6JpXLBiryc=;
        b=VkVhLmNLZjD0w1SQF5mARUTC4wmcsNYNDjFqrDgEvBl5FQ/51cl/M4BtUosGyIriSo
         piVnjTjHzaHa2/sACpY2CnxfTSM62u3nSOQSLHIRH8GdAlqPaujqXbmni28JPi1INSdH
         Dux8zULQ+33ces7BYTEnu4MCL5jqW+C0uqe50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=13qvNhqz5adh8H7HAMhUD3/uHkd4DMTPZ6JpXLBiryc=;
        b=c0XM2nKKwgdFQmotfNzZ4wWdQpV6UnoElqvFvh4f55gOENK/XZXD7xb9v39V/biJXT
         b9OWgU2ZWvB8AYIE5e9rA6Jlg1EH0xOOAyweZWUZwRcdsHxafBorB61si4DTd6sq4RRg
         z7g3Unhx1fpgCsKWqAnU9ENYK7c0vJ/4cn3AT8K31lFMw/1n8+BKyFgHaKk1XV3aPQgL
         Aqz8HqkFy/DKSSc1mzrCvBZN7qnvRuFFnxy0tJpEsDeXWxKXCfvSnmB27R96Cq6c2fji
         RVeXate0Yvze/gL9cJm9Bsh/LzkRCCQb3noTpXJPPLIuivGLqHKGpor0BTByjbpMRa7f
         Z4yQ==
X-Gm-Message-State: AJcUukcNpYW4kZUEZhA7+Z+juHtFJVRGwdjqDiJgbP5IY8vr4UfF6fOo
        EYZdFnJbRoLqNMDxCNHeNYcZIw==
X-Google-Smtp-Source: ALg8bN7ymGLs/Ielo723WIkrcEDnyxlP2IVT+0gXCCRbihcDqQi35RXNbJ2qpcG5sZyR8uCWwWTt8w==
X-Received: by 2002:a17:902:820d:: with SMTP id x13mr63232243pln.229.1546872807090;
        Mon, 07 Jan 2019 06:53:27 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id o84sm121145584pfi.172.2019.01.07.06.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Jan 2019 06:53:26 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-c6x-dev@linux-c6x.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 2/3] c6x: add __ARCH_NOMMU as a bugfix
Date:   Mon,  7 Jan 2019 20:22:45 +0530
Message-Id: <1546872766-3354-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546872766-3354-1-git-send-email-firoz.khan@linaro.org>
References: <1546872766-3354-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add __ARCH_NOMMU in uapi/asm/unistd.h file as a bugfix.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/c6x/include/uapi/asm/unistd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/c6x/include/uapi/asm/unistd.h b/arch/c6x/include/uapi/asm/unistd.h
index 6b2fe79..9e9ffe5 100644
--- a/arch/c6x/include/uapi/asm/unistd.h
+++ b/arch/c6x/include/uapi/asm/unistd.h
@@ -18,6 +18,7 @@
 #define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_CLONE
+#define __ARCH_NOMMU
 
 /* Use the standard ABI for syscalls. */
 #include <asm-generic/unistd.h>
-- 
1.9.1

