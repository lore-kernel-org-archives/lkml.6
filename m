Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754251AbeDTJ3W (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:29:22 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:43329 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754194AbeDTJ3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:29:21 -0400
X-Google-Smtp-Source: AIpwx49mbUoyw86c5xHby+uLJCvlSul+QuOM56v+lrGr4zRTuuucSjp9VJTQqZuQ8moFpGe8zCoATSslhBjwUcXRe9U=
MIME-Version: 1.0
In-Reply-To: <CAEwRVpOFS5UsyVHkHr+w_OR0eSpvT-CZGG6b4Vr6gxkc4rwO6g@mail.gmail.com>
References: <CAEwRVpOFS5UsyVHkHr+w_OR0eSpvT-CZGG6b4Vr6gxkc4rwO6g@mail.gmail.com>
From: Teck Choon Giam <giamteckchoon@gmail.com>
Date: Fri, 20 Apr 2018 17:29:19 +0800
Message-ID: <CAEwRVpPCFumSj45tCEbTg87u2wuG2AT+S69s4+uHCSM2pLR34A@mail.gmail.com>
Subject: Re: kernel-4.9.94 compile error: 'KMOD_DECOMP_LEN' undeclared
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

> <mock-chroot>sh-4.2# grep -r KMOD_DECOMP_LEN ./linux-4.15.17
> ./linux-4.15.17/tools/perf/tests/code-reading.c: char
> decomp_name[KMOD_DECOMP_LEN];
> ./linux-4.15.17/tools/perf/util/dso.h:#define KMOD_DECOMP_LEN
> sizeof(KMOD_DECOMP_NAME)
> ./linux-4.15.17/tools/perf/util/annotate.c: char tmp[KMOD_DECOMP_LEN];
> ./linux-4.15.17/tools/perf/util/dso.c: char newpath[KMOD_DECOMP_LEN];
> sh-4.2# grep -r KMOD_DECOMP_LEN ./linux-4.9.94
> ./linux-4.9.94/tools/perf/tests/code-reading.c: char
> decomp_name[KMOD_DECOMP_LEN];
> ./linux-4.9.94/tools/perf/util/dso.c: char newpath[KMOD_DECOMP_LEN];
>
> So I guess for linux-4.9.94 has not define KMOD_DECOMP_LEN in
> tools/perf/util/dso.h?

grep -r KMOD_DECOMP_LEN ./linux-4.9.95
./linux-4.9.95/tools/perf/util/dso.c: char newpath[KMOD_DECOMP_LEN];

linux-4.9.95 still can't compile for tools/perf:

util/dso.c:370:16: error: 'KMOD_DECOMP_LEN' undeclared (first use in
this function)
make[3]: *** [util/dso.o] Error 1
make[2]: *** [util] Error 2
make[1]: *** [libperf-in.o] Error 2
make: *** [all] Error 2

Thanks.

Regards,
Giam Teck Choon
