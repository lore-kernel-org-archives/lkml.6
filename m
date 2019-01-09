Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61316C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21CAE206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7Md4U75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732269AbfAIP0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:26:10 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41430 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730871AbfAIP0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 10:26:09 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so3807036pfi.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 07:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FjXFH9uSRzujiRMaS950PRrwo1mjvIJuY8kYoFNs2BU=;
        b=F7Md4U75sv/+Ka5GBUBA86iZPsP5g5irdRw3/unQwTR7F8ToD82wVmVxXxxqIXIM7U
         +y8GZwrFekFGmLLW5BqKO9SXXGdZecoJrFnWIwXvNdb17+rG6O11cLZNBis5C1Ilguzt
         DJeGth/TAv5Pew/lDe/sz9SuffqJ7BVuwUwRe3dB8W+eSH4S3sIzQ8O/QPEvUnW24xg7
         nII1djLB8SWD1RvAXmcCRjN5njpxjQP7oFrXzNYZc2MU/2caevntXLgHBEtJViWMOKa3
         J4E8Rb9RULVJcyyes6sMHEjMFq2WR4030g10tNuRnr/ax0JptbOTJREAb7g8EgNIqp3B
         T+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FjXFH9uSRzujiRMaS950PRrwo1mjvIJuY8kYoFNs2BU=;
        b=QE166n1DvptUtY2f+KLHi+85GR1TIsbE+Cl9JNANPjcj8vBdqRb76ME8DfohrPWVVx
         2p/woBIKADr0FEsgelUeg5m5ddWTehNX/M87721t3GlCiTPoKUM0SZllQQLothJgXlKP
         6iHxMViqHs+xeDLP8Spgb3HkBvEe9vg9BdX1k3DCI69/BjYg+LsYdv78FTps6hcb05uU
         8BBs9ocoi/rvnt0j3ofztdhdYsOykrwTqn4krsSknOIZzxV2Y3lI2c6n0R0W6RfdLmWb
         Pw7lJ2zmkAaAT7Z7O23ADUmUoinEoSAMm3BmL6Zav0ZkN2OBarkf12zPwkEv3ycoxSop
         Q+NQ==
X-Gm-Message-State: AJcUukekhJbi5D1rdNZYjI4P3/dDRNoPRy7qULfCSlqWGeioO9nSTTD3
        3QKm7iq9iK4mFSEiAB6hpNM=
X-Google-Smtp-Source: ALg8bN4A5jTMBtjJ1khR0S8bIe73BYXI6US7yU4I8/tDTnbsQthPPqkaDrtsN0OBZmjyfFZNbPCvag==
X-Received: by 2002:a63:30c8:: with SMTP id w191mr3677976pgw.120.1547047568778;
        Wed, 09 Jan 2019 07:26:08 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([2409:4060:2084:97b2:9503:102e:b683:299f])
        by smtp.gmail.com with ESMTPSA id h69sm87574836pge.4.2019.01.09.07.26.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 07:26:08 -0800 (PST)
Date:   Wed, 9 Jan 2019 20:55:59 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org
Cc:     jrdr.linux@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
Subject: [PATCH] staging/android/vsoc: Remove duplicate header
Message-ID: <20190109152558.GA24243@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove linux/mutex.h.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/staging/android/vsoc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/android/vsoc.c b/drivers/staging/android/vsoc.c
index 22571abcaa4e..8a75bd27c413 100644
--- a/drivers/staging/android/vsoc.c
+++ b/drivers/staging/android/vsoc.c
@@ -29,7 +29,6 @@
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
 #include <linux/interrupt.h>
-#include <linux/mutex.h>
 #include <linux/cdev.h>
 #include <linux/file.h>
 #include "uapi/vsoc_shm.h"
-- 
2.17.1

