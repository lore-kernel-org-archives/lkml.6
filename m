Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41487C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A7A2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A7A2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbeJHNDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 09:03:09 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:41082 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbeJHNDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 09:03:09 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1g9OTW-0001rQ-In; Mon, 08 Oct 2018 13:53:02 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1g9OTV-0005dT-WF; Mon, 08 Oct 2018 13:53:02 +0800
Date:   Mon, 8 Oct 2018 13:53:01 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: caam/qi2 - avoid double export
Message-ID: <20181008055301.mngrxpbfye5t4qn2@gondor.apana.org.au>
References: <20181002205720.2255567-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002205720.2255567-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 10:56:19PM +0200, Arnd Bergmann wrote:
> Both the caam ctrl file and dpaa2_caam export a couple of flags. They
> use an #ifdef check to make sure that each flag is only built once,
> but this fails if they are both loadable modules:
> 
> WARNING: drivers/crypto/caam/dpaa2_caam: 'caam_little_end' exported twice. Previous export was in drivers/crypto/caam/caam.ko
> WARNING: drivers/crypto/caam/dpaa2_caam: 'caam_imx' exported twice. Previous export was in drivers/crypto/caam/caam.ko
> 
> Change the #ifdef to an IS_ENABLED() check in order to make it work in
> all configurations. It may be better to redesign this aspect of the
> two drivers in a cleaner way.
> 
> Fixes: 8d818c105501 ("crypto: caam/qi2 - add DPAA2-CAAM driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/crypto/caam/caamalg_qi2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
