Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D88C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4535208DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pb0nADlk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4535208DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754541AbeGIGCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:02:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751388AbeGIGCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:02:06 -0400
Received: from localhost (unknown [106.201.46.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C3F2208DE;
        Mon,  9 Jul 2018 06:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531116125;
        bh=nd4c5b/OEjtDIckjiuLaxOf0BYgdhn8FEsW/E6e9TGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pb0nADlkUregHeLX/BYIvrLKt9aTOiM/4AIn5GyrJ1oK4RPrXB0HAkQFwJlq4shJg
         jOeidVxKkshM5Vh+eq/cXMateedAHJ6SxO29oeTWdcZ2EqSnk0PJNPnPfWBnrMfUjo
         7ub31hAEahuCUZseUNLa5YweqmJt+GBjmzdljOdQ=
Date:   Mon, 9 Jul 2018 11:31:57 +0530
From:   Vinod <vkoul@kernel.org>
To:     Timur Tabi <timur@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: [PATCH v4 6/6] crypto: qcom: Add ACPI support
Message-ID: <20180709060157.GZ22377@vkoul-mobl>
References: <20180704114427.29953-1-vkoul@kernel.org>
 <20180704114427.29953-7-vkoul@kernel.org>
 <b06a0327-bbfe-5f7c-c0e1-43227ce089ae@kernel.org>
 <20180705060733.GH22377@vkoul-mobl>
 <38f34817-ff86-06b7-4aab-a009c353a6db@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38f34817-ff86-06b7-4aab-a009c353a6db@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-07-18, 13:05, Timur Tabi wrote:
> On 7/5/18 1:07 AM, Vinod wrote:
> > Yes we can add driver data in ACPI ID as well so code can be:
> > 
> >          if (!has_acpi_companion(&pdev->dev)) {
> >                  rng->clk = devm_clk_get(&pdev->dev, "core");
> >                  if (IS_ERR(rng->clk))
> >                          return PTR_ERR(rng->clk);
> >          }
> >          rng->skip_init = device_get_match_data(&pdev->dev);
> > 
> > Looks much neater.
> 
> Yeah, I like it.
> 
> > I will wait for feedback on other patches before updating this.
> 
> Jeff said it works, so I guess v5 will be good to go.

Yes posting that right now. It would be great if you folks can test
again on ACPI systems

Thanks
-- 
~Vinod
