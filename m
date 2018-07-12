Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA38FC476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C562147D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PNu5b4xx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C562147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbeGLQo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:44:58 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38536 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeGLQo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:44:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so6682027wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 09:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B95ZQWtMOu6t7IAHJNdiQ7hxhRcbu9URUALGrox6/MA=;
        b=PNu5b4xxhSZHwg3yhPxqecJyIUMuBIrHDUFhe46LO8pNEnkyjIcx/YHrS/ANDmgC00
         d+upLUjjW4g/DGmap1wdbfL1HlenwIyKRhXHJGcTGTWz6HrprnxiFxNWcEqxcEnRgRqU
         lUeh1vuINfSwJ8k2UjaNifX9dKsNUrqIeoEC7AkVbU8OVLDbqoO5UGc1/6aH04zHuZ7V
         74Ls1d4DhJ0JfFZy3affoMdLYD/xpvzk+tzA4qXxesHzerXiVls7VDQBgqOi5FxYylmn
         e1yOBr1cxAQs+AMTreluWgzpid2vJL0imBQdJIow5GGzMSdOsBk78nG50wXuxR4RkIip
         7+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B95ZQWtMOu6t7IAHJNdiQ7hxhRcbu9URUALGrox6/MA=;
        b=dehaoy+b6psDM7HL4xC6fjPvxjeUyNboW9Iv9RL4lX0cDTf0dq8LmlsRz8qkG1jqeI
         bpr23OHqbZYeNYyIAoLbnHQ3VwOzABIlT9vFQUuHCLztw35Fxv90EtqJc/zAZ5zf/zue
         jQklT8XIbmxMNfqY5rKNYrKrXTz0E19JU97Au5MHnEMnNPOyZNym51h4wbBFDxihalzX
         ChJx7UeUMt9ZoZTpd2/eMUZ/rN4VtI4PLQLrjnqBf46YofPb3DPzqytvERfxAZvup4mH
         kEWjTC3Vx7y4+Gw8KWWiQnxpupFBoc8x0gaisCSna9H4n6MXP8bEDnePWlVFlt7OxHjH
         4QOw==
X-Gm-Message-State: AOUpUlGaKHQVQTKgzYW2hAjhdc9G/K2OODWfjckxL/dXolanHQvCY+5X
        PzTorZLZbzIJ3fAw2mhZx7vqDReGQD1e4kaB6xiZQQ==
X-Google-Smtp-Source: AAOMgpcv97OUe8xrbCbfS+WaHvmeYraZFiYal5FkUVmQVXPiojGDcDV2jkOxz4jyGU5+qYacCyyqUXC/G5twk1g17y8=
X-Received: by 2002:a1c:9f86:: with SMTP id i128-v6mr1687994wme.156.1531413279574;
 Thu, 12 Jul 2018 09:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180712135202.14774-1-jolsa@kernel.org>
In-Reply-To: <20180712135202.14774-1-jolsa@kernel.org>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 12 Jul 2018 09:34:45 -0700
Message-ID: <CABPqkBQsecn6Tp3q5fG1KgqF49Js0cA7KPY=dRkWV37jsqDXmg@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Synthesize GROUP_DESC feature in pipe mode
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Carrillo Cisneros <davidcc@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,
On Thu, Jul 12, 2018 at 6:52 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Stephan reported, that pipe mode does not carry the group
> information and thus the piped report won't display the
> grouped output for following command:
>
Thanks for fixing this quickly.
I think we should have more testing on the pipe mode, in general.

>   # perf record -e '{cycles,instructions,branches}' -a sleep 4 | perf report
>
> It has no idea about the group setup, so it will display
> events separately:
>
>   # Overhead  Command          Shared Object             ...
>   # ........  ...............  .......................
>   #
>        6.71%  swapper          [kernel.kallsyms]
>        2.28%  offlineimap      libpython2.7.so.1.0
>        0.78%  perf             [kernel.kallsyms]
>   ...
>
> Fixing GROUP_DESC feature record to be synthesized in pipe mode,
> so the report output is grouped if there's group defined in record:
>
>   #                 Overhead  Command          Shared    ...
>   # ........................  ...............  .......
>   #
>        7.57%   0.16%   0.30%  swapper          [kernel
>        1.87%   3.15%   2.46%  offlineimap      libpyth
>        1.33%   0.00%   0.00%  perf             [kernel
>   ...
>
> Cc: David Carrillo-Cisneros <davidcc@google.com>
> Reported-by: Stephane Eranian <eranian@google.com>
> Link: http://lkml.kernel.org/n/tip-ybqyh8ac4g173iy3xt4pxnlo@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/header.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 59fcc790c865..af9aaf28f976 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2587,7 +2587,7 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
>         FEAT_OPR(NUMA_TOPOLOGY, numa_topology,  true),
>         FEAT_OPN(BRANCH_STACK,  branch_stack,   false),
>         FEAT_OPR(PMU_MAPPINGS,  pmu_mappings,   false),
> -       FEAT_OPN(GROUP_DESC,    group_desc,     false),
> +       FEAT_OPR(GROUP_DESC,    group_desc,     false),
>         FEAT_OPN(AUXTRACE,      auxtrace,       false),
>         FEAT_OPN(STAT,          stat,           false),
>         FEAT_OPN(CACHE,         cache,          true),
> --
> 2.17.1
>
