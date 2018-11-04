Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F20C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 22:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A04B2082D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 22:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IXL98mYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A04B2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbeKEHUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 02:20:32 -0500
Received: from merlin.infradead.org ([205.233.59.134]:54850 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbeKEHUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 02:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lEj06LJ+DfeTrLd5k4yIJxlExHzA3HuGvUKbzlYnSwo=; b=IXL98mYvA6Axnn2pyaIlYrlvOg
        Zy2yBI+CRB3LvowI8i5yq5VbjcrjTW+jWDkAZ6HitRk1hRd/NcrM0dnsHAm+sLCmNSWn+mD43Wugv
        P2NYgsTv/DzkYqCzuii0m0eAlgZgx5IhCPoDdf3NrkscVar3ExSY9MBQCCoRgjRhtBxFLCIESohJQ
        VBBF3AhFJPekYjVOtlZlUCxtW5SGr5WEv8bC9eDTgVBp/QbHk0v/HzBcP2LB8gTTSJCPWvtqUtu5T
        xAMFY32z7SHSYgr/A9NDerzC0zDWcGytY7yHhoFSBE3b8Z93LabmRmlaS2EMQMJiIELYVFU+Sd0Je
        kOWkQkfQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJQV1-0007jH-DR; Sun, 04 Nov 2018 22:04:03 +0000
To:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH resend] Documentation/x86: fix typo in zero-page.txt
Message-ID: <f259b21b-1f2b-f215-00d2-23388bed2530@infradead.org>
Date:   Sun, 4 Nov 2018 14:03:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix a typo in Documentation/x86/zero-page.txt.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: x86@kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/x86/zero-page.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20181101.orig/Documentation/x86/zero-page.txt
+++ linux-next-20181101/Documentation/x86/zero-page.txt
@@ -25,7 +25,7 @@ Offset	Proto	Name		Meaning
 0C8/004	ALL	ext_cmd_line_ptr  cmd_line_ptr high 32bits
 140/080	ALL	edid_info	Video mode setup (struct edid_info)
 1C0/020	ALL	efi_info	EFI 32 information (struct efi_info)
-1E0/004	ALL	alk_mem_k	Alternative mem check, in KB
+1E0/004	ALL	alt_mem_k	Alternative mem check, in KB
 1E4/004	ALL	scratch		Scratch field for the kernel setup code
 1E8/001	ALL	e820_entries	Number of entries in e820_table (below)
 1E9/001	ALL	eddbuf_entries	Number of entries in eddbuf (below)


