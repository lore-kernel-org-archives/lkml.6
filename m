Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751487AbeDENoC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 09:44:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751275AbeDENnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 09:43:49 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E9E20B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 5 Apr 2018 09:43:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joelaf@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, kernel-patch-test@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] ring-buffer: Add set/clear_current_oom_origin() during
 allocations
Message-ID: <20180405094346.104cf288@gandalf.local.home>
In-Reply-To: <CAJWu+opM6RjK-Z1dr35XvQ5cLKaV=cLG5uMu-rLkoO=X03c+FA@mail.gmail.com>
References: <20180404115310.6c69e7b9@gandalf.local.home>
        <20180404120002.6561a5bc@gandalf.local.home>
        <CAJWu+orC-1JDYHDTQU+DFckGq5ZnXBCCq9wLG-gNK0Nc4-vo7w@mail.gmail.com>
        <20180404121326.6eca4fa3@gandalf.local.home>
        <CAJWu+op5-sr=2xWDYcd7FDBeMtrM9Zm96BgGzb4Q31UGBiU3ew@mail.gmail.com>
        <CAJWu+opM6RjK-Z1dr35XvQ5cLKaV=cLG5uMu-rLkoO=X03c+FA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2018 16:59:18 -0700
Joel Fernandes <joelaf@google.com> wrote:

> Happy to try anything else, BTW when the si_mem_available check
> enabled, this doesn't happen and the buffer_size_kb write fails
> normally without hurting anything else.

Can you remove the RETRY_MAYFAIL and see if you can try again? It may
be that we just remove that, and if si_mem_available() is wrong, it
will kill the process :-/ My original code would only add MAYFAIL if it
was a kernel thread (which is why I created the mflags variable).

-- Steve
