Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064E4C37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DB320861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="i+M98hlX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfAUUz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:55:59 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43742 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfAUUz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:55:59 -0500
Received: by mail-oi1-f195.google.com with SMTP id u18so15607683oie.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 12:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OKBB/nbJ0k8tun2GicnRPygSL370rUx/qPCIojnYS0w=;
        b=i+M98hlX6664mZd9+nua5s9g6bLxv0FGNXsz3McPTtf/FwqdnjsxGesCDOxtWv3b8k
         EMOqYulUZbIz2lLdzeMG8zMkRUgNOAyd0L32iG6TOGq8jZqo1RP7xG+8G6SPv7dBIZpQ
         1IuBlAoiTp8fJFPhhEQJHrnKI7bGZbJoO8k7uhtDAExivTGAqO1bNqZBUY0kTNEIFiV2
         zzAjdq7/FSEeR3LZsHhnn8BxeNl4P1dXj61mwAKAUsrYWvypCKd61W3UUnWf1jZZnKkJ
         +uSJrrBp1Q1Kj9db9BnnDIr0w+bkypMmexcOmZlYTpR1aSq/uXlEQA2Ahh0UCY4kgLRX
         9asg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OKBB/nbJ0k8tun2GicnRPygSL370rUx/qPCIojnYS0w=;
        b=aa3VKNtRPMJGyPCQpOHxOMhmkcI1FFKmTAae/bBUjevUKpiy3Hvjt6j+EmpLto6Rn0
         3wdMnwzoVSwZMaqU5c8aYbYOMzQrVD4hnyfq9go6Jpt+hZ1Ts7/z4UaHZ6Q50Gq2/NTp
         JuDV6mR1PFoTtk8txFzEndsIEFzESLTV72K6z4yDOH5IiMNqBY1QQ4AnmSIjLvtPFj9w
         SBGjmFbKkKfPnEZKhIiU4riA0ohbTDP0zm3SnjtEPmbGuJLE+HAMozNxuBc2xAHRsJPh
         cRKGdF25eeOEgCALunflRZIw4VJ1oszhCPWO8cAh0cHLdVno7xExItwaWnYWumX0UTaI
         c6Xw==
X-Gm-Message-State: AJcUukfrF4NzTTb+9l3bI9x1cy8jvK7rAwxZ6cPawvhFtPTUBBM1li26
        /vNgMuYEQE7CvteGKt/f9vmOVRLVzC6l5V56928=
X-Google-Smtp-Source: ALg8bN4X1zBlAOtMn3AK2UnD6WwjYDQBNQMWLd6229NDPn97fNAKJngoaxEUjD8Ikm67FEJxdtNL0qtx0r4PzhWdrhQ=
X-Received: by 2002:aca:5b43:: with SMTP id p64mr6309612oib.41.1548104158237;
 Mon, 21 Jan 2019 12:55:58 -0800 (PST)
MIME-Version: 1.0
References: <20190121183723.25231-1-martin.blumenstingl@googlemail.com> <20190121191816.GH12679@sirena.org.uk>
In-Reply-To: <20190121191816.GH12679@sirena.org.uk>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 21 Jan 2019 21:55:47 +0100
Message-ID: <CAFBinCDK92yZZFzkoZriCSObm+jf1=RQ99K4uAGSCKSnTXhURA@mail.gmail.com>
Subject: Re: [PATCH 0/1] pwm-regulator: reduce noise on EPROBE_DEFER
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        boris.brezillon@free-electrons.com, thierry.reding@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Mon, Jan 21, 2019 at 8:18 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Jan 21, 2019 at 07:37:22PM +0100, Martin Blumenstingl wrote:
> > pwm-regulator can be a bit noisy during boot.
> >
> > One example are the 32-bit Amlogic SoCs when using
> > multi_v7_defconfig (which has CONFIG_REGULATOR_PWM=y and
>
> Please don't send cover letters for single patches, if there is anything
> that needs saying put it in the changelog of the patch or after the ---
> if it's administrative stuff.  This reduces mail volume and ensures that
> any important information is recorded in the changelog rather than being
> lost.
noted - sorry for the noise.

the patch description already contains all relevant information, so I
won't re-send the patch.
only the KernelCI link is not included because I'm not sure how long
it's valid (instead the description includes all relevant information
which also can be seen in the KernelCI link)


Regards
Martin
