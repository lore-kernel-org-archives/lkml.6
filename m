Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756761AbeDXLpc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 07:45:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44754 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753221AbeDXLp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 07:45:29 -0400
Date: Tue, 24 Apr 2018 04:45:17 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: jack@suse.cz, Al Viro <viro@zeniv.linux.org.uk>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>, kirill.shutemov@linux.intel.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] fs: dax: Adding new return type vm_fault_t
Message-ID: <20180424114517.GC26636@bombadil.infradead.org>
References: <20180423180625.GA16101@jordon-HP-15-Notebook-PC>
 <20180423194917.GF13383@bombadil.infradead.org>
 <CAFqt6zatfzk8PmBN110LD_x8goU+vO4U9TAGaamJ4UqwRm+g_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zatfzk8PmBN110LD_x8goU+vO4U9TAGaamJ4UqwRm+g_g@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 11:29:39AM +0530, Souptick Joarder wrote:
> On Tue, Apr 24, 2018 at 1:19 AM, Matthew Wilcox <willy@infradead.org> wrote:
> > On Mon, Apr 23, 2018 at 11:36:25PM +0530, Souptick Joarder wrote:
> >> If the insertion of PTE failed because someone else
> >> already added a different entry in the mean time, we
> >> treat that as success as we assume the same entry was
> >> actually inserted.
> >
> > No, Jan said to *make it a comment*.  In the source file.  That's why
> > he formatted it with the /* */.  Not in the changelog.
> Sorry, got confused.
> 
> I think this should be fine -
> 
> +/*
> +If the insertion of PTE failed because someone else
> +already added a different entry in the mean time, we
> +treat that as success as we assume the same entry was
> +actually inserted.
> +*/

Jan literally typed out exactly what you need to insert:

/*
 * If the insertion of PTE failed because someone else already added a
 * different entry in the mean time, we treat that as success as we assume
 * the same entry was actually inserted.
 */

For some reason you've chosen to wrap the lines shorter than Jan had them,
and use a different comment formatting style from the rest of the kernel.
Why?  I'd suggest re-reading Documentation/process/coding-style.rst
