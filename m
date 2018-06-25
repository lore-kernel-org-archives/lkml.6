Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DEEC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A1125DA4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="mi0vlx+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A1125DA4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755398AbeFYQBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:01:19 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54685 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754173AbeFYQBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:01:16 -0400
Received: by mail-it0-f65.google.com with SMTP id 76-v6so13146191itx.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 09:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kKPCYvp3TiL2O6U9CfWcXgZL01uR0XLZBRGpu9EJ3HU=;
        b=mi0vlx+Cq8G4/e5uR9fBDXRbN8XWZV8wnj5SZFNmhOSv3gLwgUSL60oRbW1gTAXund
         5MPR0VTWJgZse/DzxaR/CQO1/u2ooVUEX4IE1wp+NxU/rkOFWpKXF8BTHpZm2T///hrs
         zj7Yc6Oipo3jPFNpBnOxF1kjc/2hBMrd1nb0GR3PAui/OC9EwSbogodz1ivbRX5rkELT
         6SQEm3dECGN2oJeV70rXWozxC0vBuDKTCZekhKjMP8QQKavpU7aLxB8depNvOIobyjro
         hGnhXwq/XpkDNmdNAorXGqHdORwQWIEJDaqiobW7d8vJrC1oTiI7grapJxrnn/hMcTRE
         w/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kKPCYvp3TiL2O6U9CfWcXgZL01uR0XLZBRGpu9EJ3HU=;
        b=JyJgwWfPu51K9oyfR9+neWZrGYWfnJCd6GxzNT2Xn/d3+Ubs+xE/x62pOdXv9oFbJw
         7G4aQIoFkrnZfZdUlOBKlc7mA7M1hdY0TcgeraW2aqBWleKBls6XsMWQlSbk0XPLFicA
         F6oVVnxImNNTI+REaPtJC9XD8mqjcZvvmuhKbUV/5jpOYQTFLvVz3LWAD0vsnFb/jRvi
         AA2nxViTTZPmP9MS3OP99Gc5BfG/NayE1c7bAK/g9d3MCTjIblTrXNTAwTPCVJWUHD8T
         3qC/PznMnJSIaEuqDyef9PJ/gOj47+sBmbcgI8vRlekdeRgeBNynMAle9vEcBWC7YWZy
         SNvg==
X-Gm-Message-State: APt69E1hb+375Gou63V8G3+o65V5yrCOv3KhcM5Bzzg8hyQKVR0dLdGx
        dfQOgg6HMv71A2mnH4pU/Eh0oLFXYxTuxu66MiVpug==
X-Google-Smtp-Source: AAOMgpc2tfbKjRcfBwdsXeuyX4e6RsFP9PLCB2HKAPHjBW2Bm7B9rWwanqQmyVHCwdoQikbldnEyQadJb8ls865GeNE=
X-Received: by 2002:a24:d80a:: with SMTP id b10-v6mr1382328itg.141.1529942475463;
 Mon, 25 Jun 2018 09:01:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:9c51:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 09:01:14
 -0700 (PDT)
In-Reply-To: <241fed6e-b414-feac-8e6c-39713c5e665e@lechnology.com>
References: <20180625152920.11549-1-brgl@bgdev.pl> <20180625152920.11549-2-brgl@bgdev.pl>
 <241fed6e-b414-feac-8e6c-39713c5e665e@lechnology.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 25 Jun 2018 18:01:14 +0200
Message-ID: <CAMRc=MdTdoL9qsrMAxhCTaQM7HGrAPpTVjDuHQ81Q5O-QMNcYQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] clk: davinci: psc-dm365: use two lookup entries for
 the aemif clock
To:     David Lechner <david@lechnology.com>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-25 17:53 GMT+02:00 David Lechner <david@lechnology.com>:
> On 06/25/2018 10:29 AM, Bartosz Golaszewski wrote:
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> We want to be able to get the clock both from the board file by its
>> con_id and from the aemif driver by dev_id.
>
>
> What about the other SoCs? Don't they need this change as well?
>

So I double checked and turns out I missed one other board that's
affected by this series and calls clk_get() from machine code:
dm644x-evm.

I'll fix it in v2.

Thanks,
Bart

>
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>   drivers/clk/davinci/psc-dm365.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/davinci/psc-dm365.c
>> b/drivers/clk/davinci/psc-dm365.c
>> index 8c73086cc676..c75424f4ea3b 100644
>> --- a/drivers/clk/davinci/psc-dm365.c
>> +++ b/drivers/clk/davinci/psc-dm365.c
>> @@ -21,7 +21,8 @@ LPSC_CLKDEV1(mmcsd1_clkdev,           NULL,
>> "da830-mmc.1");
>>   LPSC_CLKDEV1(asp0_clkdev,             NULL,           "davinci-mcbsp");
>>   LPSC_CLKDEV1(usb_clkdev,              "usb",          NULL);
>>   LPSC_CLKDEV1(spi2_clkdev,             NULL,           "spi_davinci.2");
>> -LPSC_CLKDEV1(aemif_clkdev,             "aemif",        NULL);
>> +LPSC_CLKDEV2(aemif_clkdev,             "aemif",        NULL,
>> +                                       NULL,           "ti-aemif");
>>   LPSC_CLKDEV1(mmcsd0_clkdev,           NULL,           "da830-mmc.0");
>>   LPSC_CLKDEV1(i2c_clkdev,              NULL,           "i2c_davinci.1");
>>   LPSC_CLKDEV1(uart0_clkdev,            NULL,           "serial8250.0");
>>
>
