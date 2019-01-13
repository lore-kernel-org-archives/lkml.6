Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03768C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 23:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D6820663
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 23:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfAMXPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 18:15:36 -0500
Received: from mga11.intel.com ([192.55.52.93]:37728 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfAMXPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 18:15:35 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2019 15:00:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,475,1539673200"; 
   d="gz'50?scan'50,208,50";a="134267866"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jan 2019 15:00:27 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1giojz-000HOG-3Y; Mon, 14 Jan 2019 07:00:27 +0800
Date:   Mon, 14 Jan 2019 06:59:21 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        himanshujha199640@gmail.com, mark.rutland@arm.com,
        robh+dt@kernel.org, pmeerw@pmeerw.net, lars@metafoo.de,
        knaack.h@gmx.de, jic23@kernel.org,
        Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
Subject: Re: [PATCH 1/2] iio: chemical: bme680: Add device-tree support
Message-ID: <201901140642.gVr4dS33%fengguang.wu@intel.com>
References: <20190111193141.20607-1-sebastien.bourdelin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <20190111193141.20607-1-sebastien.bourdelin@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Sebastien,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on iio/togreg]
[also build test ERROR on v5.0-rc1 next-20190111]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sebastien-Bourdelin/iio-chemical-bme680-Add-device-tree-support/20190114-063618
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: i386-randconfig-x007-201902 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/acpi.h:41:0,
                    from drivers/iio/chemical/bme680_spi.c:7:
   include/linux/module.h:213:1: error: expected ',' or ';' before 'extern'
    extern typeof(name) __mod_##type##__##name##_device_table  \
    ^
>> drivers/iio/chemical/bme680_spi.c:117:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
    MODULE_DEVICE_TABLE(of, bme680_of_spi_match);
    ^~~~~~~~~~~~~~~~~~~
>> drivers/iio/chemical/bme680_spi.c:123:22: error: implicit declaration of function 'of_match_ptr'; did you mean 'hash_ptr'? [-Werror=implicit-function-declaration]
      .of_match_table  = of_match_ptr(bme680_of_spi_match),
                         ^~~~~~~~~~~~
                         hash_ptr
>> drivers/iio/chemical/bme680_spi.c:123:22: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
   drivers/iio/chemical/bme680_spi.c:123:22: note: (near initialization for 'bme680_spi_driver.driver.of_match_table')
>> drivers/iio/chemical/bme680_spi.c:123:22: error: initializer element is not constant
   drivers/iio/chemical/bme680_spi.c:123:22: note: (near initialization for 'bme680_spi_driver.driver.of_match_table')
   cc1: some warnings being treated as errors

