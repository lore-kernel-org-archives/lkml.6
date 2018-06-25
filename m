Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A32BC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2620C25979
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMpcRKln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2620C25979
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755472AbeFYMqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:46:08 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43426 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755429AbeFYMqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:46:03 -0400
Received: by mail-pf0-f195.google.com with SMTP id y8-v6so6392642pfm.10;
        Mon, 25 Jun 2018 05:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/fFwUTOq5TotVWM5uJztPWAemINo6V3+BKTxyGrVtys=;
        b=IMpcRKlnjG7lvrzYdDM4q4OOv3KhbIL6JSwjmN+JLjg8Y2z6CtRwOxoOEwpxqRrmAH
         +XWdsLkiaP+3ggwzN+ISeTPxWrW3rvxVm1cEeJ4JecfDszXEqdgmnm/9iVMyHngwYNbw
         XP8as88TmNyHsQdA/2Jl2b6AIdXGbvy39qJ85Z5bZjCgAGmqBSvgVq3n7byaNvWgfZjg
         YPMInfJP3wvzO3IYXBLW7ekkxkqvUkIJ0/ZcVlVlRsSzZdmuIqSST4rdJq+9h0G9k+Xr
         l6o2iZOVViIPmj3hKhOz/MaQRXb/AhOfRbgqQXN1Ucj95jx42vtZvWkUOk1xMyxIeYYh
         wKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/fFwUTOq5TotVWM5uJztPWAemINo6V3+BKTxyGrVtys=;
        b=A10Y4f9FQ84YZZUFJAM/v4aer/lxAT30pv8x3jwzJE2+EpAdtA2SHPOH2fdRjG+uo/
         1/BOWiGb8Ss/XN5KVmIaGL8pmUDZz7Sd5oj6J9xtoFDX2tzV4wk/okljIt6hXGlJuJB7
         Ap6EmusqjpSEDpd9H9Kv98eVEzc817y31ZjHaqPKTpXI282q0BGYMlVbY7S7OO3sIxFx
         bH5PCA6K1tfAYS4wn42hN16IDjyYsyzSiCs2hj51ZSh8UVRHZS++6b/xlaq94lfYjqMi
         L8yXEa6A5YN4Tybn9GecQKN3lmrepXD0UF98/YoBga88NYZkpg6IQ0rDU+DKayZSp8B1
         aEgw==
X-Gm-Message-State: APt69E3FYDWvtx8fBoeTvMaH0k9tc5SNNTUxeK9QzSuVJUA/OSSYxLll
        pHTYGAcBzA65t3vr/MyamusSvWe/cco=
X-Google-Smtp-Source: ADUXVKI28s8I+EaQ9BRiDQYdJf8pp6vRz5PQ0jXv/zOyoE/sMlX7IIjq/owFwJop2hmfZzZg5Zpuig==
X-Received: by 2002:a63:80c3:: with SMTP id j186-v6mr10778181pgd.426.1529930762928;
        Mon, 25 Jun 2018 05:46:02 -0700 (PDT)
Received: from localhost (g134.124-44-9.ppp.wakwak.ne.jp. [124.44.9.134])
        by smtp.gmail.com with ESMTPSA id y4-v6sm3479214pgy.18.2018.06.25.05.46.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 05:46:02 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
        Eric Biggers <ebiggers3@gmail.com>,
        linux-crypto@vger.kernel.org, Stafford Horne <shorne@gmail.com>
Subject: [PATCH v2 2/2] kobject: Fix -Wstringop-truncation warning
Date:   Mon, 25 Jun 2018 21:45:38 +0900
Message-Id: <20180625124538.21051-3-shorne@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180625124538.21051-1-shorne@gmail.com>
References: <20180625124538.21051-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling with GCC 9.0.0 I am seeing the following warning:

    In function ‘fill_kobj_path’,
	inlined from ‘kobject_get_path’ at lib/kobject.c:155:2:
    lib/kobject.c:128:3: warning: ‘strncpy’ output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]
       strncpy(path + length, kobject_name(parent), cur);
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    lib/kobject.c: In function ‘kobject_get_path’:
    lib/kobject.c:125:13: note: length computed here
       int cur = strlen(kobject_name(parent));
		 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is not really an issue since the buffer we are writing to is
pre-zero'd and we have already allocated the buffer based on the
calculated strlen size and accounted for the terminating '\0'.
Just use memcpy() instead.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Eric Biggers <ebiggers3@gmail.com>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 lib/kobject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index 18989b5b3b56..e876957743c8 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -125,7 +125,7 @@ static void fill_kobj_path(struct kobject *kobj, char *path, int length)
 		int cur = strlen(kobject_name(parent));
 		/* back up enough to print this name with '/' */
 		length -= cur;
-		strncpy(path + length, kobject_name(parent), cur);
+		memcpy(path + length, kobject_name(parent), cur);
 		*(path + --length) = '/';
 	}
 
-- 
2.17.0

