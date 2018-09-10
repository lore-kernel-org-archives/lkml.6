Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962D8C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DAFC2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DAFC2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbeIJRjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:39:48 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:4922 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727796AbeIJRjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:39:48 -0400
X-IronPort-AV: E=Sophos;i="5.53,355,1531778400"; 
   d="scan'208";a="278352467"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 14:45:48 +0200
Date:   Mon, 10 Sep 2018 14:45:47 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Bartosz Golaszewski <brgl@bgdev.pl>
cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Devang Panchal <devang.panchal@softnautics.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, kbuild-all@01.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 1/2] eeprom: eeprom_93xx46: use resource management
 (fwd)
Message-ID: <alpine.DEB.2.20.1809101444340.3655@hadrien>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Line 494 should be dropped.  The whole fail label could be dropped as
well.

julia

---------- Forwarded message ----------
Date: Mon, 10 Sep 2018 20:27:41 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 1/2] eeprom: eeprom_93xx46: use resource management

In-Reply-To: <20180910074404.8041-2-brgl@bgdev.pl>
References: <20180910074404.8041-2-brgl@bgdev.pl>

Hi Bartosz,

I love your patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on v4.19-rc2 next-20180906]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bartosz-Golaszewski/eeprom-eeprom_93xx46-use-resource-management/20180910-192124
:::::: branch date: 66 minutes ago
:::::: commit date: 66 minutes ago

>> drivers/misc/eeprom/eeprom_93xx46.c:494:1-6: WARNING: invalid free of devm_ allocated data

# https://github.com/0day-ci/linux/commit/d51b089674382bcc4f773d88ecd7c76d5ce472f7
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout d51b089674382bcc4f773d88ecd7c76d5ce472f7
vim +494 drivers/misc/eeprom/eeprom_93xx46.c

