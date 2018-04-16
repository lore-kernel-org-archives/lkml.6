Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753904AbeDPMyG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:54:06 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:33998 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752040AbeDPMyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:54:04 -0400
X-Google-Smtp-Source: AIpwx4/0zlgY6c7jaONClhMP4ql6d1Ok6ARfPWUNK9zvl9M9DkFUVzxc+HhoprwU4wVml8QaiW/6eQ==
Subject: Re: [PATCH 02/14] thermal: exynos: Propagate error value from
 tmu_read()
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
 <6993557.YT37RIp4lG@amdc3058>
 <22d7f063-9a69-78cf-e0fd-2043e187244e@linaro.org>
 <CGME20180416124956eucas1p17636602f59e7ad83088253ed369e7894@eucas1p1.samsung.com>
 <21168314.MLeXVVoknU@amdc3058>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4123d3bb-408f-b0c0-43c3-862e93f4907a@linaro.org>
Date: Mon, 16 Apr 2018 14:54:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <21168314.MLeXVVoknU@amdc3058>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2018 14:49, Bartlomiej Zolnierkiewicz wrote:
> On Monday, April 16, 2018 02:41:48 PM Daniel Lezcano wrote:
>> On 16/04/2018 14:35, Bartlomiej Zolnierkiewicz wrote:
>>> On Monday, April 16, 2018 02:16:56 PM Daniel Lezcano wrote:
>>>> On 16/04/2018 12:11, Bartlomiej Zolnierkiewicz wrote:
>>>>> From: Marek Szyprowski <m.szyprowski@samsung.com>
>>>>>
>>>>> tmu_read() in case of Exynos4210 might return error for out of bound
>>>>> values. Current code ignores such value, what leads to reporting critical
>>>>> temperature value. Add proper error code propagation to exynos_get_temp()
>>>>> function.
>>>>
>>>> For me the comment in the function exynos4210_tmu_read
>>>>
>>>> /* "temp_code" should range between 75 and 175 */
>>>>
>>>> ... is strange. I would double check this assertion before dealing with
>>>> the error value.
>>>
>>> static int exynos4210_tmu_read(struct exynos_tmu_data *data)
>>> {
>>> 	int ret = readb(data->base + EXYNOS_TMU_REG_CURRENT_TEMP);
>>>
>>> 	/* "temp_code" should range between 75 and 175 */
>>> 	return (ret < 75 || ret > 175) ? -ENODATA : ret;
>>> }
>>>
>>
>> But I don't get why it *should* ?
> 
> Because of hardware design.
> 
>> Shouldn't be the same with the 4412, it seems having the same sensor, no?
> 
> Probably same limitations apply to all SoCs (Exynos4412 has very similar
> sensor) but the driver currently lacks the needed checks for them (it is
> on TODO but other things have higher priority).


I understand. Why the other boards are not reporting a critical value?




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
