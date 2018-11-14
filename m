Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AE9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B9922419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t7HWcSyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B9922419
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbeKOJBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:01:54 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:37021 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKOJBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:01:54 -0500
Received: by mail-yw1-f74.google.com with SMTP id s18-v6so13873401ywg.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 14:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cef6YNlIU1qhqW6QfENAl8n18Yhm93q9fZZO+r6oQn0=;
        b=t7HWcSySxUpO/OZdd5gwxbvVhUTog5gHX0Cq0W3jWFJ8gs/5iH5jhylAWeqcu9uzCx
         ksb/W0m5Omr+FwduH5FwBuwQmdkakggEOJBYBk90mW9uRLgSHz7am3k5c6qB/yk0MYdl
         WA6oik/LsDoixfzHWqSwqk6ddkxH2wjww0xI3b8VYw4YD4GefiBNQMKRVCJdI2ZlIARq
         6ybykly4+8x/M5IWUeIAMuEDE3ZeFpgWZtIv1fND5ujnvNFbhy294N8A/3L3mgwmphLz
         wfUeKDy933l8XM6JHYShKMNZW3kxfxMozztfGcY1S7ySG1xGwvVgjhle3K7XTa4G59mj
         qrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cef6YNlIU1qhqW6QfENAl8n18Yhm93q9fZZO+r6oQn0=;
        b=kJiFJDUoPfIZ0hyxWbtnF9vQGTA3VJuwdP/h35YUrGGexhVXC/ORFXdcnyIB1l4Aki
         llSQ2bStyu0Ey5qvK/zEonIrBC2UsAvpTmaFmyoRq+sLDTMIAFeLOu+gewaWoxrQz2qw
         Mz+eNgwB2rv0CM/UuaDUswf9F6soLLl5rNQUVE6iApqZT/HvrmcWvz43wS6dwK7EmVCv
         JLYN6uWpAItvro9z3dodgpfojjDG05+XyCURuGYztQhCBvgPoFGINkJL1exyqw8h5073
         TOpb9hNRghMZlsoRMG/Q96Wd1URqB6IQqdH4zuyNt81GsrVBpC9wyjS8VhasImdW1mKs
         0I/w==
X-Gm-Message-State: AGRZ1gKJsSJI9AGNlnFGXjs6bHAvy0prfyKTGds1ueIF79aMa51f/HzB
        KKSJ8nWAd5kIsp2GDTYFyeu5MqaC
X-Google-Smtp-Source: AJdET5fNHqW6uc/jnFI/Gp6AlfYsKcuiR7tSCSnpn/Rthe6786N1XCmZCOlfQ9LKEnrlCDJ9sUINBAqS
X-Received: by 2002:a81:5f55:: with SMTP id t82-v6mr1740879ywb.24.1542232389390;
 Wed, 14 Nov 2018 13:53:09 -0800 (PST)
Date:   Wed, 14 Nov 2018 16:51:55 -0500
In-Reply-To: <20181114215155.259978-1-brho@google.com>
Message-Id: <20181114215155.259978-4-brho@google.com>
Mime-Version: 1.0
References: <20181109203921.178363-1-brho@google.com> <20181114215155.259978-1-brho@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH v2 3/3] kvm: remove redundant PageReserved() check
From:   Barret Rhoden <brho@google.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, yu.c.zhang@intel.com, yi.z.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm_is_reserved_pfn() already checks PageReserved().

Signed-off-by: Barret Rhoden <brho@google.com>
---
 virt/kvm/kvm_main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2679e476b6c3..e0ea6d7dac14 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1700,12 +1700,8 @@ EXPORT_SYMBOL_GPL(kvm_release_pfn_dirty);
 
 void kvm_set_pfn_dirty(kvm_pfn_t pfn)
 {
-	if (!kvm_is_reserved_pfn(pfn)) {
-		struct page *page = pfn_to_page(pfn);
-
-		if (!PageReserved(page))
-			SetPageDirty(page);
-	}
+	if (!kvm_is_reserved_pfn(pfn))
+		SetPageDirty(pfn_to_page(pfn));
 }
 EXPORT_SYMBOL_GPL(kvm_set_pfn_dirty);
 
-- 
2.19.1.1215.g8438c0b245-goog

