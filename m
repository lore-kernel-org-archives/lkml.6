Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C3DC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D72214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D72214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sembritzki.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbeHOWg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 18:36:27 -0400
Received: from mail.sembritzki.me ([5.45.101.249]:60524 "EHLO
        mail.sembritzki.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeHOWg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 18:36:27 -0400
Received: from yannik-laptop.fritz.box (x4dbb4132.dyn.telefonica.de [77.187.65.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.sembritzki.me (Postfix) with ESMTPSA id 2BE5FA7AAD;
        Wed, 15 Aug 2018 21:42:54 +0200 (CEST)
From:   Yannik Sembritzki <yannik@sembritzki.me>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        "Justin M. Forbes" <jforbes@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@google.com>,
        Vivek Goyal <vgoyal@redhat.com>
Cc:     Yannik Sembritzki <yannik@sembritzki.me>
Subject: [PATCH 0/2] Fix kexec forbidding kernels signed with keys in the secondary keyring to boot
Date:   Wed, 15 Aug 2018 21:42:42 +0200
Message-Id: <20180815194244.29564-1-yannik@sembritzki.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CA+55aFxXzfW+85Xf5OmNCsp2YRQqN3zJT5NhobauK=yn44_xiQ@mail.gmail.com>
References: <CA+55aFxXzfW+85Xf5OmNCsp2YRQqN3zJT5NhobauK=yn44_xiQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've written two patches for (a) the logical change of allowing kernels
signed with keys in the secondary keyring to be kexec'd (b) the refactoring
of the magic 1UL Linus requested.

Yannik Sembritzki (2):
  Fix kexec forbidding kernels signed with keys in the secondary keyring
    to boot
  Replace magic for trusting the secondary keyring with #define

 arch/x86/kernel/kexec-bzimage64.c       | 2 +-
 certs/system_keyring.c                  | 3 ++-
 crypto/asymmetric_keys/pkcs7_key_type.c | 2 +-
 include/linux/verification.h            | 4 ++++
 4 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.17.1

