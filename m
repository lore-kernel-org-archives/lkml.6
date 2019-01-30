Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC55EC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA5B20989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcdpxPVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbfA3PGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:06:22 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36016 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbfA3PGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:06:20 -0500
Received: by mail-qt1-f194.google.com with SMTP id t13so26532249qtn.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 07:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fRCmJioATJL5WYGPiQvnI00ogVwM6ieigySHAUm7H0w=;
        b=NcdpxPVm5QS3oX2P3MqCk8+rZV2yMw7n8XE0GHi670d1YCK3PdRxGt06foxuCb4Es5
         LD3+Zyil4xgws2q9WwO6+f8mGAI+0xfRX4PiRGdQa2rGG31ntX9PxALEwYfLNAiixayJ
         XDJINutv9+G46lrV6ph8TS3OXAmpz5VsqMG6YMw/6qkrtX4hGo6rLCq5Smgam7yoysC3
         XMOWkIAlR/MbTqcyVW3mod2LOPdqRNtraUgVbkwahZl2BDKAiswBKSbzG54fFW4GvF0D
         rTKBcBQWfGiLmYv0gCNKODFfv6F1zP9b7WIVq3OPcKOvCCICTLDS5q0x54zHQMMJO3Xk
         DUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fRCmJioATJL5WYGPiQvnI00ogVwM6ieigySHAUm7H0w=;
        b=WB1sqYa2hecYEOf+efmp67LmSZNSaHOdYbBMKv0KxEXotUowqGJTIVUx6ooFk4kgs+
         6J63HUcHBaXxKCQWdNPI2TWnEW3bGHLDBbZs72zpTAlRqGmSBRPODLxITMAc7uOyZlOE
         aJaod3XtIlhH5NIHJ2qp7gJNPaM+ARHArw445rHYRlbQZ4Zhi7bvL873W25dZqw+ucLc
         jqVID48ujJfqfE4iHrRD62sWG5+8HQ7p3Zqu68DvZkgeu3AAz+l6ZxgEt5V8HA4OmW04
         JJpMcZ3YsxOJNXyac2ujiCjOZLSxd86fSn3Jx58W693o+zpSYZX78FM1CLKIh8Hq3lEj
         YTtw==
X-Gm-Message-State: AHQUAuautqmdLQJ6vF/wgn+ldBICD23JDXgu/SGOXG3xf5+inF4Yps+7
        qHk6V3DeQTlTdEbU0/LoFR7cHtuvA2JSTx0FbDQ=
X-Google-Smtp-Source: AHgI3IbmtfLbymWCOu21q40TIvtfhAsJWjkmqXmqBEjRD5rm1+Ubnzk8LvR6sFFgRjq5jguuooaPtRjyj3fjwFCaBos=
X-Received: by 2002:ac8:4284:: with SMTP id o4mr9259179qtl.389.1548860779118;
 Wed, 30 Jan 2019 07:06:19 -0800 (PST)
MIME-Version: 1.0
References: <20190121071833.43443-1-pihsun@chromium.org> <20190121071833.43443-6-pihsun@chromium.org>
 <20190130130738.GC4701@dell>
In-Reply-To: <20190130130738.GC4701@dell>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Wed, 30 Jan 2019 16:06:08 +0100
Message-ID: <CAFqH_51-WCxyRpb6fDhm_y6gE+XsJo9Ezp-QZuAPAyxXqZgPdQ@mail.gmail.com>
Subject: Re: [RFC v3 5/5] cros_ec: differentiate SCP from EC by feature bit.
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee, Pi-Hsun,

Missatge de Lee Jones <lee.jones@linaro.org> del dia dc., 30 de gen.
2019 a les 14:07:
>
> On Mon, 21 Jan 2019, Pi-Hsun Shih wrote:
>
> > Since a SCP and EC would both exist on a system, and use the cros_ec_de=
v
> > driver, we need to differentiate between them for the userspace, or the=
y
> > would both be registered at /dev/cros_ec, causing a conflict.
> >
> > Cc: Enric Balletbo Serra <eballetbo@gmail.com>
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> > ---
> > Changes from v2:
> >  - No change.
> >
> > Changes from v1:
> >  - New patch extracted from Patch 5.
> > ---
> >  drivers/mfd/cros_ec_dev.c            | 9 +++++++++
> >  include/linux/mfd/cros_ec.h          | 1 +
> >  include/linux/mfd/cros_ec_commands.h | 2 ++
> >  3 files changed, 12 insertions(+)
>
> Just to clarify to the new Cc'ed list, I'm waiting on one of the
> Chromium guys to review before I put my mucky paws over it.
>

Pi-Hsun, is this patchset still an RFC or you really want to see this
merged ASAP? If I am not mistaken there is still some work in progress
trying to push all the SCP stuff?

Lee, personally I have some concerns. Looks like the cros_* family is
increasing quickly lately (cros_ec, cros_pd, cros_scp, cros_ish,
cros_fp ...) and I am wondering if we are really doing well all this.
To be honest, I'd like to take a deeper look before merge this, btw I
thought there was no hurry because of the RFC and I guess there are
still some scp things that are missing. I might be wrong, and if
that's not the case I can take a look deeper and the end of the week.

Best regards,
 Enric


> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
