Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A152C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AEB520830
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="HoV8NuMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfAFTZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 14:25:41 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33102 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfAFTZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 14:25:40 -0500
Received: by mail-ed1-f65.google.com with SMTP id p6so36137304eds.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 11:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ibxTSM7aAfMxp0mh34e5XoCF9bu27Z34+6gCZTrPT34=;
        b=HoV8NuMvRHRIahTLZDBI7mFj8a25nP7usZ14wlIEpO5VDxbpItPPfakKDHJd0tpXjr
         A0xgBMAWYLPvKkIjy7HPMLg+FPHv9SXcaymFZ+PeFBicagcBq0K7E9iU/3AMRwEwfBXA
         tEXG5wGu0eqGdkSsdkRFDRRvb5FaSQRQ0+6B0EFmJ3pMLM3yuualpb+DnrRGqAfwcAfb
         LDjWeRjsPkH2ukGWunr91Bx9l1twcY8wlzi9qYk2gR4BwVppDrJniJQSqXTwHmDDJK3G
         tRpdXeiZ/aLzNIcawK7iBf8+lNGE08fdD7eeUlBG8+EtRtgGyZkLtcx6EV6qwcNMiZrF
         5++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ibxTSM7aAfMxp0mh34e5XoCF9bu27Z34+6gCZTrPT34=;
        b=iYPZOmmoiQR3p1hDV6nlpZKmRsRq+syPZW4fWDbTQOGzVv7CrnkzfyxVIEo2Koi/kb
         2UJVblGYFK/TKhOFwFkwVbjUnPSlrtgjrKW2YtTiO5cB3vMAubtzhp5e2FmgQ2InJq84
         /D/0y39TbujNhmz9G0w7o9RwO9qRB6eq4w/duQ4xhZMk0Pg6RPLXjJ07IO2ujcAwNMxw
         f5ex7Zz3rgmwWLm9csffjtyMN8vaGdm5240H7/rjl6dq5CaAoJPolyAZ6ayo6NX7ioF+
         KPRNB4XZNveLgbuikcdIb0Nib+8YIaZG3m7Vi+kMQAhAt9QFLd1kNLfL4ArCi6mKRUEj
         xcTw==
X-Gm-Message-State: AA+aEWbz972WSCwvS4NZd/g6L/ynnJQh+/ZldiNS5hm5wPHgs/sp5rxA
        0BANB7o5B/O8FuQB+Gpn359PVw==
X-Google-Smtp-Source: AFSGD/WAe91TAKjmYeWuStwWgG2ypoS1UZa6t5xjlxl6mGSeeQxsX7WS7F/s7MqHKXGG8Rq9N9yz4w==
X-Received: by 2002:a17:906:228d:: with SMTP id p13-v6mr44874418eja.159.1546802738138;
        Sun, 06 Jan 2019 11:25:38 -0800 (PST)
Received: from localhost.localdomain ([156.212.65.252])
        by smtp.gmail.com with ESMTPSA id b46sm29994035edd.94.2019.01.06.11.25.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 11:25:37 -0800 (PST)
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
Subject: [PATCH V8 08/11] KVM: X86: Port ROE_MPROTECT_CHUNK to x86
Date:   Sun,  6 Jan 2019 21:23:42 +0200
Message-Id: <20190106192345.13578-9-ahmedsoliman@mena.vt.edu>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190106192345.13578-1-ahmedsoliman@mena.vt.edu>
References: <20190106192345.13578-1-ahmedsoliman@mena.vt.edu>
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

