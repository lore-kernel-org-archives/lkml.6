Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B81CC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55262081C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="bAIw4L5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55262081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbeLBWUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 17:20:42 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44651 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeLBWUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 17:20:41 -0500
Received: by mail-io1-f68.google.com with SMTP id r200so8817003iod.11
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 14:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7kz8kaWF7Kv2T4TuI2aZ/QGeznkKe29o+BBM4Y9DnWg=;
        b=bAIw4L5MLHG7hQ5iqgylg8DJXIOAXvPk28nvxTTeFkkAOifRkK3LzAS/RWdNhWZqDe
         nr51uLE3r++rQID/JT7olYOcLEobIeygyLPl/905kGR7VHHZGQzGDVEevPg0r02kXG43
         3I7OntwDhN1wdowTKzKmBdlPFkt9/z13nws1ikbxjYEUK33UwPbVxs2EKBuo1ha+eEze
         0jf57i9oG1J9DdeJ0UNJnOYjvE6oOTs5G2YO7OpY/rK3uT3MFWrKzctf2B8DGmmHM6YP
         JG5RgEvh8P4l3YA3Y/9t2emUuHQ0dtg9woTlGzq7xvj6Lf4U9WbBn63pM/JCBhgMC7yO
         EVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7kz8kaWF7Kv2T4TuI2aZ/QGeznkKe29o+BBM4Y9DnWg=;
        b=JGMZZ7eBfEgbIBHNQaMRY2rTJBpOogOxeJr3WzamtjXQzREh387DMmXWXh7wzG4ySJ
         yJC8g1Dy2a2IxsnmIRGDH8PEFAERSfQueC3H4jLpCe69dcrTcxw6Sa+rbasjQ/G7H610
         OP6mJT4/Jth8UtAqUOBRNor4GMB7bHAwaF7p3xHmw8+zL0hofinfK7H7PwgO8hs4AxXP
         DluurWSPUIiUE4OYXN5oI1o+tbhaJAxSsKQXbc7vmZNVCRTH7s0VDuGJgptal2fABVVl
         G+R1WWjmpfSWX7mF0z0PGv21v5aUxPnGOkNU+rJzo0EdpCQmWIKEWcdIB8o51ryeZ3CQ
         uJag==
X-Gm-Message-State: AA+aEWbDKhWyr9eR9rZgWcZh5VgnxvJRgHD6lqIbXkJETzmu63LkXpGB
        LP1AHVxRVbJM3w0XaBwpk3upOogh4RuS6Vues25sIg==
X-Google-Smtp-Source: AFSGD/XDHTbJAPS5zWEfTUeSJvn06ttmebZgU12m5SFNTIbKuyCvBgNYOTO7bQl86DbwUFC+l/WqUxQrhOWxEJLmGLM=
X-Received: by 2002:a5d:8c89:: with SMTP id g9mr12699670ion.111.1543789237868;
 Sun, 02 Dec 2018 14:20:37 -0800 (PST)
MIME-Version: 1.0
References: <20181120134032.31645-1-brgl@bgdev.pl> <20181120134032.31645-2-brgl@bgdev.pl>
 <20181120171742.gkwb4s4qbcqvnefj@pengutronix.de> <CAMRc=MfKf_f+x3Wt5gScA5yb78kbpphL87bi2arxcKKGjg1S7Q@mail.gmail.com>
 <20181121191509.ia2vcklvx4q2rh56@pengutronix.de> <CAMRc=Mef_O9ANUekZaz7vP7M2PpQFjZxJBoG8EPbXt6enRPL7g@mail.gmail.com>
 <20181125211854.idnqxz4pco3r7ydr@pengutronix.de> <CAMRc=Mfu=e3BsjMN=_H9CbUvumdmT1pvNjsyivTo1WN+LC1+2A@mail.gmail.com>
 <20181202215613.jcfrxwl4taiqgsql@pengutronix.de>
In-Reply-To: <20181202215613.jcfrxwl4taiqgsql@pengutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sun, 2 Dec 2018 23:20:27 +0100
Message-ID: <CAMRc=Me=FP537vMVx-jkuff2GqO66T+i3XUBza2Xb4oWzGNcLw@mail.gmail.com>
Subject: Re: [PATCH 1/2] irq/irq_sim: provide irq_sim_fire_edge()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

niedz., 2 gru 2018 o 22:56 Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
>
> Hello,
>
> On Thu, Nov 29, 2018 at 07:14:45PM +0100, Bartosz Golaszewski wrote:
> > We're getting too much into details of how to handle simulated
> > interrupts and we can continue discussing it, but meanwhile I'd like
> > to address a different thing:
> >
> > Thomas, Linus: after commit fa38869b0161 ("gpiolib: Don't support irq
> > sharing for userspace") some libgpiod tests are failing because we can
> > no longer depend on reading the value of a dummy GPIO after detecting
> > an interrupt to know the edge of the interrupt. While these interrupts
> > are triggered from debugfs and debugfs is not required to maintain
> > compatibility, I thing having a working test suite for the GPIO
> > subsystem and uAPI is worth applying these two patches and also the
> > previous one[1].
> >
> > Can we have them applied for 4.20 or are there any objections?
>
> Just for the record: I objected the patch, Bartosz agrees to discuss
> further and but because this is too much detail the patch should now be
> applied anyhow to fix the test suite of an external project. This seems
> wrong to me.
>

Just to look at it from a different perspective: we have a project
whose tests rely on a behavior that was changed by Uwe's patch. While
the patch is fine, we need to find a correct way of testing the GPIO
user API. This may take a long time. In order to not break the tests
of an external project in 4.20 I propose to patch the interrupt
simulator (a component only used for testing) for now and to revisit
it later without time pressure.

Best regards,
Bartosz
