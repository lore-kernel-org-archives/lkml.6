Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753217AbeCNFDR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 01:03:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750758AbeCNFDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 01:03:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD62C214D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
From: Andy Lutomirski <luto@kernel.org>
To: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Stas Sergeev <stsp@list.ru>,
        bartoldeman@gmail.com, Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 0/3] x86/vm86/32: A bugfix and a matching test improvement
Date: Tue, 13 Mar 2018 22:03:09 -0700
Message-Id: <cover.1521003603.git.luto@kernel.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A patch in 4.2 broke vm86's POPF emulation in a way that was
somehow subtle enough that no one noticed until now.  Fix it
and improve the test case to exercise the code.

(The improved test case also exercises some code paths that were *not*
 broken but that would have become broken if Stas' original suggested
 patch were applied.  Go testing!)

Andy Lutomirski (3):
  selftests/x86/entry_from_vm86: Exit with 1 if we fail
  selftests/x86/entry_from_vm86: Add test cases for POPF
  x86/vm86/32: Fix POPF emulation

 arch/x86/kernel/vm86_32.c                     |  3 ++-
 tools/testing/selftests/x86/entry_from_vm86.c | 32 +++++++++++++++++++++++----
 2 files changed, 30 insertions(+), 5 deletions(-)

-- 
2.14.3
