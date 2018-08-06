Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74005C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229B421A52
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="WEOOJlQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229B421A52
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733296AbeHFSpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:45:13 -0400
Received: from vern.gendns.com ([206.190.152.46]:43846 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729230AbeHFSpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LvymvdjcDZ4k4aN4cE1nQJzY4mXwHTBXsoDzWFrwVE8=; b=WEOOJlQI7aS7mBb3+kUGsynwZg
        +4e6CwFg2k9LBSyGtMv+cVZeNHgrZmf1LY4h1YWMBW2E1HTTCxzqdVTDrJA6ti+v2fGYmq9R/XZuu
        kOMavaeE7ANPlRZMNJWkxx2zhGYm6ovs/Kh2CGMJTvt6CdhY2CC5ffiRbxulL6lJ98AaGBGSVFqpQ
        /qisH/IdYTn/I8df6hrNydEg36/eys2iG0jRvEmJDLd/7Kwa2r7/Mr56KLFjpQI2AklmA8ErFdujh
        DRoEH/e8XlqqvBvSnBf4zOv0qxFqrspTm8g8aFEmX+akFwY3AFe8eB9cJmmMstsNuhfvNEbULU80g
        sNUJZv+g==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:49224 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fmiTW-008A3I-2u; Mon, 06 Aug 2018 12:35:18 -0400
Subject: Re: [PATCH v3 00/13] ARM: davinci: remove duplicate aemif support
To:     Sekhar Nori <nsekhar@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180628095748.4462-1-brgl@bgdev.pl>
 <52a274f1-283a-a14a-54f3-4b95b6605c4f@ti.com>
 <59fdc532-bb72-ffae-cfb6-a7f156c14771@lechnology.com>
 <e1222b3c-dfa4-4cb0-eebf-8e2550e9d674@ti.com>
 <125d73f7-7311-866f-1e9d-d3c1f9473899@lechnology.com>
 <92e41afc-cf3a-e713-11d5-247b8d6e3a64@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <4154b955-4f89-035a-8a02-a3e8bd8d9ede@lechnology.com>
Date:   Mon, 6 Aug 2018 11:35:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <92e41afc-cf3a-e713-11d5-247b8d6e3a64@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2018 05:19 AM, Sekhar Nori wrote:
> On Friday 06 July 2018 11:09 PM, David Lechner wrote:
>> On 07/04/2018 01:35 AM, Sekhar Nori wrote:
>>> Hi David,
>>>
>>> On Monday 02 July 2018 09:02 PM, David Lechner wrote:
>>>> On 07/02/2018 07:28 AM, Sekhar Nori wrote:
>>>>> Hi David, Stephen,
>>>>>
>>>>> On Thursday 28 June 2018 03:27 PM, Bartosz Golaszewski wrote:
>>>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>>>
>>>>>> This series moves all aemif/nand users to using the ti-aemif platform
>>>>>> driver located in drivers/memory instead of the older API located in
>>>>>> mach-davinci.
>>>>>>
>>>>>> First five patches add necessary changes to the clock driver. Next
>>>>>> seven convert the board files to using the ti-aemif driver. Last patch
>>>>>> removes now dead code.
>>>>>
>>>>> How do you want to handle this series? I can apply the series and
>>>>> provide you an immutable branch on v4.18-rc1 with the clock patches
>>>>> applied if that can work.
>>>>
>>>> Sounds good to me. But I'm new to this maintainer thing, so maybe
>>>> there is something to consider that I haven't thought of?
>>>
>>> I don't think there is more to it. Ultimately there should not be two
>>> commits for the same patch. Either you can apply and share the commit to
>>> use or I can do that as well. I am equally fine either way.
>>>
>>> Regards,
>>> Sekhar
>>>
>>
>> I've created a branch for-sekhar at https://github.com/dlech/linux.git
>> with the clk commits.
> 
> Thanks. I merged commit f917ff75ac55b6d829c9d1142e83913064565d5b (top of
> that branch) to my v4.19/soc branch. Please do let Stephen and Mike know
> about this then when you send your stuff for v4.19.
> 

Since there have been no more clk-davinci patches for v4.19, I assume that
it is OK to just let this go through the ARM tree via Sekhar?


