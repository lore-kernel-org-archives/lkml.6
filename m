Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753401AbeDTQwz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:52:55 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:34356 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752686AbeDTQv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:51:26 -0400
Date: Sat, 21 Apr 2018 00:51:19 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Colin King <colin.king@canonical.com>
Cc: Harsh Jain <harsh@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Michael Werner <werner@chelsio.com>,
        Atul Gupta <atul.gupta@chelsio.com>, Casey Leedom <leedom@chelsio.com>,
        linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] crypto: chtls: don't leak information from the
 stack to userspace
Message-ID: <20180420165119.3dn67xpcyxglhi22@gondor.apana.org.au>
References: <20180405164403.4412-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405164403.4412-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 05:44:03PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The structure crypto_info contains fields that are not initialized and
> only .version is set.  The copy_to_user call is hence leaking information
> from the stack to userspace which must be avoided. Fix this by zero'ing
> all the unused fields.
> 
> Detected by CoverityScan, CID#1467421 ("Uninitialized scalar variable")
> 
> Fixes: a08943947873 ("crypto: chtls - Register chtls with net tls")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
