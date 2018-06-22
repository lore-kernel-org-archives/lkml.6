Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B4FC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC80E23FE2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC80E23FE2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932938AbeFVJyd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:54:33 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41260 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754585AbeFVJyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:54:31 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zRBYdmCpUg53; Fri, 22 Jun 2018 11:54:30 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCF3400329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcf:3400:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 983DE1EC0236;
        Fri, 22 Jun 2018 11:54:30 +0200 (CEST)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/7] RAS queue
Date:   Fri, 22 Jun 2018 11:54:21 +0200
Message-Id: <20180622095428.626-1-bp@alien8.de>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi guys,

please queue on tip:ras/core.

Thx.

Arnd Bergmann (1):
  x86/mce: Always use 64-bit timestamps

Borislav Petkov (5):
  x86/mce: Carve out the crashing_cpu check
  x86/mce: Remove !banks check
  x86/mce: Carve out bank scanning code
  x86/mce: Cleanup __mc_scan_banks()
  x86/mce: Do not overwrite MCi_STATUS in mce_no_way_out()

Tony Luck (1):
  x86/mce: Fix incorrect "Machine check from unknown source" message

 arch/x86/kernel/cpu/mcheck/mce.c | 244 +++++++++++++++++--------------
 1 file changed, 134 insertions(+), 110 deletions(-)

-- 
2.17.0.582.gccdcbd54c

