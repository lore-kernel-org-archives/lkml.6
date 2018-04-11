Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753240AbeDKOKU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:10:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751961AbeDKOKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:10:18 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <62e9abc2-b639-419c-afa7-e89054f7dce9@canonical.com>
References: <62e9abc2-b639-419c-afa7-e89054f7dce9@canonical.com> <20180411132613.18974-1-colin.king@canonical.com> <23535.1523453966@warthog.procyon.org.uk>
To: Colin Ian King <colin.king@canonical.com>
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] afs: fix integer overflow when shifting 1 more than 32 places
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24492.1523455816.1@warthog.procyon.org.uk>
Date: Wed, 11 Apr 2018 15:10:16 +0100
Message-ID: <24493.1523455816@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Ian King <colin.king@canonical.com> wrote:

> >> -	mask = (1 << nr_slots) - 1;
> >> +	mask = (1ULL << nr_slots) - 1;
> > 
> > nr_slots cannot be larger than 9, so what I wrote is actually fine and is
> > more efficient on a 32-bit machine.
> 
> ok, sorry about the noise.

It would be possible to cast the value to u64 before assigning it, I suppose.
Would that help?  E.g.:

	mask = (u64)((1 << nr_slots) - 1);

It looks a bit odd, though, since the cast is made implicitly anyway.

David
