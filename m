Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2E3C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 05:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A9223D8D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 05:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yg37qxyw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A9223D8D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933319AbeGDFwn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 01:52:43 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46548 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932871AbeGDFwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 01:52:38 -0400
Received: by mail-pg0-f68.google.com with SMTP id q14-v6so2003182pgt.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 22:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=GZz4DRmTIW6WvmzHIyWd+RqB/C3fKPGmRA84caE+HLU=;
        b=Yg37qxywG8NkB0VyXepfsm+NZUegWYwnZfU24aOIxYgHL3fUjaywqT1+t6mcIy8u+2
         6nm78fkRnHfSAW3Ens27C3OKrBgXSOqLsDD+uOdHfTwCmo28trz0quEL4iSk267ubMVt
         h2QJ/jvkRwT7fJwDrSy/Y8323Rfdma8irl3gU7UWbXdxD8eYqIkFJTE1dFn4l5aYA2XJ
         ZYgZOvLTzMLSH2UkrwD13SfzDOY82Yr4RbBrdGUbfIxa1UUeILNJkkeDBOov8poUUOzH
         xV1bp5Gyh7YqSKb91LmUiOndtsgRJfp7uxombp9g8hugiabHkZuKmtPz0uF6w2A4HJnc
         CR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=GZz4DRmTIW6WvmzHIyWd+RqB/C3fKPGmRA84caE+HLU=;
        b=XXvWDf6AOozyzGLacGIMKU/IyHRiSxyVhHVxvT+nHoVg6+oOUSjp2wQ5MokgrE1Y2t
         ov4jnDL6shbmBzb8KlftPvQ+PvgyxGNuCxGiym572TOhylIIg4WQk3nCb7IrQAA1JrX6
         2cm2U3OuHTEj2dEy9Z5ssQ/y/RsIXg1td7eN9G0EzSMaAXMfsxrDSwESSdFe4PKlNchP
         SCWnwdaX2utctc2BNq77kE3uih4Yf14rp+HTbOYZm5SmvmnmAA1uwgrSEXuGSB92rJLv
         zQLbhpSpnhbLaoDmBZyTdBnbCuyQGJZbddumsn1mTLB7BVoiFqJuzq2r05wzYYEBQhYV
         xm+g==
X-Gm-Message-State: APt69E1dvVWYiH7J1w14SSOQIv1lq/mPBGTqbTwFDFiO1TsOu3jDpADp
        Zn8hfpfRkdt8WrKuYfrric8=
X-Google-Smtp-Source: AAOMgpf8Hl0vAtRz3LzoagfjnZtIYXQDWG7W3ZuJohZtpIEE3gtJl9Gt0yJf2maK3Elq/+cvT2+YTw==
X-Received: by 2002:a63:4d5:: with SMTP id 204-v6mr624093pge.129.1530683557429;
        Tue, 03 Jul 2018 22:52:37 -0700 (PDT)
Received: from app09.andestech.com ([118.163.51.199])
        by smtp.gmail.com with ESMTPSA id b22-v6sm4257226pfi.144.2018.07.03.22.52.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 22:52:36 -0700 (PDT)
From:   Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To:     greentime@andestech.com, linux-kernel@vger.kernel.org,
        ren_guo@c-sky.com
Cc:     green.hu@gmail.com
Subject: [PATCH v2 2/3] nds32: Fix the dts pointer is not passed correctly issue.
Date:   Wed,  4 Jul 2018 13:52:09 +0800
Message-Id: <6897e6ecb3167598cb45e1a1424dd4d5e3778837.1530683430.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <f706abf188a82c9d961ed267a18ff5cb5e9aace9.1530683430.git.greentime@andestech.com>
References: <f706abf188a82c9d961ed267a18ff5cb5e9aace9.1530683430.git.greentime@andestech.com>
In-Reply-To: <f706abf188a82c9d961ed267a18ff5cb5e9aace9.1530683430.git.greentime@andestech.com>
References: <f706abf188a82c9d961ed267a18ff5cb5e9aace9.1530683430.git.greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found that the original implementation will only use the built-in dtb
pointer instead of the pointer pass from bootloader. This bug is fixed
by this patch.

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/kernel/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/nds32/kernel/setup.c b/arch/nds32/kernel/setup.c
index 2f5b2ccebe47..63a1a5ef5219 100644
--- a/arch/nds32/kernel/setup.c
+++ b/arch/nds32/kernel/setup.c
@@ -278,7 +278,8 @@ static void __init setup_memory(void)
 
 void __init setup_arch(char **cmdline_p)
 {
-	early_init_devtree( __dtb_start);
+	early_init_devtree(__atags_pointer ? \
+		phys_to_virt(__atags_pointer) : __dtb_start);
 
 	setup_cpuinfo();
 
-- 
2.16.2

