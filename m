Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506FBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7572145D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7572145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388937AbeKPJUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 04:20:42 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46812 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeKPJUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 04:20:42 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 74614BBF;
        Thu, 15 Nov 2018 23:10:49 +0000 (UTC)
Date:   Thu, 15 Nov 2018 15:10:48 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     mingo@kernel.org, arnd@arndb.de, aryabinin@virtuozzo.com,
        boqun.feng@gmail.com, catalin.marinas@arm.com, dvyukov@google.com,
        glider@google.com, linuxdrivers@attotech.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will.deacon@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv3 1/6] atomics: add common header generation files
Message-Id: <20181115151048.26244bad301a3bcb9a450060@linux-foundation.org>
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
> of headers to subsequent patches.

This thing is appallingly slow.  `sh scripts/atomic/check-atomics.sh'
takes 8 seconds on a machine which builds an allnoconfig kernel in 30
seconds.

Um, no.  Just no.  Please find a way to make this overhead go away.
