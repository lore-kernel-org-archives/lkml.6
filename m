Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9874C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8174720836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x4p1JFsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8174720836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753651AbeFTFcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:32:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750812AbeFTFcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:32:13 -0400
Received: from localhost (unknown [106.200.222.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 363BA20836;
        Wed, 20 Jun 2018 05:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529472732;
        bh=jnjOw9DrkBKP3kB4KI8IbDjACXMRw+YBOysaTKYA1jI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x4p1JFsJKhBw08o7mjuwpgaJOia2nCxwJ5amWu+oIQixwEFM4jF5Pvq/rg1H+Xkau
         vsXPDFQ1OMKwYK+9SujJ8MsBTSSr7KBpmckqyfYTSUAhRN4TguSrF6cjXQx4Cuz/va
         kPCSXLL8V/d7zQwddHE+Z77LLl09mlCJSUFMEDJQ=
Date:   Wed, 20 Jun 2018 11:02:04 +0530
From:   Vinod <vkoul@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Mackall <mpm@selenic.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] hwrng: msm - Add support for prng v2
Message-ID: <20180620053204.GG13316@vkoul-mobl>
References: <20180618141259.23141-1-vkoul@kernel.org>
 <20180618141259.23141-4-vkoul@kernel.org>
 <20180619142853.wgi5easw4zv6ttrb@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619142853.wgi5easw4zv6ttrb@gondor.apana.org.au>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-18, 22:28, Herbert Xu wrote:
> On Mon, Jun 18, 2018 at 07:42:59PM +0530, Vinod Koul wrote:
> > Qcom 8996 and later chips support prng v2 where we need to only
> > implement .read callback for hwrng.
> > 
> > Add a new table for v2 which supports this and get version required for
> > driver data.
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> 
> Is this really a pseudo-RNG? If so it needs to be moved over to
> the algif_rng interface.
> 
> hwrng is for true hardware RNGs only, because it may be directly
> fed into /dev/random.

I am trying to find how how much random output this hardware generates.

Meanwhile, can you please point out examples/Documentation for algif_rng
and if any test tools for this?

Thanks
-- 
~Vinod
