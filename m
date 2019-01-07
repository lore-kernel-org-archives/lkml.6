Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48F0C43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0712089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546880171;
	bh=ajVMGG4Sjw+WPm4/s2aEbB4MhWrOn8u/esw9qP0BE0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WO2aDRAhQ/wbR7hRdOX+5Ksw7OPuHgleEkAQnBPIEv+FzhjxLVyPaH2WcJLNZBvmS
	 2DecI7hHbRLlbKKr1fWJrTNcDat6nTQvGeYVYqWHvhUhOi+btphvaPCgGcAT9SoEft
	 kU95pRbXUiQrudkkEIkk4sSHEUPwpbayg/ROc+YA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbfAGQ4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:56:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:56802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbfAGQ4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:56:09 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DA5C2087F;
        Mon,  7 Jan 2019 16:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546880169;
        bh=ajVMGG4Sjw+WPm4/s2aEbB4MhWrOn8u/esw9qP0BE0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H57wY+zXKgp+0BUXisekOBmDUKgrUbFuUcMxiCIt1gp2RlrBnac3wg8kTZDxsZZTK
         T46FYKpnBehce5sZ4CfwxxreQ8qi3cQIaKx+ytNvaKKr7+1P9OdIZpTgxRgs6cZEVW
         P/TAWo0rMBj4TToOIJX9CYnJnUzsMNmLFxlAMF5s=
Date:   Mon, 7 Jan 2019 08:56:07 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Kalyani Akula <kalyani.akula@xilinx.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kalyani Akula <kalyania@xilinx.com>,
        Sarat Chand Savitala <saratcha@xilinx.com>
Subject: Re: [RFC PATCH 2/3] crypto: Add Xilinx SHA3 driver
Message-ID: <20190107165606.GA2077@gmail.com>
References: <1546851776-3456-1-git-send-email-kalyani.akula@xilinx.com>
 <1546851776-3456-3-git-send-email-kalyani.akula@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546851776-3456-3-git-send-email-kalyani.akula@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalyani,

On Mon, Jan 07, 2019 at 02:32:55PM +0530, Kalyani Akula wrote:
> This patch adds SHA3 driver suuport for the Xilinx
> ZynqMP SoC.
> 
> Signed-off-by: Kalyani Akula <kalyani.akula@xilinx.com>
[...]
> +
> +static struct ahash_alg sha3_alg = {
> +	.init		= zynqmp_sha_init,
> +	.update		= zynqmp_sha_update,
> +	.final		= zynqmp_sha_final,
> +	.finup		= zynqmp_sha_finup,
> +	.digest		= zynqmp_sha_digest,
> +	.export		= zynqmp_sha_export,
> +	.import		= zynqmp_sha_import,
> +	.halg = {
> +		.digestsize	= SHA384_DIGEST_SIZE,
> +		.statesize	= sizeof(struct sha256_state),
> +		.base	= {
> +			.cra_name		= "xilinx-keccak-384",
> +			.cra_driver_name	= "zynqmp-keccak-384",
> +			.cra_priority		= 300,
> +			.cra_flags		= CRYPTO_ALG_ASYNC,
> +			.cra_blocksize		= SHA384_BLOCK_SIZE,
> +			.cra_ctxsize		= sizeof(struct zynqmp_sha_ctx),
> +			.cra_alignmask		= 0,
> +			.cra_module		= THIS_MODULE,
> +			.cra_init		= zynqmp_sha_cra_init,
> +		}
> +	}
> +};

cra_name needs to match an algorithm that has a generic implementation.
It should be "sha3-384", or is your hardware not compatible?
Also does your hardware not support sha3-256 and sha3-512?

- Eric
