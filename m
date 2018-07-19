Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98BDC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861DF206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jHQQBoag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861DF206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbeGSGqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 02:46:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40936 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729903AbeGSGqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 02:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=x3BHXbGOkz8e+bTxCvsLNSlT13AfgzDm+UaL0N/SJII=; b=jHQQBoagz6y+96uYFuFuz5fZP
        sg6NML6qlsMe5lA464cwPuq8Fg8EarPaRXx/VNVx9Wcatkk0x2fsBrC/Oh3YFkC7sBjAqy0he8OO9
        XTapRFrvdqxcr8d5Y2jiEAVYJO0c7GmpyZMznoSSC86RguVUxYIVRuf3/nnBLsk0/mnCRrFEqm2nJ
        p4a7Rhk0Jl6fBMLrr+w3jhqfNeNh+FND3foKwUAlYzjNrKccLEUzAXZYlr0Na+N4f7V6ed4HtMJ6X
        1tRspcNafjd2vQ4t/m1a2GIdBbcqI+nUsPwvboE+Jh8SnhDYausJNUbu5a1I/svvUNfIdSKvp8nVk
        ZzERqS0qQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fg23C-0002Zg-CH; Thu, 19 Jul 2018 06:04:30 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     uclinux-h8-devel@lists.sourceforge.jp
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] arch/h8300: add a defconfig target
Message-ID: <84ff16cd-2549-56f2-9e26-60b70188c9f2@infradead.org>
Date:   Wed, 18 Jul 2018 23:04:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Make the "defconfig" target valid for arch/h8300.  Currently
"make ARCH=h8300 defconfig" produces:

*** Can't find default configuration "arch/h8300/defconfig"!
../scripts/kconfig/Makefile:87: recipe for target 'defconfig' failed

By adding a value for KBUILD_DEFCONFIG, "make ARCH=h8300 defconfig"
successfully produces a kernel .config file:

*** Default configuration is based on 'edosk2674_defconfig'

This is useful for Kconfig editing/testing.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: uclinux-h8-devel@lists.sourceforge.jp (moderated for non-subscribers)
---
 arch/h8300/Makefile |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20180717.orig/arch/h8300/Makefile
+++ linux-next-20180717/arch/h8300/Makefile
@@ -8,6 +8,8 @@
 # (C) Copyright 2002-2015 Yoshinori Sato <ysato@users.sourceforge.jp>
 #
 
+KBUILD_DEFCONFIG := edosk2674_defconfig
+
 cflags-$(CONFIG_CPU_H8300H)	:= -mh
 aflags-$(CONFIG_CPU_H8300H)	:= -mh -Wa,--mach=h8300h
 ldflags-$(CONFIG_CPU_H8300H)	:= -mh8300helf_linux


