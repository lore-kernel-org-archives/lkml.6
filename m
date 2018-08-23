Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3F7C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 03:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6493208FC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 03:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6493208FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbeHWGqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 02:46:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:15091 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbeHWGqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 02:46:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2018 20:18:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,276,1531810800"; 
   d="gz'50?scan'50,208,50";a="82666489"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by fmsmga004.fm.intel.com with ESMTP; 22 Aug 2018 20:17:43 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fsg7r-000INR-PU; Thu, 23 Aug 2018 11:17:35 +0800
Date:   Thu, 23 Aug 2018 11:17:26 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     kbuild-all@01.org, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 1/9] of: add helper to lookup compatible child node
Message-ID: <201808231057.oOgtDWTB%fengguang.wu@intel.com>
References: <20180822105547.9634-2-johan@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20180822105547.9634-2-johan@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Johan,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.18 next-20180822]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Johan-Hovold/of-fix-compatible-child-node-lookups/20180823-074211
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: mips-decstation_defconfig (attached as .config)
compiler: mipsel-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=mips 

All errors (new ones prefixed by >>):

   In file included from include/linux/irqdomain.h:35:0,
                    from arch/mips/include/asm/irq.h:14,
                    from include/linux/irq.h:23,
                    from include/asm-generic/hardirq.h:13,
                    from arch/mips/include/asm/hardirq.h:16,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from arch/mips/dec/ecc-berr.c:16:
>> include/linux/of.h:637:28: error: 'of_get_compatible_child' defined but not used [-Werror=unused-function]
    static struct device_node *of_get_compatible_child(const struct device_node *parent,
                               ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors

vim +/of_get_compatible_child +637 include/linux/of.h

   636	
 > 637	static struct device_node *of_get_compatible_child(const struct device_node *parent,
   638						const char *compatible)
   639	{
   640		return NULL;
   641	}
   642	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--VbJkn9YxBvnuCH5J
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
vJIAAA==

--VbJkn9YxBvnuCH5J--
