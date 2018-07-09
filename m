Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8BEC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A4820896
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGt5gPGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A4820896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933060AbeGILcy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:32:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932583AbeGILcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:32:51 -0400
Received: from localhost (unknown [106.201.46.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F2542086B;
        Mon,  9 Jul 2018 11:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531135970;
        bh=bASHcWTUkN3GzNwwZtafqMaKe7q58AKZ4bZOszRgzCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FGt5gPGPVSJ2SXjbn9rfff3tD75Wz+fUgj+IM3JSGJvJ8I114xGi4mx5UrgY99+oM
         JPl/kblaebIx6e0TNRXhr0Ke66WqRJhYKJf43Jxd2Jwx6e3rbSrQ32MxmiO/KOJAtl
         3LcW3QyA3GtzQzvOFLcfiYGOCZ0tuxqC6j5JPoVk=
Date:   Mon, 9 Jul 2018 17:02:42 +0530
From:   Vinod <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: nbpfaxi: Mark expected switch fall-through
Message-ID: <20180709113242.GD22377@vkoul-mobl>
References: <20180702180605.GA8523@embeddedor.com>
 <20180706055628.GP22377@vkoul-mobl>
 <29d2c48b-6a5c-f1d5-aa43-09988b162388@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29d2c48b-6a5c-f1d5-aa43-09988b162388@embeddedor.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-07-18, 06:47, Gustavo A. R. Silva wrote:
> Hi Vinod,
> 
> On 07/06/2018 12:56 AM, Vinod wrote:
> > On 02-07-18, 13:06, Gustavo A. R. Silva wrote:
> >> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> >> where we are expecting to fall through.
> >>
> >> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >> ---
> >>  drivers/dma/nbpfaxi.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
> >> index 2f9974d..8c7b2e8 100644
> >> --- a/drivers/dma/nbpfaxi.c
> >> +++ b/drivers/dma/nbpfaxi.c
> >> @@ -479,6 +479,7 @@ static size_t nbpf_xfer_size(struct nbpf_device *nbpf,
> >>  
> >>  	default:
> >>  		pr_warn("%s(): invalid bus width %u\n", __func__, width);
> >> +		/* fall through */
> > 
> > Hmm this looks okay but am not able to trigger this warning..(used W=1) Did you
> > see this warning on your build, if so what options?
> 
> Add this to your Makefile:
> 
> KBUILD_CFLAGS  += $(call cc-option,-Wimplicit-fallthrough=2)

Thanks, that did it..

Applied now thanks

-- 
~Vinod
