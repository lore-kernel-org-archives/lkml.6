Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87CFC61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 06:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957452084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 06:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aA4FWMQT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfASGkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 01:40:16 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58514 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfASGkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 01:40:15 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0J6dsHb084281;
        Sat, 19 Jan 2019 00:39:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547879994;
        bh=zTAFDrBuZAevhL7Vo0ySCtMzEdq1s8xsXNLr06BDthQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=aA4FWMQT4Kr+ESx/OAgYp6/RwMrQVpqg+4AqUhnURPqbzMb32GICvam6xdNOn06DB
         lUevIBZGvrW+ypO45tfWX10yI4X9WUWGrcsnGIgu2rl3SqSuNhSdyV9l8ifvPbYrc2
         lllZW7JQZO5wvI53HhtFVV517MMY9PjBRIHLGrIg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0J6drKL001209
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 19 Jan 2019 00:39:53 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sat, 19
 Jan 2019 00:39:53 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sat, 19 Jan 2019 00:39:53 -0600
Received: from [172.22.216.68] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0J6dm5o012278;
        Sat, 19 Jan 2019 00:39:49 -0600
Subject: Re: [Letux-kernel] [PATCH v3 3/3] arm: omap_hwmod disable ick
 autoidling when a hwmod requires that
To:     Tony Lindgren <tony@atomide.com>,
        Andreas Kemnade <andreas@kemnade.info>
CC:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        <paul@pwsan.com>, <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <linux-kernel@vger.kernel.org>, <t-kristo@ti.com>,
        <bcousson@baylibre.com>, <linux-omap@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
References: <20190116220429.9136-1-andreas@kemnade.info>
 <20190116220429.9136-4-andreas@kemnade.info>
 <20190118154807.GV5544@atomide.com> <20190118181827.7163bee4@aktux>
 <20190118183630.GX5544@atomide.com> <20190118203832.3be7975e@aktux>
 <20190118204204.44db353f@aktux> <20190118194802.GZ5544@atomide.com>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <c2c283c5-d1f7-8b65-a19b-0c4af80b722a@ti.com>
Date:   Sat, 19 Jan 2019 12:09:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118194802.GZ5544@atomide.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/2019 1:18 AM, Tony Lindgren wrote:
> * Andreas Kemnade <andreas@kemnade.info> [190118 19:42]:
>> On Fri, 18 Jan 2019 20:38:47 +0100
>> Andreas Kemnade <andreas@kemnade.info> wrote:
>>
>>> Hi,
>>>
>>> On Fri, 18 Jan 2019 10:36:30 -0800
>>> Tony Lindgren <tony@atomide.com> wrote:
>>>
>>> [...]
>>>> til the next workaround.
>>>>    
>>>>> That flags also causes the iclk being enabled/disabled
>>>>> manually.
>>>>
>>>> Yes but SWSUP_IDLE for the interface clock to me currently
>>>> just means:
>>>>
>>>> "manually enable and disable ocp interface clock"
>>>>    
>>> well, if we want to manually disable it and not automatically,
>>> we have to disable autoidle or it will be automatically disabled.
>>>
>>> Disabling it manually when it is already auto-disabled (by autoidle) is
>>> just practically a no-op towards the clock.
>>>
>>>> and with your changes it becomes:
>>>>
>>>> "manually enable and disable ocp interface clock and block
>>>>   autoidle while in use".
>>>>
>>>> So aren't we now changing the way things behave in general
>>>> for SWSUP_IDLE?
>>>>    
>>> Yes, we are, so proper testing is needed. But If I read those comments
>>> it was always intended this way but not fully implemented because it
>>> appeared to be more work like needing a usecounter (which my patchset
>>> also adds) for that autoidle flag.
>>>
>> and there are quite few hwmods marked by this flag.
>> And then there are those clocks marked by this flags (on am33xx) which
>> do not have that autoidle feature at all, so the risk is not too high.
> 
> Keerthy, can you please test this series on top of the
> related clock patches with your am335x PM test cases?

Can you point me to the clock series that needs to be tested
along with this?

- Keerthy

> 
> Regards,
> 
> Tony
> 
> 
