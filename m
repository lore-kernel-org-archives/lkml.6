Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62EFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5D0208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="TfmGIHmg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5D0208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeH0SPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:15:48 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:43660 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeH0SPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:15:48 -0400
Received: by mail-io0-f193.google.com with SMTP id y10-v6so12943726ioa.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 07:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BaOFoQl6DHDzuOJu8LPfRCgtPPF12Rh6t1zSvya2qF8=;
        b=TfmGIHmgzXvPi7OSuDK83NSOLfijjq9+nKXjpyZu/fm29pFCa4BiXk//w2VhlieCbM
         HvOO18xsbJed9EyVxml4zhe4v6LLvxvzup858wwOQbVfwWSo4yiROSiM1ImD7gfre9EC
         YPWD0SlczB6TWBj3UJ+kElNi8U2WEEnv25bLVK0uZvK6D3JD5QPM4RcitUWzW8Us1GSb
         3+yxBhLE8+iEPOj76x0FbCCFeB6wLMFA1F8WrLCK5VFenQShpogaavPT0/znJNDs98/c
         0iKr6R9IxVa36aPkii/IvTWR5PbEMsHPkqVL9m4oIsKcg85u/YkFoxB0WwhM7LwezIyZ
         Mnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BaOFoQl6DHDzuOJu8LPfRCgtPPF12Rh6t1zSvya2qF8=;
        b=uCm13COzXpOpWioY8VRjpnhuu+gj5/58TzWJNcPyhQK9wnK/hC2LjhHDPYdOum4W5v
         KDvGI9F6hb2L97CwOnwfOJ/V6ZTh5v8c/Sf/8luo4G9XVAuRAvGTfPt4Bu8IkPmCWCmX
         6iBfBxeBobkWg5P25RA+rYZBuwzpYZBkqO9Vj3b5tvquDSUdmeYciEsEfoRnM28HjAeI
         W+0E/IwjtXalEYFAYZcEB4qHEtvOJwBCml5PFSRLO+QWCZFFw5rRmX4mBQMMxKASw+AS
         HzsvRqFJaVU5OBOlLR6K152db3q3v9l6l4iW6MG5JdLKc3ohQWfmVXC46oMpPRyRdJV+
         qYng==
X-Gm-Message-State: APzg51C8ak6gZE0N0VXbYamsK5eSksk/zxw816SqTNQa6gr0ndJXiUrT
        XuHvb7drBNovhNqhrVzpwIUfyRDhCMnhAnLBGNlXDg==
X-Google-Smtp-Source: ANB0VdawUhwnbyDZyvLoQMtzwv8WAgW2PjbISF4bqsvt6C34tiMI8Azq+Gw8QUkWGno9uFXrJq9hizAVMt4UXFlc1es=
X-Received: by 2002:a6b:9157:: with SMTP id t84-v6mr10349932iod.187.1535380136343;
 Mon, 27 Aug 2018 07:28:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9402:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 07:28:55
 -0700 (PDT)
In-Reply-To: <20180827103353.GB13848@rapoport-lnx>
References: <20180827082101.5036-1-brgl@bgdev.pl> <20180827103353.GB13848@rapoport-lnx>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 27 Aug 2018 16:28:55 +0200
Message-ID: <CAMRc=MdZ_1Vk2c19L-spzOm=7UaDpaACriq4gzMxAvQz=noNgQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] devres: provide devm_kstrdup_const()
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joe Perches <joe@perches.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <guro@fb.com>,
        Huang Ying <ying.huang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-27 12:33 GMT+02:00 Mike Rapoport <rppt@linux.vnet.ibm.com>:
> On Mon, Aug 27, 2018 at 10:21:00AM +0200, Bartosz Golaszewski wrote:
>> Provide a resource managed version of kstrdup_const(). This variant
>> internally calls devm_kstrdup() on pointers that are outside of
>> .rodata section. Also provide a corresponding version of devm_kfree().
>>
>> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
>> ---
>>  include/linux/device.h |  2 ++
>>  mm/util.c              | 35 +++++++++++++++++++++++++++++++++++
>>  2 files changed, 37 insertions(+)
>>
>> diff --git a/include/linux/device.h b/include/linux/device.h
>> index 8f882549edee..f8f5982d26b2 100644
>> --- a/include/linux/device.h
>> +++ b/include/linux/device.h
>> @@ -693,7 +693,9 @@ static inline void *devm_kcalloc(struct device *dev,
>>       return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
>>  }
>>  extern void devm_kfree(struct device *dev, void *p);
>> +extern void devm_kfree_const(struct device *dev, void *p);
>>  extern char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp) __malloc;
>> +extern char *devm_kstrdup_const(struct device *dev, const char *s, gfp_t gfp);
>>  extern void *devm_kmemdup(struct device *dev, const void *src, size_t len,
>>                         gfp_t gfp);
>>
>> diff --git a/mm/util.c b/mm/util.c
>> index d2890a407332..6d1f41b5775e 100644
>> --- a/mm/util.c
>> +++ b/mm/util.c
>> @@ -39,6 +39,20 @@ void kfree_const(const void *x)
>>  }
>>  EXPORT_SYMBOL(kfree_const);
>>
>> +/**
>> + * devm_kfree_const - Resource managed conditional kfree
>> + * @dev: device this memory belongs to
>> + * @p: memory to free
>> + *
>> + * Function calls devm_kfree only if @p is not in .rodata section.
>> + */
>> +void devm_kfree_const(struct device *dev, void *p)
>> +{
>> +     if (!is_kernel_rodata((unsigned long)p))
>> +             devm_kfree(dev, p);
>> +}
>> +EXPORT_SYMBOL(devm_kfree_const);
>> +
>>  /**
>>   * kstrdup - allocate space for and copy an existing string
>>   * @s: the string to duplicate
>> @@ -78,6 +92,27 @@ const char *kstrdup_const(const char *s, gfp_t gfp)
>>  }
>>  EXPORT_SYMBOL(kstrdup_const);
>>
>> +/**
>> + * devm_kstrdup_const - resource managed conditional string duplication
>> + * @dev: device for which to duplicate the string
>> + * @s: the string to duplicate
>> + * @gfp: the GFP mask used in the kmalloc() call when allocating memory
>> + *
>> + * Function returns source string if it is in .rodata section otherwise it
>> + * fallbacks to devm_kstrdup.
>
> Please make it proper "Returns:" description and move to the end of the
> comment. See Documentation/doc-guide/kernel-doc.rst.
>

Sure.

>> + * Strings allocated by devm_kstrdup_const will be automatically freed when
>> + * the associated device is detached.
>> + */
>> +char *devm_kstrdup_const(struct device *dev, const char *s, gfp_t gfp)
>> +{
>> +     if (is_kernel_rodata((unsigned long)s))
>> +             return s;
>> +
>> +     return devm_kstrdup(dev, s, gfp);
>> +}
>> +EXPORT_SYMBOL(devm_kstrdup_const);
>> +
>
> The devm_ variants seem to belong to drivers/base/devres.c rather than
> mm/util.c
>

Not all devm_ variants live in drivers/base/devres.c, many subsystems
implement them locally. In this case we need to choose between
exporting is_kernel_rodata() and putting devm_kstrdup_const() in
mm/util.c. I chose the latter, since it's cleaner.

Bart

>>  /**
>>   * kstrndup - allocate space for and copy an existing string
>>   * @s: the string to duplicate
>> --
>> 2.18.0
>>
>
> --
> Sincerely yours,
> Mike.
>
