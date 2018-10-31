Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55643C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C67120657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PL7+NanL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C67120657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbeJaUBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 16:01:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33888 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeJaUBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 16:01:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id j26-v6so1803836wre.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 04:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pW4p5ekuQgWSAo3EpgmHNfRh/OxQhAWSXR6ZJn3Wn3w=;
        b=PL7+NanLkJYIdGjDn/qRqt7LINX3lNIF9/jaavHlbvaGNwgNtPklLdNMhcl/wUNxEK
         pME6NnczybMlsZc5EXsXueBApl1SmHgLvmEhrGJLpYfEeYP0C5r6c9Hia4izZyfrHZj3
         Obw6o0EP44frTBlm5ZwXU7OVTYO5AG07CEFGQVKH0rc5F8RG/6oBVGcBqqnasLUS/TQx
         0LblAczbbXtHaejDEtmtJPjF7jT4V/2qnKM9MjuJ7wnkg8+Yff1lVFM9rRCzNfLZgKD2
         G/7PWTZIHkGCF1ypWBbIwxPeSKO4tyufUiXfNTaQAm82UYmq8Yhst5km9b88r8AFWBsn
         4H0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=pW4p5ekuQgWSAo3EpgmHNfRh/OxQhAWSXR6ZJn3Wn3w=;
        b=hQOm27H0uSstb/+bTQnI4N2jyL4luDs667otetO1olf1VCZ1oSuaDLDY+F0kL7NsyC
         pLHYNlwD7MiM/0pDi1MiaXEQ+VD77zdqEogacu4fzVpKxDuVXtNOr5m9Ag1iDgXjJ9ZN
         ZxVzcj5PO2o++80N6t1pJNf2lAw+UoepBoN1/mEsJOuWz9bOVr/Vl2CsUgj2ODbJ0V44
         XBUEsaox/03YogMpFubQN5ePw58hR43pEubd7nCRrG8BqlDhTSQYvxtXF5wnGoB5Pnqp
         Crqx1zUmnHu8Xf7zNR7P5unXjSfL+zcO64FJJUb04aUbpYGb8u4cAsb1AbyaIsqh99kp
         urzQ==
X-Gm-Message-State: AGRZ1gI/aY5Pww+Xi9N/JCk1jXgMFKarToJulSpjWSzexW453cWgBkIL
        0ILDsFWeQdAeMQ6yvPo/wNM=
X-Google-Smtp-Source: AJdET5fshi4tDPpym8Jo9Z4K5Ndwa/fv8W1OjBREuTaYwyUw/LyR6mYycLkVb2WDLYqZy3wI9WkQRQ==
X-Received: by 2002:a5d:570d:: with SMTP id a13-v6mr2448052wrv.289.1540983804438;
        Wed, 31 Oct 2018 04:03:24 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id b71-v6sm21113557wma.13.2018.10.31.04.03.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 04:03:23 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 36D81114491C; Wed, 31 Oct 2018 12:03:21 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] =?UTF-8?q?powerpc/mm:=20remove=20const=20type=20qualifier?= =?UTF-8?q?=20from=20function=20=E2=80=98pud=5Fpfn=E2=80=99?=
Date:   Wed, 31 Oct 2018 12:03:07 +0100
Message-Id: <20181031110308.8194-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Type qualifier on return type is ignored. Remove warning in W=1:

  arch/powerpc/include/asm/book3s/64/pgtable.h:1268:25: error: type qualifiers ignored on function return type [-Werror=ignored-qualifiers]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 6c99e846a8c9..2e6ada28da64 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1304,7 +1304,7 @@ static inline int pgd_devmap(pgd_t pgd)
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-static inline const int pud_pfn(pud_t pud)
+static inline int pud_pfn(pud_t pud)
 {
 	/*
 	 * Currently all calls to pud_pfn() are gated around a pud_devmap()
-- 
2.11.0

