Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbeDLHxn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 03:53:43 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:36632 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752291AbeDLHxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 03:53:41 -0400
X-Google-Smtp-Source: AIpwx491g6tKj6duAWA3Yk5PHnTo6/FpwArkVreQy5va8kx18pwSfrdfubFbcsQqXSpJzLQVQHu7Zw==
Date: Thu, 12 Apr 2018 09:53:38 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Song Liu <songliubraving@fb.com>
Cc: Vince Weaver <vincent.weaver@maine.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: perf: fuzzer leads to trace_kprobe: Could not insert message
 flood
Message-ID: <20180412075338.tsu36qh2wcrcp36k@gmail.com>
References: <alpine.DEB.2.21.1804101043490.6068@macbook-air>
 <A3B3905F-3364-462A-BE02-B01D52482791@fb.com>
 <20180411120447.2gzrwijrtayjv3eg@gmail.com>
 <C0B2EFB5-C403-4BDB-9046-C14B3EE66999@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C0B2EFB5-C403-4BDB-9046-C14B3EE66999@fb.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Song Liu <songliubraving@fb.com> wrote:

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index d7af828..2d5fe26 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8400,6 +8400,10 @@ static int perf_kprobe_event_init(struct perf_event *event)
> 
>         if (event->attr.type != perf_kprobe.type)
>                 return -ENOENT;
> +
> +       if (!capable(CAP_SYS_ADMIN))
> +               return -EACCES;
> +
>         /*
>          * no branch sampling for probe events
>          */
> @@ -8437,6 +8441,10 @@ static int perf_uprobe_event_init(struct perf_event *event)
> 
>         if (event->attr.type != perf_uprobe.type)
>                 return -ENOENT;
> +
> +       if (!capable(CAP_SYS_ADMIN))
> +               return -EACCES;

This is seriously whitespace damaged: all tabs are spaces ...

Thanks,

	Ingo
