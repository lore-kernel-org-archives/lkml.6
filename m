Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A4DC5AE5A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF932075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPd0Ru2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF932075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030658AbeFSTzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:55:22 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:46425 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030472AbeFSTzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:55:21 -0400
Received: by mail-ua0-f193.google.com with SMTP id d7-v6so596646uam.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 12:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PVwpYuypUVxRoJZPJSQmTZrfJAjnYsAU40u1bgCpeFU=;
        b=JPd0Ru2OmW60A20rkaxrJdaZTstzHfCB1YyzdSw+BvtlL89x04uGzDAzuBcE4sm6Rw
         brk170hP/n7ABm2/YeOwJjrsc6A1CMbauheJXd0rFToNF2BHf10Fn1/8B9FsdRLsLv4G
         fBCjdMHaGwuwNXLx/H15dlVpld/bDvRoZmankcY9DLx59j+EwvK/ng+iURb/QLPuIirg
         6TCs6jYLwCDeHQw+bZjCpr1wmLqOWRBZJbnZicGloczWxKmLaQerhUwdb9bm0VeecfEK
         OFLXHqq9+PeR1bbtula4x9Du2s45C0H0kuuSLmQZOKqNVyWFiYl6B5E/q+xkOV7ldnDb
         7hvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PVwpYuypUVxRoJZPJSQmTZrfJAjnYsAU40u1bgCpeFU=;
        b=mTbCfDOGqtqjZqb2NlTP1ApUgFQ0z3MtlM6cLiDL5bvQ7J8BVNgizbk5hAaQ5W1WCH
         mHq6H8ywaUit3sJ+3vIzpm7EgC4w80N4QcLOv7/6tu46VkCRiIZqY8eCUwWp3PWFJSeG
         Q3JWVtmUPkQ6wOw5afhm4hrvEq7W2xsMmzMKyFmbw8Okr10fHkXHwBBa15tCzyiGI1Ig
         QBCXzmWRQL+by5OU9yW9qiCVycEC4rhqSFMFH2ka5DNILV3Da10tO4TmcTWiJgEN7qz7
         WPWGMI03FlItPrlb4mx6A2bkWE6lmo3ra/Y73RqeZ9fMNnYQOX3ZfahDx4h2ggxR9Tqi
         VpOg==
X-Gm-Message-State: APt69E2kY3heVHyf0V45pvdgGaQ8LuooDs8A+DAqZirFUlL4k898n6/r
        IVSkt33/QyLl/niMAgjhaolRfwvi+eBMA6+UCY0=
X-Google-Smtp-Source: ADUXVKJK92jxEBR9PP2ZuPsbHRC4PLLXsqqElKTZE7gJGzt5SJN41ILbGdS/QUA9dmV6NG/qrBrWByk7hh0zKeYoSBE=
X-Received: by 2002:ab0:15ad:: with SMTP id i42-v6mr11252651uae.199.1529438120517;
 Tue, 19 Jun 2018 12:55:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 12:55:20
 -0700 (PDT)
In-Reply-To: <CAHp75Vcn39N9rZ0UO3szGrODVLxek4X746uWs+RPXwy4i0s1Ug@mail.gmail.com>
References: <20180619183356.32106-1-javierm@redhat.com> <CAHp75Vcn39N9rZ0UO3szGrODVLxek4X746uWs+RPXwy4i0s1Ug@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 19 Jun 2018 22:55:20 +0300
Message-ID: <CAHp75VdpHdanWJmcwLBRTSDoDkbpPxuAGwwVO0hosXSRn4PUoA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] driver core: add a debugfs entry to show deferred devices
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 10:53 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jun 19, 2018 at 9:33 PM, Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> For debugging purposes it may be useful to know what are the devices whose
>> probe function was deferred. Add a debugfs entry showing that information.

>> +static int deferred_devs_open(struct inode *inode, struct file *file)
>> +{
>> +       return single_open(file, deferred_devs_show, inode->i_private);
>> +}
>> +
>> +static const struct file_operations deferred_devs_fops = {
>> +       .owner = THIS_MODULE,
>> +       .open = deferred_devs_open,
>> +       .read = seq_read,
>> +       .llseek = seq_lseek,
>> +       .release = single_release,
>> +};
>
> Isn't this DEFINE_SHOW_ATTRIBUTE() ?

Besides that, you are summoning Greg's dark side :-)
See below.

>> +       if (IS_ENABLED(CONFIG_DEBUG_FS)) {
>> +               deferred_devices = debugfs_create_file("deferred_devices",
>> +                                                      0444, NULL, NULL,
>> +                                                      &deferred_devs_fops);

>> +               if (!deferred_devices)
>> +                       return -ENOMEM;

This must not prevent the execution. So, the check introduces actually
a regression.

>> +       }

-- 
With Best Regards,
Andy Shevchenko
