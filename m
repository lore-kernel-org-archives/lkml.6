Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979ABC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658F82082F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PL+qO4BS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395288AbfBMWnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:43:09 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39626 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395143AbfBMWmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:42:16 -0500
Received: by mail-wm1-f65.google.com with SMTP id f16so4162047wmh.4;
        Wed, 13 Feb 2019 14:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=ktrl99/4+i4VLz6USppssXo49kPq9nmcbGTF0KLoSBQ=;
        b=PL+qO4BSrqbTBZVvQdKVfuy3/R+TSzmQVsSmPWSD0nYfCQOw4/ftFDGqeAZGSDmsrD
         gp5dGhCLQjbXWBv2zPEel7ZGbFiiHXKIek08yxjbI/8bRXIXLDgV3glT33iw2UZwlzF6
         ZWtW7gYc5MVUhpPAtUuhRfoed2qyAVf+Nntc5wC3H4/s2pYobeRt0viKWP7Txq5JAUgK
         zb27BPlMpvk46SWw6eK2V2YyFXBJnAP8jjBEEB5li9V5UUDTFf3bDWz8iq6hJrbY/pXp
         KcT+ffr0v8t9+4SCEJMuLmWpGXbPjoJa2FgJQJ6vmf7fAQnr6F1cclKwU046m0j6BDC+
         kczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=ktrl99/4+i4VLz6USppssXo49kPq9nmcbGTF0KLoSBQ=;
        b=XQJDsWHJ70paOH35m8UtAKoFRkOhc4C/F4kbCptJdzC06Kcri4FLoIJ/FTFPV50RZw
         xz9E1rdeB0NkasM2wY9WqD3HzeFM1hNzkB0iD3McFBm2oivPwELpbz+cR/6OhxbTyEZL
         5133AXHqqFj2mlxRLWI/SZqxCPyBQLSUUUMCpWEBm6mMno6QL1LETRRzgYLH+IUKETvG
         CbN9gM+LjMtEwHK5ogjjRMlzM7npgL+aFSIHyhF9tJlUlYV1Cbl8+Xc44im0zXh9/fIk
         pEbh67joQDeQTGMLmDugWyfSwhtWvaKobWFM517hqQK5CYmM9+9AXGeRKj325yCdzO1j
         GnLA==
X-Gm-Message-State: AHQUAuZZscDRAAbj2LTh9xrOtRqDULcf1yM0AnplsUXAXjvQ5nl4hwtG
        WOZ8PhdRw6QbGKKYaEtjy9g=
X-Google-Smtp-Source: AHgI3IZgZPIjnSp/dGfR7iVH0dIRhuCCwStYtqJDhnVvkktzfFNDDUM47bqA//xCjlNKL+dEg6bIOg==
X-Received: by 2002:a1c:a58c:: with SMTP id o134mr259360wme.79.1550097733324;
        Wed, 13 Feb 2019 14:42:13 -0800 (PST)
Received: from localhost.localdomain ([91.75.74.250])
        by smtp.gmail.com with ESMTPSA id f196sm780810wme.36.2019.02.13.14.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 14:42:12 -0800 (PST)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
Cc:     Igor Stoppa <igor.stoppa@huawei.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v5 05/12] __wr_after_init: x86_64: enable
Date:   Thu, 14 Feb 2019 00:41:34 +0200
Message-Id: <c5838cd211a1648f44e0c2f48ab5bcbc1387cb8c.1550097697.git.igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1550097697.git.igor.stoppa@huawei.com>
References: <cover.1550097697.git.igor.stoppa@huawei.com>
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set ARCH_HAS_PRMEM to Y for x86_64

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>

CC: Andy Lutomirski <luto@amacapital.net>
CC: Nadav Amit <nadav.amit@gmail.com>
CC: Matthew Wilcox <willy@infradead.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Kees Cook <keescook@chromium.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Mimi Zohar <zohar@linux.vnet.ibm.com>
CC: Thiago Jung Bauermann <bauerman@linux.ibm.com>
CC: Ahmed Soliman <ahmedsoliman@mena.vt.edu>
CC: linux-integrity@vger.kernel.org
CC: kernel-hardening@lists.openwall.com
CC: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 68261430fe6e..7392b53b12c2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -32,6 +32,7 @@ config X86_64
 	select SWIOTLB
 	select X86_DEV_DMA_OPS
 	select ARCH_HAS_SYSCALL_WRAPPER
+	select ARCH_HAS_PRMEM
 
 #
 # Arch settings
-- 
2.19.1

