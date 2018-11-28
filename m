Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D15C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151C0208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151C0208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbeK2BNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:13:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:39186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbeK2BNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:13:51 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1DE020832;
        Wed, 28 Nov 2018 14:12:02 +0000 (UTC)
Date:   Wed, 28 Nov 2018 09:12:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 0/2] panic: Add options to dump system info on panic
Message-ID: <20181128091201.7dd80c92@gandalf.local.home>
In-Reply-To: <1543398842-19295-1-git-send-email-feng.tang@intel.com>
References: <1543398842-19295-1-git-send-email-feng.tang@intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 17:54:00 +0800
Feng Tang <feng.tang@intel.com> wrote:

> Kernel panic issues are always painful to debug, partially
> because it's not easy to get enough information of the
> context when panic happens.
> 
> And we have ramoops and kdump for that, while this commit
> tries to provide a easier way to show the system info by adding
> a cmdline parameter, referring some idea from sysrq handler.
> 
> The patches have been used by us and did help on solving some nasty
> panic cases.
> 
> Please help to review, thanks!
> 

Looks fine to me.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Although, I still wonder if we should add a comment stating that bit 4
is the same as ftrace_dump_on_oops.

-- Steve
