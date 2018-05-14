Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbeENLwd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:52:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:27204 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752856AbeENLw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:52:29 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,399,1520924400";
   d="gz'50?scan'50,208,50";a="50669926"
Date: Mon, 14 May 2018 19:51:29 +0800
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
Message-ID: <201805141858.BZEWcnnV%fengguang.wu@intel.com>
References: <20180514082146.4318-1-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20180514082146.4318-1-a.hajda@samsung.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andrzej,

I love your patch! Perhaps something to improve:

[auto build test WARNING on pm/linux-next]
[also build test WARNING on v4.17-rc5 next-20180511]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andrzej-Hajda/PM-core-refactor-PM_OPS-initializers/20180514-172201
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: openrisc-or1ksim_defconfig (attached as .config)
compiler: or1k-linux-gcc (GCC) 6.0.0 20160327 (experimental)
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=openrisc 

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:23:0,
                    from include/linux/cdev.h:8,
                    from include/linux/tty_driver.h:245,
                    from include/linux/tty.h:9,
                    from include/linux/serial_core.h:29,
                    from drivers/tty/serial/8250/8250_of.c:11:
   drivers/tty/serial/8250/8250_of.c:293:44: error: 'of_serial_suspend' undeclared here (not in a function)
    static SIMPLE_DEV_PM_OPS(of_serial_pm_ops, of_serial_suspend, of_serial_resume);
                                               ^
   include/linux/pm.h:316:59: note: in definition of macro 'PM_SLEEP_PTR'
    #define PM_SLEEP_PTR(ptr) (IS_ENABLED(CONFIG_PM_SLEEP) ? (ptr) : NULL)
                                                              ^~~
   include/linux/pm.h:354:2: note: in expansion of macro 'SET_SYSTEM_SLEEP_PM_OPS'
     SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
     ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/tty/serial/8250/8250_of.c:293:8: note: in expansion of macro 'SIMPLE_DEV_PM_OPS'
    static SIMPLE_DEV_PM_OPS(of_serial_pm_ops, of_serial_suspend, of_serial_resume);
           ^~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_of.c:293:63: error: 'of_serial_resume' undeclared here (not in a function)
    static SIMPLE_DEV_PM_OPS(of_serial_pm_ops, of_serial_suspend, of_serial_resume);
                                                                  ^
   include/linux/pm.h:316:59: note: in definition of macro 'PM_SLEEP_PTR'
    #define PM_SLEEP_PTR(ptr) (IS_ENABLED(CONFIG_PM_SLEEP) ? (ptr) : NULL)
                                                              ^~~
   include/linux/pm.h:354:2: note: in expansion of macro 'SET_SYSTEM_SLEEP_PM_OPS'
     SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
     ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/tty/serial/8250/8250_of.c:293:8: note: in expansion of macro 'SIMPLE_DEV_PM_OPS'
    static SIMPLE_DEV_PM_OPS(of_serial_pm_ops, of_serial_suspend, of_serial_resume);
           ^~~~~~~~~~~~~~~~~

vim +/SIMPLE_DEV_PM_OPS +293 drivers/tty/serial/8250/8250_of.c

8ad3b1352 drivers/tty/serial/of_serial.c    Jingchang Lu         2014-11-11  276  
aa42db44f drivers/tty/serial/8250/8250_of.c Arnd Bergmann        2017-01-25  277  static int of_serial_resume(struct device *dev)
8ad3b1352 drivers/tty/serial/of_serial.c    Jingchang Lu         2014-11-11  278  {
aa42db44f drivers/tty/serial/8250/8250_of.c Arnd Bergmann        2017-01-25  279  	struct of_serial_info *info = dev_get_drvdata(dev);
8ad3b1352 drivers/tty/serial/of_serial.c    Jingchang Lu         2014-11-11  280  	struct uart_8250_port *port8250 = serial8250_get_port(info->line);
8ad3b1352 drivers/tty/serial/of_serial.c    Jingchang Lu         2014-11-11  281  	struct uart_port *port = &port8250->port;
8ad3b1352 drivers/tty/serial/of_serial.c    Jingchang Lu         2014-11-11  282  
a2d23edae drivers/tty/serial/8250/8250_of.c Franklin S Cooper Jr 2017-08-16  283  	if (!uart_console(port) || console_suspend_enabled) {
a2d23edae drivers/tty/serial/8250/8250_of.c Franklin S Cooper Jr 2017-08-16  284  		pm_runtime_get_sync(dev);
8ad3b1352 drivers/tty/serial/of_serial.c    Jingchang Lu         2014-11-11  285  		clk_prepare_enable(info->clk);
a2d23edae drivers/tty/serial/8250/8250_of.c Franklin S Cooper Jr 2017-08-16  286  	}
8ad3b1352 drivers/tty/serial/of_serial.c    Jingchang Lu         2014-11-11  287  
8ad3b1352 drivers/tty/serial/of_serial.c    Jingchang Lu         2014-11-11  288  	serial8250_resume_port(info->line);
8ad3b1352 drivers/tty/serial/of_serial.c    Jingchang Lu         2014-11-11  289  
8ad3b1352 drivers/tty/serial/of_serial.c    Jingchang Lu         2014-11-11  290  	return 0;
8ad3b1352 drivers/tty/serial/of_serial.c    Jingchang Lu         2014-11-11  291  }
8ad3b1352 drivers/tty/serial/of_serial.c    Jingchang Lu         2014-11-11  292  #endif
8ad3b1352 drivers/tty/serial/of_serial.c    Jingchang Lu         2014-11-11 @293  static SIMPLE_DEV_PM_OPS(of_serial_pm_ops, of_serial_suspend, of_serial_resume);
8ad3b1352 drivers/tty/serial/of_serial.c    Jingchang Lu         2014-11-11  294  

:::::: The code at line 293 was first introduced by commit
:::::: 8ad3b1352693972b737607c7b9c89b56d45fea9b serial: of-serial: add PM suspend/resume support

:::::: TO: Jingchang Lu <jingchang.lu@freescale.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--EVF5PPMfhYS0aIcm
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
vhG8ISJuAAA=

--EVF5PPMfhYS0aIcm--
