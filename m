Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752351AbeCOUT6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 16:19:58 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53485 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751750AbeCOUT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 16:19:57 -0400
X-Google-Smtp-Source: AG47ELumTARqt0iDZZCyOBTiw7R/5UwI2Fujh6LLmftPo6CxJzY8XeIeqx5dxmjutqQPDmgn/7BNm3FfQi2NqzoCDxY=
MIME-Version: 1.0
In-Reply-To: <201803160351.YXuH1FAL%fengguang.wu@intel.com>
References: <20180313214327.37475-2-joelaf@google.com> <201803160351.YXuH1FAL%fengguang.wu@intel.com>
From: Joel Fernandes <joelaf@google.com>
Date: Thu, 15 Mar 2018 13:19:54 -0700
Message-ID: <CAJWu+oqsDT28t_2=dUcjrid=0S3dLzM-Y2YrpYJWc-RoQKJBxg@mail.gmail.com>
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

Hello,

On Thu, Mar 15, 2018 at 12:51 PM, kbuild test robot <lkp@intel.com> wrote:
>
> Hi Joel,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.16-rc5 next-20180315]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Joel-Fernandes/tracing-Improve-design-of-preemptirq-tracepoints-and-its-users/20180316-012211
> config: i386-randconfig-x006-201810 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> All errors (new ones prefixed by >>):
>
>    kernel//locking/lockdep.c: In function 'lockdep_init':
> >> kernel//locking/lockdep.c:4325:2: error: implicit declaration of function 'register_trace_irq_disable'; did you mean 'trace_irq_disable'? [-Werror=implicit-function-declaration]
>      register_trace_irq_disable(lockdep_hardirqs_off, NULL);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~

The reason for this is PREEMPTIRQ_TRACEPOINTS depends on FTRACE which
is turned off in the config. Its a combination I hadn't tested in my
matrix. It causes build errors in in lockdep code that tries to
register the lockdep hooks. I'll fix it in the next rev. Thanks.

- Joel
