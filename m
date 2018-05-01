Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752182AbeEAFDE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 01:03:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46556 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeEAFDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 01:03:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3091F60588
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH] clk: qcom: gdsc: Add support to poll CFG register to
 check GDSC state
To: Doug Anderson <dianders@chromium.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1524817171-7258-1-git-send-email-tdas@codeaurora.org>
 <CAD=FV=X=2nVbP+C14UMjBYveDuVYgvhbAKji6SUnXDtE8_G_uA@mail.gmail.com>
From: Taniya Das <tdas@codeaurora.org>
Message-ID: <d7d652a9-6385-464a-49d1-3f699a4889b7@codeaurora.org>
Date: Tue, 1 May 2018 10:32:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=X=2nVbP+C14UMjBYveDuVYgvhbAKji6SUnXDtE8_G_uA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Doug,

Thanks for the comments, I have based my latest patch on top of the 
earlier patches (clk-qcom-sdm845 branch of clk-next).

On 5/1/2018 12:12 AM, Doug Anderson wrote:
> Hi,
> 
> On Fri, Apr 27, 2018 at 1:19 AM, Taniya Das <tdas@codeaurora.org> wrote:
> 
>> -static int gdsc_is_enabled(struct gdsc *sc, unsigned int reg)
>> +static int gdsc_is_enabled(struct gdsc *sc, bool en)
>>   {
>> +       unsigned int reg;
>>          u32 val;
>>          int ret;
>>
>> +       if (sc->flags & POLL_CFG_GDSCR)
>> +               reg = sc->gdscr + CFG_GDSCR_OFFSET;
>> +       else
>> +               reg = sc->gds_hw_ctrl ?  sc->gds_hw_ctrl : sc->gdscr;
> 
> nit: why two spaces after the "?" in this new patch?  Should be just one.
> 
> 
>> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
>> index 3964834..ac5f844 100644
>> --- a/drivers/clk/qcom/gdsc.h
>> +++ b/drivers/clk/qcom/gdsc.h
>> @@ -53,6 +53,7 @@ struct gdsc {
>>   #define VOTABLE                BIT(0)
>>   #define CLAMP_IO       BIT(1)
>>   #define HW_CTRL                BIT(2)
>> +#define POLL_CFG_GDSCR  BIT(5)
> 
> This doesn't apply cleanly to clk-next because clk-next already has
> the old patch #1 and patch #2 from your series.  You should have
> applied your patch to clk-next before sending out.
> 
> Also a nit here is that you have two spaces before "BIT(5)" but all
> other entries in this list have a tab before them.  You should be
> consistent and use a tab.
> 
> 
> In general I'd tend to assume that Stephen could handle this small
> merge conflict and fixing the whitespace issues when applying, but if
> he tells you to spin then you certainly should.  I'll also say that
> I'm nowhere near an expert on gdsc but it looks like Stephen's
> previous comments were addressed and the patch seems sane in general.
> Stephen: feel free to add my Reviewed-by: if you wish when applying
> (or Taniya, if you end up spinning).
> 
> 
> -Doug
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
