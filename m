Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058AEC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2434208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="T1+1hDq6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="T1+1hDq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2434208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeGLMdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:33:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34156 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeGLMdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:33:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D3C106083C; Thu, 12 Jul 2018 12:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531398229;
        bh=P7GGGpX50ttdnNWWeaAdJoiwgtL6utFwnEGoSD5ALsg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T1+1hDq6YH9akm5VJ3u+vl5mYnDFJ5NoURWmZ4KJQs5w7EI+BibR9TVxGhcQTzEFM
         Dxo+gGKu/1il3OATNSMPXDkoU1ee29UOK9ZCsxPK07KkdDTw7FOnulZskYgKCq8/Mq
         ZcTJ+qfkANVlfCVJr1l0xy8ZwowN+I5Ybwaj6QGQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 0ABA36083C;
        Thu, 12 Jul 2018 12:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531398229;
        bh=P7GGGpX50ttdnNWWeaAdJoiwgtL6utFwnEGoSD5ALsg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T1+1hDq6YH9akm5VJ3u+vl5mYnDFJ5NoURWmZ4KJQs5w7EI+BibR9TVxGhcQTzEFM
         Dxo+gGKu/1il3OATNSMPXDkoU1ee29UOK9ZCsxPK07KkdDTw7FOnulZskYgKCq8/Mq
         ZcTJ+qfkANVlfCVJr1l0xy8ZwowN+I5Ybwaj6QGQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 12 Jul 2018 17:53:48 +0530
From:   Amit Nischal <anischal@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk-owner@vger.kernel.org
Subject: Re: [PATCH 1/4] clk: qcom: gdsc: Add support to enable/disable the
 clocks with GDSC
In-Reply-To: <153111447519.143105.17241493270191899078@swboyd.mtv.corp.google.com>
References: <1528285308-25477-1-git-send-email-anischal@codeaurora.org>
 <1528285308-25477-2-git-send-email-anischal@codeaurora.org>
 <153111447519.143105.17241493270191899078@swboyd.mtv.corp.google.com>
Message-ID: <6e53b7934af72e40e99a3d6afe54174f@codeaurora.org>
X-Sender: anischal@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Thanks for the review comments.

Regards,
Amit

On 2018-07-09 11:04, Stephen Boyd wrote:
> Quoting Amit Nischal (2018-06-06 04:41:45)
>> For some of the GDSCs, there is a requirement to enable/disable the
>> few clocks before turning on/off the gdsc power domain. Add support
> 
> Why is there a requirement? Do the clks need to be in hw control mode 
> or
> they can't be turned off when the GDSC is off? It's hard for me to
> understand with these vague statements.
> 

This requirement is primarily to turn on the GPU GX GDSC and these 
clocks
do not need to be in HW control mode and clock disable is not related
with the GDSC.

To turn on the GX GDSC, root clock (GFX3D RCG) needs to be enabled first
before writing to SW_COLLAPSE bit of the GDSC. The CLK_ON signal from 
RCG
would power up the GPU GX GDSC.


>> for the same by specifying a list of clk_hw pointers per gdsc and
>> enable/disable them along with power domain on/off callbacks.
>> 
>> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
>> ---
>>  drivers/clk/qcom/gdsc.c | 44 
>> ++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/clk/qcom/gdsc.h |  5 +++++
>>  2 files changed, 49 insertions(+)
>> 
>> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
>> index a077133..b6adca1 100644
>> --- a/drivers/clk/qcom/gdsc.c
>> +++ b/drivers/clk/qcom/gdsc.c
>> @@ -12,6 +12,8 @@
>>   */
>> 
>>  #include <linux/bitops.h>
>> +#include <linux/clk.h>
> 
> Ugh.
> 
>> +#include <linux/clk-provider.h>
> 
> Both, really?
> 

Above includes are required else we get a compilation error as below:
error: dereferencing pointer to incomplete type
    ret = clk_prepare_enable(sc->clk_hws[i]->clk);
                                           ^

>>  #include <linux/delay.h>
>>  #include <linux/err.h>
>>  #include <linux/jiffies.h>
>> @@ -208,11 +210,41 @@ static inline void gdsc_assert_reset_aon(struct 
>> gdsc *sc)
>>         regmap_update_bits(sc->regmap, sc->clamp_io_ctrl,
>>                            GMEM_RESET_MASK, 0);
>>  }
>> +
>> +static int gdsc_clk_prepare_enable(struct gdsc *sc)
>> +{
>> +       int i, ret;
>> +
>> +       for (i = 0; i < sc->clk_count; i++) {
>> +               ret = clk_prepare_enable(sc->clk_hws[i]->clk);
>> +               if (ret) {
>> +                       for (i--; i >= 0; i--)
>> +                               
>> clk_disable_unprepare(sc->clk_hws[i]->clk);
>> +                       return ret;
>> +               }
>> +       }
>> +       return 0;
>> +}
>> +
> 
> Looks an awful lot like bulk_enable clk API.

As mentioned above, ROOT_EN bit of GFX3D RCG needs to be enabled first 
to
turn on the GDSC. We want this enable to happen only through clock 
framework
API in order to avoid stability issues.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
