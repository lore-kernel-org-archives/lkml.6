Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A316EC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40ED32082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4c74Wba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40ED32082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbeKBDe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 23:34:59 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40130 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeKBDe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 23:34:59 -0400
Received: by mail-qt1-f193.google.com with SMTP id k12so16354638qtf.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 11:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bRqbtKsUzKKj+xFVyFQQLsbca7n/6UoC9ZChKknDqLw=;
        b=a4c74WbaJMs9G3Es2YziKbutgt6IVaqUlmXjPg8znvXnu8nUX0lrSCsUQR8nzypdE8
         We6e7Q8jDK36WJv0FG6mc8jQkD98EOCMCtBHXBDa06YA5OJmvEq8yC2BPC4eE0Qa1or5
         vU+wkqzeP+xohiyRfB1C2+wn1Gqsbtrt2d4Ln7i2ZIsx2wRn8x3tMsWUkRIUOzy7mZW6
         I1Hm9Op/diJkOJ4qtkK5lwRFjEZx7eJ9MeZerGo22y/sRe+36yhY3zzZSb/bDdWdr+hf
         bm7ki7P5BfZTfTfoCNoJDyTvv8bdkXm27FP5IRJd0mJMDE88Tt7hlSw0jCKA1RDC7B3X
         TqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bRqbtKsUzKKj+xFVyFQQLsbca7n/6UoC9ZChKknDqLw=;
        b=ABEJXJIZfqKmsZN8j1LrOV248mny1fVEKP26JdDdVZ5pwa8e9lIoAbZfY8wBg0SLgc
         4H9DQ47IkvxRzSxGbVbNzF5CM0PAPWnlJVGp3Xupa+nIJ51JN4FFhNkXiHDxzV8H5yBt
         Qv2jOyB8zMTVfm4KJS3voxNFd19YA+PIH3e0wU4hk80L4HK6gLJZDQzUiAj3Vpd6+MBA
         rQ6UzzjmYeRBoXDL/qFpdcX4MhT71NfTxEgAICtvmB5n/Up71uNWyRNuyN2UhAsz3BFJ
         aaNfgvfVHX76cW7LZ9KZuSu8Akp67QXc4Js4kigMjD+EinyDNXeuYdL28kF7aM2ozlEg
         Xo2A==
X-Gm-Message-State: AGRZ1gJtcjbRr2pF06MBGWbV8pjbOk7VLtgg/mpCZFQWRoZXldSS8kAp
        /3BMV16kuE4g4BTYiUXv8r0pjdKYN0QrDqBTHdY=
X-Google-Smtp-Source: AJdET5dS4jSgz7ReG26OmizvxQlTx4LMjDR7rNOyWBVdR4RG6s3D0CzXrEOjbIcx0gNnKLcyYxKPK0t+wBN5TKQvUYw=
X-Received: by 2002:a0c:8822:: with SMTP id 31mr7958403qvl.5.1541097052032;
 Thu, 01 Nov 2018 11:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <d6bd3626-8c7c-ca12-8adf-31fe15726446@linux.intel.com> <6295b798-f710-0251-3122-bbb5c694f00e@linux.intel.com>
