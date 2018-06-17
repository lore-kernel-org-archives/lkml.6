Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F257C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 15:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA1320874
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 15:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="XOt08A1t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA1320874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934103AbeFQPsy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 11:48:54 -0400
Received: from vern.gendns.com ([206.190.152.46]:44217 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933506AbeFQPsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 11:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MHJWVjzZkuEF1o5lqE+1zOF7NIyxiJOdrYJWL4vM6cg=; b=XOt08A1tqBhoJvbjSP/yi121+I
        XlvNG88XJy33nbaqOy3bEbdwwKC8zDLRfdPNH5OztgOwxneSSKRK4gr866tmh4T3x9Wyn34qjooMG
        gHFEZRyhXCoWN12qgZpZwhflltT9jYVNZvbEo7aQOC7UBc5BRBb0l6bZZviUEEDLvv8HUaqdoWJ2p
        YTh4b8Zq9+wvlIKtM5Dbcef5CyV6U7wLE5oF3jE5aJl6CfbAdRkqgYQd8puJi5d3Jz7qojGYmbX+6
        FIJTREkWV0ujTUnTah3zAZuYS7jPxcoc/CT3ji7Uf+3V7uKYhmV5Xrd5frG2178aALDJgYvv+dkm0
        orjQ9EWg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:54416 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fUZv7-003Dmf-0H; Sun, 17 Jun 2018 11:48:49 -0400
Subject: =?UTF-8?Q?Re:_[PATCH_v11_00/27]_ARM:_davinci:_convert_to_common_clo?=
 =?UTF-8?B?Y2sgZnJhbWV3b3Jr4oCL?=
To:     Sekhar Nori <nsekhar@ti.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org
References: <20180518164829.27052-1-david@lechnology.com>
 <850a0ec9-53aa-02a5-ecbd-e068b13b2764@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <89b599d3-c43a-255f-8da6-9bea6cf53a5d@lechnology.com>
Date:   Sun, 17 Jun 2018 10:48:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <850a0ec9-53aa-02a5-ecbd-e068b13b2764@ti.com>
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

Hi Sekhar,

On 05/22/2018 04:38 AM, Sekhar Nori wrote:
> Hi David,
> 
> On Friday 18 May 2018 10:18 PM, David Lechner wrote:
>> This series converts mach-davinci to use the common clock framework.
>>
>> The series works like this, the first 3 patches fix some issues with the clock
>> drivers that have already been accepted into the mainline kernel.
>>
>> Then, starting with "ARM: davinci: pass clock as parameter to
>> davinci_timer_init()", we get the mach code ready for the switch by adding the
>> code needed for the new clock drivers and adding #ifndef CONFIG_COMMON_CLK
>> around the legacy clocks so that we can switch easily between the old and the
>> new.
>>
>> "ARM: davinci: switch to common clock framework" actually flips the switch
>> to start using the new clock drivers. Then the next 8 patches remove all
>> of the old clock code.
>>
>> The final four patches add device tree clock support to the one SoC that
>> supports it.
>>
>> This series has been tested on TI OMAP-L138 LCDK (both device tree and legacy
>> board file).
> 
> If you do end up sending a v12, you can leave out the mach-davinci
> portions unless there are any changes you need to make. I will pick them
> up from this series once the driver dependencies are merged.
> 
> I do hope the drivers/clk/* changes can be merged from v4.18.
> 
> Thanks,
> Sekhar
> 

Are you going to pick up the arch patches from this series now that
the 4.18 merge window is closed?

All of the clk patches landed in 4.18.
