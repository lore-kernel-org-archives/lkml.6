Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFF7C10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89EDE217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499481;
	bh=d1DjLuy9vdHw3AVzlqwwocJxzHeCjpXmU18OUepR4ic=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CRgZdGMaBpLlpQNZi9eUBAX7KVYegEgEqEvVC2fSfO6fcWkEle42FXUG7u8ht6Olm
	 5OiM9yfpKZ3uSFHQ7A6DEOsOUboJZcyQKvv/6C/7n366Ywb/Z+TfrpMU3RopjMkPxL
	 5WMmjhcCluh5hqKgFX63EwFefVR3KLRMFRu51DMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391125AbfBROJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:09:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39576 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391107AbfBROJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:09:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id l5so17429343wrw.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 06:09:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fMM8WcKhyRRdsMop1RMW+GBtK02EPt2099aXNawo/jA=;
        b=r6Rop1rAdizJRi3wo+qiatywaBB97miUeKDkYsuSznWlbqVnx1+HMMV81kzvDR4NBL
         dqn0emCDySlwKJOzCxpO2wo7IgF3T3pRnr6lip5xqoJVrFAPKRqr7ITRGW0beQgYQSaY
         /SXD88b55otMLZsqeeRbumLbhtd307wiBlr0dhEYOfJQCIeP0LKjlYwxO/7Oel/LGce6
         itzjyTG2YJswL2GnOolsGup11xdXAGIQ7Pjtw6x7FAn05AhDQRS++/YwhDqinu13qUwY
         5NUdXueir6yPnxrPQEeHS3gckOxby+dDJigwUNX7wSAYq/wcYxytMp+kw7qDOmdZhxEC
         avDg==
X-Gm-Message-State: AHQUAuaAdm7Vf+Riuvi1FkxJdX/z3ptd/e0uC+haJKyn0HWugYxP0xiY
        Dpe5tT5YMnItSZL85ModNwCzbkHwF4xQZkcjRDU=
X-Google-Smtp-Source: AHgI3IZIj9fjOajrYW85kX4B50SVY+HTbNUFxK70Fcb+a5srudl9XDnMKfGfkhFnu8/jp65LSBEsNWS/Ebgm8OeQR50=
X-Received: by 2002:a5d:4145:: with SMTP id c5mr16704495wrq.256.1550498948747;
 Mon, 18 Feb 2019 06:09:08 -0800 (PST)
MIME-Version: 1.0
References: <20190218113927.30841-1-jolsa@kernel.org> <20190218113927.30841-4-jolsa@kernel.org>
In-Reply-To: <20190218113927.30841-4-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 18 Feb 2019 23:08:55 +0900
Message-ID: <CAM9d7cjEaUmYhduf2ddgxOAZw9=1NfsNTScwZZENPzXvUyMBaw@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf tools: Add numa_topology object
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jirka,

