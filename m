Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8C7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0272075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cszzm5/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0272075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbeGRNZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:25:44 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33421 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729324AbeGRNZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:25:43 -0400
Received: by mail-vk0-f66.google.com with SMTP id y70-v6so2412488vkc.0;
        Wed, 18 Jul 2018 05:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ORGVMhNOGvEGIRzn92jpA1tCbA7lkMVuBvcCCkuWZVQ=;
        b=cszzm5/WgPY//Y3PL5PlrauKOYLhBbfDRdyQwVE+mHXhUIknpf1VLT5uFTjWJJNeum
         sQzHDcKEIhwqAmCkMKaHhJnGW4yLAU5WtzpTMXect2+7puCNostEfwz+hdASOjb1x5mz
         QsZ4SwRcc45kWSY9UNjCuhxvKmAYJGAdWQgxaMuVBFNb9SxkRG4+xxWMppzH31z8bHQe
         1qmv0tq3hKdmMVNt4dFzHfB4J3Ntb5h8GjtellZ1HJz9i0XbIO1N+n2qMUQBq38lQ1KK
         aDfTxiHekUHT2/ftQdaotxm3YuIFnYUrGMGJAIW/PPIW4QzRaxeCmAM/tFetHESH+yuV
         aP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ORGVMhNOGvEGIRzn92jpA1tCbA7lkMVuBvcCCkuWZVQ=;
        b=jz3m+kDx1jfmVy+gsB2m/IBWzkOehblx8ppu1TWSiBe3ng3ZFCAU14mhxCbSsCa+iZ
         nwORoAFuuVLNDkNg8/qNO2U+bOTZ4n3c2pSDKnke/TYfYY9JNGkodhbysBZDlhie4E+U
         eFjxtriiyVz/ZdwHxoJ6Fqw4Tv2eBaVORunTzxWnqgtjHR1VrBEkfP5OgqLfeYz9hK8s
         Y9V8HPv70gP3qVCIpCg6ol4phM32VPTdi3sEpthveXENgqar4K95xuGL3hR0hPbYX8CR
         tkOVIJzHK9zVPE0AnrnGrSDoawFz0B0g8HCtvER69BoS6AGC5lcS49XZuVN97Z7olMt6
         nmwA==
X-Gm-Message-State: AOUpUlG01Cm8oriiWt4jQvNodY7ZOPM/2C6UoC1+Syj5oShE1GWBoJLp
        Ymkj932Z08mks6qmIODcsZJ3rmBFpy3U70fL+d4D2g==
X-Google-Smtp-Source: AAOMgpfJQHYRdHxB4HdPk0/Ko/V208ta4qK6s0KBkC4Wx7u5sLQXZh9eCiDya3JUR9GwRnup1GZ8icgqttApBV3b904=
X-Received: by 2002:a1f:50c:: with SMTP id 12-v6mr3254739vkf.26.1531918076189;
 Wed, 18 Jul 2018 05:47:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 05:47:54
 -0700 (PDT)
In-Reply-To: <20180718094006.105675-3-giulio.benetti@micronovasrl.com>
References: <20180718094006.105675-1-giulio.benetti@micronovasrl.com> <20180718094006.105675-3-giulio.benetti@micronovasrl.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Jul 2018 15:47:54 +0300
Message-ID: <CAHp75VcaALb8fYJExnZ=Ye=GcNHc3aPXgFihVK+rAu_a1A01Sg@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] rtc: ds1307: add frequency_test_enable sysfs
 attribute to check tick on m41txx
To:     Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 12:40 PM, Giulio Benetti
<giulio.benetti@micronovasrl.com> wrote:
> On m41txx you can enable open-drain OUT pin to check if offset is ok.
> Enabling OUT pin with frequency_test_enable attribute, OUT pin will tick
> 512 times faster than 1s tick base.
>
> Enable or Disable FT bit on CONTROL register if freq_test is 1 or 0.

> +static ssize_t frequency_test_enable_store(struct device *dev,
> +                                          struct device_attribute *attr,
> +                                          const char *buf, size_t count)
> +{
> +       struct ds1307 *ds1307 = dev_get_drvdata(dev);


> +       bool freq_test_en = 0;

First of all, initialization of boolean using int is not very best style.
Second, this is not needed.

> +       int ret;
> +
> +       ret = kstrtobool(buf, &freq_test_en);

> +       if (ret == -EINVAL) {

What kind of other error code you may expect and why they are not
considered as no error?

> +               dev_err(dev, "Failed to store RTC Frequency Test attribute\n");
> +               return ret;
> +       }
> +
> +       regmap_update_bits(ds1307->regmap, M41TXX_REG_CONTROL, M41TXX_BIT_FT,
> +                          freq_test_en ? M41TXX_BIT_FT : 0);
> +
> +       return count;
> +}
> +
> +static ssize_t frequency_test_enable_show(struct device *dev,
> +                                         struct device_attribute *attr,
> +                                         char *buf)
> +{
> +       struct ds1307 *ds1307 = dev_get_drvdata(dev);
> +       unsigned int ctrl_reg;
> +
> +       regmap_read(ds1307->regmap, M41TXX_REG_CONTROL, &ctrl_reg);
> +

> +       if (ctrl_reg & M41TXX_BIT_FT)
> +               return scnprintf(buf, PAGE_SIZE, "on\n");
> +       else
> +               return scnprintf(buf, PAGE_SIZE, "off\n");

Entire condition might be one line.

> +}
> +

> +static int ds1307_add_frequency_test(struct ds1307 *ds1307)
> +{

> +       int err = 0;

Redundant assignment. See below.

> +
> +       switch (ds1307->type) {
> +       case m41t0:
> +       case m41t00:
> +       case m41t11:
> +               /* Export sysfs entries */
> +               err = sysfs_create_group(&(ds1307->dev)->kobj,
> +                                        &rtc_freq_test_attr_group);
> +               if (err) {
> +                       dev_err(ds1307->dev,
> +                               "Failed to create sysfs group: %d\n",
> +                               err);
> +                       return err;
> +               }
> +
> +               err = devm_add_action_or_reset(ds1307->dev,
> +                                              rtc_calib_remove_sysfs_group,
> +                                              ds1307->dev);
> +               if (err) {
> +                       dev_err(ds1307->dev,
> +                               "Failed to add sysfs cleanup action: %d\n",
> +                               err);
> +                       sysfs_remove_group(&(ds1307->dev)->kobj,
> +                                          &rtc_freq_test_attr_group);
> +                       return err;
> +               }
> +               break;
> +       default:
> +               break;
> +       }
> +

> +       return err;

return 0;

-- 
With Best Regards,
Andy Shevchenko
