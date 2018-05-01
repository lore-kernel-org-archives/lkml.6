Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755865AbeEAOG2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 10:06:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755363AbeEAOG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 10:06:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DED32366C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 1 May 2018 10:06:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joelaf@google.com>
Cc: linux-kernel@vger.kernel.org, Peter Zilstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>, kernel-team@android.com
Subject: Re: [PATCH RFC v5 3/6] srcu: Add notrace variant of
 srcu_dereference
Message-ID: <20180501100623.7ebec465@gandalf.local.home>
In-Reply-To: <20180501014204.67548-4-joelaf@google.com>
References: <20180501014204.67548-1-joelaf@google.com>
        <20180501014204.67548-4-joelaf@google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2018 18:42:01 -0700
Joel Fernandes <joelaf@google.com> wrote:

> In this series, we are making lockdep use an rcuidle tracepoint. For
> this reason we need a notrace variant of srcu_dereference since
> otherwise we get lockdep splats since lockdep hooks may not have run
> yet. This patch adds the needed variant.

This change log is rather confusing. Why would lockdep use an rcuidle
tracepoint? I think we need to explain more here.

-- Steve
