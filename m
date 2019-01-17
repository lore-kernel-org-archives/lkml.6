Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868D7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5245B20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/7mec4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfAQODR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:03:17 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36200 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfAQODR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:03:17 -0500
Received: by mail-qt1-f195.google.com with SMTP id t13so11392173qtn.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 06:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z3KM/2M9SGXtzqM96P0s+vV4xNaD8ggwcV3UuciUkjY=;
        b=N/7mec4aDkFA2OzfS6v/HsawS2Z4+1sTtsicX+wT1jQb9Al+y+9qT/GmgtIHKcbOQO
         JeummLxwauHMU6sp8Q3zBgfHMQBTGucvqKFwPcW6xvwUb7QE1tLpwDeqFMHp6JpPF0Fp
         K426B9qHzyfQtOSRoD2i5LMDpCHJ5icI9HhjsYPnrHzP73YZPrV38XiRJiblKbHSTYch
         xzwNCWSRPW1jGqyrLhmuYDyXqankQ27SLYRVRqHsxcXE7K0j54NyYecjPCzaB80sbJv2
         cQhDgnCeJga9eXlRJ7HK3NlsqxcAG00+dmTNXwNELSpbkS+kx3qE1HaG/xnxZxOMoYIv
         3CJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z3KM/2M9SGXtzqM96P0s+vV4xNaD8ggwcV3UuciUkjY=;
        b=pDcy7lTMsSwihdVHOTdp3QsFqK41FWSJoDsSa9/87efIg4E0lxrZ7+h/d4S54PQTXF
         prqEVT1fkkboJk7rvffylimUQDJH/MxboTgtnLxndY8xoWxSPU6JDOJ94BjZQKNzaS5s
         BCY4IP3GOXBNteYpJ6CkvkJc6yHiCPwFk1BjulgSBIp2q+icPlfaJ7QDRlXwFPyZEgvb
         mixVjY/yg7q4LBBYtNJGh4ltJuQBtAj1I9SAx5CrhJvUh1Besd79DxRsnQnS+ywCLXlp
         BJcuQivoymBK3o+uRIBZudjuCsCut1TZmNrx5ESQ2XyS5cNFySISXzIdWWsqvLFqtyqb
         e2sQ==
X-Gm-Message-State: AJcUukfFhsji7xyLgaAGm8ukI8hXMEXdXOSdkgG5aJ3IIdltxZFcmO5y
        qp7plnbdZ7iTCMigxAdEjWd/dBIf8aAOFY0sMQc=
X-Google-Smtp-Source: ALg8bN5WQqVyBPITVG4f7zpjfPocmyXIVCI0DKEzg/iPfR09M921fTllm7UIqY/6D4G0rAS1yoB/TBeBbYxxnDdwfg0=
X-Received: by 2002:aed:2798:: with SMTP id a24mr11537800qtd.138.1547733795964;
 Thu, 17 Jan 2019 06:03:15 -0800 (PST)
MIME-Version: 1.0
References: <20190117113017.12977-1-jolsa@kernel.org>
In-Reply-To: <20190117113017.12977-1-jolsa@kernel.org>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 17 Jan 2019 06:03:04 -0800
Message-ID: <CAPhsuW78Xk3kK208RMmV6HuwpGmhqX+6Jg=rd3A12LCp7HqFOQ@mail.gmail.com>
Subject: Re: [PATCH perf/urgent] perf tools: Fix crash in ordered_events__free
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 3:54 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Song Liu reported crash in perf record:
>
> > #0  0x0000000000500055 in ordered_events(float, long double,...)(...) ()
> > #1  0x0000000000500196 in ordered_events.reinit ()
> > #2  0x00000000004fe413 in perf_session.process_events ()
> > #3  0x0000000000440431 in cmd_record ()
> > #4  0x00000000004a439f in run_builtin ()
> > #5  0x000000000042b3e5 in main ()"
>
> This can happen when we get out of the buffers during
> event processing. The subsequent ordered_events__free
> assumes the oe->buffer != NULL and crashes. Adding
> the check to prevent that.
>
> Cc: Stephane Eranian <eranian@google.com>
> Fixes: d5ceb62b3654 ("perf ordered_events: Add 'struct ordered_events_buffer' layer")
> Reported-by: Song Liu <liu.song.a23@gmail.com>
> Link: http://lkml.kernel.org/n/tip-914bml5kabz2m9mbywd7el9l@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Reviewed-and-tested-by: Song Liu <songliubraving@fb.com>

Thanks again for the fix!
Song



> ---
>  tools/perf/util/ordered-events.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
> index 897589507d97..ea523d3b248f 100644
> --- a/tools/perf/util/ordered-events.c
> +++ b/tools/perf/util/ordered-events.c
> @@ -391,8 +391,10 @@ void ordered_events__free(struct ordered_events *oe)
>          * Current buffer might not have all the events allocated
>          * yet, we need to free only allocated ones ...
>          */
> -       list_del(&oe->buffer->list);
> -       ordered_events_buffer__free(oe->buffer, oe->buffer_idx, oe);
> +       if (oe->buffer) {
> +               list_del(&oe->buffer->list);
> +               ordered_events_buffer__free(oe->buffer, oe->buffer_idx, oe);
> +       }
>
>         /* ... and continue with the rest */
>         list_for_each_entry_safe(buffer, tmp, &oe->to_free, list) {
> --
> 2.17.2
>
