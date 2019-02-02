Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A9AC282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972C0218A6
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuwwOCjk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfBBAxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 19:53:34 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43573 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbfBBAxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 19:53:34 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so4041207pfk.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 16:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EN3amef8ZhHr5DcbmHgtOAbga/cCkXa0/i/rZcSMGvg=;
        b=MuwwOCjkKCw27szgEwc3xDNTAPFLsnTW81gV0N8EoZF5J6W5UxDNjMXV3oFwPBVKzs
         U+R7fHygTSggOJcBFmHiBCXj7/2nnGl0TRQ6pUh8KJHQdhe5RHIl3xa0ZEQtMW5lKBkx
         djEuTjHaM9uv0pUIXjPc7Pj+/e3/h1kXB3M6BqVjTqzdysFMpx0v7ZKNRVcOTgXKU4+/
         mWNDGr8FQYre4dvum1zCRvlRm5umbc8CLYOCudsL2KH9Ljfg0ZNOKiX8AqelIGVMGub5
         JmoqABit6zL9pyXFf0Tj98DEgTW0ewkI/C5VjKZUs/+jpE/dzYU4Vp2m3t9DT7xU9/2M
         MNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EN3amef8ZhHr5DcbmHgtOAbga/cCkXa0/i/rZcSMGvg=;
        b=YByTWd6GVi/Mtci3E9TzvsDcacBJCRrVzgZcdMP3vBrMJcdf58kUE43XkaLIW2ci9x
         oZbERw9GbeDriFkgxxJ0VSu0bkbi3lU/H7G8iJe2t1/adTP7DTe6q9JZVd5Hlvz1Xl5r
         MQArIdJ/HRI7mqPp3AtV3DOciPrCt2O6Fa3/TCKcZStNA1B8WM1z3GEy+BLsjhQHFUe9
         5kccD+hjBK51C8KgJKO75GK+aZ/Ovt4A7pivPOO33+kMsquKOA4l5qnc7w+OKG70bXxq
         SJuQT9jwQWjuchq2GCrA5PRcBx4c4LjbkZptAlT/02UXeSvK5rzc6HC0e7kvC0/cGktL
         LVfg==
X-Gm-Message-State: AHQUAuauVa0bpCMilcCx0/cRyGOEdrJfO9ELuXhneTQP9+I0fkBc21Xl
        31DaOznpMmLrOop2ORcTx1M=
X-Google-Smtp-Source: AHgI3IYdNaZG592p/7pnSmft2DvhisWxrCjcdoxGoFl+5Wl30o+4uA6gK9t+MB8HGPZ25bGauxvovQ==
X-Received: by 2002:a63:2b01:: with SMTP id r1mr4421622pgr.432.1549068813612;
        Fri, 01 Feb 2019 16:53:33 -0800 (PST)
Received: from localhost.localdomain (110.188.252.27.dyn.cust.vf.net.nz. [27.252.188.110])
        by smtp.gmail.com with ESMTPSA id r187sm33863764pfc.63.2019.02.01.16.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 16:53:32 -0800 (PST)
From:   Derek Robson <robsonde@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Derek Robson <robsonde@gmail.com>
Subject: [PATCH] aout: incorrct use of strncpy fixed.
Date:   Sat,  2 Feb 2019 13:55:12 +1300
Message-Id: <20190202005512.3144-1-robsonde@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Found a bug with the source / dest length
updated to have size limit as the size of dest not size or source.

Signed-off-by: Derek Robson <robsonde@gmail.com>
---
 arch/x86/ia32/ia32_aout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/ia32/ia32_aout.c b/arch/x86/ia32/ia32_aout.c
index f65b78d32f5e..1e7f71723ee0 100644
--- a/arch/x86/ia32/ia32_aout.c
+++ b/arch/x86/ia32/ia32_aout.c
@@ -157,7 +157,7 @@ static int aout_core_dump(struct coredump_params *cprm)
 	fs = get_fs();
 	set_fs(KERNEL_DS);
 	has_dumped = 1;
-	strncpy(dump.u_comm, current->comm, sizeof(current->comm));
+	strncpy(dump.u_comm, current->comm, sizeof(dump.u_comm));
 	dump.u_ar0 = offsetof(struct user32, regs);
 	dump.signal = cprm->siginfo->si_signo;
 	dump_thread32(cprm->regs, &dump);
-- 
2.20.1

