Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D5DC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6DC21A4E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391383AbeLVRY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:24:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:55612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731167AbeLVRY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:24:58 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 518A521974;
        Sat, 22 Dec 2018 17:24:56 +0000 (UTC)
Date:   Sat, 22 Dec 2018 12:24:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>, kernel-team@lge.com
Subject: Re: [PATCH v4] string.h: Add str_has_prefix() helper function
Message-ID: <20181222122454.63bba1ac@vmware.local.home>
In-Reply-To: <20181222122335.7fee7e5e@vmware.local.home>
References: <20181221231924.4583e90b@vmware.local.home>
        <20181222093346.GB7610@danjae.aot.lge.com>
        <20181222072404.27a7e9a3@vmware.local.home>
        <20181222142411.GA10058@danjae.aot.lge.com>
        <20181222101244.7da017c9@vmware.local.home>
        <20181222111630.24a4444a@vmware.local.home>
        <20181222164605.GA10792@danjae.aot.lge.com>
        <20181222121911.68603488@vmware.local.home>
        <20181222122335.7fee7e5e@vmware.local.home>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2018 12:23:35 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 22 Dec 2018 12:19:11 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Because memcmp() isn't required to test byte by byte. In fact, most
> > implementations don't which is why memcmp is faster than strcncmp.  
> 
> In fact, if memcmp() was safe to use if we only knew the size of one of
> the parameters, then there would be no reason for strncmp to exist.
>

Also, I believe there are some memcmp implementations that start at the
end of the memory locations, not the beginning. That is, it compares
backwards. Which is also legit for memcmp to do.

-- Steve
