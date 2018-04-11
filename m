Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753541AbeDKQDw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 12:03:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752894AbeDKQDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 12:03:50 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180411155811.2qznymjhi6zlzgbb@mwanda>
References: <20180411155811.2qznymjhi6zlzgbb@mwanda> <62e9abc2-b639-419c-afa7-e89054f7dce9@canonical.com> <20180411132613.18974-1-colin.king@canonical.com> <23535.1523453966@warthog.procyon.org.uk> <24493.1523455816@warthog.procyon.org.uk>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: dhowells@redhat.com, Colin Ian King <colin.king@canonical.com>,
        linux-afs@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] afs: fix integer overflow when shifting 1 more than 32 places
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2494.1523462628.1@warthog.procyon.org.uk>
Date: Wed, 11 Apr 2018 17:03:48 +0100
Message-ID: <2495.1523462628@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> Ideally static analyzers should know that nr_slots is 0-9, but right now
> that seems pretty tricky to figure out...

1-9, actually, but, yeah.  Maybe the addition of "assertions" that aren't
actually evaluated at runtime?

David