On Mon, Feb 18, 2019 at 8:39 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding numa_topology object to return the list of numa
> nodes together with their cpus. It will replace the numa
> code in header.c and will be used from perf record code
> in following patches.
>
> Adding following interface functions to load numa details:
>
>   struct numa_topology *numa_topology__new(void);
>   void numa_topology__delete(struct numa_topology *tp);
>
> And replacing current (copied) local interface, with no
> functional changes.
>
> Link: http://lkml.kernel.org/n/tip-rn15st6hjj7txg2i88v7yff4@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/cputopo.c | 120 ++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/cputopo.h |  16 +++++
>  tools/perf/util/header.c  | 119 +++++++++----------------------------
>  3 files changed, 162 insertions(+), 93 deletions(-)
>
> diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
> index 84470ed4e707..daac3cf90b12 100644
> --- a/tools/perf/util/cputopo.c
> +++ b/tools/perf/util/cputopo.c
> @@ -1,9 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <sys/param.h>
> +#include <inttypes.h>
>
>  #include "cputopo.h"
>  #include "cpumap.h"
>  #include "util.h"
> +#include "env.h"
>
>
>  #define CORE_SIB_FMT \
> @@ -142,3 +144,121 @@ struct cpu_topology *cpu_topology__new(void)
>         }
>         return tp;
>  }
> +
> +static int load_numa_node(struct numa_topology_node *node, int nr)
> +{
> +       char str[MAXPATHLEN];
> +       char field[32];
> +       char *buf = NULL, *p;
> +       size_t len = 0;
> +       int ret = -1;
> +       FILE *fp;
> +       u64 mem;
> +
> +       node->node = (u32) nr;
> +
> +       sprintf(str, "/sys/devices/system/node/node%d/meminfo", nr);

Why not using similar macro like NODE_MEMINFO_FMT?
Also it'd be better using snprintf() or scnprintf() instead.


> +       fp = fopen(str, "r");
> +       if (!fp)
> +               return -1;
> +
> +       while (getline(&buf, &len, fp) > 0) {
> +               /* skip over invalid lines */
> +               if (!strchr(buf, ':'))
> +                       continue;
> +               if (sscanf(buf, "%*s %*d %31s %"PRIu64, field, &mem) != 2)
> +                       goto err;
> +               if (!strcmp(field, "MemTotal:"))
> +                       node->mem_total = mem;
> +               if (!strcmp(field, "MemFree:"))
> +                       node->mem_free = mem;
> +               if (node->mem_total && node->mem_free)
> +                       break;
> +       }
> +
> +       fclose(fp);
> +       fp  = NULL;
> +       buf = NULL;

No need to make them NULL.  Also it'd leak buf..


> +
> +       ret = -1;

It's not changed yet.

Thanks,
Namhyung


> +       sprintf(str, "/sys/devices/system/node/node%d/cpulist", nr);
> +
> +       fp = fopen(str, "r");
> +       if (!fp)
> +               return -1;
> +
> +       if (getline(&buf, &len, fp) <= 0)
> +               goto err;
> +
> +       p = strchr(buf, '\n');
> +       if (p)
> +               *p = '\0';
> +
> +       node->cpus = buf;
> +       fclose(fp);
> +       return 0;
> +
> +err:
> +       free(buf);
> +       if (fp)
> +               fclose(fp);
> +       return ret;
> +}
> +
> +struct numa_topology *numa_topology__new(void)
> +{
> +       struct cpu_map *node_map = NULL;
> +       struct numa_topology *tp = NULL;
> +       char *buf = NULL;
> +       size_t len = 0;
> +       u32 nr, i;
> +       FILE *fp;
> +       char *c;
> +
> +       fp = fopen("/sys/devices/system/node/online", "r");
> +       if (!fp)
> +               return NULL;
> +
> +       if (getline(&buf, &len, fp) <= 0)
> +               goto out;
> +
> +       c = strchr(buf, '\n');
> +       if (c)
> +               *c = '\0';
> +
> +       node_map = cpu_map__new(buf);
> +       if (!node_map)
> +               goto out;
> +
> +       nr = (u32) node_map->nr;
> +
> +       tp = zalloc(sizeof(*tp) + sizeof(tp->nodes[0])*nr);
> +       if (!tp)
> +               goto out;
> +
> +       tp->nr = nr;
> +
> +       for (i = 0; i < nr; i++) {
> +               if (load_numa_node(&tp->nodes[i], node_map->map[i])) {
> +                       numa_topology__delete(tp);
> +                       tp = NULL;
> +                       break;
> +               }
> +       }
> +
> +out:
> +       free(buf);
> +       fclose(fp);
> +       cpu_map__put(node_map);
> +       return tp;
> +}
> +
> +void numa_topology__delete(struct numa_topology *tp)
> +{
> +       u32 i;
> +
> +       for (i = 0; i < tp->nr; i++)
> +               free(tp->nodes[i].cpus);
> +
> +       free(tp);
> +}
> diff --git a/tools/perf/util/cputopo.h b/tools/perf/util/cputopo.h
> index 4b5f4112b6f8..47a97e71acdf 100644
> --- a/tools/perf/util/cputopo.h
> +++ b/tools/perf/util/cputopo.h
> @@ -3,6 +3,7 @@
>  #define __PERF_CPUTOPO_H
>
>  #include <linux/types.h>
> +#include "env.h"
>
>  struct cpu_topology {
>         u32       core_sib;
> @@ -11,7 +12,22 @@ struct cpu_topology {
>         char    **thread_siblings;
>  };
>
> +struct numa_topology_node {
> +       char            *cpus;
> +       u32              node;
> +       u64              mem_total;
> +       u64              mem_free;
> +};
> +
> +struct numa_topology {
> +       u32                             nr;
> +       struct numa_topology_node       nodes[0];
> +};
> +
>  struct cpu_topology *cpu_topology__new(void);
>  void cpu_topology__delete(struct cpu_topology *tp);
>
> +struct numa_topology *numa_topology__new(void);
> +void numa_topology__delete(struct numa_topology *tp);
> +
>  #endif /* __PERF_CPUTOPO_H */
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 80ac57e6d38f..a2323d777dae 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -639,112 +639,45 @@ static int write_total_mem(struct feat_fd *ff,
>         return ret;
>  }
>
> -static int write_topo_node(struct feat_fd *ff, int node)
> -{
> -       char str[MAXPATHLEN];
> -       char field[32];
> -       char *buf = NULL, *p;
> -       size_t len = 0;
> -       FILE *fp;
> -       u64 mem_total, mem_free, mem;
> -       int ret = -1;
> -
> -       sprintf(str, "/sys/devices/system/node/node%d/meminfo", node);
> -       fp = fopen(str, "r");
> -       if (!fp)
> -               return -1;
> -
> -       while (getline(&buf, &len, fp) > 0) {
> -               /* skip over invalid lines */
> -               if (!strchr(buf, ':'))
> -                       continue;
> -               if (sscanf(buf, "%*s %*d %31s %"PRIu64, field, &mem) != 2)
> -                       goto done;
> -               if (!strcmp(field, "MemTotal:"))
> -                       mem_total = mem;
> -               if (!strcmp(field, "MemFree:"))
> -                       mem_free = mem;
> -       }
> -
> -       fclose(fp);
> -       fp = NULL;
> -
> -       ret = do_write(ff, &mem_total, sizeof(u64));
> -       if (ret)
> -               goto done;
> -
> -       ret = do_write(ff, &mem_free, sizeof(u64));
> -       if (ret)
> -               goto done;
> -
> -       ret = -1;
> -       sprintf(str, "/sys/devices/system/node/node%d/cpulist", node);
> -
> -       fp = fopen(str, "r");
> -       if (!fp)
> -               goto done;
> -
> -       if (getline(&buf, &len, fp) <= 0)
> -               goto done;
> -
> -       p = strchr(buf, '\n');
> -       if (p)
> -               *p = '\0';
> -
> -       ret = do_write_string(ff, buf);
> -done:
> -       free(buf);
> -       if (fp)
> -               fclose(fp);
> -       return ret;
> -}
> -
>  static int write_numa_topology(struct feat_fd *ff,
>                                struct perf_evlist *evlist __maybe_unused)
>  {
> -       char *buf = NULL;
> -       size_t len = 0;
> -       FILE *fp;
> -       struct cpu_map *node_map = NULL;
> -       char *c;
> -       u32 nr, i, j;
> +       struct numa_topology *tp;
>         int ret = -1;
> +       u32 i;
>
> -       fp = fopen("/sys/devices/system/node/online", "r");
> -       if (!fp)
> -               return -1;
> +       tp = numa_topology__new();
> +       if (!tp)
> +               return -ENOMEM;
>
> -       if (getline(&buf, &len, fp) <= 0)
> -               goto done;
> +       ret = do_write(ff, &tp->nr, sizeof(u32));
> +       if (ret < 0)
> +               goto err;
>
> -       c = strchr(buf, '\n');
> -       if (c)
> -               *c = '\0';
> +       for (i = 0; i < tp->nr; i++) {
> +               struct numa_topology_node *n = &tp->nodes[i];
>
> -       node_map = cpu_map__new(buf);
> -       if (!node_map)
> -               goto done;
> -
> -       nr = (u32)node_map->nr;
> +               ret = do_write(ff, &n->node, sizeof(u32));
> +               if (ret < 0)
> +                       goto err;
>
> -       ret = do_write(ff, &nr, sizeof(nr));
> -       if (ret < 0)
> -               goto done;
> +               ret = do_write(ff, &n->mem_total, sizeof(u64));
> +               if (ret)
> +                       goto err;
>
> -       for (i = 0; i < nr; i++) {
> -               j = (u32)node_map->map[i];
> -               ret = do_write(ff, &j, sizeof(j));
> -               if (ret < 0)
> -                       break;
> +               ret = do_write(ff, &n->mem_free, sizeof(u64));
> +               if (ret)
> +                       goto err;
>
> -               ret = write_topo_node(ff, j);
> +               ret = do_write_string(ff, n->cpus);
>                 if (ret < 0)
> -                       break;
> +                       goto err;
>         }
> -done:
> -       free(buf);
> -       fclose(fp);
> -       cpu_map__put(node_map);
> +
> +       ret = 0;
> +
> +err:
> +       numa_topology__delete(tp);
>         return ret;
>  }
>
> --
> 2.17.2
>


-- 
Thanks,
Namhyung
