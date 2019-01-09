Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B5EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76072173B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5CzvUqh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfAIUSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 15:18:44 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35438 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfAIUSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 15:18:44 -0500
Received: by mail-wm1-f68.google.com with SMTP id t200so9774660wmt.0;
        Wed, 09 Jan 2019 12:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QPItt1mCzwDxqSHw70DXeUjWCLlE2xErlGpQWxgwhbc=;
        b=A5CzvUqhNRs2Sd78wXuyktj0sdpGUh0CxBL5LPsg5h2IDrqBPJjEeu1iWWyu3V7ohp
         GokunV0NIO9GSHys1DYt70z3NtrQ+Iid26MVOHBuomuNYatOngxYj6pyMs4Ew0MP6NBD
         +mRF9mZO+F1eZBfE0IhkNtQ2Elr9EEstVGUOGb6eC8JEzB2wqqss0JTpEWlnD6iHMlYM
         ZwfejsD4MZjk4Cj43mENaQtmzmh9+y5PgBEm/Afs3PrNHbrlDJZOm7ES7LQC7m5z/2Na
         +b+Kx3KnLJFbaESK8xCR4ReILlBxoG+36/Iwp7PX9hotDBpA0pUB3J00anKtxQYNWsWD
         rrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QPItt1mCzwDxqSHw70DXeUjWCLlE2xErlGpQWxgwhbc=;
        b=GZSe3NG4LCvY7rpWJ8FJpXBTQ8zwdA7K3+NnaouwCdgAuhzwYJl9TX7PGEPcIimnwi
         L403DvTXRAGMZI8eBZoQKusNbRszbUytmutFcizFkqhpQyd///xx/fgAp8DLBauTBZ9+
         kfwYr7JjmoMHl6UvHpdLZ9uleM/vWgLDqiWsw2vEtONvAaPni9xwsHZykkuGhoHWCUE6
         6pQIrkR/b+4lcPOpW/So7YtZ0EDlXf2fbZWNHRpCTzToWxj83AZESJqW1Ekke/TEPv7f
         tyitPz7GZ4f5d4CZQyPN6B6+aO0/Gh6Rsp6nDjzuIxYmOiakjoxE888KqcS4Ufk33Ts2
         ++hg==
X-Gm-Message-State: AJcUukeuO+G4qrQrx737dWCZX7hoJKwxaJ0vr5FZmnR2AdS5gDyLzoE5
        p5V9PE/gLXxNHDaLwwbAUiSwI7k=
X-Google-Smtp-Source: ALg8bN6wRNvkJefCo96f4xt1LERaxZ0kYW79xgE8so3BLtn+Z6HvczxQkC3pVTdnUAvQxkOgh/RpMg==
X-Received: by 2002:a1c:ce0e:: with SMTP id e14mr7389922wmg.53.1547065121451;
        Wed, 09 Jan 2019 12:18:41 -0800 (PST)
Received: from avx2 (nat-minsk-pool-46-53-201-92.telecom.by. [46.53.201.92])
        by smtp.gmail.com with ESMTPSA id g9sm13658392wmg.44.2019.01.09.12.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 12:18:40 -0800 (PST)
Date:   Wed, 9 Jan 2019 23:18:38 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org
Subject: [PATCH] mm: shuffle GFP_* flags
Message-ID: <20190109201838.GA9140@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GFP_KERNEL is one of the most used constant but on archs like arm
with fixed length instruction some constants are more equal than
the others. Constants with tightly packed bits can be injected directly
into instruction stream:

	   0:   e3a00d33        mov     r0, #3264       ; 0xcc0

Others require multiple instructions or even loading out of instruction
stream:

	   0:   e3a000c0        mov     r0, #192        ; 0xc0
	   4:   e3400060        movt    r0, #96		; 0x60

Shuffle GFP_* flags so that GFP_KERNEL/GFP_ATOMIC + __GFP_ZERO bits are
close to each other.

Savings on arm configs are ~0.1%.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/gfp.h |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -24,21 +24,21 @@ struct vm_area_struct;
 #define ___GFP_HIGH		0x20u
 #define ___GFP_IO		0x40u
 #define ___GFP_FS		0x80u
-#define ___GFP_WRITE		0x100u
-#define ___GFP_NOWARN		0x200u
-#define ___GFP_RETRY_MAYFAIL	0x400u
-#define ___GFP_NOFAIL		0x800u
-#define ___GFP_NORETRY		0x1000u
-#define ___GFP_MEMALLOC		0x2000u
-#define ___GFP_COMP		0x4000u
-#define ___GFP_ZERO		0x8000u
-#define ___GFP_NOMEMALLOC	0x10000u
-#define ___GFP_HARDWALL		0x20000u
-#define ___GFP_THISNODE		0x40000u
-#define ___GFP_ATOMIC		0x80000u
-#define ___GFP_ACCOUNT		0x100000u
-#define ___GFP_DIRECT_RECLAIM	0x200000u
-#define ___GFP_KSWAPD_RECLAIM	0x400000u
+#define ___GFP_ZERO		0x100u
+#define ___GFP_ATOMIC		0x200u
+#define ___GFP_DIRECT_RECLAIM	0x400u
+#define ___GFP_KSWAPD_RECLAIM	0x800u
+#define ___GFP_WRITE		0x1000u
+#define ___GFP_NOWARN		0x2000u
+#define ___GFP_RETRY_MAYFAIL	0x4000u
+#define ___GFP_NOFAIL		0x8000u
+#define ___GFP_NORETRY		0x10000u
+#define ___GFP_MEMALLOC		0x20000u
+#define ___GFP_COMP		0x40000u
+#define ___GFP_NOMEMALLOC	0x80000u
+#define ___GFP_HARDWALL		0x100000u
+#define ___GFP_THISNODE		0x200000u
+#define ___GFP_ACCOUNT		0x400000u
 #ifdef CONFIG_LOCKDEP
 #define ___GFP_NOLOCKDEP	0x800000u
 #else