In-Reply-To: <6295b798-f710-0251-3122-bbb5c694f00e@linux.intel.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 1 Nov 2018 11:30:40 -0700
Message-ID: <CAPhsuW52Vfsx7gfPppxH_E=6Y6xtMrWzCAx0=aJk0odm_q=ZzA@mail.gmail.com>
Subject: Re: [PATCH v14 3/3]: perf record: extend trace writing to multi AIO
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 11:47 PM Alexey Budankov
<alexey.budankov@linux.intel.com> wrote:
>
>
> Multi AIO trace writing allows caching more kernel data into userspace
> memory postponing trace writing for the sake of overall profiling data
> thruput increase. It could be seen as kernel data buffer extension into
> userspace memory.
>
> With aio option value different from 0, default value is 1,
> tool has capability to cache more and more data into user space
> along with delegating spill to AIO.
>
> That allows avoiding suspend at record__aio_sync() between calls of
> record__mmap_read_evlist() and increase profiling data thruput for
> the cost of userspace memory.
>
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
> Changes in v14:
> - fix --aio option handling
> Changes in v13:
> - preserved --aio option name avoiding complication
> Changes in v12:
> - extended --aio option to --aio-cblocks=<n>
> Changes in v10:
> - added description of aio-cblocks option into perf-record.tx
> ---
>  tools/perf/Documentation/perf-record.txt |  4 +-
>  tools/perf/builtin-record.c              | 64 ++++++++++++++++++++++++--------
>  tools/perf/util/mmap.c                   | 64 +++++++++++++++++++++-----------
>  tools/perf/util/mmap.h                   |  9 +++--
>  4 files changed, 99 insertions(+), 42 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 7efb4af88a68..d232b13ea713 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -435,8 +435,8 @@ Specify vmlinux path which has debuginfo.
>  --buildid-all::
>  Record build-id of all DSOs regardless whether it's actually hit or not.
>
> ---aio::
> -Enable asynchronous (Posix AIO) trace writing mode.
> +--aio[=n]::
> +Use <n> control blocks in asynchronous (Posix AIO) trace writing mode (default: 1, max: 4).
>  Asynchronous mode is supported only when linking Perf tool with libc library
>  providing implementation for Posix AIO API.
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 0c6105860123..c5d9288b8670 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -196,16 +196,35 @@ static int record__aio_complete(struct perf_mmap *md, struct aiocb *cblock)
>         return rc;
>  }
>
> -static void record__aio_sync(struct perf_mmap *md)
> +static int record__aio_sync(struct perf_mmap *md, bool sync_all)
>  {
> -       struct aiocb *cblock = &md->aio.cblock;
> +       struct aiocb **aiocb = md->aio.aiocb;
> +       struct aiocb *cblocks = md->aio.cblocks;
>         struct timespec timeout = { 0, 1000 * 1000  * 1 }; /* 1ms */
> +       int i, do_suspend;
>
>         do {
> -               if (cblock->aio_fildes == -1 || record__aio_complete(md, cblock))
> -                       return;
> +               do_suspend = 0;
> +               for (i = 0; i < md->aio.nr_cblocks; ++i) {
> +                       if (cblocks[i].aio_fildes == -1 || record__aio_complete(md, &cblocks[i])) {
> +                               if (sync_all)
> +                                       aiocb[i] = NULL;
> +                               else
> +                                       return i;
> +                       } else {
> +                               /*
> +                                * Started aio write is not complete yet
> +                                * so it has to be waited before the
> +                                * next allocation.
> +                                */
> +                               aiocb[i] = &cblocks[i];
> +                               do_suspend = 1;
> +                       }
> +               }
> +               if (!do_suspend)
> +                       return -1;
>
> -               while (aio_suspend((const struct aiocb**)&cblock, 1, &timeout)) {
> +               while (aio_suspend((const struct aiocb **)aiocb, md->aio.nr_cblocks, &timeout)) {
>                         if (!(errno == EAGAIN || errno == EINTR))
>                                 pr_err("failed to sync perf data, error: %m\n");
>                 }
> @@ -252,28 +271,33 @@ static void record__aio_mmap_read_sync(struct record *rec)
>                 struct perf_mmap *map = &maps[i];
>
>                 if (map->base)
> -                       record__aio_sync(map);
> +                       record__aio_sync(map, true);
>         }
>  }
>
>  static int nr_cblocks_default = 1;
>
>  static int record__aio_parse(const struct option *opt,
> -                            const char *str __maybe_unused,
> +                            const char *str,
>                              int unset)
>  {
>         struct record_opts *opts = (struct record_opts *)opt->value;
>
> -       if (unset)
> +       if (unset) {
>                 opts->nr_cblocks = 0;
> -       else
> -               opts->nr_cblocks = nr_cblocks_default;
> +       } else {
> +               if (str)
> +                       opts->nr_cblocks = strtol(str, NULL, 0);
> +               if (!opts->nr_cblocks)
> +                       opts->nr_cblocks = nr_cblocks_default;
> +       }
>
>         return 0;
>  }
>  #else /* HAVE_AIO_SUPPORT */
> -static void record__aio_sync(struct perf_mmap *md __maybe_unused)
> +static int record__aio_sync(struct perf_mmap *md __maybe_unused, bool sync_all __maybe_unused)
>  {
> +       return -1;
>  }
>
>  static int record__aio_pushfn(void *to __maybe_unused, struct aiocb *cblock __maybe_unused,
> @@ -723,12 +747,13 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>                                         goto out;
>                                 }
>                         } else {
> +                               int idx;
>                                 /*
>                                  * Call record__aio_sync() to wait till map->data buffer
>                                  * becomes available after previous aio write request.
>                                  */
> -                               record__aio_sync(map);
> -                               if (perf_mmap__aio_push(map, rec, record__aio_pushfn, &off) != 0) {
> +                               idx = record__aio_sync(map, false);
> +                               if (perf_mmap__aio_push(map, rec, idx, record__aio_pushfn, &off) != 0) {
>                                         record__aio_set_pos(trace_fd, off);
>                                         rc = -1;
>                                         goto out;
> @@ -1492,6 +1517,13 @@ static int perf_record_config(const char *var, const char *value, void *cb)
>                 var = "call-graph.record-mode";
>                 return perf_default_config(var, value, cb);
>         }
> +#ifdef HAVE_AIO_SUPPORT
> +       if (!strcmp(var, "record.aio")) {
> +               rec->opts.nr_cblocks = strtol(value, NULL, 0);
> +               if (!rec->opts.nr_cblocks)
> +                       rec->opts.nr_cblocks = nr_cblocks_default;
> +       }
> +#endif
>
>         return 0;
>  }
> @@ -1884,8 +1916,8 @@ static struct option __record_options[] = {
>         OPT_BOOLEAN(0, "dry-run", &dry_run,
>                     "Parse options then exit"),
>  #ifdef HAVE_AIO_SUPPORT
> -       OPT_CALLBACK_NOOPT(0, "aio", &record.opts,
> -                    NULL, "Enable asynchronous trace writing mode",
> +       OPT_CALLBACK_OPTARG(0, "aio", &record.opts,
> +                    &nr_cblocks_default, "n", "Use <n> control blocks in asynchronous trace writing mode (default: 1, max: 4)",
>                      record__aio_parse),
>  #endif
>         OPT_END()
> @@ -2080,6 +2112,8 @@ int cmd_record(int argc, const char **argv)
>                 goto out;
>         }
>
> +       if (rec->opts.nr_cblocks > 4)
> +               rec->opts.nr_cblocks = 4;
nit: I feel this logic belongs to record__aio_parse(). And we should have

static int nr_cblocks_max = 4;

Other than this

Acked-by: Song Liu <songliubraving@fb.com>
