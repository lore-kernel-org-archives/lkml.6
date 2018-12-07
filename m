Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C76C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29AC3214DA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="ZtGj2HHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29AC3214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mena.vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbeLGMtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:49:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40712 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbeLGMt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:49:28 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so3690692wrt.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 04:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ibxTSM7aAfMxp0mh34e5XoCF9bu27Z34+6gCZTrPT34=;
        b=ZtGj2HHQ1QdQqkzxKnkhyG6zbN40ooJhtxiFxmtMZB2G6JXMbNVeLRlBclZc1ByuBt
         rJkGbokdWxQ0B4Z/lVF47mJXfpvZg6onuNs38evpR6F0plHgzidl0tnlt5rJTh3WpIX0
         xXvr8J/Yp27UtUoFGtdUgpFJ6up0leTOytBXoBP3vyuv2whs8HO6r7g4e5dNAiOckiEq
         S4Jkfj+slyqpYESweAypsVAe8xa4+M+/i961soZgwCd01iqS8UtJC/jK7GFRWxJ15VKF
         iteVo2+659CaouRtxIESOgKb838vu10UoGWA0UJYtGjsBcL2ia6Cz6nFHafS5PeNz3tx
         ntcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ibxTSM7aAfMxp0mh34e5XoCF9bu27Z34+6gCZTrPT34=;
        b=WcGxLklkODEODaTpyaPrf/GH93gnbSXiB3NsmSsVuXLg/z4+RfaLMRDeOmVQEKphOt
         REeKh3XtlqZDcoswGPgi93AJJ4mePeGjpJ0f9pLmE5vonhijzu9RXXZPeX6r9fF9Bv52
         tJVwEH4CeMe4UPN4c/wKLnmADLDCnq3vqhWn2hyUS8GktJTQ2OL1N8Fy6aEnpRQIfS+J
         Ur1+J4sVEk+FoLZu3BUECUqS5OulVGCFmkwpnvITksnR9dTAuVEhGyDkmfvDi66Dpl3R
         fAzs+nRT87rmcXfA2FfbI8N5Z7LrO2ldrfpocEAIK8HMO0HSaKF7UGhb8V7BQ5Y8YM/t
         1+Nw==
X-Gm-Message-State: AA+aEWair3PycGgHfU4VUe/SkjEFoNzhxzNCHbUtK6WyePtDbwQlghX5
        pghFmjEBcL1JKqWFKxw+yUx/vw==
X-Google-Smtp-Source: AFSGD/XycEJqUK3+cMbWlXGqoLuR+oFh9trApfppGt82EltYcdXfLPRSVVY6b30XONttXSMdK4nsLQ==
X-Received: by 2002:adf:c846:: with SMTP id e6mr1624715wrh.243.1544186966936;
        Fri, 07 Dec 2018 04:49:26 -0800 (PST)
Received: from localhost.localdomain ([156.213.98.90])
        by smtp.gmail.com with ESMTPSA id i192sm4362949wmg.7.2018.12.07.04.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 04:49:26 -0800 (PST)
From:   Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahmedsoliman0x666@gmail.com, ovich00@gmail.com,
        kernel-hardening@lists.openwall.com, nigel.edwards@hpe.com,
        Boris Lukashev <blukashev@sempervictus.com>,
        Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
Subject: [PATCH 08/10] KVM: X86: Port ROE_MPROTECT_CHUNK to x86
Date:   Fri,  7 Dec 2018 14:48:01 +0200
Message-Id: <20181207124803.10828-9-ahmedsoliman@mena.vt.edu>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181207124803.10828-1-ahmedsoliman@mena.vt.edu>
References: <20181207124803.10828-1-ahmedsoliman@mena.vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apply d->memslot->partial_roe_bitmap to shadow page table entries
too.

Signed-off-by: Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
---
 arch/x86/kvm/roe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/roe.c b/arch/x86/kvm/roe.c
index f787106be8..700f69823b 100644
--- a/arch/x86/kvm/roe.c
+++ b/arch/x86/kvm/roe.c
@@ -25,11 +25,14 @@ static bool __rmap_write_protect_roe(struct kvm *kvm,
 	struct rmap_iterator iter;
 	bool prot;
 	bool flush = false;
+	void *full_bmp =  memslot->roe_bitmap;
+	void *part_bmp = memslot->partial_roe_bitmap;
 
 	for_each_rmap_spte(rmap_head, &iter, sptep) {
 		int idx = spte_to_gfn(sptep) - memslot->base_gfn;
 
-		prot = !test_bit(idx, memslot->roe_bitmap) && pt_protect;
+		prot = !(test_bit(idx, full_bmp) || test_bit(idx, part_bmp));
+		prot = prot && pt_protect;
 		flush |= spte_write_protect(sptep, prot);
 	}
 	return flush;
-- 
2.19.2

