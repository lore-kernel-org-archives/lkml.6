Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC911C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30AE20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U0Se9BVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30AE20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeLEMUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:20:09 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42526 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbeLEMUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:20:09 -0500
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so18119260lja.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 04:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ylCZA5F9X8yIgHAk7WqnJ+3fsfxROm6NPDkBwyXHatY=;
        b=U0Se9BVLotgirsafeyt6bFhUvXu00VvjC6b2ONzCJU1WJs0VnFbbiAGfr05BHisAwr
         O09ru7jSVNdYnFhY6+1rYumWXz++aAsh45DhwkXSLLpP2Tb2zpaDHbZoioW8jYvC0fF5
         3OKaQKO4jtNMyqzLjH8ccBmcQADt4IEcZFbfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ylCZA5F9X8yIgHAk7WqnJ+3fsfxROm6NPDkBwyXHatY=;
        b=jHCA+/QEvnf9RY4Td6Ru2sS7EUR0YXQMl/iPKp9HTzcmDDWmb/tna0YGHSS5irXUYr
         ESDZvRFD049lN5LXi9J328s+hmbwvfZ60V8VNwv1vWw1a/+EgSG5FySvKP3TiWbA3CUg
         50LKkAvzy2AeCqnUyvWr5ARnTDWYv5Qctgq25SGGtaRCbfaja8FZriYLDxZicWt9JZ8u
         +TIZ7a6sxb1Wu4mKlm1rb7egYB4ka+CQzPwN2zTv5LiLNDNbsCc5On7c/az9fTN7ad01
         uLP1eQ396YOIeP9iL6gO0oFPd+UM+DgQ1gMfewnW1TMRPaYFpNBFXxSuc+/Kk6EQ3S4U
         R56A==
X-Gm-Message-State: AA+aEWYif84qyyNZeEm7zNa06OvIKeuyOyAP0WXMZWoWJUUdeN3peeZO
        G/hq4gUig+lbtQg7KZr9Y5asmNfOFH0eY1k6kxgpgA==
X-Google-Smtp-Source: AFSGD/V6zPdRmvlej3S6F7vLeO2Nvq5fVwcCLQsSSxB4ObfW10ZhgdexfdJMvfHb+HavwFOy+pzz0Iurl4Ce6ClhpB0=
X-Received: by 2002:a2e:29d7:: with SMTP id p84-v6mr15361354ljp.12.1544012407167;
 Wed, 05 Dec 2018 04:20:07 -0800 (PST)
MIME-Version: 1.0
References: <CAMRc=MfKf_f+x3Wt5gScA5yb78kbpphL87bi2arxcKKGjg1S7Q@mail.gmail.com>
 <20181121191509.ia2vcklvx4q2rh56@pengutronix.de> <CAMRc=Mef_O9ANUekZaz7vP7M2PpQFjZxJBoG8EPbXt6enRPL7g@mail.gmail.com>
 <20181125211854.idnqxz4pco3r7ydr@pengutronix.de> <CAMRc=Mfu=e3BsjMN=_H9CbUvumdmT1pvNjsyivTo1WN+LC1+2A@mail.gmail.com>
 <20181202215613.jcfrxwl4taiqgsql@pengutronix.de> <CAMRc=Me=FP537vMVx-jkuff2GqO66T+i3XUBza2Xb4oWzGNcLw@mail.gmail.com>
 <CAMRc=MeD-O5-7sBfrFn2rt27VHXwcOQ5cX2ybLHXU8kFyA_dLQ@mail.gmail.com>
 <20181203104923.gcb2bcsaoczjcjhk@pengutronix.de> <CAMRc=Me3srKHXLvdAVLAaVOyW79D378EGVh=dTXbCxo7FiyAsA@mail.gmail.com>
 <20181203110654.53o3prw3qu3u2uyf@pengutronix.de>
In-Reply-To: <20181203110654.53o3prw3qu3u2uyf@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 5 Dec 2018 13:19:54 +0100
Message-ID: <CACRpkdahWTts9Vz_vdC8dfd_HxCb3NmiFcwK=x-tVvFRcRm3tg@mail.gmail.com>
Subject: Re: [PATCH 1/2] irq/irq_sim: provide irq_sim_fire_edge()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 12:06 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Mon, Dec 03, 2018 at 11:57:26AM +0100, Bartosz Golaszewski wrote:

> > It used to live in the gpio-mockup driver and I generalized it
> > precisely because there was another driver - iio evgen - which was
> > doing basically the same thing. While I don't know if there'll be more
> > users (I'd guess it would be useful for testing purposes of other
> > subsystems) having the same functionality implemented once is better
> > than twice.
>
> The iio testing driver only needs the trigger and relies on an irq that
> then calls the registerd handler. The iio driver doesn't need to tune
> the edge sensitivity though and if your mockup driver just only calls
> the fire routine if the configured sensitivity justifies that,
> everything should work as expected.

Simulating edges in the generic IRQ simulator codes seems
generally useful to me, even if there is just one user now.

Certainly for any kind of IRQ testing, it could be interesting to
throw several low-to-high and high-to-low transitions
on a driver and see how it reacts.

But it is up to the irqchip maintainers to state whether they
agree.

Yours,
Linus Walleij
