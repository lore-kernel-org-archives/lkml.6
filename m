Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 02F2EC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A296920896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A296920896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936249AbeFOO7E (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 10:59:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:14726 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752798AbeFOO7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 10:59:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 07:59:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,227,1526367600"; 
   d="scan'208";a="57620504"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jun 2018 07:58:58 -0700
Message-ID: <e4524ae9650c308245ecf398a0c27c6f7924be03.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/5] md: Avoid namespace collision with bitmap API
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com
Date:   Fri, 15 Jun 2018 17:58:57 +0300
In-Reply-To: <201806152251.xRJyWhS2%fengguang.wu@intel.com>
References: <20180615132017.23889-2-andriy.shevchenko@linux.intel.com>
         <201806152251.xRJyWhS2%fengguang.wu@intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-15 at 23:09 +0800, kbuild test robot wrote:
> Hi Andy,
> 
> I love your patch! Yet something to improve:

Thanks!

I fixed that locally (definitely that module wasn't compiled by
default). Though I would wait to gather more comments before sending v3.

> 
> [auto build test ERROR on next-20180615]
> [also build test ERROR on v4.17]
> [cannot apply to md/for-next linus/master dm/for-next v4.17 v4.17-rc7
> v4.17-rc6]
> [if your patch is applied to the wrong git tree, please drop us a note
> to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/bitma
> p-Introduce-alloc-free-helpers/20180615-214724
> config: i386-randconfig-b0-06141412 (attached as .config)
> compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
> > > drivers/md/persistent-data/dm-space-map-common.c:111:23: error:
> > > 'bitmap_prepare_for_write' undeclared here (not in a function)
> 
>      .prepare_for_write = bitmap_prepare_for_write,
>                           ^
> > > drivers/md/persistent-data/dm-space-map-common.c:112:11: error:
> > > 'bitmap_check' undeclared here (not in a function)
> 
>      .check = bitmap_check
>               ^
>    drivers/md/persistent-data/dm-space-map-common.c:72:13: warning:
> 'md_bitmap_prepare_for_write' defined but not used [-Wunused-function]
>     static void md_bitmap_prepare_for_write(struct dm_block_validator
> *v,
>                 ^
>    drivers/md/persistent-data/dm-space-map-common.c:84:12: warning:
> 'md_bitmap_check' defined but not used [-Wunused-function]
>     static int md_bitmap_check(struct dm_block_validator *v,
>                ^
> 
> vim +/bitmap_prepare_for_write +111 drivers/md/persistent-data/dm-
> space-map-common.c
> 
> 3241b1d3 Joe Thornber 2011-10-31  108  
> 3241b1d3 Joe Thornber 2011-10-31  109  static struct
> dm_block_validator dm_sm_bitmap_validator = {
> 3241b1d3 Joe Thornber 2011-10-31  110  	.name = "sm_bitmap",
> 3241b1d3 Joe Thornber 2011-10-31 @111  	.prepare_for_write =
> bitmap_prepare_for_write,
> 3241b1d3 Joe Thornber 2011-10-31 @112  	.check = bitmap_check
> 3241b1d3 Joe Thornber 2011-10-31  113  };
> 3241b1d3 Joe Thornber 2011-10-31  114  
> 
> :::::: The code at line 111 was first introduced by commit
> :::::: 3241b1d3e0aaafbfcd320f4d71ade629728cc4f4 dm: add persistent
> data library
> 
> :::::: TO: Joe Thornber <thornber@redhat.com>
> :::::: CC: Alasdair G Kergon <agk@redhat.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology
> Center
> https://lists.01.org/pipermail/kbuild-all                   Intel
> Corporation

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
