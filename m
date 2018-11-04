Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52878ECDE46
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 17:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12EBE2085A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 17:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhkdCSsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12EBE2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbeKEC2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 21:28:14 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42795 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729339AbeKEC2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 21:28:13 -0500
Received: by mail-wr1-f65.google.com with SMTP id y15-v6so6904796wru.9;
        Sun, 04 Nov 2018 09:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=DwaIjaOplxzcZ7ftx2a6kgsWPHMYRimWe+wNdR5/hJE=;
        b=MhkdCSshEjRNx9P6uI8UFpbF8xhZBi+BXrVUGq0azBHVfb+d1zjeBVZE0MZmNYcXRY
         MA6om+WJgl40o+v+zhnVpCAqEXp+JlmQvMJ4Xsll1pSAkOtANQ6qWh/Q+ckP7nV1hXa6
         CqzPOGiKXUiwojtMSBT3idTVZQFRgNoqAw4wZ8VeT65adKtmaINQAET4gwQnH/RF30w3
         f+cnlNNaERkdOCwvSvDkYWwImy5CnYaVJmX6iV8E9cqT+RePOhDQZSqKCdVOQeHKWsQn
         AngBM2mt/BjtcyGnUowd/4FXyQ+gF42PKnufo74QdGHHdrfViUkkkv9gWRhFm4I0zBtW
         4GyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=DwaIjaOplxzcZ7ftx2a6kgsWPHMYRimWe+wNdR5/hJE=;
        b=lgPMlx9nQiZ6N7fHEu4jWaBTo6Sk62YlBNLQJTb4XN31yUP1F0cZhCPWEsOEmnXi30
         2Sz0Qsxdq/FuryjcqJNRxwq+kI9MRn4jTdivK5d8tcDPQdeXxJ8Y6oBwAANzie1NvNDM
         I6edUL9uyBua6h49Wl8P2n1JEaQ9Oq3F5boa9h7/36jTkkR5J53/fp1FntZANLs2bGP3
         /V1zeM8E5dHiAuGTVlyVSH2JOf86dCS41H5ls+CXId+ASv33jn7ZXOPnu3+Otb61kGrv
         pnvVZ7KQre6GZLGN90Q4LAGxGFCgrhtMbU4t9Yybn+gGdUMZLH4hrMF5kDNoF1MR9aJO
         JgcA==
X-Gm-Message-State: AGRZ1gKNOH9ExqxPmaqFCIzpGNtUNI0yPO1Ft7kJmFLJma33QbpfIJdt
        9duIvwTSgRhdKFC1rRQ3V20=
X-Google-Smtp-Source: AJdET5e89ZUGWapFPY6etHj5e1LT86pqcOptFq7O4qxay+gQJ0F3xdZD6d3MGP1AJX6TZZjit4uaxQ==
X-Received: by 2002:adf:f148:: with SMTP id y8-v6mr4983695wro.303.1541351553120;
        Sun, 04 Nov 2018 09:12:33 -0800 (PST)
Received: from localhost.localdomain ([41.35.162.9])
        by smtp.gmail.com with ESMTPSA id r2-v6sm23707749wrq.1.2018.11.04.09.12.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 09:12:32 -0800 (PST)
From:   Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahmedsoliman0x666@gmail.com, ovich00@gmail.com,
        kernel-hardening@lists.openwall.com, nigel.edwards@hpe.com,
        Boris Lukashev <blukashev@sempervictus.com>,
        Hossam Hassan <7ossam9063@gmail.com>,
        "Ahmed Lotfy igor . stoppa @ gmail . com" <A7med.lotfey@gmail.com>
Subject: [PATCH V6 7/8] KVM: X86: Port ROE_MPROTECT_CHUNK to x86
Date:   Sun,  4 Nov 2018 19:11:23 +0200
Message-Id: <20181104171124.5717-8-ahmedsoliman0x666@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181104171124.5717-1-ahmedsoliman0x666@gmail.com>
References: <20181104171124.5717-1-ahmedsoliman0x666@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apply d->memslot->partial_roe_bitmap to shadow page table entries
too.

Signed-off-by: Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
---
 arch/x86/kvm/roe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/roe.c b/arch/x86/kvm/roe.c
index cd3e6944c15f..b2b50fbcd598 100644
--- a/arch/x86/kvm/roe.c
+++ b/arch/x86/kvm/roe.c
@@ -25,9 +25,12 @@ static bool __rmap_write_protect_roe(struct kvm *kvm,
 	struct rmap_iterator iter;
 	bool prot;
 	bool flush = false;
+	void *full_bmp =  d->memslot->roe_bitmap;
+	void *part_bmp = d->memslot->partial_roe_bitmap;
 
 	for_each_rmap_spte(rmap_head, &iter, sptep) {
-		prot = !test_bit(d->i, d->memslot->roe_bitmap) && pt_protect;
+		prot = !(test_bit(d->i, full_bmp) || test_bit(d->i, part_bmp));
+		prot = prot && pt_protect;
 		flush |= spte_write_protect(sptep, prot);
 		d->i++;
 	}
-- 
2.18.1

