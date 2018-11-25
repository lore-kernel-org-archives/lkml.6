Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3542DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0059F2084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0059F2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbeKZILZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 03:11:25 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45140 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbeKZILY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 03:11:24 -0500
Received: by mail-qt1-f196.google.com with SMTP id e5so15494112qtr.12
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 13:19:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=t7lsGt49k3uMFJJvuNzeFS8yN2cadVdozgLlp7QA5Rw=;
        b=aaGsrdhjpyiNBkR+h35qLzMVoXYSbOsOyoacHimsGIIsRGamvsEmcjgMzyRKCgMuLP
         wFWnU84dXq3c78cowrI9T9781DVrvmCWr9wqWTIBoQtt3udJBX6L3SQNMU9zulCUmtUp
         sBZLOLY5ftj7UuDD0Xb7ge5LhyABYLKaVBzRDdASjQ20k2CYwSQrZH2qoo4hZaWeCpbO
         qmmirN0vptUbij+wFLs/i4JIo8xNAmF+4QgHG7qMO+tkvHCNVz4uUoadkD18Flm0l88Y
         HZ4G88gQtT11BlRC/JUts4Pz17UuLTDJ9ho222yfbr4ZEfCT/iWSqobqqfD/Bo6kFuQ/
         rX7g==
X-Gm-Message-State: AGRZ1gJIARHv5wSupB2VFXNzUGHb2hgac2zIvas7TwH5ApWa2cTlpaP5
        vYAnrjo25REOfyrQnzwn39ufAbRK
X-Google-Smtp-Source: AFSGD/X/MGPL87LfggLjE41ETpwvRtq1ecYQ49ZuzhXhRuda2CNqnzy7elo0RFd8tZ4/3uxeVLoPJw==
X-Received: by 2002:ac8:29d2:: with SMTP id 18mr22909197qtt.174.1543180765097;
        Sun, 25 Nov 2018 13:19:25 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id x41sm9240825qth.92.2018.11.25.13.19.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 13:19:24 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 25 Nov 2018 19:19:17 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
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
Subject: [PATCH 02/13] ARM: multi_v7_defconfig: Add missing systemd options
Date:   Sun, 25 Nov 2018 19:18:56 -0200
Message-Id: <20181125211907.9895-2-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181125211907.9895-1-otavio@ossystems.com.br>
References: <20181125211907.9895-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Berton <fabio.berton@ossystems.com.br>

Signed-off-by: Fabio Berton <fabio.berton@ossystems.com.br>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

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
2.19.1

