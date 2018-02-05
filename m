Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752674AbeBEBZq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:25:46 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43840 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752611AbeBEBYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:24:53 -0500
X-Google-Smtp-Source: AH8x227YZR26P9/eRNP2XfBm/WU23eOzhlLnZop2DrxBKu3rknulIcZlo74V9JLuaTjuXvWxwmTVPA==
From: Ulf Magnusson <ulfalizer@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, tfiga@chromium.org, paul.burton@mips.com,
        m.szyprowski@samsung.com, egtvedt@samfundet.no,
        linus.walleij@linaro.org, vgupta@synopsys.com,
        mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com,
        robh@kernel.org, sboyd@codeaurora.org, paulus@ozlabs.org,
        will.deacon@arm.com, tony@atomide.com, npiggin@gmail.com,
        yamada.masahiro@socionext.com, Ulf Magnusson <ulfalizer@gmail.com>,
        Boaz Harrosh <ooo@electrozaur.com>
Subject: [PATCH 13/20] ore: Remove PNFS_OBJLAYOUT dependency
Date: Mon,  5 Feb 2018 02:21:25 +0100
Message-Id: <20180205012146.23981-14-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180205012146.23981-1-ulfalizer@gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PNFS_OBJLAYOUT symbol was removed in commit 6d22323b2e9f ("nfs:
remove the objlayout driver"), but the ORE symbol still depends on it.

Remove the PNFS_OBJLAYOUT dependency from ORE.

Discovered with the
https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
script.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 fs/exofs/Kconfig.ore | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exofs/Kconfig.ore b/fs/exofs/Kconfig.ore
index 2daf2329c28d..73cab8d92dfd 100644
--- a/fs/exofs/Kconfig.ore
+++ b/fs/exofs/Kconfig.ore
@@ -7,7 +7,7 @@
 # selected by any of the users.
 config ORE
 	tristate
-	depends on EXOFS_FS || PNFS_OBJLAYOUT
+	depends on EXOFS_FS
 	select ASYNC_XOR
 	select RAID6_PQ
 	select ASYNC_PQ
-- 
2.14.1
