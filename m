Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D99ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925BB208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 925BB208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbeIPF5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 01:57:03 -0400
Received: from mga03.intel.com ([134.134.136.65]:58369 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbeIPF5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 01:57:03 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Sep 2018 17:36:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,379,1531810800"; 
   d="scan'208";a="233234144"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga004.jf.intel.com with ESMTP; 15 Sep 2018 17:34:27 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1g1KAe-0000XC-Dg; Sun, 16 Sep 2018 07:40:12 +0800
Date:   Sun, 16 Sep 2018 07:39:39 +0800
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
Message-ID: <201809160755.OFd8HPIT%fengguang.wu@intel.com>
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

>> fs/sysfs/Kconfig:1:error: recursive dependency detected!
>> fs/sysfs/Kconfig:1: symbol SYSFS is selected by CONFIGFS_FS
>> fs/configfs/Kconfig:1: symbol CONFIGFS_FS is selected by ACPI_CONFIGFS
>> drivers/acpi/Kconfig:542: symbol ACPI_CONFIGFS depends on ACPI
   drivers/acpi/Kconfig:9: symbol ACPI depends on ARCH_SUPPORTS_ACPI
   drivers/acpi/Kconfig:6: symbol ARCH_SUPPORTS_ACPI is selected by EFI
   arch/arm64/Kconfig:1253: symbol EFI depends on KERNEL_MODE_NEON
   arch/arm64/Kconfig:262: symbol KERNEL_MODE_NEON is implied by ZINC_ARCH_ARM
   lib/zinc/Kconfig:42: symbol ZINC_ARCH_ARM depends on ZINC
>> lib/zinc/Kconfig:1: symbol ZINC is selected by ZINC_POLY1305
>> lib/zinc/Kconfig:9: symbol ZINC_POLY1305 is selected by CRYPTO_POLY1305
>> crypto/Kconfig:656: symbol CRYPTO_POLY1305 depends on CRYPTO
>> crypto/Kconfig:16: symbol CRYPTO is selected by IP_SCTP
>> net/sctp/Kconfig:5: symbol IP_SCTP is selected by DLM
>> fs/dlm/Kconfig:1: symbol DLM depends on SYSFS
   For a resolution refer to Documentation/kbuild/kconfig-language.txt
   subsection "Kconfig recursive dependency limitations"

vim +1 lib/zinc/Kconfig

32bbe22e Jason A. Donenfeld 2018-09-14  @1  config ZINC
32bbe22e Jason A. Donenfeld 2018-09-14   2  	tristate
32bbe22e Jason A. Donenfeld 2018-09-14   3  
35f45248 Jason A. Donenfeld 2018-09-14   4  config ZINC_CHACHA20
35f45248 Jason A. Donenfeld 2018-09-14   5  	bool
35f45248 Jason A. Donenfeld 2018-09-14   6  	select ZINC
35f45248 Jason A. Donenfeld 2018-09-14   7  	select CRYPTO_ALGAPI
35f45248 Jason A. Donenfeld 2018-09-14   8  
0a36c146 Jason A. Donenfeld 2018-09-14  @9  config ZINC_POLY1305
0a36c146 Jason A. Donenfeld 2018-09-14  10  	bool
0a36c146 Jason A. Donenfeld 2018-09-14  11  	select ZINC
0a36c146 Jason A. Donenfeld 2018-09-14  12  
1b5dbb86 Jason A. Donenfeld 2018-09-14  13  config ZINC_CHACHA20POLY1305
1b5dbb86 Jason A. Donenfeld 2018-09-14  14  	bool
1b5dbb86 Jason A. Donenfeld 2018-09-14  15  	select ZINC
1b5dbb86 Jason A. Donenfeld 2018-09-14  16  	select ZINC_CHACHA20
1b5dbb86 Jason A. Donenfeld 2018-09-14  17  	select ZINC_POLY1305
1b5dbb86 Jason A. Donenfeld 2018-09-14  18  	select CRYPTO_BLKCIPHER
1b5dbb86 Jason A. Donenfeld 2018-09-14  19  
a740374c Jason A. Donenfeld 2018-09-14  20  config ZINC_BLAKE2S
a740374c Jason A. Donenfeld 2018-09-14  21  	bool
a740374c Jason A. Donenfeld 2018-09-14  22  	select ZINC
a740374c Jason A. Donenfeld 2018-09-14  23  
cec5aa7c Jason A. Donenfeld 2018-09-14  24  config ZINC_CURVE25519
cec5aa7c Jason A. Donenfeld 2018-09-14  25  	bool
cec5aa7c Jason A. Donenfeld 2018-09-14  26  	select ZINC
cec5aa7c Jason A. Donenfeld 2018-09-14  27  	select CONFIG_CRYPTO
cec5aa7c Jason A. Donenfeld 2018-09-14  28  
32bbe22e Jason A. Donenfeld 2018-09-14  29  config ZINC_DEBUG
32bbe22e Jason A. Donenfeld 2018-09-14  30  	bool "Zinc cryptography library debugging and self-tests"
32bbe22e Jason A. Donenfeld 2018-09-14  31  	depends on ZINC
32bbe22e Jason A. Donenfeld 2018-09-14  32  	help
32bbe22e Jason A. Donenfeld 2018-09-14  33  	  This builds a series of self-tests for the Zinc crypto library, which
32bbe22e Jason A. Donenfeld 2018-09-14  34  	  help diagnose any cryptographic algorithm implementation issues that
32bbe22e Jason A. Donenfeld 2018-09-14  35  	  might be at the root cause of potential bugs. It also adds various
32bbe22e Jason A. Donenfeld 2018-09-14  36  	  debugging traps.
32bbe22e Jason A. Donenfeld 2018-09-14  37  
32bbe22e Jason A. Donenfeld 2018-09-14  38  	  Unless you're developing and testing cryptographic routines, or are
32bbe22e Jason A. Donenfeld 2018-09-14  39  	  especially paranoid about correctness on your hardware, you may say
32bbe22e Jason A. Donenfeld 2018-09-14  40  	  N here.
32bbe22e Jason A. Donenfeld 2018-09-14  41  
32bbe22e Jason A. Donenfeld 2018-09-14 @42  config ZINC_ARCH_ARM
32bbe22e Jason A. Donenfeld 2018-09-14  43  	def_bool y
32bbe22e Jason A. Donenfeld 2018-09-14  44  	depends on ARM
32bbe22e Jason A. Donenfeld 2018-09-14  45  	depends on ZINC
32bbe22e Jason A. Donenfeld 2018-09-14  46  	imply VFP
32bbe22e Jason A. Donenfeld 2018-09-14  47  	imply VFPv3 if CPU_V7
32bbe22e Jason A. Donenfeld 2018-09-14  48  	imply NEON if CPU_V7
32bbe22e Jason A. Donenfeld 2018-09-14  49  	imply KERNEL_MODE_NEON if CPU_V7
32bbe22e Jason A. Donenfeld 2018-09-14  50  

:::::: The code at line 1 was first introduced by commit
:::::: 32bbe22ec6fddc21b70274aab7d2830d69d51578 zinc: introduce minimal cryptography library

:::::: TO: Jason A. Donenfeld <Jason@zx2c4.com>
:::::: CC: 0day robot <lkp@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
