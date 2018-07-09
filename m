Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38353C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAEBC2089B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JbdWr5Vw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g18WC7wt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAEBC2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932949AbeGIOw0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:52:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56504 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932670AbeGIOwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:52:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B60F060B18; Mon,  9 Jul 2018 14:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531147943;
        bh=4tVYkRMohhnpr4xzQUsLbyljTgiKiMr98g6JlcZu7Q4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JbdWr5Vwe4koKF2iIaWeLLEHruDRUl+m3VWhMlmsiYtCsNxLII04UzP+KoEjjgfPz
         dJIgXLoNirkhTxRhuTVvifRkLJpTIfey2mtJC6cWl/n6W9tx3d/BX/xydUWc6wcBPu
         G8EOzjNnRwgs2nq7L3ViMvlFrm+UWx9vKuYvudU0=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1917D600C1;
        Mon,  9 Jul 2018 14:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531147942;
        bh=4tVYkRMohhnpr4xzQUsLbyljTgiKiMr98g6JlcZu7Q4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=g18WC7wtS0oGvQahTwj1Lr/ycyUA6oE7Qc2RgHxEbtdvP2LYuS4M5jhbwcdpUfdou
         4KazfknhkUSL+GKK6JP0H75/R9Qc+nh3Xdi8J+2YG4zzi0+iqKZJjB00CcpGXAbDWw
         YDhDP6zBxmpqju+sanRv9RknfjxwCQ/9kFCX6OHA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1917D600C1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v4 6/6] crypto: qcom: Add ACPI support
To:     Vinod <vkoul@kernel.org>, Timur Tabi <timur@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
References: <20180704114427.29953-1-vkoul@kernel.org>
 <20180704114427.29953-7-vkoul@kernel.org>
 <b06a0327-bbfe-5f7c-c0e1-43227ce089ae@kernel.org>
 <20180705060733.GH22377@vkoul-mobl>
 <38f34817-ff86-06b7-4aab-a009c353a6db@kernel.org>
 <20180709060157.GZ22377@vkoul-mobl>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <e031959c-80cb-575b-8b6a-fc3b2119733b@codeaurora.org>
Date:   Mon, 9 Jul 2018 08:52:21 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180709060157.GZ22377@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/2018 12:01 AM, Vinod wrote:
> On 07-07-18, 13:05, Timur Tabi wrote:
>> On 7/5/18 1:07 AM, Vinod wrote:
>>> Yes we can add driver data in ACPI ID as well so code can be:
>>>
>>>           if (!has_acpi_companion(&pdev->dev)) {
>>>                   rng->clk = devm_clk_get(&pdev->dev, "core");
>>>                   if (IS_ERR(rng->clk))
>>>                           return PTR_ERR(rng->clk);
>>>           }
>>>           rng->skip_init = device_get_match_data(&pdev->dev);
>>>
>>> Looks much neater.
>>
>> Yeah, I like it.
>>
>>> I will wait for feedback on other patches before updating this.
>>
>> Jeff said it works, so I guess v5 will be good to go.
> 
> Yes posting that right now. It would be great if you folks can test
> again on ACPI systems
> 
> Thanks
> 
I might need a day, but I'll get to it.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
