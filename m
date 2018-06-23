Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A6DC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 18:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CC724CD5
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 18:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35CC724CD5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbeFWS7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 14:59:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:14180 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751595AbeFWS7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 14:59:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jun 2018 11:59:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,262,1526367600"; 
   d="gz'50?scan'50,208,50";a="52323568"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga006.jf.intel.com with ESMTP; 23 Jun 2018 11:59:49 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fWnlE-00090t-9q; Sun, 24 Jun 2018 02:59:48 +0800
Date:   Sun, 24 Jun 2018 02:59:39 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     kbuild-all@01.org, linux-kbuild@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] kbuild: use 'include' directive to load auto.conf
 from top Makefile
Message-ID: <201806240006.eCGYTuNX%fengguang.wu@intel.com>
References: <1529762169-13488-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <1529762169-13488-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Masahiro,

I love your patch! Yet something to improve:

[auto build test ERROR on kbuild/for-next]
[also build test ERROR on v4.18-rc1 next-20180622]
[cannot apply to mmarek/for-next mmarek/rc-fixes]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Masahiro-Yamada/kbuild-use-include-directive-to-load-auto-conf-from-top-Makefile/20180623-220114
base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
config: xtensa-nommu_kc705_defconfig (attached as .config)
compiler: xtensa-de212-elf-gcc (crosstool-NG crosstool-ng-1.23.0-307-g452ee331) 7.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.3.0 make.cross ARCH=xtensa 

All errors (new ones prefixed by >>):

>> Makefile:592: include/config/auto.conf: No such file or directory
   drivers/staging/mt7621-dts/Kconfig:4:warning: 'BUILTIN_DTB' has wrong type. 'select' only accept arguments of bool and tristate type
   <stdin>:1332:2: warning: #warning syscall io_pgetevents not implemented [-Wcpp]
   <stdin>:1335:2: warning: #warning syscall rseq not implemented [-Wcpp]

vim +592 Makefile

   590	
   591	ifeq ($(dot-config),1)
 > 592	include include/config/auto.conf
   593	endif
   594	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--tKW2IUtsqtDRztdT
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--tKW2IUtsqtDRztdT--
