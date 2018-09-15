Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748FEECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 23:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD8420881
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 23:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD8420881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbeIPEXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 00:23:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:36423 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725199AbeIPEXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 00:23:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Sep 2018 16:03:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,379,1531810800"; 
   d="scan'208";a="257575723"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga005.jf.intel.com with ESMTP; 15 Sep 2018 16:03:09 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1g1Jan-0005Ip-AD; Sun, 16 Sep 2018 07:03:09 +0800
Date:   Sun, 16 Sep 2018 07:02:31 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH net-next v4 17/20] crypto: port Poly1305 to Zinc
Message-ID: <201809160719.qunccnIZ%fengguang.wu@intel.com>
References: <20180914162240.7925-18-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914162240.7925-18-Jason@zx2c4.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

I love your patch! Yet something to improve:

[auto build test ERROR on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Jason-A-Donenfeld/WireGuard-Secure-Network-Tunnel/20180916-043623
config: arm64-defconfig
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        GCC_VERSION=7.2.0 make.cross ARCH=arm64  defconfig
        GCC_VERSION=7.2.0 make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   fs/sysfs/Kconfig:1:error: recursive dependency detected!
   fs/sysfs/Kconfig:1: symbol SYSFS is selected by CONFIGFS_FS
   fs/configfs/Kconfig:1: symbol CONFIGFS_FS is selected by ACPI_CONFIGFS
   drivers/acpi/Kconfig:542: symbol ACPI_CONFIGFS depends on ACPI
>> drivers/acpi/Kconfig:9: symbol ACPI depends on ARCH_SUPPORTS_ACPI
>> drivers/acpi/Kconfig:6: symbol ARCH_SUPPORTS_ACPI is selected by EFI
>> arch/arm64/Kconfig:1253: symbol EFI depends on KERNEL_MODE_NEON
>> arch/arm64/Kconfig:262: symbol KERNEL_MODE_NEON is implied by ZINC_ARCH_ARM
>> lib/zinc/Kconfig:42: symbol ZINC_ARCH_ARM depends on ZINC
   lib/zinc/Kconfig:1: symbol ZINC is selected by ZINC_POLY1305
   lib/zinc/Kconfig:9: symbol ZINC_POLY1305 is selected by CRYPTO_POLY1305
   crypto/Kconfig:656: symbol CRYPTO_POLY1305 depends on CRYPTO
   crypto/Kconfig:16: symbol CRYPTO is selected by IP_SCTP
   net/sctp/Kconfig:5: symbol IP_SCTP is selected by DLM
   fs/dlm/Kconfig:1: symbol DLM depends on SYSFS
   For a resolution refer to Documentation/kbuild/kconfig-language.txt
   subsection "Kconfig recursive dependency limitations"

vim +9 drivers/acpi/Kconfig

^1da177e4 Linus Torvalds    2005-04-16   5  
f5d707ede Arnd Bergmann     2018-08-21  @6  config ARCH_SUPPORTS_ACPI
f5d707ede Arnd Bergmann     2018-08-21   7  	bool
f5d707ede Arnd Bergmann     2018-08-21   8  
3f2c48c9b Jan Engelhardt    2007-07-03  @9  menuconfig ACPI
355ee5eb6 Frans Pop         2007-10-29  10  	bool "ACPI (Advanced Configuration and Power Interface) Support"
2c870e611 Arnd Bergmann     2018-07-24  11  	depends on ARCH_SUPPORTS_ACPI
1300124f6 Adrian Bunk       2006-03-28  12  	depends on PCI
243b66e76 Len Brown         2007-02-15  13  	select PNP
2c870e611 Arnd Bergmann     2018-07-24  14  	default y if X86
1c48aa36e Bjorn Helgaas     2009-02-19  15  	help
^1da177e4 Linus Torvalds    2005-04-16  16  	  Advanced Configuration and Power Interface (ACPI) support for 
1c48aa36e Bjorn Helgaas     2009-02-19  17  	  Linux requires an ACPI-compliant platform (hardware/firmware),
^1da177e4 Linus Torvalds    2005-04-16  18  	  and assumes the presence of OS-directed configuration and power
^1da177e4 Linus Torvalds    2005-04-16  19  	  management (OSPM) software.  This option will enlarge your 
^1da177e4 Linus Torvalds    2005-04-16  20  	  kernel by about 70K.
^1da177e4 Linus Torvalds    2005-04-16  21  
^1da177e4 Linus Torvalds    2005-04-16  22  	  Linux ACPI provides a robust functional replacement for several 
^1da177e4 Linus Torvalds    2005-04-16  23  	  legacy configuration and power management interfaces, including
^1da177e4 Linus Torvalds    2005-04-16  24  	  the Plug-and-Play BIOS specification (PnP BIOS), the 
^1da177e4 Linus Torvalds    2005-04-16  25  	  MultiProcessor Specification (MPS), and the Advanced Power 
^1da177e4 Linus Torvalds    2005-04-16  26  	  Management (APM) specification.  If both ACPI and APM support 
1c48aa36e Bjorn Helgaas     2009-02-19  27  	  are configured, ACPI is used.
^1da177e4 Linus Torvalds    2005-04-16  28  
1c48aa36e Bjorn Helgaas     2009-02-19  29  	  The project home page for the Linux ACPI subsystem is here:
aaf3d29fe Rafael J. Wysocki 2013-10-10  30  	  <https://01.org/linux-acpi>
^1da177e4 Linus Torvalds    2005-04-16  31  
^1da177e4 Linus Torvalds    2005-04-16  32  	  Linux support for ACPI is based on Intel Corporation's ACPI
1c48aa36e Bjorn Helgaas     2009-02-19  33  	  Component Architecture (ACPI CA).  For more information on the
1c48aa36e Bjorn Helgaas     2009-02-19  34  	  ACPI CA, see:
1c48aa36e Bjorn Helgaas     2009-02-19  35  	  <http://acpica.org/>
^1da177e4 Linus Torvalds    2005-04-16  36  
c7f5220d0 Hanjun Guo        2014-04-08  37  	  ACPI is an open industry specification originally co-developed by
c7f5220d0 Hanjun Guo        2014-04-08  38  	  Hewlett-Packard, Intel, Microsoft, Phoenix, and Toshiba. Currently,
c7f5220d0 Hanjun Guo        2014-04-08  39  	  it is developed by the ACPI Specification Working Group (ASWG) under
c7f5220d0 Hanjun Guo        2014-04-08  40  	  the UEFI Forum and any UEFI member can join the ASWG and contribute
c7f5220d0 Hanjun Guo        2014-04-08  41  	  to the ACPI specification.
1c48aa36e Bjorn Helgaas     2009-02-19  42  	  The specification is available at:
^1da177e4 Linus Torvalds    2005-04-16  43  	  <http://www.acpi.info>
c7f5220d0 Hanjun Guo        2014-04-08  44  	  <http://www.uefi.org/acpi/specs>
^1da177e4 Linus Torvalds    2005-04-16  45  

:::::: The code at line 9 was first introduced by commit
:::::: 3f2c48c9b48423d1411695da066d525cca2a27db ACPI: Use menuconfig objects

:::::: TO: Jan Engelhardt <jengelh@linux01.gwdg.de>
:::::: CC: Len Brown <len.brown@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
