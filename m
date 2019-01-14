Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD13DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98ED720883
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YtwFxkQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfANXrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:47:53 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:48460 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfANXrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 18:47:52 -0500
Received: by mail-yw1-f74.google.com with SMTP id v187so424322ywv.15
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 15:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DyNHNOpRHYfQX03BEElWerg7y93ICKkIGunjZWqODLk=;
        b=YtwFxkQAHpEln7Dk8lAkmFX6APkMcrh10F2T5DwAGqfmHb6uFdVirV/IH50YxJ/hrx
         0pte13PufAUwllS2nNSwytCTQ7ligoAhrIn1WmXqKW+IPyyCUwJzN3ES19OkEn/RiDUq
         xhWtYcP2nL6TMtwf1o4Oa0tkBhHjDsd5MKmwtZCGUL1S9CvqDVbP5ZwRAD+BJLl6HiuF
         pIhNTnF1LZet5NRf4suJOOXNfrmchqZxQJdwvW+uURfMZ21ySJoXYr2qdCcFmohNHIg1
         cLu3YAlBUlvN3QdtnrBNgH+EyXtEbXgR1H8JbrEheLe9U6v0xbej35y7Qm9ajnYHw32W
         qN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DyNHNOpRHYfQX03BEElWerg7y93ICKkIGunjZWqODLk=;
        b=qkf+Hjx1FjPcuIMxvaDEwElScGqlzfEzjarpxaCW0TwuAKkDFjLIIUC5Ukzj5lI/LO
         AfpQ88RQPFw4ZMbPfzvqMZSroAnDgH4i9a87icxEcA3nP6gY6lDbSO2ytZbLvKl4KzOJ
         hi4rjLHytDNBY0Xq4uG+KfLzRCI97qks4agjz9aFCkv7esmRo5C84VhIUldZ7zq9O3Zb
         u0bSSmVAKRrQAwKErdV1kyxjGpGuMAoHLZSq6FNE5I2U76OaO4oX5nX3V7N5vCgGMh8G
         jiK/5xuNBkTziSYcuD+RF9eFpHlRn+hFK9r5cSyzWpX8OeCRwylXTOTuJBjmftmhLAcZ
         BoBg==
X-Gm-Message-State: AJcUukezxxW1pnSCWXe+Vj5cxbYCRytlmdO2IjETrW/EDFRozHIrIqVv
        7ngDCjC7KWr4Bdf2i/eLxcjsWsu+jx2+rg==
X-Google-Smtp-Source: ALg8bN6fZj5BAKLABqPU20mclFuR0vY4cbY7+1t5EJtmkKkVH3MCOYNHWRctTYpEKm/oiD9DU6nK2jW5YfV6JA==
X-Received: by 2002:a25:c64e:: with SMTP id k75mr261925ybf.90.1547509671676;
 Mon, 14 Jan 2019 15:47:51 -0800 (PST)
Date:   Mon, 14 Jan 2019 15:47:28 -0800
In-Reply-To: <6f79d9be-fa76-3a06-2612-f44f3a18ece7@redhat.com>
Message-Id: <20190114234728.49239-1-tmroeder@google.com>
Mime-Version: 1.0
References: <6f79d9be-fa76-3a06-2612-f44f3a18ece7@redhat.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [RFC PATCH] kvm: x86/vmx: Use kzalloc for cached_vmcs12
From:   Tom Roeder <tmroeder@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        "=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>
Cc:     Liran Alon <liran.alon@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Roeder <tmroeder@google.com>,
        syzbot+ded1696f6b50b615b630@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changes the allocation of cached_vmcs12 to use kzalloc instead of
kmalloc. This removes the information leak found by Syzkaller (see
Reported-by) in this case and prevents similar leaks from happening
based on cached_vmcs12.

The email from Syszkaller led to a discussion about a patch in early
November on the KVM list (I've made this a reply to that thread), but
the current upstream kernel still has kmalloc instead of kzalloc for
cached_vmcs12 and cached_shadow_vmcs12. This RFC proposes changing to
kzalloc for defense in depth.

Tested: rebuilt but not tested, since this is an RFC

Reported-by: syzbot+ded1696f6b50b615b630@syzkaller.appspotmail.com
Signed-off-by: Tom Roeder <tmroeder@google.com>
---
 arch/x86/kvm/vmx/nested.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 2616bd2c7f2c7..ad46667042c7a 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4140,11 +4140,11 @@ static int enter_vmx_operation(struct kvm_vcpu *vcpu)
 	if (r < 0)
 		goto out_vmcs02;
 
-	vmx->nested.cached_vmcs12 = kmalloc(VMCS12_SIZE, GFP_KERNEL);
+	vmx->nested.cached_vmcs12 = kzalloc(VMCS12_SIZE, GFP_KERNEL);
 	if (!vmx->nested.cached_vmcs12)
 		goto out_cached_vmcs12;
 
-	vmx->nested.cached_shadow_vmcs12 = kmalloc(VMCS12_SIZE, GFP_KERNEL);
+	vmx->nested.cached_shadow_vmcs12 = kzalloc(VMCS12_SIZE, GFP_KERNEL);
 	if (!vmx->nested.cached_shadow_vmcs12)
 		goto out_cached_shadow_vmcs12;
 
-- 
2.20.1.97.g81188d93c3-goog

