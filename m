Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23E6C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7E820836
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546199815;
	bh=D7hGCZVGaij5kPaqIxVh16MxKbBwDEXZ8GW8sEjvepw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f95vpkVmgzWyttLnFbKCUm/fRtVzkH8Qo5PNzoYNhDxplLMnkEjy8roeOoR7ClPsF
	 k3OEavuDKuWyTck6m28bx6UK5w/JZHgyVupgZIkVVT9mHNXSJQuOUglPvjJ8/0AZZG
	 Leic8pX2bDzuETbhLB3VC1qP+XCg9BFCeDqNelKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeL3T4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 14:56:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:47634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbeL3T4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 14:56:20 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.76.85.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B94C20866;
        Sun, 30 Dec 2018 19:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546199779;
        bh=D7hGCZVGaij5kPaqIxVh16MxKbBwDEXZ8GW8sEjvepw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uSSWHiFckD5qgO3QTvhD/Y2YdC4BTvfETvt05krdHu0j+yudFL/gtyVlK/CKZC6XQ
         m7Nr6gkl7XoLCIoCmxA3d0Xu75DxiHZUw7j5v1iBhNQCYcX430vCVzX5N+ctutK5bu
         BgHvFqfs1H7nYjH6BhFieeFyQEG1571l1IZkmJaE=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 05/11] platform/x86: intel_pmc: Make PCI dependency explicit
Date:   Sun, 30 Dec 2018 19:56:06 +0000
Message-Id: <20181230195612.6657-6-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181230195612.6657-1-okaya@kernel.org>
References: <20181230195612.6657-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code relies on PCI for execution. Specify this in the Kconfig.

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/platform/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index b36ea14b41ad..7afb96cb1cd6 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1174,7 +1174,7 @@ config INTEL_SMARTCONNECT
 
 config INTEL_PMC_IPC
 	tristate "Intel PMC IPC Driver"
-	depends on ACPI
+	depends on ACPI && PCI
 	---help---
 	This driver provides support for PMC control on some Intel platforms.
 	The PMC is an ARC processor which defines IPC commands for communication
-- 
2.19.0

