Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F72EC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F7520882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="IcZfNnp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F7520882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeIMNsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:48:17 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45695 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbeIMNsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:48:17 -0400
Received: by mail-io1-f65.google.com with SMTP id e12-v6so2466126iok.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 01:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kEMMaT9ShUuziYzELVGnyZvzVHrNgakyUOlmM59MbvQ=;
        b=IcZfNnp+FQIGzU4id8zO+QuG9FUbgvzNWVqytltnqB+tUrQolW5c5wPoSlzLFEOYgn
         A90pI5Mya25AgAuT8NskTRK9SEMfNeK2CNvz3A29HQfxLFhyfifj9EQ9lJ9Cz98uoZhH
         rILAuD+QODK2DsqyUgxm3VPzEXbDJKNi9e+zp+t+1mJEe+AgRmtzxsgoPh6AXLZjqm9M
         dPzfE6SYgcBbw9ZachDHfkcTl2No0McbplFJ4qpyr/vF0kxeT+1cUVazq/+dTnynwJ+2
         LrvDmBmwvFTkKt8N0URICBNRdR/70JbOnk8Nj6RON1AMPaHqRDo7QBM7D4RCaMzwJYhF
         /hAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kEMMaT9ShUuziYzELVGnyZvzVHrNgakyUOlmM59MbvQ=;
        b=W6lCP0Rn13Vjym/WPEQ1DPif61c1hJ5YMVONSRWEg8p0V/HYzsSBHhfrnZLnExmx77
         Po5XpcQVBTH9kxqiYsJRo8sRQu2B5reAhJxTpJLPq8LdunIJb+vGQAkJPGvmfmg17jIJ
         kgWG8RkanDhNvd8wpf7dX1gtdvCUUBcmdBNwuQwNIKfwjmtHWo5/B53+bpA7NubajOyO
         3oDbpdSXPvL+eFyRwpWYm/BE9WPE7RPWDsQnMFZ5cyXonEWE/Xa9sU7lDdCLyMVQ5U0V
         QkpLopjyy55wY18uSB2nonegPg2ZCLKl6avDaEXeSZWW9ktzmPwAbC6Y26vzlCxjoaJy
         3VTQ==
X-Gm-Message-State: APzg51D5K5W+FffA6XL20PMwsj4I6UqdJTnfsY5qOVoi3EGDgxGC+jGi
        2V3ApjURJrcwAqEM4xvM2dyH+4raXeZwwNJJ7IyK3Q==
X-Google-Smtp-Source: ANB0VdY0EB02HRzOYuhI9AWugpZQ3NWPEXnnDHQDrtZXNKPEQfUTUWriJsfe82vxtIXxLkhar+Xej7KMgK68x0BoZM0=
X-Received: by 2002:a5e:a901:: with SMTP id c1-v6mr4749030iod.187.1536827988879;
 Thu, 13 Sep 2018 01:39:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1905:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 01:39:48
 -0700 (PDT)
In-Reply-To: <201809130920.Bfc949m8%fengguang.wu@intel.com>
References: <20180912075129.25185-9-brgl@bgdev.pl> <201809130920.Bfc949m8%fengguang.wu@intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 13 Sep 2018 10:39:48 +0200
Message-ID: <CAMRc=Med1gSg_ALsb_J2G5QXQ=438CiqG4GT-NYQT-uDF_cPHA@mail.gmail.com>
Subject: Re: [PATCH v3 08/21] nvmem: sunxi_sid: use devm_nvmem_register()
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-13 3:38 GMT+02:00 kbuild test robot <lkp@intel.com>:
> Hi Bartosz,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v4.19-rc3 next-20180912]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Bartosz-Golaszewski/nvmem-rework-of-the-subsystem-for-non-DT-users/20180913-071053
> config: arm-sunxi_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=arm
>
> All warnings (new ones prefixed by >>):
>
>    drivers/nvmem/sunxi_sid.c: In function 'sunxi_sid_probe':
>>> drivers/nvmem/sunxi_sid.c:190:18: warning: passing argument 1 of 'PTR_ERR' makes pointer from integer without a cast [-Wint-conversion]
>       return PTR_ERR(-EINVAL);
>                      ^
>    In file included from include/linux/kernfs.h:11:0,
>                     from include/linux/sysfs.h:16,
>                     from include/linux/kobject.h:20,
>                     from include/linux/device.h:16,
>                     from drivers/nvmem/sunxi_sid.c:18:
>    include/linux/err.h:29:33: note: expected 'const void *' but argument is of type 'int'
>     static inline long __must_check PTR_ERR(__force const void *ptr)
>                                     ^~~~~~~
>    drivers/nvmem/sunxi_sid.c:157:6: warning: unused variable 'ret' [-Wunused-variable]
>      int ret, i, size;
>          ^~~
>
> vim +/PTR_ERR +190 drivers/nvmem/sunxi_sid.c
>
>    150
>    151  static int sunxi_sid_probe(struct platform_device *pdev)
>    152  {
>    153          struct device *dev = &pdev->dev;
>    154          struct resource *res;
>    155          struct nvmem_device *nvmem;
>    156          struct sunxi_sid *sid;
>    157          int ret, i, size;
>    158          char *randomness;
>    159          const struct sunxi_sid_cfg *cfg;
>    160
>    161          sid = devm_kzalloc(dev, sizeof(*sid), GFP_KERNEL);
>    162          if (!sid)
>    163                  return -ENOMEM;
>    164
>    165          cfg = of_device_get_match_data(dev);
>    166          if (!cfg)
>    167                  return -EINVAL;
>    168          sid->value_offset = cfg->value_offset;
>    169
>    170          res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>    171          sid->base = devm_ioremap_resource(dev, res);
>    172          if (IS_ERR(sid->base))
>    173                  return PTR_ERR(sid->base);
>    174
>    175          size = cfg->size;
>    176
>    177          econfig.size = size;
>    178          econfig.dev = dev;
>    179          if (cfg->need_register_readout)
>    180                  econfig.reg_read = sun8i_sid_read_by_reg;
>    181          else
>    182                  econfig.reg_read = sunxi_sid_read;
>    183          econfig.priv = sid;
>    184          nvmem = devm_nvmem_register(dev, &econfig);
>    185          if (IS_ERR(nvmem))
>    186                  return PTR_ERR(nvmem);
>    187
>    188          randomness = kzalloc(size, GFP_KERNEL);
>    189          if (!randomness)
>  > 190                  return PTR_ERR(-EINVAL);

Will fix in v4. I think this should also return -ENOMEM, not -EINVAL.

Bart

>    191
>    192          for (i = 0; i < size; i++)
>    193                  econfig.reg_read(sid, i, &randomness[i], 1);
>    194
>    195          add_device_randomness(randomness, size);
>    196          kfree(randomness);
>    197
>    198          platform_set_drvdata(pdev, nvmem);
>    199
>    200          return 0;
>    201  }
>    202
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
