Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeA3Nf0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 08:35:26 -0500
Received: from mail-oi0-f49.google.com ([209.85.218.49]:36378 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbeA3NfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 08:35:24 -0500
X-Google-Smtp-Source: AH8x2248pIzgGAZMVgyk6wLbvxkHVJHWVy4bBGxf/4TQe70Yqa7JNAyWsl+TyDnCZC6VWl+TJFWZXyU8lVwyJFARPeA=
MIME-Version: 1.0
In-Reply-To: <3f15868475cb4b32353885ee03c983209279fa81.1517192387.git.baolin.wang@linaro.org>
References: <3f15868475cb4b32353885ee03c983209279fa81.1517192387.git.baolin.wang@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 30 Jan 2018 14:35:23 +0100
X-Google-Sender-Auth: PIX55rQ07vW7VStVvttThASxvcI
Message-ID: <CAK8P3a1_tNGhqN+tbfbxtpdPJ+=ksNS4QJ=sPYCz7ORAqKVQAw@mail.gmail.com>
Subject: Re: [PATCH v2] kdb: use ktime_get_mono_fast_ns() instead of ktime_get_ts()
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Mark Brown <broonie@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 3:22 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
> The kdb code will print the monotonic time by ktime_get_ts(), but
> the ktime_get_ts() will be protected by a sequence lock, that will
> introduce one deadlock risk if the lock was already held in the
> context from which we entered the debugger.
>
> Thus we can use the ktime_get_mono_fast_ns() to get the monotonic
> time, which is NMI safe access to clock monotonic. Moreover we can
> remove the 'struct timespec', which is not y2038 safe.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
