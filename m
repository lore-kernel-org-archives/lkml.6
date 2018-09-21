Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984FFECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 21:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B77621571
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 21:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1IoQkhw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B77621571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391565AbeIVDL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 23:11:58 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40455 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391318AbeIVDL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 23:11:57 -0400
Received: by mail-qk1-f193.google.com with SMTP id c126-v6so9060356qkd.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 14:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q59eA4xWV6K9K/6hLgsaP3wT3TmGA9WvVJlRBF9PZlQ=;
        b=V1IoQkhw1oGKTtTPZipGrMe1ntv+NX6346s2lt9vvx+JpsJ6RP54kKX+ojkcOK1AUQ
         qVKzGCeiYobc9xeFB7OfN/C5hQ1yLfn28gjQNyKJR6aX5e/eCEJxh0vtJWvcD2QyTLQp
         u7aDf64oCkJX3actxKavOD9AZaqZcDhp0hWuAW/aMjaViG+S48J6TVQrg7jgDieIs6DB
         rTzokHUONzEIWuoJvYF8nrnA3P/hmSMIYkF+xP8vEB46yxLDO1x/nha5ww43UXEiYNIp
         9l8NWBI4zsgv5/81SSKcvXm+Z0C3Go5So5YAAaA6x3LcGas826uj9YIq+HrhdthmmrLf
         l8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q59eA4xWV6K9K/6hLgsaP3wT3TmGA9WvVJlRBF9PZlQ=;
        b=b7TfMuNScpUPQrqgKW76eEy9MTBGWgjhkpbUDHouITt0QBxTv1e54ky2W+J91Diq4c
         Vo4KAl3CDdRO5AQVoL6Nih3sJTyNX4Lt1XHhDTqznVccCT8lxg/mdU3MGv+jxPJ1DOkI
         CjIaZd1LkVHXy5QWDzd4C7IBilc1L3DDpHVzfHz0VCPyRLbXF/QgbYJp6J0MdWCMa3io
         Df7d4ZN7dd+qQHmeUO+objadNZGGL+pzaqCcAQc3sje+U5Yd2nkcV+a7kT2LY6UrB2JO
         +qx2yH2LazJgmE6r90b8ITMbh7MyaFS5OptgbVEiunYXa0bCMR6qo4uYyFDCFfdqCM7O
         /5Og==
X-Gm-Message-State: APzg51DY0vD/RNbBT9CdaM+KR/r9dYahcLcb7/pcyEOq+ELNpriL+Zfz
        47LAzPit4WtFSV8Ir6Y4hhnZJlI=
X-Google-Smtp-Source: ANB0VdYF2f4vO4jYgLKseDkZXjkktlUad4fh9Fy6AjpL5qFMv/yQvgGw14ZCauD9YjfpHTEQaTAf8g==
X-Received: by 2002:a37:5b83:: with SMTP id p125-v6mr31849005qkb.196.1537564875308;
        Fri, 21 Sep 2018 14:21:15 -0700 (PDT)
Received: from localhost.localdomain ([2603:3003:4107:8d00::5ce6])
        by smtp.gmail.com with ESMTPSA id f6-v6sm16740401qke.77.2018.09.21.14.21.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 14:21:14 -0700 (PDT)
From:   Matthew Whitehead <tedheadster@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        luto@amacapital.net, bp@alien8.de, hpa@zytor.com,
        Matthew Whitehead <tedheadster@gmail.com>
Subject: [PATCH v2 1/2] x86/cpu: Use correct macros for Cyrix calls
Date:   Fri, 21 Sep 2018 17:20:40 -0400
Message-Id: <20180921212041.13096-2-tedheadster@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180921212041.13096-1-tedheadster@gmail.com>
References: <20180921212041.13096-1-tedheadster@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are comments in processor-cyrix.h advising you to _not_ make calls
using the deprecated macros in this style:

  setCx86_old(CX86_CCR4, getCx86_old(CX86_CCR4) | 0x80);

This is because it expands the macro into a non-functioning calling
sequence. The calling order must be:

  outb(CX86_CCR2, 0x22);
  inb(0x23);

From the comments:

 * When using the old macros a line like
 *   setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x88);
 * gets expanded to:
 *  do {
 *    outb((CX86_CCR2), 0x22);
 *    outb((({
 *        outb((CX86_CCR2), 0x22);
 *        inb(0x23);
 *    }) | 0x88), 0x23);
 *  } while (0);

The new macros fix this problem, so we use them instead.

Reviewed-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Matthew Whitehead <tedheadster@gmail.com>
---
 arch/x86/kernel/cpu/cyrix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/cyrix.c b/arch/x86/kernel/cpu/cyrix.c
index 8949b7ae6d92..d12226f60168 100644
--- a/arch/x86/kernel/cpu/cyrix.c
+++ b/arch/x86/kernel/cpu/cyrix.c
@@ -437,7 +437,7 @@ static void cyrix_identify(struct cpuinfo_x86 *c)
 			/* enable MAPEN  */
 			setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10);
 			/* enable cpuid  */
-			setCx86_old(CX86_CCR4, getCx86_old(CX86_CCR4) | 0x80);
+			setCx86(CX86_CCR4, getCx86(CX86_CCR4) | 0x80);
 			/* disable MAPEN */
 			setCx86(CX86_CCR3, ccr3);
 			local_irq_restore(flags);
-- 
2.16.4

