Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A3BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 04:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461FE206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 04:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550897817;
	bh=zjZwrt22t8d6qIRP3daR5ABYLm307PBuxtBmhLocgC8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gBB+2ivUnAsPTxGetLHj9RPNzCZQxp6vcMJcZypmqd3GUzZxZIaiOa2e47ZToPf43
	 u9q6SwLiVp/QhRJ/VoxPKGKwEKDjS9LM+1VRBT62HMtbKqUwhWiVSfXwBAFVvuPCJE
	 NTkOZTQicq+Bq9h2ot67vj67X2/4JD/efwpTN1cI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfBWE4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 23:56:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35187 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbfBWE4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 23:56:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id t18so4473623wrx.2;
        Fri, 22 Feb 2019 20:56:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wYJs5uHGIYmWYVtOvQUCcBbWAStEOh/S8s/SrzgqdEI=;
        b=eVe1mFBApPmEPFS+t7pWWJgOy42SwcYPgvu91+MMIZPA9MFV5wdxPB0Ta3ILXLXR97
         dx0NV2aCa4gHKuaZod1U/W8mmQauJhIlXT/lFfnGPDt7Zt8WA+ebSp21nqrOvg/9sMcp
         XKiA9Y5gLUJWI5Urg6DMjJoDl9ZImAgnXs9eaZe8m/9dpS0Y1LFQKPC05BnHHlkP4nP5
         GjiHVNjnhb3Ctg9wUi2t5IIn+mdZL/Fj9zX7KtPrTKv2H3dUSOqnTNm0IFCzi4E8ojHY
         7Ok0Ll/gjQ/0XamxB35dTTpajvbMJnHmhJYxu8jE9p96Sm6KmaRn/QRRUad1dR8z2IV1
         wpdQ==
X-Gm-Message-State: AHQUAuYFiKewW89rgWxlblxHyu+bgV3FpaG3+rI1dCQNj7qzadEooape
        q0+DjbxpH7VeYhFBtppcy0u+EveP1G2byd0Qwek=
X-Google-Smtp-Source: AHgI3IaGUNO7WNLow4sz6zchtNGMozbgl7lVwEa3XUaJy+vFUavE/6Tpjjl0pgT2PmSHRa97CYDO2p17f09iK+LTbEI=
X-Received: by 2002:adf:fdc3:: with SMTP id i3mr4960922wrs.252.1550897806527;
 Fri, 22 Feb 2019 20:56:46 -0800 (PST)
