Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD942C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75270218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfBKL4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 06:56:49 -0500
Received: from foss.arm.com ([217.140.101.70]:46390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfBKL4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 06:56:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9C8C80D;
        Mon, 11 Feb 2019 03:56:48 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02D653F557;
        Mon, 11 Feb 2019 03:56:45 -0800 (PST)
Date:   Mon, 11 Feb 2019 11:56:43 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Torsten Duwe <duwe@lst.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v8 3/5] arm64: replace -pg with CC_FLAGS_FTRACE in
 mm/kasan Makefile
Message-ID: <20190211115643.GC10501@lakrids.cambridge.arm.com>
References: <20190208150826.44EBC68DD2@newverein.lst.de>
 <20190208151014.CD48668DDC@newverein.lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208151014.CD48668DDC@newverein.lst.de>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 04:10:14PM +0100, Torsten Duwe wrote:
>   In preparation for arm64 supporting ftrace built on other compiler
>   options, let's have makefiles remove the $(CC_FLAGS_FTRACE)
>   flags, whatever these may be, rather than assuming '-pg'.
> 
>   There should be no functional change as a result of this patch.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>

With the indentation removed from the commit text:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> 
> ---
>  mm/kasan/Makefile |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> --- a/mm/kasan/Makefile
> +++ b/mm/kasan/Makefile
> @@ -5,8 +5,8 @@ UBSAN_SANITIZE_generic.o := n
>  UBSAN_SANITIZE_tags.o := n
>  KCOV_INSTRUMENT := n
>  
> -CFLAGS_REMOVE_common.o = -pg
> -CFLAGS_REMOVE_generic.o = -pg
> +CFLAGS_REMOVE_common.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_generic.o = $(CC_FLAGS_FTRACE)
>  # Function splitter causes unnecessary splits in __asan_load1/__asan_store1
>  # see: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63533
>  
