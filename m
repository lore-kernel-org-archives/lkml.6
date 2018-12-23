Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85710C43444
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 03:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC7621721
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 03:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405155AbeLWDXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 22:23:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:51108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731060AbeLWDXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 22:23:37 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59E822171F;
        Sun, 23 Dec 2018 03:23:35 +0000 (UTC)
Date:   Sat, 22 Dec 2018 22:23:33 -0500
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
Message-ID: <20181222222333.78eaa7ce@vmware.local.home>
In-Reply-To: <20181223031343.GB11421@danjae.aot.lge.com>
References: <20181221231924.4583e90b@vmware.local.home>
        <20181222093346.GB7610@danjae.aot.lge.com>
        <20181222072404.27a7e9a3@vmware.local.home>
        <20181222142411.GA10058@danjae.aot.lge.com>
        <20181222101244.7da017c9@vmware.local.home>
        <20181222111630.24a4444a@vmware.local.home>
        <20181222164605.GA10792@danjae.aot.lge.com>
        <20181222121911.68603488@vmware.local.home>
        <20181222122335.7fee7e5e@vmware.local.home>
        <20181222122454.63bba1ac@vmware.local.home>
        <20181223031343.GB11421@danjae.aot.lge.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2018 12:13:43 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> > Also, I believe there are some memcmp implementations that start at the
> > end of the memory locations, not the beginning. That is, it compares
> > backwards. Which is also legit for memcmp to do.  
> 
> I'm not sure, the man page says:
> 
>     RETURN VALUE
>        The memcmp() function returns an integer less than, equal to,
>        or greater than zero if the first n bytes of s1 is found,
>        respectively, to be less than, to match, or be greater than
>        the first n bytes of s2.
> 
>        For a nonzero return value, the sign is determined by the sign
>        of the difference between the first pair of bytes (interpreted
>        as unsigned char) that differ in s1 and s2.
> 
>        If n is zero, the return value is zero.
> 
> 
> It should return difference in the first pair of bytes that differ so
> I guess implementations should compare from the beginning.

Ah, makes sense. I think I'm thinking of memcpy() which can start at
the end, or maybe even the deprecated bcmp(). It's been a long time
since I had to deal with the implementations of these.

-- Steve
