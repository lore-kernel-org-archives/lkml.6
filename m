Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FA6C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E584247E4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tXdCvmsl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E584247E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934448AbeFVT17 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 15:27:59 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51189 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933382AbeFVT16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 15:27:58 -0400
Received: by mail-wm0-f68.google.com with SMTP id e16-v6so3232393wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 12:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GoLP/NxL54n0S0izYjVS6o6CtwhirjK8Je/kF6aG740=;
        b=tXdCvmslB7+9r5d7A6HKJWdpE2Wby7yLE+bqHH1SURqkG2YNe4rDf6Xo/GQ3moc46w
         A9g57IMyzinQ+JFFpsjy+mgL3HFDeDgBhXdpN9eiJg8J8Zt/AIM0s5UrHESU9SmXTHfU
         orA6InTKxKR7rxlUmVr1JsvV8h4BED8yuTl0oIcrxPmGaraExV6rYnGXRarnITYpQ3Ji
         hiDFXkHLnITm9g1TrEKh/ir1wlNgaGW0iqah0JDZgSBrLf3uN473jxw0qITLz+PT4dhy
         Ht9aJNlavDp0xth7aT1mROnhnVYO6NZa3fBJFj6iqKTBABcD8WDqzn5RyYFODQfSIfPY
         XvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=GoLP/NxL54n0S0izYjVS6o6CtwhirjK8Je/kF6aG740=;
        b=DvKGLL9wz4bFRcc7uJcJLuUBpnwnxWdeGSZBfEUOqDH4vR0PZIPDF8MBkyRijSEKn4
         9bu+RvpPiJCNopi/2TzJ/ee5k7i7NEHM+HPO0ADLf/m/P33vbxcNLs5O9uToCkdGo5NC
         q2n//Pohwx+GayBmi0mN0BumYYU8L+6QwTA9RF7pzdyVneQj0KHIygDHLZySKxt0NRmW
         L9wkDN0nZs6TIOJejVcXLJVms2aQwy5pk7Y1piAWr7CnRSFMCi3soz9TkqEEWLOb6735
         gL1nQeH4hsSr7tydZSg6jsR4oHC1VlG9mIif3UlO9W4lAEJTYT0u2dzueVxK+pedvPYC
         gxvQ==
X-Gm-Message-State: APt69E2GavzgVsEfo1cN9I8PlV6jGdVRkqJLMaxvOVPz48ejHb3Uw4rs
        2hHYnhZSbHIJ9s3S3GWpYbo=
X-Google-Smtp-Source: AAOMgpd7eeco6G/XwGVITTKQltbbXU1bGyDzN5YW1bWM5B4AZtnWbpmIgRCNklnI6fUovVGD5HLtRw==
X-Received: by 2002:a1c:c208:: with SMTP id s8-v6mr2677723wmf.29.1529695676961;
        Fri, 22 Jun 2018 12:27:56 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id v68-v6sm2784455wmd.12.2018.06.22.12.27.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 12:27:56 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 6C97710C0452; Fri, 22 Jun 2018 21:27:55 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] =?UTF-8?q?powerpc/mm:=20remove=20warning=20about=20?= =?UTF-8?q?=E2=80=98type=E2=80=99=20being=20set?=
Date:   Fri, 22 Jun 2018 21:27:47 +0200
Message-Id: <20180622192749.24954-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

‘type’ is only used when CONFIG_DEBUG_HIGHMEM is set. So add a possibly
unused tag to variable. Remove warning treated as error with W=1:

  arch/powerpc/mm/highmem.c:59:6: error: variable ‘type’ set but not used [-Werror=unused-but-set-variable]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/mm/highmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/highmem.c b/arch/powerpc/mm/highmem.c
index 668e87d03f9e..82a0e37557a5 100644
--- a/arch/powerpc/mm/highmem.c
+++ b/arch/powerpc/mm/highmem.c
@@ -56,7 +56,7 @@ EXPORT_SYMBOL(kmap_atomic_prot);
 void __kunmap_atomic(void *kvaddr)
 {
 	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-	int type;
+	int type __maybe_unused;
 
 	if (vaddr < __fix_to_virt(FIX_KMAP_END)) {
 		pagefault_enable();
-- 
2.11.0

