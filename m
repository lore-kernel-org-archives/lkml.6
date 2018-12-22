Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EB3C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51B721A48
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRwgTR2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391254AbeLVRVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:21:00 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46654 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390141AbeLVRVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:21:00 -0500
Received: by mail-ed1-f68.google.com with SMTP id o10so7168317edt.13
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 09:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oAZc1TB5VIllL0LN1ysvCnLYLA4BeXi1PNyTKAVFtNc=;
        b=nRwgTR2aEhUB9nLKbgAWZJ7SEDEJzvPB9ayf+i5kq9qDuafD3eqHIa2SrNkGbeSxHF
         xbdVe0LJ5Sw2gsfUypYWOsM1IlKloODzwCkN2HP5Sj+A1hllyLEjk/DWta9m+E4H8fod
         ahNaABKV+F83sq7D4QrHwuZhdGlge90MlOOR1EJhC8+Q4VSEXrbFY6oCsRQfQplEgUmr
         NynNd5dDYaKgUYhJ795G2kO4hwwdfrF6NYeAUvgXSH+GCFCGFbB+m+df6gEczqiLuWHa
         iXn1X2V4rII8/GCCONByK9j04QxgfCOEFWfFhWD56aHYJLJ2amSmnS2tuWaSpBgn51Xx
         Xn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oAZc1TB5VIllL0LN1ysvCnLYLA4BeXi1PNyTKAVFtNc=;
        b=XcdN4cznoAoo22KuCDA3kH8fX4/y52gVB1k+Luxo+g+hb4cjv2k+DbzzV3UR6DHpZK
         w18E0zkbjNo2Y/GWVhvrViZNKsscwNJlb+YhszfPtRxUod1jlZmmJPQNzaa8oR3xBYrr
         3gS+DO+eCgwL931W2uwy4W7PrazuRuaJ2cQl5/Td//pZQZpn4QkQUl82UNoxjbmKmLsZ
         q1U2jgMLduqqwZjj/O+h8kUW+gl6DHlQBrXHnqgpuv9J6A7EL8rWTtH7Gcr1MXccQ1MP
         1EaxpyKcn1S2+9e92IKrUHWCKetMjPJDcZbzAC/QfVTWhP4FINlx2s0rrcegOkSTZpR2
         vuzw==
X-Gm-Message-State: AA+aEWaykNeLTyQkLpuSlIp7eRY52sNCxiCwjVYrV6BdWylNthzHuvtj
        YGnPJh5daAdsflsHtvINAY++3TGXWBI=
X-Google-Smtp-Source: AFSGD/XDcCS2/A9R+5PYWzFtGyBz9AMK55Lj3Fhss5oHDPsz8ST+VqljKAGFIWdy31jrJqdHrE75AQ==
X-Received: by 2002:a17:906:815a:: with SMTP id z26-v6mr4252597ejw.121.1545473019697;
        Sat, 22 Dec 2018 02:03:39 -0800 (PST)
Received: from bebop.suse.de (189.26.183.192.dynamic.adsl.gvt.net.br. [189.26.183.192])
        by smtp.gmail.com with ESMTPSA id jo7-v6sm3986162ejb.12.2018.12.22.02.03.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 02:03:38 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <jbacik@fb.com>, Mike Snitzer <snitzer@redhat.com>,
        Michael Callahan <michaelcallahan@fb.com>,
        Omar Sandoval <osandov@fb.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH] blk_types.h: Use REQ_OP_WRITE in op_is_write
Date:   Sat, 22 Dec 2018 08:03:54 -0200
Message-Id: <20181222100356.559995-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of just using plain '1', as it improves readability.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 include/linux/blk_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 1dcf652ba0aa..905c666a0101 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -377,7 +377,7 @@ static inline void bio_set_op_attrs(struct bio *bio, unsigned op,
 
 static inline bool op_is_write(unsigned int op)
 {
-	return (op & 1);
+	return (op & REQ_OP_WRITE);
 }
 
 /*
-- 
2.16.4

