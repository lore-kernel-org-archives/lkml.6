Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbeBOFNP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 00:13:15 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55782 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeBOFNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 00:13:13 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 351D760585
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v3 3/3] arm64: dts: sdm845: Add serial console support
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stephen Boyd <sboyd@codeaurora.org>, evgreen@chromium.org
References: <20180212062832.2791-1-rnayak@codeaurora.org>
 <20180212062832.2791-4-rnayak@codeaurora.org>
 <CAD=FV=UXrmpsK3k+8yZCqVi6S+c_3icPUViDST+shnrQW1A6EA@mail.gmail.com>
 <20180214191125.GD93895@bjorns-mbp-2.lan>
From: Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <a7008b8a-1c07-6a49-f586-cea88a6e9a18@codeaurora.org>
Date: Thu, 15 Feb 2018 10:43:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180214191125.GD93895@bjorns-mbp-2.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/15/2018 12:41 AM, Bjorn Andersson wrote:
> [..]
>>> +
>>> +               qup_1: geni-se@ac0000 {
>> Color me confused.  So you're saying here that this is "qup_1".
>> ...but above you turn the pinmux for pins "GPIO4" and "GPIO5" to
>> "qup9", right?  So UART2 is on "qup 1" and "qup 9"?
>>
>> ...OK, so I stared at manuals a bunch more, and _maybe_ I get it.
>> Maybe there are 3 "QUP v3 modules" each of which handles up to 8
>> "QUP"s.  So QUP 9 is on "QUP module 1", is that right?  If everyone
>> understands this already and it's just me that's confused then I guess
>> you can just ignore this comment.  However, if you can think of any
>> better alias than "qup_1" that makes this less confusing then that
>> would make me extra happy.  Like maybe "qupv3_id_1" to match the
>> manual?
> This is indeed a source of confusion, in particular since there tend to
> be different numbering depending on what part of the puzzle you look at.
> But you're right that each QUP has a number of engines, each one being a
> UART/I2C/SPI controller.
> 
> I don't see a reason for labeling this particular node though, aliases
> references individual engines, not the wrapper.

makes sense, I'll just drop the label.


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
