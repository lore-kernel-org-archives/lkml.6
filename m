Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F409AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95B720874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218832;
	bh=fCRKsIrHSPNW2A6IIl1rV3IfVLtI73NyE7AWUR3e+rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T3kMArifqh7EMLvsIU75gKfGfE43wFqa6FEibEUx2mgB0n5iSylD1SWF3YSEV1tis
	 5fxU4Bk6glVor+segHamxI8PtsYoNAfO/tuYevbdRyVF688JCBmTYYLimaTNoP9CVw
	 aNdpjkBz4AN2W/jTLUMcIM8EUdVgVsvwZa1r66rc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389511AbfAKOcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:32:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:52842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389491AbfAKOcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:32:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DD342133F;
        Fri, 11 Jan 2019 14:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217165;
        bh=fCRKsIrHSPNW2A6IIl1rV3IfVLtI73NyE7AWUR3e+rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yRPXPV7jxzpuWtcx6lVJyW+WFbhqqJM1iNWs+wxHo/Y3gUpDJZ8DDKfmfDUfNBpCY
         GERGfHz25N3lKU/5nYiJ3IjufP0Y5kSqD/K3flvf3C8v6UoIj2s84yn+OmZpTClWMu
         ZusmVzFRMU1mC0aj5GBMXSSspS13ocosRee/XtZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 028/105] x86, hyperv: remove PCI dependency
Date:   Fri, 11 Jan 2019 15:13:59 +0100
Message-Id: <20190111131105.724441917@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c629421a990033ba539eb8585e73a2e6fa9ea631 ]

Need to be able to boot without PCI devices present.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 50b89ea0e60f..247a62604d1f 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -2,7 +2,7 @@ menu "Microsoft Hyper-V guest support"
 
 config HYPERV
 	tristate "Microsoft Hyper-V client drivers"
-	depends on X86 && ACPI && PCI && X86_LOCAL_APIC && HYPERVISOR_GUEST
+	depends on X86 && ACPI && X86_LOCAL_APIC && HYPERVISOR_GUEST
 	select PARAVIRT
 	help
 	  Select this option to run Linux as a Hyper-V client operating
-- 
2.19.1



