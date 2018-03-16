Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752537AbeCPPQ5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 11:16:57 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:59294 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbeCPPQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 11:16:55 -0400
Date: Fri, 16 Mar 2018 23:16:42 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-crypto@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: doc - clarify hash callbacks state machine
Message-ID: <20180316151642.GA6606@gondor.apana.org.au>
References: <20180305103945.3517-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180305103945.3517-1-horia.geanta@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 12:39:45PM +0200, Horia Geantă wrote:
> Even though it doesn't make too much sense, it is perfectly legal to:
> - call .init() and then (as many times) .update()
> - subseqently _not_ call any of .final(), .finup() or .export()

Actually it makes perfect sense, because there can be an arbitrary
number of requests for a given tfm.  There is no requirement that
you must finalise the first request before submitting new ones.

IOW there can be an arbitrary number of outstanding requests even
without the user intentionally abandoning any hash request.

So please modify your commit description.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
