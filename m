Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D01C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1235F20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1235F20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeK0Gyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:54:36 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40323 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeK0Gyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:54:36 -0500
Received: by mail-qt1-f193.google.com with SMTP id k12so19076967qtf.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 11:59:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=5PrUBg/th3RFhXk6/SdU1bKY3J8DNBLUu4+/xWVaDnM=;
        b=QBhIYtxZXr2vi1cP41SAAT0fXMHqfeHkJdxir8rHR6oT37W1mG3fhW05uvkfPFIJfG
         0+G4wC4OceYFFmol+JaicAeLresdl2DY4Adg8WbQ81wRtMjqKhdCi/2qTXU+3FtMLv7K
         gkeHCT9wZTIAJoeGYWG2X56LeGYBkN7XLOx5CawxC3SOa2KGP0/sauh9HUwaAwrhh6ef
         dSPbhEso8zItfN6ATThiFuNeQdZt3JprsSAL2qVL9P90Rbhb1dPEbubdl3lQfvFVtzpP
         wt/W2q/ZP3zGXEcGPeMfFrssWVJTGJMj/RZ7IDZV7HCEpsIPHP6jqzGQndImfSSQNcBh
         v9sA==
X-Gm-Message-State: AA+aEWYMu7DlVU0gOH1SMjHa6qIr4+OvtWsPFIVQfhTEB86yGFFRHCtV
        yTL+v9zP98ddSks3ygygGsPHuUFC
X-Google-Smtp-Source: AFSGD/WcIcNhEZJg14+PjWYi9dFTxN4ehJoyXsomIrhcXks3PHgmCQolQh5xyWN4CnoGeyeuczPpjw==
X-Received: by 2002:ad4:5307:: with SMTP id y7mr28423039qvr.9.1543262363413;
        Mon, 26 Nov 2018 11:59:23 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id b17sm809807qkj.69.2018.11.26.11.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 11:59:22 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Mon, 26 Nov 2018 17:59:15 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Fabio Berton <fabio.berton@ossystems.com.br>,
        Otavio Salvador <otavio@ossystems.com.br>,
        =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>,
        Arnd Bergmann <arnd@arndb.de>, Eric Anholt <eric@anholt.net>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Stefan Agner <stefan@agner.ch>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>,
        Russell King <linux@armlinux.org.uk>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v2 2/2] ARM: multi_v7_defconfig: Improve use with systemd
Date:   Mon, 26 Nov 2018 17:59:05 -0200
Message-Id: <20181126195905.5427-2-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126195905.5427-1-otavio@ossystems.com.br>
References: <20181126195905.5427-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Berton <fabio.berton@ossystems.com.br>

This enables following options:

 - CONFIG_CGROUP_BPF
 - CONFIG_NAMESPACES
 - CONFIG_USER_NS
 - CONFIG_CHECKPOINT_RESTORE
 - CONFIG_BPF_SYSCALL

Those are based on recommendation from Gentoo wiki[1] which describes
the recommended and required kernel options for systemd use.

 1. https://wiki.gentoo.org/wiki/Systemd#Kernel

Signed-off-by: Fabio Berton <fabio.berton@ossystems.com.br>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

Changes in v2:
- rework commit log

 arch/arm/configs/multi_v7_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index a8ec309d182a..34c8a745d951 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -2,7 +2,12 @@ CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_CGROUPS=y
+CONFIG_CGROUP_BPF=y
+CONFIG_NAMESPACES=y
+CONFIG_USER_NS=y
+CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_BPF_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 CONFIG_MODULES=y
-- 
2.19.2

