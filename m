Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7369EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2302F2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BFuQH+gk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2302F2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeHaMIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:08:01 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36647 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeHaMIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:08:01 -0400
Received: by mail-wm0-f67.google.com with SMTP id j192-v6so4432748wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 01:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V70EShZZZMhM/idW+PMgxEPMDT+DBbzZvdgv3cs4Keo=;
        b=BFuQH+gkE0EbL/QyoTVm/H1PM1Qgbu290uXr9mXxUn8lRc1JXah484r4qFP9pP0f9g
         RZLOd8rNZaLfwAYOaLG60l6fNFvJp38MrCbPpu0oQ+2M4VBooGCGjYzQts9FMemAZwWN
         ieNzKobQGNILxXnjPb9sZvPufN3BQm644RKyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V70EShZZZMhM/idW+PMgxEPMDT+DBbzZvdgv3cs4Keo=;
        b=oEuR2oLrswkS5Y3alTtbcMLllLiavjnEpSoIUPHR0DWrIuIwC7BgzuQ+U8EGov372u
         M6gUiz4I9hhrC4mBk18fvwHu3ksS/l4JhGGOFMm4SmP2EdklBHDP4XPMGxJGgzwvjDRP
         aBGTYrUyRNVY9eaiA3nmkL3zUFAslu2NTlfrF1XU0oWLtr4qe3t8/3RMTKOnemMx4hlG
         rmeLiBhqxaZ519rEApwXVNrrHwI4NQMNAj64wEcdI9gtUdZMOjWl4VXmKwetMtM/4W3c
         2rCzhM1zrZk/lHYzpFyphoQa04l3fOJ6P0uMwLt9jDNA9cn6YreTzw7PQkgxAO3o2YV0
         QSRg==
X-Gm-Message-State: APzg51CyrnyTL2a/ky8Khzp/gn0sgqcf0B2cx3jmqwiT43Yi5eb/qSGe
        iiFIZDky8PERnLhrfgsuZpgXKA==
X-Google-Smtp-Source: ANB0VdYmETAimkvMhLfLtR96t2ocCe3Es0cjkTxJl545jN+aCJzfT9j9GHHopB67nC734j3k0le9Sg==
X-Received: by 2002:a1c:cf08:: with SMTP id f8-v6mr4168381wmg.27.1535702506595;
        Fri, 31 Aug 2018 01:01:46 -0700 (PDT)
Received: from [192.168.1.2] (static-qvn-qvu-167076.business.bouyguestelecom.com. [89.81.167.76])
        by smtp.googlemail.com with ESMTPSA id s131-v6sm4746586wmf.2.2018.08.31.01.01.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 01:01:46 -0700 (PDT)
Subject: Re: [PATCH 2/2] clk: imx: imx7d: remove clks_init_on array
To:     Stephen Boyd <sboyd@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1533703167-26583-1-git-send-email-Anson.Huang@nxp.com>
 <1533703167-26583-2-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB4481FC2BAD71B75D7BE84C0788260@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916F8BC381BBA01DB21D1C0F5260@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM0PR04MB44813C7A3E0AF4F3BCFFCF0088390@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <153567894721.93865.4092113232222931488@swboyd.mtv.corp.google.com>
From:   Jerome Forissier <jerome.forissier@linaro.org>
Message-ID: <a6489bda-703f-207c-0b24-60f4044fe89f@linaro.org>
Date:   Fri, 31 Aug 2018 10:01:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153567894721.93865.4092113232222931488@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/31/2018 03:29 AM, Stephen Boyd wrote:
> Quoting Peng Fan (2018-08-12 18:15:41)
>> Hi Anson,
>>
>>>>> -----Original Message-----
>>>>> From: Anson Huang
>>>>> Sent: 2018年8月8日 12:39
>>>>> To: shawnguo@kernel.org; s.hauer@pengutronix.de;
>>>>> kernel@pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
>>>>> mturquette@baylibre.com; sboyd@kernel.org;
>>>>> linux-arm-kernel@lists.infradead.org;
>>>>> linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org
>>>>> Cc: dl-linux-imx <linux-imx@nxp.com>
>>>>> Subject: [PATCH 2/2] clk: imx: imx7d: remove clks_init_on array
>>>>>
>>>>> Clock framework will enable those clocks registered with
>>>>> CLK_IS_CRITICAL flag, so no need to have clks_init_on array during
>>>>> clock
>>>> initialization now.
>>>>
>>>> Will it be more flexible to parse dts saying "critical-clocks = <xxx>"
>>>> or "init-on-arrary=<xxx>"
>>>> and enable those clocks?
>>>
>>> Parsing the clocks arrays from dtb is another way of enabling critical clocks, but
>>> for current i.MX6/7 platforms, we implement it in same way as most of other
>>> SoCs, currently I did NOT see any necessity of putting them in dtb, just adding
>>> flag during clock registering is more simple, if there is any special requirement
>>> for different clocks set to be enabled, then we can add support to enable the
>>> method of parsing critical-clocks from dtb. Just my two cents.
>>
>> Thinking about OP-TEE want to use one device, but it's clocks are registered
>> by Linux, because there is no module in Linux side use it, it will shutdown the clock,
>> which cause OP-TEE could not access the device.
>>
>> Then people have to modify clk code to add CLK_IS_CRITICAL flag to make sure
>> the clocks are not shutdown by Linux.
>>
>> However adding a new property in clk node and let driver code parse the dts,
>> there is no need to modify clk driver code when OP-TEE needs another device clock.
>>
> 
> If OP-TEE needs linux to keep things on then why can't the OP-TEE driver
> in Linux probe, acquire clocks, and keep the clks enabled forever?

Sounds reasonable, but how could this be done without introducing
platform-specific stuff in the OP-TEE driver?

> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
