Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752269AbeC0MSo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 08:18:44 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54831 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbeC0MSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 08:18:41 -0400
X-Google-Smtp-Source: AIpwx487TwQf2pUfqKb1Myqvmquy4hYcntICUzayNr3zTM7+g7Vm1n6gEo39AnVamPuXmONwWj5uNA==
Date: Tue, 27 Mar 2018 13:18:38 +0100
From: Lee Jones <lee.jones@linaro.org>
To: kbuild test robot <lkp@intel.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>, kbuild-all@01.org,
        linus.walleij@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, patches@opensource.cirrus.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 8/9] pinctrl: madera: Add driver for Cirrus Logic
 Madera codecs
Message-ID: <20180327121838.y3wcovp3vng35zw4@dell>
References: <20180313131904.13700-9-rf@opensource.cirrus.com>
 <201803221928.QinIS1e5%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201803221928.QinIS1e5%fengguang.wu@intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2018, kbuild test robot wrote:

> Hi Richard,
> 
> I love your patch! Yet something to improve:

Looking to apply this set soon.

I guess this needs fixing first though?

> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.16-rc6 next-20180322]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Richard-Fitzgerald/mfd-madera-Add-register-definitions-for-Cirrus-Logic-Madera-codecs/20180314-211822
> config: i386-randconfig-x010-03221515 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/pinctrl/cirrus/pinctrl-madera-core.c:561:20: error: 'pinconf_generic_dt_node_to_map_all' undeclared here (not in a function); did you mean 'pinconf_generic_params'?
>      .dt_node_to_map = pinconf_generic_dt_node_to_map_all,
>                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                        pinconf_generic_params
> 
> vim +561 drivers/pinctrl/cirrus/pinctrl-madera-core.c
> 
>    555	
>    556	
>    557	static const struct pinctrl_ops madera_pin_group_ops = {
>    558		.get_groups_count = madera_get_groups_count,
>    559		.get_group_name = madera_get_group_name,
>    560		.get_group_pins = madera_get_group_pins,
>  > 561		.dt_node_to_map = pinconf_generic_dt_node_to_map_all,
>    562		.dt_free_map = pinctrl_utils_free_map,
>    563	#if IS_ENABLED(CONFIG_DEBUG_FS)
>    564		.pin_dbg_show = madera_pin_dbg_show,
>    565	#endif
>    566	};
>    567	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
