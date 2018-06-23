Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4533C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 03:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D26224AFA
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 03:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gLokTjPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D26224AFA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934643AbeFWDI2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 23:08:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59296 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933783AbeFWDI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 23:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DJgScgbKpm6g1A52JSNBuJxbMfh5uHXgmljKVopCAI8=; b=gLokTjPv+JSlbK7iG5N4vdzf/9
        whvqQPvZVIUfA71asDm8hbSWsOEt2gSw7IROexwngslCCJI25gGOEmBZrkFlaFI8QAjrKHZ7DdbIn
        Ff/k1yFkkdtZ2YZ8eHMdYiVQwouplzvMrFzbpyJodIr3mZcGOHT8SD5Ira0uhmiEhHeEH4WBaIK8g
        TH540wCtQQuQ0XP/WedEEUnPBkaB6THEIv+4qxvKWUS02NRyrnm9nN7zXGmIvCnVpKUD0y349K8Kn
        iGK8ssyKoRZulLmiHCyT8ZKKGNiZDvXZ6cL+qVPEJj7xdPJyrJK9+eHS+/BiKS1dtl2V6kJLTla8y
        3XGHcbtg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWYuX-00053d-Cy; Sat, 23 Jun 2018 03:08:25 +0000
To:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] kconfig: document Kconfig source file comments
Message-ID: <b2854ed6-073d-11b9-b344-571a0903995c@infradead.org>
Date:   Fri, 22 Jun 2018 20:08:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

I saw this type of Kconfig construct on LKML:

config SYMBOOL
	#bool "prompt string"
	default y

and wondered what it does.  Then I wondered if '#' comments are
even documented.  They aren't, so add a little doc for that.

Ah, good.  kconfig says:
arch/x86/Kconfig:2942:warning: config symbol defined without type

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/kbuild/kconfig-language.txt |    6 ++++++
 1 file changed, 6 insertions(+)

--- lnx-418-rc1.orig/Documentation/kbuild/kconfig-language.txt
+++ lnx-418-rc1/Documentation/kbuild/kconfig-language.txt
@@ -430,6 +430,12 @@ This sets the config program's title bar
 to use it. It should be placed at the top of the configuration, before any
 other statement.
 
+'#' Kconfig source file comment:
+
+An unquoted '#' character anywhere in a source file line indicates
+the beginning of a source file comment.  The remainder of that line
+is a comment.
+
 
 Kconfig hints
 -------------


