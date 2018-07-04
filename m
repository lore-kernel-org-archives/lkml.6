Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CB5C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6A922537
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrACM8z2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6A922537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753224AbeGDNpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932569AbeGDNnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:43:00 -0400
Received: from [192.168.1.125] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EE6A23CAF;
        Wed,  4 Jul 2018 13:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530711780;
        bh=UAtA9yPyi/IQz7bevMS3rMvN9DDMQVW0CLJdHh5bcak=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IrACM8z2n5MOI5EyEJ5poy/8llOoTIOqFmhU6kvcGnh5acfgNw0mkpzsfVOeM7n7Y
         GGFKt2A7x2swo4Ah/hHnANQT0lu3haRlxVI5GK2L5Gyl+UeXtXYupVuVu6AMrekL6Y
         xbiA3COjrdV+yr+staVf7DY83zr0Q45b1Db/NUnA=
Subject: Re: [PATCH v3 3/6] crypto: Add Qcom prng driver
To:     Vinod <vkoul@kernel.org>, Stephan Mueller <smueller@chronox.de>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Timur Tabi <timur@codeaurora.org>
References: <20180703060434.19293-1-vkoul@kernel.org>
 <20180703060434.19293-4-vkoul@kernel.org>
 <2990655.vKmMgW600W@tauon.chronox.de> <20180704041059.GT22377@vkoul-mobl>
 <20180704061035.GY22377@vkoul-mobl>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <181d27ff-e935-ce50-fce2-b114d2d99bc0@kernel.org>
Date:   Wed, 4 Jul 2018 08:42:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180704061035.GY22377@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/18 1:10 AM, Vinod wrote:
> Okay so I rechecked this, the hardware gives 32 bits of random data. I
> am thinking of splitting the word and updating by each byte. That way
> trailing zero can also be avoided which is the case now

The current driver only returns data in multiples of 4 bytes.  Why can't 
you keep that?
