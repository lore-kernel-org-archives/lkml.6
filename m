Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF29C282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A7A20821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qg/9/eOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfBEIcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:32:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33881 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbfBEIcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 03:32:31 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so11936008wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 00:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JQaIGbqbOsdpvvMZdriTA2P6Ud0BRc1w/mg9jQCrw74=;
        b=qg/9/eOvq6rtSSoMkn6ONKe2eKzdaDOfqzBZVarYa5UMLly+1GwPeczUfyFhN5XzRL
         jgJMGtNfxeAxkli8mNJGJ+ueYZvdMyEAhU+dPYGoLPygsaq9C5wGfQShpFfFM1ankA6d
         NJlkQBg56utEbCSbfdbiOayol7F5vZlhs+JOMXiiM1sMh/3LXwWSDQLJyi9P7YuVAQaC
         d3ixhwI0eDN4TVqZ/Wkl6M96WOUyxIyi+Jecd7Kg8ewyaBLeNVR4pWlviHkolI+18U57
         cxoO5EVdTT4YuGhYiuygPJNCEkvlcoRZ2Joqhk5rqwsdCjT21eDSZLqy/EBTTffOzP9Y
         vpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JQaIGbqbOsdpvvMZdriTA2P6Ud0BRc1w/mg9jQCrw74=;
        b=JcszqoPLRgovujmhMU3pXsqcSbkgyddGz4kPnb/w9dQhcKledqM+AdAVtvtgMJ+0tQ
         05ujXxQk/kzXduP9hnWn2XHnu6OfTw3gOgH5UsU4ApNoODkZ0xOgkjVvxJ0pQNhIYNJ9
         JcvyXAIFQBtviYJ6eitWg9vP7vwV6zxMjv63z6MHxxwvE8/arL55o6PRdbecngnCBOc0
         DRfXijaECrr02D5ijpB6q2EaDMWTnyE1EyQLqIEpyWALB6BTAklYtDgepj21V2di44eF
         dl/YcQkezLBdqNwxTYuEySu31JEUezPUxKtxU5DZOt1OuaCN+4yViAa0w1RksgZYT7ZJ
         WCeg==
X-Gm-Message-State: AHQUAuakj7lcqRsS3ili5+sjInPnjqnYg9MEfPvmXIVuOVrroad15Yr3
        D1gdThUYm3bY6X6qYfkY20xOsg==
X-Google-Smtp-Source: AHgI3IbCzcad5CJDRZsKoo9zeRC3C32LYze/heCorOZBPAiLBqVZ6MLEiInJws3hQGcoOPFSuRo8aA==
X-Received: by 2002:a1c:f518:: with SMTP id t24mr2713700wmh.26.1549355549401;
        Tue, 05 Feb 2019 00:32:29 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id g3sm3118596wmh.20.2019.02.05.00.32.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Feb 2019 00:32:28 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     vgupta@synopsys.com, abrodkin@synopsys.com
Cc:     linux-kernel@vger.kernel.org, khilman@baylibre.com,
        linux-snps-arc@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 2/2] arc: hsdk_defconfig: enable CONFIG_ARC_UBOOT_SUPPORT
Date:   Tue,  5 Feb 2019 08:32:15 +0000
Message-Id: <1549355535-22052-3-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549355535-22052-1-git-send-email-clabbe@baylibre.com>
References: <1549355535-22052-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have now a HSDK device in our kernelci lab, but kernel builded via
the hsdk_defconfig ignore bootargs, so it cannot boot kernelci jobs yet.
Furthermore, I think the probability is that devices will be booted more via
uboot than by a debugger.

So this patch enable CONFIG_ARC_UBOOT_SUPPORT in hsdk_defconfig.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arc/configs/hsdk_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arc/configs/hsdk_defconfig b/arch/arc/configs/hsdk_defconfig
index 0e5fd29ed238..b80e3ac5c93c 100644
--- a/arch/arc/configs/hsdk_defconfig
+++ b/arch/arc/configs/hsdk_defconfig
@@ -9,6 +9,7 @@ CONFIG_NAMESPACES=y
 # CONFIG_PID_NS is not set
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_BLK_DEV_RAM=y
+CONFIG_ARC_UBOOT_SUPPORT=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_VM_EVENT_COUNTERS is not set
-- 
2.19.2

