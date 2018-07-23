Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBDBECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416E220846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416E220846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388018AbeGWJ2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:28:30 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:33097 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387869AbeGWJ2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:28:30 -0400
Received: from [192.168.122.135] (helo=_)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fhWCf-0006Nc-4J; Mon, 23 Jul 2018 09:28:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 Jul 2018 09:28:25 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     pdeschrijver@nvidia.com, jonathanh@nvidia.co,
        thierry.reding@gmail.com, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        pgaikwad@nvidia.com, linux-kernel@lists.codethink.co.uk
Subject: Re: [PATCH 6/8] clk: tegra30: add 2d and 3d idle clocks
In-Reply-To: <1721645.6LMGIEI4vR@dimapc>
References: <20180720134532.13148-1-ben.dooks@codethink.co.uk>
 <20180720134532.13148-7-ben.dooks@codethink.co.uk>
 <1721645.6LMGIEI4vR@dimapc>
Message-ID: <ca29f065814a22f46b9b1683165548cb@codethink.co.uk>
X-Sender: ben.dooks@codethink.co.uk
User-Agent: Roundcube Webmail/1.1.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-07-22 12:55, Dmitry Osipenko wrote:
> On Friday, 20 July 2018 16:45:30 MSK Ben Dooks wrote:
>> The 2D and 3D clocks have an IDLE field in bits 15:8 so add these
>> clocks by making a 2D and 3D mux, and split the divider into the
>> standard 2D/3D ones and 2D/3D idle clocks.
>> 
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

[snip]

> 
> According to TRM, Tegra20 and Tegra114 have these "idle-mode" clock 
> dividers
> as well. Why only T30 should have them?

I've got a separate series to sort t20 bits out, i've not used the 
tegra114

>> a/include/dt-bindings/clock/tegra30-car.h
>> b/include/dt-bindings/clock/tegra30-car.h index 
>> 3c90f1535551..eda4ca60351e
>> 100644
>> --- a/include/dt-bindings/clock/tegra30-car.h
>> +++ b/include/dt-bindings/clock/tegra30-car.h
>> @@ -269,6 +269,11 @@
>>  #define TEGRA30_CLK_AUDIO3_MUX 306
>>  #define TEGRA30_CLK_AUDIO4_MUX 307
>>  #define TEGRA30_CLK_SPDIF_MUX 308
>> -#define TEGRA30_CLK_CLK_MAX 309
>> +
>> +#define TEGRA30_CLK_GR2D_MUX	309
>> +#define TEGRA30_CLK_GR3D_MUX	310
>> +#define TEGRA30_CLK_GR2D_IDLE	311
>> +#define TEGRA30_CLK_GR3D_IDLE	312
>> +#define TEGRA30_CLK_CLK_MAX 313
>> 
>>  #endif	/* _DT_BINDINGS_CLOCK_TEGRA30_CAR_H */
> 
> IIUC, that "idle-mode" divisor is just some kind of power-safe feature, 
> is
> there any real use-case for these clocks? Why not to just pre-configure 
> the
> "idle-mode" bits during the clocks initialization?

It is is nice to have it available after to check, other than that we're 
not
using any drivers that currently dynamically change the values of this.

