Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CEFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93CD21773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfBTFR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 00:17:59 -0500
Received: from mx.socionext.com ([202.248.49.38]:45868 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbfBTFR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 00:17:59 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 20 Feb 2019 14:17:56 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id E031F6117D;
        Wed, 20 Feb 2019 14:17:56 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 20 Feb 2019 14:17:56 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 7D5FB1A04E1;
        Wed, 20 Feb 2019 14:17:56 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 6B78D121B6C;
        Wed, 20 Feb 2019 14:17:56 +0900 (JST)
Subject: Re: [PATCH v2 04/15] ARM: milbeaut: Add basic support for Milbeaut
 m10v SoC
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
References: <1549628778-30785-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a026P7tZpJ7gsZbf_MnJJ0eVv60ggGXYndX9kCDLpNy4Q@mail.gmail.com>
 <7266af3b-aeec-4c29-c96e-ee0d21d3e867@socionext.com>
 <CAK8P3a09+K7ZPBgHs45Z2e_w6DPzXDMPT+DpXBowT0SBu8oCtw@mail.gmail.com>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <9979cb94-ce35-56de-df2e-33c10517ed77@socionext.com>
Date:   Wed, 20 Feb 2019 14:17:55 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a09+K7ZPBgHs45Z2e_w6DPzXDMPT+DpXBowT0SBu8oCtw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019/02/19 18:21, Arnd Bergmann wrote:
> On Tue, Feb 19, 2019 at 8:12 AM Sugaya, Taichi
> <sugaya.taichi@socionext.com> wrote:
>> On 2019/02/18 21:15, Arnd Bergmann wrote:
>>> On Fri, Feb 8, 2019 at 1:26 PM Sugaya Taichi
>>> <sugaya.taichi@socionext.com> wrote:
>>
>>>> +static int __init m10v_pm_init(void)
>>>> +{
>>>> +       suspend_set_ops(&m10v_pm_ops);
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +late_initcall(m10v_pm_init);
>>>
>>> This requires a check to ensure you are actually on the right platform,
>>> otherwise you break suspend/resume in a multiplatform kernel running
>>> on anything other than milbeaut.
>>>
>>
>> OK.
>> I think the solution is adding a "if statement with mlbeaut compatible"
>> above suspend_set_ops(&m10v_pm_ops).
> 
> Right, you can either use a call to of_machine_is_compatible(),
> or you add a machine descriptor with OF_MACHINE_START()
> and use this as the init_late() callback.
> 

Yeah, I will use "of_machine_is_compatible()".

Thanks,
Sugaya Taichi

>        Arnd
> 

