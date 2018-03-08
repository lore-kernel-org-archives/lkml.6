Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935397AbeCHIX1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 03:23:27 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:48588 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755009AbeCHIXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 03:23:25 -0500
Date: Thu, 8 Mar 2018 16:23:12 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Greg Hackmann <ghackmann@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] net: xfrm: use preempt-safe this_cpu_read() in
 ipcomp_alloc_tfms()
Message-ID: <20180308082312.GA8403@gondor.apana.org.au>
References: <20180307224253.152470-1-ghackmann@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307224253.152470-1-ghackmann@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 02:42:53PM -0800, Greg Hackmann wrote:
> f7c83bcbfaf5 ("net: xfrm: use __this_cpu_read per-cpu helper") added a
> __this_cpu_read() call inside ipcomp_alloc_tfms().
> 
> At the time, __this_cpu_read() required the caller to either not care
> about races or to handle preemption/interrupt issues.  3.15 tightened
> the rules around some per-cpu operations, and now __this_cpu_read()
> should never be used in a preemptible context.  On 3.15 and later, we
> need to use this_cpu_read() instead.
> 
> syzkaller reported this leading to the following kernel BUG while
> fuzzing sendmsg:

Please explain why we can't revert f7c83bcbfaf5 instead.

Your patch contradicts the comment above the line that you're
changing.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
