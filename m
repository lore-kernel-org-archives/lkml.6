Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F70C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E842E2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1BLZn7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E842E2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbeKBDq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 23:46:28 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36608 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbeKBDq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 23:46:28 -0400
Received: by mail-qk1-f196.google.com with SMTP id o125so9647529qkf.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 11:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HaHy0/DXbehWd/1yVW8xOvahtNoqV0TORXcv+1mK/RQ=;
        b=Z1BLZn7GLT2FXuEokbX7pWw9ZwIs3a8fGaE7YdA40s0XHlmjltGx95d7lTNN3u1pcy
         /VXGaMWxGVSsBmHMOlhANTcOXUAggffUM1XsZfBigP3rcdPgZU+W6oBdHPG4tDagyTna
         BK8EvIqT+LBgsv/1KPnY7Ich2phrMid8LunQX8WFZM3NVmSzyee50lo3GoHzjvxnJnSE
         TXRcG0t04xmjwUGBrEtlvip+j/d2tYfhEzhsTlFG6ioGoKl3VBbCjKnpa6y4ohcO9RbC
         8bmCxdZakAXHo7fxS3MM2GSJBlK0r1xzEz9qo74l3l2Qvw3QGr6wC9b8Hy3mtP3bU9XB
         g9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HaHy0/DXbehWd/1yVW8xOvahtNoqV0TORXcv+1mK/RQ=;
        b=VEubdLqtefjCfQydmr7sAVAZ2XZqFQvTfIDe6NbNBCb4rL9QDSdlDG3bGXBzP0+8pk
         TO2EJc4qGD2cJ6nlX5J3RmazCRD+N+rTpow7/fwuQJ4bZJLBKJpTzMmrUFyHpZVFjA7z
         27aSDoGjBEJxXJbitTzvG+LNXTAt1ntMbm0wAnVLv1hMI9hL4jyAcfGvkn3QNOLo1W3e
         eADmf92JzlDh2CZcqy6jCdUsWIwLdddIJ8fkDaKIAhFw/ITZO6nFs8ZcDFP5bSnjsta4
         +SZzMNTTuduxSA/viLhigpu+Eqv0cZCSlaSd9nb/MO/0AMKaXdR1YMu4w9tK9Azx0pmg
         h26g==
X-Gm-Message-State: AGRZ1gJ11e6JcOdGKDmOl/qclRYDkRs/aaLGHz+6hqZ1p8f/C4IoKn5q
        C2rctAW6RPU/VIhpIOoXXfBHhbW/1iv9UbYjGIY=
X-Google-Smtp-Source: AJdET5dXX0lPNvGGgx6/I/hrA7lYrlQ8Fj/S1H6pZHlbR82bCw4HwGwJ0CG9bCmHk1iTpMugD4BGStgEVy+aiAGfoyw=
X-Received: by 2002:a37:2008:: with SMTP id g8mr7483474qkg.120.1541097736963;
 Thu, 01 Nov 2018 11:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <d6bd3626-8c7c-ca12-8adf-31fe15726446@linux.intel.com> <32a39baa-7078-e76b-0157-e6808af4812c@linux.intel.com>
In-Reply-To: <32a39baa-7078-e76b-0157-e6808af4812c@linux.intel.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 1 Nov 2018 11:42:05 -0700
Message-ID: <CAPhsuW76iDvxwqxpH3bdGGGW_5ye5eLM=R2cZsF=P5iPsuB_pQ@mail.gmail.com>
Subject: Re: [PATCH v14 2/3]: perf record: enable asynchronous trace writing
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

