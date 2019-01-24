Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C455C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFDEA218A3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="aGq8QVh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfAXHrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 02:47:09 -0500
Received: from mail-io1-f52.google.com ([209.85.166.52]:44188 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfAXHrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 02:47:08 -0500
Received: by mail-io1-f52.google.com with SMTP id r200so3883287iod.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 23:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/vVgMBY/108aqd7Q7Qjb+nynJnLA/DdqLznqJKbTi8Y=;
        b=aGq8QVh7jNuIkN4z5UeamjxzJW8XX52tKQ6ftZu1LEgbJAo+yBmxDMcgOrMS/6Iisf
         S+qzFvB5QzvBiwUE80c6KT5hNJmnw9W6GiSLJRSKRUmRr+UjyR6s5utPtJ9q8UsVTay8
         pTZX4kjC8LXv5KEI/5hdYgtxoQazTAfrHxGiGsd1Y7V29Sa1iYzXQr5PlVXXvIo0lgag
         yhtS1AiPiArxu0zbe5rG/DmRzMeJuOX2gU2S/B3gDKxlXJNMEin85UKI3z7vjWFKnG6c
         +BxYLizTtBxoIu0qBE+m5p48rGdpSmBiqdHxGX5EDXOL7tHRtm2i9ITW72tU0AD7Dkpm
         ewUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/vVgMBY/108aqd7Q7Qjb+nynJnLA/DdqLznqJKbTi8Y=;
        b=UWdKBmi2DFRkuyg4x93W7V5yV0atlu6Vsa+lBoiL2TeBDFxzkGbflCwufTVwHKlt+x
         icLPCXOIN/1/jFdBtAjEmO3yajEtyuHfjpbNWypJdYY/WVYClA8cozmM3l+8EPVgD1fM
         CFJbM5V9M8al6aYJ8x5//155FgoeAyeJlK/dTAC2fPIWHqZUtBRhu4/kTHZVL/A3+nno
         wekkZpJmWzuPcqtoKDr0AzAkVnINp/wmbgMivcmVOSSImhb3qYIDC77RQh4820Aj1rD5
         VLbS815aGm/4xvq0yR4S60v7TbaBzPQrBnkKAV8InAbv5bX4lo76UJAqAAjtrpJr+pYA
         0o2w==
X-Gm-Message-State: AHQUAuYoVEygwP4vIj1GbXkpLF/sYRfH8gbhU5LRsCr+jRfzHQ/Y/Qsw
        J7dD5A8BITCVBtdUo3Vk5mycJssB8BWgk8uUYRoKcA==
X-Google-Smtp-Source: AHgI3IbJhaSMT8uIl52HSxMHTF7aGCG6T7A83nuhSl9Zvviq+BsIHAvBdKeaLPU9tl2grJzI9GuTU/rqwCXEGrwmrzk=
X-Received: by 2002:a5d:834e:: with SMTP id q14mr3199013ior.258.1548316027599;
 Wed, 23 Jan 2019 23:47:07 -0800 (PST)
MIME-Version: 1.0
References: <20190123141538.29408-1-brgl@bgdev.pl> <20190123141538.29408-4-brgl@bgdev.pl>
 <20190123191824.btuaq4s5rvc236n3@pengutronix.de>
In-Reply-To: <20190123191824.btuaq4s5rvc236n3@pengutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 24 Jan 2019 08:46:56 +0100
Message-ID: <CAMRc=Me58SFJOMxie5aTkOAHRqS7bjdOSAaZSY8wjPK7tntTfQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] irq/irq_sim: provide irq_sim_get_type()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 23 sty 2019 o 20:18 Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
>
> Hello Bartosz,
>
> On Wed, Jan 23, 2019 at 03:15:32PM +0100, Bartosz Golaszewski wrote:
> > Provide a helper that allows users to retrieve the configured flow type
> > of dummy interrupts. That allows certain users to decide whether an irq
> > needs to be fired depending on its edge/level/... configuration.
>
> You don't talk about the .set_type callback here; is this intended?
>
> I wonder how you think this should be used. Assume the mockup-driver is
> directed to pull up a certain line, does it do something like that:
>
>         def mockup_setval(self, val):
>                 irqtype =3D irq_sim_get_type(...)
>                 if irqtype =3D=3D LEVEL_HIGH:
>                         if val:
>                                 fire_irq()
>
>                 else if irqtype =3D=3D EDGE_RISING:
>                         if val and not prev_val:
>                                 fire_irq()
>
>                 else if irqtype =3D=3D LEVEL_LOW:
>                         if not val:
>                                 fire_irq()
>
>                 else if irqtype =3D=3D EDGE_FALLING:
>                         if not val and prev_val:
>                                 fire_irq()
>
> I wonder if that logic should be done in the same place as where the irq
> type is stored. Otherwise that .type member is only a data store
> provided by the irq simulator. So I suggest to either move the variable
> that mirrors the current level of the line into the irq simulator, or
> keep the irqtype variable in the mockup driver. Both approaches would
> make it unnecessary to provide an accessor function for the type member.
>

Yeah, might be better to go back to my previous idea of adding
irq_sim_fire_edge(), but maybe it should be irq_sim_fire_type()
instead, so that irq_sim_fire() fires unconditionally and
irq_sim_fire_type() would fire only if the passed flag is the same as
the one previously configured by the set_type() callback.

Thanks,
Bartosz
