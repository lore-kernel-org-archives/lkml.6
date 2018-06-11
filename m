Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kMi7F3qTHltSJwAAmS7hNA
	; Mon, 11 Jun 2018 15:22:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9949460792; Mon, 11 Jun 2018 15:22:06 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNJYDGuk"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 20C936074D;
	Mon, 11 Jun 2018 15:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20C936074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754184AbeFKPWE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:22:04 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34240 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754013AbeFKPWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:22:00 -0400
Received: by mail-lf0-f65.google.com with SMTP id o9-v6so31167013lfk.1;
        Mon, 11 Jun 2018 08:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vLGi2rUP0JpBO5tDaFwWYXZmsypWgCMfFT56xBXg2BI=;
        b=kNJYDGukByVml6Rxt++5uwF+whw7ksd6aB4lmbBDGrFWAb+x/vX1i8WUxbbi/Ugd+2
         8xEndujTZA+fSbX/3ZbGhh6npy2dhIkJogENFGs+iox+AjR1sXu3ZgDO6VqeqqDl0J/y
         4Egcy8cpbc5UOIYri5zTdVORv9tnhX0C/WI12jKbYktedjb4+2jrTClzvjshOfAMJmax
         Kc95qY0RZFZck2oESSQpVlEWi9FjZKMoS429jFEqYKLnwuDtzB4EMkriblgdXjupss9G
         5KvLlV/D9J4+vuUjcwh4tv4Rp2+PcSFGc9un1aiweOYtTA2PjRGYegDWCRnk8L55dr3q
         Wirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vLGi2rUP0JpBO5tDaFwWYXZmsypWgCMfFT56xBXg2BI=;
        b=YSIato3jne/HbTQhXuzm//IBDK3Pp2Mte6R7YJdPOQNDBq6X9+hYIFaZVWP3dnOGnj
         rNtB/4AW2/+D4O1AlL4nH0qcMtq29LEuqXUcsVfGwQtds6YSxivq5tlRo+amj98h6rOO
         SDLoHBJ8olPcRA+FAqw5OSGHxnjLy1DuV/rDXTckOWbcN0dYwDT+qFX77g64H58wb2Un
         387d6jQhY2cPXb/RY9Ll7j5ix5D+doZ+3t/rMsPGg6wWRhf7p1oDsjNhF719hqnXQETR
         QixKhapY3hhfJDuLIpschzuY0AMQpXPT+tcJAuAdzm+TCfX1i/Ts6o4Lg5dCw3/LXs12
         ruQQ==
X-Gm-Message-State: APt69E2G5DrX/Dw+5Ylb7Goq0Tl8fwy8icmbbUH1gY4XaZlTxIN29TFF
        bXxDsINdgyNVmqjsGE9Ua8kQI/BKrRTrWilCg3Hhm20b
X-Google-Smtp-Source: ADUXVKIc6+vOh7K8esvbjGVkI6eTQxBBHanUb0jCFol+xKzrWxAI/TflQRxDITSB8ngmdF2i8XAWYCISn6SDVB3LFLs=
X-Received: by 2002:a2e:1dd9:: with SMTP id w86-v6mr11687797lje.110.1528730519022;
 Mon, 11 Jun 2018 08:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180611115240.32606-22-ricardo.ribalda@gmail.com> <CAHp75VeeF4eNjyhhBxocRXboN3fRY=RjrT6QQ72=QJ-s8gvSfA@mail.gmail.com>
 <8912BE88-4AA3-44ED-9828-57666CB31522@holtmann.org>
In-Reply-To: <8912BE88-4AA3-44ED-9828-57666CB31522@holtmann.org>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Mon, 11 Jun 2018 17:21:42 +0200
Message-ID: <CAPybu_0wG_vrkAF4M4C9D2EmtEzT=DbGjFXS-KC=VWYfrr3ACQ@mail.gmail.com>
Subject: Re: [PATCH v2 21/24] rave-sp: Support for variants on modalias drivers
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello


On Mon, Jun 11, 2018 at 3:38 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Andy,
>
> >> Rave-sp behaves differently based on the device variant.
> >
> >
> >>        sp->variant =3D of_device_get_match_data(dev);
> >> +       if (!sp->variant) {
> >> +               id =3D serdev_match_id(rave_sp_serdev_id, serdev);
> >
> > I think you may leave the ID table where it is in the code and use link=
.
> >
> >> +               if (id)
> >> +                       sp->variant =3D (const struct rave_sp_variant =
*)
> >> +                                                       id->driver_dat=
a;
> >> +       }
> >
> > Perhaps a helper like it's done for ACPI / OF cases?
> >
> > [device_get_match_data() -> ]
> >  of_fwnode_device_get_match_data()
> >  acpi_fwnode_device_get_match_data()
>
> something like that and frankly this is trying to hard. This driver is cu=
rrently really DT specific and can be fixed up later. It is causing a lot o=
f noise in this patch series. I would really urge to focus on the core chan=
ges get prominent drivers support. I think hci_bcm.c is a good example sinc=
e a) we need to fix up Edison and b) new ACPI based tablets might be able t=
o allow for easy testing.

I can try to implement something like andy proposes, but if it turns
out too complicated we can remove this driver from the series.

Thanks!

>
> Regards
>
> Marcel
>


--=20
Ricardo Ribalda
