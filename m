Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA611C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9305E208E2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="H9D18Di4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9305E208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeH0Mro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:47:44 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37878 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0Mro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:47:44 -0400
Received: by mail-io0-f196.google.com with SMTP id v14-v6so12219220iob.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 02:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=X/uABiPZ9yR2rK0DeZRSLuxLdEpUuLHriCvZnCoanUQ=;
        b=H9D18Di49M7tlhlYLSxjZ/m5C5URgBQfJnWoCM5hjJlQeIdodOE+8WLzd3yn+960LN
         Yh4GIVdL5OX5QQuVXbWn9rZTKkkYabBiYeXNsN8llr0zApneh2IOp0s+hOcl026dTLRd
         E+HL8f7hFlhab2kfsvpO8tVudKU+hCmmdv3AIqQfRuKVbh2wl41r8ifiscRok91aBvQJ
         vOF/za2oh/mEyh99w64zH/+QNVCROOgcPQ8pGhVpZQShX7Y+Ll+cbl0uSxHWEGfA9IcH
         GH+GNXDCsTx3g7AzxG4H1+NywsnzHTwPixd9t6qVe2A/mCzUdHL4/ht/QxhZbxRZbTeu
         BtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=X/uABiPZ9yR2rK0DeZRSLuxLdEpUuLHriCvZnCoanUQ=;
        b=D95c3uGArNMWzQZp5bnDDrxExw3CpdV6yK5lIxqAdP7BjV4TIvJgTWTisFltzCMDhH
         s56LmCF3oCrcoSJnJIfZVCL7j/uu12wwoV3s2gAQApDco/lblLquT5740IKQ7Rj8r83X
         CBawGpnr0rUuziiYWMI4QFkqvjFA605Ku4u9L7mVpCx4zQAkevsd1uEca6TyQFZjVVoQ
         6xjV7H4TMujT9Bs5mv90e5o24GjkfKfOz5jx0OAsdO2i5ydMHSjyVVKnOceaCg4bNKuX
         4aq0Iv9FyZAPydnDTpp3ckHrnQXcpSEyAp1GEHkOAq/8S+DD9HrwUcVrC7tNKwhqAMSg
         Xtrg==
X-Gm-Message-State: APzg51BO2IVBSSK9ci57UmhKz1dCy2TIzSujXpL7+/S8DC9GX17VYxHp
        1kYwXUvz4lhrfMztfMv8X0HLQNQnyPB74jldVbCHVA==
X-Google-Smtp-Source: ANB0VdauIfCrYQfVWvK0xpqAY085wPY8UGe4J3PsglRHKvoL3owgsORsCto59CV1k6G52+vyAvGNzbChcJM/CbJA3T0=
X-Received: by 2002:a5e:8d07:: with SMTP id m7-v6mr9221166ioj.258.1535360517629;
 Mon, 27 Aug 2018 02:01:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9402:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 02:01:57
 -0700 (PDT)
In-Reply-To: <4a576f65b8fb3a0e6f0ca662e89070eb982be298.camel@perches.com>
References: <20180827082101.5036-1-brgl@bgdev.pl> <4a576f65b8fb3a0e6f0ca662e89070eb982be298.camel@perches.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 27 Aug 2018 11:01:57 +0200
Message-ID: <CAMRc=McVQ6co1KispVNotLOj4t6Pok0F+j4X9eYnrpDTm-CYaQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] devres: provide devm_kstrdup_const()
To:     Joe Perches <joe@perches.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
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

2018-08-27 10:42 GMT+02:00 Joe Perches <joe@perches.com>:
> On Mon, 2018-08-27 at 10:21 +0200, Bartosz Golaszewski wrote:
>> Provide a resource managed version of kstrdup_const(). This variant
>> internally calls devm_kstrdup() on pointers that are outside of
>> .rodata section. Also provide a corresponding version of devm_kfree().
> []
>> diff --git a/mm/util.c b/mm/util.c
> []
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
>> + *
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
>
> Doesn't this lose constness and don't you get
> a compiler warning here?
>

Yes it does but for some reason gcc 6.3 didn't complain...

> The kstrdup_const function returns a const char *,
> why shouldn't this?
>

It probably should, I'll fix it for v2.

Bart
