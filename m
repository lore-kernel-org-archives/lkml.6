Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723F3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 23:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3105320861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 23:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3105320861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbeKXJzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 04:55:55 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41092 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbeKXJzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 04:55:55 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C67A2ACA;
        Fri, 23 Nov 2018 23:09:44 +0000 (UTC)
Date:   Fri, 23 Nov 2018 15:09:43 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] locking/atomics: build atomic headers as required
Message-Id: <20181123150943.ddf22393b568131a3383fd02@linux-foundation.org>
In-Reply-To: <20181123153321.8561-1-mark.rutland@arm.com>
References: <20181123153321.8561-1-mark.rutland@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018 15:33:21 +0000 Mark Rutland <mark.rutland@arm.com> wrote:

> Andrew and Ingo report that the check-atomics.sh script is simply too
> slow to run for every kernel build, and it's impractical to make it
> faster without rewriting it in something other than shell.
> 
> Rather than committing the generated headers, let's regenerate these
> as-required for a pristine tree.
> 
> That ensures they're always up-to-date, allows them to be built in
> parallel, and avoid redundant rebuilds, which is a 2-8s saving per
> incremental build. Since the results are not committed, it's very
> obvious that they should not be modified directly. If we need to
> generate more headers in future, it's easy to extend Makefile.genheader
> to permit this.
> 
> I've verified that this works in the cases we previously had issues with
> (out-of-tree builds and where scripts have no execute permissions), and
> have tested these cases for both x86_64 and arm64.

Seems like a reasonable compromise.  I'll take a copy for testing now,
shall drop that when this appears in tip->linux-next.

