Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751771AbeDMVQi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 17:16:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54682 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750867AbeDMVQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 17:16:37 -0400
Date: Fri, 13 Apr 2018 14:16:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ioan Nicu <ioan.nicu.ext@nokia.com>
Cc: Alexandre Bounine <alex.bou9@gmail.com>,
        Barry Wood <barry.wood@idt.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Logan Gunthorpe <logang@deltatee.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Frank Kunz <frank.kunz@nokia.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rapidio: fix rio_dma_transfer error handling
Message-Id: <20180413141634.4935b2da32aa4705b9181ffd@linux-foundation.org>
In-Reply-To: <20180413070917.GA2794@nokia.com>
References: <20180412150605.GA31409@nokia.com>
        <20180412142803.cd235a40155503700dc73b21@linux-foundation.org>
        <d77db0b1-2cca-c0f6-987d-32ffb45cb16f@gmail.com>
        <20180413070917.GA2794@nokia.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Apr 2018 09:09:18 +0200 Ioan Nicu <ioan.nicu.ext@nokia.com> wrote:

> > > And please remember to always include all information regarding
> > > end-user impact when fixing bugs.
> > > 
> > This bug fix is applicable to versions starting from v4.6
> 
> Actually, this is something I broke with my previous patch where I added a
> kref to the mport_dma_req structure. Before this patch, all the error paths
> were doing kfree(req) instead of kref_put(&req->refcount, dma_req_free).
> 
> Now that dma_req_free() is called, it dereferences req->dmach, which is
> initialized late in do_dma_request(), so dma_req_free() could be called
> with a NULL req->dmach in some cases.
> 
> Sorry if I did not make this clear enough in the description.

I added

Fixes: bbd876adb8c72 ("rapidio: use a reference count for struct mport_dma_req")

(correct?) and removed cc:stable.
