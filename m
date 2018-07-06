Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93E0C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F08223FDC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQrcStHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F08223FDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934671AbeGFF4k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:56:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933799AbeGFF4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:56:37 -0400
Received: from localhost (unknown [223.226.33.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2AAB23F9F;
        Fri,  6 Jul 2018 05:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530856596;
        bh=DzN/3bZHyXxiniDXOmgvjg+BQuDsoludQbENCN0nVn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PQrcStHQMqrs/vVhlI5wX/5quc2rt3GfHIKULNUApOYQ+QlpQmKiWdsZuwaXWlIY8
         XkYiV6ywUIeRRgdV18npVzWu/jFRxA5V4jKRCpxdaT0ALxY1+Bae8aacUs/Y6shVJj
         2liCHx2UJ/sxUVkLV8oCkThGyAC14qw48lW0FIk4=
Date:   Fri, 6 Jul 2018 11:26:28 +0530
From:   Vinod <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: nbpfaxi: Mark expected switch fall-through
Message-ID: <20180706055628.GP22377@vkoul-mobl>
References: <20180702180605.GA8523@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702180605.GA8523@embeddedor.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-07-18, 13:06, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/dma/nbpfaxi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
> index 2f9974d..8c7b2e8 100644
> --- a/drivers/dma/nbpfaxi.c
> +++ b/drivers/dma/nbpfaxi.c
> @@ -479,6 +479,7 @@ static size_t nbpf_xfer_size(struct nbpf_device *nbpf,
>  
>  	default:
>  		pr_warn("%s(): invalid bus width %u\n", __func__, width);
> +		/* fall through */

Hmm this looks okay but am not able to trigger this warning..(used W=1) Did you
see this warning on your build, if so what options?

-- 
~Vinod
