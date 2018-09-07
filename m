Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24005C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D7620861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D7620861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbeIGMuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:50:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:25189 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbeIGMuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:50:35 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 01:10:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,341,1531810800"; 
   d="gz'50?scan'50,208,50";a="87969834"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by fmsmga001.fm.intel.com with ESMTP; 07 Sep 2018 01:10:13 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fyBq7-000ABw-RH; Fri, 07 Sep 2018 16:10:03 +0800
Date:   Fri, 7 Sep 2018 16:10:04 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Peter Wu <peter@lekensteyn.nl>
Cc:     kbuild-all@01.org, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] bochs: convert to drm_fb_helper_fbdev_setup/teardown
Message-ID: <201809071601.PLeDWI6u%fengguang.wu@intel.com>
References: <20180905144127.5690-1-peter@lekensteyn.nl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20180905144127.5690-1-peter@lekensteyn.nl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Peter,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.19-rc2 next-20180906]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Peter-Wu/bochs-convert-to-drm_fb_helper_fbdev_setup-teardown/20180907-154819
config: i386-randconfig-x006-201835 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:5:0,
                    from arch/x86/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from drivers/gpu/drm/bochs/bochs_drv.c:8:
   drivers/gpu/drm/bochs/bochs_drv.c: In function 'bochs_pm_suspend':
   drivers/gpu/drm/bochs/bochs_drv.c:110:15: error: 'struct <anonymous>' has no member named 'initialized'
     if (bochs->fb.initialized) {
                  ^
   include/linux/compiler.h:58:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
>> drivers/gpu/drm/bochs/bochs_drv.c:110:2: note: in expansion of macro 'if'
     if (bochs->fb.initialized) {
     ^~
   drivers/gpu/drm/bochs/bochs_drv.c:110:15: error: 'struct <anonymous>' has no member named 'initialized'
     if (bochs->fb.initialized) {
                  ^
   include/linux/compiler.h:58:42: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                             ^~~~
>> drivers/gpu/drm/bochs/bochs_drv.c:110:2: note: in expansion of macro 'if'
     if (bochs->fb.initialized) {
     ^~
   drivers/gpu/drm/bochs/bochs_drv.c:110:15: error: 'struct <anonymous>' has no member named 'initialized'
     if (bochs->fb.initialized) {
                  ^
   include/linux/compiler.h:69:16: note: in definition of macro '__trace_if'
      ______r = !!(cond);     \
                   ^~~~
>> drivers/gpu/drm/bochs/bochs_drv.c:110:2: note: in expansion of macro 'if'
     if (bochs->fb.initialized) {
     ^~
   drivers/gpu/drm/bochs/bochs_drv.c: In function 'bochs_pm_resume':
   drivers/gpu/drm/bochs/bochs_drv.c:127:15: error: 'struct <anonymous>' has no member named 'initialized'
     if (bochs->fb.initialized) {
                  ^
   include/linux/compiler.h:58:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
   drivers/gpu/drm/bochs/bochs_drv.c:127:2: note: in expansion of macro 'if'
     if (bochs->fb.initialized) {
     ^~
   drivers/gpu/drm/bochs/bochs_drv.c:127:15: error: 'struct <anonymous>' has no member named 'initialized'
     if (bochs->fb.initialized) {
                  ^
   include/linux/compiler.h:58:42: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                             ^~~~
   drivers/gpu/drm/bochs/bochs_drv.c:127:2: note: in expansion of macro 'if'
     if (bochs->fb.initialized) {
     ^~
   drivers/gpu/drm/bochs/bochs_drv.c:127:15: error: 'struct <anonymous>' has no member named 'initialized'
     if (bochs->fb.initialized) {
                  ^
   include/linux/compiler.h:69:16: note: in definition of macro '__trace_if'
      ______r = !!(cond);     \
                   ^~~~
   drivers/gpu/drm/bochs/bochs_drv.c:127:2: note: in expansion of macro 'if'
     if (bochs->fb.initialized) {
     ^~

vim +/if +110 drivers/gpu/drm/bochs/bochs_drv.c

0a6659bd Gerd Hoffmann           2013-12-17   @8  #include <linux/mm.h>
0a6659bd Gerd Hoffmann           2013-12-17    9  #include <linux/module.h>
0a6659bd Gerd Hoffmann           2013-12-17   10  #include <linux/slab.h>
44adece5 Daniel Vetter           2016-08-10   11  #include <drm/drm_fb_helper.h>
0a6659bd Gerd Hoffmann           2013-12-17   12  
0a6659bd Gerd Hoffmann           2013-12-17   13  #include "bochs.h"
0a6659bd Gerd Hoffmann           2013-12-17   14  
1acf5661 Max Staudt              2017-01-18   15  static int bochs_modeset = -1;
1acf5661 Max Staudt              2017-01-18   16  module_param_named(modeset, bochs_modeset, int, 0444);
1acf5661 Max Staudt              2017-01-18   17  MODULE_PARM_DESC(modeset, "enable/disable kernel modesetting");
1acf5661 Max Staudt              2017-01-18   18  
0a6659bd Gerd Hoffmann           2013-12-17   19  static bool enable_fbdev = true;
0a6659bd Gerd Hoffmann           2013-12-17   20  module_param_named(fbdev, enable_fbdev, bool, 0444);
0a6659bd Gerd Hoffmann           2013-12-17   21  MODULE_PARM_DESC(fbdev, "register fbdev device");
0a6659bd Gerd Hoffmann           2013-12-17   22  
0a6659bd Gerd Hoffmann           2013-12-17   23  /* ---------------------------------------------------------------------- */
0a6659bd Gerd Hoffmann           2013-12-17   24  /* drm interface                                                          */
0a6659bd Gerd Hoffmann           2013-12-17   25  
11b3c20b Gabriel Krisman Bertazi 2017-01-06   26  static void bochs_unload(struct drm_device *dev)
0a6659bd Gerd Hoffmann           2013-12-17   27  {
0a6659bd Gerd Hoffmann           2013-12-17   28  	struct bochs_device *bochs = dev->dev_private;
0a6659bd Gerd Hoffmann           2013-12-17   29  
0a6659bd Gerd Hoffmann           2013-12-17   30  	bochs_fbdev_fini(bochs);
0a6659bd Gerd Hoffmann           2013-12-17   31  	bochs_kms_fini(bochs);
0a6659bd Gerd Hoffmann           2013-12-17   32  	bochs_mm_fini(bochs);
0a6659bd Gerd Hoffmann           2013-12-17   33  	bochs_hw_fini(dev);
0a6659bd Gerd Hoffmann           2013-12-17   34  	kfree(bochs);
0a6659bd Gerd Hoffmann           2013-12-17   35  	dev->dev_private = NULL;
0a6659bd Gerd Hoffmann           2013-12-17   36  }
0a6659bd Gerd Hoffmann           2013-12-17   37  
0a6659bd Gerd Hoffmann           2013-12-17   38  static int bochs_load(struct drm_device *dev, unsigned long flags)
0a6659bd Gerd Hoffmann           2013-12-17   39  {
0a6659bd Gerd Hoffmann           2013-12-17   40  	struct bochs_device *bochs;
0a6659bd Gerd Hoffmann           2013-12-17   41  	int ret;
0a6659bd Gerd Hoffmann           2013-12-17   42  
0a6659bd Gerd Hoffmann           2013-12-17   43  	bochs = kzalloc(sizeof(*bochs), GFP_KERNEL);
0a6659bd Gerd Hoffmann           2013-12-17   44  	if (bochs == NULL)
0a6659bd Gerd Hoffmann           2013-12-17   45  		return -ENOMEM;
0a6659bd Gerd Hoffmann           2013-12-17   46  	dev->dev_private = bochs;
0a6659bd Gerd Hoffmann           2013-12-17   47  	bochs->dev = dev;
0a6659bd Gerd Hoffmann           2013-12-17   48  
0a6659bd Gerd Hoffmann           2013-12-17   49  	ret = bochs_hw_init(dev, flags);
0a6659bd Gerd Hoffmann           2013-12-17   50  	if (ret)
0a6659bd Gerd Hoffmann           2013-12-17   51  		goto err;
0a6659bd Gerd Hoffmann           2013-12-17   52  
0a6659bd Gerd Hoffmann           2013-12-17   53  	ret = bochs_mm_init(bochs);
0a6659bd Gerd Hoffmann           2013-12-17   54  	if (ret)
0a6659bd Gerd Hoffmann           2013-12-17   55  		goto err;
0a6659bd Gerd Hoffmann           2013-12-17   56  
0a6659bd Gerd Hoffmann           2013-12-17   57  	ret = bochs_kms_init(bochs);
0a6659bd Gerd Hoffmann           2013-12-17   58  	if (ret)
0a6659bd Gerd Hoffmann           2013-12-17   59  		goto err;
0a6659bd Gerd Hoffmann           2013-12-17   60  
0a6659bd Gerd Hoffmann           2013-12-17   61  	if (enable_fbdev)
0a6659bd Gerd Hoffmann           2013-12-17   62  		bochs_fbdev_init(bochs);
0a6659bd Gerd Hoffmann           2013-12-17   63  
0a6659bd Gerd Hoffmann           2013-12-17   64  	return 0;
0a6659bd Gerd Hoffmann           2013-12-17   65  
0a6659bd Gerd Hoffmann           2013-12-17   66  err:
0a6659bd Gerd Hoffmann           2013-12-17   67  	bochs_unload(dev);
0a6659bd Gerd Hoffmann           2013-12-17   68  	return ret;
0a6659bd Gerd Hoffmann           2013-12-17   69  }
0a6659bd Gerd Hoffmann           2013-12-17   70  
0a6659bd Gerd Hoffmann           2013-12-17   71  static const struct file_operations bochs_fops = {
0a6659bd Gerd Hoffmann           2013-12-17   72  	.owner		= THIS_MODULE,
0a6659bd Gerd Hoffmann           2013-12-17   73  	.open		= drm_open,
0a6659bd Gerd Hoffmann           2013-12-17   74  	.release	= drm_release,
0a6659bd Gerd Hoffmann           2013-12-17   75  	.unlocked_ioctl	= drm_ioctl,
0a6659bd Gerd Hoffmann           2013-12-17   76  	.compat_ioctl	= drm_compat_ioctl,
0a6659bd Gerd Hoffmann           2013-12-17   77  	.poll		= drm_poll,
0a6659bd Gerd Hoffmann           2013-12-17   78  	.read		= drm_read,
0a6659bd Gerd Hoffmann           2013-12-17   79  	.llseek		= no_llseek,
0a6659bd Gerd Hoffmann           2013-12-17   80  	.mmap           = bochs_mmap,
0a6659bd Gerd Hoffmann           2013-12-17   81  };
0a6659bd Gerd Hoffmann           2013-12-17   82  
0a6659bd Gerd Hoffmann           2013-12-17   83  static struct drm_driver bochs_driver = {
0a6659bd Gerd Hoffmann           2013-12-17   84  	.driver_features	= DRIVER_GEM | DRIVER_MODESET,
0a6659bd Gerd Hoffmann           2013-12-17   85  	.load			= bochs_load,
0a6659bd Gerd Hoffmann           2013-12-17   86  	.unload			= bochs_unload,
0a6659bd Gerd Hoffmann           2013-12-17   87  	.fops			= &bochs_fops,
0a6659bd Gerd Hoffmann           2013-12-17   88  	.name			= "bochs-drm",
0a6659bd Gerd Hoffmann           2013-12-17   89  	.desc			= "bochs dispi vga interface (qemu stdvga)",
0a6659bd Gerd Hoffmann           2013-12-17   90  	.date			= "20130925",
0a6659bd Gerd Hoffmann           2013-12-17   91  	.major			= 1,
0a6659bd Gerd Hoffmann           2013-12-17   92  	.minor			= 0,
6f2c1c15 Daniel Vetter           2016-05-30   93  	.gem_free_object_unlocked = bochs_gem_free_object,
0a6659bd Gerd Hoffmann           2013-12-17   94  	.dumb_create            = bochs_dumb_create,
0a6659bd Gerd Hoffmann           2013-12-17   95  	.dumb_map_offset        = bochs_dumb_mmap_offset,
0a6659bd Gerd Hoffmann           2013-12-17   96  };
0a6659bd Gerd Hoffmann           2013-12-17   97  
0a6659bd Gerd Hoffmann           2013-12-17   98  /* ---------------------------------------------------------------------- */
b8ccd70f Gerd Hoffmann           2014-04-14   99  /* pm interface                                                           */
b8ccd70f Gerd Hoffmann           2014-04-14  100  
150cee9c Russell King            2014-07-12  101  #ifdef CONFIG_PM_SLEEP
b8ccd70f Gerd Hoffmann           2014-04-14  102  static int bochs_pm_suspend(struct device *dev)
b8ccd70f Gerd Hoffmann           2014-04-14  103  {
b8ccd70f Gerd Hoffmann           2014-04-14  104  	struct pci_dev *pdev = to_pci_dev(dev);
b8ccd70f Gerd Hoffmann           2014-04-14  105  	struct drm_device *drm_dev = pci_get_drvdata(pdev);
b8ccd70f Gerd Hoffmann           2014-04-14  106  	struct bochs_device *bochs = drm_dev->dev_private;
b8ccd70f Gerd Hoffmann           2014-04-14  107  
b8ccd70f Gerd Hoffmann           2014-04-14  108  	drm_kms_helper_poll_disable(drm_dev);
b8ccd70f Gerd Hoffmann           2014-04-14  109  
b8ccd70f Gerd Hoffmann           2014-04-14 @110  	if (bochs->fb.initialized) {
b8ccd70f Gerd Hoffmann           2014-04-14  111  		console_lock();
6a752972 Archit Taneja           2015-07-31  112  		drm_fb_helper_set_suspend(&bochs->fb.helper, 1);
b8ccd70f Gerd Hoffmann           2014-04-14  113  		console_unlock();
b8ccd70f Gerd Hoffmann           2014-04-14  114  	}
b8ccd70f Gerd Hoffmann           2014-04-14  115  
b8ccd70f Gerd Hoffmann           2014-04-14  116  	return 0;
b8ccd70f Gerd Hoffmann           2014-04-14  117  }
b8ccd70f Gerd Hoffmann           2014-04-14  118  

:::::: The code at line 110 was first introduced by commit
:::::: b8ccd70f1363f7d4e49219dbc46ec973a14f49cd drm: bochs: add power management support

:::::: TO: Gerd Hoffmann <kraxel@redhat.com>
:::::: CC: Dave Airlie <airlied@redhat.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--EeQfGwPcQSOJBaQU
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--EeQfGwPcQSOJBaQU--
