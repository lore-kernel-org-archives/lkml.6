Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D871C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015BC20671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 015BC20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732120AbeGZUnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:43:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36716 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732070AbeGZUnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:43:50 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D0D19D08;
        Thu, 26 Jul 2018 19:25:34 +0000 (UTC)
Date:   Thu, 26 Jul 2018 12:25:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] checkpatch: check for function calls with struct or
 union on stack
Message-Id: <20180726122533.104f6eea950853ef50ebc680@linux-foundation.org>
In-Reply-To: <1236369d28b2f1f5389ff652c4eb89e699e6481e.camel@perches.com>
References: <1236369d28b2f1f5389ff652c4eb89e699e6481e.camel@perches.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018 11:27:50 -0700 Joe Perches <joe@perches.com> wrote:

> I was cc'd on a patch where structs were used on stack instead
> of using pointers to the structs.

"passed by value" is a good term for this practice.

  This can cause defects when
> the calling function modifies the stack struct instead of the

     "called"

> calling function's struct.
> 
> Possible patch below, but it may be overkill for the number of
> instances
> where this is actually an issue.
> 
> Thoughts?

Seems worthwhile.

> There are what seems to be some false positives for a few of the
> .h files in include/linux/... where the false positives are for
> very small structs where the indirection via a pointer might be
> slower than than the stack use.
> 
> For instance: (some duplicates removed)

I'll give it a spin, see how noisy it is.