vim +123 drivers/iio/chemical/bme680_spi.c

   > 7	#include <linux/acpi.h>
     8	#include <linux/module.h>
     9	#include <linux/regmap.h>
    10	#include <linux/spi/spi.h>
    11	
    12	#include "bme680.h"
    13	
    14	static int bme680_regmap_spi_write(void *context, const void *data,
    15					   size_t count)
    16	{
    17		struct spi_device *spi = context;
    18		u8 buf[2];
    19	
    20		memcpy(buf, data, 2);
    21		/*
    22		 * The SPI register address (= full register address without bit 7)
    23		 * and the write command (bit7 = RW = '0')
    24		 */
    25		buf[0] &= ~0x80;
    26	
    27		return spi_write_then_read(spi, buf, 2, NULL, 0);
    28	}
    29	
    30	static int bme680_regmap_spi_read(void *context, const void *reg,
    31					  size_t reg_size, void *val, size_t val_size)
    32	{
    33		struct spi_device *spi = context;
    34	
    35		return spi_write_then_read(spi, reg, reg_size, val, val_size);
    36	}
    37	
    38	static struct regmap_bus bme680_regmap_bus = {
    39		.write = bme680_regmap_spi_write,
    40		.read = bme680_regmap_spi_read,
    41		.reg_format_endian_default = REGMAP_ENDIAN_BIG,
    42		.val_format_endian_default = REGMAP_ENDIAN_BIG,
    43	};
    44	
    45	static int bme680_spi_probe(struct spi_device *spi)
    46	{
    47		const struct spi_device_id *id = spi_get_device_id(spi);
    48		struct regmap *regmap;
    49		unsigned int val;
    50		int ret;
    51	
    52		spi->bits_per_word = 8;
    53		ret = spi_setup(spi);
    54		if (ret < 0) {
    55			dev_err(&spi->dev, "spi_setup failed!\n");
    56			return ret;
    57		}
    58	
    59		regmap = devm_regmap_init(&spi->dev, &bme680_regmap_bus,
    60					  &spi->dev, &bme680_regmap_config);
    61		if (IS_ERR(regmap)) {
    62			dev_err(&spi->dev, "Failed to register spi regmap %d\n",
    63					(int)PTR_ERR(regmap));
    64			return PTR_ERR(regmap);
    65		}
    66	
    67		ret = regmap_write(regmap, BME680_REG_SOFT_RESET_SPI,
    68				   BME680_CMD_SOFTRESET);
    69		if (ret < 0) {
    70			dev_err(&spi->dev, "Failed to reset chip\n");
    71			return ret;
    72		}
    73	
    74		/* after power-on reset, Page 0(0x80-0xFF) of spi_mem_page is active */
    75		ret = regmap_read(regmap, BME680_REG_CHIP_SPI_ID, &val);
    76		if (ret < 0) {
    77			dev_err(&spi->dev, "Error reading SPI chip ID\n");
    78			return ret;
    79		}
    80	
    81		if (val != BME680_CHIP_ID_VAL) {
    82			dev_err(&spi->dev, "Wrong chip ID, got %x expected %x\n",
    83					val, BME680_CHIP_ID_VAL);
    84			return -ENODEV;
    85		}
    86		/*
    87		 * select Page 1 of spi_mem_page to enable access to
    88		 * to registers from address 0x00 to 0x7F.
    89		 */
    90		ret = regmap_write_bits(regmap, BME680_REG_STATUS,
    91					BME680_SPI_MEM_PAGE_BIT,
    92					BME680_SPI_MEM_PAGE_1_VAL);
    93		if (ret < 0) {
    94			dev_err(&spi->dev, "failed to set page 1 of spi_mem_page\n");
    95			return ret;
    96		}
    97	
    98		return bme680_core_probe(&spi->dev, regmap, id->name);
    99	}
   100	
   101	static const struct spi_device_id bme680_spi_id[] = {
   102		{"bme680", 0},
   103		{},
   104	};
   105	MODULE_DEVICE_TABLE(spi, bme680_spi_id);
   106	
   107	static const struct acpi_device_id bme680_acpi_match[] = {
   108		{"BME0680", 0},
   109		{},
   110	};
   111	MODULE_DEVICE_TABLE(acpi, bme680_acpi_match);
   112	
   113	static const struct of_device_id bme680_of_spi_match[] = {
   114		{ .compatible = "bosch,bme680", },
   115		{},
   116	}
 > 117	MODULE_DEVICE_TABLE(of, bme680_of_spi_match);
   118	
   119	static struct spi_driver bme680_spi_driver = {
   120		.driver = {
   121			.name			= "bme680_spi",
   122			.acpi_match_table	= ACPI_PTR(bme680_acpi_match),
 > 123			.of_match_table		= of_match_ptr(bme680_of_spi_match),
   124		},
   125		.probe = bme680_spi_probe,
   126		.id_table = bme680_spi_id,
   127	};
   128	module_spi_driver(bme680_spi_driver);
   129	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--0F1p//8PRICkK4MW
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
BiQ92lxXdRi/a2cu/3+LwX3X2tYBAA==

--0F1p//8PRICkK4MW--
