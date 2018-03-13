Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751808AbeCMGuI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 02:50:08 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:54146 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751462AbeCMGuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 02:50:06 -0400
Date: Tue, 13 Mar 2018 07:50:03 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Greg Hackmann <ghackmann@google.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net] net: xfrm: use preempt-safe this_cpu_read() in
 ipcomp_alloc_tfms()
Message-ID: <20180313065003.pwir4pvhr4jwmdbs@gauss3.secunet.de>
References: <20180307224253.152470-1-ghackmann@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180307224253.152470-1-ghackmann@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 3CCA2F9B-5DD3-41EB-AAB5-5CF57A0B0EE5
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

...

> Signed-off-by: Greg Hackmann <ghackmann@google.com>

Patch applied, thanks!
