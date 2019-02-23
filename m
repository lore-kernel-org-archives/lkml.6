Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1771BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 05:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45502084F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 05:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550898493;
	bh=SFaIaI3raJTXp/gwxbwyWdMAutUn5VGuQmMWboOqK7w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=K3gN/MnSWXIuO51up7AUdRwmX0nbpBbRGkrW0gWxj2pO99Yrr4pdDCzMvlNSFJg0Y
	 K9cOZw1g+IXRn73vuAVwS5ogA+PYGyn8ERx5npO76wBHBjzJ0ApnwzlszRANFT+qO8
	 OWbAal/VOQYLO7xbUenYZ5O6UPqk9n6cC6KJ2X+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbfBWFIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 00:08:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38694 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfBWFIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 00:08:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so4490185wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 21:08:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sik2hf/gsSkh3enWWLmmJzPhPAWpjCaGtMFWkKXes3U=;
        b=nfPuCmzvVndpMuzOGYSKVwKVuZm+wH7D82ZNX3jQFVa6BSmTARmEe00N6LJ72uZ4s/
         PzratgWRMoGkwVnryiJdsNAMqCik7PJd29bSsFmWedncr5ae0AKpHU45jSfx1fZjIEos
         7bylEJ/7/zAbtczDi3W3UIL4NDd1flBG7YYFS240OwZELz1xSFjDylWQKEKC3EVdb7Oj
         gLvr+w4Kdhj3ia76baAzOAgx4j/UtOjJoOihOo16okJf81xARUoFuzFo+huO89TiIkVX
         7Qv/ZSVCPd9cCq61iBJYJ59KIi7R84TLvyFPmaz/7cqpAjhUMmbi9ZohLoxf1mrZjRHE
         qdSw==
X-Gm-Message-State: AHQUAuYh4Ew4y2WYZUlA3hC+OGie4eQI/NfdAIMsg5MA2DPHX53qsO6a
        ULTmVR4B/3oiyFeyyL+qbBXhhGDyUu/oWH8uiSU=
X-Google-Smtp-Source: AHgI3IbwfVuRzHP91SAH77cTNzuSxkcy8BaSkkREbggRTLYut61UGSdSWCLa1/TK2E9iL6UIO/afPXLl9veDYnxIc3s=
X-Received: by 2002:a5d:4887:: with SMTP id g7mr5293013wrq.51.1550898484967;
 Fri, 22 Feb 2019 21:08:04 -0800 (PST)
MIME-Version: 1.0
References: <20190221094145.9151-1-jolsa@kernel.org> <20190221094145.9151-6-jolsa@kernel.org>
In-Reply-To: <20190221094145.9151-6-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 23 Feb 2019 14:07:53 +0900
Message-ID: <CAM9d7cgnR=Yto5Vatv-mYxr3E=eeYaiaofpMZLJ6fk3dpj9YSQ@mail.gmail.com>
Subject: Re: [PATCH 05/17] perf data: Add perf_data__(create_dir|close_dir) functions
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 6:42 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding perf_data__create_dir to create nr files inside
> struct perf_data path directory:
>   int perf_data__create_dir(struct perf_data *data, int nr);
>
> and function to close that data:
>   void perf_data__close_dir(struct perf_data *data);
>
> Link: http://lkml.kernel.org/n/tip-kl4s1f13cg6wycrg367p85qm@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/data.c | 47 ++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/data.h |  8 +++++++
>  2 files changed, 55 insertions(+)
>
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index 18e5d94b0e97..7f13fbd9c043 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -7,11 +7,58 @@
>  #include <fcntl.h>
>  #include <unistd.h>
>  #include <string.h>
> +#include <asm/bug.h>
>
>  #include "data.h"
>  #include "util.h"
>  #include "debug.h"
>
> +static void close_dir(struct perf_data_file *files, int nr)
> +{
> +       while (--nr >= 1) {
> +               close(files[nr].fd);
> +               free(files[nr].path);
> +       }
> +       free(files);
> +}
> +
> +void perf_data__close_dir(struct perf_data *data)
> +{
> +       close_dir(data->dir.files, data->dir.nr);
> +}
> +
> +int perf_data__create_dir(struct perf_data *data, int nr)
> +{
> +       struct perf_data_file *files = NULL;
> +       int i, ret = -1;
> +
> +       files = malloc(nr * sizeof(*files));
> +       if (!files)
> +               return -ENOMEM;
> +
> +       data->dir.files = files;
> +       data->dir.nr    = nr;
> +
> +       for (i = 0; i < nr; i++) {
> +               struct perf_data_file *file = &files[i];
> +
> +               if (asprintf(&file->path, "%s/data.%d", data->path, i) < 0)
> +                       goto out_err;
> +
> +               ret = open(file->path, O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR);
> +               if (ret < 0)
> +                       goto out_err;

It seems you need to free the file->path here.

Thanks,
Namhyung


> +
> +               file->fd = ret;
> +       }
> +
> +       return 0;
> +
> +out_err:
> +       close_dir(files, i);
> +       return ret;
> +}
> +
>  static bool check_pipe(struct perf_data *data)
>  {
>         struct stat st;
> diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
> index 2bce28117ccf..2d0d015a7d4d 100644
> --- a/tools/perf/util/data.h
> +++ b/tools/perf/util/data.h
> @@ -21,6 +21,11 @@ struct perf_data {
>         bool                     is_pipe;
>         bool                     force;
>         enum perf_data_mode      mode;
> +
> +       struct {
> +               struct perf_data_file   *files;
> +               int                      nr;
> +       } dir;
>  };
>
>  static inline bool perf_data__is_read(struct perf_data *data)
> @@ -64,4 +69,7 @@ ssize_t perf_data_file__write(struct perf_data_file *file,
>  int perf_data__switch(struct perf_data *data,
>                            const char *postfix,
>                            size_t pos, bool at_exit);
> +
> +int perf_data__create_dir(struct perf_data *data, int nr);
> +void perf_data__close_dir(struct perf_data *data);
>  #endif /* __PERF_DATA_H */
> --
> 2.17.2
>
