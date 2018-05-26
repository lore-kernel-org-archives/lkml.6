Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031674AbeEZJ6v (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 05:58:51 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51439 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031487AbeEZJ6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 05:58:50 -0400
X-Google-Smtp-Source: ADUXVKIiyEONxgjtVM8XDrnP+uCHY+aACB4RZcNi/NB0HUIZ+h4Q+4/Aj+IMIp87q4+KcyeCV/m0MA==
Subject: Re: [PATCH 2/6] mfd: da9063: Replace model with type
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
References: <20180523114230.10109-2-marek.vasut+renesas@gmail.com>
 <201805261713.OJMLXvlB%fengguang.wu@intel.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <fca2a629-e5e8-6ef8-7e7d-d25353ab4c3e@gmail.com>
Date: Sat, 26 May 2018 11:58:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <201805261713.OJMLXvlB%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/26/2018 11:16 AM, kbuild test robot wrote:
> Hi Marek,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on ljones-mfd/for-mfd-next]
> [also build test WARNING on v4.17-rc6]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Marek-Vasut/mfd-da9063-Rename-PMIC_DA9063-to-PMIC_CHIP_ID_DA9063/20180526-162613
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
> config: x86_64-randconfig-x002-201820 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/kernel.h:10:0,
>                     from drivers//regulator/da9063-regulator.c:16:
>    drivers//regulator/da9063-regulator.c: In function 'da9063_regulator_probe':
>    drivers//regulator/da9063-regulator.c:744:12: error: 'const struct da9063_dev_model' has no member named 'dev_model'
>       if (model->dev_model == da9063->type)
>                ^
>    include/linux/compiler.h:58:30: note: in definition of macro '__trace_if'
>      if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
>                                  ^~~~
>>> drivers//regulator/da9063-regulator.c:744:3: note: in expansion of macro 'if'
>       if (model->dev_model == da9063->type)
>       ^~
>    drivers//regulator/da9063-regulator.c:744:12: error: 'const struct da9063_dev_model' has no member named 'dev_model'
>       if (model->dev_model == da9063->type)
>                ^
>    include/linux/compiler.h:58:42: note: in definition of macro '__trace_if'
>      if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
>                                              ^~~~
>>> drivers//regulator/da9063-regulator.c:744:3: note: in expansion of macro 'if'
>       if (model->dev_model == da9063->type)
>       ^~
>    drivers//regulator/da9063-regulator.c:744:12: error: 'const struct da9063_dev_model' has no member named 'dev_model'
>       if (model->dev_model == da9063->type)
>                ^
>    include/linux/compiler.h:69:16: note: in definition of macro '__trace_if'
>       ______r = !!(cond);     \
>                    ^~~~
>>> drivers//regulator/da9063-regulator.c:744:3: note: in expansion of macro 'if'
>       if (model->dev_model == da9063->type)
>       ^~
>    drivers//regulator/da9063-regulator.c:749:10: error: 'struct da9063' has no member named 'model'
>        da9063->model);
>              ^~
> 
> vim +/if +744 drivers//regulator/da9063-regulator.c

Is it testing this patch without the other patches in the series or at
least 1/6 ?

-- 
Best regards,
Marek Vasut
