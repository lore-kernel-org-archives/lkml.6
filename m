Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752311AbeCTIu2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 04:50:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36936 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbeCTIuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 04:50:23 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180320085020euoutp02ab316b843cdd4dd3075e04e4d55545f7~dlMR334191109511095euoutp02M
X-AuditID: cbfec7f5-f95739c0000028a9-6c-5ab0cb4bdf28
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
Subject: Re: [PATCH v2] crypto: doc - clarify hash callbacks state machine
To: =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From: Kamil Konieczny <k.konieczny@partner.samsung.com>
Message-id: <d036a7ef-d900-4858-b821-05c50b2b739e@partner.samsung.com>
Date: Tue, 20 Mar 2018 09:50:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
In-reply-to: <20180320075612.22719-1-horia.geanta@nxp.com>
Content-language: en-US
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWy7djP87repzdEGTy/q2mxccZ6VosnB9oZ
        Leacb2Gx6H4lY/Hh/GEmi/v3fjJZLGxbwmJxedccNgcOjy0rbzJ5bDug6rG4bzKrx8Z3O5g8
        +rasYvT4vEkugC2KyyYlNSezLLVI3y6BK+PDxJ/sBct5KqZdZG9gvMLZxcjJISFgInFn92m2
        LkYuDiGBFYwSPct3M0M4nxklPp5rZYapOjtpNztEYhmjxO8zj9lBErwCghI/Jt9jAbGZBTQl
        XnyZxAJR9IxR4sqlX0BzOTiEBbwkWvrtQWpEBDYySnzvFgSpYRaYzCjxuG0/2CA2AXOJR9vP
        MEEMdZPY9r2LDcRmEVCV+LzqKNgCUYEIiYVTnzKC2JwCVhI7Z0xhhlgsLtHcehPqCHmJg1ee
        s0BcfZtN4t9UFwjbReLW2m5WCFtY4tXxLewQtozE5cndUPXlEpu2rAX7UkKggVFizfsmRoiE
        tcTh4xdZIRbwSUzaNp0Z5DEJAV6JjjYhiBIPidY3h5ggbEeJHRsugZULCexhlNh6xGMCo9ws
        pPCahRRes5C8MAvJCwsYWVYxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIEJpnT/45/3cG4
        70/SIUYBDkYlHl6NO+ujhFgTy4orcw8xSnAwK4nwqkdviBLiTUmsrEotyo8vKs1JLT7EKM3B
        oiTOG6dRFyUkkJ5YkpqdmlqQWgSTZeLglGpgtF1k6HW1yudvTszGn0uW9SeXGN5hefl6/6yG
        yCVTql7/Dvqr9PpxLMeEjVUMcwQy5rdfdJzJ9GfjbC/+E6XcK9esbsz4Zr97naf4ggppz6cb
        cnmusmmc4pXQfXRgHmfsfh7PSOO5a6q1Z9sn3N8YwFzryLXxk79dzYWnBxNW+Up1XT/l4bTH
        QomlOCPRUIu5qDgRAMwB6GwuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsVy+t/xy7repzdEGRy6z2KxccZ6VosnB9oZ
        Leacb2Gx6H4lY/Hh/GEmi/v3fjJZLGxbwmJxedccNgcOjy0rbzJ5bDug6rG4bzKrx8Z3O5g8
        +rasYvT4vEkugC2KyyYlNSezLLVI3y6BK+PDxJ/sBct5KqZdZG9gvMLZxcjJISFgInF20m72
        LkYuDiGBJYwS7zZ9ZARJ8AoISvyYfI+li5GDg1lAXWLKlFyImmeMEucO/WACiQsLeEm09NuD
        xEUENjJK/G67BjaIWWAio8TDP2+gpu5hlGie8J4VZCqbgLnEo+1nmCA2uEls+97FBmKzCKhK
        fF51lAXEFhWIkOhcOR/M5hSwktg5YwoziM0sIC7R3HqTBcKWlzh45TnLBEaBWUiOnYVw7Cwk
        HbOQdCxgZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kRGAvbjv3csoOx613wIUYBDkYlHl6N
        O+ujhFgTy4orcw8xSnAwK4nwqkdviBLiTUmsrEotyo8vKs1JLT7EKM3BoiTOe96gMkpIID2x
        JDU7NbUgtQgmy8TBKdXA2BUmxxysLvJqv9VsWffi64f919ibKX5RK37THXd22ofi8osxChvF
        Fb76luedKllwYNKnWq+3t+88yDhqFvOdLTytZ9l81wfis71m3Lih5xnG0xlxrFaj7OOeyYz3
        3X4lPbhw++q9teKSmqKZnut0VgWVfRc6FSq/b4F4gWH/qWvF+e63Jt7JVGIpzkg01GIuKk4E
        AI6+bRmBAgAA
X-CMS-MailID: 20180320085019eucas1p1f1d0f113a7659add81f22d9bf126b044
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180320075741epcas5p3a7c026ba8644e54478955afcb6091023
X-RootMTR: 20180320075741epcas5p3a7c026ba8644e54478955afcb6091023
References: <20180305103945.3517-1-horia.geanta@nxp.com>
        <CGME20180320075741epcas5p3a7c026ba8644e54478955afcb6091023@epcas5p3.samsung.com>
        <20180320075612.22719-1-horia.geanta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.03.2018 08:56, Horia Geantă wrote:
> Add a note that it is perfectly legal to "abandon" a request object:
> - call .init() and then (as many times) .update()
> - _not_ call any of .final(), .finup() or .export() at any point in
>   future
> 
> Link: https://lkml.kernel.org/r/20180222114741.GA27631@gondor.apana.org.au
> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
> ---
>  Documentation/crypto/devel-algos.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/crypto/devel-algos.rst b/Documentation/crypto/devel-algos.rst
> index 66f50d32dcec..c45c6f400dbd 100644
> --- a/Documentation/crypto/devel-algos.rst
> +++ b/Documentation/crypto/devel-algos.rst
> @@ -236,6 +236,14 @@ when used from another part of the kernel.
>                                 |
>                                 '---------------> HASH2
>  
> +Note that it is perfectly legal to "abandon" a request object:
> +- call .init() and then (as many times) .update()
> +- _not_ call any of .final(), .finup() or .export() at any point in future
> +
> +In other words implementations should mind the resource allocation and clean-up.
> +No resources related to request objects should remain allocated after a call
-- ^^^^^^^^^^^^
> +to .init() or .update(), since there might be no chance to free them.

is it for crypto api  users or for drivers ?

the creator of request context is responsible for alloc and destroy,
so why there are no chance of free ?

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland
