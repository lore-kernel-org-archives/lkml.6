Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752567AbeCZPi6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 11:38:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752470AbeCZPiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 11:38:55 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31F02175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 26 Mar 2018 11:38:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "daniel@bristot.me" <daniel@bristot.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "nab@linux-iscsi.org" <nab@linux-iscsi.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "williams@redhat.com" <williams@redhat.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "lclaudio@redhat.com" <lclaudio@redhat.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 2/2] target: remove spin_lock_assert() in
 __target_(attach|detach)_tg_pt_gp()
Message-ID: <20180326113852.1582e597@gandalf.local.home>
In-Reply-To: <1521827753.2535.18.camel@wdc.com>
References: <20180321153854.GB24312@kernel.org>
        <CA+55aFwKN_JijmCt=0S4jF8KzGPmoKNbuYF59va7U4ziJLLryA@mail.gmail.com>
        <20180322093745.GC4229@kernel.org>
        <20180323155513.dwbgvblenlji33as@linutronix.de>
        <1521822325.2535.5.camel@wdc.com>
        <CA+55aFxVkuntSektVmwXktzvfEezdDTAM_zj4DJdp3qJxWf8aA@mail.gmail.com>
        <20180323171736.bcyi2oiolge4l6hl@linutronix.de>
        <20180323171959.7ac6klrqg4fdk3ey@linutronix.de>
        <1521827085.2535.12.camel@wdc.com>
        <20180323175013.6uucllg5ogyzfovt@linutronix.de>
        <1521827753.2535.18.camel@wdc.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2018 17:55:54 +0000
Bart Van Assche <Bart.VanAssche@wdc.com> wrote:

> Comments are not verified at runtime and hence can become outdated if the code
> is modified. assert_spin_locked() and lockdep_assert_held() assertions however
> are verified at runtime with the proper kernel configuration options enabled.
> Hence my preference for assert_spin_locked()/lockdep_assert_held() over source
> code comments.

Asserts are fine, but when the code is static and used close to the
caller, asserts are overkill. A comment at the beginning of a function
should suffice. We do that all over the kernel for functions like that.

The asserts are there when the code can be called from other files, or
in multiple places.

-- Steve
