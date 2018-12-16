Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEFDC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 03:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD68206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 03:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbeLPDO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 22:14:28 -0500
Received: from mga18.intel.com ([134.134.136.126]:58366 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728593AbeLPDO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 22:14:27 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Dec 2018 19:13:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,359,1539673200"; 
   d="gz'50?scan'50,208,50";a="107747484"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 15 Dec 2018 19:13:22 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gYMrq-0002xN-4L; Sun, 16 Dec 2018 11:13:22 +0800
Date:   Sun, 16 Dec 2018 11:12:38 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 5/7] riscv: dts: add initial support for the SiFive
 FU540-C000 SoC
Message-ID: <201812161134.fJ7zG13s%fengguang.wu@intel.com>
References: <20181215052154.24347-6-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <20181215052154.24347-6-paul.walmsley@sifive.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Paul,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.20-rc6 next-20181214]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Paul-Walmsley/arch-riscv-add-DT-file-support-starting-with-the-SiFive-HiFive-U/20181216-103926
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: riscv-tinyconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=riscv 

Note: the linux-review/Paul-Walmsley/arch-riscv-add-DT-file-support-starting-with-the-SiFive-HiFive-U/20181216-103926 HEAD bd72c6c6fec694776fceb1c4f4cf7c6415a6e8e3 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

>> scripts/Makefile.build:42: arch/riscv/boot/dts/Makefile: No such file or directory
>> make[2]: *** No rule to make target 'arch/riscv/boot/dts/Makefile'.
   make[2]: Failed to remake makefile 'arch/riscv/boot/dts/Makefile'.

vim +42 scripts/Makefile.build

20a468b51 Sam Ravnborg   2006-01-22  38  
2a6914703 Sam Ravnborg   2005-07-25  39  # The filename Kbuild has precedence over Makefile
db8c1a7b2 Sam Ravnborg   2005-07-27  40  kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
0c53c8e6e Sam Ravnborg   2007-10-14  41  kbuild-file := $(if $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Kbuild,$(kbuild-dir)/Makefile)
0c53c8e6e Sam Ravnborg   2007-10-14 @42  include $(kbuild-file)
^1da177e4 Linus Torvalds 2005-04-16  43  

:::::: The code at line 42 was first introduced by commit
:::::: 0c53c8e6eb456cde30f2305421c605713856abc8 kbuild: check for wrong use of CFLAGS

:::::: TO: Sam Ravnborg <sam@neptun.(none)>
:::::: CC: Sam Ravnborg <sam@neptun.(none)>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--FL5UXtIhxfXey3p5
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
OQAA

--FL5UXtIhxfXey3p5--
