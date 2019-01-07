Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A304DC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66BF32147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="sx621G3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfAGXQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 18:16:44 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40155 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfAGXQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 18:16:44 -0500
Received: by mail-yb1-f196.google.com with SMTP id x201so856234ybg.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 15:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/WwBr+Tzu5XcWcFiNikHjmD9H+6xUjFSK9owpOcNL/c=;
        b=sx621G3zbi6jl8yoKLaoj9Pfd58dP1LWgGu3yI5djCOmEGBtxcKLclgnjmPnLfgWgz
         Z3nZury/uMamAT/paX3AHfbzW6CW3CjxgjvQDHF9I5ttJh00D/H2CfO6gF8+KG4qaBJ5
         jiJ8qu5yD7GLIlIPnx/j9yQKldIC5WDo2B7WKNvZH9JN1FSkYnUss5kOjYWbg1So7gqM
         Bq2lHdFeUJ0RIVwxAcMafZeGEXzCqfpzaDhUALsYBU2VOkvvYpL5DGeNdkgH0q1GppPM
         hFg5Gl+XGdhqv3K1mHMShvpFLpbeLhBP6M3tzje4QcyerrLa8P6hoYb+C10bbwNWNELl
         q9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/WwBr+Tzu5XcWcFiNikHjmD9H+6xUjFSK9owpOcNL/c=;
        b=quBCs1zaVd85/DHR0Vmujvj6dIdtEEPZz/X5+bXEonRfhTk93me2EJV5YGsC1KuKvK
         Fu0L0fthLJq+DcDdLfOqzzZ7ybSJjj6J75VLHib3mY2WDYBLWrnzcAgckUhJN5qxetbQ
         x9XiKQoDrTUUdnLtZEA//74nkqDk+SxZccSEl4rkrSrcc+ehlhZ0vAdiBOx1m7PLa12P
         NjF37DswxE3vd3qULz6Mru9akKs7rgzEcvhGgu/2/KUjDGQlI661DQT73aeRyadwWrmf
         PMR1jqHWdcQ+LHm2Qk5Vrx3P20bVXxa+l3qdeY/nalQb2Yu12RDSTSzWkhJP/UMsh3OS
         K69A==
X-Gm-Message-State: AJcUukekLVoIuLRmUT90K2lllruztAFmASry820BOG22cdiISdqvdhm9
        ZuJZByHtn6UHvOzzG5DcLV89wMGj+gxZbQ==
X-Google-Smtp-Source: ALg8bN6aUZbraMyY2Y7ihL5PH4LjTfwiIRUIBj/MwW+9nXKnCFLSpIckFiQecxXbptjpiMcfHnaijA==
X-Received: by 2002:a25:db04:: with SMTP id g4mr16200486ybf.18.1546903002888;
        Mon, 07 Jan 2019 15:16:42 -0800 (PST)
Received: from cisco.hsd1.co.comcast.net ([2601:282:901:dd7b:c092:9114:ac14:211f])
        by smtp.gmail.com with ESMTPSA id f67sm27840835ywa.93.2019.01.07.15.16.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 15:16:42 -0800 (PST)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Ingo Molnar <mingo@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH] samples/seccomp: fix 32-bit build
Date:   Mon,  7 Jan 2019 16:16:31 -0700
Message-Id: <20190107231631.1849-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the .o and the actual executable need to be built with -m32 in order
to link correctly.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
Reported-by: Ingo Molnar <mingo@kernel.org>
Fixes: fec7b6690541 ("samples: add an example of seccomp user trap")
---
I guess x86 can pick this up directly? Not sure where it should go
exactly.
---
 samples/seccomp/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
index 4920903c8009..fb43a814d4c0 100644
--- a/samples/seccomp/Makefile
+++ b/samples/seccomp/Makefile
@@ -34,6 +34,7 @@ HOSTCFLAGS_bpf-direct.o += $(MFLAG)
 HOSTCFLAGS_dropper.o += $(MFLAG)
 HOSTCFLAGS_bpf-helper.o += $(MFLAG)
 HOSTCFLAGS_bpf-fancy.o += $(MFLAG)
+HOSTCFLAGS_user-trap.o += $(MFLAG)
 HOSTLDLIBS_bpf-direct += $(MFLAG)
 HOSTLDLIBS_bpf-fancy += $(MFLAG)
 HOSTLDLIBS_dropper += $(MFLAG)
-- 
2.19.1

