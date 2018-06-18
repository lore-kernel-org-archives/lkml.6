Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C998C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69B220864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JN80mRwA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69B220864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933073AbeFRHxr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 03:53:47 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36949 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932524AbeFRHxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 03:53:46 -0400
Received: by mail-qt0-f193.google.com with SMTP id a18-v6so14347785qtj.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 00:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AmUobRNTjYaDhgAgBl3NJxgUVdQ62evKL5qfSawOGhQ=;
        b=JN80mRwAjH1F/6zlvgioI6Bh4nvrzZFVUvQdA/hEY2JHuyddviIp7aMpky2GonpmTd
         T34Gjw8Kx5j+wmdyEnbPXedccfXO1i4eNcdZFvY/p3UE07pF/c63ftVpp4qXspnu7Lvw
         UTCDC82qcNRDBxn4vpZE5vHlTDUN3u3ocSBXyn9hsK4RO5X2pj2Se7f0PN+wYFav/N4U
         JA7M6YQuIashIzK4QWGzj/zCC4YqBtduGI0sBrgonFWVO8mZ7HHi4Oky6XhJpsqKDDMG
         kijFTiNCR/dulMHiyB4F0f+qaAFvFRNb/9h82whIEdYcIlazv/uPBgUe/ZRVGCy1Pi8A
         tq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AmUobRNTjYaDhgAgBl3NJxgUVdQ62evKL5qfSawOGhQ=;
        b=r/WCk+hswkNMB/ormWU2+chl4MwLo9hSKYxQgBGgBikG2rluD1+8Q2olYan/BXhlwn
         7NnlbKbFE3dS8sbLVxBnsNpq5IufBE0jOfMI2A2Pb9gHdIQvbfqxhisPO1JlFEwM/J60
         Zs4cceyIAjp5h+vdf19P/hVN4/cZPUYMrNrMOpr3q80U2EjJApWW7NVzHmwAdv/S8kyn
         A9wEhssLh4vg8vQGC2dB4aEompzjgqhsHQofes2KJHfo33wZK+izkCVEC58U4a71cUnj
         HRAZx4jj+SEZ7NhL4RLqQP/qhDEAgXx9jkOyFp3Ik9W5S+LkCe98hVEdc2kmcTFj4/bC
         2IgQ==
X-Gm-Message-State: APt69E0Fu9/jaqqAUveQN7RODMOBfW5GBzNB3R87+JcRNdqnB5niyo55
        doxbv9Rs2MoiSxxVN+fMYbSeQ7URKB9m1ld7mr0=
X-Google-Smtp-Source: ADUXVKLESIw5cPlFHs7uB5s9/dbHJDEbXti/sRacUZ2Gl/TTIghtWyRj7y4Y9T9UGpQzEocfwokS0aQnb53l7DMcdTU=
X-Received: by 2002:a0c:93ec:: with SMTP id g41-v6mr9842588qvg.243.1529308425893;
 Mon, 18 Jun 2018 00:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180606150900.8342-1-enric.balletbo@collabora.com>
 <20180606150900.8342-4-enric.balletbo@collabora.com> <20180618071801.GI31141@dell>
 <20180618072021.GJ31141@dell>
In-Reply-To: <20180618072021.GJ31141@dell>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 18 Jun 2018 09:53:34 +0200
Message-ID: <CAFqH_51Fsyr-zE4zzKLxqPZeep9gj7X_1HOnBeEbg9jXju8S4A@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] mfd: cros_ec: Make license text and module
 license match.
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,
Missatge de Lee Jones <lee.jones@linaro.org> del dia dl., 18 de juny
2018 a les 9:21:
>
> On Mon, 18 Jun 2018, Lee Jones wrote:
>
> > On Wed, 06 Jun 2018, Enric Balletbo i Serra wrote:
> >
> > > The license text is specifying "GPLv2" but the MODULE_LICENSE is set =
to
> > > GPL which means GNU Public License v2 or later. When MODULE_LICENSE a=
nd
> > > boiler plate does not match, go for boiler plate license.
> > >
> > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > ---
> > >
> > > Changes in v3: None
> > > Changes in v2: None
> > >
> > >  drivers/mfd/cros_ec.c     | 2 +-
> > >  drivers/mfd/cros_ec_i2c.c | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > Applied, thanks.
>
> I've just seen Joe's comment.
>

Did you read my answer [1] to the Joe's email?

According to the doc if MODULE_LICENSE is GPL that means  GPL-2.0 or
later which to be strict is wrong if your file is GPL-2.0 only. It's
right that there are modules in the kernel that have this mismatch but
IMHO is wrong, there are also some examples where people fix this, i.e
[2]

Best regards,
  Enric

[1] https://lkml.org/lkml/2018/6/8/144
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D75dc344145190bf53aed7a28dbc27c11180d94e5




> Unapplied, for now.
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
