Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbeE3LBj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:01:39 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50306 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752464AbeE3LBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:01:35 -0400
X-Google-Smtp-Source: ADUXVKJa4DZq3+ryqgb/+AvMRcyo8pqq+5yW84DrUJZuK8GQRzzlt9lyHGAA06YYAmHQU4pdnGRHlA==
Subject: Re: [PATCH 2/6] mfd: da9063: Replace model with type
To: Ye Xiaolong <xiaolong.ye@intel.com>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
References: <20180523114230.10109-2-marek.vasut+renesas@gmail.com>
 <201805261713.OJMLXvlB%fengguang.wu@intel.com>
 <fca2a629-e5e8-6ef8-7e7d-d25353ab4c3e@gmail.com>
 <20180530052110.GB27396@yexl-desktop>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <7db6e995-70db-8bdf-e425-14c52e2592ea@gmail.com>
Date: Wed, 30 May 2018 12:45:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180530052110.GB27396@yexl-desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/30/2018 07:21 AM, Ye Xiaolong wrote:
> Hi, Marek
> 
> On 05/26, Marek Vasut wrote:
>> On 05/26/2018 11:16 AM, kbuild test robot wrote:
>>> Hi Marek,
>>>
>>> I love your patch! Perhaps something to improve:
>>>
>>> [auto build test WARNING on ljones-mfd/for-mfd-next]
>>> [also build test WARNING on v4.17-rc6]
>>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>>
>>> url:    https://github.com/0day-ci/linux/commits/Marek-Vasut/mfd-da9063-Rename-PMIC_DA9063-to-PMIC_CHIP_ID_DA9063/20180526-162613
>>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
>>> config: x86_64-randconfig-x002-201820 (attached as .config)
>>> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
>>> reproduce:
>>>         # save the attached .config to linux build tree
>>>         make ARCH=x86_64 
>>>
>>> All warnings (new ones prefixed by >>):
>>>
>>>    In file included from include/linux/kernel.h:10:0,
>>>                     from drivers//regulator/da9063-regulator.c:16:
>>>    drivers//regulator/da9063-regulator.c: In function 'da9063_regulator_probe':
>>>    drivers//regulator/da9063-regulator.c:744:12: error: 'const struct da9063_dev_model' has no member named 'dev_model'
>>>       if (model->dev_model == da9063->type)
>>>                ^
>>>    include/linux/compiler.h:58:30: note: in definition of macro '__trace_if'
>>>      if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
>>>                                  ^~~~
>>>>> drivers//regulator/da9063-regulator.c:744:3: note: in expansion of macro 'if'
>>>       if (model->dev_model == da9063->type)
>>>       ^~
>>>    drivers//regulator/da9063-regulator.c:744:12: error: 'const struct da9063_dev_model' has no member named 'dev_model'
>>>       if (model->dev_model == da9063->type)
>>>                ^
>>>    include/linux/compiler.h:58:42: note: in definition of macro '__trace_if'
>>>      if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
>>>                                              ^~~~
>>>>> drivers//regulator/da9063-regulator.c:744:3: note: in expansion of macro 'if'
>>>       if (model->dev_model == da9063->type)
>>>       ^~
>>>    drivers//regulator/da9063-regulator.c:744:12: error: 'const struct da9063_dev_model' has no member named 'dev_model'
>>>       if (model->dev_model == da9063->type)
>>>                ^
>>>    include/linux/compiler.h:69:16: note: in definition of macro '__trace_if'
>>>       ______r = !!(cond);     \
>>>                    ^~~~
>>>>> drivers//regulator/da9063-regulator.c:744:3: note: in expansion of macro 'if'
>>>       if (model->dev_model == da9063->type)
>>>       ^~
>>>    drivers//regulator/da9063-regulator.c:749:10: error: 'struct da9063' has no member named 'model'
>>>        da9063->model);
>>>              ^~
>>>
>>> vim +/if +744 drivers//regulator/da9063-regulator.c
>>
>> Is it testing this patch without the other patches in the series or at
>> least 1/6 ?
> 
> It was tested with the whole patch series as you can see in https://github.com/0day-ci/linux/commits/Marek-Vasut/mfd-da9063-Rename-PMIC_DA9063-to-PMIC_CHIP_ID_DA9063/20180526-162613.

Ha, I see the problem. Thanks for confirming it's checked with the whole
series.

-- 
Best regards,
Marek Vasut
