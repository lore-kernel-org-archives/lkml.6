Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1700BC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB8A20834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SH7dS6yO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QwY6dPcU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB8A20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbeJEVR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:17:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60124 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbeJEVR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:17:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 314A56035F; Fri,  5 Oct 2018 14:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538749141;
        bh=jDbqnxvlI+BVTltqAUIvUOEC4d0n7vP/A2ZY3X0M010=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SH7dS6yOKj8I2S6r+8UnBe779Ic37kvXa25IBnDrULPsxPlADoOtKWD8veGJdmtof
         lqsW2s32zuoGLmZ4INwCuQd2fUZ3z0BO372KFcUaKgkYKyOMrshGVyQWvza30k9MsE
         OrvJZ7EhDKKCsTTQoCopnEoCO3kkk/WI7bAssIHU=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 20DF26031A;
        Fri,  5 Oct 2018 14:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538749140;
        bh=jDbqnxvlI+BVTltqAUIvUOEC4d0n7vP/A2ZY3X0M010=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QwY6dPcUmPu7D96SMd6UQfFmFoXu7zLlkDEX2I4pKcxOLNWzQTggLy7jbfzl71aC2
         ElIvWJZN83I/9iEAqWVvMyHbiWkwycPJy8OT4TnHTD4HSKgB7zVtVvihmM3Md++1cu
         TdAL91J3dJYT4dZ7UvIQLcCfGchAs7WG6CJV4o8s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20DF26031A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v4 3/3] gpiolib: Show correct direction from the beginning
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Timur Tabi <timur@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181002140858.16833-1-ricardo.ribalda@gmail.com>
 <d1bbafcb-1b6a-b137-1fd1-954c17e14836@codeaurora.org>
 <da760bcf-4716-e685-1ce4-1dbc6eb7c272@codeaurora.org>
 <CAPybu_1qqdffE4K2BonCV0X_eYY+or6NSK9Bbco9A68N9aasVw@mail.gmail.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <b020854a-819e-a0b4-5e29-a2aca19fad59@codeaurora.org>
Date:   Fri, 5 Oct 2018 08:18:59 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPybu_1qqdffE4K2BonCV0X_eYY+or6NSK9Bbco9A68N9aasVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/2018 12:52 AM, Ricardo Ribalda Delgado wrote:
> Hi
> On Fri, Oct 5, 2018 at 12:26 AM Jeffrey Hugo <jhugo@codeaurora.org> wrote:
>>
>> On 10/2/2018 9:21 AM, Jeffrey Hugo wrote:
>>> On 10/2/2018 8:08 AM, Ricardo Ribalda Delgado wrote:
>>>> Current code assumes that the direction is input if direction_input
>>>> function is set.
>>>> This might not be the case on GPIOs with programmable direction.
>>>>
>>>> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
>>>
>>> I'll try to get this series tested on QDF2400 by the end of the week.
>>
>> 1-2/3 (v3) and 3/3 (v4) still fails.  Same issue.  Attempting to access
>> config registers for GPIO 0 when the OS is not allowed to do that.
>>
> 
> I think that I might found the bug. if gpio-reserved-ranges was
> present the initialization was lost.
> 
> Can you try with v5
> 
> Thanks for your help

I'll let you know how it goes.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
