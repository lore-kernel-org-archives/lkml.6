Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D170EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 05:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D39120657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 05:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjW6Pjea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbfAQF4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 00:56:07 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38466 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfAQF4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 00:56:07 -0500
Received: by mail-lj1-f193.google.com with SMTP id c19-v6so7515066lja.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 21:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6MnWAj8UwhfxEIh519jo926apWvnyVGPR42Hx9biopI=;
        b=CjW6PjeaMc8UKC+Mh0SiiG/XIr5Cj8tmqiz0dXTkZYBoN8O2/R+SKTzgqWgj1G/1r8
         yTDh4y7Jpqc9Ayt0A16ByzpE8YA2kdijyu9g82zYlGchLDOrN0dFgkZ67QCQFQAxDnot
         gBo5RbDfTH52PrINuVeVrAfvZ+Un5UszP+sWk7hmZcuZuMXBqvgChNtqL4Get7EXM/Uz
         E8f90pIPVs19T8SzSe1yoASi9E7tcQoxR8zBcNsZZtv2a15n3DSTD18rL6NKPUR9wvUu
         PqSg0yCysp8ZqtE4W2dIFqxDhsOVCavUlbv6XGExyCuu55JHYxy+vJuWMcQktWDkQvY6
         rbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6MnWAj8UwhfxEIh519jo926apWvnyVGPR42Hx9biopI=;
        b=BggEX4V0ytP+S+ZisvnPpcUiYXE7yMraC5A2QTOwa2Cvymm8biYTCYZ4anNF6ViF17
         aJM0E0BT4WjFcDDRzuRuxt8LHqdyvX/rThVXXz9I9ioE/O3Hs108bdUNIpXlu3KVTDS+
         32dbi95Ef70yTQjzzcfH5ghMHn7d6yUg5U5fN4hTlg+6ilfjhF/j59pVrOQYKuRMNLB4
         Cd4p/LqWmGlwHSgANDfVW8nk62ahPDn5fWWR8s+zeyuEnlccMwidaQAv9t07bqnLS1b6
         3jcX1/mCVA9K3LapCWJ0hdj3HIJSipc9fl87B9UzgUPWpdGwZngDpVS3+UG3lJbmYmxb
         lVrg==
X-Gm-Message-State: AJcUukee6EGScDhn3A6wd9CEqYfDIFgJsv5kwjKAJPw2wlem0zo/vMHg
        h92gE/t9O4gtAEXmKNT6Jn3zXiskveYF2nruqM8=
X-Google-Smtp-Source: ALg8bN4Y0jX5qr8Ico0ZXAk9YVIuPZRL8QpWQRWe7ysuD7BJDIKrlODCDwfobksmYTnJY1WxSsAGtinDZ8B/NKBH8gE=
X-Received: by 2002:a2e:9c52:: with SMTP id t18-v6mr7842813ljj.149.1547704564885;
 Wed, 16 Jan 2019 21:56:04 -0800 (PST)
MIME-Version: 1.0
References: <20190115135916.GA3629@hp-pavilion-15-notebook-pc-brajeswar>
In-Reply-To: <20190115135916.GA3629@hp-pavilion-15-notebook-pc-brajeswar>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 17 Jan 2019 11:25:52 +0530
Message-ID: <CAFqt6zYyWANuBt773x64QDuvqsH4qsNE1yz9APo2Xxjdfm0pXg@mail.gmail.com>
Subject: Re: [PATCH] tools/perf: Remove duplicate header
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, acme@kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        jolsa@redhat.com, namhyung@kernel.org, colin.king@canonical.com,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 7:29 PM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove duplicate headers which are included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  tools/perf/builtin-stat.c     | 1 -
>  tools/perf/tests/bp_account.c | 1 -
>  tools/perf/util/dso.h         | 1 -
>  tools/perf/util/zlib.c        | 1 -
>  4 files changed, 4 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index d1028d7755bb..f919ffc4b3b3 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -83,7 +83,6 @@
>  #include <unistd.h>
>  #include <sys/time.h>
>  #include <sys/resource.h>
> -#include <sys/wait.h>
>
>  #include "sane_ctype.h"
>
> diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
> index a20cbc445426..57fc544aedb0 100644
> --- a/tools/perf/tests/bp_account.c
> +++ b/tools/perf/tests/bp_account.c
> @@ -15,7 +15,6 @@
>  #include <sys/mman.h>
>  #include <linux/compiler.h>
>  #include <linux/hw_breakpoint.h>
> -#include <sys/ioctl.h>
>
>  #include "tests.h"
>  #include "debug.h"
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index c5380500bed4..722d67a407e2 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -8,7 +8,6 @@
>  #include <sys/types.h>
>  #include <stdbool.h>
>  #include "rwsem.h"
> -#include <linux/types.h>
>  #include <linux/bitops.h>
>  #include "map.h"
>  #include "namespaces.h"
> diff --git a/tools/perf/util/zlib.c b/tools/perf/util/zlib.c
> index 902ce6384f57..512ad7c09b13 100644
> --- a/tools/perf/util/zlib.c
> +++ b/tools/perf/util/zlib.c
> @@ -6,7 +6,6 @@
>  #include <sys/mman.h>
>  #include <zlib.h>
>  #include <linux/compiler.h>
> -#include <unistd.h>
>
>  #include "util/compress.h"
>  #include "util/util.h"
> --
> 2.17.1
>
