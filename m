Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937809AbeBUQuN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:50:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42534 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932778AbeBUQuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:50:10 -0500
Date: Wed, 21 Feb 2018 08:50:06 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: Use higher-order pages in vmalloc
Message-ID: <20180221165006.GA27687@bombadil.infradead.org>
References: <151670492223.658225.4605377710524021456.stgit@buzz>
 <151670493255.658225.2881484505285363395.stgit@buzz>
 <20180221154214.GA4167@bombadil.infradead.org>
 <CALCETrU5jaennr5ziS9NzNA6KpK204acdroJpuc6yYy3PGvpHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrU5jaennr5ziS9NzNA6KpK204acdroJpuc6yYy3PGvpHQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 04:11:16PM +0000, Andy Lutomirski wrote:
> On Wed, Feb 21, 2018 at 3:42 PM, Matthew Wilcox <willy@infradead.org> wrote:
> > +++ b/kernel/fork.c
> > @@ -319,12 +319,12 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
> >         if (vm) {
> >                 int i;
> >
> > -               BUG_ON(vm->nr_pages != THREAD_SIZE / PAGE_SIZE);
...
> > +               if (j) {
> > +                       area->nr_pages -= (1UL << j) - 1;
> 
> Is there any code that expects area->nr_pages to be the size of the
> area in pages?  I don't know of any such code.

I found one and deleted it ;-)
