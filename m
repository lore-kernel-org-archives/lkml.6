Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C73AC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B032A2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVndotcq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B032A2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeJZDfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:35:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41430 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbeJZDfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:35:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id a19-v6so4641025pfo.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 12:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8S9m4MWvb18JXBx4d0GbFiXW2VAIEnxv/Q8oXWj2Ak0=;
        b=cVndotcqgTFj7NSdQ+sn8ZhQ2N0swYhKxJBiuGmQRCE8EiMnkqZ2eFquAYzvHGOV0G
         TVY5g+iz4fCnnDHFo7MGWpZ9/zVLhxwv5QoiufQPMKlZq3ywngut0pLA5RXbq5pTkv/D
         gJSpH4Tt6IqZAmv/h9kiWeEOmThT/thI/xIHonZRdLgfMwjceB89FsUi+qjCmqmAAjB5
         WCa0GBinb6DZGl998EeM5ilxGPxJbp1fNfSoFaueFacGfRovnGf8W9jAw+QRgXbfswz6
         mKmC1ZCqPaIvOfV1MpBoDlNMxyTpJOhdI7e/KJvIe/8KSzcNms4CDR+knSj2iEMiKruI
         5DXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8S9m4MWvb18JXBx4d0GbFiXW2VAIEnxv/Q8oXWj2Ak0=;
        b=WQTkR6aH1EY0sjuBzo13YTeh4zA4r3wMbQx+bdWS95oKkInYYmPGYpLWQRLfU4G4Te
         aVH735vZcmWQ28NvFXyG4K4MJdK8oFNP1cL0QqT93t73kscychGUE0wV4LOowvRnnUMP
         3tvuT9X9/PBUaaANNBcr7Mit1XqTrCYinOYUQTMlOnwGNAAILHSKVwlBGjFOSzGozNiB
         2obuRbwTsKTYDc1laLc8I+m3HQkcXHteA+/5tpsdWCaCm25QiJC/e2dOaocG3PSyZdpW
         d1+KEQUU87c2eyh3pTgZH/Dlx99mhkXl5XA2dO3LGiGszf/Uq1OBb1zB8ZpQZRO0RnBa
         +Z0g==
X-Gm-Message-State: AGRZ1gLuKueb8CxZMzf/8gIZQUd34eQAiOgTtKoE4UZFr87Ljb1cWVNu
        oytSRvc77mE1M1dShp3sq0U=
X-Google-Smtp-Source: AJdET5cQxkvQ/Bmi/oGSgGe2n6DEcnbc5bXDaj39dl1SG/77ZQExlJB9I6wx6dLFLTJ78QA5YsLIJQ==
X-Received: by 2002:a62:9fc4:: with SMTP id v65-v6mr415074pfk.130.1540494097110;
        Thu, 25 Oct 2018 12:01:37 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id l129-v6sm12163415pfc.155.2018.10.25.12.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 12:01:35 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     andrew@lunn.ch, ebiederm@xmission.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] ARM: mm: Facilitate debugging CONFIG_KUSER_HELPERS disabled
Date:   Thu, 25 Oct 2018 12:01:08 -0700
Message-Id: <20181025190110.7564-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some software such as perf makes unconditional use of the special
[vectors] page which is only provided when CONFIG_KUSER_HELPERS is
enabled in the kernel.

Facilitate the debugging of such situations by printing a debug message
to the kernel log showing the task name and the faulting address.

Suggested-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mm/fault.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index f4ea4c62c613..58f69fa07df9 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -173,6 +173,12 @@ __do_user_fault(struct task_struct *tsk, unsigned long addr,
 		show_regs(regs);
 	}
 #endif
+#ifndef CONFIG_KUSER_HELPERS
+	if ((sig == SIGSEGV) && ((addr & PAGE_MASK) == 0xffff0000))
+		printk_ratelimited(KERN_DEBUG
+				   "%s: CONFIG_KUSER_HELPERS disabled at 0x%08lx\n",
+				   tsk->comm, addr);
+#endif
 
 	tsk->thread.address = addr;
 	tsk->thread.error_code = fsr;
-- 
2.17.1

