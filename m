Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbeDLAUL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 20:20:11 -0400
Received: from mga04.intel.com ([192.55.52.120]:55587 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751633AbeDLAUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 20:20:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,438,1517904000";
   d="scan'208";a="46212042"
Date: Thu, 12 Apr 2018 08:19:12 +0800
From: kbuild test robot <lkp@intel.com>
To: Thiebaud Weksteen <tweek@google.com>
Cc: kbuild-all@01.org, jarkko.sakkinen@linux.intel.com,
        nayna@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, tweek@google.com
Subject: Re: [PATCH 1/3] tpm: Move eventlog files to a subdirectory
Message-ID: <201804120854.QaJLImB4%fengguang.wu@intel.com>
References: <20180411125501.188477-2-tweek@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411125501.188477-2-tweek@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thiebaud,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on v4.16 next-20180411]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Thiebaud-Weksteen/tpm-Move-eventlog-files-to-a-subdirectory/20180412-045224
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/char/tpm/eventlog/of.c:59:37: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __be32 const [usertype] *p @@    got unsignrestricted __be32 const [usertype] *p @@
   drivers/char/tpm/eventlog/of.c:59:37:    expected restricted __be32 const [usertype] *p
   drivers/char/tpm/eventlog/of.c:59:37:    got unsigned int const [usertype] *[assigned] sizep
>> drivers/char/tpm/eventlog/of.c:60:37: sparse: incorrect type in argument 1 (different base types) @@    expected restricted __be64 const [usertype] *p @@    got unsigned lonrestricted __be64 const [usertype] *p @@
   drivers/char/tpm/eventlog/of.c:60:37:    expected restricted __be64 const [usertype] *p
   drivers/char/tpm/eventlog/of.c:60:37:    got unsigned long long const [usertype] *[assigned] basep

vim +59 drivers/char/tpm/eventlog/of.c

c5df39262 drivers/char/tpm/tpm_of.c Ashley Lai             2012-08-14  23  
02ae13828 drivers/char/tpm/tpm_of.c Nayna Jain             2016-11-14  24  int tpm_read_log_of(struct tpm_chip *chip)
c5df39262 drivers/char/tpm/tpm_of.c Ashley Lai             2012-08-14  25  {
c5df39262 drivers/char/tpm/tpm_of.c Ashley Lai             2012-08-14  26  	struct device_node *np;
c5df39262 drivers/char/tpm/tpm_of.c Ashley Lai             2012-08-14  27  	const u32 *sizep;
d72c39114 drivers/char/tpm/tpm_of.c Hon Ching \(Vicky\  Lo 2015-06-17  28) 	const u64 *basep;
748935eeb drivers/char/tpm/tpm_of.c Nayna Jain             2016-11-14  29  	struct tpm_bios_log *log;
e46e22f12 drivers/char/tpm/tpm_of.c Nayna Jain             2017-01-23  30  	u32 size;
e46e22f12 drivers/char/tpm/tpm_of.c Nayna Jain             2017-01-23  31  	u64 base;
c5df39262 drivers/char/tpm/tpm_of.c Ashley Lai             2012-08-14  32  
748935eeb drivers/char/tpm/tpm_of.c Nayna Jain             2016-11-14  33  	log = &chip->log;
0cf577a03 drivers/char/tpm/tpm_of.c Jason Gunthorpe        2016-11-19  34  	if (chip->dev.parent && chip->dev.parent->of_node)
ed4fdb4f5 drivers/char/tpm/tpm_of.c Nayna Jain             2016-11-14  35  		np = chip->dev.parent->of_node;
79eec5b94 drivers/char/tpm/tpm_of.c Colin Ian King         2016-11-15  36  	else
c5df39262 drivers/char/tpm/tpm_of.c Ashley Lai             2012-08-14  37  		return -ENODEV;
c5df39262 drivers/char/tpm/tpm_of.c Ashley Lai             2012-08-14  38  
b5d0ebc99 drivers/char/tpm/tpm_of.c Enric Balletbo i Serra 2017-06-27  39  	if (of_property_read_bool(np, "powered-while-suspended"))
b5d0ebc99 drivers/char/tpm/tpm_of.c Enric Balletbo i Serra 2017-06-27  40  		chip->flags |= TPM_CHIP_FLAG_ALWAYS_POWERED;
b5d0ebc99 drivers/char/tpm/tpm_of.c Enric Balletbo i Serra 2017-06-27  41  
c5df39262 drivers/char/tpm/tpm_of.c Ashley Lai             2012-08-14  42  	sizep = of_get_property(np, "linux,sml-size", NULL);
0cf577a03 drivers/char/tpm/tpm_of.c Jason Gunthorpe        2016-11-19  43  	basep = of_get_property(np, "linux,sml-base", NULL);
0cf577a03 drivers/char/tpm/tpm_of.c Jason Gunthorpe        2016-11-19  44  	if (sizep == NULL && basep == NULL)
0cf577a03 drivers/char/tpm/tpm_of.c Jason Gunthorpe        2016-11-19  45  		return -ENODEV;
0cf577a03 drivers/char/tpm/tpm_of.c Jason Gunthorpe        2016-11-19  46  	if (sizep == NULL || basep == NULL)
5efae7d6b drivers/char/tpm/tpm_of.c Nayna Jain             2016-11-14  47  		return -EIO;
5efae7d6b drivers/char/tpm/tpm_of.c Nayna Jain             2016-11-14  48  
e46e22f12 drivers/char/tpm/tpm_of.c Nayna Jain             2017-01-23  49  	/*
e46e22f12 drivers/char/tpm/tpm_of.c Nayna Jain             2017-01-23  50  	 * For both vtpm/tpm, firmware has log addr and log size in big
e46e22f12 drivers/char/tpm/tpm_of.c Nayna Jain             2017-01-23  51  	 * endian format. But in case of vtpm, there is a method called
e46e22f12 drivers/char/tpm/tpm_of.c Nayna Jain             2017-01-23  52  	 * sml-handover which is run during kernel init even before
e46e22f12 drivers/char/tpm/tpm_of.c Nayna Jain             2017-01-23  53  	 * device tree is setup. This sml-handover function takes care
e46e22f12 drivers/char/tpm/tpm_of.c Nayna Jain             2017-01-23  54  	 * of endianness and writes to sml-base and sml-size in little
e46e22f12 drivers/char/tpm/tpm_of.c Nayna Jain             2017-01-23  55  	 * endian format. For this reason, vtpm doesn't need conversion
e46e22f12 drivers/char/tpm/tpm_of.c Nayna Jain             2017-01-23  56  	 * but physical tpm needs the conversion.
e46e22f12 drivers/char/tpm/tpm_of.c Nayna Jain             2017-01-23  57  	 */
e46e22f12 drivers/char/tpm/tpm_of.c Nayna Jain             2017-01-23  58  	if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0) {
e46e22f12 drivers/char/tpm/tpm_of.c Nayna Jain             2017-01-23 @59  		size = be32_to_cpup(sizep);
e46e22f12 drivers/char/tpm/tpm_of.c Nayna Jain             2017-01-23 @60  		base = be64_to_cpup(basep);

:::::: The code at line 59 was first introduced by commit
:::::: e46e22f12b19f0068b02afcf6edb716b4f49934f tpm: enhance read_log_of() to support Physical TPM event log

:::::: TO: Nayna Jain <nayna@linux.vnet.ibm.com>
:::::: CC: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
