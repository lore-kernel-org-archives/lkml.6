Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F69C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E22214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpsdtS2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E22214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731255AbeISR2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 13:28:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbeISR2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 13:28:02 -0400
Received: from [192.168.1.75] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAF48214C2;
        Wed, 19 Sep 2018 11:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537357828;
        bh=5aLGS9vLV+k4W72Bii/cEdQKrTJjLFqlZJufTTTHVvc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OpsdtS2yPgJ63zc0nbRiXoH97E7axMcu7ApO0S36kBzgKEa0rqR7HC4cCHr4uu25Q
         Fl9bbcZ+cVy4apUD17GH5doUOgZYZw4RWTF0Lh2umg7gP1Fz9NOvY4GFYyXwt7BKUM
         DUcwBFR0BhdNsqxqr2tnG5ULuH3QhzArdeWDNkNk=
Subject: Re: [PATCH] gpiolib: Show correct direction from the beginning
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Timur Tabi <timur@codeaurora.org>, swboyd@chromium.org,
        linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20180914070839.4667-1-ricardo.ribalda@gmail.com>
 <20180914070839.4667-2-ricardo.ribalda@gmail.com>
 <CACRpkdbqmK=MzGsOYLdtFO3AAbKHhzy_RD=Gr6wj3WnQunyCGg@mail.gmail.com>
 <CAPybu_0iDqSn02iGLEg8Ge9EdyCCNhRVV3JgHg180qrXK+bcdw@mail.gmail.com>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <d84ee082-f578-3ed3-32be-dbeb9562980e@kernel.org>
Date:   Wed, 19 Sep 2018 06:50:25 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPybu_0iDqSn02iGLEg8Ge9EdyCCNhRVV3JgHg180qrXK+bcdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/18 11:04 PM, Ricardo Ribalda Delgado wrote:
> And should't that be tacked in qcom hardware with something like:
> 
> if (!priv->initialized)
>     return INPUT;
> 
> if you or Timur point me to the harware that was crashing I would not
> mind looking into that, but the current situations seems to me like a
> hack.

I'd say the previous code was the hack.  My comment about not touching 
the hardware until it is properly claimed is valid, and it applies to 
all platforms.
