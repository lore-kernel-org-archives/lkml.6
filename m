Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425161AbeBOPv3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:51:29 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:39590 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424582AbeBOPvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:51:23 -0500
Date: Thu, 15 Feb 2018 23:51:00 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: alexandre.torgue@st.com, arei.gonglei@huawei.com, corbet@lwn.net,
        davem@davemloft.net, jasowang@redhat.com, mcoquelin.stm32@gmail.com,
        mst@redhat.com, fabien.dessenne@st.com,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 0/6] crypto: engine - Permit to enqueue all async
 requests
Message-ID: <20180215155100.GJ7352@gondor.apana.org.au>
References: <20180126191534.17569-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180126191534.17569-1-clabbe.montjoie@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2018 at 08:15:28PM +0100, Corentin Labbe wrote:
> Hello
> 
> The current crypto_engine support only ahash and ablkcipher request.
> My first patch which try to add skcipher was Nacked, it will add too many functions
> and adding other algs(aead, asymetric_key) will make the situation worst.
> 
> This patchset remove all algs specific stuff and now only process generic crypto_async_request.
> 
> The requests handler function pointer are now moved out of struct engine and
> are now stored directly in a crypto_engine_reqctx.
> 
> The original proposal of Herbert [1] cannot be done completly since the crypto_engine
> could only dequeue crypto_async_request and it is impossible to access any request_ctx
> without knowing the underlying request type.
> 
> So I do something near that was requested: adding crypto_engine_reqctx in TFM context.
> Note that the current implementation expect that crypto_engine_reqctx
> is the first member of the context.
> 
> The first patch is a try to document the crypto engine API.
> The second patch convert the crypto engine with the new way,
> while the following patchs convert the 4 existing users of crypto_engine.
> Note that this split break bisection, so probably the final commit will be all merged.
> 
> Appart from virtio, all 4 latest patch were compile tested only.
> But the crypto engine is tested with my new sun8i-ce driver.
> 
> Regards
> 
> [1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1474434.html
> 
> Changes since V1:
> - renamed crypto_engine_reqctx to crypto_engine_ctx
> - indentation fix in function parameter
> - do not export crypto_transfer_request
> - Add aead support
> - crypto_finalize_request is now static
> 
> Changes since RFC:
> - Added a documentation patch
> - Added patch for stm32-cryp
> - Changed parameter of all crypto_engine_op functions from
> 	crypto_async_request to void*
> - Reintroduced crypto_transfer_xxx_request_to_engine functions
> 
> Corentin Labbe (6):
>   Documentation: crypto: document crypto engine API
>   crypto: engine - Permit to enqueue all async requests
>   crypto: omap: convert to new crypto engine API
>   crypto: virtio: convert to new crypto engine API
>   crypto: stm32-hash: convert to the new crypto engine API
>   crypto: stm32-cryp: convert to the new crypto engine API

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
