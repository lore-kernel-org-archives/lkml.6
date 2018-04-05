Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752953AbeDET5b (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 15:57:31 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:36865 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752746AbeDET53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 15:57:29 -0400
X-Google-Smtp-Source: AIpwx4+ltDAyrcUzLO5MFRJos8jnkBxvf89Fz9h0EyKbkNkm9NBfG4Ka0p976u0dhjUTyQoiAqbxuh+YIjC9fAQAnzE=
MIME-Version: 1.0
In-Reply-To: <20180405094346.104cf288@gandalf.local.home>
References: <20180404115310.6c69e7b9@gandalf.local.home> <20180404120002.6561a5bc@gandalf.local.home>
 <CAJWu+orC-1JDYHDTQU+DFckGq5ZnXBCCq9wLG-gNK0Nc4-vo7w@mail.gmail.com>
 <20180404121326.6eca4fa3@gandalf.local.home> <CAJWu+op5-sr=2xWDYcd7FDBeMtrM9Zm96BgGzb4Q31UGBiU3ew@mail.gmail.com>
 <CAJWu+opM6RjK-Z1dr35XvQ5cLKaV=cLG5uMu-rLkoO=X03c+FA@mail.gmail.com> <20180405094346.104cf288@gandalf.local.home>
From: Joel Fernandes <joelaf@google.com>
Date: Thu, 5 Apr 2018 12:57:28 -0700
Message-ID: <CAJWu+oqT0oPrEL4mPnWvF3Zt-psg2DWGj9Nrr+fda2JYFzRmqg@mail.gmail.com>
Subject: Re: [PATCH] ring-buffer: Add set/clear_current_oom_origin() during allocations
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, kernel-patch-test@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Thu, Apr 5, 2018 at 6:43 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 4 Apr 2018 16:59:18 -0700
> Joel Fernandes <joelaf@google.com> wrote:
>
>> Happy to try anything else, BTW when the si_mem_available check
>> enabled, this doesn't happen and the buffer_size_kb write fails
>> normally without hurting anything else.
>
> Can you remove the RETRY_MAYFAIL and see if you can try again? It may
> be that we just remove that, and if si_mem_available() is wrong, it
> will kill the process :-/ My original code would only add MAYFAIL if it
> was a kernel thread (which is why I created the mflags variable).

Tried this. Dropping RETRY_MAYFAIL and the si_mem_available check
destabilized the system and brought it down (along with OOM killing
the victim).

System hung for several seconds and then both the memory hog and bash
got killed.

thanks,

- Joel
