Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59653C37121
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEC820870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548112808;
	bh=3kufgmztrELjwW9JtGeq77yjk/C52ZMulQj9Y7Ulgho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hIOxB4+c1fJexMHyfsbhbLNAt/ljLeo66eo0OLDkNJYihMOa4Es9YzsDq0+r+eF5/
	 6CfBWnn5ybL/SlpsLUh9DI8lMksCoJxMs4shAWJ56IbGcR7CAJdD3DoBjBmmDEC/p0
	 xTviSHHmNoVp3ho2IyPYoPjyYdjnI9laRIBIMcTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfAUXUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 18:20:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:59370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbfAUXUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 18:20:03 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.117.83.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A964721019;
        Mon, 21 Jan 2019 23:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548112802;
        bh=3kufgmztrELjwW9JtGeq77yjk/C52ZMulQj9Y7Ulgho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gePac9im+of31CSYKkfk70y1qBZbzHB/Dq1WUo9BC+dUd8Zniqtj/PEvCSNavDD+H
         YXAvuhjZn/3U+hi0112EiQtZr15OUb8QBSy4qLLX8ymOqYR1X0Be/WDtYuwETHcJHP
         hrzn6h8TdmvMhjmxbsndh3iNLgXfuPc4HYtosfJE=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [for next][PATCH 2/2] x86/Kconfig: Select PCI_LOCKLESS_CONFIG if PCI is enabled
Date:   Mon, 21 Jan 2019 23:19:58 +0000
Message-Id: <20190121231958.28255-2-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20190121231958.28255-1-okaya@kernel.org>
References: <20190121231958.28255-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
satisfied implicitly through dependencies on CONFIG_ACPI have to be
specified directly.

PCI_LOCKLESS_CONFIG depends on PCI but this dependency has not been
mentioned in the Kconfig.

Add an explicit dependency here.

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 568f339595ed..0519da6f8ee4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -199,7 +199,7 @@ config X86
 	select IRQ_FORCED_THREADING
 	select NEED_SG_DMA_LENGTH
 	select PCI_DOMAINS			if PCI
-	select PCI_LOCKLESS_CONFIG
+	select PCI_LOCKLESS_CONFIG		if PCI
 	select PERF_EVENTS
 	select RTC_LIB
 	select RTC_MC146818_LIB
-- 
2.19.0

