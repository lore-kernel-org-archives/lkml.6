Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EE7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4496F205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sVYdXDU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbfAQOaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:30:11 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37581 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfAQOaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:30:11 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so4834937plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 06:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Cbj6vEfgXvmKrCXCkBOMRdx31fA2CXUeeXvveYwZp2w=;
        b=sVYdXDU/NWaNCdwTcEMMOWSeoUogfuLzumvd/+b3bXdcM4mUulp8Ym1Bw2pKlRqfdU
         1UtN+28gwoX9sU9Kd3h1YMgWWYqTEQX3QOIrfMU9AD9dfw/VeyPkP55vHAh5nnigbBzy
         h3eAjiAy//kjbsT/auZuEGQaxajtnwKpsxsqJZ0PWbgIXM86aWLdzXD3ZHXSlmx2YqfE
         +w87lPEv34wms+tXmN9uZ6CpyDxZWj/IVP8CWUkW9SDpokY4fVbULuhCGTI9HtmApjFg
         dq2cdB0yNNMlWcd2UEHHKUXfGLvRuzjSIYOD0PT5SDJesp+Uc6iPamKvP6uUTDQWm49t
         IHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Cbj6vEfgXvmKrCXCkBOMRdx31fA2CXUeeXvveYwZp2w=;
        b=g+fnqiFc2F63HLw+PyyJinBN/aLMSzaWz6Ozr9N5ljrIGF+6iAx7/5AyQ2XlIVzFeJ
         C9kIRQoZwcSLT5ugppNn97v8MxO8V9OuFT/bsG7XMQeRe7qTE8E10CaGXsVwcFCTsrOb
         yrBJrmDV6tlim6W7/TZCL/fXHAH22WV+SwvbbBtnsXvNsDWY0B0T50w2uj02Wt9Wa6gY
         zfI8k4W3MohZLslWENvVP1D3AnZUZihPfZOKxzdQP7pP0HVDMxCQaRJdTWdA4u17KpYx
         w77GsIp6Ikj2Y34n3s3K6uAgaDiWQEgCjiommS82qTiZhzSFd8lPJ5tIipAVxgtUJE7T
         CB+A==
X-Gm-Message-State: AJcUukd4mrnpoo21m/LMUiImK2VHAEtbr+ucUgn9lRbeYJBKpWOOKKiY
        Uh7yK0Bo34mSLuV/3S0z6gk=
X-Google-Smtp-Source: ALg8bN7S5dp3PylX5acr4kMB6JgPDmNLjY7Im0Gtz6GBQSHfzWks/YXk1c5uM9ML69i3tH5IyirNsA==
X-Received: by 2002:a17:902:bb86:: with SMTP id m6mr15325261pls.315.1547735410226;
        Thu, 17 Jan 2019 06:30:10 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([2405:204:4402:39a3:451f:6d25:2f65:74d6])
        by smtp.gmail.com with ESMTPSA id x11sm7448930pfe.72.2019.01.17.06.30.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 06:30:09 -0800 (PST)
Date:   Thu, 17 Jan 2019 20:00:04 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     ren_guo@c-sky.com, arnd@arndb.de
Cc:     jrdr.linux@gmail.com, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: [PATCH] csky/kernel/entry: Remove duplicate heade
Message-ID: <20190117143004.GA2916@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate headers which are included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 arch/csky/kernel/entry.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index 79f92b8606c8..f2081ddcc398 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -9,7 +9,6 @@
 #include <asm/unistd.h>
 #include <asm/asm-offsets.h>
 #include <linux/threads.h>
-#include <asm/setup.h>
 #include <asm/page.h>
 #include <asm/thread_info.h>
 
-- 
2.17.1

