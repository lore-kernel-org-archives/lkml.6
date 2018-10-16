Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CBBC5ACC8
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A9821470
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oWYB9rr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A9821470
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeJQCCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:02:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45222 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJQCCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:02:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id q5-v6so26656904wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 11:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PMdqnSb9m/F9k8AXy5iOjzXITHV9FGY3Ks/LXRYr2CY=;
        b=oWYB9rr0hyAwH8gus/nUge6mDbC0SF/7c/xAbiz2GDSJKLOBrTKGhLRfMjNqAcX/7r
         I6pp4TREWFPp/1+xzXNWgqt0sKtcVI8u7ObITUTi2NY67SLaHI9FRZbhnQKGfJH/2XIN
         eQF5YEYErwHhXMbSsLHmyLNTk+rrWa8lSRFX5mItLpcNssQq8MdMlKeLK0xmrQn7PvSW
         hXsU2LX+vaVMyl4OfK2w2X7RrdjZKev8wGbLh5hciZ+WPNE0vPdARwxdgkHanW+ZQWeA
         Hrw0jkDvahxz+425QupJc6zRxeC8+EHJmKIAX0tg0gMats0tMztTYWPBVf2zvVSues+m
         tx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PMdqnSb9m/F9k8AXy5iOjzXITHV9FGY3Ks/LXRYr2CY=;
        b=UTquhdLuq0dtUwfggH+en7knfjixKR+/e1RQDFqvU9CkDsd/bFLuWfoT+7YadWLtzC
         RZ9jz6Uqe6tTR7s7pBVIQI5xAj3BOJcxFDYQ6ovLGuHJn/WiM5LsQCTGbjIUV9FHUgW8
         HYjXNexlNCi++5Alr8UFdelwK2s6wTsVxotplsiTSBXP4vHsL0kp0OzP2mRV8zfPvbsY
         elzX//oyDT6QmTsZ9xLA5WTMdVYLz92aFosFL6znFP9kI4HW3zw2HQO8X02U7tCY8vd0
         3PZGSdq1Y9Yke5a5Pmpkv6lwGEmCJKomiaIHe8F6T401qVHYlA2VQ8yEPPxIboOjz3VJ
         naqQ==
X-Gm-Message-State: ABuFfojE4bZVqCnBjLN5OLLIqx5yD2McWEMWubNF/7t9aGNkJVRYUITB
        Uwv93XlbHWccHG805RJhJD5hDbQurJanPQhVYRXntQ==
X-Google-Smtp-Source: ACcGV62pF0oMDw8sJe6U9odSJ8qxQjEE+SsaPoOmd/WZmolFVCtM6idv/aY+Z4yd5SfMoCe+Wz2yn7HYUZQxpRsDlpo=
X-Received: by 2002:a5d:438e:: with SMTP id i14-v6mr21179528wrq.156.1539713423528;
 Tue, 16 Oct 2018 11:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <CABPqkBTEOwKrq6ZJo3W-rZQi56OWorWo3VcOTwV17QxZBckS0Q@mail.gmail.com>
 <20181016110341.GB18450@krava> <20181016162554.GD6631@krava>
In-Reply-To: <20181016162554.GD6631@krava>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 16 Oct 2018 11:10:12 -0700
Message-ID: <CABPqkBTWZA7k+7qu0SD5CTaS-e5NnkQoFwBX1q4HnBArzKaqTw@mail.gmail.com>
Subject: Re: [BUG] perf stat: hangs with -p and process completes
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri,

Thanks for looking into this.
Yeah, I don't think you need a kernel patch to make this work.
You can poll in the app.
Let me try this out.


On Tue, Oct 16, 2018 at 9:25 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Oct 16, 2018 at 01:03:41PM +0200, Jiri Olsa wrote:
> > On Fri, Oct 12, 2018 at 02:26:09PM -0700, Stephane Eranian wrote:
> > > Hi,
> > >
> > > I am running into a perf stat issue with the -p option which allows you
> > > to attach to a running process. If that process happens to terminate
> > > while under monitoring
> > > perf hangs in there and never terminates. The proper behavior would be to stop.
> > > I can see the issue in that the attached process is not a child, so
> > > wait() would not work.
> > >
> > > To reproduce:
> > >   $ sleep 10 &
> > >   $ perf stat -p $!
> > >
> > > doing the same with perf record works, so there is a solution to this problem.
> >
> > yea, we don't poll for the event state change in perf stat,
> > but we do that in perf record.. also because the perf poll
> > code in kernel is originaly meant for tracking the ring
> > buffer state
> >
> > maybe we could return EPOLLIN for alive events without ring
> > buffer.. like below (totaly untested) and add polling for
> > event state into perf stat
> >
> > cc-ing perf folks
> >
>
> on the second thought attached patch works as well
> without kernel change
>
> jirka
>
>
> ---
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index b86aba1c8028..d1028d7755bb 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -409,6 +409,28 @@ static struct perf_evsel *perf_evsel__reset_weak_group(struct perf_evsel *evsel)
>         return leader;
>  }
>
> +static bool is_target_alive(struct target *_target,
> +                           struct thread_map *threads)
> +{
> +       struct stat st;
> +       int i;
> +
> +       if (!target__has_task(_target))
> +               return true;
> +
> +       for (i = 0; i < threads->nr; i++) {
> +               char path[PATH_MAX];
> +
> +               scnprintf(path, PATH_MAX, "%s/%d", procfs__mountpoint(),
> +                         threads->map[i].pid);
> +
> +               if (!stat(path, &st))
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
>  static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  {
>         int interval = stat_config.interval;
> @@ -579,6 +601,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>                 enable_counters();
>                 while (!done) {
>                         nanosleep(&ts, NULL);
> +                       if (!is_target_alive(&target, evsel_list->threads))
> +                               break;
>                         if (timeout)
>                                 break;
>                         if (interval) {
