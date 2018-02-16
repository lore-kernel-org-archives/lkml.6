Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750948AbeBPX5z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 18:57:55 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38282 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750824AbeBPX5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 18:57:53 -0500
Date: Fri, 16 Feb 2018 15:57:52 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] proc/kpageflags: add KPF_WAITERS
Message-Id: <20180216155752.4a17cfd41875911c79807585@linux-foundation.org>
In-Reply-To: <151834540184.176427.12174649162560874101.stgit@buzz>
References: <151834540184.176427.12174649162560874101.stgit@buzz>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Feb 2018 13:36:41 +0300 Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:

> KPF_WAITERS indicates tasks are waiting for a page lock or writeback.
> This might be false-positive, in this case next unlock will clear it.

Well, kpageflags is full of potential false-positives.  Or do you think
this flag is especially vulnerable?

In other words, under what circumstances will we have KPF_WAITERS set
when PG_locked and PG-writeback are clear?

> This looks like worth information not only for kernel hacking.

Why?  What are the use-cases, in detail?  How are we to justify this
modification?

> In tool page-types in non-raw mode treat KPF_WAITERS without
> KPF_LOCKED and KPF_WRITEBACK as false-positive and hide it.

>  fs/proc/page.c                         |    1 +
>  include/uapi/linux/kernel-page-flags.h |    1 +
>  tools/vm/page-types.c                  |    7 +++++++

Please update Documentation/vm/pagemap.txt.
