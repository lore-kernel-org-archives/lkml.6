Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753151AbeENLwb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:52:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:41568 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752543AbeENLw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:52:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,399,1520924400";
   d="gz'50?scan'50,208,50";a="228287248"
Date: Mon, 14 May 2018 19:51:48 +0800
From: kbuild test robot <lkp@intel.com>
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: kbuild-all@01.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] PM / core: refactor PM_OPS initializers
Message-ID: <201805141851.L6s8SuDq%fengguang.wu@intel.com>
References: <20180514082146.4318-1-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <20180514082146.4318-1-a.hajda@samsung.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andrzej,

I love your patch! Yet something to improve:

[auto build test ERROR on pm/linux-next]
[also build test ERROR on v4.17-rc5 next-20180511]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andrzej-Hajda/PM-core-refactor-PM_OPS-initializers/20180514-172201
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: ia64-defconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:23:0,
                    from include/linux/pci.h:31,
                    from drivers/net//ethernet/broadcom/tg3.c:33:
>> drivers/net//ethernet/broadcom/tg3.c:18150:38: error: 'tg3_suspend' undeclared here (not in a function); did you mean 'phy_suspend'?
    static SIMPLE_DEV_PM_OPS(tg3_pm_ops, tg3_suspend, tg3_resume);
                                         ^
   include/linux/pm.h:316:59: note: in definition of macro 'PM_SLEEP_PTR'
    #define PM_SLEEP_PTR(ptr) (IS_ENABLED(CONFIG_PM_SLEEP) ? (ptr) : NULL)
                                                              ^~~
   include/linux/pm.h:354:2: note: in expansion of macro 'SET_SYSTEM_SLEEP_PM_OPS'
     SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
     ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net//ethernet/broadcom/tg3.c:18150:8: note: in expansion of macro 'SIMPLE_DEV_PM_OPS'
    static SIMPLE_DEV_PM_OPS(tg3_pm_ops, tg3_suspend, tg3_resume);
           ^~~~~~~~~~~~~~~~~
>> drivers/net//ethernet/broadcom/tg3.c:18150:51: error: 'tg3_resume' undeclared here (not in a function); did you mean 'phy_resume'?
    static SIMPLE_DEV_PM_OPS(tg3_pm_ops, tg3_suspend, tg3_resume);
                                                      ^
   include/linux/pm.h:316:59: note: in definition of macro 'PM_SLEEP_PTR'
    #define PM_SLEEP_PTR(ptr) (IS_ENABLED(CONFIG_PM_SLEEP) ? (ptr) : NULL)
                                                              ^~~
   include/linux/pm.h:354:2: note: in expansion of macro 'SET_SYSTEM_SLEEP_PM_OPS'
     SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
     ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net//ethernet/broadcom/tg3.c:18150:8: note: in expansion of macro 'SIMPLE_DEV_PM_OPS'
    static SIMPLE_DEV_PM_OPS(tg3_pm_ops, tg3_suspend, tg3_resume);
           ^~~~~~~~~~~~~~~~~
--
   In file included from include/linux/device.h:23:0,
                    from drivers/video//backlight/backlight.c:12:
>> drivers/video//backlight/backlight.c:280:54: error: 'backlight_suspend' undeclared here (not in a function); did you mean 'backlight_types'?
    static SIMPLE_DEV_PM_OPS(backlight_class_dev_pm_ops, backlight_suspend,
                                                         ^
   include/linux/pm.h:316:59: note: in definition of macro 'PM_SLEEP_PTR'
    #define PM_SLEEP_PTR(ptr) (IS_ENABLED(CONFIG_PM_SLEEP) ? (ptr) : NULL)
                                                              ^~~
   include/linux/pm.h:354:2: note: in expansion of macro 'SET_SYSTEM_SLEEP_PM_OPS'
     SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
     ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/video//backlight/backlight.c:280:8: note: in expansion of macro 'SIMPLE_DEV_PM_OPS'
    static SIMPLE_DEV_PM_OPS(backlight_class_dev_pm_ops, backlight_suspend,
           ^~~~~~~~~~~~~~~~~
>> drivers/video//backlight/backlight.c:281:5: error: 'backlight_resume' undeclared here (not in a function); did you mean 'backlight_device'?
        backlight_resume);
        ^
   include/linux/pm.h:316:59: note: in definition of macro 'PM_SLEEP_PTR'
    #define PM_SLEEP_PTR(ptr) (IS_ENABLED(CONFIG_PM_SLEEP) ? (ptr) : NULL)
                                                              ^~~
   include/linux/pm.h:354:2: note: in expansion of macro 'SET_SYSTEM_SLEEP_PM_OPS'
     SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
     ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/video//backlight/backlight.c:280:8: note: in expansion of macro 'SIMPLE_DEV_PM_OPS'
    static SIMPLE_DEV_PM_OPS(backlight_class_dev_pm_ops, backlight_suspend,
           ^~~~~~~~~~~~~~~~~

vim +18150 drivers/net//ethernet/broadcom/tg3.c

^1da177e drivers/net/tg3.c Linus Torvalds    2005-04-16  18149  
c866b7ea drivers/net/tg3.c Rafael J. Wysocki 2010-12-25 @18150  static SIMPLE_DEV_PM_OPS(tg3_pm_ops, tg3_suspend, tg3_resume);
c866b7ea drivers/net/tg3.c Rafael J. Wysocki 2010-12-25  18151  

:::::: The code at line 18150 was first introduced by commit
:::::: c866b7eac073198cef03ea6bac2dc978635a9f5c tg3: Do not use legacy PCI power management

:::::: TO: Rafael J. Wysocki <rjw@sisk.pl>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--Q68bSM7Ycu6FN28Q
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
tvj/uGq0wBomAQA=

--Q68bSM7Ycu6FN28Q--
