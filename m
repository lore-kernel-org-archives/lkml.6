Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeC2RGf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 13:06:35 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:50108 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeC2RGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 13:06:34 -0400
Date: Fri, 30 Mar 2018 01:06:26 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel <cluster-devel@redhat.com>, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, NeilBrown <neilb@suse.com>,
        Thomas Graf <tgraf@suug.ch>, Tom Herbert <tom@quantonium.net>
Subject: Re: [PATCH v2 0/2] gfs2: Stop using rhashtable_walk_peek
Message-ID: <20180329170626.GA24218@gondor.apana.org.au>
References: <20180329120612.6104-1-agruenba@redhat.com>
 <20180329123544.GA22551@gondor.apana.org.au>
 <CAHc6FU4i5LDoqXXTgAKtTA8EtGyawxXtY4iavo7NjHCsbX1G8w@mail.gmail.com>
 <20180329154153.GA23562@gondor.apana.org.au>
 <CAHc6FU708-F-C_ihwBW-zKC7rZvfeuKYq7kTccZQU156UicjQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU708-F-C_ihwBW-zKC7rZvfeuKYq7kTccZQU156UicjQA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 06:52:34PM +0200, Andreas Gruenbacher wrote:
>
> Should rhashtable_walk_peek be kept around even if there are no more
> users? I have my doubts.

Absolutely.  All netlink dumps using rhashtable_walk_next are buggy
and need to switch over to rhashtable_walk_peek.  As otherwise
the object that triggers the out-of-space condition will be skipped
upon resumption.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
