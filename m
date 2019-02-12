Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FBBC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D23222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hydkx+Du"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731802AbfBLRQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:16:32 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40374 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731772AbfBLRQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:16:28 -0500
Received: by mail-ed1-f68.google.com with SMTP id 10so2861001eds.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PWKxQooIvE5dHLOz2OtceRXcOqy7jac9KKsFTONstGg=;
        b=hydkx+DuavtsR7Uwdo9TB0qjO1hjFxg2YKoTbBHU0X5zM8pDUwhiI7CoAvl/TLGYar
         ZvdxgZrHPwGZqJrJJtIB1HnqS0oJUUBLZ6RE167fPHKo23lEa5HIJk5Our9rrQlXj3ro
         oYLI5wf6Of3+wmpY1ljQwxYNsfvdNo+LJo2EN5GdmiXi5kZoBpHakIACoeMTaDuQM0Y7
         k7azg6qIIGgJhQatb9HyjYRMbgtxPBBCrXmYz3tlPEYV0jLRDo37vLCDyl0NXBp6I4Dv
         BNz4g3agnRTojuYO13iLtrawGXG1z49J/gwwfz/8AZWSMM2vM7XiAOERIcTbaTH3wBhJ
         rElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PWKxQooIvE5dHLOz2OtceRXcOqy7jac9KKsFTONstGg=;
        b=X0vfc+7hGZVgpVLifObFospeqJJsS/sdC2aH6PFNFYloI2jwXDAbBu+NH4KMy+EWkT
         jaSN+PFpRfkzFoJlDT5EDrMBdz3YVFSqmBEAHtR16SVZOH2B8Yxh4Q2/b0XUUipAtQYk
         BsDZ5aHpEkEJke+7w2uwaVBlt6StxZlSqkg+xdZyvIOUF7h5U9vqtYhxQeUp1zhyQWsY
         klrAtIAFgr2Ehg/A8rBpjsyWMmR+3E4YCSVvBgK9+XTsEo/t5Kp4tR2QNOXG++NEPw7V
         fd55ROoMmvXVAeU1mIjOd8vYo/YMs0//8oQe1BcmHn5zXlZmduL4TljX7mp27gnx/+1R
         uaFQ==
X-Gm-Message-State: AHQUAubP22PY4bqQ02DWiLpjB1Avom8uBKUVtujc+MU2reaJEpjf8c6W
        whNC6IhQI+5945vLUeIgesmu+6l3gI6fkw==
X-Google-Smtp-Source: AHgI3IZ1oceoufUlqVsrCkTPQKFiq2gc43iJxcA+Vw4eADxYGjcQcStc1WuE9hbgQnLSTotUZqdR0A==
X-Received: by 2002:a17:906:381:: with SMTP id b1mr3482708eja.67.1549991786273;
        Tue, 12 Feb 2019 09:16:26 -0800 (PST)
Received: from dumbo ([83.137.1.208])
        by smtp.gmail.com with ESMTPSA id h1sm3123074ejx.41.2019.02.12.09.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 09:16:25 -0800 (PST)
Date:   Tue, 12 Feb 2019 18:16:16 +0100
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Borkmann <dborkman@redhat.com>,
        Francesco Fusco <ffusco@redhat.com>,
        George Spelvin <linux@sciencehorizons.net>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        Ian Campbell <ian.campbell@citrix.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Matthew Wilcox <matthew@wil.cx>,
        Nadia Yvette Chambers <nyc@holomorphy.com>,
        Pavel Emelyanov <xemul@parallels.com>
Subject: [PATCH] Add the SPDX header to include/linux/hash.h
Message-ID: <20190212171616.nlfz45mtr3zcyv7p@dumbo>
References: <20190115170017.5gxarqxzfezgr5ld@dumbo>
 <c3aa1b37-60bb-aceb-10ba-9768157a2a5a@gentoo.org>
 <20190211072259.GA19224@nouveau>
 <20190115083241.6c6ftrw73xuv26j6@dumbo>
 <2977287.v5rPGuGa1n@merkaba>
 <86va1p7c7z.fsf@benfinney.id.au>
 <8a87da85-3aef-a113-f93f-c96ab465c96f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a87da85-3aef-a113-f93f-c96ab465c96f@kernel.dk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Domenico Andreoli <domenico.andreoli@linux.com>

It is unlikely that who contributes to this file is unaware of the kernel
licensing but bringing the license statement into the file itself makes
it properly reusable in different contexts.

CC: Daniel Borkmann <dborkman@redhat.com>
CC: Francesco Fusco <ffusco@redhat.com>
CC: George Spelvin <linux@sciencehorizons.net>
CC: Hannes Frederic Sowa <hannes@stressinduktion.org>
CC: Ian Campbell <ian.campbell@citrix.com>
CC: Jay Vosburgh <jay.vosburgh@canonical.com>
CC: Jens Axboe <axboe@kernel.dk>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
CC: Matthew Wilcox <matthew@wil.cx>
CC: Nadia Yvette Chambers <nyc@holomorphy.com>
CC: Pavel Emelyanov <xemul@parallels.com>
Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>

---
 include/linux/hash.h |    2 ++
 1 file changed, 2 insertions(+)

Index: b/include/linux/hash.h
===================================================================
--- a/include/linux/hash.h
+++ b/include/linux/hash.h
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
 #ifndef _LINUX_HASH_H
 #define _LINUX_HASH_H
 /* Fast hashing routine for ints,  longs and pointers.
