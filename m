Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD122C282E9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFAC2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="lcJa/9Go"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbfAUIOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:14:11 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37000 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbfAUIOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:14:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id g67so9768999wmd.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 00:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ibxTSM7aAfMxp0mh34e5XoCF9bu27Z34+6gCZTrPT34=;
        b=lcJa/9GoZ/Y6WfC0bylBfI5oCVTUbuuQaazcglM7FxSXk53oJ3EwA7gQ6DK+WxiFMb
         Tlrgwvc736fHcfg+YAswmtczDWnSSBMIcGSSXYg6i0MRH/ZIX2y9cpGSxmZ+J63hsT4/
         QTQXtg0gQ8OgWOCw2BrEXgDSkegRbpVoC0R+6nlx8MG5HL4zfx/R+JZ6gMYPKE+l1tLJ
         AXI8c4Qwl9aiXZE+hXoOGirioCNsW/YzcD/4+02Q9kHE3d1EMNxtT20zPoj7Mcuv0039
         pK40Sk4UGAAo1eF1IXEqWJ3/lN+mYFSzRQBsmUcXjgxuNNvUwayW8QCEFaj6ijFFXHa+
         HtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ibxTSM7aAfMxp0mh34e5XoCF9bu27Z34+6gCZTrPT34=;
        b=mzBWBrlJiMWZI69ljN+B9NllugdO+tmVuDf7lWCddzj4QVF3U75aecfJ6TtxbXZ3ST
         Z42v5FVp7lHclebi/gzwN8FqSc71NaknDT+OSdGaoFwO3dIUdYOCGPXieyRp4H+VpLn+
         USBQ1QZIE+VK1pH73wDW/98omEagamFmY0MNR0E1yZ2Oq8rRtscwguKLd7yuEqhO6D4d
         kM9qUyORT7GKoXCBop3z4g5bUnBEoMIeAotBsn2cJoR7/1TDYmZvr2IFQPNRnkXvcuYB
         IFf+3NdTy6JMOaxLCW+k//MKi+5Gvo+sIHSdYSPdQprU0HkUmdwJF1NniKUBoZY0cJ3W
         t8+Q==
X-Gm-Message-State: AJcUukdKdoyC3I2CXgwIsomYhfClYHYWv5o8zGkXLr6/Nu4oXKntLdyV
        frIhcNX1lW2aH2YyrIvNEiSNM9cg5Bc=
X-Google-Smtp-Source: ALg8bN6p9RWZDpkENLmzoXwCtF9v6nAyN1W721G5G6yv2ozcu7srm3C8FwlQtG+MKjShLdYSf4N48A==
X-Received: by 2002:a1c:9a4c:: with SMTP id c73mr23491864wme.35.1548027691743;
        Sun, 20 Jan 2019 15:41:31 -0800 (PST)
Received: from localhost.localdomain ([156.212.82.83])
        by smtp.gmail.com with ESMTPSA id e9sm76576753wro.16.2019.01.20.15.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jan 2019 15:41:31 -0800 (PST)
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
Subject: [RESEND PATCH V8 08/11] KVM: X86: Port ROE_MPROTECT_CHUNK to x86
Date:   Mon, 21 Jan 2019 01:39:37 +0200
Message-Id: <20190120233940.15282-9-ahmedsoliman@mena.vt.edu>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190120233940.15282-1-ahmedsoliman@mena.vt.edu>
References: <20190120233940.15282-1-ahmedsoliman@mena.vt.edu>
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

