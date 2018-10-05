Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B842BC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A56220875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwIBxJpH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A56220875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbeJETDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 15:03:37 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33247 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbeJETDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 15:03:37 -0400
Received: by mail-lf1-f68.google.com with SMTP id o21-v6so9188409lfe.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 05:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m2cBRleoAZgTRa4+zpZ2p8UYhRqCDkfgraH1S7tW6nA=;
        b=QwIBxJpHCBwAmf8Hkk8ZRBlQ1jjU9zQ4vIsCmvZb+467p83QXEWYD8oBtkSP9Ta3pN
         3EGzz6tR+tRS5HvzRfthoIEuyWFTR6Huc0RexTFDD/St05Q1dTcIwnrA2BH6meg2o6/d
         xLM2O0RtNxAbptpGPTX5dpMbcoLqADvBfuuSixOO9mP+KWh/pCkapwISIINqGKSNRUks
         I11JpIHxTP/fw4kKBYC8PSdYm9FuLllv2xCjOvooHzRSmXohERNuWdsCTb43nMfmAlbX
         e09KheUS2bEAWnjcswi34J3RgHiPwzuR4eAaOvy5utJ2qjki/rsXiTsiT9ejCVwTGGjQ
         PmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m2cBRleoAZgTRa4+zpZ2p8UYhRqCDkfgraH1S7tW6nA=;
        b=m4wHlbZae9Xzn4PE5namin8ezKVTmCEjCciClH//Np5H/aKii7gTkMDrYg+tynK8c0
         gPm2SZBBk8blgxz18N8Fp6dt3l51BOudXLTWB+Gsd0zl3q2KaZUg947W2ExgrCrab5Wa
         6nMX1aedSklyrin/cWD6ekNpKPqgdg+CnQM1NoBIEDdflwadxPnVcQu9EsEI4Sg/cwL+
         Qaf+dr0BlY9WJ0EAy1dSc2qVMUPSUjR1w2JClXUT1bIWSOgMDNjTpCALrdDONxTmCIwt
         kqe3yeXIWDaC5Y+f9OebNhDa+fgjn1Klw3466Rv6s1rfXh0N+2CkLA8jEQaNMnBWhyHx
         Mdxw==
X-Gm-Message-State: ABuFfoiEpLiMfPjGYFX5kqRNCOKuZXl0W6KSWNE7V0co3qPPyNH2xBLK
        rGrzk4ky68b2mPqvhVNBOE5xbSeJG4AAeg3eirk=
X-Google-Smtp-Source: ACcGV63Ft4UqWwXMeO+MbTDEqZcwSoZZw/KoZjlJkBuAg61d0Uzx0nkapOzSQ0DgmZ5qv7Fj8hqBony7394PDrr/lrw=
X-Received: by 2002:a19:169d:: with SMTP id 29-v6mr6350799lfw.151.1538741109002;
 Fri, 05 Oct 2018 05:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20181004142942.11887-1-ricardo.ribalda@gmail.com>
 <20181004142942.11887-2-ricardo.ribalda@gmail.com> <20181005002125.12fd229f@bbrezillon>
 <CAPybu_26HST5xGfhE6MoVTRZok_gfDqN=ZOAesuEMVskdrCpLA@mail.gmail.com>
 <20181005090811.6b7e9957@bbrezillon> <CAPybu_38xH2Cv+eONQmEJ1i6k=oiQM=WrcwOFR29LbtRvWfKXA@mail.gmail.com>
 <20181005103730.57d52e3c@bbrezillon> <CAPybu_1RMcro3xLNW5mbybYdObCTq=QwXgk+RT6hcmRGTh6s7A@mail.gmail.com>
 <20181005121235.7e64b64a@bbrezillon>
