Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08940C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3137218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="rL3JU099"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389488AbeLUKWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:22:30 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42840 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389473AbeLUKW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:22:29 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so4242595lja.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4bcZukLakkWf6+CfNvRBmI9VoGjGKAsi/dt6R8KXiHc=;
        b=rL3JU099+gWXXtm11ylhAkmC8PxaAQmFtNRaCbW2wKWBZNft89w96D2oL6lX0ktCQP
         OpEQwd8WKscH0mSMhqG640/TvMJYF/yIOAWTY/OtLRs9cIK28IsATu2535sw0iEL3QP7
         jxtws8/rl6SP8PiSfWaYdHlR/u0wdR655rMl3Z6XUtXyVEDCuR5VBPjtofBP9UhM9IJi
         mdcx99EBCqfZcWQYDrHeK9MIR4sqCo0gzaeq6r0onJebUhRCK1W1QBD1r8aq/M5dW53B
         Nv/YTgop0pgddtKa6ZB4qVgWoPxIpm0fJLxd82MvIxEZwzoIRLE2964b3UxI8ceJKMhr
         +KFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4bcZukLakkWf6+CfNvRBmI9VoGjGKAsi/dt6R8KXiHc=;
        b=CeC284I7NJPCWxdLh8t+yavYslpC67+LNmw+ifWAa2HjLkQidkmb//qRPwb7mQMvhU
         mPutWW/V4PHbcVwLOCqSRceRn1wYARAt4lDZ0AxJijDA5xkUvmQBejSt3hDuekY1Lw61
         +Cy1NzdKhm3xI8SSF83gvsYf1Ydn6yfFNHkgT5JNWtOFuXUN4BcFz8ZPEZK3MbpbPuDZ
         SffvMmZtGtG5p/ZPgwlLKO+lWRQQmeoJd6PomQGu1+Y+JrZSESxIrPhUUhoclThEt9MA
         kXEfBHg3U98tbK+argvbPidB9I8nxjxTJTmDxslac7M+hhAqF7mfcsi62KkWc3Ebc8QM
         zO/Q==
X-Gm-Message-State: AJcUukfhtPbEj1pmjmG6ECChZWrYBZx1gVRaLQQCwDkY7oEnWJwoLD+H
        1W75BkDOfmJOPW2ujKjLNEaZ2Q==
X-Google-Smtp-Source: ALg8bN5iEFaWWXW1jzDXDzl32WH8EAwtjYoGVYGVQBidbIz23YwQ+Af5zerzXXygm361IBn6gw9bGw==
X-Received: by 2002:a2e:8719:: with SMTP id m25-v6mr1283855lji.121.1545387748169;
        Fri, 21 Dec 2018 02:22:28 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.81.170])
        by smtp.gmail.com with ESMTPSA id m10-v6sm4511334ljj.34.2018.12.21.02.22.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 02:22:27 -0800 (PST)
Subject: Re: [PATCH v3 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
 driver
To:     masonccyang@mxic.com.tw
Cc:     boris.brezillon@bootlin.com, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        zhengxunli@mxic.com.tw
References: <1544181199-3373-1-git-send-email-masonccyang@mxic.com.tw>
 <1544181199-3373-2-git-send-email-masonccyang@mxic.com.tw>
 <b638fedc-551a-63e4-9654-f9fed8d0e292@cogentembedded.com>
 <OFC335F545.7543A0F2-ON4825836A.0007E65A-4825836A.0008428D@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <9945f585-ab50-978a-7290-249336b7f107@cogentembedded.com>
Date:   Fri, 21 Dec 2018 13:22:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <OFC335F545.7543A0F2-ON4825836A.0007E65A-4825836A.0008428D@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 12/21/2018 04:30 AM, masonccyang@mxic.com.tw wrote:

>> > diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
>> > new file mode 100644
>> > index 0000000..cec5669
>> > --- /dev/null
>> > +++ b/drivers/spi/spi-renesas-rpc.c
>> > @@ -0,0 +1,776 @@
>> [...]
>> > +static const struct soc_device_attribute r8a7795es1[] __initconst = {
>>
>>    This __initconst shouldn't be there, it causes a build warning.
>>
>> > +   { .soc_id = "r8a7795", .revision = "ES1.*" },
>>
>>    Wait, the driver doesn't really probe on R8A7795 yet!
> 
> yup, this is for RPC_PHYCNT_STRTIM setting by Marek's comments.
> 
> On H3 ES1.x, the value should be 0, while on others, the value should be 6.
> 
> ES1.x is r8a7795.

   Why care if we don't support H3 yet? Add this when the R8A77950 support is added.

>> > +   { /* sentinel */ }
>> > +};
>> > +
>> > +static void rpc_spi_hw_init(struct rpc_spi *rpc)
>> > +{
>> > +   int strtim;
>> > +   /*
>> > +    * NOTE: The 0x260 are undocumented bits, but they must be set.
>> > +    *   RPC_PHYCNT_STRTIM is strobe timing adjustment bit,
>> > +    *   0x0 : the delay is biggest,
>> > +    *   0x1 : the delay is 2nd biggest,
>> > +    *   On H3 ES1.x, the value should be 0, while on others,
>> > +    *   the value should be 6.
>> > +    */
>> > +   if (soc_device_match(r8a7795es1))
>> > +      strtim = 0;
>> > +   else
>> > +      strtim = 6;
>> [...]
>> > +static const struct of_device_id rpc_spi_of_ids[] = {
>> > +   { .compatible = "renesas,r8a77995-rpc", },
>>
>>    We only support R8A77995 now.
> 
> see above !

   There's difference between R8A77995 and R8A77950, right?

[...]
> thanks & best regards,
> Mason

MBR, Sergei
