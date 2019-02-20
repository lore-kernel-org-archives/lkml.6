Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA35C10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B652147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="yWOynNFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfBTLVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:21:38 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:34894 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfBTLVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:21:37 -0500
Received: by mail-it1-f194.google.com with SMTP id v72so14605204itc.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 03:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j5fZZ7GesBgYBl4ma4xCECbC5ZArw2fFQ2HuTTgG+q4=;
        b=yWOynNFMC/qXqF/uctWasGhJsPA8ivj3BqmEbG+9GBk7ribtbyJg41q5ll8ghZ3Ywm
         pmzYdJb2wKSiE1OUltszTzucDs0ZVJ5tyN7yidSgr2FsJLKdIy1mbm0zHiU/1b0ojAJj
         dqoE3YokT/Vjp21+vttwaFJewd5miSBL4erGV8oz8cB7kH9kQqkD5fq+GKKUqPiWB5G9
         +NdQqePhmTna7eL1m6ZG4bB/RquHXCb7HmotosQL7jtvhR92lERMcqPqed/xKBkMCI6Q
         r9AVGJYbi5zBOJHLrv+FCIvc9gOAoV/WrsTqnPu2iTe9WymVUqGZnRdV+HkwRT6cN3Az
         R/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j5fZZ7GesBgYBl4ma4xCECbC5ZArw2fFQ2HuTTgG+q4=;
        b=Ez6MkCf4/6wyEAO3jF50J+QyFuKRLATxNQJD9i8G2P7IdmWG4YlSF5cyUrMmMhzX5V
         AutPKeaM6kQ2ie2O0vrG96jKfjVOMXOUScB9VCR/t2xdu4Iw/U8NqKb8MxsZh8ad+Sfr
         JkGSXBdE3w3ZsFelCXQYcmIrx1skaTQAKcO3WwmS8cEbTvT4733Knq67LmzW0QuReOSc
         F3pNIKkR2sHR3C3XZZ4JmhD5SRXoT9QvlRAtcjcqN3aPf3jMwpH+Ei0Tt7BiZMlHBVOw
         SHhjTPNKdLpivPcdd/xrFaYguIc1JeUwzOPllGI57YZxzoZQGZ5Ua8af/fmZxImbctbV
         VUUA==
X-Gm-Message-State: AHQUAuYrcOWa3IBuYeXqTrak9RCpNkef52jxiu5ZLv3mG3OBeEvAuKJo
        m26YTgUGC3ZvzJtn4gNLL4+YwhZkLqKNRjJNDLkEjg==
X-Google-Smtp-Source: AHgI3Ia4/+YcBC4CSos3zKlJmndSi7ockSHNx+vYv73jA9L1tMv+KIeYP26AHYYi9VsOUDyChUPmbcVRdMNQLB5Uhls=
X-Received: by 2002:a5e:de05:: with SMTP id e5mr21823824iok.111.1550661696997;
 Wed, 20 Feb 2019 03:21:36 -0800 (PST)
MIME-Version: 1.0
References: <20190220111240.10041-1-brgl@bgdev.pl> <20190220111240.10041-2-brgl@bgdev.pl>
 <20190220111650.GA13077@kroah.com>
In-Reply-To: <20190220111650.GA13077@kroah.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 20 Feb 2019 12:21:26 +0100
Message-ID: <CAMRc=MeXPsJCsKAnzUD7Cvhj2gy3pyd6X79e602awv3_Ys6mYA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drivers: provide devm_platform_ioremap_resource()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 20 lut 2019 o 12:16 Greg Kroah-Hartman
<gregkh@linuxfoundation.org> napisa=C5=82(a):
>
> On Wed, Feb 20, 2019 at 12:12:39PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > There are currently 1200+ instances of using platform_get_resource()
> > and devm_ioremap_resource() together in the kernel tree.
> >
> > This patch wraps these two calls in a single helper. Thanks to that
> > we don't have to declare a local variable for struct resource * and can
> > omit the redundant argument for resource type. We also have one
> > function call less.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>

Should this go through the driver-core tree?

Bart
