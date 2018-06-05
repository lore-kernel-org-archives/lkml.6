Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751818AbeFELrk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:47:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56040 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbeFELrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:47:35 -0400
Date: Tue, 5 Jun 2018 04:47:34 -0700
From: Matthew Wilcox <willy@infradead.org>
To: John Johansen <john.johansen@canonical.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use an IDR to allocate apparmor secids
Message-ID: <20180605114734.GA20472@bombadil.infradead.org>
References: <20180522093259.GA30182@bombadil.infradead.org>
 <20180528170108.GA5448@bombadil.infradead.org>
 <862d03b6-ba2f-3ec0-d45e-d8fcf16f9edf@canonical.com>
 <20180605022712.GB32444@bombadil.infradead.org>
 <4e075d0a-2e4d-f298-070c-836324864b97@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e075d0a-2e4d-f298-070c-836324864b97@canonical.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 07:35:24PM -0700, John Johansen wrote:
> On 06/04/2018 07:27 PM, Matthew Wilcox wrote:
> > On Mon, Jun 04, 2018 at 06:27:09PM -0700, John Johansen wrote:
> >> hey Mathew,
> >>
> >> I've pulled this into apparmor-next and done the retuning of
> >> AA_SECID_INVALID a follow on patch. The reworking of the api to
> >> return the specific error type can wait for another cycle.
> > 
> > Oh ... here's what I currently have.  I decided that AA_SECID_INVALID
> > wasn't needed.
> > 
> well not needed in the allocation path, but definitely needed and it
> needs to be 0.
> 
> This is for catching some uninitialized or freed and zeroed values.
> The debug checks aren't in the current version, as they were
> residing in another debug patch, but I will pull them out into their
> own patch.

With the IDR, I don't know if you need it for debug.

	BUG_ON(label != idr_find(&aa_secids, label->secid))

should do the trick.
