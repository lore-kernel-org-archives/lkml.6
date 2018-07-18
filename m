Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69263ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 200E620854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="Pbw2NfQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 200E620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbeGROoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:44:44 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:43112 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbeGROon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:44:43 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id CE320B00756
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 16:06:37 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:to:subject:subject; s=dkim; t=
        1531922796; x=1532786797; bh=c2+oOu6wsJAMOC3N2+BR2zsMWTmjHDsj7i+
        q4/WOCOk=; b=Pbw2NfQ2FZq4weVoidW1ZZctH1Yt+ecbs44pXrHlZ1gQ/5iZjnA
        eu0qfvBuL78Hy4sU8uvZxFczKIuoiCm9AX4FRGHezaB1TXhhDazc6Pxli1WBJ+y8
        7ZApLgOiKf/pOrtdAet98RlrNg4uNgY9JDd4T30++gQJzsFW1yZJy+do=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id L7Xz2DUTjaGp for <linux-kernel@vger.kernel.org>;
        Wed, 18 Jul 2018 16:06:36 +0200 (CEST)
Received: from [192.168.2.133] (62-11-51-166.dialup.tiscali.it [62.11.51.166])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id 7F878B00049;
        Wed, 18 Jul 2018 16:06:34 +0200 (CEST)
Subject: Re: [PATCH v9 4/4] rtc: ds1307: add frequency_test_enable sysfs
 attribute to check tick on m41txx
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180718094006.105675-1-giulio.benetti@micronovasrl.com>
 <20180718094006.105675-3-giulio.benetti@micronovasrl.com>
 <CAHp75VcaALb8fYJExnZ=Ye=GcNHc3aPXgFihVK+rAu_a1A01Sg@mail.gmail.com>
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <30d6b568-b785-ae93-9f56-d0a8b7e82901@micronovasrl.com>
Date:   Wed, 18 Jul 2018 16:06:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VcaALb8fYJExnZ=Ye=GcNHc3aPXgFihVK+rAu_a1A01Sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Il 18/07/2018 14:47, Andy Shevchenko ha scritto:
> On Wed, Jul 18, 2018 at 12:40 PM, Giulio Benetti
> <giulio.benetti@micronovasrl.com> wrote:
>> On m41txx you can enable open-drain OUT pin to check if offset is ok.
>> Enabling OUT pin with frequency_test_enable attribute, OUT pin will tick
>> 512 times faster than 1s tick base.
>>
>> Enable or Disable FT bit on CONTROL register if freq_test is 1 or 0.
> 
>> +static ssize_t frequency_test_enable_store(struct device *dev,
>> +                                          struct device_attribute *attr,
>> +                                          const char *buf, size_t count)
>> +{
>> +       struct ds1307 *ds1307 = dev_get_drvdata(dev);
> 
> 
>> +       bool freq_test_en = 0;
> 
> First of all, initialization of boolean using int is not very best style.
> Second, this is not needed.

Ok I remove initialization.

> 
>> +       int ret;
>> +
>> +       ret = kstrtobool(buf, &freq_test_en);
> 
>> +       if (ret == -EINVAL) {
> 
> What kind of other error code you may expect and why they are not
> considered as no error?

According to documentation, kstrtobool can only fail with -EINVAL.
See:
https://elixir.bootlin.com/linux/v4.18-rc5/source/lib/kstrtox.c#L332

> 
>> +               dev_err(dev, "Failed to store RTC Frequency Test attribute\n");
>> +               return ret;
>> +       }
>> +
>> +       regmap_update_bits(ds1307->regmap, M41TXX_REG_CONTROL, M41TXX_BIT_FT,
>> +                          freq_test_en ? M41TXX_BIT_FT : 0);
>> +
>> +       return count;
>> +}
>> +
>> +static ssize_t frequency_test_enable_show(struct device *dev,
>> +                                         struct device_attribute *attr,
>> +                                         char *buf)
>> +{
>> +       struct ds1307 *ds1307 = dev_get_drvdata(dev);
>> +       unsigned int ctrl_reg;
>> +
>> +       regmap_read(ds1307->regmap, M41TXX_REG_CONTROL, &ctrl_reg);
>> +
> 
>> +       if (ctrl_reg & M41TXX_BIT_FT)
>> +               return scnprintf(buf, PAGE_SIZE, "on\n");
>> +       else
>> +               return scnprintf(buf, PAGE_SIZE, "off\n");
> 
> Entire condition might be one line.

Right, I change it.

> 
>> +}
>> +
> 
>> +static int ds1307_add_frequency_test(struct ds1307 *ds1307)
>> +{
> 
>> +       int err = 0;
> 
> Redundant assignment. See below.

Ok.

> 
>> +
>> +       switch (ds1307->type) {
>> +       case m41t0:
>> +       case m41t00:
>> +       case m41t11:
>> +               /* Export sysfs entries */
>> +               err = sysfs_create_group(&(ds1307->dev)->kobj,
>> +                                        &rtc_freq_test_attr_group);
>> +               if (err) {
>> +                       dev_err(ds1307->dev,
>> +                               "Failed to create sysfs group: %d\n",
>> +                               err);
>> +                       return err;
>> +               }
>> +
>> +               err = devm_add_action_or_reset(ds1307->dev,
>> +                                              rtc_calib_remove_sysfs_group,
>> +                                              ds1307->dev);
>> +               if (err) {
>> +                       dev_err(ds1307->dev,
>> +                               "Failed to add sysfs cleanup action: %d\n",
>> +                               err);
>> +                       sysfs_remove_group(&(ds1307->dev)->kobj,
>> +                                          &rtc_freq_test_attr_group);
>> +                       return err;
>> +               }
>> +               break;
>> +       default:
>> +               break;
>> +       }
>> +
> 
>> +       return err;
> 
> return 0;

Ok.

Thanks

Giulio