In-Reply-To: <20181005121235.7e64b64a@bbrezillon>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Fri, 5 Oct 2018 14:04:52 +0200
Message-ID: <CAPybu_0TbeN+-F6zwN8XOMuY1EpgE6GRi=ExDx6O3Yun9kXjYQ@mail.gmail.com>
Subject: Re: [PATCH v10 10/10] mtd: maps: gpio-addr-flash: Add support for
 device-tree devices
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris
On Fri, Oct 5, 2018 at 12:12 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> On Fri, 5 Oct 2018 11:54:18 +0200
> Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:
>
> > Hi Boris
> >
> > Just seen that  you already did the rebase at
> > https://github.com/bbrezillon/linux-0day/commits/mtd/physmap-cleanup
> >
> > Thanks for that.
> >
> > I am about to test it in real hw (unless you want me wait)
>
> Sure, go ahead and test it.
>
> Thanks,
>
> Boris
I had to change this on your patchset to have it working on hw:
https://pastebin.com/78A7yhJ9

If you send the patchset to the mailing list I can review it patch by patch.

Also
mtd: maps: Prepare merging of physmap and physmap_of

I do not think that can be bisected. (Not sure, I have to test it)

I add the diff to the mail, but gmail will probably scramble the
lines(yes I know I have to use other mail client)

Thanks!



diff --git a/drivers/mtd/maps/physmap-core.c b/drivers/mtd/maps/physmap-core.c
index 2e236ef60e04..d7a902afc9a7 100644
--- a/drivers/mtd/maps/physmap-core.c
+++ b/drivers/mtd/maps/physmap-core.c
@@ -69,8 +69,6 @@ static int physmap_flash_remove(struct platform_device *dev)
  if (!info)
  return 0;

- physmap_data = dev_get_platdata(&dev->dev);
-
  if (info->cmtd) {
  err = mtd_device_unregister(info->cmtd);
  if (err)
@@ -80,12 +78,12 @@ static int physmap_flash_remove(struct platform_device *dev)
  mtd_concat_destroy(info->cmtd);
  }

- for (i = 0; i < info->nmaps; i++) {
- if (!info->mtds[i])
+ for (i = 0; i < info->nmaps; i++)
+ if (info->mtds[i])
  map_destroy(info->mtds[i]);
- }

- if (physmap_data->exit)
+ physmap_data = dev_get_platdata(&dev->dev);
+ if (physmap_data && physmap_data->exit)
  physmap_data->exit(dev);

  return 0;
@@ -456,18 +454,18 @@ static int physmap_flash_probe(struct
platform_device *dev)
  info->maps = devm_kzalloc(&dev->dev,
    sizeof(*info->maps) * info->nmaps,
    GFP_KERNEL);
- if (info->maps)
+ if (!info->maps)
  return -ENOMEM;

  info->mtds = devm_kzalloc(&dev->dev,
    sizeof(*info->mtds) * info->nmaps,
    GFP_KERNEL);
- if (info->mtds)
+ if (!info->mtds)
  return -ENOMEM;

  platform_set_drvdata(dev, info);

- info->gpios = devm_gpiod_get_array_optional(&dev->dev, "addr-gpios",
+ info->gpios = devm_gpiod_get_array_optional(&dev->dev, "addr",
      GPIOD_OUT_LOW);
  if (IS_ERR(info->gpios))
  return PTR_ERR(info->gpios);
@@ -480,14 +478,6 @@ static int physmap_flash_probe(struct platform_device *dev)
  err = physmap_flash_of_init(dev);
  if (err)
  err = physmap_flash_pdata_init(dev);
-
- if (err)
- return err;
-
- err = physmap_flash_of_init(dev);
- if (err)
- err = physmap_flash_pdata_init(dev);
-
  if (err)
  return err;

@@ -509,7 +499,6 @@ static int physmap_flash_probe(struct platform_device *dev)
  if (!info->maps[i].phys)
  info->maps[i].phys = res->start;

- info->maps[i].size = resource_size(res);
  info->win_order = get_bitmask_order(resource_size(res)) - 1;
  info->maps[i].size = BIT(info->win_order +
  (info->gpios ?





-- 
Ricardo Ribalda
