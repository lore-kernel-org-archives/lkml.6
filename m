Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbeEBU1x (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 16:27:53 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37670 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbeEBU1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 16:27:49 -0400
X-Google-Smtp-Source: AB8JxZrR4e5t1PnSqDlZSWTGq2qKlXTlKnVwT9M5pdn3RxaUk5irz+cvAtlqStJRrpgG5/cWrLupTuBxdVvj48PQx4E=
MIME-Version: 1.0
In-Reply-To: <1525268700-10631-4-git-send-email-changbin.du@intel.com>
References: <1525268700-10631-1-git-send-email-changbin.du@intel.com> <1525268700-10631-4-git-send-email-changbin.du@intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 2 May 2018 16:27:47 -0400
X-Google-Sender-Auth: RVTm6l1lH2SWh0r-8t0siNmCOAs
Message-ID: <CAK8P3a01sgKSYKmzptkNn4xfoGzV=k+uHu0+wco_-x-iMFtVYQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
To: changbin.du@intel.com
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 2, 2018 at 9:44 AM,  <changbin.du@intel.com> wrote:
> From: Changbin Du <changbin.du@intel.com>
>
> This patch add a new kernel hacking option NO_AUTO_INLINE. Selecting
> this option will prevent the compiler from optimizing the kernel by
> auto-inlining functions not marked with the inline keyword.
>
> With this option, only functions explicitly marked with "inline" will
> be inlined. This will allow the function tracer to trace more functions
> because it only traces functions that the compiler has not inlined.
>
> Signed-off-by: Changbin Du <changbin.du@intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>

Should this be closer to CONFIG_OPTIMIZE_INLINING or
possibly mutually exclusive with it?

       Arnd
