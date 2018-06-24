Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72841C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 10:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A45924E90
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 10:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A45924E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbeFXKY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 06:24:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:18427 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751596AbeFXKYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 06:24:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2018 03:24:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,265,1526367600"; 
   d="scan'208";a="51796120"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.13.138])
  by orsmga008.jf.intel.com with ESMTP; 24 Jun 2018 03:24:53 -0700
Date:   Sun, 24 Jun 2018 18:35:16 +0800
From:   Philip Li <philip.li@intel.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     kbuild test robot <lkp@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>, kbuild-all@01.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [kbuild-all] [PATCH v2 1/3] kbuild: use 'include' directive to
 load auto.conf from top Makefile
Message-ID: <20180624103516.GA29697@intel.com>
References: <1529762169-13488-1-git-send-email-yamada.masahiro@socionext.com>
 <201806240006.eCGYTuNX%fengguang.wu@intel.com>
 <CAK7LNARv7VyPaew6XpRiYqh1YTapj-oErGuiq4rS1_BmEjC8Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARv7VyPaew6XpRiYqh1YTapj-oErGuiq4rS1_BmEjC8Lw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 24, 2018 at 05:56:24PM +0900, Masahiro Yamada wrote:
> Hi.
> 
> 2018-06-24 3:59 GMT+09:00 kbuild test robot <lkp@intel.com>:
> > Hi Masahiro,
> >
> > I love your patch! Yet something to improve:
> >
> > [auto build test ERROR on kbuild/for-next]
> > [also build test ERROR on v4.18-rc1 next-20180622]
> > [cannot apply to mmarek/for-next mmarek/rc-fixes]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> >
> > url:    https://github.com/0day-ci/linux/commits/Masahiro-Yamada/kbuild-use-include-directive-to-load-auto-conf-from-top-Makefile/20180623-220114
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
> > config: xtensa-nommu_kc705_defconfig (attached as .config)
> > compiler: xtensa-de212-elf-gcc (crosstool-NG crosstool-ng-1.23.0-307-g452ee331) 7.3.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=7.3.0 make.cross ARCH=xtensa
> 
> This did not work for me
> because the make.cross script tries to download GCC 7.3.0 xtensa-linux
> but it is missing in the web site.
> 
> $ GCC_VERSION=7.3.0 make.cross ARCH=xtensa
> Cannot find xtensa-linux under
> https://download.01.org/0day-ci/cross-package check
> /tmp/crosstool-files
thanks for info, we will fix it as early as possible, and
reproduce the issue to provide feedback later.

> 
> 
> I installed xtensa-de212-elf-gcc by hand,
> but I could not reproduce the error.
> 
> 
> GCC_VERSION=7.2.0 make.cross ARCH=xtensa
> worked, but I could not reproduce the issue either.
> (the build terminated with a different error.)
> 
> 
> Where can I see the full build log?
> 
> 
> > All errors (new ones prefixed by >>):
> >
> >>> Makefile:592: include/config/auto.conf: No such file or directory
> >    drivers/staging/mt7621-dts/Kconfig:4:warning: 'BUILTIN_DTB' has wrong type. 'select' only accept arguments of bool and tristate type
> >    <stdin>:1332:2: warning: #warning syscall io_pgetevents not implemented [-Wcpp]
> >    <stdin>:1335:2: warning: #warning syscall rseq not implemented [-Wcpp]
> >
> > vim +592 Makefile
> >
> >    590
> >    591  ifeq ($(dot-config),1)
> >  > 592  include include/config/auto.conf
> >    593  endif
> >    594
> >
> > ---
> > 0-DAY kernel test infrastructure                Open Source Technology Center
> > https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
> _______________________________________________
> kbuild-all mailing list
> kbuild-all@lists.01.org
> https://lists.01.org/mailman/listinfo/kbuild-all
