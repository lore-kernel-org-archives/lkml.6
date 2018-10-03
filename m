Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4CAC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B7220684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DTvP6Df1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B7220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbeJCOmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:42:06 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42770 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbeJCOmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:42:05 -0400
Received: by mail-io1-f66.google.com with SMTP id n18-v6so4257843ioa.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 00:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3WgWF58AIzZi7hf4ydxtcmC4ODH8vSJiXmJ8/nCJZ84=;
        b=DTvP6Df1UBXdnm4OVmzpirkviixniaEY4IXA0i6w6N+sem4gOGK8HthclN/s7bRCja
         oG0J6iCro6SH4CYGILuSoT5RJPVpBAU4XXvNc9sjmcQXkSuEdHws9nLuhAylOWYGBKhv
         1vQh9SRjJcHqWH3t4kKkF9GNNXH04sGCMxt6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3WgWF58AIzZi7hf4ydxtcmC4ODH8vSJiXmJ8/nCJZ84=;
        b=UxlfnaFEdJCFKORFdivxj4qAuIc/Mkqz/lPinVAtOnBYMXZcbMahAEk1gtTE+ekwtD
         fJAYl4c9B1hJsK1P4G2IYQCrISAaWFGcUQbwx92vodW+fssxN/etTqgptvDelSR8Gvo5
         VjLvD6qhOzKlwADSdb1iLCFa+LdJ2fXAnf5XGsNDw7jxTPCXH+Eh4t2BGxRKn2Sba2wv
         H0JXUBMclILn7JUuJYI6YANdRmQHHdc6hED+FgXuRua+SWRiqtgAYf8FqopwWEa33J8N
         pNOIVds52wH9VfdVcHJwNhedUWiuysnSvlxS3QZYeKgdOHugO5NZI0kYQokHI38VqEzF
         DaNA==
X-Gm-Message-State: ABuFfoi3jfINfdjuu5oE1OQvmIXDCm+WL8RmdSHZmNfxkT6JYphv9PS6
        DvMTJ3YkSIv2aWigedTbytRPEG+Ep/ha4JYvL4VUOw==
X-Google-Smtp-Source: ACcGV62wHmoLSv+qfbLyIud0RGH9pp9pg6JwdbMgvbB77avs3pNbVQLxSX7MN5l3CG8csbcOsTrY1he6NcOS51lxN10=
X-Received: by 2002:a6b:630a:: with SMTP id p10-v6mr159000iog.175.1538553289591;
 Wed, 03 Oct 2018 00:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180925112946.30629-1-brgl@bgdev.pl>
In-Reply-To: <20180925112946.30629-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Oct 2018 09:54:36 +0200
Message-ID: <CACRpkdb0755w1cUQgfA=_Gf_oKSO=8+u9a8ni7L=0+HEppbkQA@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: mockup: use device properties instead of platform_data
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        vincent.whitchurch@axis.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 1:29 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> Some users want to introduce device tree support to the mockup driver.
> Let's make it easier by switching to using generic device properties.
> The driver stays compatible with previous use cases and after this
> conversion there'll be no need to change the way probing of mockup
> GPIO chips works.
>
> Tested with libgpiod test suite.
>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
> v1 -> v2:
> - dropped an unnecessary check when reading the base gpio number property

Patch applied.

Vincent, could you rebase your work on top of this
when/if you resend?

Yours,
Linus Walleij
