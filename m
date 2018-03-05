Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbeCEPVH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:21:07 -0500
Received: from mga05.intel.com ([192.55.52.43]:27876 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751144AbeCEPVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:21:04 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="31498688"
Date: Mon, 5 Mar 2018 23:20:14 +0800
From: kbuild test robot <lkp@intel.com>
To: Florent Flament <contact@florentflament.com>
Cc: kbuild-all@01.org, andy.shevchenko@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        Florent Flament <contact@florentflament.com>
Subject: Re: [PATCH v2 1/1] HID: Logitech K290: Add driver for the Logitech
 K290 USB keyboard
Message-ID: <201803052207.4oLBFRZp%fengguang.wu@intel.com>
References: <20180304221425.28611-2-contact@florentflament.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180304221425.28611-2-contact@florentflament.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florent,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on hid/for-next]
[also build test WARNING on v4.16-rc4 next-20180305]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Florent-Flament/Logitech-K290-Add-driver-for-the-Logitech-K290-USB-keyboard/20180305-153311
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/hid/hid-logitech-k290.c:54:46: sparse: Using plain integer as NULL pointer

vim +54 drivers/hid/hid-logitech-k290.c

    45	
    46	static void k290_set_function(struct usb_device *dev, uint16_t function_mode)
    47	{
    48		int ret;
    49	
    50		ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
    51				      K290_SET_FUNCTION_CMD,
    52				      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
    53				      K290_SET_FUNCTION_VAL,
  > 54				      function_mode, 0, 0, USB_CTRL_SET_TIMEOUT);
    55	
    56		if (ret < 0)
    57			dev_err(&dev->dev,
    58				"Failed to setup K290 function key, error %d\n", ret);
    59	}
    60	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
