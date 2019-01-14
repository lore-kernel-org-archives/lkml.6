Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19C5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6912064C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJeLztXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfANUNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:13:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33911 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfANUNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:13:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id j2so400805wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 12:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wWmKbA5d1oGoKuQguYAEN7zBM2H2HtNTPi7BgyT+znE=;
        b=LJeLztXb9zgZvHzDWbseGTWidNnpW/yFUY8r0TRpnoVtSGfyr+9cFKpMGTtbygxsgK
         EgXfYwfB9M8h/ktpa3VziHuaHkuqqWAwPJOXZ4D++YHxdi6zcf94D0CUTVRQhrnN9P4K
         tFMJLetWqC7sNybYyHUclTfS/A5oCIyzb6JmWOs4eVlNErNMvNDNXkGvX0KleqXd64yB
         YzNlZyMJyPhu6mRBEF79jK9+qMe9VWrx1V4Q8ZJpIyE7jnY6wFRBu4N6dx3+Fy370gw3
         HMyQT9VDw9ehIpGJE1J0Gk7SPI0k4st4NyUmWqRMnvx9TXibRhjw8uuj+PM5cNFFsxfV
         Uc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=wWmKbA5d1oGoKuQguYAEN7zBM2H2HtNTPi7BgyT+znE=;
        b=NRtSjs/K0DFAk/aoqR1HSzR06MIzmotaSA8Yamz2CuJmUyiB1wxoZYre7/aFnFGEQB
         lwDR81GnosvTnoYQ5LPlotIcsdOVkAMNr3okw1jAc5vJLYGf73uGDVyx1H9vi83qiEOd
         /si9dDfkcUPy/x2Ul+SsczistTbKTIOWq7P/15GGLiVLLJd2c+qIgBGh35HHlJlj1P4Y
         KrX6FoqyJV5X6KTdeDo2CBQESIKkV/1P7PBlw+v+gN/vKKktyQP/q4BCz0XBFy5yMgcp
         eFMWvDE64zweg6TtoVA5NmqiDLuZvop2Vz47hsyQdV05ebhsxassHsr32bXpHpNMew3w
         GqqA==
X-Gm-Message-State: AJcUukeWQiBSF19hONwaOltCNcoM1twxorCH+Ze/ORpIvi7RQJAur40z
        c6/Qy0mvmWVr9C+GSnimGpPin/MB
X-Google-Smtp-Source: ALg8bN7bqye7llULIjL7t/Z3TLbFTkFMfki7ki2Lrd+nu5U0G8/6XBBCi0iF7q74/cXWuqyYK4jwqg==
X-Received: by 2002:a5d:5409:: with SMTP id g9mr176312wrv.88.1547496813706;
        Mon, 14 Jan 2019 12:13:33 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id c15sm24265536wml.27.2019.01.14.12.13.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:13:31 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id ADE5D11422AD; Mon, 14 Jan 2019 21:13:30 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Allow CPU selection of G4/74xx variant
Date:   Mon, 14 Jan 2019 21:13:04 +0100
Message-Id: <20190114201304.10783-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC supports -mcpu=G4

This patch gives the opportunity to select ALTIVEC for this variant.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/platforms/Kconfig.cputype | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 8c7464c3f27f..7c544607ba32 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -153,6 +153,11 @@ config E300C3_CPU
 	bool "e300c3 (831x)"
 	depends on PPC_BOOK3S_32
 
+config G4_CPU
+	bool "G4 (74xx)"
+	depends on PPC_BOOK3S_32
+	select ALTIVEC
+
 endchoice
 
 config TARGET_CPU_BOOL
@@ -171,6 +176,7 @@ config TARGET_CPU
 	default "860" if 860_CPU
 	default "e300c2" if E300C2_CPU
 	default "e300c3" if E300C3_CPU
+	default "G4" if G4_CPU
 
 config PPC_BOOK3S
 	def_bool y
-- 
2.19.2

