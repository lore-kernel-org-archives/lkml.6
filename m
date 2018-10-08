Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38DEC64EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A3F2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxcpCNRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A3F2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeJHOoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 10:44:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33020 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeJHOoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 10:44:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id y140-v6so8084709wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 00:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EdftAsy0TUXj+StkyoBelYkRpwruLsU2EYLwdbvmKbE=;
        b=kxcpCNRVS/HgfMxZK74Wmh7dvxRV10bBSqTghdGSYJ6PT5Bty7A03CvFm9O7Pw23tj
         cLX6nUI1eZKTaGnwOK0YSX5dBYuUybkQ+neUlr1HLwvYfxAJxIAGAW5/tNZgL/5twD+l
         m/vSOeXfM71A8Q/0tgtjrjDKAPGvYZf8kMRGXO1o0gan7ZD65CxDyqxtKaX3exuWdoE/
         UU9Sf7vb/0BQS4Jk+1Z0rV0qSXFbqlxzmrNIzT7sj9zz8EHQt7sz+sGG7NLT7E/JfSvq
         AU7exMK5RuevZyugPge+Q9q4nfm84pcd0pcrguGL/rwhA+MV8nMu1tzqia1Q294QIAMk
         XKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EdftAsy0TUXj+StkyoBelYkRpwruLsU2EYLwdbvmKbE=;
        b=OYS5YACVEQlkZIpJwXvJwP5FPLMS61s40psuWJY5iiFMzZotS5RW9/1u6fJ07PSgKK
         W2QpMKZkF3w2zOVVYyJDRv4TBBK9B0TjL9csEhuSi+GvLJNzbj1uuVkbwoqZYwIjeV/i
         KHARQSDjk9ToPRVLj9z/bYeVb7p8bh/NnBc/c3zMgh13RbVSJEHi3J8sJ1g5mGZeFtyg
         OuDJv5ByM3PWEhJrHTxMmXxptTsxIn55Q4Qrvpu5BJLtdUGjlK0H5+WKDGSHgVbCDo6d
         a0pLG2SzO2i9cRse3I2hked4ZZ67VYMLia1Oo2QNYC/3fdRzoMO4bFkL6ret2GzLsEmv
         Hr7g==
X-Gm-Message-State: ABuFfojo1Lvy5CEls0cg5d/Gt0kfwJ5k3Wz1O8/qUwYpby7hD6YsHeih
        dDUOtHlqo3PFrS44O9sgqYXsUvyEn/c=
X-Google-Smtp-Source: ACcGV63gF35cp9/KTM4VxY6IOhkhuF173J/tsmeLDmb6KhR8oZO9sMKrhMC3KCIK40/jdcFGQHx3Yw==
X-Received: by 2002:a1c:e388:: with SMTP id a130-v6mr13672515wmh.20.1538984020256;
        Mon, 08 Oct 2018 00:33:40 -0700 (PDT)
Received: from ltourlonias-VirtualBox (89.200.136.77.rev.sfr.net. [77.136.200.89])
        by smtp.gmail.com with ESMTPSA id 90-v6sm19876683wrg.86.2018.10.08.00.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 00:33:39 -0700 (PDT)
From:   Loic Tourlonias <loic.tourlonias.lkml@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Loic Tourlonias <loic.tourlonias.lkml@gmail.com>
Subject: [PATCH] staging: emxx_udc: remove unused code
Date:   Mon,  8 Oct 2018 09:33:36 +0200
Message-Id: <20181008073336.17362-1-loic.tourlonias.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove useless code inside if_0 endif

Signed-off-by: Loic Tourlonias <loic.tourlonias.lkml@gmail.com>
---
 drivers/staging/emxx_udc/emxx_udc.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.h b/drivers/staging/emxx_udc/emxx_udc.h
index 8337e38c238a..78fa60192a14 100644
--- a/drivers/staging/emxx_udc/emxx_udc.h
+++ b/drivers/staging/emxx_udc/emxx_udc.h
@@ -10,10 +10,6 @@
 
 /*---------------------------------------------------------------------------*/
 /*----------------- Default undef */
-#if 0
-#define DEBUG
-#define UDC_DEBUG_DUMP
-#endif
 
 /*----------------- Default define */
 #define	USE_DMA	1
-- 
2.17.1

