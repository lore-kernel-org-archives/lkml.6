Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA48C43614
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 00:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A2021934
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 00:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393069AbeLWAzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 19:55:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:43224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393055AbeLWAzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 19:55:05 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D9CA218F0;
        Sun, 23 Dec 2018 00:55:03 +0000 (UTC)
Date:   Sat, 22 Dec 2018 19:55:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: Re: [for-next][PATCH 0/5] tracing: Add string_has_prefix() and
 usages
Message-ID: <20181222195502.3951b626@vmware.local.home>
In-Reply-To: <20181222162007.697862256@goodmis.org>
References: <20181222162007.697862256@goodmis.org>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2018 11:20:07 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> They ran through all my tests, althought zero-day-bot had a weird build
> regression in sh, that looks totally unrelated:
> 
>  Regressions in current branch:
> 
>  arch/sh/kernel/dwarf.c:107:26: error: 'dwarf_frame_reg' defined but not used [-Werror=unused-function]
>  arch/sh/kernel/dwarf.c:1209:0: error: unterminated argument list invoking macro "WARN_ON"
>  arch/sh/kernel/dwarf.c:226:12: error: 'dwarf_read_encoded_value' defined but not used [-Werror=unused-function]
>  arch/sh/kernel/dwarf.c:306:26: error: 'dwarf_lookup_cie' defined but not used [-Werror=unused-function]
>  arch/sh/kernel/dwarf.c:38:27: error: 'dwarf_frame_cachep' defined but not used [-Werror=unused-variable]
>  arch/sh/kernel/dwarf.c:399:12: error: 'dwarf_cfa_execute_insns' defined but not used [-Werror=unused-function]
>  arch/sh/kernel/dwarf.c:41:27: error: 'dwarf_reg_cachep' defined but not used [-Werror=unused-variable]
>  arch/sh/kernel/dwarf.c:580:22: error: unused variable 'frame' [-Werror=unused-variable]
>  arch/sh/kernel/dwarf.c:581:20: error: unused variable 'cie' [-Werror=unused-variable]
>  arch/sh/kernel/dwarf.c:582:20: error: unused variable 'fde' [-Werror=unused-variable]
>  arch/sh/kernel/dwarf.c:583:20: error: unused variable 'reg' [-Werror=unused-variable]
>  arch/sh/kernel/dwarf.c:584:16: error: unused variable 'addr' [-Werror=unused-variable]
>  arch/sh/kernel/dwarf.c:622:3: error: expected ';' at end of input
>  arch/sh/kernel/dwarf.c:622:3: error: expected declaration or statement at end of input
>  arch/sh/kernel/dwarf.c:622:3: error: 'WARN_ON' undeclared (first use in this function); did you mean 'WMARK_LOW'?
> 
> Pushing to my for-next branch should kick off another run. Let's see
> if it reports that again. Unless someone knows why that happened?


FYI,

Zeroday reported back a successful run of my for-next branch, and did
it again, after I pushed a rebase that added an Acked-by. Thus, I'm
guessing that the above is a simple fluke.

-- Steve
