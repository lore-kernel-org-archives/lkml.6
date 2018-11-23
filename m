Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC920C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 03:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841FA20813
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 03:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 841FA20813
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408003AbeKWN5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 08:57:47 -0500
Received: from mail1.windriver.com ([147.11.146.13]:40471 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731997AbeKWN5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 08:57:47 -0500
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id wAN3F9hu023447
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 22 Nov 2018 19:15:10 -0800 (PST)
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.408.0; Thu, 22 Nov 2018 19:14:57 -0800
Received: by yow-pgortmak-d1.corp.ad.wrs.com (Postfix, from userid 1000)        id
 335EB2E0841; Thu, 22 Nov 2018 22:14:57 -0500 (EST)
Date:   Thu, 22 Nov 2018 22:14:57 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     kbuild test robot <lkp@intel.com>
CC:     <kbuild-all@01.org>, Lee Jones <lee.jones@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH 02/11] mfd: da9055-core: make it explicitly non-modular
Message-ID: <20181123031456.GD14659@windriver.com>
References: <1542861179-8941-3-git-send-email-paul.gortmaker@windriver.com>
 <201811231036.wIjm7GBh%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <201811231036.wIjm7GBh%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 02/11] mfd: da9055-core: make it explicitly non-modular] On 23/11/2018 (Fri 10:21) kbuild test robot wrote:

> Hi Paul,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on ljones-mfd/for-mfd-next]
> [also build test ERROR on v4.20-rc3]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Paul-Gortmaker/mfd-simple-demodularization-of-non-modular-drivers/20181123-090206
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
> config: i386-randconfig-s1-11191736 (attached as .config)
> compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/mfd/da9055-i2c.o: In function `da9055_i2c_remove':
> >> drivers/mfd/da9055-i2c.c:53: undefined reference to `da9055_device_exit'

Thanks for the report -- I'll look into what causes it, why my testing
didn't see it, and get an update to Lee as soon as possible.

Paul.
--

> 
> vim +53 drivers/mfd/da9055-i2c.c
> 
> 2896434c Ashish Jangam  2012-09-14  48  
> 4740f73f Bill Pemberton 2012-11-19  49  static int da9055_i2c_remove(struct i2c_client *i2c)
> 2896434c Ashish Jangam  2012-09-14  50  {
> 2896434c Ashish Jangam  2012-09-14  51  	struct da9055 *da9055 = i2c_get_clientdata(i2c);
> 2896434c Ashish Jangam  2012-09-14  52  
> 2896434c Ashish Jangam  2012-09-14 @53  	da9055_device_exit(da9055);
> 2896434c Ashish Jangam  2012-09-14  54  
> 2896434c Ashish Jangam  2012-09-14  55  	return 0;
> 2896434c Ashish Jangam  2012-09-14  56  }
> 2896434c Ashish Jangam  2012-09-14  57  
> 
> :::::: The code at line 53 was first introduced by commit
> :::::: 2896434cf272acace1b7093d5e4ba8022ed11ac8 mfd: DA9055 core driver
> 
> :::::: TO: Ashish Jangam <ashish.jangam@kpitcummins.com>
> :::::: CC: Samuel Ortiz <sameo@linux.intel.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


