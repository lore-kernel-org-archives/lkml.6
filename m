Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87746C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514BF20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJV/Erow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbfAQQTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:19:10 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42676 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbfAQQTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:19:10 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so4644615pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=Yh3qbiGpjxaAJvITh5Ss6ioubvpHOgUYQyUYAdIiPdM=;
        b=eJV/Erowm0GeLQUDSuaKn+WZQlg8KAmrehnq+7XT3qou8SYUM//b6DKII+2vELxhkX
         lMWnN3vmHE7MQKWnzqc1TacQO+Vm5lvmw2p6YMTJT0gRhj+BFKL5qXq2o4RuvrHhWAcE
         9F4TLqQOcHyDJa6oGchO3orqWBbBttgQR+BjmRzWkdFKpUchRnFyJdYjGZ+5s3bYfOTB
         S16HKt58iQ9pDIfNyhGI+oDzQNK85nXnh9zWWxl68RhOsSjwOaSvcsikQtzi3goPGO46
         t6Q4+oo+YYt7lNoBX82eVvc2ivLtSPHV2OctaBcJtj9KXo9VjAB1iFryBrNtYq3G7quW
         sobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=Yh3qbiGpjxaAJvITh5Ss6ioubvpHOgUYQyUYAdIiPdM=;
        b=cwkFmL1o1+y9fHoPNybpK1f2Z0XgNm4vKXUX3jVDT55G8f3+uf5b6dThAo8tvrVGtT
         MeK1vBgkK4HL++ZkXyoK4PvgYVYaYCA3P/yzauDX0eRDkstwcIzn5rh3Ku0Njm1vB8KR
         R5gKkpsAJfUTYZaaHjIYSUXjtHTMcync42sJxgsw+04tuY0Sdm/kd6oTL5+EigOk+Y2r
         DQJdQzmu5gdGL5AiIewu+aha+28vnmyTsPRuF1KS4lnYRKxE2lvL8peQC+s3aFZR7Vs+
         Ou2+g97yTNI2aC4LSrubl1smiRcUVMGWEvtm1OBNkBZkklfaBRXPDTtA0nGYRMSB5xrj
         3Ryw==
X-Gm-Message-State: AJcUuke9Aw/48kWSYbbr7nPd7n3jSwiB3dUSr2RxHJ6zoLFKLRuyZBm4
        QxnPzD0c+u0ErTQ5MXwsSsw=
X-Google-Smtp-Source: ALg8bN6VcP5mWImeZ6h4043pxQWpbLnjO4dFoF5U+cwY7XL6VflxbmUugfVG8vV96byvGm5u1Z8szA==
X-Received: by 2002:a63:790e:: with SMTP id u14mr14051254pgc.452.1547741949572;
        Thu, 17 Jan 2019 08:19:09 -0800 (PST)
Received: from sabyasachi ([45.116.191.230])
        by smtp.gmail.com with ESMTPSA id z14sm2576929pgv.47.2019.01.17.08.19.08
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Jan 2019 08:19:08 -0800 (PST)
Message-ID: <5c40aafc.1c69fb81.a0ba0.67a7@mx.google.com>
X-Google-Original-Message-ID: <20190117161905.GA23274@sabyasachi.linux@gmail.com>
Date:   Thu, 17 Jan 2019 21:49:05 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     arnd@arndb.de, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au
Cc:     jrdr.linux@gmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
Subject: [PATCH] powerpc/cell: Remove duplicate header
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove linux/syscalls.h which is included more than once

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 arch/powerpc/platforms/cell/spu_syscalls.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spu_syscalls.c b/arch/powerpc/platforms/cell/spu_syscalls.c
index 263413a..b95d6af 100644
--- a/arch/powerpc/platforms/cell/spu_syscalls.c
+++ b/arch/powerpc/platforms/cell/spu_syscalls.c
@@ -26,7 +26,6 @@
 #include <linux/syscalls.h>
 #include <linux/rcupdate.h>
 #include <linux/binfmts.h>
-#include <linux/syscalls.h>
 
 #include <asm/spu.h>
 
-- 
2.7.4

