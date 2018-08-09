Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8588CC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2657021EC2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="o5Gc9a26";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="a/wREm8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2657021EC2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732616AbeHITwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:52:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40796 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731198AbeHITwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:52:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 593D2606CF; Thu,  9 Aug 2018 17:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533835602;
        bh=zMqeUHb9x39NFn2br9txibW6X8mqecdfmWv0clsytrs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=o5Gc9a26ZmI49pbF6v9bPZ8tIKUZgsW3zrDAv5+hY7KbzfKRY3u6x7zQsMzeFa10i
         0HRrT6d+RCLR0jIjP/QFvvR0yNDYQwCs12UtM1qLPYTjQ9bF9EP/qHcS+s7pf29eSE
         gjDtviqh9KHuWvMHg5gQrUPZa9ZsuV+x2yKFZQyk=
Received: from [192.168.0.3] (unknown [115.99.104.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 86FA760AD9;
        Thu,  9 Aug 2018 17:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533835601;
        bh=zMqeUHb9x39NFn2br9txibW6X8mqecdfmWv0clsytrs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=a/wREm8+314s8o3PUPye6RBo9HxlDwplkGrm0asE5hqKFJx1Ycxv+FYfRSyCr3K3Y
         LjUG071iAbUxQuLHCB5ns9VBAlOAlXz5SxWD6xizIKFbuPPLb3eccOc9KIg3ql377U
         8oRwzqatWgOh1oFa135KB0pVItaopEZ66ACncugs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 86FA760AD9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH v8 3/5] phy: Add QMP phy based UFS phy support for sdm845
To:     Evan Green <evgreen@chromium.org>, cang@codeaurora.org
Cc:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        Manu Gautam <mgautam@codeaurora.org>, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20180731100914.19856-1-cang@codeaurora.org>
 <20180731100914.19856-4-cang@codeaurora.org>
 <CAE=gft6cdE+oMYf779VGrQHfYQ5Xb1v+Qr6cAznTtAovehCOxw@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <c5ccbdac-8816-2a64-eb29-23e506b5cf7c@codeaurora.org>
Date:   Thu, 9 Aug 2018 22:56:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAE=gft6cdE+oMYf779VGrQHfYQ5Xb1v+Qr6cAznTtAovehCOxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,


On 8/9/2018 3:25 AM, Evan Green wrote:
> On Tue, Jul 31, 2018 at 3:09 AM Can Guo <cang@codeaurora.org> wrote:
>> Add UFS PHY support to make SDM845 UFS work with common PHY framework.
>>
>> Signed-off-by: Can Guo <cang@codeaurora.org>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp.c | 172 +++++++++++++++++++++++++++++++++++-
>>   drivers/phy/qualcomm/phy-qcom-qmp.h |  15 ++++
>>   2 files changed, 186 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
>> index 9be9754..de7ff18 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> ...
>>   static void qcom_qmp_phy_configure(void __iomem *base,
>>                                     const unsigned int *regs,
>>                                     const struct qmp_phy_init_tbl tbl[],
>> @@ -1131,6 +1249,14 @@ static int qcom_qmp_phy_init(struct phy *phy)
>>          qcom_qmp_phy_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
>>
>>          /*
>> +        * UFS PHY requires the deassert of software reset before serdes start.
>> +        * For UFS PHYs that do not have software reset control bits, defer
>> +        * starting serdes until the power on callback.
>> +        */
> I'm relatively thick when it comes to PHYs, but I'm a little confused.
> The sequence of code right below this (not shown) looks like it is
> deasserting reset before starting serdes, seemingly doing what the
> comment wants. I guess the problem is the lack of SW reset? So then
> you defer serdes start until UFS does... something. Can you explain
> how deferring to after UFS HC init actually helps? Is it the UFS HC
> that releases reset on the PHY?

As you can see in [1], the ufs first asserts the sw_reset, then phy 
initialization is done.
This phy_init() is just programming the phy registers. Now as per the H/W
programming doc, we can't start the phy until we de-assert the sw_reset.
So the sequence as per the programming doc should be:

assert SW_reset --> program phy serdes/tx/rx/pcs registers --> deassert 
SW_reset --> start serdes --> test PCS status

That's the reason that serdes_start has been moved to phy_power_on(), as 
that seemed
a more cleaner way of handling the above sequence.
UFS HC init doesn't help more than this in terms of phy initialization.

>
> I was hoping the next patch would help, but I'm still confused. It
> looks like you've added a call to phy_power_on in
> ufs_qcom_setup_clocks, but there's also one still in
> ufs_qcom_power_up_sequence. What does the original phy_power_on in
> ufs_qcom_power_up_sequence do now? It seems like that one would do the
> power on too early, and then your new added call in
> ufs_qcom_setup_clocks would do nothing.

I think [patch 4/5] of this series handles this. We skip the 
phy_power_on until
we do phy_init.
phy_power_on/off() in setup_clocks() is also used for suspend/resume case
and that's the reason you see couple of phy_power_on(). Patch 4/5 should 
handle
this now.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/ufs/ufs-qcom.c#n268

[snip]

Regards
Vivek
