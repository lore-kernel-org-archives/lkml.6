Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398D0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF58A2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF58A2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405617AbeKWBXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:23:15 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:42728 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbeKWBXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:23:15 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gPqCT-0001Bm-HX; Thu, 22 Nov 2018 22:43:25 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gPqCP-0002vI-8H; Thu, 22 Nov 2018 22:43:21 +0800
Date:   Thu, 22 Nov 2018 22:43:21 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Mathias Krause <minipli@googlemail.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Pan Bian <bianpan2016@163.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pan Bian <bianpan2013@163.com>
Subject: Re: [net] xfrm_user: use xfrm_state_put to free xfrm_state_alloc
 return value
Message-ID: <20181122144321.5gmyynui254qfeoq@gondor.apana.org.au>
References: <1542783468-67482-1-git-send-email-bianpan2016@163.com>
 <20181121080045.4vtozqc6eyeyis2n@gondor.apana.org.au>
 <20181121200923.GA12460@jig.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121200923.GA12460@jig.fritz.box>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 09:09:23PM +0100, Mathias Krause wrote:
> 
> -- >8 --
> 
> Subject: [PATCH] xfrm_user: fix freeing of xfrm states on acquire
> 
> Commit 565f0fa902b6 ("xfrm: use a dedicated slab cache for struct
> xfrm_state") moved xfrm state objects to use their own slab cache.
> However, it missed to adapt xfrm_user to use this new cache when
> freeing xfrm states.
> 
> Fix this by introducing and make use of a new helper for freeing
> xfrm_state objects.
> 
> Fixes: 565f0fa902b6 ("xfrm: use a dedicated slab cache for struct xfrm_state")
> Reported-by: Pan Bian <bianpan2016@163.com>
> Cc: <stable@vger.kernel.org> # v4.18+
> Signed-off-by: Mathias Krause <minipli@googlemail.com>

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Looks good to me.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
