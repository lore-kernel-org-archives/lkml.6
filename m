Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B54C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B6E20883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iitqknEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfAHNCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:02:45 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41407 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfAHNCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:02:44 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so1871782plm.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 05:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZSoL/Kk/BCmIoIGSuAlkdgXRZS794wm3/tJcUjwgI/I=;
        b=iitqknECZeiHbmov/UnzYlFETwohVebt+CBHska4FIbSCKzWUba3wgkn3nt8NheqMU
         GSdXGcSlurYT5+zvT/aIleTpl0tgyM+qO2VInXNBKnqt0a/FU7FoEjSwjidtQGfrXe1A
         vtvc72DLU9HGf60d5p2Xe4HyAzhUZ1hQkJwd4DkRDFONTL31ectTFeIDyzyj1L70Amp8
         Ja7wjqTPRTTf0EW8kl3sE5OaSOke4mHt+3fdAMsadsb96piJ7QOGQk04vmyHWuacXiyb
         f+NZqlB9bCYyTmg6ZseJk0LJwXhIKooOOkyJDEtw+q4H7OE2YCmjT3PEScnbPvvGrBdl
         3Vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZSoL/Kk/BCmIoIGSuAlkdgXRZS794wm3/tJcUjwgI/I=;
        b=oXbRU6imwDZDRlND8CSDNV3rS+D5ivBMC+vxJtVITJ6qn2TdFATHkgHpnz6wQAeE03
         0HJkmWx8RHkbOFe7I1dFFcy7ZKIkZs9uI5HZImxAeXTa357xLgFHjvdtFuJ2po7mPWA5
         UhuhTyGGk5QcZARkqDJDwc5uwpRQqXIl4TPzJtajiMTQaY1YKaaQDusWk933kxVU23aj
         gIjeTIAhkyL1SCdfvq8uoUIWoIXya3/OYZy2I6S5xPQ7R08yjqPBvPFbpjnjyr0xWGGJ
         wBbyt3cglOsbZKm/z4mTUrUjm+k6jrLs+kXqt4Bpu2WR61Yl5nRd4thc+ZwS8unbVGo2
         uYVA==
X-Gm-Message-State: AJcUukeLFle7O61VCqPMh8myVJuzQdT7tTWMuMpAiqIvuk/Sgp32/9HK
        orJnm7FRpgMiU0rKFhtYH60=
X-Google-Smtp-Source: ALg8bN6azsF9/Zk/X9+SdMlAxbmeNjAN3UuJ1XdisVJVsQC6hCuysog4u3nVPbgcX0WjvwjHQ76jhw==
X-Received: by 2002:a17:902:f81:: with SMTP id 1mr1644973plz.174.1546952563721;
        Tue, 08 Jan 2019 05:02:43 -0800 (PST)
Received: from localhost.localdomain ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id n21sm100678648pfg.84.2019.01.08.05.02.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 05:02:43 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] x86/fpu: move init_xstate_size() to __init section
Date:   Tue,  8 Jan 2019 22:02:25 +0900
Message-Id: <20190108130225.5066-2-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108130225.5066-1-sergey.senozhatsky@gmail.com>
References: <20190108130225.5066-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: vmlinux.o(.text.unlikely+0x1c05): Section mismatch in
         reference from the function init_xstate_size() to the
         function .init.text:get_xsave_size()

WARNING: vmlinux.o(.text.unlikely+0x1c19): Section mismatch in
         reference from the function init_xstate_size() to the
         function .init.text:get_xsaves_size()

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 arch/x86/kernel/fpu/xstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 9cc108456d0b..d7432c2b1051 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -669,7 +669,7 @@ static bool is_supported_xstate_size(unsigned int test_xstate_size)
 	return false;
 }
 
-static int init_xstate_size(void)
+static int __init init_xstate_size(void)
 {
 	/* Recompute the context size for enabled features: */
 	unsigned int possible_xstate_size;
-- 
2.20.1

