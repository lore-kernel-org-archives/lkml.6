Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E030C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3CC21473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNbYdvRs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3CC21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbeJBCbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:31:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbeJBCbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:31:40 -0400
Received: from localhost (c-71-202-137-17.hsd1.ca.comcast.net [71.202.137.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9BD32146D;
        Mon,  1 Oct 2018 19:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538423537;
        bh=zqM7VbUwzRiniVv8GQvZFzJFMiMI1fqMcHgNqrDqpxg=;
        h=From:To:Cc:Subject:Date:From;
        b=mNbYdvRsw3x52oSUxbP4E6ZenIISogw2jDwGQaX7Vf2qnPegx+X59Vk1teHgnLll2
         6sKse+S9KKHHLxt94vK0xfHXMskw/KghDcKoZqZmn7Rmq23GVsrHP5llB5djQQWeTN
         1bgxcabnpC6WUS2T5vWTXJVjAo4twiUwrwfHlYpQ=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 0/2] x86/vdso: A bugfix and a selftest
Date:   Mon,  1 Oct 2018 12:52:14 -0700
Message-Id: <cover.1538422295.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas-

In preparation for your big rewrite, here is a bugfix and a
selftest.  I marked both for -stable.  If you commit them, it might
be nice to insert the commit hash for the first patch into the
changelog for the second patch.  I obviously can't do that myself :)

Andy Lutomirski (2):
  x86/vdso: Fix asm constraints on vDSO syscall fallbacks
  selftests/x86: Add clock_gettime() tests to test_vdso

 arch/x86/entry/vdso/vclock_gettime.c    | 18 +++--
 tools/testing/selftests/x86/test_vdso.c | 99 +++++++++++++++++++++++++
 2 files changed, 109 insertions(+), 8 deletions(-)

-- 
2.17.1

