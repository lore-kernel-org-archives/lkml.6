Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E417EC5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E37C208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OXRr5I7u";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ovz9wMEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E37C208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932862AbeFKRL2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:11:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33142 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932297AbeFKRL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:11:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 160D16070A; Mon, 11 Jun 2018 17:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528737086;
        bh=yJZnyoDd0FLJEodo74HBE69pOZYVzafmOc3KMkoZEn4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OXRr5I7uBd//MNiRiiGpybjHrMiOENnPuk7ZZlmKnZ6OTBKleEpxDDsi2kvtLypzg
         mXkQ7//z+qnqsrJrKSJlrwwoH5+tdB+/1l8pJHBkIuEU5KI/Ji1o4+xvkJJAprbb3f
         PZJg/N2TSlKlO4CFjEoF+g0tvPstJ9QBCtcxZl+0=
Received: from [192.168.1.7] (unknown [183.83.75.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CB28160541;
        Mon, 11 Jun 2018 17:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528737085;
        bh=yJZnyoDd0FLJEodo74HBE69pOZYVzafmOc3KMkoZEn4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ovz9wMEGOiLM7olPizPi8nzkAP2RWXWXWsMYeufI2Y9hLNxh9L0CLkQXj96rkbB6p
         VMF6N5UQl4Aj0yw8Jo0lB7Lcp/LSffNq1SLQApHUoYtipK7CVu7gsQQuopTDE5IvGt
         lP6vYZSoacpkBnopv3jnj06KSdUzDNNhPlXPETLY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CB28160541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
Subject: Re: [PATCH v9 04/10] drivers: qcom: rpmh: add RPMH helper functions
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>
References: <1527158731-17685-1-git-send-email-rplsssn@codeaurora.org>
 <1527158731-17685-5-git-send-email-rplsssn@codeaurora.org>
 <CAD=FV=V9TP-d33nc8Wq53C+KaDZffi7Vjtp5yDwdjvTP+aeb6A@mail.gmail.com>
From:   Raju P L S S S N <rplsssn@codeaurora.org>
Message-ID: <a7b1b031-1009-4c5b-30ec-2db529ae6150@codeaurora.org>
Date:   Mon, 11 Jun 2018 22:41:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=V9TP-d33nc8Wq53C+KaDZffi7Vjtp5yDwdjvTP+aeb6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/31/2018 3:19 AM, Doug Anderson wrote:
> Hi,
> 
> On Thu, May 24, 2018 at 3:45 AM, Raju P L S S S N
> <rplsssn@codeaurora.org> wrote:
>> --- a/drivers/soc/qcom/rpmh-rsc.c
>> +++ b/drivers/soc/qcom/rpmh-rsc.c
>> @@ -61,6 +61,8 @@
>>   #define CMD_STATUS_ISSUED              BIT(8)
>>   #define CMD_STATUS_COMPL               BIT(16)
>>
>> +LIST_HEAD(rsc_drv_list);
> 
> I still see no point of rsc_drv_list.  Please remove it, AKA squash in
> <http://crosreview.com/1042883>.

Agree.


> 
> I'm also still of the opinion that we should take something like
> <http://crosreview.com/1054646>, AKA "Get rid of the global array
> rpmh_rsc".


>> +/**
>> + * __rpmh_write: send the RPMH request
>> + *
>> + * @dev: The device making the request
>> + * @state: Active/Sleep request type
>> + * @rpm_msg: The data that needs to be sent (cmds).
>> + */
>> +static int __rpmh_write(const struct device *dev, enum rpmh_state state,
>> +                       struct rpmh_request *rpm_msg)
>> +{
>> +       struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
>> +
>> +       if (IS_ERR(ctrlr))
>> +               return PTR_ERR(ctrlr);
>> +
>> +       rpm_msg->msg.state = state;
>> +
>> +       if (state != RPMH_ACTIVE_ONLY_STATE)
>> +               return -EINVAL;
>> +
>> +       WARN_ON(irqs_disabled());
>> +
>> +       return rpmh_rsc_send_data(ctrlr->drv, &rpm_msg->msg);
>> +}
> 
> You went too far in the removal of EXPORT_SYMBOL I think.  This symbol
> needs to be exported because other code that could be compiled as a
> module might need to call into it.  To explain:
> 
> * If two files that are always built-in to Linux need to call into
> each other: no need for EXPORT_SYMBOL.
> 
> * If two files that are always part of the same module need to call
> into each other: no need for EXPORT_SYMBOL.
> 
> * If one file that might be built-into a module needs to call another
> that's builtin to the kernel: need EXPORT_SYMBOL.

Thanks for the explanation Doug. Will address this.

Thanks,
Raju
