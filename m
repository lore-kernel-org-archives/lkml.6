Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 86BE7C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C239208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C239208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935451AbeFMTZA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 15:25:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:54139 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935245AbeFMTY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 15:24:59 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2018 12:24:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,220,1526367600"; 
   d="scan'208";a="57047810"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jun 2018 12:24:54 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fTBNy-000OP7-Ka; Thu, 14 Jun 2018 03:24:50 +0800
Date:   Thu, 14 Jun 2018 03:23:53 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Borys Movchan <borys.movchan@axis.com>
Cc:     kbuild-all@01.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Borys Movchan <borysmn@axis.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeff LaBundy <jeff@labundy.com>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: add ISL29033 Ultra-Low Lux
 ambient-light-sensor
Message-ID: <201806140109.tvP88cyu%fengguang.wu@intel.com>
References: <20180613140043.5802-2-borys.movchan@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613140043.5802-2-borys.movchan@axis.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borys,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on iio/togreg]
[also build test WARNING on v4.17 next-20180613]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Borys-Movchan/dt-bindings-iio-light-add-ISL29033-device-bindings/20180613-220725
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/iio/light/isl29033.c:235:15: sparse: cast to restricted __be16
>> drivers/iio/light/isl29033.c:235:15: sparse: cast to restricted __be16
>> drivers/iio/light/isl29033.c:235:15: sparse: cast to restricted __be16
>> drivers/iio/light/isl29033.c:235:15: sparse: cast to restricted __be16

vim +235 drivers/iio/light/isl29033.c

   220	
   221	static int isl29033_read_sensor_input(struct isl29033_chip *chip)
   222	{
   223		int ret;
   224		u16 val;
   225		struct device *dev = regmap_get_device(chip->regmap);
   226	
   227		ret = regmap_bulk_read(chip->regmap, ISL29033_REG_ADD_DATA_LSB,
   228					(u8 *)&val, 2);
   229		if (ret < 0) {
   230			dev_err(dev,
   231				"Data bulk read error %d\n", ret);
   232			return ret;
   233		}
   234	
 > 235		val = be16_to_cpu(val);
   236		dev_vdbg(dev, "Data read: %x\n", val);
   237	
   238		return val;
   239	}
   240	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
