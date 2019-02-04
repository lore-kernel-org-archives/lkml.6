Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C54C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1985820823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiPvZ4Ir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731277AbfBDPTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:19:45 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42637 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbfBDPTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 10:19:45 -0500
Received: by mail-yw1-f65.google.com with SMTP id v201so139509ywa.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 07:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e/P+Dmskm5/T79y1RM6HJitZaFYs+4spZSVHLt7Gg2Y=;
        b=PiPvZ4Irmse56x/FCBJo1HeHmNRJAqZE7Eu+bCPwWzsj/1qPs2dwbRpDX4wp/fSQ5M
         kF13N6t9nuQziZrdrB8d2m3yqDaFAy4qG2T0JJ0Oyj0qyevBsetAe50TE7QRtMMzB/9j
         cPUvz9E/+eUMG9ndD2bn62ZKei4OXkZ2RiMMCV94/NNn6chnpQnaIKTENMOzA82kzjMg
         PhlADmutH+3FvXx7FpGvajJLIFRhASC7p0PJmrLS2wKpZXUqRpje6U845R+Z7gE3cS8u
         fGdbuIUue5BRjzGkZaGrs0l9qSJmf+AEjqpV3GwxlqApgw+NKSg5ZYA3456KJarg/dbK
         7q8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/P+Dmskm5/T79y1RM6HJitZaFYs+4spZSVHLt7Gg2Y=;
        b=Qqie5ASLONFkW+6U3MpypcXKclJwbdNZQ8v5wAnOomfKjgI3VipJ0HqKAbspueXFb4
         8etfM9m/mleKIqmEM+AQQqXBxPcY9FSjIrTk3+inJLqWnZ74rFFsriCTeg5iSQNPDihs
         hL5ANdsCHN+mqEPReQrCsHPnA1A2FsHHrD1wtqeMZp3+nDOo7oCGTmTABLcAtsqWkfIN
         db7JqSFYpXA1tgVcvhVzExbwObwg83HEgQRe7gaNZQY/W2PQaj1EQhiN0Yhy41M7ZBvE
         EjNPgnBUJJfGdwCOsUR57jlLE4cx7BPfQL3c1Buwvn2hXvssKAtEn2VT+k2Pjv+/ldV7
         O8uw==
X-Gm-Message-State: AHQUAuaav+b3NnxDVzyVMYUp6rPyj4hliibHdAKX45nxSuf6Rg10TfOJ
        TY0+xJoFWWzXGGFWtr1HGIy87M096SJf348VAww=
X-Google-Smtp-Source: AHgI3Ib6T1ivLDUH6mndr5WMnzFuC/mfL0q9Gf9SCyDb8gB90t035V2zpcMMDETIpb+sSrv4IBjfcEE6gDMLJtAXQ4k=
X-Received: by 2002:a0d:eb8a:: with SMTP id u132mr2044294ywe.36.1549293583573;
 Mon, 04 Feb 2019 07:19:43 -0800 (PST)
MIME-Version: 1.0
References: <201902031020.N1KyfneM%fengguang.wu@intel.com>
In-Reply-To: <201902031020.N1KyfneM%fengguang.wu@intel.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 4 Feb 2019 16:19:32 +0100
Message-ID: <CAJiuCcffL-sDLEaOtbS9VfrvH_1FGjkD-=8Se3z=UaZ36aynKw@mail.gmail.com>
Subject: Re: sound/soc//codecs/ak4118.c:297:2: error: implicit declaration of
 function 'gpiod_set_value'
To:     kbuild test robot <lkp@intel.com>
Cc:     Adrien Charruel <adrien.charruel@devialet.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There is a header missing "linux/gpio/consumer.h"

I will propose a patch.

Regards,
Clement

