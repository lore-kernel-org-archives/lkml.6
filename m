Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755104AbeCSBj6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 21:39:58 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:32809 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754916AbeCSBj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 21:39:56 -0400
X-Google-Smtp-Source: AG47ELuemFmMuhgm+gM2FjF+nN6rDkOfpLeiqpOAXwmvVC8deF5KvQdOftg5/Vng+EfcLEo8kw/yjAAexGj3ytVHXfg=
MIME-Version: 1.0
In-Reply-To: <201803180239.bVSVPTE1%fengguang.wu@intel.com>
References: <20180315204401.68282-2-joelaf@google.com> <201803180239.bVSVPTE1%fengguang.wu@intel.com>
From: Joel Fernandes <joelaf@google.com>
Date: Sun, 18 Mar 2018 18:39:54 -0700
Message-ID: <CAJWu+orG8WGqfsMd0=Z-4vCskW=LzRfWkQyNjZxSoDbE2YtKSQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tracing: Improve design of preemptirq tracepoints
 and its users
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 17, 2018 at 12:03 PM, kbuild test robot <lkp@intel.com> wrote:
> Hi Joel,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.16-rc5 next-20180316]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Joel-Fernandes/Improve-preemptirq-tracepoint-usage/20180317-155535
> config: arm-moxart_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm
>
> All errors (new ones prefixed by >>):
>
>    arch/arm/kernel/entry-common.o: In function `no_work_pending':
>>> (.entry.text+0x64): undefined reference to `trace_hardirqs_on'
>    arch/arm/kernel/entry-common.o: In function `vector_swi':
>    (.entry.text+0xf8): undefined reference to `trace_hardirqs_on'
>    arch/arm/kernel/entry-armv.o: In function `__dabt_svc':
>>> (.entry.text+0xa4): undefined reference to `trace_hardirqs_off'
>    (.entry.text+0xb8): undefined reference to `trace_hardirqs_on'
>    (.entry.text+0xc0): undefined reference to `trace_hardirqs_off'
>    arch/arm/kernel/entry-armv.o: In function `__irq_svc':

Fixed in the next rev. Sigh :-( Turns out kernel/trace/ wasn't being
built at all because of a combination of
CONFIG_PREEMPTIRQ_TRACEPOINTS=y but CONFIG_TRACING=n

I think the next rev looks much better now and its getting there, but
I have to thoroughly test it before posting it again..

thanks,

- Joel
