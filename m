Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F21C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 02:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B634E20C0C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 02:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B634E20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbeHTF3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 01:29:02 -0400
Received: from exmail.andestech.com ([59.124.169.137]:63406 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbeHTF3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 01:29:02 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w7K2DMSe072820;
        Mon, 20 Aug 2018 10:13:22 +0800 (GMT-8)
        (envelope-from zong@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Mon, 20 Aug 2018
 10:15:11 +0800
From:   Zong Li <zong@andestech.com>
To:     <green.hu@gmail.com>, <linux-kernel@vger.kernel.org>
CC:     <zongbox@gmail.com>, <greentime@andestech.com>,
        Zong Li <zong@andestech.com>
Subject: [PATCH 0/2] Remove the deprecated ABI implementation
Date:   Mon, 20 Aug 2018 10:15:03 +0800
Message-ID: <cover.1534730156.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w7K2DMSe072820
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches remove the implementation of NDS32_ABI_2 and
replace the magic number of offset of lp on stack.

In stacktrace.c, we dump the stack without considering the old
ABI, it should be consistent in traps.c.

Zong Li (2):
  nds32: Remove the deprecated ABI implementation
  nds32: Add macro definition for offset of lp register on stack

 arch/nds32/include/asm/nds32.h | 1 +
 arch/nds32/kernel/stacktrace.c | 2 +-
 arch/nds32/kernel/traps.c      | 7 +------
 3 files changed, 3 insertions(+), 7 deletions(-)

-- 
2.7.4

