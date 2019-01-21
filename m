Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1128C282E5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C242520989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhKBAw61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfAUHty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:49:54 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39616 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbfAUHty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:49:54 -0500
Received: by mail-pf1-f193.google.com with SMTP id r136so9740668pfc.6;
        Sun, 20 Jan 2019 23:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=oMUSXr5QsF43bcIcsIiuh+5ymsAO1eFL7kdTCvBXLWI=;
        b=nhKBAw61LBsc1KZvQRmxBkPBknsCXawIVZAdBMR00NyVT3zwFiGabAhsTyCDO0VO4g
         mUBSoLtGzh9mwWstNx7/DGl8PlY3oRefvQRBz+K7qdqNheS/Zu5AfzcuUl4G1hI7CFcS
         FUTPkJxc9An4I9Bwxs8q7TExmOdP97G9GdS8BwesLNhZsijjXO3mA6uirK4T2RtWNZjP
         0c2wRbaNMmEBjwHIwBVaYlTtx4MUcSg4gOarQ38CHH4t3yrw4TmlXIubmxWxb/NvOtma
         YpkJQgfd3zLyWAyDd4CqP+7+V4cfxBmISOSZlGbPHPVBI5l9hFmWfbmH1xCWfevOZSPC
         DiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=oMUSXr5QsF43bcIcsIiuh+5ymsAO1eFL7kdTCvBXLWI=;
        b=li055qVZ1pyZKs85tWT/nsvi2UsiqDaEn6JCDU6vVa78qCaiZkzqoMZJab8thy+pLp
         fi80Ngkc8YUfq0r0n3dSrMqlfs0D3G5nKEJWZyLvoBFX5VKbTww75j/nLWvmXOZBFtw5
         kpX3YadeWiRJcHVxjwGapQm/gaKtY75Abiv+O72czvXaZlK43CwjGDhyxYfORWLv4kyT
         2Umf6qpMRkpqYSO/3EOLKYBv6cZkrqHS+7DuMEnKffUb1IfYzodk+hi3QPFwr7xzClOe
         hTOhvEtb68i5PfRQGxInz0P8sjqHD3NFTRj9g6VEY+foYxmNpa9IA2YefdvJbHhaA1DG
         9WEw==
X-Gm-Message-State: AJcUukdjCzFu/G/wvD0HVyFG+s4fLCsJRQExcmegcb/WatLPuRGEYeI7
        w7JFlIc4guwtHUUBoELnQB4rCIU=
X-Google-Smtp-Source: ALg8bN7IS+OseEJcGrMGJ3Qx7LLRPIrTleJj4d2q5EAJkJbSWmYtih9VDuMdMeJWN6tf2H9CMhDMLQ==
X-Received: by 2002:a62:9657:: with SMTP id c84mr28960807pfe.77.1548042310585;
        Sun, 20 Jan 2019 19:45:10 -0800 (PST)
Received: from genru-archlinux (220-135-242-25.HINET-IP.hinet.net. [220.135.242.25])
        by smtp.gmail.com with ESMTPSA id c4sm22977095pfm.151.2019.01.20.19.45.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Jan 2019 19:45:10 -0800 (PST)
From:   Jun-Ru Chang <jrjang@gmail.com>
X-Google-Original-From: Jun-Ru Chang <jrjang@realtek.com>
Date:   Mon, 21 Jan 2019 11:45:05 +0800
To:     ralf@linux-mips.org
Cc:     paul.burton@mips.com, jhogan@kernel.org, macro@mips.com,
        tonywu@realtek.com, mingo@kernel.org, peterz@infradead.org,
        jrjang@realtek.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Remove function size check in get_frame_info()
Message-ID: <20190121034505.GA1522@genru-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch (b6c7a324df37b "MIPS: Fix get_frame_info() handling of
microMIPS function size.") introduces additional function size
check for microMIPS by only checking insn between ip and ip + func_size.
However, func_size in get_frame_info() is always 0 if KALLSYMS is not
enabled. This causes get_frame_info() to return immediately without
calculating correct frame_size, which in turn causes "Can't analyze
schedule() prologue" warning messages at boot time.

This patch removes func_size check, and let the frame_size check run
up to 128 insns for both MIPS and microMIPS.

Signed-off-by: Jun-Ru Chang <jrjang@realtek.com>
Signed-off-by: Tony Wu <tonywu@realtek.com>
Fixes: b6c7a324df37b ("MIPS: Fix get_frame_info() handling of microMIPS function size.")
---
 arch/mips/kernel/process.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 6829a064aac8..339870ed92f7 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -371,7 +371,7 @@ static inline int is_sp_move_ins(union mips_instruction *ip, int *frame_size)
 static int get_frame_info(struct mips_frame_info *info)
 {
 	bool is_mmips = IS_ENABLED(CONFIG_CPU_MICROMIPS);
-	union mips_instruction insn, *ip, *ip_end;
+	union mips_instruction insn, *ip;
 	const unsigned int max_insns = 128;
 	unsigned int last_insn_size = 0;
 	unsigned int i;
@@ -384,10 +384,9 @@ static int get_frame_info(struct mips_frame_info *info)
 	if (!ip)
 		goto err;
 
-	ip_end = (void *)ip + info->func_size;
-
-	for (i = 0; i < max_insns && ip < ip_end; i++) {
+	for (i = 0; i < max_insns; i++) {
 		ip = (void *)ip + last_insn_size;
+
 		if (is_mmips && mm_insn_16bit(ip->halfword[0])) {
 			insn.word = ip->halfword[0] << 16;
 			last_insn_size = 2;
-- 
2.20.1

