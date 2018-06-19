Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5DAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C522083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xUX5cqVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C522083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755553AbeFSEGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 00:06:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750732AbeFSEGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 00:06:39 -0400
Received: from localhost (unknown [106.200.222.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30E7820693;
        Tue, 19 Jun 2018 04:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529381198;
        bh=A7Cny9HzS5Z48ZxbgUFP8g+6OQmpN+1foCbQ1l+fPqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xUX5cqVZphpeA3RZnGsV7D8oQtKr0M9BjKDIET26WTC8/e1jgitNcbhLl1r40fsmy
         mBJLHv3pi9i/I6X/qs7x+9saNSf1SdWQQUgDNzumbtlRb0sFxLFAsyCr4sisS/kiEG
         A6bFkGIuc3y2/dUX6gANF/9pUo4bSYMbneC9s8Wo=
Date:   Tue, 19 Jun 2018 09:36:30 +0530
From:   Vinod <vkoul@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] hwrng: msm - Add support for prng v2
Message-ID: <20180619040630.GK25852@vkoul-mobl>
References: <20180618141259.23141-1-vkoul@kernel.org>
 <20180618141259.23141-4-vkoul@kernel.org>
 <20180618182123.GT14924@minitux>
 <152935345439.16708.16472364970375601294@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152935345439.16708.16472364970375601294@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-06-18, 13:24, Stephen Boyd wrote:
> Quoting Bjorn Andersson (2018-06-18 11:21:23)
> > On Mon 18 Jun 07:12 PDT 2018, Vinod Koul wrote:
> > 
> > > Qcom 8996 and later chips support prng v2 where we need to only
> > > implement .read callback for hwrng.
> > > 
> > 
> > The hardware still needs initialization, so I think you should expand
> > this to mention that the initialization is moved to secure world and
> > that's the reason why we only implement read.
> > 
> > The question is what happens in projects with other security models.
> 
> Can we still read the PRNG_CONFIG register to see if it's already been
> configured or not and then bail out if it isn't configured? That would
> be better as long as we the system doesn't blow up if non-secure mode
> tries to read the config register.

Unfortunately it did blow up for me when I tried it..

-- 
~Vinod
