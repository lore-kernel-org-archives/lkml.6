Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D834C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80B021529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="atnc0Nzr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80B021529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387573AbeITSTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:19:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727633AbeITSTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:19:11 -0400
Received: from [192.168.1.75] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1BF421529;
        Thu, 20 Sep 2018 12:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537446954;
        bh=LBduy/MitbhYvvPT9XFTDK0L3FQ6kLzKm5fBXNm0J0A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=atnc0Nzrpji03499bodxTwdFEidawq8c5o7hKVUvn33cJZCC/uep3Nx5992kxNbB+
         GFT+yjLq2TXeUDWfgr6DAdzayYsaCd6jgtSp1dgywrSl8SASYOwv5Y5prY/Apne2Nx
         WfqajKRehjVk0bFb3zQLgTBCBgIe2llIY8NkqPNQ=
Subject: Re: [PATCH] gpiolib: Show correct direction from the beginning
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180914070839.4667-1-ricardo.ribalda@gmail.com>
 <20180914070839.4667-2-ricardo.ribalda@gmail.com>
 <CACRpkdbqmK=MzGsOYLdtFO3AAbKHhzy_RD=Gr6wj3WnQunyCGg@mail.gmail.com>
 <CAPybu_0iDqSn02iGLEg8Ge9EdyCCNhRVV3JgHg180qrXK+bcdw@mail.gmail.com>
 <d84ee082-f578-3ed3-32be-dbeb9562980e@kernel.org>
 <CACRpkdYGpEVG9gqPxNaOsD55k9idEfGaxOUrObbN9VZS06x5jw@mail.gmail.com>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <bcb79947-dfe0-e5e2-fb48-3b6992720f01@kernel.org>
Date:   Thu, 20 Sep 2018 07:35:52 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdYGpEVG9gqPxNaOsD55k9idEfGaxOUrObbN9VZS06x5jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/18 12:23 AM, Linus Walleij wrote:
> I think most gpiochips easily survives calling the .get_direction()
> early, Qualcomm's stand out here.
> 
> Now that we have .valid_mask in the gpiochip could we simply just
> add this back, resepecting valid_mask and avoid checking the
> direction of precisely these GPIOs?

Can you be more specific?  One of the proposals made previously was to 
add a check in msm_gpio_get_direction(), but that was rejected because 
the consensus was the valid_mask checks in gpiolib are sufficient.

