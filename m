Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F29C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0A920672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMFSZuAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0A920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbeLJPNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:13:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46565 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbeLJPNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:13:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so10805388wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 07:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=SZzKSrhqccWQdpOVW17AHjuTu939cT/b5KlSYsuXu2Q=;
        b=EMFSZuAMaNTdvPGKAYAdCKY/LLtFhVvK1dci3wuXGuPw9GuBqo16T1bf08VeXnqyb7
         8TJ3oFhGeV1ZlAq57SMVjTV9kqhb7EI2/8WWontfXOxjpbIGdTBpPV/f2Qs7pI9use9N
         qP1WK6mv55FKrQp3sSYgzqCkjoNtL6Jf6AU2aTRxT9v2AWtHODxGHM8UmjMHbPeEbHmE
         MRuP3eJ+Kap6CZlZwWw32TX8BmwKBiGpXq7/QeljIO5L032XCj2i2lJ7IUE9sKraoqMg
         bHyfTZC/OXh2k3U905zd5Z0jSQu3tEyZGlYTOp/1naOnt7t7v5rN69R+O7YdjZ+qOtr2
         zXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SZzKSrhqccWQdpOVW17AHjuTu939cT/b5KlSYsuXu2Q=;
        b=CiCRUsqMl9bDm8uBGQJji7arHuax2aPxwLvQBNo1fyQ6ydG/WzUHdDeTBq1dQLFxSE
         E6wCIi/8h1yflmdc9smzr81xvUOWefFj1Xtt3iuPvY2i12ACCcQ1ZxH9b6X+i7/fZI73
         +wGiI86e/LV5uwxnQ+tkd2myHt8QDbSE+IuJnlWe5xkwl1Fv6r1Tjaz9SDQzFkcViOP/
         aIbLFbJNAK1/86hgNJ5gC05aMmMA2q8iQx0rFvmn0ye9FzXwhmXkkzj5igFjo1YIgmbo
         ySiucmf8jJ0UFbqjh6g+ji3WlwX6IKvOhByC1sUQoRL51IU4KmSm3b7OW+cg2aK0rTD6
         ZFTQ==
X-Gm-Message-State: AA+aEWYHBNgv5GqvQP/3aVQVujiEgCEZOB37PjcW+a6LvtLKAJdTQPuY
        3ZKvHzcrU98r9kqfBuWCPQ==
X-Google-Smtp-Source: AFSGD/Wq585wafpkfGUpsgCJxMlaGmEvc6SjI/7Cq/jXJEiRIwD9EgncDyUW6CbCZj3luyFgJokZ9A==
X-Received: by 2002:a05:6000:8a:: with SMTP id m10mr9808615wrx.79.1544454778463;
        Mon, 10 Dec 2018 07:12:58 -0800 (PST)
Received: from localhost (host34-126-dynamic.27-79-r.retail.telecomitalia.it. [79.27.126.34])
        by smtp.gmail.com with ESMTPSA id 129sm12168951wmd.18.2018.12.10.07.12.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 07:12:57 -0800 (PST)
Date:   Mon, 10 Dec 2018 16:12:57 +0100
From:   Andrea Righi <righi.andrea@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kprobes/x86/xen: blacklist non-attachable xen interrupt
 functions
Message-ID: <20181210151256.GA1977@Dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Blacklist symbols in Xen probe-prohibited areas, so that user can see
these prohibited symbols in debugfs.

See also: a50480cb6d61.

Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
---
 arch/x86/xen/xen-asm_64.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index bb1c2da0381d..1e9ef0ba30a5 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -12,6 +12,7 @@
 #include <asm/segment.h>
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
+#include <asm/asm.h>
 
 #include <xen/interface/xen.h>
 
@@ -24,6 +25,7 @@ ENTRY(xen_\name)
 	pop %r11
 	jmp  \name
 END(xen_\name)
+_ASM_NOKPROBE(xen_\name)
 .endm
 
 xen_pv_trap divide_error
-- 
2.17.1

