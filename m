Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50F4C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999F821721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548168081;
	bh=BFTnvXnAm5o3G6K0jtRw7dWn6GTmBURul6yM41En70k=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hMwHq+5wmem16RPOB0Rhr0AKaBpvTnw1Tn7EnGHel/r4zLvr9u+jVhI0xDLvX5sIR
	 rYD9IbF50DX/w1lELSd8/PdUV/MKIbDSUilskDN/NkW0VoMq7yFtQ9OFH25d8SLScT
	 NDbM4lHg5ofyS8qsEBklFXDcd03Cl7EtxXypiJnw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfAVOlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:41:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:53168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728353AbfAVOlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:41:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D92E20855;
        Tue, 22 Jan 2019 14:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548168079;
        bh=BFTnvXnAm5o3G6K0jtRw7dWn6GTmBURul6yM41En70k=;
        h=From:To:Cc:Subject:Date:From;
        b=drNM9kb2lNWdeg+G3bR6vPoSJcolXVMUITjyma/KZgi0Eloic232HTY1g1Il2HEqu
         oWgzqHFHP7HZ2prXbPx5y/feJXq2OYT8JgonwnKBOXsrrddugjIDS47wHx1Nv6wYam
         hSItg7yFaAhz6E9d7hQLk5umbpyEVOsGEgquNZLo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/4] ARM: cleanup debugfs usage
Date:   Tue, 22 Jan 2019 15:41:10 +0100
Message-Id: <20190122144114.9816-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs code, there is no need to ever check the return
value of the call, as no logic should ever change if a call works
properly or not.  Fix up a bunch of x86-specific code to not care about
the results of debugfs

Greg Kroah-Hartman (4):
  arm64: dump: no need to check return value of debugfs_create functions
  arm: dump: no need to check return value of debugfs_create functions
  arm: omap1: no need to check return value of debugfs_create functions
  arm: omap2: no need to check return value of debugfs_create functions

 arch/arm/include/asm/ptdump.h   |  9 ++---
 arch/arm/mach-omap1/clock.c     | 63 +++++++--------------------------
 arch/arm/mach-omap1/pm.c        |  7 ++--
 arch/arm/mach-omap2/pm-debug.c  | 15 ++++----
 arch/arm/mm/dump.c              |  4 +--
 arch/arm/mm/ptdump_debugfs.c    |  8 ++---
 arch/arm64/include/asm/ptdump.h |  9 ++---
 arch/arm64/mm/dump.c            |  4 +--
 arch/arm64/mm/ptdump_debugfs.c  |  7 ++--
 9 files changed, 34 insertions(+), 92 deletions(-)

-- 
2.20.1

