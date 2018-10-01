Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB15C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36582213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S9dtBJ43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36582213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbeJAVak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:30:40 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36064 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729439AbeJAVak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:30:40 -0400
Received: by mail-it1-f196.google.com with SMTP id c85-v6so11819697itd.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 07:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nuQMH4QyUZbI9PbzAUc4fniTl9pvLrgey7B00sVGezI=;
        b=S9dtBJ43cBMbBIDbp0SI5ULlMJ8M3zqP6cyJ01GxhFAKzTQ1aNztI6FJAaVFBCAey2
         W0YI+zItupfpfk48mhc7ZsZd18Z+Da7si2+MQo0V//Vz90Aa0ymj7vV/ZSC47omE0qDQ
         7vhnr43UK5MzK/5jFmFDgSoN1OYlUYK3J5ImY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nuQMH4QyUZbI9PbzAUc4fniTl9pvLrgey7B00sVGezI=;
        b=H03eOTha6JEpBSE3Hvyqd9DZ9AHpIneVghcsG5XgLCMi5X6oeFXmAu/2XfAu09CqY5
         rqgFdnchsX6ynOtdryo7C3lHoryJ+3d8J547tPb/gnH+rtehEadVlzzswYCc2X5Cukfu
         d8BjbqLibbDv9txyoTswfz0+cs3NhXMNQ8ZT7QkyqLugl18yAVj4Q+fHYH1MRDqJlr3Q
         7B+xkQDi2WeXSA7astyEMiGHWLrWs9j+MyllNHxn3px8gtTYkbgh/nZ+H/qGDpTAOhDL
         R+QbcJooIFiJcwLobHhW9CzPrD+vjf4YIKd9QnpNxQQUdmqu2mSbjDQiSbgG27gsWEY2
         jZ4Q==
X-Gm-Message-State: ABuFfog+LDmfF49xBzG7f2IdaKkiCCbt4bLqwD7xdBvc4CzzzvxlR2gh
        Akjg/dyw/BJbEvFvxaRrrQPJAMBWbVzCZJWjoAcDUw==
X-Google-Smtp-Source: ACcGV60BSfa1IQCcqPz0sLhsT6JITK0OFrIsJDAsAUS4NDvJMD0GLA/hjN0+ACPhG/+V2/tCowzhukUv/pQub85YdIA=
X-Received: by 2002:a24:e48e:: with SMTP id o136-v6mr10130760ith.58.1538405548344;
 Mon, 01 Oct 2018 07:52:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 07:52:27 -0700 (PDT)
In-Reply-To: <20181001141643.331EE68BC7@newverein.lst.de>
References: <20181001140910.086E768BC7@newverein.lst.de> <20181001141643.331EE68BC7@newverein.lst.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 1 Oct 2018 16:52:27 +0200
Message-ID: <CAKv+Gu-ZtJ-BpfPWU=soDCb2+dAd81p8OtaarWhmTe+Fk6A8ig@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] DYNAMIC_FTRACE configurable with and without REGS
To:     Torsten Duwe <duwe@lst.de>
Cc:     Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Torsten,

On 1 October 2018 at 16:16, Torsten Duwe <duwe@lst.de> wrote:
> In commit 06aeaaeabf69da4, many ftrace-related config options are
> consolidated. By accident, I guess, the choice about DYNAMIC_FTRACE
> and DYNAMIC_FTRACE_WITH_REGS is no longer available explicitly but
> determined by the sole availability on the architecture.
>
> This makes it hard to introduce DYNAMIC_FTRACE_WITH_REGS if it depends
> on new compiler features or other new properties of the toolchain
> without breaking existing configurations.
>
> This patch turns the def_bool into an actual choice. Should the toolchain
> not meet the requirements for _WITH_REGS it can be turned off.
>

I guess we now have Kbuild/Kconfig support for this, no? I mean, we
can now show/hide options depending on the capabilities of the
toolchain.

I am not saying it would be a better approach, though - I'd rather
have a warning than have things silently disabled, but other people
may think differently.


> Signed-off-by: Torsten Duwe <duwe@suse.de>
>
>
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -508,9 +508,15 @@ config DYNAMIC_FTRACE
>           otherwise has native performance as long as no tracing is active.
>
>  config DYNAMIC_FTRACE_WITH_REGS
> -       def_bool y
> +       bool "Include register content tracking in dynamic ftrace facility"
> +       default y
>         depends on DYNAMIC_FTRACE
>         depends on HAVE_DYNAMIC_FTRACE_WITH_REGS
> +       help
> +         This architecture supports the inspection of register contents,
> +         as passed between functions, at the dynamic ftrace points.
> +         This is also a prerequisite for Kernel Live Patching (KLP).
> +         When in doubt, say Y.
>
>  config FUNCTION_PROFILER
>         bool "Kernel function profiler"
