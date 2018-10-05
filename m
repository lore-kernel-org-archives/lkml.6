Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8D3C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6CC2208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6CC2208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbeJFD3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:29:23 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:44922 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728139AbeJFD3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:29:23 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 5 Oct 2018 13:29:00 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id BA22B4032C;
        Fri,  5 Oct 2018 13:29:02 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH 0/3] Macrofying inline asm rebased
Date:   Fri, 5 Oct 2018 13:27:15 -0700
Message-ID: <20181005202718.229565-1-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005093108.GA24723@gmail.com>
References: <20181005093108.GA24723@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are the last 3 patches from the "macrofying inline asm" series
after rebasing on TIP, per Ingo's request.

For the record: the new commit log was written by Ingo.

Link: https://lore.kernel.org/lkml/20181003213100.189959-11-namit@vmware.com/T/#m28ed17da046354dd8d897ff9703561ac3fd71410

Nadav Amit (3):
  x86/extable: Macrofy inline assembly code to work around GCC inlining
    bugs
  x86/cpufeature: Macrofy inline assembly code to work around GCC
    inlining bugs
  x86/jump-labels: Macrofy inline assembly code to work around GCC
    inlining bugs

 arch/x86/entry/calling.h          |  2 +-
 arch/x86/include/asm/asm.h        | 53 ++++++++------------
 arch/x86/include/asm/cpufeature.h | 82 ++++++++++++++++++-------------
 arch/x86/include/asm/jump_label.h | 72 +++++++--------------------
 arch/x86/kernel/macros.S          |  3 ++
 5 files changed, 89 insertions(+), 123 deletions(-)

-- 
2.17.1

