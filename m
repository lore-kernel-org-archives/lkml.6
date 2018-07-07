Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AA7C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 18:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3ADD20C0F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 18:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5Flox8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3ADD20C0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932834AbeGGSFl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 14:05:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932182AbeGGSFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 14:05:39 -0400
Received: from [192.168.1.125] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21B822098B;
        Sat,  7 Jul 2018 18:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530986739;
        bh=Zli7TVRvX9531KMg6QVfbng9Wi1DUi9f7do5QSjZa8o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=b5Flox8jedcOYqBhlEpwfpbxFjIpLMN1ZhJTkvZB0eVA04ATxfC1KDi4nwVGFKLxc
         kgTP04VsoGKLyvE3hkJJ/5Yo3rNHF2EuYYsDLPAnV4aJHCS7KYoQToh8ghmTrVas8v
         n2IjtK/IchzRAHvrCo/H665HooYUYP/lq3uw9KBU=
Subject: Re: [PATCH v4 6/6] crypto: qcom: Add ACPI support
To:     Vinod <vkoul@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
References: <20180704114427.29953-1-vkoul@kernel.org>
 <20180704114427.29953-7-vkoul@kernel.org>
 <b06a0327-bbfe-5f7c-c0e1-43227ce089ae@kernel.org>
 <20180705060733.GH22377@vkoul-mobl>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <38f34817-ff86-06b7-4aab-a009c353a6db@kernel.org>
Date:   Sat, 7 Jul 2018 13:05:36 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180705060733.GH22377@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/18 1:07 AM, Vinod wrote:
> Yes we can add driver data in ACPI ID as well so code can be:
> 
>          if (!has_acpi_companion(&pdev->dev)) {
>                  rng->clk = devm_clk_get(&pdev->dev, "core");
>                  if (IS_ERR(rng->clk))
>                          return PTR_ERR(rng->clk);
>          }
>          rng->skip_init = device_get_match_data(&pdev->dev);
> 
> Looks much neater.

Yeah, I like it.

> I will wait for feedback on other patches before updating this.

Jeff said it works, so I guess v5 will be good to go.
