Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CBDC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2744121726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548169100;
	bh=G+WQwcnRE6zahJRQhFFcfB73LCT5sulYYfaDDPTEdgE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=rjrTnqv38Kue3CK4cVItakdtVyyYsqZnOlrfcF5hqEJRnAmgEMN3mtTqGZmwV8XhB
	 /RbfrRfinTyDUihJa+gjUjJBA+L8MloiSnvkdhVLe23HgVYVI+mHM5EkVG5YcG6103
	 pbBkCIYk2C0NyJ6/U1kZXZslCHQc17BqXk8zy8O8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfAVO6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:58:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:37410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728853AbfAVO6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:58:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13C1021721;
        Tue, 22 Jan 2019 14:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548169097;
        bh=G+WQwcnRE6zahJRQhFFcfB73LCT5sulYYfaDDPTEdgE=;
        h=From:To:Cc:Subject:Date:From;
        b=HPKbAz+HYESv8on9lNks2mjfITHM4wNFsO1ZzzbDRaf3W9aM5yi0pwkKnIVXwYHzh
         0EtNQNN0mj/DPv9jzfUt/k/KbiP46RlNAWyPJZtjHZK1q425Mug9M/kJv3hvAejqHz
         I8//Q9tSjXwPh28bicuGGK0g9+W4ctW5lKykx7k0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        John Crispin <john@phrozen.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/5] mips: cleanup debugfs usage
Date:   Tue, 22 Jan 2019 15:57:37 +0100
Message-Id: <20190122145742.11292-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs code, there is no need to ever check the return
value of the call, as no logic should ever change if a call works
properly or not.  Fix up a bunch of x86-specific code to not care about
the results of debugfs.

Greg Kroah-Hartman (5):
  mips: cavium: no need to check return value of debugfs_create
    functions
  mips: ralink: no need to check return value of debugfs_create
    functions
  mips: mm: no need to check return value of debugfs_create functions
  mips: math-emu: no need to check return value of debugfs_create
    functions
  mips: kernel: no need to check return value of debugfs_create
    functions

 arch/mips/cavium-octeon/oct_ilm.c     | 31 ++++-----------------------
 arch/mips/kernel/mips-r2-to-r6-emul.c | 21 ++++--------------
 arch/mips/kernel/segment.c            | 15 +++----------
 arch/mips/kernel/setup.c              |  7 +-----
 arch/mips/kernel/spinlock_test.c      | 21 ++++--------------
 arch/mips/kernel/unaligned.c          | 16 ++++----------
 arch/mips/math-emu/me-debugfs.c       | 23 ++++----------------
 arch/mips/mm/sc-debugfs.c             | 15 +++----------
 arch/mips/ralink/bootrom.c            |  8 +------
 9 files changed, 28 insertions(+), 129 deletions(-)

-- 
2.20.1

