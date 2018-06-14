Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2354BC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CD6208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CD6208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752737AbeFNFM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 01:12:58 -0400
Received: from mga04.intel.com ([192.55.52.120]:61044 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751440AbeFNFMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 01:12:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2018 22:12:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,221,1526367600"; 
   d="gz'50?scan'50,208,50";a="59113893"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga003.jf.intel.com with ESMTP; 13 Jun 2018 22:12:40 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fTKYp-0006Bf-Ao; Thu, 14 Jun 2018 13:12:39 +0800
Date:   Thu, 14 Jun 2018 13:12:29 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Hugo Lefeuvre <hle@owl.eu.com>
Cc:     kbuild-all@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Marcus Wolf <linux@wolf-entwicklungen.de>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH v3] staging: pi433: fix race condition in pi433_ioctl
Message-ID: <201806141123.L0s5IfDT%fengguang.wu@intel.com>
References: <20180614005414.GA1974@hle-laptop.local>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <20180614005414.GA1974@hle-laptop.local>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Hugo,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on staging/staging-testing]
[also build test ERROR on v4.17 next-20180613]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Hugo-Lefeuvre/staging-pi433-fix-race-condition-in-pi433_ioctl/20180614-091011
config: i386-randconfig-s0-201823 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   In file included from arch/x86/include/asm/string.h:3:0,
                    from include/linux/string.h:20,
                    from arch/x86/include/asm/page_32.h:35,
                    from arch/x86/include/asm/page.h:14,
                    from arch/x86/include/asm/thread_info.h:12,
                    from include/linux/thread_info.h:38,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:81,
                    from include/linux/spinlock.h:51,
                    from include/linux/seqlock.h:36,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:10,
                    from drivers/staging//pi433/pi433_if.c:31:
   drivers/staging//pi433/pi433_if.c: In function 'pi433_ioctl':
>> drivers/staging//pi433/pi433_if.c:909:30: error: 'tx_cfg_buffer' undeclared (first use in this function)
      memcpy(&instance->tx_cfg, &tx_cfg_buffer, sizeof(struct pi433_tx_cfg));
                                 ^
   arch/x86/include/asm/string_32.h:183:45: note: in definition of macro 'memcpy'
    #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
                                                ^
   drivers/staging//pi433/pi433_if.c:909:30: note: each undeclared identifier is reported only once for each function it appears in
      memcpy(&instance->tx_cfg, &tx_cfg_buffer, sizeof(struct pi433_tx_cfg));
                                 ^
   arch/x86/include/asm/string_32.h:183:45: note: in definition of macro 'memcpy'
    #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
                                                ^

vim +/tx_cfg_buffer +909 drivers/staging//pi433/pi433_if.c

   876	
   877	static long
   878	pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
   879	{
   880		int			retval = 0;
   881		struct pi433_instance	*instance;
   882		struct pi433_device	*device;
   883		struct pi433_tx_cfg	tx_cfg;
   884		void __user *argp = (void __user *)arg;
   885	
   886		/* Check type and command number */
   887		if (_IOC_TYPE(cmd) != PI433_IOC_MAGIC)
   888			return -ENOTTY;
   889	
   890		/* TODO? guard against device removal before, or while,
   891		 * we issue this ioctl. --> device_get()
   892		 */
   893		instance = filp->private_data;
   894		device = instance->device;
   895	
   896		if (!device)
   897			return -ESHUTDOWN;
   898	
   899		switch (cmd) {
   900		case PI433_IOC_RD_TX_CFG:
   901			if (copy_to_user(argp, &instance->tx_cfg,
   902					 sizeof(struct pi433_tx_cfg)))
   903				return -EFAULT;
   904			break;
   905		case PI433_IOC_WR_TX_CFG:
   906			if (copy_from_user(&tx_cfg, argp, sizeof(struct pi433_tx_cfg)))
   907				return -EFAULT;
   908			mutex_lock(&device->tx_fifo_lock);
 > 909			memcpy(&instance->tx_cfg, &tx_cfg_buffer, sizeof(struct pi433_tx_cfg));
   910			mutex_unlock(&device->tx_fifo_lock);
   911			break;
   912		case PI433_IOC_RD_RX_CFG:
   913			if (copy_to_user(argp, &device->rx_cfg,
   914					 sizeof(struct pi433_rx_cfg)))
   915				return -EFAULT;
   916			break;
   917		case PI433_IOC_WR_RX_CFG:
   918			mutex_lock(&device->rx_lock);
   919	
   920			/* during pendig read request, change of config not allowed */
   921			if (device->rx_active) {
   922				mutex_unlock(&device->rx_lock);
   923				return -EAGAIN;
   924			}
   925	
   926			if (copy_from_user(&device->rx_cfg, argp,
   927					   sizeof(struct pi433_rx_cfg))) {
   928				mutex_unlock(&device->rx_lock);
   929				return -EFAULT;
   930			}
   931	
   932			mutex_unlock(&device->rx_lock);
   933			break;
   934		default:
   935			retval = -EINVAL;
   936		}
   937	
   938		return retval;
   939	}
   940	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--0OAP2g/MAC+5xKAE
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
SD+dD09EdBbtCMr/AU0ZBJfZIgIA

--0OAP2g/MAC+5xKAE--