On Sun, Oct 14, 2018 at 11:45 PM Alexey Budankov
<alexey.budankov@linux.intel.com> wrote:
>
>
> Trace file offset is read once before mmaps iterating loop and written
> back after all performance data enqueued for aio writing. Trace file offset
> is incremented linearly after every successful aio write operation.
>
> record__aio_sync() blocks till completion of started AIO operation
> and then proceeds.
>
> record__aio_mmap_read_sync() implements a barrier for all incomplete
> aio write requests.
>
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  Changes in v14:
>  - implement default nr_cblocks_default variable
>  Changes in v13:
>  - named new functions with _aio_ word
>  - grouped aio functions under single #ifdef HAVE_AIO_SUPPORT
>  - moved perf_mmap__aio_push() stub into header
>  - removed trailed white space
>  Changes in v12:
>  - implemented record__aio_get/set_pos(), record__aio_enabled()
>  - implemented simple --aio option
>  Changes in v11:
>  - replacing the both lseek() syscalls in every loop iteration by the only
>    two syscalls just before and after the loop at record__mmap_read_evlist()
>    and advancing *in-flight* off file pos value at perf_mmap__aio_push()
>  Changes in v10:
>  - avoided lseek() setting file pos back in case of record__aio_write() failure
>  - compacted code selecting between serial and AIO streaming
>  - optimized call places of record__mmap_read_sync()
>  Changes in v9:
>  - enable AIO streaming only when --aio-cblocks option is specified explicitly
>  Changes in v8:
>  - split AIO completion check into separate record__aio_complete()
>  Changes in v6:
>  - handled errno == EAGAIN case from aio_write();
>  Changes in v5:
>  - data loss metrics decreased from 25% to 2x in trialed configuration;
>  - avoided nanosleep() prior calling aio_suspend();
>  - switched to per cpu multi record__aio_sync() aio
>  - record_mmap_read_sync() now does global barrier just before
>    switching trace file or collection stop;
>  - resolved livelock on perf record -e intel_pt// -- dd if=/dev/zero of=/dev/null count=100000
>  Changes in v4:
>  - converted void *bf to struct perf_mmap *md in signatures
>  - written comment in perf_mmap__push() just before perf_mmap__get();
>  - written comment in record__mmap_read_sync() on possible restarting
>    of aio_write() operation and releasing perf_mmap object after all;
>  - added perf_mmap__put() for the cases of failed aio_write();
>  Changes in v3:
>  - written comments about nanosleep(0.5ms) call prior aio_suspend()
>    to cope with intrusiveness of its implementation in glibc;
>  - written comments about rationale behind coping profiling data
>    into mmap->data buffer;
> ---
>  tools/perf/Documentation/perf-record.txt |   5 +
>  tools/perf/builtin-record.c              | 218 ++++++++++++++++++++++++++++++-
>  tools/perf/perf.h                        |   1 +
>  tools/perf/util/evlist.c                 |   6 +-
>  tools/perf/util/evlist.h                 |   2 +-
>  tools/perf/util/mmap.c                   |  77 ++++++++++-
>  tools/perf/util/mmap.h                   |  14 ++
>  7 files changed, 314 insertions(+), 9 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 246dee081efd..7efb4af88a68 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -435,6 +435,11 @@ Specify vmlinux path which has debuginfo.
>  --buildid-all::
>  Record build-id of all DSOs regardless whether it's actually hit or not.
>
> +--aio::
> +Enable asynchronous (Posix AIO) trace writing mode.
> +Asynchronous mode is supported only when linking Perf tool with libc library
> +providing implementation for Posix AIO API.
> +
>  --all-kernel::
>  Configure all used events to run in kernel space.
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 0980dfe3396b..0c6105860123 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -124,6 +124,183 @@ static int record__write(struct record *rec, struct perf_mmap *map __maybe_unuse
>         return 0;
>  }
>
> +#ifdef HAVE_AIO_SUPPORT
> +static int record__aio_write(struct aiocb *cblock, int trace_fd,
> +               void *buf, size_t size, off_t off)
> +{
> +       int rc;
> +
> +       cblock->aio_fildes = trace_fd;
> +       cblock->aio_buf    = buf;
> +       cblock->aio_nbytes = size;
> +       cblock->aio_offset = off;
> +       cblock->aio_sigevent.sigev_notify = SIGEV_NONE;
> +
> +       do {
> +               rc = aio_write(cblock);
> +               if (rc == 0) {
> +                       break;
> +               } else if (errno != EAGAIN) {
> +                       cblock->aio_fildes = -1;
> +                       pr_err("failed to queue perf data, error: %m\n");
> +                       break;
> +               }
> +       } while (1);
> +
> +       return rc;
> +}
> +
> +static int record__aio_complete(struct perf_mmap *md, struct aiocb *cblock)
> +{
> +       void *rem_buf;
> +       off_t rem_off;
> +       size_t rem_size;
> +       int rc, aio_errno;
> +       ssize_t aio_ret, written;
> +
> +       aio_errno = aio_error(cblock);
> +       if (aio_errno == EINPROGRESS)
> +               return 0;
> +
> +       written = aio_ret = aio_return(cblock);
> +       if (aio_ret < 0) {
> +               if (aio_errno != EINTR)
> +                       pr_err("failed to write perf data, error: %m\n");
> +               written = 0;
> +       }
> +
> +       rem_size = cblock->aio_nbytes - written;
> +
> +       if (rem_size == 0) {
> +               cblock->aio_fildes = -1;
> +               /*
> +                * md->refcount is incremented in perf_mmap__push() for
> +                * every enqueued aio write request so decrement it because
> +                * the request is now complete.
> +                */
> +               perf_mmap__put(md);
> +               rc = 1;
> +       } else {
> +               /*
> +                * aio write request may require restart with the
> +                * reminder if the kernel didn't write whole
> +                * chunk at once.
> +                */
> +               rem_off = cblock->aio_offset + written;
> +               rem_buf = (void *)(cblock->aio_buf + written);
> +               record__aio_write(cblock, cblock->aio_fildes,
> +                               rem_buf, rem_size, rem_off);
> +               rc = 0;
> +       }
> +
> +       return rc;
> +}
> +
> +static void record__aio_sync(struct perf_mmap *md)
> +{
> +       struct aiocb *cblock = &md->aio.cblock;
> +       struct timespec timeout = { 0, 1000 * 1000  * 1 }; /* 1ms */
> +
> +       do {
> +               if (cblock->aio_fildes == -1 || record__aio_complete(md, cblock))
> +                       return;
> +
> +               while (aio_suspend((const struct aiocb**)&cblock, 1, &timeout)) {
> +                       if (!(errno == EAGAIN || errno == EINTR))
> +                               pr_err("failed to sync perf data, error: %m\n");
> +               }
> +       } while (1);
> +}
> +
> +static int record__aio_pushfn(void *to, struct aiocb *cblock, void *bf, size_t size, off_t off)
> +{
> +       struct record *rec = to;
> +       int ret, trace_fd = rec->session->data->file.fd;
> +
> +       rec->samples++;
> +
> +       ret = record__aio_write(cblock, trace_fd, bf, size, off);
> +       if (!ret) {
> +               rec->bytes_written += size;
> +               if (switch_output_size(rec))
> +                       trigger_hit(&switch_output_trigger);
> +       }
> +
> +       return ret;
> +}
> +
> +static off_t record__aio_get_pos(int trace_fd)
> +{
> +       return lseek(trace_fd, 0, SEEK_CUR);
> +}
> +
> +static void record__aio_set_pos(int trace_fd, off_t pos)
> +{
> +       lseek(trace_fd, pos, SEEK_SET);
> +}
> +
> +static void record__aio_mmap_read_sync(struct record *rec)
> +{
> +       int i;
> +       struct perf_evlist *evlist = rec->evlist;
> +       struct perf_mmap *maps = evlist->mmap;
> +
> +       if (!rec->opts.nr_cblocks)
> +               return;
> +
> +       for (i = 0; i < evlist->nr_mmaps; i++) {
> +               struct perf_mmap *map = &maps[i];
> +
> +               if (map->base)
> +                       record__aio_sync(map);
> +       }
> +}
> +
> +static int nr_cblocks_default = 1;
> +
> +static int record__aio_parse(const struct option *opt,
> +                            const char *str __maybe_unused,
> +                            int unset)
> +{
> +       struct record_opts *opts = (struct record_opts *)opt->value;
> +
> +       if (unset)
> +               opts->nr_cblocks = 0;
> +       else
> +               opts->nr_cblocks = nr_cblocks_default;
> +
> +       return 0;
> +}
> +#else /* HAVE_AIO_SUPPORT */
> +static void record__aio_sync(struct perf_mmap *md __maybe_unused)
> +{
> +}
> +
> +static int record__aio_pushfn(void *to __maybe_unused, struct aiocb *cblock __maybe_unused,
> +               void *bf __maybe_unused, size_t size __maybe_unused, off_t off __maybe_unused)
> +{
> +       return -1;
> +}
> +
> +static off_t record__aio_get_pos(int trace_fd __maybe_unused)
> +{
> +       return -1;
> +}
> +
> +static void record__aio_set_pos(int trace_fd __maybe_unused, off_t pos __maybe_unused)
> +{
> +}
> +
> +static void record__aio_mmap_read_sync(struct record *rec __maybe_unused)
> +{
> +}
> +#endif
> +
> +static int record__aio_enabled(struct record *rec)
> +{
> +       return rec->opts.nr_cblocks > 0;
> +}
> +
>  static int process_synthesized_event(struct perf_tool *tool,
>                                      union perf_event *event,
>                                      struct perf_sample *sample __maybe_unused,
> @@ -329,7 +506,7 @@ static int record__mmap_evlist(struct record *rec,
>
>         if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
>                                  opts->auxtrace_mmap_pages,
> -                                opts->auxtrace_snapshot_mode) < 0) {
> +                                opts->auxtrace_snapshot_mode, opts->nr_cblocks) < 0) {
>                 if (errno == EPERM) {
>                         pr_err("Permission error mapping pages.\n"
>                                "Consider increasing "
> @@ -520,6 +697,8 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>         int i;
>         int rc = 0;
>         struct perf_mmap *maps;
> +       int trace_fd = rec->data.file.fd;
> +       off_t off;
>
>         if (!evlist)
>                 return 0;
> @@ -531,13 +710,29 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>         if (overwrite && evlist->bkw_mmap_state != BKW_MMAP_DATA_PENDING)
>                 return 0;
>
> +       if (record__aio_enabled(rec))
> +               off = record__aio_get_pos(trace_fd);
> +
>         for (i = 0; i < evlist->nr_mmaps; i++) {
>                 struct perf_mmap *map = &maps[i];
>
>                 if (map->base) {
> -                       if (perf_mmap__push(map, rec, record__pushfn) != 0) {
> -                               rc = -1;
> -                               goto out;
> +                       if (!record__aio_enabled(rec)) {
> +                               if (perf_mmap__push(map, rec, record__pushfn) != 0) {
> +                                       rc = -1;
> +                                       goto out;
> +                               }
> +                       } else {
> +                               /*
> +                                * Call record__aio_sync() to wait till map->data buffer
> +                                * becomes available after previous aio write request.
> +                                */
> +                               record__aio_sync(map);
> +                               if (perf_mmap__aio_push(map, rec, record__aio_pushfn, &off) != 0) {
> +                                       record__aio_set_pos(trace_fd, off);
> +                                       rc = -1;
> +                                       goto out;
> +                               }
>                         }
>                 }
>
> @@ -548,6 +743,9 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>                 }
>         }
>
> +       if (record__aio_enabled(rec))
> +               record__aio_set_pos(trace_fd, off);
> +
>         /*
>          * Mark the round finished in case we wrote
>          * at least one event.
> @@ -650,6 +848,8 @@ record__switch_output(struct record *rec, bool at_exit)
>         /* Same Size:      "2015122520103046"*/
>         char timestamp[] = "InvalidTimestamp";
>
> +       record__aio_mmap_read_sync(rec);
> +
>         record__synthesize(rec, true);
>         if (target__none(&rec->opts.target))
>                 record__synthesize_workload(rec, true);
> @@ -1157,6 +1357,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>                 record__synthesize_workload(rec, true);
>
>  out_child:
> +       record__aio_mmap_read_sync(rec);
> +
>         if (forks) {
>                 int exit_status;
>
> @@ -1681,6 +1883,11 @@ static struct option __record_options[] = {
>                           "signal"),
>         OPT_BOOLEAN(0, "dry-run", &dry_run,
>                     "Parse options then exit"),
> +#ifdef HAVE_AIO_SUPPORT
> +       OPT_CALLBACK_NOOPT(0, "aio", &record.opts,
> +                    NULL, "Enable asynchronous trace writing mode",
> +                    record__aio_parse),
> +#endif
>         OPT_END()
>  };
>
> @@ -1873,6 +2080,9 @@ int cmd_record(int argc, const char **argv)
>                 goto out;
>         }
>
> +       if (verbose > 0)
> +               pr_info("nr_cblocks: %d\n", rec->opts.nr_cblocks);
> +

nit: I guess we don't really need this pr_info()?

Other than this,

Acked-by: Song Liu <songliubraving@fb.com>
