Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBE6C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5E1208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5E1208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934581AbeFRNgn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:36:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933527AbeFRNgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:36:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8AF34401EF16;
        Mon, 18 Jun 2018 13:36:40 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B7B7410194;
        Mon, 18 Jun 2018 13:36:37 +0000 (UTC)
Date:   Mon, 18 Jun 2018 09:36:37 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kbuild test robot <lkp@intel.com>, mika.westerberg@linux.intel.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        dm-devel@redhat.com, Yury Norov <ynorov@caviumnetworks.com>,
        kbuild-all@01.org, linux-input@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shaohua Li <shli@kernel.org>, Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v2 1/5] md: Avoid namespace collision with bitmap API
Message-ID: <20180618133637.GB25400@redhat.com>
References: <20180615132017.23889-2-andriy.shevchenko@linux.intel.com>
 <201806152251.xRJyWhS2%fengguang.wu@intel.com>
 <e4524ae9650c308245ecf398a0c27c6f7924be03.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4524ae9650c308245ecf398a0c27c6f7924be03.camel@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 18 Jun 2018 13:36:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 18 Jun 2018 13:36:40 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'msnitzer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15 2018 at 10:58am -0400,
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, 2018-06-15 at 23:09 +0800, kbuild test robot wrote:
> > Hi Andy,
> > 
> > I love your patch! Yet something to improve:
> 
> Thanks!
> 
> I fixed that locally (definitely that module wasn't compiled by
> default). Though I would wait to gather more comments before sending v3.
> 

Hi,

DM is not MD.  drivers/md/persistent-data/* is only used by DM.

Please rename all the drivers/md/persistent-data/ changes to use a
"dm_bitmap" prefix.

Thanks,
Mike

> > [auto build test ERROR on next-20180615]
> > [also build test ERROR on v4.17]
> > [cannot apply to md/for-next linus/master dm/for-next v4.17 v4.17-rc7
> > v4.17-rc6]
> > [if your patch is applied to the wrong git tree, please drop us a note
> > to help improve the system]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/bitma
> > p-Introduce-alloc-free-helpers/20180615-214724
> > config: i386-randconfig-b0-06141412 (attached as .config)
> > compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
> > reproduce:
> >         # save the attached .config to linux build tree
> >         make ARCH=i386 
> > 
> > All errors (new ones prefixed by >>):
> > 
> > > > drivers/md/persistent-data/dm-space-map-common.c:111:23: error:
> > > > 'bitmap_prepare_for_write' undeclared here (not in a function)
> > 
> >      .prepare_for_write = bitmap_prepare_for_write,
> >                           ^
> > > > drivers/md/persistent-data/dm-space-map-common.c:112:11: error:
> > > > 'bitmap_check' undeclared here (not in a function)
> > 
> >      .check = bitmap_check
> >               ^
> >    drivers/md/persistent-data/dm-space-map-common.c:72:13: warning:
> > 'md_bitmap_prepare_for_write' defined but not used [-Wunused-function]
> >     static void md_bitmap_prepare_for_write(struct dm_block_validator
> > *v,
> >                 ^
> >    drivers/md/persistent-data/dm-space-map-common.c:84:12: warning:
> > 'md_bitmap_check' defined but not used [-Wunused-function]
> >     static int md_bitmap_check(struct dm_block_validator *v,
> >                ^
> > 
> > vim +/bitmap_prepare_for_write +111 drivers/md/persistent-data/dm-
> > space-map-common.c
> > 
> > 3241b1d3 Joe Thornber 2011-10-31  108  
> > 3241b1d3 Joe Thornber 2011-10-31  109  static struct
> > dm_block_validator dm_sm_bitmap_validator = {
> > 3241b1d3 Joe Thornber 2011-10-31  110  	.name = "sm_bitmap",
> > 3241b1d3 Joe Thornber 2011-10-31 @111  	.prepare_for_write =
> > bitmap_prepare_for_write,
> > 3241b1d3 Joe Thornber 2011-10-31 @112  	.check = bitmap_check
> > 3241b1d3 Joe Thornber 2011-10-31  113  };
> > 3241b1d3 Joe Thornber 2011-10-31  114  
> > 
> > :::::: The code at line 111 was first introduced by commit
> > :::::: 3241b1d3e0aaafbfcd320f4d71ade629728cc4f4 dm: add persistent
> > data library
> > 
> > :::::: TO: Joe Thornber <thornber@redhat.com>
> > :::::: CC: Alasdair G Kergon <agk@redhat.com>
> > 
> > ---
> > 0-DAY kernel test infrastructure                Open Source Technology
> > Center
> > https://lists.01.org/pipermail/kbuild-all                   Intel
> > Corporation
> 
> -- 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
> 
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://www.redhat.com/mailman/listinfo/dm-devel
