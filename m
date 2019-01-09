Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD0CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7231214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbfAIJP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:15:58 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33402 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729715AbfAIJP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:15:58 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 3B269270B0C
Subject: Re: [PATCH v5 0/7] mfd / platform: cros_ec: move cros_ec sysfs
 attributes to its own drivers.
To:     Lee Jones <lee.jones@linaro.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Benson Leung <bleung@chromium.org>
References: <20181212173402.27086-1-enric.balletbo@collabora.com>
 <20181221091001.GA13248@dell>
 <CAFqH_51mrsb=cBOeBL0avyYGogZ-MtMUpKUS7avXGT9Q2JmWHw@mail.gmail.com>
 <20190109072556.GD27286@dell>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <35c8fe0c-7986-f306-c888-7571f6f23b44@collabora.com>
Date:   Wed, 9 Jan 2019 10:15:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190109072556.GD27286@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 9/1/19 8:25, Lee Jones wrote:
> On Tue, 08 Jan 2019, Enric Balletbo Serra wrote:
>> Missatge de Lee Jones <lee.jones@linaro.org> del dia dv., 21 de des.
>> 2018 a les 16:39:
>>>
>>> On Wed, 12 Dec 2018, Enric Balletbo i Serra wrote:
>>>
>>>> Hi,
>>>>
>>>> This is another patchset to try to cleanup a bit more the crossed
>>>> references for cros-ec driver between the MFD and the platform/chrome
>>>> subsystems.
>>>>
>>>> The purpose of these patches is get rid of the different cros-ec attributes
>>>> from mfd/cros_ec_dev to its own sub-driver in platform/chrome. cros_ec_dev
>>>> continues instantiating the sub-devices but the sysfs attributes are owned
>>>> by the platform driver.E.g. The lightbar driver should own his sysfs
>>>> attributes and be instantiated only if the Embedded Controller has a
>>>> lightbar.
>>>>
>>>> The patchset also adds the documentation of the sysfs attributes.
>>>>
>>>> Most of the patches touches mfd subsystem and platform/chrome so I'd
>>>> suggest go all using and inmutable branch.
>>>
>>> That's fine.
>>>
>>> What else needs to happen with this set?
>>
>> I think the patchset is ready to be queued. Note that to apply cleanly
>> it depends on [1] which is already merged in your for-next branch.
>> What do you prefer, go through your repo or go through the
>> chrome-platform repo? Do you want Benson or I create an immutable
>> branch? I'm fine with whenever you decide.
> 
> Probably best if this goes through the MFD tree.
> 

Sounds good to me, thanks
 Enric

> I have a PR pending upstream at the moment.  Once I know what is
> happening with that, I'll start taking patches/sets again.
> 
>> [1]
>> https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/commit/?h=for-mfd-next&id=18e294ddafaeb80a1e2e10c9bd750a6cb8388d5b
>>
>>> Any more Acks required?
>>>
>>
>> I think that you, Guenter, Benson and I are fine with it, so not more
>> acks needed.
> 
> Thanks for the clarification.
> 
