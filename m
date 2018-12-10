Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9AFC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BA120855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n1aPwoIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80BA120855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbeLJWfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:35:23 -0500
Received: from mail-it1-f201.google.com ([209.85.166.201]:33853 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728875AbeLJWfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:35:23 -0500
Received: by mail-it1-f201.google.com with SMTP id j202so6565723itj.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 14:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iZS1+LevQGNc8sV2xBIttuqt0fcxmPyoSK7pA3AKBWA=;
        b=n1aPwoIOFCfUOmjxz293ilOtKGUmcnKtnfapBoF01YV36p/oHrRiRq4JLDidyh3EZw
         lJm7Im8HRNoD4VleiniQCyRcc3vksq5Zb1DV8if6RiB97DxIsrezTkdkcE5SrmH5DEvz
         iZ95GjNHZgpvhV2FvbyYEo+TNvTYsq/3gg9JFz+oP0/P9W8ANTjrV0ErEyGOZRlaPYNi
         gzLCFkngvm/zBZ+N15VBVF3IalfXh+PSS7cyVmO+NmzYUcQv8yk1SzOf90hnUOGVFkKZ
         xmtR3BQbnyI5xyyUa6XpI4kAa4BF/5F/G8AMVoZvX5KjYF3e7rkWay7ZDMSdw3n5giOT
         aCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iZS1+LevQGNc8sV2xBIttuqt0fcxmPyoSK7pA3AKBWA=;
        b=YXnwnjEfNAe3fOpL+43TLfGCEPETEcVDABER/ZuFkwiCUm0Vo7oQ28p786b3FjyDJg
         upRN662YW2defjF4bod6H2juL4WaFlm8rcbUvWvzreMzQqmTpMa+ZaPDUGidFVELphsm
         4e/fW1w3csuYZ4gLFltXzkoErQC/5BkMT0UZn/KKv5VZ4sD1nOOEHCPJ5ybN/EvpJZXk
         rOjrptbxFn2OmS0eJ7M9ob/ADuKMZfb/yGCLlt6StIwmVDhADTny1Q2Sou3GAHja1/Ac
         LVZGjuVW1/VlhrbrCSMi0Ltg11NHUQmPbpAcqO5VxMBzC3UjFE+e71wD326go39ZTc8U
         D9bg==
X-Gm-Message-State: AA+aEWbDKafciNoLLyLSxHbyJFglGOgyrvOgEQszEM4Fv1Z3frE5RiOX
        mBAr+xrmHfr9R6XIEcK1zw+9sUx4kPo/v2/xumw=
X-Google-Smtp-Source: AFSGD/XaQ7OnV1AtzNo04mZ+bC8g01SwyU6wU7vNjvz6OqZozYTIk7AGpJ6aBLvRPNSlQHDfY892zcFcm9hy/ubRroM=
X-Received: by 2002:a24:1c87:: with SMTP id c129mr178810itc.11.1544481322152;
 Mon, 10 Dec 2018 14:35:22 -0800 (PST)
Date:   Mon, 10 Dec 2018 14:35:13 -0800
Message-Id: <20181210223515.26332-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH] sparc: vdso: Drop implicit common-page-size linker flag
From:   ndesaulniers@google.com
To:     davem@davemloft.net
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GNU linker's -z common-page-size's default value is based on the target
architecture. arch/sparc/vdso/Makefile sets it to the architecture
default, which is implicit and redundant. Drop it.

Link: https://lkml.kernel.org/r/20181206191231.192355-1-ndesaulniers@google.com
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/sparc/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index a6e18ca4cc18..74e97f77e23b 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -34,7 +34,7 @@ targets += $(vdso_img_sodbg) $(vdso_img-y:%=vdso%.so)
 CPPFLAGS_vdso.lds += -P -C
 
 VDSO_LDFLAGS_vdso.lds = -m elf64_sparc -soname linux-vdso.so.1 --no-undefined \
-			-z max-page-size=8192 -z common-page-size=8192
+			-z max-page-size=8192
 
 $(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
 	$(call if_changed,vdso)
-- 
2.20.0.rc2.403.gdbc3b29805-goog

