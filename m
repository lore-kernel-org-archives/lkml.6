Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE61C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9A725A90
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aba8Xm4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9A725A90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752615AbeF1BQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 21:16:17 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36788 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752539AbeF1BQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 21:16:14 -0400
Received: by mail-wr0-f196.google.com with SMTP id f16-v6so3746471wrm.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 18:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z1vi6F0BWlLdHa5VN79jCgZfDph4cPj8mHS0FnSEau0=;
        b=Aba8Xm4CZ97rVrJlIIDIm+O2r8c3bHD7dYJzM1chIXZm6snaaPda7B3TN8FFMj5SI7
         hrzOOTClu7wOW603ziT9NV4cuXxEqAVzfusRf8dgHR4kO/YKFq/j8izwlSDHrhKJioVt
         mktxNDOML11GS0DbHQOdjCoA1ocEXi6uD9Uec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z1vi6F0BWlLdHa5VN79jCgZfDph4cPj8mHS0FnSEau0=;
        b=rsI9rnGUJrXLfDaoLBz8EI8TuMLcvCIWeLe1mXozIsHshk1WIpGpB/UcsUoc+0QEmc
         bKe7RYoDEeDX0ilNNAHvluFsBJY7xZmWCFGbKCVA8Bsw4Tl2aguyezIpvZORtJc2tnoN
         vOTG9pxQdrMU1QnpdeNIUmYSiQTVhtzfgqG28rm65cwvQLigJ+ZkCLkRBAV2F5VrncX8
         J2LqnoL57+ZVKN5fXl5AM9wfaDYOm8BJ+ooGxlZtWZPjc8MZ6mu0TmQL9xGx0Ya0rJeA
         NNd7qA6ZKXbaj9c+dYVYQ2Qiti/4EgARAyh4HU23aBeSB8Ha3oltbY1h0WYcnz3HrCEe
         Awcg==
X-Gm-Message-State: APt69E2yNE3bJNqo3d/L1X0ctwucDNC7KXJS+FFRy9xFFmJ9OZUrTrNy
        QnOf9pmQRqu8CBKA+H1PiDSNTMx1EmvOCrBViOYphg==
X-Google-Smtp-Source: AAOMgpcplMaAmEWVtA1dn46P/tXEHPqwyNYXpiebDk2384L00Ugua6Uzj6ycSzZyaSgNxnlaZ9cvqVK074xGR8D/VDs=
X-Received: by 2002:adf:e311:: with SMTP id b17-v6mr7188423wrj.158.1530148573469;
 Wed, 27 Jun 2018 18:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180606174424.9630-1-rafael.tinoco@linaro.org> <CACRpkdZ82RNta7LGp4OB=6TY_q3mdqGGDedayz-C4hB9m7WG9Q@mail.gmail.com>
In-Reply-To: <CACRpkdZ82RNta7LGp4OB=6TY_q3mdqGGDedayz-C4hB9m7WG9Q@mail.gmail.com>
From:   Rafael Tinoco <rafael.tinoco@linaro.org>
Date:   Wed, 27 Jun 2018 22:15:37 -0300
Message-ID: <CADtBP2CzQ7_ad53ZnC_5w5gmaQdSeB8VxDEtW13fZye_OGWzug@mail.gmail.com>
Subject: Re: [PATCH] selftests: gpio: gpio-mockup-chardev GPIOHANDLE_REQUEST_OUTPUT
 fix
To:     linus.walleij@linaro.org
Cc:     brgl@bgdev.pl, bamv2005@gmail.com, shuah@kernel.org,
        linux-gpio@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Bartosz,

This was discovered during our investigations of a functional tests
regression/error:

https://bugs.linaro.org/show_bug.cgi?id=3769

Which turned out to be related to missing CONFIG_ARM{64}_MODULE_PLTS
config in our builds.

However, during investigations, we realized the functional test had
the issues best described in comment:

https://bugs.linaro.org/show_bug.cgi?id=3769#c3

Related to errno variable being considered outside the error scope.

Thank you
Rafael

On Thu, 14 Jun 2018 at 11:42, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Jun 6, 2018 at 7:44 PM, Rafael David Tinoco
> <rafael.tinoco@linaro.org> wrote:
>
> > Following logic from commit: 22f6592b23, GPIOHANDLE_REQUEST_OUTPUT
> > should handle errors same way as GPIOHANDLE_REQUEST_INPUT does, or else
> > the following error occurs:
> >
> > gpio-mockup-chardev: gpio<gpiochip1> line<0> test flag<0x2> value<0>: No
> > such file or directory
> >
> > despite the real result of gpio_pin_test(), gpio_debugfs_get() and
> > gpiotools_request_linehandle() functions.
> >
> > Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
>
> Bartosz, does this look OK to you?
>
> Yours,
> Linus Walleij
