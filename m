Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932161AbeDWR30 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 13:29:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45552 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932073AbeDWR3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 13:29:22 -0400
Date: Mon, 23 Apr 2018 10:28:40 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        mawilcox@microsoft.com, Ross Zwisler <ross.zwisler@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>, kirill.shutemov@linux.intel.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fs: dax: Adding new return type vm_fault_t
Message-ID: <20180423172840.GA13383@bombadil.infradead.org>
References: <20180421210529.GA27238@jordon-HP-15-Notebook-PC>
 <20180422230948.2mvimlf3zspry4ji@quack2.suse.cz>
 <20180423022505.GA2308@bombadil.infradead.org>
 <20180423135947.dovwxnhzknobmyog@quack2.suse.cz>
 <CAFqt6zajJkFBs-OAbLyU5srCLnrtNJVt7NMfWdawcVYOvwETMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zajJkFBs-OAbLyU5srCLnrtNJVt7NMfWdawcVYOvwETMg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 09:42:30PM +0530, Souptick Joarder wrote:
> > OK, fair enough and thanks for doing an audit! So possibly just add a
> > comment above vmf_insert_mixed() and vmf_insert_mixed_mkwrite() like:
> >
> > /*
> >  * If the insertion of PTE failed because someone else already added a
> >  * different entry in the mean time, we treat that as success as we assume
> >  * the same entry was actually inserted.
> >  */
> >
> > After that feel free to add:
> >
> > Reviewed-by: Jan Kara <jack@suse.cz>
> >
> > to the patch.
> >
> 
> Thanks , will add this in change log and send v4.

Jan asked you to add this comment above vmf_insert_mixed_mkwrite()
(I don't think it needs to be added above vmf_insert_mixed() because
this comment will get moved in a later commit once we have no more callers
of vm_insert_mixed()).
