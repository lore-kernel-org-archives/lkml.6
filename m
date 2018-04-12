Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753299AbeDLV2G (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 17:28:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46424 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753206AbeDLV2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 17:28:04 -0400
Date: Thu, 12 Apr 2018 14:28:03 -0700
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
Message-Id: <20180412142803.cd235a40155503700dc73b21@linux-foundation.org>
In-Reply-To: <20180412150605.GA31409@nokia.com>
References: <20180412150605.GA31409@nokia.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2018 17:06:05 +0200 Ioan Nicu <ioan.nicu.ext@nokia.com> wrote:

> Some of the mport_dma_req structure members were initialized late
> inside the do_dma_request() function, just before submitting the
> request to the dma engine. But we have some error branches before
> that. In case of such an error, the code would return on the error
> path and trigger the calling of dma_req_free() with a req structure
> which is not completely initialized. This causes a NULL pointer
> dereference in dma_req_free().
> 
> This patch fixes these error branches by making sure that all
> necessary mport_dma_req structure members are initialized in
> rio_dma_transfer() immediately after the request structure gets
> allocated.

This sounds like something which someone has actually triggered in a
real-world situation.  So I added a cc:stable.  Please let me know if
that was inappropriate.

And please remember to always include all information regarding
end-user impact when fixing bugs.
