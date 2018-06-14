Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0ACBDC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E70205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E70205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965166AbeFNXx3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 19:53:29 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:34608 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965001AbeFNXx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 19:53:27 -0400
Received: from mipsdag01.mipstec.com (mail1.mips.com [12.201.5.31]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Thu, 14 Jun 2018 23:52:55 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag01.mipstec.com
 (10.20.40.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Thu, 14
 Jun 2018 16:53:07 -0700
Received: from pburton-laptop.mipstec.com (10.20.2.29) by
 mipsdag02.mipstec.com (10.20.40.47) with Microsoft SMTP Server id 15.1.1415.2
 via Frontend Transport; Thu, 14 Jun 2018 16:53:07 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     <linux-mips@linux-mips.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        James Hogan <jhogan@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH 0/4] MIPS: Restartable sequences (rseq) support
Date:   Thu, 14 Jun 2018 16:52:06 -0700
Message-ID: <20180614235211.31357-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1529020375-321457-11388-11694-1
X-BESS-VER: 2018.7-r1806112253
X-BESS-Apparent-Source-IP: 12.201.5.31
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194071
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: linux-mips@linux-mips.org,peterz@infradead.org,jhogan@kernel.org,linux-kernel@vger.kernel.org,mathieu.desnoyers@efficios.com,boqun.feng@gmail.com,paulmck@linux.vnet.ibm.com,ralf@linux-mips.org
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements MIPS support for restartable sequences, hooks up
the rseq syscall & implements MIPS support in the rseq selftests.

Applies atop Linus' master as of 2837461dbe6f ("Merge tag 'scsi-fixes'
of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi").

Thanks,
    Paul

Paul Burton (4):
  MIPS: Add support for restartable sequences
  MIPS: Add syscall detection for restartable sequences
  MIPS: Wire up the restartable sequences (rseq) syscall
  rseq/selftests: Implement MIPS support

 arch/mips/Kconfig                         |   1 +
 arch/mips/include/uapi/asm/unistd.h       |  15 +-
 arch/mips/kernel/entry.S                  |   8 +
 arch/mips/kernel/scall32-o32.S            |   1 +
 arch/mips/kernel/scall64-64.S             |   1 +
 arch/mips/kernel/scall64-n32.S            |   1 +
 arch/mips/kernel/scall64-o32.S            |   1 +
 arch/mips/kernel/signal.c                 |   3 +
 tools/testing/selftests/rseq/param_test.c |  24 +
 tools/testing/selftests/rseq/rseq-mips.h  | 725 ++++++++++++++++++++++
 tools/testing/selftests/rseq/rseq.h       |   2 +
 11 files changed, 776 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/rseq-mips.h

-- 
2.17.1

