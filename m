Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753193AbeEGVFq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 17:05:46 -0400
Received: from mail.efficios.com ([167.114.142.138]:54716 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753031AbeEGVFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 17:05:43 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2F4141B1743
Date: Mon, 7 May 2018 17:05:41 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Joel Fernandes <joelaf@google.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        fweisbec <fweisbec@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        baohong liu <baohong.liu@intel.com>,
        vedang patel <vedang.patel@intel.com>,
        kernel-team <kernel-team@android.com>
Message-ID: <568999860.209.1525727141943.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180507204143.13061-5-joelaf@google.com>
References: <20180507204143.13061-1-joelaf@google.com> <20180507204143.13061-5-joelaf@google.com>
Subject: Re: [PATCH RFC v6 4/5] tracepoint: Make rcuidle tracepoint callers
 use SRCU
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2026 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_2031)
Thread-Topic: tracepoint: Make rcuidle tracepoint callers use SRCU
Thread-Index: Plr0uP8pxuDHbbMQVMMmjb1ZX6x9GQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 7, 2018, at 4:41 PM, Joel Fernandes joelaf@google.com wrote:
[...]
> +extern struct srcu_struct tracepoint_srcu;
> +
> extern int
> tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
> extern int
> @@ -77,6 +80,9 @@ int unregister_tracepoint_module_notifier(struct
> notifier_block *nb)
>  */
> static inline void tracepoint_synchronize_unregister(void)
> {
> +#ifdef CONFIG_TRACEPOINTS
> +	synchronize_srcu(&tracepoint_srcu);
> +#endif
> 	synchronize_sched();

Why is this ifdef needed ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