MIME-Version: 1.0
References: <20190221160652.1788-1-jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <20190221160652.1788-1-jonas.rabenstein@studium.uni-erlangen.de>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 23 Feb 2019 13:56:35 +0900
Message-ID: <CAM9d7cjnYRTwGSWhgeQAdityphZYzmm-3MeV6WdmMEE0nDw+Tg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Support inline symbols in callchains
To:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Miller <davem@davemloft.net>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Milian Wolff <milian.wolff@kdab.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Gardner <rob.gardner@oracle.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 1:07 AM Jonas Rabenstein
<jonas.rabenstein@studium.uni-erlangen.de> wrote:
>
> Hi,
> This patchset supersedes my previous attempt to add inline symbols to
> callchain of perf-script [1] by a more generic attempt to not hook in
> the output stage but directly into the callchain generation. By a matter
> of fact this adds those inline symbols automatically to other commands
> like perf-report.
> Additionally this fixes the regression reported by Jiri Olsa [2] that
> some entries from previous outputs had been vanished and now only new
> lines are added if symbols had been found.
>
> The integration for perf-report is not completely done as there is an
> issue if the root for an hist_entry as for inlined symbols there may be
> multiple instances (for each address-range) with the same name. But in
> util/sort.c:233 only the name is compared for inlined symbols. As a
> consequence the returned hist_entry may hold a reference to another
> instance for this inlined symbol (with another address range than
> requested) we later on fail with -ERANGE in __symbol__inc_addr_samples
> (util/annotate.c:857).
> This issue does still permit perf-report to be executed without any
> problems and the inlined symbols do show up but none of the samples is
> actually accounted to them but to the original symbol :(
>
> To further provide information what this changeset is doing, here is a
> script-session to show the differences in the output:
>
> [jonas@x60s]$  git reset --hard v5.0-rc7; make -C tools/perf >/dev/null; \
> HEAD is now at a3b22b9f11d9 Linux 5.0-rc7
> [jonas@x60s]$  git am *.patch; make -C tools/perf >/dev/null; \
>         mv tools /perf/perf perf-new
> Applying: perf map: add function to lookup inline symbols
> Applying: perf machine: use map__inlines in append_inlines
> Applying: perf machine: add inline symbols to callchains
> [jonas@x60s]$  cat test.c
> static int foo(int m){int r=0; for(int i=0;i<m;++i)r+=i; return r;}
> static int bar(int m){int r=0; for(int i=0;i<m;++i)r+=foo(i); return r;}
> static int baz(int m){int r=0; for(int i=0;i<m;++i)r+=foo(i)*bar(i); return r;}
> int main() { return baz(421); }
> [jonas@x60s]$  gcc -O2 -fno-omit-frame-pointer -g -o test test.c
> [jonas@x60s]$  ./perf-new record --call-graph fp ./test.c
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.002 MB perf.data (19 samples) ]
> [jonas@x60s]$  time ./perf-old script >old.script
> real    0m0.039s
> user    0m0.012s
> sys     0m0.022s
> [jonas@x60s]$  time ./perf-new script >new.script
> real    0m0.045s
> user    0m0.010s
> sys     0m0.032s
> [jonas@x60s]$  diff -u old.script new.script
> --- old.script  2019-02-21 16:30:47.997194180 +0100
> +++ new.script  2019-02-21 16:30:51.757309790 +0100
> @@ -23,66 +23,101 @@
>             7f43b1148090 _start+0x0 (/lib/x86_64-linux-gnu/ld-2.27.so)
>
>  test  7579 1470536.968092:     354758 cycles:uppp:
> +           7f43b1148f4b elf_get_dynamic_info+0xab (inlined)
>             7f43b1148f4b _dl_start+0xab (/lib/x86_64-linux-gnu/ld-2.27.so)
>             7f43b1148098 _dl_start_user+0x0 (/lib/x86_64-linux-gnu/ld-2.27.so)
>  [...]
>
>  test  7579 1470536.969210:    1922435 cycles:uppp:
> +           563f0df9c53f foo+0x4f (inlined)
> +           563f0df9c53f bar+0x4f (inlined)
> +           563f0df9c53f baz+0x4f (inlined)
>             563f0df9c53f main+0x4f (/home/jonas/linux/test)
>             7f43b0d77b97 __libc_start_main+0xe7 (/lib/x86_64-linux-gnu/libc-2.27.so)
>          75e258d4c544155 [unknown] ([unknown])
> [jonas@x60s]$  time ./perf-new script --no-inline >new.noinline.script
> real    0m0.035s
> user    0m0.012s
> sys     0m0.020s
> [jonas@x60s]$  diff -u old.script new.noinline.script
> [jonas@x60s]$  ./perf-old report --stdio --quiet | sed '/^$/Q'
>        88.80%    88.80%  test     test              [.] main
>             |
>             ---0x75e258d4c544155
>                __libc_start_main
>                main
> [jonas@x60s]$  ./perf-new report --stdio --quiet | sed '/^$/Q'
>     88.80%    88.80%  test     test              [.] main
>             |
>             ---0x75e258d4c544155
>                __libc_start_main
>                main
>                baz (inlined)
>                bar (inlined)
>                foo (inlined)
> [jonas@x60s]$  ./perf-new report --stdio --quiet --no-inline | sed '/^$/Q'
>     88.80%    88.80%  test     test              [.] main
>             |
>             ---0x75e258d4c544155
>                __libc_start_main
>                main
>
> I am still trying to find a way that in the new output of report the
> 88.80% 'Self' are not accounted to main itself but split up for the
> inlined baz, bar and foo symbols.
>
> I'm open to any help as well as feedback,

I guess you can set al->sym to a symbol of the last callchain entry in
the iter_add_single_cumulative_entry().  For annotation, al->addr
needs to be updated from the start of the inlined subroutine if DWARF
is used, but not sure for addr2line though.

Thanks,
Namhyung
