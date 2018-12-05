Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D8CC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA65C2081B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O/xiM052"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA65C2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeLEMzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:55:19 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36820 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbeLEMzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:55:19 -0500
Received: by mail-lj1-f194.google.com with SMTP id g11-v6so18227166ljk.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 04:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MPhiphJkyHNBIRz2WygzOMtJhYXElRIR+7gk7YvqEEo=;
        b=O/xiM052FM7pBWm7Yr1COtbJkaSSVfTb9NO1X84k7pNpKVBZoiF3y2PICfyQA6Jal0
         SWAkHUU7RIrfSnGCu6NGiaMT4CMLR/ZFA3dqCfZpixAW3Kw3lpMlbZQgCq+iifPkthjh
         I2ZhsnoVox7TnyPuvSDPZmlVwyBtEaMtQLlWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MPhiphJkyHNBIRz2WygzOMtJhYXElRIR+7gk7YvqEEo=;
        b=ZqSSnlQT3ZI1YyJURGKCrwYe1oAIUrBOHPCdFvEj20i2f/KNqlrpVu4xz59rXDa3Kc
         XBhuQFdnQGDrT3tkQAaieLhFLcimU6FdlKDVXwrp52F8M0h6rNjGcH6DDD7lSukcnvJa
         S0VPO0AnNOuClM6BaQkF18yajjQ3jM+zu5H1Ux5sl5WyTMQiYSXxn+Qo50Dslfl/Ou9y
         LTN9lF6S+s7vatpKdktoCwrGaOddFj9b/QMfnE180BVjjfDswUHGtyC5rNNNoNBBsk+m
         WbYQfAE+08zLyyidMwyO9mrs1rKarE+LTsuSe3Sp7BW4/czhlufDqU+p0QttyEbvH/Jk
         G2MQ==
X-Gm-Message-State: AA+aEWZ5SDYM+3aKYitD19niSPr5C9e4IO+lZi65kcWnWrL6h7lQJJVb
        kf0rDAZdK3mMrUZ0v9Q0/K2rjJKZH6daeKL0Spc1JQ==
X-Google-Smtp-Source: AFSGD/XXZT0Uyd958fgHRW36Lra+egPmDHayMj75jhaktdmYGCHbUpH0ddYmhdWQ0rk/SfJ3ALxO2NJ05ivQkVgE+Tc=
X-Received: by 2002:a2e:29d7:: with SMTP id p84-v6mr15441917ljp.12.1544014516807;
 Wed, 05 Dec 2018 04:55:16 -0800 (PST)
MIME-Version: 1.0
References: <CAMRc=MfKf_f+x3Wt5gScA5yb78kbpphL87bi2arxcKKGjg1S7Q@mail.gmail.com>
 <20181121191509.ia2vcklvx4q2rh56@pengutronix.de> <CAMRc=Mef_O9ANUekZaz7vP7M2PpQFjZxJBoG8EPbXt6enRPL7g@mail.gmail.com>
 <20181125211854.idnqxz4pco3r7ydr@pengutronix.de> <CAMRc=Mfu=e3BsjMN=_H9CbUvumdmT1pvNjsyivTo1WN+LC1+2A@mail.gmail.com>
 <20181202215613.jcfrxwl4taiqgsql@pengutronix.de> <CAMRc=Me=FP537vMVx-jkuff2GqO66T+i3XUBza2Xb4oWzGNcLw@mail.gmail.com>
 <CAMRc=MeD-O5-7sBfrFn2rt27VHXwcOQ5cX2ybLHXU8kFyA_dLQ@mail.gmail.com>
 <20181203104923.gcb2bcsaoczjcjhk@pengutronix.de> <CAMRc=Me3srKHXLvdAVLAaVOyW79D378EGVh=dTXbCxo7FiyAsA@mail.gmail.com>
 <20181203110654.53o3prw3qu3u2uyf@pengutronix.de> <CACRpkdahWTts9Vz_vdC8dfd_HxCb3NmiFcwK=x-tVvFRcRm3tg@mail.gmail.com>
 <CAMpxmJWAZevmCkDDgLVTY5REGPB3HA5JAtNDtxT0NMt964GQCQ@mail.gmail.com>
In-Reply-To: <CAMpxmJWAZevmCkDDgLVTY5REGPB3HA5JAtNDtxT0NMt964GQCQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 5 Dec 2018 13:55:04 +0100
Message-ID: <CACRpkdZu_Pyd_FLYpRikpC4YTer4VjDhsmRZyfjyqrLoBgR+ww@mail.gmail.com>
Subject: Re: [PATCH 1/2] irq/irq_sim: provide irq_sim_fire_edge()
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 1:38 PM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:

> All that would be great, but at this point I just want to fix broken
> tests in user-space. After that we can think about how to
> improve/approach simulating interrupts all we want.

That is true. The other Linus is known to steamroll
maintainers who knowingly break userspace, so we have
a broad consensus not to do that, and I think
that holds no matter if the ABI user is a test or not,
debugfs or not.

Yours,
Linus Walleij
