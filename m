Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C9FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20AC320857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWYTezkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20AC320857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeIFHJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 03:09:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35478 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeIFHJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 03:09:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so4471284pfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 19:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5ZVcxdL3wgI2wwi7DksSKEhHqYPWKpAEMhlcil+nVwI=;
        b=eWYTezkBwD0rqOrGD8Li+S2CbxKBTOOtAf7XVIHIjFHdgLdLzBcgud+2O4/gO+sKpr
         5RJcTFErJQwa4GDfbgao1DKxBfuCYx0cKOcYmADS3gKhhHblOX/ETEZ2Dq+0o4JDozow
         V8uF1rWUebCdDHaoptix7xPP2ZVqczDXf7kl+tfu4rp3qejUiJKj1KfY71k720PB6ez9
         rhCRY06MXlV9nwwxj/cb9Zd/Dqkp3DM6IQ0hkLkf+aCsms+gvrQPoNI+Ga+O/F8YQttF
         TxX9UUDRWUmYKdm79d+tYBSC9MEb0xCAcheZcJVkw4gGcQsyUr1/JHGNT3SYybX2RwsD
         nyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5ZVcxdL3wgI2wwi7DksSKEhHqYPWKpAEMhlcil+nVwI=;
        b=pjcxJ/TxwkJ8Uqzw63PWQJAGYWSS3AQOmhREapgDccEEqaXfF5F+XXAdQAO2f6oawc
         t5FAUuNEJpPWuOl2Xg0ukuNRFTA2MYdRqjgFLxD0v8ERichPfx1HmHXLo/EObANxfsy2
         HOR+5wvO3R/y81x3Eq8jMK/NYbl46K30SOJoHb41nUgBsl+/1dJjYmHEvEejUUxtDebB
         3NCzVw+wB2Unnu0HPu3uZGhwK6qLFh2LYrKJfnsLGgcR623HXmX/G76JRDuOD0FfeLkB
         LTmOzo5r1BHrul0QgP9Qh8WekyfGqF8XF6NTR/nRWhm4XboNAQpKnwVSB1SiIWEL0IDs
         kZCw==
X-Gm-Message-State: APzg51Bhm0vC/QQJP/f32LTb0LiwBtQuy1FoFe00yIIxIgkt6gnkYwjX
        Fc/lw8kQfZl7OcTakaIWzS+ai9U=
X-Google-Smtp-Source: ANB0VdY2rODLGOVw3aQuzMOe86Gn9lrCBJwTC3/tRYhhk/ODoO28XCbKYiU7pvvtnDUDATOOo7UY+Q==
X-Received: by 2002:a62:2285:: with SMTP id p5-v6mr653210pfj.53.1536201408926;
        Wed, 05 Sep 2018 19:36:48 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r17-v6sm8780990pff.50.2018.09.05.19.36.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 19:36:47 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Baoquan He <bhe@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>, x86@kernel.org
Subject: [PATCH 0/3] x86/boot/KASLR: enhance randomness of kernel load addr when using GiB hugepage
Date:   Thu,  6 Sep 2018 10:36:19 +0800
Message-Id: <1536201382-13133-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 747ff6265db4 ("x86/boot/KASLR: Skip specified number of 1GB huge
pages when doing physical randomization (KASLR)") and commit
9b912485e0e7 ("x86/boot/KASLR: Add two new functions for 1GB huge pages
handling") prevent the physical load addr of kernel from spoiling a good
candidate of GiB page. But the algorithm deterministicly chooses the most
front GiB page for hugetlb, and sacrifices the randomness, which
is the heart of the KASLR. This patch tries to enlarge the randomness in
the cases where hugepages=X < the num Y of good candidate of GiB
page.
To comparison, taking a typical KVM guest for example, the head 3GiB mem
can not be used as GiB hugetlb. Denoting the total mem size as Z(GiB), when
Z=5, then Y=2, assuming X=1, the randomness range before this patch is
4GiB, after this patch is 5GiB, and get a 25% improvement of randomness.
If Z=6, then Y=3, assuming X=2, the improvement equals: 50%( 6/(6-2) - 1);
assuming X=1, the improvement will be: 20% (6/(6-1) - 1)

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com> (authored:1/16=6%)
Cc: x86@kernel.org

Pingfan Liu (3):
  x86/boot/KASLR: change the prototypes of
    process_efi_entries/process_e820_entries
  x86/boot/KASLR: change the prototype of process_mem_region() to meet
    the align requirement
  x86/boot/KASLR: enhance randomness when using GiB hugepage

 arch/x86/boot/compressed/kaslr.c | 228 ++++++++++++++++++++++++++-------------
 1 file changed, 152 insertions(+), 76 deletions(-)

-- 
2.7.4

