Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750942AbeDNJlR (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 05:41:17 -0400
Received: from mail-ot0-f179.google.com ([74.125.82.179]:44472 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbeDNJlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 05:41:15 -0400
X-Google-Smtp-Source: AIpwx49FdUDZ+0TtWZx3JoUZrQ+Qap5htva5eDQH9nz/5Eg1SO7POJFPAY/DfgLk29vTJ5F5MQphOMIKKGKLCEr+6zw=
MIME-Version: 1.0
From: Teck Choon Giam <giamteckchoon@gmail.com>
Date: Sat, 14 Apr 2018 17:41:13 +0800
Message-ID: <CAEwRVpOFS5UsyVHkHr+w_OR0eSpvT-CZGG6b4Vr6gxkc4rwO6g@mail.gmail.com>
Subject: kernel-4.9.94 compile error: 'KMOD_DECOMP_LEN' undeclared
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Compile linux-4.9.94 will have error related to KMOD_DECOMP_LEN
undeclared.  Searching string related to KMOD_DECOMP_LEN in
linux-4.9.94 and linux-4.15.17 sources as below:

<mock-chroot>sh-4.2# grep -r KMOD_DECOMP_LEN ./linux-4.15.17
./linux-4.15.17/tools/perf/tests/code-reading.c: char
decomp_name[KMOD_DECOMP_LEN];
./linux-4.15.17/tools/perf/util/dso.h:#define KMOD_DECOMP_LEN
sizeof(KMOD_DECOMP_NAME)
./linux-4.15.17/tools/perf/util/annotate.c: char tmp[KMOD_DECOMP_LEN];
./linux-4.15.17/tools/perf/util/dso.c: char newpath[KMOD_DECOMP_LEN];
sh-4.2# grep -r KMOD_DECOMP_LEN ./linux-4.9.94
./linux-4.9.94/tools/perf/tests/code-reading.c: char
decomp_name[KMOD_DECOMP_LEN];
./linux-4.9.94/tools/perf/util/dso.c: char newpath[KMOD_DECOMP_LEN];

So I guess for linux-4.9.94 has not define KMOD_DECOMP_LEN in
tools/perf/util/dso.h?

Thanks.

Regards,
Giam Teck Choon
