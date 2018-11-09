Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A427C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 04:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D0420840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 04:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwlhyNFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D0420840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbeKINxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 08:53:13 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45946 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbeKINxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 08:53:13 -0500
Received: by mail-pf1-f196.google.com with SMTP id p17-v6so311958pfj.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 20:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=evrj2d5VpGDfMVcLyE5779uE47xmcWk31UlkEPrl0DE=;
        b=LwlhyNFwdYZ7chgZRCtv/TuwbTXQQntgIrSj4HnMGG30zDM5pjEghme326GqD3D2O1
         3cT9ZIs9U4K4eC9WY5DfbfNJRZNNhwuK2XiWZOD386umoN8CmnrLInkuQZHbJik3XM9H
         XSkv67P6XhjErrksfhBJFRSpslphP5ABehtwrzE2bVtOEMTZhC5syM7WApsdNgJ+JCKj
         jL4tkDNebomM+C2qRod98qu4d/e4EWDbD5/GG8gblssmTyFXE4mDnrV+93XYBSeNfHFK
         yPh4vYuA3piHbm9Lsp9CO5BYqAPB9CjoA/KBfur10bFwce+QqcnnMBrLYlhHNIgiDjXj
         5YJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=evrj2d5VpGDfMVcLyE5779uE47xmcWk31UlkEPrl0DE=;
        b=GL6W8YMBImthnvsnmQO1DVPzk0TSA3OXiojW5pO8k4EXTRWLDD0WIr9C0+wZsL+ffE
         rKHcEQ276UOoAtRbxdIXPrrN/b5T2RPKCkMXP8KTrq9rqOtUYLFXFN6nGiYGWzT58MWZ
         MK5Xzi8S8akxEy1WOPduoTPo4kUmc9r15c1OiI1u4c1o2qNWt4INiRtT68QPSE2OfDDm
         ihwu8oK2H6IR2npTYyWn3IAXtunwfnnHb5JyRfKcl+2sVo8v3Ialw3Rtre8j1raXnMM2
         HEf/LNBv2zeAmupuDzzjnKSB3IR2GJQ0/AmqOysMfeE7rXPKQWb5z+7wkzE3qBtgDcO4
         qvfg==
X-Gm-Message-State: AGRZ1gJadj1GLuraOyW00ysZ2cQRSDxgWG/gK1njaI2Izdkfbr5WVnz0
        qOi1N9O0MOKGU48SPDZgtls=
X-Google-Smtp-Source: AJdET5dds3pgwfUWb5Ds2Ifh6pIQcKxcT47jCNSSLHZxRVr8E2svzV1ua0P3Y567JKNm6zDo7j8tUQ==
X-Received: by 2002:a63:c70a:: with SMTP id n10-v6mr5995985pgg.431.1541736868768;
        Thu, 08 Nov 2018 20:14:28 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([45.251.61.32])
        by smtp.gmail.com with ESMTPSA id e2-v6sm4552041pgv.25.2018.11.08.20.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 20:14:28 -0800 (PST)
Date:   Fri, 9 Nov 2018 09:44:25 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org
Cc:     jrdr.linux@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
Subject: [PATCH] drivers/android/binder.c: Remove duplicate header
Message-ID: <20181109041425.GA2950@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove binder_trace.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/android/binder.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index cb30a524d16d..719f35a5c04b 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5852,6 +5852,5 @@ static int __init binder_init(void)
 device_initcall(binder_init);
 
 #define CREATE_TRACE_POINTS
-#include "binder_trace.h"
 
 MODULE_LICENSE("GPL v2");
-- 
2.17.1

