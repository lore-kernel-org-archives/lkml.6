Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9C5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF56206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="L6aZMDkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfANNa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:30:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33863 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfANNaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:30:25 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so7368959wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 05:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=m+dqoUTZ553nDWQVkK+5miIXYXnjGts+7dZ1viX+uA0=;
        b=L6aZMDkn0eXQpSur/59udmyHKkaaqYwVzoCYf8j2+nP6g+CvW/03enBcLIM3yUGvP6
         azqss3Nh/1NvgSnfTRVq+l/zdWPpi4pimmTjWfZ26dVPWyHviJrLsma20gQoBhaF7eBl
         bs+yyQ5vTi8wGO89Rdpw4T7wNmAmCQez12XjPP0rgy6aAmqwpHMBAXYyj1GARHOHcIO/
         4+woaaNHLLMcGeB8rVn+QT59stAKLeqPPv2KVsUHelSKJPm8AeB6IDgBgd37D1LGKROf
         zjJBUBAcAurH6t4pccnNOYz0wnFBy8TsXDKFAx6SblfKjndg3cpqXpAd3pYvXBB3ndh/
         Tfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=m+dqoUTZ553nDWQVkK+5miIXYXnjGts+7dZ1viX+uA0=;
        b=qSb7HnGW8oykQVfEB5TxWqA8d7ehUVtoJPWpcTwHOAmdr2w2fFcZDMj9XE1fteVqxH
         I921W6S9Z7bQFpynUmQ2cLEl/q3QqoPkCaST31JTkGJJgk9+/zSZH864IEXimkp4wIRQ
         QOzQphkrgUQh3Mmd7K93dDgh7WF7pIqGdAKkmJxQwy3XDhTqAq1gMVn37Y2A+/1TiMzS
         ZHNyzTuvcAYUBUMXuf9oMTe7Zh6qgzTNZFxRci6JmVZBSKuVjVJk+ams0iYvL0UCiYpG
         7RTg2n9pc2k+gKNiiI9gWlZyZzhQk+Vmr7cZZRBoEYnp61TvNQE/lFhxib4kbEpbTRtO
         tQEg==
X-Gm-Message-State: AJcUukfvXld35nklCyciI4pXXyPpsj31x5McSw2FlPhE+jtLiQRXnI7j
        JoLgenvKiu3tPQjwi/EdXvUT+g==
X-Google-Smtp-Source: ALg8bN4g7XhzTK3a7x2ZyBppxsQ2dbnyUnSPT2LvpdX3jVsV/BVKMSu4gDm2frVgSD2pvww/Boqx8g==
X-Received: by 2002:a1c:8b44:: with SMTP id n65mr12332007wmd.104.1547472623560;
        Mon, 14 Jan 2019 05:30:23 -0800 (PST)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a1sm64329218wrw.76.2019.01.14.05.30.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 05:30:22 -0800 (PST)
References: <1547134822-18498-1-git-send-email-lollivier@baylibre.com> <CAFBinCDM4BTx0Ude-M=O6B2bXPE9EdfD=VxZfFzR9Dc=yT+xWQ@mail.gmail.com> <7hy37rm0j6.fsf@baylibre.com>
User-agent: mu4e 1.0; emacs 25.3.2
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Loys Ollivier <lollivier@baylibre.com>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v3] arm64: dts: meson: Fix mmc cd-gpios polarity
In-reply-to: <7hy37rm0j6.fsf@baylibre.com>
Date:   Mon, 14 Jan 2019 14:30:20 +0100
Message-ID: <861s5fmknn.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

On Fri 11 Jan 2019 at 19:55, Kevin Hilman wrote:

> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>
>> Hi,
>>
>> some nit-picks as well as my Tested-by (in case it's not too late) below.
>> thank you for taking care of this!
>>
You're welcome !
>> On Thu, Jan 10, 2019 at 4:40 PM Loys Ollivier <lollivier@baylibre.com> 
>> wrote:
>>>
>>> Commit 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
>>> changed the behavior of "cd-inverted" to follow the device tree bindings
>>> specification.
>>> Lines specifying "cd-inverted" are now "active high".
>> this depends on the polarity from the cd-gpios property. above commit
>> caused cd-inverted to be applied twice (effectively making it a
>> no-op). thus "cd-inverted" only means "active high" if cd-gpios also
>> sets GPIO_ACTIVE_HIGH. if the polarity in cd-gpios is GPIO_ACTIVE_LOW
>> together with "cd-inverted" then the GPIO will be treated as active
>> low.
>>
Hum ok so there's more to it than the commit message. I'll come by with
something clearer for a v4. Thank you for the clarification.
>>> Fix the SD card for meson by setting the cd-gpios as "active low" 
>>> according
>>> to the boards specifications.
>> not only switching to GPIO_ACTIVE_LOW, also dropping "cd-inverted"
>>
Indeed.
>>> Fixes: 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
>> in my patches for the 32-bit boards I used the commit which added SD
>> card support to the board for the Fixes tag. however, I'm fine with
>> this as well (I just wanted to point out that there's a small
>> difference in our commits).
>>
OK, I treat fixes tags as:
from the introduction (or discovery) of a regression (or bug), the
"Fixes" commit will patch the commit that introduced the regression.
Hence why I tagged the commit from which the platform was not acting
correctly anymore. If that's fine for you it's fine for me as well :) 
>>> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
>> on my Khadas VIM(1), using Kevin's v5.0/fixes branch:
>> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> I can add this tested-by tag in my v5.0/fixes branch for now, and can
> replace it with a follow up if Loys can update the changelog with your
> suggestions/clarifications.
>
Will do.
> Thanks,
>
> Kevin


-- 
-L
