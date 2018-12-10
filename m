Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8C8C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F51B20851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F51B20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbeLJRrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:47:15 -0500
Received: from foss.arm.com ([217.140.101.70]:59804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727324AbeLJRrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:47:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0E0215BF;
        Mon, 10 Dec 2018 09:47:14 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.196.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2326D3F6A8;
        Mon, 10 Dec 2018 09:47:13 -0800 (PST)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>
Subject: [RESEND PATCH 0/2] scripts/decode{code,_stacktrace} fixes
Date:   Mon, 10 Dec 2018 17:46:57 +0000
Message-Id: <20181210174659.31054-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending this, as there was hardly any feedback except for Will's
Ack. Andrew, can you please consider this?

Here's a couple of fixes that have been languishing in my tree for a
few months.

The first one is for an issue that can only be observed using
decodecode natively on arm/arm64m and resulting in a pretty useless
disassembly. The second one fixes the path trimming in
decode_stacktrace, and probably affects everyone.

Marc Zyngier (2):
  scripts/decodecode: Set ARCH when running natively on arm/arm64
  scripts/decode_stacktrace: Only strip base path when a prefix of the
    path

 scripts/decode_stacktrace.sh | 2 +-
 scripts/decodecode           | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.19.1