c074abe02 Cory Tusar          2016-01-06  423
80c8ae289 Bill Pemberton      2012-11-19  424  static int eeprom_93xx46_probe(struct spi_device *spi)
06b4501e8 Anatolij Gustschin  2011-07-25  425  {
06b4501e8 Anatolij Gustschin  2011-07-25  426  	struct eeprom_93xx46_platform_data *pd;
06b4501e8 Anatolij Gustschin  2011-07-25  427  	struct eeprom_93xx46_dev *edev;
06b4501e8 Anatolij Gustschin  2011-07-25  428  	int err;
06b4501e8 Anatolij Gustschin  2011-07-25  429
c074abe02 Cory Tusar          2016-01-06  430  	if (spi->dev.of_node) {
c074abe02 Cory Tusar          2016-01-06  431  		err = eeprom_93xx46_probe_dt(spi);
c074abe02 Cory Tusar          2016-01-06  432  		if (err < 0)
c074abe02 Cory Tusar          2016-01-06  433  			return err;
c074abe02 Cory Tusar          2016-01-06  434  	}
c074abe02 Cory Tusar          2016-01-06  435
06b4501e8 Anatolij Gustschin  2011-07-25  436  	pd = spi->dev.platform_data;
06b4501e8 Anatolij Gustschin  2011-07-25  437  	if (!pd) {
06b4501e8 Anatolij Gustschin  2011-07-25  438  		dev_err(&spi->dev, "missing platform data\n");
06b4501e8 Anatolij Gustschin  2011-07-25  439  		return -ENODEV;
06b4501e8 Anatolij Gustschin  2011-07-25  440  	}
06b4501e8 Anatolij Gustschin  2011-07-25  441
d51b08967 Bartosz Golaszewski 2018-09-10  442  	edev = devm_kzalloc(&spi->dev, sizeof(*edev), GFP_KERNEL);
06b4501e8 Anatolij Gustschin  2011-07-25  443  	if (!edev)
06b4501e8 Anatolij Gustschin  2011-07-25  444  		return -ENOMEM;
06b4501e8 Anatolij Gustschin  2011-07-25  445
06b4501e8 Anatolij Gustschin  2011-07-25  446  	if (pd->flags & EE_ADDR8)
06b4501e8 Anatolij Gustschin  2011-07-25  447  		edev->addrlen = 7;
06b4501e8 Anatolij Gustschin  2011-07-25  448  	else if (pd->flags & EE_ADDR16)
06b4501e8 Anatolij Gustschin  2011-07-25  449  		edev->addrlen = 6;
06b4501e8 Anatolij Gustschin  2011-07-25  450  	else {
06b4501e8 Anatolij Gustschin  2011-07-25  451  		dev_err(&spi->dev, "unspecified address type\n");
06b4501e8 Anatolij Gustschin  2011-07-25  452  		err = -EINVAL;
06b4501e8 Anatolij Gustschin  2011-07-25  453  		goto fail;
06b4501e8 Anatolij Gustschin  2011-07-25  454  	}
06b4501e8 Anatolij Gustschin  2011-07-25  455
06b4501e8 Anatolij Gustschin  2011-07-25  456  	mutex_init(&edev->lock);
06b4501e8 Anatolij Gustschin  2011-07-25  457
dd69a18ae Mark Brown          2016-04-20  458  	edev->spi = spi;
06b4501e8 Anatolij Gustschin  2011-07-25  459  	edev->pdata = pd;
06b4501e8 Anatolij Gustschin  2011-07-25  460
1c4b6e2c7 Andrew Lunn         2016-02-26  461  	edev->size = 128;
1c4b6e2c7 Andrew Lunn         2016-02-26  462  	edev->nvmem_config.name = dev_name(&spi->dev);
1c4b6e2c7 Andrew Lunn         2016-02-26  463  	edev->nvmem_config.dev = &spi->dev;
1c4b6e2c7 Andrew Lunn         2016-02-26  464  	edev->nvmem_config.read_only = pd->flags & EE_READONLY;
1c4b6e2c7 Andrew Lunn         2016-02-26  465  	edev->nvmem_config.root_only = true;
1c4b6e2c7 Andrew Lunn         2016-02-26  466  	edev->nvmem_config.owner = THIS_MODULE;
1c4b6e2c7 Andrew Lunn         2016-02-26  467  	edev->nvmem_config.compat = true;
1c4b6e2c7 Andrew Lunn         2016-02-26  468  	edev->nvmem_config.base_dev = &spi->dev;
a8ab316ab Srinivas Kandagatla 2016-04-24  469  	edev->nvmem_config.reg_read = eeprom_93xx46_read;
a8ab316ab Srinivas Kandagatla 2016-04-24  470  	edev->nvmem_config.reg_write = eeprom_93xx46_write;
a8ab316ab Srinivas Kandagatla 2016-04-24  471  	edev->nvmem_config.priv = edev;
a8ab316ab Srinivas Kandagatla 2016-04-24  472  	edev->nvmem_config.stride = 4;
a8ab316ab Srinivas Kandagatla 2016-04-24  473  	edev->nvmem_config.word_size = 1;
a8ab316ab Srinivas Kandagatla 2016-04-24  474  	edev->nvmem_config.size = edev->size;
1c4b6e2c7 Andrew Lunn         2016-02-26  475
d51b08967 Bartosz Golaszewski 2018-09-10  476  	edev->nvmem = devm_nvmem_register(&spi->dev, &edev->nvmem_config);
1c4b6e2c7 Andrew Lunn         2016-02-26  477  	if (IS_ERR(edev->nvmem)) {
1c4b6e2c7 Andrew Lunn         2016-02-26  478  		err = PTR_ERR(edev->nvmem);
06b4501e8 Anatolij Gustschin  2011-07-25  479  		goto fail;
1c4b6e2c7 Andrew Lunn         2016-02-26  480  	}
06b4501e8 Anatolij Gustschin  2011-07-25  481
06b4501e8 Anatolij Gustschin  2011-07-25  482  	dev_info(&spi->dev, "%d-bit eeprom %s\n",
06b4501e8 Anatolij Gustschin  2011-07-25  483  		(pd->flags & EE_ADDR8) ? 8 : 16,
06b4501e8 Anatolij Gustschin  2011-07-25  484  		(pd->flags & EE_READONLY) ? "(readonly)" : "");
06b4501e8 Anatolij Gustschin  2011-07-25  485
06b4501e8 Anatolij Gustschin  2011-07-25  486  	if (!(pd->flags & EE_READONLY)) {
06b4501e8 Anatolij Gustschin  2011-07-25  487  		if (device_create_file(&spi->dev, &dev_attr_erase))
06b4501e8 Anatolij Gustschin  2011-07-25  488  			dev_err(&spi->dev, "can't create erase interface\n");
06b4501e8 Anatolij Gustschin  2011-07-25  489  	}
06b4501e8 Anatolij Gustschin  2011-07-25  490
5ba75b559 Jingoo Han          2013-04-05  491  	spi_set_drvdata(spi, edev);
06b4501e8 Anatolij Gustschin  2011-07-25  492  	return 0;
06b4501e8 Anatolij Gustschin  2011-07-25  493  fail:
06b4501e8 Anatolij Gustschin  2011-07-25 @494  	kfree(edev);
06b4501e8 Anatolij Gustschin  2011-07-25  495  	return err;
06b4501e8 Anatolij Gustschin  2011-07-25  496  }
06b4501e8 Anatolij Gustschin  2011-07-25  497

:::::: The code at line 494 was first introduced by commit
:::::: 06b4501e88ad10f02849a3f9d7408ed6ae15a53f misc/eeprom: add driver for microwire 93xx46 EEPROMs

:::::: TO: Anatolij Gustschin <agust@denx.de>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
