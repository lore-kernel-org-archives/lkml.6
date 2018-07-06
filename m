Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722B4C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8D723FAA
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8D723FAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933109AbeGFPty (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:49:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932849AbeGFPtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:49:53 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDDA223F9C;
        Fri,  6 Jul 2018 15:49:52 +0000 (UTC)
Date:   Fri, 6 Jul 2018 11:49:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C. Harding" <me@tobin.cc>, Theodore Ts'o <tytso@mit.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsprintf: fix build warning
Message-ID: <20180706114951.6e739180@gandalf.local.home>
In-Reply-To: <20180706144213.GA411@tigerII.localdomain>
References: <20180706134724.563799-1-arnd@arndb.de>
        <20180706144213.GA411@tigerII.localdomain>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2018 23:42:13 +0900
Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:

> On (07/06/18 15:47), Arnd Bergmann wrote:
> [..]
> > Fixes: bfe80ed3d7c7 ("vsprintf: add command line option debug_boot_weak_hash")  
> 
> Seems like this one is still in linux-next.
> Can we squash this patch and bfe80ed3d7c7?
> 

I prefer not to do squashes unless absolutely necessary. Yes, it is in
next, but even branches pulled into next should try to resist rebasing
(I never rebase my next branch unless there is a real bug that will
break bisecting).

As this is just a warning fix, and not something that should break any
bisect, I say keep it separate. Rebases tend to cause issues.

-- Steve
