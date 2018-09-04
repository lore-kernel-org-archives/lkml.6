Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA32C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82332086B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Qa3NxSug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82332086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeIDQKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 12:10:17 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40595 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbeIDQKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 12:10:16 -0400
Received: by mail-lf1-f65.google.com with SMTP id x26-v6so2673065lfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 04:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+bOy8wTVFOzay31GNXfyRkk9gSWBhmQdFCw2D5fEM6M=;
        b=Qa3NxSughZ2b0klNz8LKXF+Vad2eIGx8UygWk0scbbCH4UMsciUQ4yAYIrxYpayKgT
         HlDWYhjaVdxU2iLXrP47y86hoiLfiinDPeEJHdi3+T2qQeSVp6oOmZG9HFjMWdR9LLi2
         D3zuQV/70JCe4aYDYggsZgTU5bZw+hJY7HMlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+bOy8wTVFOzay31GNXfyRkk9gSWBhmQdFCw2D5fEM6M=;
        b=oi43/Lw1ipGBbRxg64UKorE2yG4YSSsRIrA5RTxSRSx88cJSMtfGQarr3a6J/FuAVo
         bhm2QQDjDFcyPCstP0tZLS1O0sFYtvJI5eo6SzQRwcPmvjDTo8YnUzq4JkuPN4bGAA3F
         qlNe8CbBIlfXvWD9MVd1swzyfo+emYsy107BiyKjyxsoV9mWksiVmPp4lQxGI8VrIfox
         1gapFTiFOKKQqc6gjFaMzZ/g2/4jGmoYTTxg/zR6sUj7uDq5j6c9hR6q6WQB8DtzQqhJ
         j63SCCYD+mC85vSPcrm42oO30zcu0APdIIRfof4cS9j1WIS9BACZXReQQa5RvdasH4jG
         +4vw==
X-Gm-Message-State: APzg51Cfd/yxpqLVg2ldCmiBHJpQjzRSFusRR2Sk5reyVN3hFhtq89LM
        VpDiDOPK4pEJB1/ir+xQDk3JkrUkxvw+TSbL
X-Google-Smtp-Source: ANB0VdbaMIaHcDuA0s/pcUOdszu/TdAXTfszdLCDDoFHBkA3GwT9w1RBt1AphZfiW0fjYx5ZWgHg3A==
X-Received: by 2002:a19:6450:: with SMTP id b16-v6mr19830604lfj.32.1536061528546;
        Tue, 04 Sep 2018 04:45:28 -0700 (PDT)
Received: from [172.16.11.40] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id m8-v6sm4068096ljj.10.2018.09.04.04.45.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 04:45:28 -0700 (PDT)
Subject: Re: [PATCH 5/7] linux/bitmap.h: relax comment on compile-time
 constant nbits
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <ynorov@caviumnetworks.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20180818131623.8755-1-linux@rasmusvillemoes.dk>
 <20180818131623.8755-6-linux@rasmusvillemoes.dk>
 <20180904110859.GA4992@yury-thinkpad>
 <20180904113046.GQ11447@smile.fi.intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <df13a186-c569-916b-5d36-97a92533c0d8@rasmusvillemoes.dk>
Date:   Tue, 4 Sep 2018 13:45:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904113046.GQ11447@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-04 13:30, Andy Shevchenko wrote:
> On Tue, Sep 04, 2018 at 02:08:59PM +0300, Yury Norov wrote:
>> On Sat, Aug 18, 2018 at 03:16:21PM +0200, Rasmus Villemoes wrote:
>>> It's not clear what's so horrible about emitting a function call to
>>> handle a run-time sized bitmap. Moreover, gcc also emits a function call
>>> for a compile-time-constant-but-huge nbits, so the comment isn't even
>>> accurate.
>>>
>>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>>
>> Hi Rasmus,
>>
>> Maybe too late, but 
>>
>> Acked-by: Yury Norov <ynorov@caviumnetworks.com>
> 
> Actually not, I don't see this in linux-next.
> 
> Rasmus, do you know what happened to the series? Is it got stuck by unknown reasons?

I just assumed Andrew was busy doing more important things. He usually
gets around to these kinds of minor cleanups, eventually.

Rasmus
