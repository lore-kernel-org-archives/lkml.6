Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeBFHPk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 02:15:40 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:44461 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbeBFHPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 02:15:34 -0500
X-Google-Smtp-Source: AH8x2266Bye0/X2FpZwdrZan68XUjQyNQd0oihDc6xfipYqTrxmF7CuE7Fay8KHsvu2ZZQqzaHo2XDNK1VtaT92j8Ww=
MIME-Version: 1.0
In-Reply-To: <20180206023950.64030-1-joelaf@google.com>
References: <20180206023950.64030-1-joelaf@google.com>
From: Joel Fernandes <joelaf@google.com>
Date: Mon, 5 Feb 2018 23:15:32 -0800
Message-ID: <CAJWu+ooXZRVUhsc9mSLc2H28EeX=8XyDo6iMPur3DtH=y=rxAA@mail.gmail.com>
Subject: Re: [RFC] tracing: Improve design of preemptirq tracepoints and its users
To: LKML <linux-kernel@vger.kernel.org>
Cc: Joel Fernandes <joelaf@google.com>,
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

On Mon, Feb 5, 2018 at 6:39 PM, Joel Fernandes <joelaf@google.com> wrote:
> This patch detaches the preemptirq tracepoints from the tracers and
> keeps it separate. With this, several ifdefs are cleaner, and lockdep
> and other users can use the preemptirq tracepoints by registering probes
> onto them. This makes it much cleaner, but not just that: PROVE_LOCKING
> and CONFIG_IRQSOFF_TRACER can be enabled now at the same time and we
> get rid of all the horrific ifdeferry around PROVE_LOCKING.
>

Sorry for the misstatement, irqsoff tracer and PROVE_LOCKING can still
be used at the same time (without this patch). I will correct the
commit message in the next rev. However this patch avoids the
complication that arises when enabling the 2 together, by eliminating
time_hardirqs_on/off.

thanks,

- Joel
