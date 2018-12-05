Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3126EC07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2EB720850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAV6r52B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2EB720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeLEBmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:42:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36585 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeLEBmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:42:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id u3so17925078wrs.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 17:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W0RQ4W4GOIgM92/vcDV5u070gtrTghilwsK18K8ftuM=;
        b=KAV6r52BSoydvVh/fT6UYReTo+kUH9aGLV73C9LyFs7zzAuiD/b5Tj/ElJU6idKQcU
         uLvLp8noe26vFTeemlaDo5o28i1UPkazxNfQrTahTSwzK5Po+vItbFSz01crEOq4TqAL
         4oNvxN+vf0AjU0/HrW2SeZaq71aZQMvlvlBbNgmePe0O4hV81bxTaA6qmdrglP3MOEEc
         lAmZeiXr6tbhoIYBv2h1zR/6MQhqc8/1wRGgVx/OZMXXuLlUjKNeM2Q9Xz3Kz6jm9ya3
         PFW1fAHojr/aEkpl2tN1jIaD6INmZ9rgglnnegFJbAMq5gvarmvlxJ4Li5+ApNXSycas
         lFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W0RQ4W4GOIgM92/vcDV5u070gtrTghilwsK18K8ftuM=;
        b=ay+rg21A1qAlBV3BvXlqL3gzOP4uXLTUBVOOdqMYP+yfd8Fl1lSXBk3ukDGsMnEls8
         35cdumvDT4JZTfYdWFrMXoFNRDTgle6Dcr679A9yBvyxHdA90H9ZWGbsrVUWxl3rtf0f
         yN5Yrq8mLbbUbZOTXY/7rZcrQVxtXYmzoOsyPP5vS6jVVt3cZIubdru/dcH1wwFUPxrx
         Gf3w/hr0P+My1yXzX45sVfI0A+aU7Km6H3XrLi/vOYZJwdgis7W7SauX6iqlxI1naYvO
         7lSdL1fwNb/RtKrrwaFIdzuezxKswNT9F1rqB2fGwmylznJlngei6Bwc9KWls6xtgeGS
         R9SQ==
X-Gm-Message-State: AA+aEWbERWTyjqzPWHldEkNx96h0X0z6ITGt/4MpsCAuGtCri1wMhu65
        Y9JpB+jbW+ccFupaXI/Olsw=
X-Google-Smtp-Source: AFSGD/UeihGXAfdhJOnkYVqMFj/b90JXNt4Mlsw6T1Fj23zeKRfG11Fnpnr8k7mtCm8Ympnnlph5Tw==
X-Received: by 2002:adf:d1d2:: with SMTP id m18mr21026171wri.138.1543974154263;
        Tue, 04 Dec 2018 17:42:34 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id b7sm15845784wrs.47.2018.12.04.17.42.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 17:42:33 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 2/2] ARM: Wrap '--pic-veneer' with ld-option
Date:   Tue,  4 Dec 2018 18:42:13 -0700
Message-Id: <20181205014213.943-2-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181205014213.943-1-natechancellor@gmail.com>
References: <20181205014213.943-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This flag is not supported by lld:

    ld.lld: error: unknown argument: --pic-veneer

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/arm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index e2a0baf36766..4fab2aa29570 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -10,7 +10,7 @@
 #
 # Copyright (C) 1995-2001 by Russell King
 
-LDFLAGS_vmlinux	:= --no-undefined -X --pic-veneer
+LDFLAGS_vmlinux	:= --no-undefined -X $(call ld-option,--pic-veneer)
 ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
 LDFLAGS_vmlinux	+= --be8
 KBUILD_LDFLAGS_MODULE	+= --be8
-- 
2.20.0.rc1

