Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753597AbeEWAfT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 20:35:19 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41269 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752681AbeEWAfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 20:35:17 -0400
X-Google-Smtp-Source: AB8JxZoiE+0KA5ufN4gPuWR1PYz3FTsK3MvI6/00Dl/wr9I9rQMhfCsqV45UlfXEGxkCligyUzN3zlCDugNUiCovKYw=
MIME-Version: 1.0
In-Reply-To: <CANWdNRCQCteO7L+Of7T2vWBW7GbMHyvyF5aSQMVYNGg_afxNhg@mail.gmail.com>
References: <20180522062017.5193-1-xiyou.wangcong@gmail.com>
 <20180522062017.5193-4-xiyou.wangcong@gmail.com> <CANWdNRCQCteO7L+Of7T2vWBW7GbMHyvyF5aSQMVYNGg_afxNhg@mail.gmail.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Tue, 22 May 2018 17:34:57 -0700
Message-ID: <CAM_iQpV3o6Dj4xEgVQvJz0tvVLh4Tmvkjp=DdHFui+tNGevU+w@mail.gmail.com>
Subject: Re: [PATCH 3/3] sched/fair: add tracepoints for cfs throttle
To: Ivan Babrou <ibobrik@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 11:35 PM, Ivan Babrou <ibobrik@gmail.com> wrote:
>
>
> On Mon, May 21, 2018 at 11:20 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>>
>> +
>> +       TP_printk("path=%s cpu=%d runtime_remaining=%lld",
>> __get_str(cfs_path),
>> +                 __entry->cpu, __entry->runtime_remaining)
>
>
> Can you add "[ns]" as the unit to runtime_remaining? We have it in
> "sched:sched_stat_runtime".

Hmm, although it is indeed ns, this ->runtime_remaining can be negative,
unlike sched_stat_runtime. So I am not sure if I should marked it as "[ns]".
