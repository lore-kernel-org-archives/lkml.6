Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7F6C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F6E2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="el3xz9iq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfAGRPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:15:11 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40609 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfAGRPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:15:11 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so408000pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 09:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=x/QzmUyHJ6F27j7w4MWF17KHvW3Orfvcl1prMlNjj+8=;
        b=el3xz9iqaEkNf37pJLFnUYd+fMGNUQdfA54pCPwiKcmLJb6jSYvQTW1BldSNfp/Ry3
         qLCZr4mckISAinfRez97Ye1LmcpTWkAYrqPBVq9RCe/MDm2K8l/Jb7N8Xbm+fuDPTjLH
         +WepaiTP97E3Vaj9TxIDS5IS5h/9q+7HLwe9Q3UffQCuPNUl4pNSyCx37qSU0CL7WuBU
         IPwpxeTFO0L7PEHMNElk91JKGQ2gQ1nSxWJHWvFan5T4gxS5cU+/dYHQJ6UOjFTzjMEv
         RNI8Wl6LOAIoloSc8KDHD6I5LS7HKkavmQn7r/RCnE/60853gIrIhLQXhCIh2VcpqBEX
         dzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=x/QzmUyHJ6F27j7w4MWF17KHvW3Orfvcl1prMlNjj+8=;
        b=q/w4h5qTGgd7YM/PNG1/Ok36g/jAt+KR7L/zFqGFGbu87D2fMNmYu38nP4hwQVoWkF
         AJOqFXivB5l301qGbtE+H2UJ9ndc1P8I1YLvJF5l7Pi77GYVDP01C7eLoi5YkPvLvDkC
         JnC5h9+7gAYFU3lvThFIA9gO9m+uD/y4WFHBwWbPMmXsVFlKknLPhnPR0WVQ8EY3YMD3
         LDEpRqyKr2m0l31NNaUVJA8U6kATyn+tkZCuMmfHPO91Xmiyh85WrCkYgn73a4pam+4P
         k5BAl+2pF+tgVt6ZoMYR9IVmbMbnGWosbrA2z+TcS42OvcApTaoIUtYRw1NUlMewe+Nd
         vkrA==
X-Gm-Message-State: AA+aEWZmvzk7p5WnQm+SbsmjxAhU4x2Q7kmA2WKrwWDfkcS+hqakHyfU
        ZY+AbZgLkd4CHkLpqfMVD7w=
X-Google-Smtp-Source: ALg8bN4hrojHm1+xmTxfWxSQfh+U9iWFKTVjoMf6FAqzNGy+dstoHCZ9/iGQowKlRYVAMqi3ZfCenA==
X-Received: by 2002:a62:47d9:: with SMTP id p86mr62375182pfi.95.1546881310280;
        Mon, 07 Jan 2019 09:15:10 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.19.175])
        by smtp.gmail.com with ESMTPSA id s190sm97380708pfb.103.2019.01.07.09.15.07
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Jan 2019 09:15:08 -0800 (PST)
Date:   Mon, 7 Jan 2019 22:49:08 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     linux@armlinux.org.uk, mchehab+samsung@kernel.org,
        linus.walleij@linaro.org, wsa@the-dreams.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        brajeswar.linux@gmail.com, sabyasachi.linux@gmail.com
Subject: [PATCH] arm/mach-sa1100/simpad.c: Remove duplicate header
Message-ID: <20190107171908.GA5246@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove linux/gpio/machine.h which is included more than once.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 arch/arm/mach-sa1100/simpad.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index 406487e..c7fb9a7 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -18,7 +18,6 @@
 #include <linux/mtd/partitions.h>
 #include <linux/io.h>
 #include <linux/gpio/driver.h>
-#include <linux/gpio/machine.h>
 
 #include <mach/hardware.h>
 #include <asm/setup.h>
-- 
1.9.1

