Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753565AbeEWASM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 20:18:12 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37117 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753511AbeEWASJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 20:18:09 -0400
X-Google-Smtp-Source: AB8JxZri3NayspCL9UslFFOYUfMz+vkyviMAoWN6NamGHSAcCo8aWNIWTqznZaY2HMe41+7asGb5pg==
Date: Tue, 22 May 2018 17:18:08 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: "Joel Fernandes (Google)" <joelaf@google.com>
Cc: linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>, Todd Kjos <tkjos@google.com>,
        claudio@evidence.eu.com, kernel-team@android.com,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH RFC] schedutil: Address the r/w ordering race in kthread
Message-ID: <20180523001808.GC55359@joelaf.mtv.corp.google.com>
References: <20180522235028.80564-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522235028.80564-1-joel@joelfernandes.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 04:50:28PM -0700, Joel Fernandes (Google) wrote:
> Currently there is a race in schedutil code for slow-switch single-CPU
> systems. Fix it by enforcing ordering the write to work_in_progress to
> happen before the read of next_freq.

Aargh, s/before/after/.

Commit log has above issue but code is Ok. Should I resend this patch or
are there any additional comments? thanks!

 - Joel

[..] 
