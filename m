Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752753AbeC3DcZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 23:32:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53281 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752487AbeC3DcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 23:32:24 -0400
X-Google-Smtp-Source: AIpwx4+Xe4gFGdU9EYlZaztKYrbwURU+6zvbF99i2J50+u2XItuoct4bX5jlaUVBf2y/Xn7dukolW2ZH2S2NWDr+agU=
MIME-Version: 1.0
In-Reply-To: <20180329120528.337bf6cb@gandalf.local.home>
References: <1522320104-6573-1-git-send-email-zhaoyang.huang@spreadtrum.com> <20180329120528.337bf6cb@gandalf.local.home>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 30 Mar 2018 11:32:22 +0800
Message-ID: <CAGWkznGH96VcMujvep5VtwO6M42YOmXtV=M+QZM+xWH_5DPcEA@mail.gmail.com>
Subject: Re: [PATCH v1] kernel/trace:check the val against the available mem
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-patch-test@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2018 at 12:05 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu, 29 Mar 2018 18:41:44 +0800
> Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>
>> It is reported that some user app would like to echo a huge
>> number to "/sys/kernel/debug/tracing/buffer_size_kb" regardless
>>  of the available memory, which will cause the coinstantaneous
>> page allocation failed and introduce OOM. The commit checking the
>> val against the available mem first to avoid the consequence allocation.
>>
>
> One of my tests is to stress buffer_size_kb, and it fails nicely if you
> try to get too much. Although, it may cause an OOM, but that's expected.
>
> The application should do the test (try "free" on the command line).
> This isn't something that the kernel should be responsible for. If
> someone wants to allocate all memory for tracing, that's their
> prerogative.
>
> -- Steve
Steve, thanks for your quick feedback. The original purpose is to
avoid such kind
of OOM as kernel can not define the behavior of the application. I
think it is no need
to do the alloc->free process if we have known the number of pages
difinitly lead to failure.
Furthermore,  the app which screw up the thing usually escape the OOM and cause
the innocent to be sacrificed.
