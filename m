Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA97C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD3121741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkC6AO6r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733230AbfA1RJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:09:02 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44133 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733031AbfA1QLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:11:50 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so7385140pgr.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 08:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=CV388ilkjL0NcLVI0uaGKJeYDzVKBWBY5OcOpufxxPc=;
        b=rkC6AO6rkKbgt9CB/wiM/aYiYfQuXpg0AmcKVo3Z0suKBF7QQlqbUFhNYmFmOtSDjL
         gG9iBres8z+hERqnTMH8AB0qRmEA62RZGHi3enK2okgQZaZY8AU59Duen8DxmLRI/2qY
         VN7QmeR4Jng7XT+7P2HRCwGAmgOn4Zzd9ZVkF9oARXn/FEif1YCtP7u9qL982S4l3zab
         qEj9d1PP+2QqdZx2PAXOQfLLibt3DgU926iBmJN5cZQT4sS4lvSS2PD4G4qv9gsIiI4k
         cQmdWO0ughG0V8CvBYV+UW6XuV06jp6pg6d9gMyq0TPUBAOdHbvRRhetRqwEPuBdu8FG
         YL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=CV388ilkjL0NcLVI0uaGKJeYDzVKBWBY5OcOpufxxPc=;
        b=Z8xtByvQyf4WEDpq3qARh/YsNUNBXBx2uZeTOns/L5ZWkZi6bA818W877Rk+R/wVCq
         5fSRdTMDEpSLetzA+ig75NBwTEouTwPpvo3tdrDsEAyfJZLeAL2M/X34G0UuEAJb2Sxz
         30bPKygjw8GdWELrZFdZ+G/gMCsg2kVdCrjxHS1LcBYY8Ki2he2ucshq73z5NvdWplAE
         kNOrXbT+OmqpFyNAJCPWZIq63PmDWw5eJbycuppLUy/lJ3GByKAPXgaD4dyUIYuWKufG
         5uoFUc18XJxdSMDM7JidaTu6hYi1r8CXkDO/ZpYAizDK9IboDEmZf8fwnyWbvphnZulu
         W/iA==
X-Gm-Message-State: AJcUukfeWBV/ITSmoYOOHajJcR1AspRbMhRk/LyH0eAZQUdDYI/VNfeQ
        rRbBVxS51sRoeKRHDi7jagk=
X-Google-Smtp-Source: ALg8bN5oiB7c+yXgt6FEtfawuyFcw+R/BgttdHCUnb3PSB26onItgOqrnKhAkZj1bs/uAv6zqfka/Q==
X-Received: by 2002:a63:4384:: with SMTP id q126mr20174469pga.160.1548691909813;
        Mon, 28 Jan 2019 08:11:49 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([47.11.154.113])
        by smtp.gmail.com with ESMTPSA id p2sm41647731pfb.28.2019.01.28.08.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 08:11:49 -0800 (PST)
Date:   Mon, 28 Jan 2019 21:41:36 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@c-s.fr, arnd@arndb.de,
        anton@ozlabs.org, aneesh.kumar@linux.ibm.com
Cc:     jrdr.linux@gmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
Subject: [PATCH] powerpc/kernel/time: Remove duplicate header
Message-ID: <20190128161136.GA2266@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove linux/rtc.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 arch/powerpc/kernel/time.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 3646affae963..bc0503ef9c9c 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -57,7 +57,6 @@
 #include <linux/irq_work.h>
 #include <linux/clk-provider.h>
 #include <linux/suspend.h>
-#include <linux/rtc.h>
 #include <linux/sched/cputime.h>
 #include <linux/processor.h>
 #include <asm/trace.h>
-- 
2.17.1

