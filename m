Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664FCC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249F8271D4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249F8271D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753704AbeF1Mdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:33:55 -0400
Received: from foss.arm.com ([217.140.101.70]:46634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752178AbeF1Mdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:33:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08D1A18A;
        Thu, 28 Jun 2018 05:33:54 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BE6F53F5C0;
        Thu, 28 Jun 2018 05:33:51 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akiyks@gmail.com, andrea.parri@amarulasolutions.com,
        boqun.feng@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, mark.rutland@arm.com, npiggin@gmail.com,
        paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        stern@rowland.harvard.edu, will.deacon@arm.com
Subject: [PATCH 0/2] tools/memory-model: remove ACCESS_ONCE()
Date:   Thu, 28 Jun 2018 13:33:45 +0100
Message-Id: <20180628123347.52963-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit:
    
  b899a850431e2dd0 ("compiler.h: Remove ACCESS_ONCE()")
    
... there has been no definition of ACCESS_ONCE() in the kernel tree,
and it has been necessary to use READ_ONCE() or WRITE_ONCE() instead.

However, since then the kernel memory model was added to the Linux tree,
sporting new instances of ACCESS_ONCE() in examples and in the memory
model itself.

These patches remove the new instances of ACCESS_ONCE() for consistency
with the contemporary codebase.

Thanks,
Mark.

Mark Rutland (2):
  tools/memory-model: remove ACCESS_ONCE() from recipes
  tools/memory-model: remove ACCESS_ONCE() from model

 tools/memory-model/Documentation/recipes.txt | 4 ++--
 tools/memory-model/linux-kernel.bell         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.11.0

