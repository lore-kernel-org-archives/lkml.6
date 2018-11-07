Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8471EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BF520837
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qxtj3hc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BF520837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbeKHF6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:58:46 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42164 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbeKHF6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:58:46 -0500
Received: by mail-wr1-f67.google.com with SMTP id y15-v6so18806068wru.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 12:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oqwrTTqvGsUpLX2SWvD7XWIT2tTdoRIiwxsCG3LUJnc=;
        b=Qxtj3hc2m3rjDLj86DqFS0SG3/MQwRYZHk2fnZavQnjY7kRIgoVdcmHkInbTaYzn62
         n6tyvBShSyfofdBwcMWxGhCyKAUTzUH9gdMArubI8XsK8afN/hH8gf3hTEs9HmBPDZ1O
         14hvQEKJA+ZnP5VRYUQSyXOzYFjbOYyU5CKcbN/JdFt+oGnAIBSZcWxk7ffsmyztu8EX
         WWUQcfX6okOqya632GNpUA2PSWvGu8w8ZXsCnBnDQypZMEnKiCHwcVvyY6eywwdqdQl8
         wzD6FxqKl6+6/Zclmj6jgHu02YlsZQ/ycL3iBr482As5ZZfz9m5HdG45GbGfih5P3LIR
         g5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=oqwrTTqvGsUpLX2SWvD7XWIT2tTdoRIiwxsCG3LUJnc=;
        b=rOtb1iOdn2Im76KoZRRif54Efu3c920fTyHMOBM14w/0V4yVzJeSRApPNWh3BG1T3U
         gbgvXWNF0GcGC+SxVfSqGIRpK6D1mkNekPAJkAdeLoEsQYdH2RjuPBkkHVBKIP8xv8lT
         WNzlVD6R/OJtjlhdzXxE3Kq4gVwLtNUBWTGH/evyWJY78l6WDqWiss1UIQfp8yCouRON
         7a4AEGctF1QELdolvvTq8t3fILw9WMeQ9h03m+bjnz81H+DfD37jjJkonytFlDeGmbQI
         hqs7amQa4AtRZ7tCZKRRDx0pn7yyHoKi3UfF37XyWW7Qd3wyql1g5x8CNpHIlZh7WYjJ
         mJBA==
X-Gm-Message-State: AGRZ1gJMeXaV3TK7GfoL43ODjkFb938Xg32BuklPM44ChC//F40rBl7S
        +HBO8qEg3vbFU53cCvO8mTo=
X-Google-Smtp-Source: AJdET5dU6tqQvOaQgYuwZ4gHxlIvyOt476nswY8sgDNg35m/iB4Ohl9+T6NYtQ4UbPz1MRKXhVpAkw==
X-Received: by 2002:adf:d1c6:: with SMTP id m6-v6mr1575709wri.138.1541622405551;
        Wed, 07 Nov 2018 12:26:45 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id f67-v6sm1892405wme.22.2018.11.07.12.26.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 12:26:44 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 129C61142B69; Wed,  7 Nov 2018 21:26:43 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Mark variable `cpumsr` as unused
Date:   Wed,  7 Nov 2018 21:26:41 +0100
Message-Id: <20181107202641.7865-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gcc attribute unused for `cpumsr` variable.

Fix warnings treated as errors with W=1:

  arch/powerpc/kernel/process.c:231:16: error: variable ‘cpumsr’ set but not used [-Werror=unused-but-set-variable]
  arch/powerpc/kernel/process.c:296:16: error: variable ‘cpumsr’ set but not used [-Werror=unused-but-set-variable]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 96f34730010f..b9f1a2408738 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -228,7 +228,7 @@ EXPORT_SYMBOL_GPL(flush_fp_to_thread);
 
 void enable_kernel_fp(void)
 {
-	unsigned long cpumsr;
+	unsigned long cpumsr __maybe_unused;
 
 	WARN_ON(preemptible());
 
@@ -293,7 +293,7 @@ EXPORT_SYMBOL(giveup_altivec);
 
 void enable_kernel_altivec(void)
 {
-	unsigned long cpumsr;
+	unsigned long cpumsr __maybe_unused;
 
 	WARN_ON(preemptible());
 
-- 
2.11.0

