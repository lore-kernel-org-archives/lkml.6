Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD4CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1066206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSJ5+BwM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732240AbfAIPSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:18:11 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40153 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730725AbfAIPSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 10:18:11 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so3441091pgp.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 07:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ARKDrisAl1k2U6UTgEe1li3yvO/6nZYU2CZsSYeoKBE=;
        b=fSJ5+BwMdvK3r+larLGPN3N2I3Jb6pS0Zrn/RUSP2a8owLWje1Up/OOCr8Vkp2ZOkq
         JRy7ETQC9h/tnvM3A22qMCwSkP71qdoppFxSVd2YBQk3DL7pTIoxmIP90IItgmmNwRT+
         rNaxej/7Csv4lIepkV3mL9i5D/rov/CTRvPYPSwktx2De8TpqO+IRuU2tsi7qwu6iVPW
         ITEEFL8oHIpJza89z2GKpw4/DJT5Wf6eCrl0NsWgzqMWz7z8+LHea7x98Q/8+VvS698X
         NYL9cI+Thwq0/XIKqQK3G2NoAu8gHv4CRmKCcFaiygMKkq5CZ9dUWS0xvlEdRgHM2zd7
         2lKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ARKDrisAl1k2U6UTgEe1li3yvO/6nZYU2CZsSYeoKBE=;
        b=Oq24A/Z20/8xmoA1FH50SD+IRtH6qlpAMTXCDPKP/Bad3LH7JcUFuuHJOdvnoJVSOI
         jW39mqGJYO8AytA/HNRuhyvlLBjpaC91YYA0RU1pvFolVb+UXK0zSOUM7cZ44K9BYMkS
         KxLG0w9P+RZDJnwMPQiQ47/Zy+/l2DfOnq7CfRf4hyzd4sYnXeQL5ayjooCG6BQa6Yx6
         PVBuB0oBPa1nMy0rkWLP0npqBQ7ZFC7XRNGHajudtNtF2dHP+FyzoUWGMSKBjSur8M/0
         ZcGoA7oZtLWf2iWKDCpDMKJz6YqExZyPQiXLE+CN4gsrcztW51wrN6/a5KKkhk4fkLnA
         NEPg==
X-Gm-Message-State: AJcUukdc3ikuwhXrgTrb1x8rydbHJakSE22Kqp2BlGP3BNDB9tRM5+dV
        vZla4scSnbg0aU8HDbIZ9Zg=
X-Google-Smtp-Source: ALg8bN53AoyER8xikEckBFUeTn7XcdkI88Xo+wAFyIVJqmQdZOoUyJr0TBhT15dm7RIVx8P7FgwmPg==
X-Received: by 2002:a62:3305:: with SMTP id z5mr6466446pfz.112.1547047090744;
        Wed, 09 Jan 2019 07:18:10 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.49.233])
        by smtp.gmail.com with ESMTPSA id s2sm140054951pfa.167.2019.01.09.07.18.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Jan 2019 07:18:09 -0800 (PST)
Date:   Wed, 9 Jan 2019 20:52:09 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, willy@infradead.org,
        ak@linux.intel.com
Subject: [PATCH] x86/mm/fault.c: Convert to use vm_fault_t
Message-ID: <20190109152209.GA13599@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vm_fault_t type for last argument of do_sigbus().

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 arch/x86/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 2ff25ad..dea3725 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1031,7 +1031,7 @@ static inline bool bad_area_access_from_pkeys(unsigned long error_code,
 
 static void
 do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
-	  unsigned int fault)
+	  vm_fault_t fault)
 {
 	struct task_struct *tsk = current;
 
-- 
1.9.1

