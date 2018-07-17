Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DDCECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE5A20862
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tRKYYM4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE5A20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbeGQPzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:55:24 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51032 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbeGQPzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:55:23 -0400
Received: by mail-it0-f65.google.com with SMTP id w16-v6so2345210ita.0;
        Tue, 17 Jul 2018 08:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HMlSnFQVAaXH1Wlm82vaAi7/HJlMCrn2RyLy1Ugk+74=;
        b=tRKYYM4/sqDCAG7Q6AJNIBSESIUrySvAlIhKDaaVAELLGzTprCxWp7URser1/AeqTH
         bfE/KwGMmxcglu5UM8/hVQkNKztzoNl7qnjaj5hX3BYxDMVYGvAjkey4FxEtKCuteeg2
         kvwWc8q1jVJ7d/ypa3K2orgawAtqrxiBS4dOv8mCBiFS7oUM//RozJm3lOijWO9JXA5V
         mpPBl39nuHSIkHhYdbErEV0k9iZERxh749vlJDcqrxdmCECqpFlGlddk9L6G/zwss96f
         Q5DkbaR2hsdPmlVTaZlcNJd7WN2I2MjSu+CWt9YiQ1LmmzLBtfqi/QkO6PIpvvBdye7q
         ZKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HMlSnFQVAaXH1Wlm82vaAi7/HJlMCrn2RyLy1Ugk+74=;
        b=t1Od2YhoAlPm82yTlojxEWN0H/eCPYLKpFPBvqnlH0CnOm8QPN9HNuDcTgZ/sWmDfc
         PlodBqyRqXnzp/zjKYk9ajysdygMAfaGLIrWcIjvP27YK0YqzUlVTaQ/BAfVHBMvR9UY
         EgXIHcMYiZDcO4IGf1G39+fUKH3fa68VrYmiiZb1tpvyzz7pJYd6GcS3mPi8n+1anF3j
         +56liHJ17Iaa3YqbaHDp/09a8tFOrPcqD9vjSWbDCc3v0HphGtp6D3LvzQcJmpXZMT+v
         Z66KHaj4ysYgjLiYNwKMgSwqGb1kWiVQaAA5EtYv2HDogPw4E7hZlz/AQYIIeJATOPBc
         /Lug==
X-Gm-Message-State: AOUpUlHCKO+XhE5bkDwa6GZ57pTQQRdnN5E8aP2d747UjunUo0+hJ7NW
        t00u4BSRL/67eDM+bEgTY+AeDxb1VkPoFJG8JK0=
X-Google-Smtp-Source: AAOMgpdyvOa3e5LQD/WZi6BSqVWvfbW3ph5EQyEZPmMLRmDz/5V1B2poXpT33y9fLFsh0QurzxMgPd9lzrnIHdmtNEg=
X-Received: by 2002:a02:89fc:: with SMTP id e57-v6mr1964507jak.44.1531840934825;
 Tue, 17 Jul 2018 08:22:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:d00d:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 08:22:14
 -0700 (PDT)
In-Reply-To: <20180717152035.GD16320@lunn.ch>
References: <20180717040651.641-1-andrew.smirnov@gmail.com>
 <20180717144638.GB16320@lunn.ch> <CAFXsbZpKyLjp0bO7MVR5StKf=3UkXUANydhM+8_13G3itRmE+Q@mail.gmail.com>
 <20180717152035.GD16320@lunn.ch>
From:   Chris Healy <cphealy@gmail.com>
Date:   Tue, 17 Jul 2018 08:22:14 -0700
Message-ID: <CAFXsbZpS0zs3nihDuaMZaNEwYDyhQQeo_5gz5W-frv0QJFZKPQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610: Add ZII SSMB SPU3 board
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 8:20 AM, Andrew Lunn <andrew@lunn.ch> wrote:
>> >> +++ b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
>> >> @@ -0,0 +1,343 @@
>> >> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>> >> +
>> >> +/*
>> >> + * Device tree file for ZII's SSMB SPU3 board
>> >> + *
>> >> + * SSMB - SPU3 Switch Management Board
>> >> + * SPU - Seat Power Unit
>> >
>> > I think this is the first Zodiac board with mutually recursive
>> > acronyms.
>> >
>> > Probably a question for Chris: Does SSMB specifically refer to version
>> > 3 of the SPU?
>> >
>> >    Andrew
>>
>> SPU3 is the third generation of seat power unit.
>> SSMB is the SPU3 Switch Management Board.
>>
>> So, SSMB is a backronym.  This naming scheme breaks down a bit though
>> when follow on designs (that are not the SPU3) also use the SSMB, but
>> that's what it is... ;-)
>
> O.K, i was just wondering if the 3 was in the wrong place. More
> logically, it would be
>
> * SSMB - SPU Switch Management Board
> * SPU 3 - Seat Power Unit, version 3.
>
> But you are saying the Marketing guys messed up the naming and
> engineering is now stuck with it.
>
Yep
