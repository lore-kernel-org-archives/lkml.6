Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27217C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 19:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13962087E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 19:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="kaBa1cqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13962087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933116AbeFPTpE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 15:45:04 -0400
Received: from mail.efficios.com ([167.114.142.138]:51488 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932878AbeFPTpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 15:45:03 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 7A7E81B0DB5;
        Sat, 16 Jun 2018 15:45:02 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id iKdGCMOYKdP7; Sat, 16 Jun 2018 15:45:02 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 20E041B0DB0;
        Sat, 16 Jun 2018 15:45:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 20E041B0DB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1529178302;
        bh=9vqTt1QjrVOj1I0Il40X1FwjMbid8+qfeTHaH3UWPMs=;
        h=From:To:Date:Message-Id;
        b=kaBa1cqpoqBNQsJGfX+6nfTKq9aFcvLJe5Q3EeN7V0eBw8uJfy4EY4qkydawC/HiS
         fTCYtPJOX4JeINkrCgt/RMpnE0iMXSrbyyyJKI0rTxamZKXn6GByY7Jtbns+FNehmH
         F4UEL8dxOY5yUkKWShgWbrruOcQVcsiGBS0T5yfy027TTlgvSqRcHepR0IA6+jpTyk
         GHsx1efI98bXLCCQa/ZlA9x5CCngMXIeyvH7GCUfeM9Rrt6bM82Ye5C/pMXJZdyvV0
         2ravpou+qdKwAMGsV0gdNtno5eKhnVhRg9VN2K4vCYzk+GGIDmQravrQisqYSzckXF
         OJY/sj0TyNKNA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 9zC6V1ptowZJ; Sat, 16 Jun 2018 15:45:02 -0400 (EDT)
Received: from thinkos.etherlink (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id CB55C1B0DAB;
        Sat, 16 Jun 2018 15:45:01 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH for 4.18 0/2] Restartable Sequences selftests fixes
Date:   Sat, 16 Jun 2018 15:44:54 -0400
Message-Id: <20180616194456.26159-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those are trivial restartable sequences selftest fixes for 4.18.

The executable flag of run_param_test.sh got lost in the merge of the
rseq patchset.

On ARM, align the struct rseq_cs definition in the inline asm to match
the alignment of that structure in the uapi headers.

Thanks,

Mathieu

Mathieu Desnoyers (2):
  rseq/selftests: run_param_test.sh should be executable
  rseq/selftests: arm: align struct rseq_cs on 32 bytes

 tools/testing/selftests/rseq/rseq-arm.h        | 1 +
 tools/testing/selftests/rseq/run_param_test.sh | 0
 2 files changed, 1 insertion(+)
 mode change 100644 => 100755 tools/testing/selftests/rseq/run_param_test.sh

-- 
2.11.0

