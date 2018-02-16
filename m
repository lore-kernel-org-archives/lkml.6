Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752421AbeBPElU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 23:41:20 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36191 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752369AbeBPElT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 23:41:19 -0500
X-Google-Smtp-Source: AH8x2257lwwdJlLSgBzZX35ZyblDfTjuQWfayz8l2BP6pTsJwV/rLXvn08o4NoxjaJqULENejYbewA==
Date: Fri, 16 Feb 2018 07:41:15 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 1/3] proc: randomize "struct pde_opener"
Message-ID: <20180216044115.GA7811@avx2>
References: <20180214063033.GA15579@avx2>
 <20180214081935.GA17157@avx2>
 <CAGXu5jKv5EehXn7tNc9n=Zd_tT5AcNeQm5_rT81m6OAWXXpMYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKv5EehXn7tNc9n=Zd_tT5AcNeQm5_rT81m6OAWXXpMYQ@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 04:53:29PM -0800, Kees Cook wrote:
> On Wed, Feb 14, 2018 at 12:19 AM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > The more the merrier.
> 
> What made you choose this structure, BTW?

Nothing depends on its layout. No funky memcpy/memset...
It is strange you didn't annotate like 95% of structs.

> > @@ -177,7 +177,7 @@ struct pde_opener {
> >         struct list_head lh;
> >         bool closing;
> >         struct completion *c;
> > -};
> > +} __randomize_layout;
