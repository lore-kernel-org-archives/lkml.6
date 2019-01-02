Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA3AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5F2214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vBJxKYyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfABU4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 15:56:36 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38364 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbfABU4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 15:56:35 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so15672574pfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 12:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=K/hOWKtqQZ9Y+0xuXr52DlLfCsfN6a83f790ZTqPZLU=;
        b=vBJxKYyhWDF2HOaEqX8OEeNQ/KJe9qsGHVs/Ru7Iq9BIxFnX49zD1OmGeqOlLTAZ1S
         zEuFfCAZfwOfdl7MWYmSpRwjPjkt7RYajusfwAcZJfHNNP1wB/iwxI9XLis9b2FNCaHy
         SjWBI5y04QpBSbqNHRQ8vQCb6OSXsxXi6SJ5UC/3nDR8qhXlUHSdWd5MtvsxfNy+7eej
         tOGMdR3TWnUnwAsquLR0l286kuMF9LH82xUy14GJl3K1ncYhBcUk7ICmZFs3g3E8Tjnt
         2ykKvVkbt19tBXdi39JPikNUWv/RKV3EEVn/5BoXwUfGVPrvlMWQf0sVrXeJlW0xqZcy
         kR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=K/hOWKtqQZ9Y+0xuXr52DlLfCsfN6a83f790ZTqPZLU=;
        b=cTQW/Rj1b7x0btsqULLKJ+Vr4jzfYmx6jk7ywWV2RL7jVhAKg7Z8YO8XfhrH+q8+rR
         SOTPgTqkd2kuPZ3eRogn6tV1tPhSZ6nu/0uLqfxT3JO5MFHzNUVJ8DXktgs8spSNWWtn
         b/4qb+ZAQrZQCii0qcw0s8tRwxmYxXXw89/ugbj8Segdrewa/FMge95PHX9U5g4mHgJO
         XlPwl3lrtgmHGUCvVMMth9DgxTwzq8KITqF4o+NBzr6P3sIQJlR84RWVCRigVl8qoOM9
         h9BDxRYT76ucWF4UEa18H/R/kprlKNMRv/uwqAzvFLH6486KVvdPP1zgHXwvvbf5IB+5
         FkzQ==
X-Gm-Message-State: AJcUukffs3WqaX1fYDonRwecukeV1te9XAesfjM2fSgcGP1vDLGjeZ0Z
        wP/vkJfMSi91tbG+md8+h4CZJA==
X-Google-Smtp-Source: ALg8bN5NKmmWU4XVsRsDyKcNYBFOjKNyb3HtM8g410zlWqp0f8yjfyuCDzjDIif6xOT2+lPCWtLlPg==
X-Received: by 2002:a63:4d0e:: with SMTP id a14mr14859234pgb.408.1546462595051;
        Wed, 02 Jan 2019 12:56:35 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id q75sm78264856pfa.38.2019.01.02.12.56.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 12:56:34 -0800 (PST)
Date:   Wed, 2 Jan 2019 12:56:33 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
cc:     Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch] kvm: sev: Fail KVM_SEV_INIT if already initialized
Message-ID: <alpine.DEB.2.21.1901021255410.62182@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By code inspection, it was found that multiple calls to KVM_SEV_INIT
could deplete asid bits and overwrite kvm_sev_info's regions_list.

Multiple calls to KVM_SVM_INIT is not likely to occur with QEMU, but this
should likely be fixed anyway.

This code is serialized by kvm->lock.

Fixes: 1654efcbc431 ("KVM: SVM: Add KVM_SEV_INIT command")
Reported-by: Cfir Cohen <cfir@google.com>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 arch/x86/kvm/svm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -6278,6 +6278,9 @@ static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	int asid, ret;
 
 	ret = -EBUSY;
+	if (unlikely(sev->active))
+		return ret;
+
 	asid = sev_asid_new();
 	if (asid < 0)
 		return ret;
