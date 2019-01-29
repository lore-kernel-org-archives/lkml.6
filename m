Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFA7C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2022184D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Tegt77JL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbfA2QID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:08:03 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34244 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfA2QID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:08:03 -0500
Received: from zn.tnic (p200300EC2BCC54006D3D030A08A1426E.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:5400:6d3d:30a:8a1:426e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B492D1EC03D8;
        Tue, 29 Jan 2019 17:08:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548778081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HdgZ0wl1cvI6dbA5ke3Lwjiy0lDA1ibLjGTTD7vcoTo=;
        b=Tegt77JLA3i8e3HSDAGpukCoqizj1tHc9yGzoJf8jYzVb6mInJsUt2sxfunrscXE8Chmzk
        R42lSDAmmqQWne7TMD5Wqq9kvL/XCnKLw4uYC5Nu+x4iMwUrQaHtwBv6PfiR40EzEKx1AU
        sXkHzdbv/wXORmSdfqYBikXpK4zZm9Y=
Date:   Tue, 29 Jan 2019 17:07:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/events: Mark expected switch fall-throughs
Message-ID: <20190129160753.GA27037@zn.tnic>
References: <20190125184917.GA7289@embeddedor>
 <20190129152500.GA25706@zn.tnic>
 <8aa46db0-6983-62c4-7dc6-e006d20cd84b@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8aa46db0-6983-62c4-7dc6-e006d20cd84b@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 09:58:05AM -0600, Gustavo A. R. Silva wrote:
> $ scripts/get_maintainer.pl --nokeywords --nogit --nogit-fallback arch/x86/events/intel/core.c

You need to have -f when supplying a file:

scripts/get_maintainer.pl -f arch/x86/events/intel/core.c

and the pattern is there:

PERFORMANCE EVENTS SUBSYSTEM
M:      Peter Zijlstra <peterz@infradead.org>
...
F:      arch/*/events/*

yet it still doesn't list Peter as maintainer:

Thomas Gleixner <tglx@linutronix.de> (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Ingo Molnar <mingo@redhat.com> (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT),commit_signer:21/22=95%)
Borislav Petkov <bp@alien8.de> (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
"H. Peter Anvin" <hpa@zytor.com> (reviewer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Peter Zijlstra <peterz@infradead.org> (commit_signer:19/22=86%,authored:3/22=14%,added_lines:22/382=6%,removed_lines:13/122=11%)
Kan Liang <kan.liang@linux.intel.com> (commit_signer:11/22=50%,authored:10/22=45%,added_lines:144/382=38%,removed_lines:73/122=60%)
Jiri Olsa <jolsa@kernel.org> (commit_signer:4/22=18%,authored:4/22=18%,added_lines:99/382=26%,removed_lines:32/122=26%)
Andi Kleen <ak@linux.intel.com> (added_lines:113/382=30%)
linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)

if you change the pattern to

F:      arch/*/events/

i.e., drop the '*', then it works:

$ scripts/get_maintainer.pl -f arch/x86/events/intel/core.c
Peter Zijlstra <peterz@infradead.org> (supporter:PERFORMANCE EVENTS SUBSYSTEM,commit_signer:19/22=86%,authored:3/22=14%,added_lines:22/382=6%,removed_lines:13/122=11%)
Ingo Molnar <mingo@redhat.com> (supporter:PERFORMANCE EVENTS SUBSYSTEM,commit_signer:21/22=95%)
Arnaldo Carvalho de Melo <acme@kernel.org> (supporter:PERFORMANCE EVENTS SUBSYSTEM)
Alexander Shishkin <alexander.shishkin@linux.intel.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
Jiri Olsa <jolsa@redhat.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM,commit_signer:4/22=18%,authored:4/22=18%,added_lines:99/382=26%,removed_lines:32/122=26%)
Namhyung Kim <namhyung@kernel.org> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
