Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336DDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB42206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218540;
	bh=TcD2AvscNW6WNckdQxz1v9Q62Jl4A46+uHVE8sbLcms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jFbSOcJNjdrPV7xfOwDpAzzb/YQtyF5/3gsPtdePOck+Uumrhk7jRMdLWJNnbek2g
	 Dn0QqL3aD70VjiZvvkMoPNCM7PJoe03lMiV+DAqZs4UZ/EAbLF4KHE5BqfGaJ7w/f5
	 lroQrc1ZWylW9i+5/XeGikEONBDUrk3fBM1BHl5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390418AbfAKOge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:36:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:56790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390386AbfAKOg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:36:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A4A9204EC;
        Fri, 11 Jan 2019 14:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217387;
        bh=TcD2AvscNW6WNckdQxz1v9Q62Jl4A46+uHVE8sbLcms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0+sLBfkk55lANRC1QZV0yTmmBV0EgL0JHlvmSUPbcSAQ2bY3L0SKG56z1Fl9IHUUJ
         V7t1DFznaQQzr1yVB/T5YBRYhRTgt/2QNNyFBxIWbRtJ0olM36SUEYNvkZzzhkPAJf
         UlmdyngqInbQyYg88NhzR9GbRsf9pzmtI7LULL0U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 042/148] x86, hyperv: remove PCI dependency
Date:   Fri, 11 Jan 2019 15:13:40 +0100
Message-Id: <20190111131115.970717444@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c629421a990033ba539eb8585e73a2e6fa9ea631 ]

Need to be able to boot without PCI devices present.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 97954f575c3f..1c1a2514d6f3 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -4,7 +4,7 @@ menu "Microsoft Hyper-V guest support"
 
 config HYPERV
 	tristate "Microsoft Hyper-V client drivers"
-	depends on X86 && ACPI && PCI && X86_LOCAL_APIC && HYPERVISOR_GUEST
+	depends on X86 && ACPI && X86_LOCAL_APIC && HYPERVISOR_GUEST
 	select PARAVIRT
 	help
 	  Select this option to run Linux as a Hyper-V client operating
-- 
2.19.1



