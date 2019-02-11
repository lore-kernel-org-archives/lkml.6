Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E64AC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8112184E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERfk6YwV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfBKX2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:28:23 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40175 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbfBKX2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 18:28:19 -0500
Received: by mail-wm1-f65.google.com with SMTP id q21so1011905wmc.5;
        Mon, 11 Feb 2019 15:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=ktrl99/4+i4VLz6USppssXo49kPq9nmcbGTF0KLoSBQ=;
        b=ERfk6YwVVFsD4gpa86J3tNvUf/jRxA7negb6JBcQ5PSR0xZZvMMbnqTZ+wRrS2Husj
         Ggd8+h/Q6iGpIBl92FmkpdpssV2xt9w6MiuQS2cXjMtk96NDjzsy/uEnc/s7yXVpuL6c
         mpoDNWR+cp0zbAXtobA5UoCkq+orGEc1HmBwrLmgLHRuHzaFQ/+tRBnFd/U7BP3qfbPV
         ln/K1BHTqeaHXoV9cT0aGU+M7Xa55XRzuBeoCYotqmiST1osgENBFvz37ywgrYEko+pv
         OnWJ8Rdek3QLL7gzQPr7kKm7jyZ28jH2jgCwj74BAERzhEIIn+YrVvRGcUeyx16kqW+P
         hxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=ktrl99/4+i4VLz6USppssXo49kPq9nmcbGTF0KLoSBQ=;
        b=lHJWLCeHp0lGdGBygwPydCBfhtHc1dc0YGDyDvXbjbE92y3GMEYLvPp9UChlAqNpK2
         7tGdQQHBeKFkrAjep/uR/aMvB8OsxxncSIZlgkabTQauao0sUIZ5z96UB/JCaYJ2ikA+
         8Ajwzs7LkB16+O0MuMTK+aW/x6p+eHJATlct1o/DwBoUo8e4SQAeaG0iJHaKDDEahpoI
         HtAJsZ8tlDDKWtOnpbZFut7m9qAtpFY7wLwBRf8gF+j1dr3oOF4Rpj6gb1v8eRNrE2Cz
         bsuCBh8qtmfG4lc6iRBTNKjXI6mi0SMjuN5Wk6yyl1IVSkzMhCOdL9fgoUdHgo4N4GSW
         3eDg==
X-Gm-Message-State: AHQUAuZBwEwTP65o5Ut/LLtwzuFMMW7sj4YdCTjZxXNwTSH4Jw7fF1Ko
        Q/lBd1FRdJt0WRSZfaqwAws=
X-Google-Smtp-Source: AHgI3IaPnxVvWxLjhqm0PsH5iF2NiueH7C1Z1h4hq25QVvV24PnbiOHB8xirGOEnJlaL7jk97tS8SA==
X-Received: by 2002:a1c:7719:: with SMTP id t25mr513964wmi.7.1549927697736;
        Mon, 11 Feb 2019 15:28:17 -0800 (PST)
Received: from localhost.localdomain (bba134232.alshamil.net.ae. [217.165.113.120])
        by smtp.gmail.com with ESMTPSA id e67sm1470295wmg.1.2019.02.11.15.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 15:28:17 -0800 (PST)
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
Subject: [RFC PATCH v4 04/12] __wr_after_init: x86_64: enable
Date:   Tue, 12 Feb 2019 01:27:41 +0200
Message-Id: <38307f2c7ae982478d33f55f7a7b827de489cdf3.1549927666.git.igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1549927666.git.igor.stoppa@huawei.com>
References: <cover.1549927666.git.igor.stoppa@huawei.com>
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

