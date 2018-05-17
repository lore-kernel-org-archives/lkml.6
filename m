Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752259AbeEQIKq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 04:10:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:61384 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751647AbeEQIKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 04:10:44 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,390,1520924400";
   d="gz'50?scan'50,208,50";a="229247925"
Date: Thu, 17 May 2018 16:10:21 +0800
From: kbuild test robot <lkp@intel.com>
To: Florian Schmaus <flo@geekplace.eu>
Cc: kbuild-all@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Schmaus <flo@geekplace.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] driver-core: print bus registration error value
Message-ID: <201805171606.KSJpzg5g%fengguang.wu@intel.com>
References: <20180516120527.29403-4-flo@geekplace.eu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <20180516120527.29403-4-flo@geekplace.eu>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Florian,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on v4.17-rc5 next-20180516]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Florian-Schmaus/return-EINVAL-error-instead-of-BUG_ON/20180517-145147
config: x86_64-randconfig-x002-201819 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:7:0,
                    from include/linux/kernel.h:14,
                    from include/linux/list.h:9,
                    from include/linux/kobject.h:19,
                    from include/linux/device.h:16,
                    from drivers/base/driver.c:11:
   drivers/base/driver.c: In function 'driver_register':
>> include/linux/kern_levels.h:5:18: warning: too many arguments for format [-Wformat-extra-args]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
    #define KERN_ERR KERN_SOH "3" /* error conditions */
                     ^~~~~~~~
>> include/linux/printk.h:304:9: note: in expansion of macro 'KERN_ERR'
     printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~
>> drivers/base/driver.c:153:4: note: in expansion of macro 'pr_err'
       pr_err("Driver '%s' was unable to register with bus_type '%s'",
       ^~~~~~
>> include/linux/kern_levels.h:5:18: warning: too many arguments for format [-Wformat-extra-args]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
    #define KERN_ERR KERN_SOH "3" /* error conditions */
                     ^~~~~~~~
>> include/linux/printk.h:304:9: note: in expansion of macro 'KERN_ERR'
     printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~
   drivers/base/driver.c:158:4: note: in expansion of macro 'pr_err'
       pr_err("Driver '%s' was unable to register with bus_type '%s'",
       ^~~~~~
--
   In file included from include/linux/printk.h:7:0,
                    from include/linux/kernel.h:14,
                    from include/linux/list.h:9,
                    from include/linux/kobject.h:19,
                    from include/linux/device.h:16,
                    from drivers//base/driver.c:11:
   drivers//base/driver.c: In function 'driver_register':
>> include/linux/kern_levels.h:5:18: warning: too many arguments for format [-Wformat-extra-args]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
    #define KERN_ERR KERN_SOH "3" /* error conditions */
                     ^~~~~~~~
>> include/linux/printk.h:304:9: note: in expansion of macro 'KERN_ERR'
     printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~
   drivers//base/driver.c:153:4: note: in expansion of macro 'pr_err'
       pr_err("Driver '%s' was unable to register with bus_type '%s'",
       ^~~~~~
>> include/linux/kern_levels.h:5:18: warning: too many arguments for format [-Wformat-extra-args]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
    #define KERN_ERR KERN_SOH "3" /* error conditions */
                     ^~~~~~~~
>> include/linux/printk.h:304:9: note: in expansion of macro 'KERN_ERR'
     printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~
   drivers//base/driver.c:158:4: note: in expansion of macro 'pr_err'
       pr_err("Driver '%s' was unable to register with bus_type '%s'",
       ^~~~~~

vim +/pr_err +153 drivers/base/driver.c

   137	
   138	/**
   139	 * driver_register - register driver with bus
   140	 * @drv: driver to register
   141	 *
   142	 * We pass off most of the work to the bus_add_driver() call,
   143	 * since most of the things we have to do deal with the bus
   144	 * structures.
   145	 */
   146	int driver_register(struct device_driver *drv)
   147	{
   148		int ret;
   149		struct device_driver *other;
   150	
   151		if (!drv->bus->p) {
   152			if (drv->bus->bus_register_error) {
 > 153				pr_err("Driver '%s' was unable to register with bus_type '%s'",
   154					   " (error: %d).\n",
   155					   drv->name, drv->bus->name,
   156					   drv->bus->bus_register_error);
   157			} else {
   158				pr_err("Driver '%s' was unable to register with bus_type '%s'",
   159					   " because it was not initialized.\n",
   160					   drv->name, drv->bus->name);
   161			}
   162			return -EINVAL;
   163		}
   164	
   165		if ((drv->bus->probe && drv->probe) ||
   166		    (drv->bus->remove && drv->remove) ||
   167		    (drv->bus->shutdown && drv->shutdown))
   168			printk(KERN_WARNING "Driver '%s' needs updating - please use "
   169				"bus_type methods\n", drv->name);
   170	
   171		other = driver_find(drv->name, drv->bus);
   172		if (other) {
   173			printk(KERN_ERR "Error: Driver '%s' is already registered, "
   174				"aborting...\n", drv->name);
   175			return -EBUSY;
   176		}
   177	
   178		ret = bus_add_driver(drv);
   179		if (ret)
   180			return ret;
   181		ret = driver_add_groups(drv, drv->groups);
   182		if (ret) {
   183			bus_remove_driver(drv);
   184			return ret;
   185		}
   186		kobject_uevent(&drv->p->kobj, KOBJ_ADD);
   187	
   188		return ret;
   189	}
   190	EXPORT_SYMBOL_GPL(driver_register);
   191	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--ibTvN161/egqYuK8
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ibTvN161/egqYuK8--
