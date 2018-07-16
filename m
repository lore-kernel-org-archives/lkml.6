Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCDDECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 05:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73A420864
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 05:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="higlOHST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73A420864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeGPFy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 01:54:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbeGPFy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 01:54:59 -0400
Received: from localhost (unknown [122.178.242.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BFF12084C;
        Mon, 16 Jul 2018 05:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531718962;
        bh=ejyMqabIhr4HHQnhMvPD+GQJSFx7UwGudG06Z6gLoqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=higlOHSTB90MetfzGcF6vhM9x/qet08m3wUODGAAgrf7BQTLM9QSI1HcJ+iEUHEwt
         e/evjUvSIpOpfafmEe3HJjPnnx3y6bWtO899H/puO1jDUlgEFNDea8HtBc7sgTfrxs
         W2RU3kZN74drgjIGx921LQ5j16bBKZ68xRpRvD5o=
Date:   Mon, 16 Jul 2018 10:59:11 +0530
From:   Vinod <vkoul@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-crypto@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Timur Tabi <timur@codeaurora.org>, jhugo@codeaurora.org
Subject: Re: [PATCH v5 3/6] crypto: Add Qcom prng driver
Message-ID: <20180716052911.GB3219@vkoul-mobl>
References: <20180709061925.20276-1-vkoul@kernel.org>
 <20180709061925.20276-4-vkoul@kernel.org>
 <CACRpkdYk11wNMFFFqbVXgRtPCrvq25MOHDrG_dikCr31oUWyqA@mail.gmail.com>
 <20180716041538.GZ3219@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716041538.GZ3219@vkoul-mobl>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-07-18, 09:45, Vinod wrote:
> On 14-07-18, 12:16, Linus Walleij wrote:
> > On Mon, Jul 9, 2018 at 8:20 AM Vinod Koul <vkoul@kernel.org> wrote:
> 
> > > +#include <linux/of_device.h>
> > 
> > Do you need this? It seems like a platform device fair and square.
> 
> It was required for of_device_get_match_data() but then the change is in
> subsequent patch, I should move that

And I need of.h here for of_match_ptr. Added that and removed
of_device.h.

-- 
~Vinod
