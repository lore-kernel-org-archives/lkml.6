Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A72FC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366E1218C3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HgLB53hl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366E1218C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387644AbeHGIQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 04:16:21 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35354 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbeHGIQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 04:16:21 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7762IgA044068;
        Tue, 7 Aug 2018 01:02:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533621738;
        bh=YL/ZQmphpD0iTyyf24TF2tz2ZqtHusEN0haDa++zFp8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HgLB53hlHNCzVQj0puVVTi5XqDgFvw78gz+56N08OfBr/QfWwJ6OM83FUDwoMFdtX
         hDVAMpcpmJ7gxT6SoqIC21RjPhT4Y5n5tX4ppY/U7sG1ggXfhX4/YCzhy1ThHa/Jpd
         2C1mcXObbSDJovncpA9TR7NhYZt9PaOJLQ63OhCA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7762I0g024593;
        Tue, 7 Aug 2018 01:02:18 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 7 Aug
 2018 01:02:17 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 7 Aug 2018 01:02:17 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7762ErA020402;
        Tue, 7 Aug 2018 01:02:15 -0500
Subject: Re: [PATCH v3 00/13] ARM: davinci: remove duplicate aemif support
To:     David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180628095748.4462-1-brgl@bgdev.pl>
 <52a274f1-283a-a14a-54f3-4b95b6605c4f@ti.com>
 <59fdc532-bb72-ffae-cfb6-a7f156c14771@lechnology.com>
 <e1222b3c-dfa4-4cb0-eebf-8e2550e9d674@ti.com>
 <125d73f7-7311-866f-1e9d-d3c1f9473899@lechnology.com>
 <92e41afc-cf3a-e713-11d5-247b8d6e3a64@ti.com>
 <4154b955-4f89-035a-8a02-a3e8bd8d9ede@lechnology.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <c09e90e1-2e55-aced-1215-4c845349c1b1@ti.com>
Date:   Tue, 7 Aug 2018 11:32:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4154b955-4f89-035a-8a02-a3e8bd8d9ede@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Monday 06 August 2018 10:05 PM, David Lechner wrote:
> On 07/10/2018 05:19 AM, Sekhar Nori wrote:
>> On Friday 06 July 2018 11:09 PM, David Lechner wrote:
>>> On 07/04/2018 01:35 AM, Sekhar Nori wrote:
>>>> Hi David,
>>>>
>>>> On Monday 02 July 2018 09:02 PM, David Lechner wrote:
>>>>> On 07/02/2018 07:28 AM, Sekhar Nori wrote:
>>>>>> Hi David, Stephen,
>>>>>>
>>>>>> On Thursday 28 June 2018 03:27 PM, Bartosz Golaszewski wrote:
>>>>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>>>>
>>>>>>> This series moves all aemif/nand users to using the ti-aemif
>>>>>>> platform
>>>>>>> driver located in drivers/memory instead of the older API located in
>>>>>>> mach-davinci.
>>>>>>>
>>>>>>> First five patches add necessary changes to the clock driver. Next
>>>>>>> seven convert the board files to using the ti-aemif driver. Last
>>>>>>> patch
>>>>>>> removes now dead code.
>>>>>>
>>>>>> How do you want to handle this series? I can apply the series and
>>>>>> provide you an immutable branch on v4.18-rc1 with the clock patches
>>>>>> applied if that can work.
>>>>>
>>>>> Sounds good to me. But I'm new to this maintainer thing, so maybe
>>>>> there is something to consider that I haven't thought of?
>>>>
>>>> I don't think there is more to it. Ultimately there should not be two
>>>> commits for the same patch. Either you can apply and share the
>>>> commit to
>>>> use or I can do that as well. I am equally fine either way.
>>>>
>>>> Regards,
>>>> Sekhar
>>>>
>>>
>>> I've created a branch for-sekhar at https://github.com/dlech/linux.git
>>> with the clk commits.
>>
>> Thanks. I merged commit f917ff75ac55b6d829c9d1142e83913064565d5b (top of
>> that branch) to my v4.19/soc branch. Please do let Stephen and Mike know
>> about this then when you send your stuff for v4.19.
>>
> 
> Since there have been no more clk-davinci patches for v4.19, I assume that
> it is OK to just let this go through the ARM tree via Sekhar?

Yes, that should be fine.

Thanks,
Sekhar
