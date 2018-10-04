Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3846BC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E498C2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPehwE+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E498C2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbeJEEkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbeJEEkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:40:14 -0400
Received: from localhost (unknown [198.217.64.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1242C2084D;
        Thu,  4 Oct 2018 21:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538689496;
        bh=A9uxb9b+cp4vUePyAC7tCrECc4U8aOY9HhBfRqGQUEo=;
        h=From:To:Cc:Subject:Date:From;
        b=dPehwE+0uhNmA697crHMGnG5Z2btaEa4NeEWmqtOBKXi2LQ214VOqytfXxQVnDPUm
         Ewq4Ibabd8xzcpvQidHtIfraWxheMgtgja56wFf5lzr4c1zkUhmUg6DZBLFGLILM2A
         3W/7i41/1+UGVjui78KlelFtp8ORsZZXQlg0/HMc=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 0/3] x86/vdso: Minor improvements
Date:   Thu,  4 Oct 2018 14:44:42 -0700
Message-Id: <cover.1538689401.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi tglx,

This little series applies on top of your patches and, at least on
my laptop, gets back all the performance you lost and then some :)

--Andy

Andy Lutomirski (3):
  x86/vdso: Remove "memory" clobbers in the vDSO syscall fallbacks
  x86/vdso: Rearrange do_hres() to improve code generation
  x86/vdso: Document vgtod_ts better

 arch/x86/entry/vdso/vclock_gettime.c | 9 ++++-----
 arch/x86/include/asm/vgtod.h         | 9 +++++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

-- 
2.17.1

