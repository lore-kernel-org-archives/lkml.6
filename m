Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44736C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 13:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BD220880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 13:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayeq0b+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BD220880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbeI2TuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 15:50:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbeI2TuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 15:50:22 -0400
Received: from [192.168.1.75] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC90C206B2;
        Sat, 29 Sep 2018 13:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538227315;
        bh=tv+n1u2sa4yJQvanWPNPraodOjf0ubQ52vfH0h72ofs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ayeq0b+TQm4kngOpdMUBlEKMco0VChUxSiOlUXxsbdEK9uoPNDUTsDUb/QJPTbGoD
         WGBZXPLY/4xPOC02fWpQPugSv0Io5CLCqoyn9ixfR0yZw5HrztN3GltmOW3jWrDecT
         y7G8z0mPd3P5Ir9V6BgEn8FILW/HqUWCswJ+vkQ4=
Subject: Re: [PATCH v2] gpiolib: Show correct direction from the beginning
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     jhugo@codeaurora.org, swboyd@chromium.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
References: <20180921103604.13361-1-ricardo.ribalda@gmail.com>
 <20180921103604.13361-2-ricardo.ribalda@gmail.com>
 <153803107307.119890.10052910965015646333@swboyd.mtv.corp.google.com>
 <ffe11a8c-368b-8c74-54a7-a088c3997032@kernel.org>
 <3e07cab8-0f3e-7474-8f6d-e6bb16e8f998@codeaurora.org>
 <5aea282d-6fc9-cd70-cec4-10f28aa819b9@codeaurora.org>
 <CAOZdJXUUWUWHzus+3sbEXbW_q92e+SSzTQJCqCyQp6Y6_HOo3g@mail.gmail.com>
 <CAPybu_3v6Y1Bs1+WQKFfdNmAFdBN6VJTDiCG1ApNVM2AWt4vjA@mail.gmail.com>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <9df3f61f-ac54-f5b1-6b86-db539e07c5bd@kernel.org>
Date:   Sat, 29 Sep 2018 08:21:54 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPybu_3v6Y1Bs1+WQKFfdNmAFdBN6VJTDiCG1ApNVM2AWt4vjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/18 1:23 AM, Ricardo Ribalda Delgado wrote:
> In fact  gpiochip_init_valid_mask is called some lines after in the
> same function. We could reorder the function. Would that work for you?

It might.  It might break something else, though.

> The driver breaking is upstream?

Yes.

> Is it possible to access the hardware?

Linaro and some Linux OSVs should still have systems, but I usually just 
ask Jeff to test code for me.
