Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE63FC64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A60221848
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="kTHTg9QA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbeLXPze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 10:55:34 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:33810 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbeLXPze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 10:55:34 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 674AC5B0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 15:55:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zObIiM0SVm0k for <linux-kernel@vger.kernel.org>;
        Mon, 24 Dec 2018 09:55:32 -0600 (CST)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 406F6B8A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 09:55:32 -0600 (CST)
Received: by mail-it1-f200.google.com with SMTP id k133so14255362ite.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 07:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gsAi35npPSIav7ntIXZhvzpmSLjKeqgNRU/IzLhneq8=;
        b=kTHTg9QA66FNh0b8HaIGFYjrQ9Kuw3owPTW4FBNgTqeXtYwHzj+SGWt1XCypiY0udD
         z4xohAFMKpo5LkxqNVtmDjT8gygyZwp/i8xzQlseAYHonv9GRul9OFY1v3HwaJvaC36Z
         nXXvzMtNKyrJTwP8A6roryKJpN9zAfOSKh3l64zMSKmfR3c6BGhrhPESxHxE1T6XZeKc
         ks0DJTIEtrtbIsaverigvXCMf2v9Jplw6fBXzOxvwMJiUFH/MkojR5ZnRaGholsnvpRx
         V+cfclmdo2eyMvYhSflVw2x7Ez27VYMYtCfpLzeDGDEZbuJHZYkzrKIa+Wh8e5F/VQVA
         jtzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gsAi35npPSIav7ntIXZhvzpmSLjKeqgNRU/IzLhneq8=;
        b=oG5JjaTBKeDnqvo5SdCR5UOXOBH39TyFN1EC8zR8/IievWwNJ+iNfMKFLbLjYmo4Uw
         KCjhYxRhaDOVqG/VDok67bu2jHiSBcj+De1BH8YSnORIYq6xDMAqfrzCwA/pblVL08Xs
         hbI/OYaH+yfIMz3at5Ux499Spn6Z2+2Q+HgxX0K+XZ1hctm/iwFjFaDCbvG3APfdj9lW
         VNcmYSL2jZTivzyWuv5Y4TY8AlEmUnxztpPwPofQJkokcbgpBMBYPVyqlbDTJieAdSTE
         iQ0VSKZYtKifHR6cqXgwwP4UWFyIcGO+bPEIfZYqrXq7sunvh8/ehGfW1dTurMADj7HU
         qJQQ==
X-Gm-Message-State: AJcUukcKUlSX5RAbojIXOWY9wN09ZXMhU3ryn1tMJsSz89DB29fQnghh
        wqc8tqhjM/T5vIu+bkBzsFZ0cgyoGVTFmpbQJ8CGRfljFoRDgQD+Wi+ffZAfXA4+A0nbsTbZiz4
        RmNeGF+vQMWKtvWm7j9+qST1y1ZU1
X-Received: by 2002:a5d:814d:: with SMTP id f13mr1297462ioo.90.1545666931859;
        Mon, 24 Dec 2018 07:55:31 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5w9PoMTN+CT+hvlcGLDK+rIk3F+erHnaEyuph0RIbo8Se8nk1PqmQmLzHC18xwUBF5p8yH1g==
X-Received: by 2002:a5d:814d:: with SMTP id f13mr1297451ioo.90.1545666931629;
        Mon, 24 Dec 2018 07:55:31 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id v19sm10760220itb.0.2018.12.24.07.55.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 07:55:30 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Aymen Qader <qader.aymen@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rts5208: Add a check on the status of ms_send_cmd
Date:   Mon, 24 Dec 2018 09:55:12 -0600
Message-Id: <20181224155514.16455-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mspro_stop_seq_mode(), ms_send_cmd() may fail. The patch attempts
to detect a failure before flushing the registers via rtsx_write_register.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/staging/rts5208/ms.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/ms.c b/drivers/staging/rts5208/ms.c
index f53adf15c685..04b588b8b376 100644
--- a/drivers/staging/rts5208/ms.c
+++ b/drivers/staging/rts5208/ms.c
@@ -2586,7 +2586,9 @@ void mspro_stop_seq_mode(struct rtsx_chip *chip)
 
 		ms_card->seq_mode = 0;
 		ms_card->total_sec_cnt = 0;
-		ms_send_cmd(chip, PRO_STOP, WAIT_INT);
+		retval = ms_send_cmd(chip, PRO_STOP, WAIT_INT);
+		if (retval != STATUS_SUCCESS)
+			return;
 
 		rtsx_write_register(chip, RBCTL, RB_FLUSH, RB_FLUSH);
 	}
-- 
2.17.1