On Sun, 3 Feb 2019 at 03:43, kbuild test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f17b5f06cb92ef2250513a1e154c47b78df07d40
> commit: bf897b441bd3afdd43e19605df4fb5a105678664 ASoC: ak4118: Add support for AK4118 S/PDIF transceiver
> date:   3 months ago
> config: x86_64-randconfig-s0-02030926 (attached as .config)
> compiler: gcc-6 (Debian 6.5.0-2) 6.5.0 20181026
> reproduce:
>         git checkout bf897b441bd3afdd43e19605df4fb5a105678664
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> All errors (new ones prefixed by >>):
>
>    sound/soc//codecs/ak4118.c: In function 'ak4118_probe':
> >> sound/soc//codecs/ak4118.c:297:2: error: implicit declaration of function 'gpiod_set_value' [-Werror=implicit-function-declaration]
>      gpiod_set_value(ak4118->reset, 0);
>      ^~~~~~~~~~~~~~~
>    sound/soc//codecs/ak4118.c: In function 'ak4118_i2c_probe':
> >> sound/soc//codecs/ak4118.c:377:18: error: implicit declaration of function 'devm_gpiod_get' [-Werror=implicit-function-declaration]
>      ak4118->reset = devm_gpiod_get(&i2c->dev, "reset", GPIOD_OUT_HIGH);
>                      ^~~~~~~~~~~~~~
> >> sound/soc//codecs/ak4118.c:377:53: error: 'GPIOD_OUT_HIGH' undeclared (first use in this function)
>      ak4118->reset = devm_gpiod_get(&i2c->dev, "reset", GPIOD_OUT_HIGH);
>                                                         ^~~~~~~~~~~~~~
>    sound/soc//codecs/ak4118.c:377:53: note: each undeclared identifier is reported only once for each function it appears in
> >> sound/soc//codecs/ak4118.c:385:49: error: 'GPIOD_IN' undeclared (first use in this function)
>      ak4118->irq = devm_gpiod_get(&i2c->dev, "irq", GPIOD_IN);
>                                                     ^~~~~~~~
> >> sound/soc//codecs/ak4118.c:393:45: error: implicit declaration of function 'gpiod_to_irq' [-Werror=implicit-function-declaration]
>      ret = devm_request_threaded_irq(&i2c->dev, gpiod_to_irq(ak4118->irq),
>                                                 ^~~~~~~~~~~~
>    cc1: some warnings being treated as errors
>
> vim +/gpiod_set_value +297 sound/soc//codecs/ak4118.c
>
>    288
>    289  static int ak4118_probe(struct snd_soc_component *component)
>    290  {
>    291          struct ak4118_priv *ak4118 = snd_soc_component_get_drvdata(component);
>    292          int ret = 0;
>    293
>    294          ak4118->component = component;
>    295
>    296          /* release reset */
>  > 297          gpiod_set_value(ak4118->reset, 0);
>    298
>    299          /* unmask all int1 sources */
>    300          ret = regmap_write(ak4118->regmap, AK4118_REG_INT1_MASK, 0x00);
>    301          if (ret < 0) {
>    302                  dev_err(component->dev,
>    303                          "failed to write regmap 0x%x 0x%x: %d\n",
>    304                          AK4118_REG_INT1_MASK, 0x00, ret);
>    305                  return ret;
>    306          }
>    307
>    308          /* rx detect enable on all channels */
>    309          ret = regmap_write(ak4118->regmap, AK4118_REG_RX_DETECT, 0xff);
>    310          if (ret < 0) {
>    311                  dev_err(component->dev,
>    312                          "failed to write regmap 0x%x 0x%x: %d\n",
>    313                          AK4118_REG_RX_DETECT, 0xff, ret);
>    314                  return ret;
>    315          }
>    316
>    317          ret = snd_soc_add_component_controls(component, ak4118_iec958_controls,
>    318                                           ARRAY_SIZE(ak4118_iec958_controls));
>    319          if (ret) {
>    320                  dev_err(component->dev,
>    321                          "failed to add component kcontrols: %d\n", ret);
>    322                  return ret;
>    323          }
>    324
>    325          return 0;
>    326  }
>    327
>    328  static void ak4118_remove(struct snd_soc_component *component)
>    329  {
>    330          struct ak4118_priv *ak4118 = snd_soc_component_get_drvdata(component);
>    331
>    332          /* hold reset */
>    333          gpiod_set_value(ak4118->reset, 1);
>    334  }
>    335
>    336  static const struct snd_soc_component_driver soc_component_drv_ak4118 = {
>    337          .probe                  = ak4118_probe,
>    338          .remove                 = ak4118_remove,
>    339          .dapm_widgets           = ak4118_dapm_widgets,
>    340          .num_dapm_widgets       = ARRAY_SIZE(ak4118_dapm_widgets),
>    341          .dapm_routes            = ak4118_dapm_routes,
>    342          .num_dapm_routes        = ARRAY_SIZE(ak4118_dapm_routes),
>    343          .idle_bias_on           = 1,
>    344          .use_pmdown_time        = 1,
>    345          .endianness             = 1,
>    346          .non_legacy_dai_naming  = 1,
>    347  };
>    348
>    349  static const struct regmap_config ak4118_regmap = {
>    350          .reg_bits = 8,
>    351          .val_bits = 8,
>    352
>    353          .reg_defaults = ak4118_reg_defaults,
>    354          .num_reg_defaults = ARRAY_SIZE(ak4118_reg_defaults),
>    355
>    356          .cache_type = REGCACHE_NONE,
>    357          .max_register = AK4118_REG_MAX - 1,
>    358  };
>    359
>    360  static int ak4118_i2c_probe(struct i2c_client *i2c,
>    361                              const struct i2c_device_id *id)
>    362  {
>    363          struct ak4118_priv *ak4118;
>    364          int ret;
>    365
>    366          ak4118 = devm_kzalloc(&i2c->dev, sizeof(struct ak4118_priv),
>    367                                GFP_KERNEL);
>    368          if (ak4118 == NULL)
>    369                  return -ENOMEM;
>    370
>    371          ak4118->regmap = devm_regmap_init_i2c(i2c, &ak4118_regmap);
>    372          if (IS_ERR(ak4118->regmap))
>    373                  return PTR_ERR(ak4118->regmap);
>    374
>    375          i2c_set_clientdata(i2c, ak4118);
>    376
>  > 377          ak4118->reset = devm_gpiod_get(&i2c->dev, "reset", GPIOD_OUT_HIGH);
>    378          if (IS_ERR(ak4118->reset)) {
>    379                  ret = PTR_ERR(ak4118->reset);
>    380                  if (ret != -EPROBE_DEFER)
>    381                          dev_err(&i2c->dev, "Failed to get reset: %d\n", ret);
>    382                  return ret;
>    383          }
>    384
>  > 385          ak4118->irq = devm_gpiod_get(&i2c->dev, "irq", GPIOD_IN);
>    386          if (IS_ERR(ak4118->irq)) {
>    387                  ret = PTR_ERR(ak4118->irq);
>    388                  if (ret != -EPROBE_DEFER)
>    389                          dev_err(&i2c->dev, "Failed to get IRQ: %d\n", ret);
>    390                  return ret;
>    391          }
>    392
>  > 393          ret = devm_request_threaded_irq(&i2c->dev, gpiod_to_irq(ak4118->irq),
>    394                                          NULL, ak4118_irq_handler,
>    395                                          IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>    396                                          "ak4118-irq", ak4118);
>    397          if (ret < 0) {
>    398                  dev_err(&i2c->dev, "Fail to request_irq: %d\n", ret);
>    399                  return ret;
>    400          }
>    401
>    402          return snd_soc_register_component(&i2c->dev, &soc_component_drv_ak4118,
>    403                                            &ak4118_dai, 1);
>    404  }
>    405
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
