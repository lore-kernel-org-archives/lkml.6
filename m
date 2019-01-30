Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B22EC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E672086C
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbfA3XoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:44:19 -0500
Received: from www1102.sakura.ne.jp ([219.94.129.142]:55012 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3XoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:44:18 -0500
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0UNi6Mq059918;
        Thu, 31 Jan 2019 08:44:06 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Thu, 31 Jan 2019 08:44:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from [192.168.1.2] (119.104.232.153.ap.dti.ne.jp [153.232.104.119])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0UNi57q059914
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 31 Jan 2019 08:44:06 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] clk: fractional-divider: check parent rate only for
 general approximation
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190107132124.27788-1-katsuhiro@katsuster.net>
 <154879892760.136743.9274469856102314518@swboyd.mtv.corp.google.com>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <d507fe24-c2ba-0c38-4985-7f8f4bf89958@katsuster.net>
Date:   Thu, 31 Jan 2019 08:44:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <154879892760.136743.9274469856102314518@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

Thank you for your comment.
I'll add detail description and send it.

Best Regards,
Katsuhiro Suzuki

On 2019/01/30 6:55, Stephen Boyd wrote:
> Quoting Katsuhiro Suzuki (2019-01-07 05:21:24)
>> Custom approximation of fractional-divider may not need parent clock
>> rate checking. For example Rockchip SoCs work fine using grand parent
>> clock rate evne if target rate is greater than parent.
>>
>> This patch removes parent clock rate check from custom approximation.
>>
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>> ---
>>   drivers/clk/clk-fractional-divider.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
>> index 545dceec0bbf..b0fc5509e0ff 100644
>> --- a/drivers/clk/clk-fractional-divider.c
>> +++ b/drivers/clk/clk-fractional-divider.c
>> @@ -79,13 +79,17 @@ static long clk_fd_round_rate(struct clk_hw *hw, unsigned long rate,
>>          unsigned long m, n;
>>          u64 ret;
>>   
>> -       if (!rate || rate >= *parent_rate)
>> +       if (!rate)
> 
> Is your fraction multiplying the rate up? If it's a divider it shouldn't
> be increasing the rate more than whatever the parent is supplying so
> this looks odd. How does the grandparent matter here? Maybe you can show
> the example in the commit text so we can all understand what's going on
> here.
> 
>>                  return *parent_rate;
>>   
> 
> 

