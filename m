Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752833AbeCPD2E (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 23:28:04 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36190 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752378AbeCPD2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 23:28:02 -0400
X-Google-Smtp-Source: AG47ELso9QmFVm+Nm7UiJNdsAuzArXx7l3SnunoN8WzYDkaTuNmUV/GIahpOdtFvn7SrN1+KAhgSyw7dq3+jjA9B0pQ=
MIME-Version: 1.0
In-Reply-To: <201803161102.KN3yR10g%fengguang.wu@intel.com>
References: <20180313214327.37475-2-joelaf@google.com> <201803161102.KN3yR10g%fengguang.wu@intel.com>
From: Joel Fernandes <joelaf@google.com>
Date: Thu, 15 Mar 2018 20:28:01 -0700
Message-ID: <CAJWu+ooJ7yDRxHfKUiUJHfurJ+oXhzFP4MCFGm71BD=KuMdNpA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] tracing: Improve design of preemptirq tracepoints
 and its users
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 8:13 PM, kbuild test robot <lkp@intel.com> wrote:
> Hi Joel,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.16-rc5 next-20180314]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Joel-Fernandes/tracing-Improve-design-of-preemptirq-tracepoints-and-its-users/20180316-012211
> config: i386-randconfig-a1-201810 (attached as .config)
> compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> All errors (new ones prefixed by >>):
>
>    kernel/locking/lockdep.c: In function 'lockdep_init':
>>> kernel/locking/lockdep.c:4325:2: error: implicit declaration of function 'register_trace_irq_disable' [-Werror=implicit-function-declaration]
>      register_trace_irq_disable(lockdep_hardirqs_off, NULL);
>      ^
>>> kernel/locking/lockdep.c:4326:2: error: implicit declaration of function 'register_trace_irq_enable' [-Werror=implicit-function-declaration]
>      register_trace_irq_enable(lockdep_hardirqs_on, NULL);
>      ^
>    cc1: some warnings being treated as errors
>
> vim +/register_trace_irq_disable +4325 kernel/locking/lockdep.c

Can't reproduce this. Kbuild bot might be testing old patches. With
the latest patches and the config kbuild shared, I don't get any
errors.

thanks,

- Joel
