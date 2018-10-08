Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3267DC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F1D2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F1D2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbeJHNCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 09:02:38 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:41028 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbeJHNCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 09:02:38 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1g9OT0-0001pU-Fc; Mon, 08 Oct 2018 13:52:30 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1g9OSw-0005cX-Fn; Mon, 08 Oct 2018 13:52:26 +0800
Date:   Mon, 8 Oct 2018 13:52:26 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S . Miller " <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] crypto: mxs-dcp - Fix tcrypt on imx6
Message-ID: <20181008055226.kpqykclsjmb72cde@gondor.apana.org.au>
References: <cover.1538505573.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1538505573.git.leonard.crestez@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 07:01:46PM +0000, Leonard Crestez wrote:
> The mxs-dcp driver currently fails to probe on imx6. Fix the whole thing
> by porting a cleaned/squashed version of fixes carried in the NXP vendor
> tree.
> 
> Tested with "modprobe tcrypt" and CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=n
> on imx6sl imx6sll imx6ull: no failures.
> 
> I'm not very familiar with crypto and did not write write these fixes so
> a skeptical review would be appreciated.
> 
> Previously:
>   https://lore.kernel.org/patchwork/patch/989652/
> 
> Dan Douglass (1):
>   crypto: mxs-dcp - Implement sha import/export
> 
> Radu Solea (2):
>   crypto: mxs-dcp - Fix SHA null hashes and output length
>   crypto: mxs-dcp - Fix AES issues
> 
>  drivers/crypto/mxs-dcp.c | 121 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 101 insertions(+), 20 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
