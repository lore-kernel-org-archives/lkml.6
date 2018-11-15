Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209A6C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4BF2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4BF2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388931AbeKPJNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 04:13:50 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46620 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbeKPJNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 04:13:49 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 00D1B89B;
        Thu, 15 Nov 2018 23:03:58 +0000 (UTC)
Date:   Thu, 15 Nov 2018 15:03:58 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     mingo@kernel.org, arnd@arndb.de, aryabinin@virtuozzo.com,
        boqun.feng@gmail.com, catalin.marinas@arm.com, dvyukov@google.com,
        glider@google.com, linuxdrivers@attotech.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will.deacon@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv3 1/6] atomics: add common header generation files
Message-Id: <20181115150358.c5e816ded563af0643269c91@linux-foundation.org>
In-Reply-To: <20180904104830.2975-2-mark.rutland@arm.com>
References: <20180904104830.2975-1-mark.rutland@arm.com>
        <20180904104830.2975-2-mark.rutland@arm.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  4 Sep 2018 11:48:25 +0100 Mark Rutland <mark.rutland@arm.com> wrote:

> To minimize repetition, to allow for future rework, and to ensure
> regularity of the various atomic APIs, we'd like to automatically
> generate (the bulk of) a number of headers related to atomics.
> 
> This patch adds the infrastructure to do so, leaving actual conversion
> of headers to subsequent patches. This infrastructure consists of:

My build broke.

scripts/atomic/check-atomics.sh: line 16: scripts/atomic/gen-atomic-instrumented.sh: Permission denied
scripts/atomic/check-atomics.sh: line 16: scripts/atomic/gen-atomic-long.sh: Permission denied
scripts/atomic/check-atomics.sh: line 16: scripts/atomic/gen-atomic-fallback.sh: Permission denied



From: Andrew Morton <akpm@linux-foundation.org>
Subject: scripts/atomic/check-atomics.sh: don't assume that scripts are executable

patch(1) doesn't set the x bit on files.  So if someone downloads and
applies patch-4.21.xz, their kernel won't build.  Fix that by executing
/bin/sh.

Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 scripts/atomic/check-atomics.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/atomic/check-atomics.sh~scripts-atomic-check-atomicssh-dont-assume-that-scripts-are-executable
+++ a/scripts/atomic/check-atomics.sh
@@ -13,7 +13,7 @@ gen-atomic-long.sh              asm-gene
 gen-atomic-fallback.sh          linux/atomic-fallback.h
 EOF
 while read script header; do
-	if ! (${ATOMICDIR}/${script} ${ATOMICTBL} | diff - ${LINUXDIR}/include/${header} > /dev/null); then
+	if ! (/bin/sh ${ATOMICDIR}/${script} ${ATOMICTBL} | diff - ${LINUXDIR}/include/${header} > /dev/null); then
 		printf "warning: include/${header} is out-of-date.\n"
 	fi
 done
_

