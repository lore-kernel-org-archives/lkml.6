Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05040C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5252054F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="fQ942ovM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5252054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeH0XxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:53:18 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:57918 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbeH0XxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:53:18 -0400
Received: from trochilidae.lan (unknown [IPv6:2a02:169:34d6::189])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 26E875C0491;
        Mon, 27 Aug 2018 22:05:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1535400312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=iWENdm1xdcEOLCy9vygwGD/F6DmxsGHUysIo1z4Z6w4=;
        b=fQ942ovMX803vzaRz5Rxqh6/xI53EPN7+tLd7tZB/tHhsvAtSh//nDjgd/RBsgPrezMP/G
        ft6ufXpr/88cE+zZtVVi1t/C5Fac/2JCCNSqf1cRjNtJ9m+xIOBTqNRpdgvbtlgU/JzcSF
        2EzE+I/iYCVrUxL77DiPcAQzEFgtZkk=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     arnd@arndb.de, hch@lst.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH] ARM: wire up io_pgetevents syscall
Date:   Mon, 27 Aug 2018 22:05:05 +0200
Message-Id: <20180827200505.21991-1-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up the new io_pgetevents syscall for ARM.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/tools/syscall.tbl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index fbc74b5fa3ed..8edf93b4490f 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -413,3 +413,4 @@
 396	common	pkey_free		sys_pkey_free
 397	common	statx			sys_statx
 398	common	rseq			sys_rseq
+399	common	io_pgetevents		sys_io_pgetevents
-- 
2.18.0

