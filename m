Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203B6C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C795A26244
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lnO6g/Id"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C795A26244
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934575AbeFYWsE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:48:04 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:53915 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932113AbeFYWlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:41:09 -0400
Received: by mail-it0-f74.google.com with SMTP id h195-v6so4884271itb.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=lCTxE5lz0L47Pc05K8/9m/ry5J3JMywUVuCnYE96NS0=;
        b=lnO6g/IdbWSCN8e5QY+u5ZUmgm8HjsN0UqEy7Db1oroVaZvQbE2COyhlWKarF4hjGk
         4jq2WgDHpxhflPw/XLbGBnaTyt24Y5lJDbzY3/I8qq14UsdxBQYXE7LVB0cPYySerrcR
         3t/RgXsewHBsgrOo7LapcSVesPiz9B3K0QIAqhVQAFWsDZ38RE82ODXGRpsUonuEVUoS
         r+Agyq+K/OugM+erLr+iMazyeJDGjvSgqqKDY9Fr4w/qUdCcZvAMAqhQEaznM/PKgO3A
         HvkxkuvN96PEOa0nFh6d9KCM8L3e1wsRLkjaWGkOcADwhZZaI7Y9GTPDsO8BEjVMA05L
         avbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=lCTxE5lz0L47Pc05K8/9m/ry5J3JMywUVuCnYE96NS0=;
        b=b6nRghA/WBqCKiQ//Lu5eVEs4TrlfOgwfvjpTDcZddEkPgpbGposUn8bOtPVLRiIEX
         0LP+VAnQY+fFO+YVaDXgvGk42vpAq9uf/esWgsyGyO31LWnKYJbhsx554PKGB8zgxcay
         xAjO4/98rk5a9bavDV5VC6JBggfl7ZuwHZcmhzX5DI0FU1aIGyjmN9l66HRbuuHLtcJz
         TprR0UrbT2xFonnbptZJyWwRWodnSTXLD9q4/92QOuwJ/KUrtt/A+B67PgW8wg2Wm1fP
         mJoXXSOZytTHJufuwpm6aKatgWh3zfb4Rs7xJXUUJHJTC1HFtq5Zp4SjXIGZuzycuKv8
         4W3A==
X-Gm-Message-State: APt69E32gDobfIn1S3fpN6E1gm19f6I/tUGCeL1Uf8LCH5jiEtYnN4mt
        ZT5Ng+xMgbu0LEwbQEE9Kphh8/LJESpHxg==
X-Google-Smtp-Source: AAOMgpd4tZ9cGQvZmf2ZyxpLZ+yF9MAsCnCppU/Ftd7kOb3DNAVrK0GkCq/iob8uqaABFEa2ovUqGiMvDlnNaw==
MIME-Version: 1.0
X-Received: by 2002:a24:74d0:: with SMTP id o199-v6mr1175909itc.11.1529966468641;
 Mon, 25 Jun 2018 15:41:08 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:38:53 -0700
In-Reply-To: <20180625224014.134829-1-thgarnie@google.com>
Message-Id: <20180625224014.134829-6-thgarnie@google.com>
References: <20180625224014.134829-1-thgarnie@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 05/27] x86: relocate_kernel - Adapt assembly for PIE support
From:   Thomas Garnier <thgarnie@google.com>
To:     kernel-hardening@lists.openwall.com
Cc:     Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly code to use only relative references of symbols for the
kernel to be PIE compatible.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/kernel/relocate_kernel_64.S | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 11eda21eb697..a7227dfe1a2b 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -208,9 +208,11 @@ identity_mapped:
 	movq	%rax, %cr3
 	lea	PAGE_SIZE(%r8), %rsp
 	call	swap_pages
-	movq	$virtual_mapped, %rax
-	pushq	%rax
-	ret
+	jmp	*virtual_mapped_addr(%rip)
+
+	/* Absolute value for PIE support */
+virtual_mapped_addr:
+	.quad virtual_mapped
 
 virtual_mapped:
 	movq	RSP(%r8), %rsp
-- 
2.18.0.rc2.346.g013aa6912e-goog

