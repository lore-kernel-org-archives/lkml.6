Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEA3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B9A21907
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863837;
	bh=ZAwtI7S7tpRdr98IrxI03Uu/9Q7ebwBGfeeugP2GhBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vF/zsnnL8QNjwE4tXp7ICKAwseU8Wy1GuUNA0B+mmLz0LUuhbWWrOvbLPZta8LrbH
	 OE51Biy0/6xcpqRPng1b4msV2qMgnlR2TANB4Pcz+5LN5dr9RfYDfyOxMh2CHbn06d
	 HaG4zi+yQr1e3MRmZ2XuzDNMSiv4U2LcLx8F1HKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeLZWhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:37:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:37280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728097AbeLZWhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:37:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0DCB218FE;
        Wed, 26 Dec 2018 22:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863831;
        bh=ZAwtI7S7tpRdr98IrxI03Uu/9Q7ebwBGfeeugP2GhBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xMn1nPYfQCcar2i5jYIlefIA6Fk76DkdSboS+OraIYJzXBRjUQMgOe3FdUh/unBxh
         yYc1uZIzuo2QDuPfqeE4cKPqRp2sUGWu1lf1JawVw/LDhZqeb4iZHqZSym2DfstYPk
         DSD7ze6pN3OM85nvaywh4avXYVZ8tzeVnbpNX0SY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>, Sasha Levin <sashal@kernel.org>,
        devel@linuxdriverproject.org
Subject: [PATCH AUTOSEL 4.19 46/97] x86, hyperv: remove PCI dependency
Date:   Wed, 26 Dec 2018 17:35:06 -0500
Message-Id: <20181226223557.149329-46-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinan Kaya <okaya@kernel.org>

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

