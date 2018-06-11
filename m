Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +SYvHUyWHlvBNQAAmS7hNA
	; Mon, 11 Jun 2018 15:34:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 972C2607BB; Mon, 11 Jun 2018 15:34:20 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uOA/UFIg"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 06489601C3;
	Mon, 11 Jun 2018 15:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06489601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754234AbeFKPeS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:34:18 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43336 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753933AbeFKPeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:34:15 -0400
Received: by mail-lf0-f66.google.com with SMTP id n15-v6so31203827lfn.10;
        Mon, 11 Jun 2018 08:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w2LJaCm5tOxzif/TTH8ApWC0yWKEqOMOFZ+xIB5jfw4=;
        b=uOA/UFIg28FyySx9I/zPraT1OCAcxYZwsEOZV03MXyB+QR8zVlh5xu2xHuoyncQbsk
         lh294Lv1yvw+nXoslMG3+9RmSwpCqAdyBX90ynagqwccX6dztCPSpT0dQQo3WMS8OuZy
         jseZWPPHJaqGo+uPaBJlkk6FdXExx+8FbrcO1HkD+U1/3wzxd/4FRja+C9W49VHXjGvR
         zS4B27n8mKm1Lq18Euf8LkYq2yRrdAkMgLap3w8r+GRLStb9H2dHOPT69zgJsejsyBsj
         bzhjj3m8wPbO+NrhUtDnWr/Ns5BQLSKNJqLlqCfYJvzc6pIOuYup2XFRFsRma5x2Nuln
         Bkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w2LJaCm5tOxzif/TTH8ApWC0yWKEqOMOFZ+xIB5jfw4=;
        b=gTyia6pnvDL5yMv/DxPd18HXJXpiPVNUswcE5Xqu4tuvEaKCG4nkNIFVBPPCfwBLIy
         wUc1B18CuFg4KXbS9O6EODoYx9fcVC6FMC4jvbEpa7iFAzfeEDwRw3fJfvVWlGhbJDyd
         ItIr6FM417pDO4NmFVwvJEIlcuVm7TrvKaQ4TVRU3NbKuukQ8S/o4V1UInzdoQoA1UhL
         r8JtZg+bHo3KFHRqKTU27Xt1RfSiDvuug7sGYe45tD5bTjdUDJXsqq6C1pmRw6oMXqqp
         DAydzFiaF0qFCehYVJ5lWNtN49SDV3K17eKfLlIA3jPtDlnXnvBdxXjUlyz9YrpMRKCo
         k2Kw==
X-Gm-Message-State: APt69E2bRmdgi3BYxxgLiODaC+aS0edfQmrQdqfIlSkUyTl6qBCwdSoc
        hc40t7z8sFPf6j7AEuX0ZHyu7ioYYHnU07t0EEE=
X-Google-Smtp-Source: ADUXVKJWaqDgqBHzMWZdN6JfxgcXA3F3thSgrxMPlJWMnme/RLES+uRwQgRyXSGhRAtrDLLaVLxOz4RI6v8uimrjeTw=
X-Received: by 2002:a2e:9204:: with SMTP id k4-v6mr11850316ljg.144.1528731254041;
 Mon, 11 Jun 2018 08:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180611115240.32606-16-ricardo.ribalda@gmail.com> <CCB7FF79-F89A-4421-A6C0-E0663BEE6065@holtmann.org>
 <CAPybu_0=ykAcCx=nZyrv90YRfihDxi3s2+Nz+6UP8Fwd5eH2-A@mail.gmail.com> <B4BC9DB0-2D7C-4F9D-99FE-8227D4DC3D54@holtmann.org>
In-Reply-To: <B4BC9DB0-2D7C-4F9D-99FE-8227D4DC3D54@holtmann.org>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Mon, 11 Jun 2018 17:33:53 +0200
Message-ID: <CAPybu_2ViGvN6egz-Ajq4+1fv6VAVFswuvSPAVmYH0a9R-Yjvw@mail.gmail.com>
Subject: Re: [PATCH v2 15/24] net: qualcomm: MODULE_DEVICE_TABLE(serdev)
To: Marcel Holtmann <marcel@holtmann.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        David Miller <davem@davemloft.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,
On Mon, Jun 11, 2018 at 5:28 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Marcel,
>
> >> the commit message is misleading me. If I build something with ACPI or=
 DT support, then modinfo will show all modalias information for ACPI and D=
T compatible strings. What else does udev/modprobe actually need? Is someth=
ing broken with the modalias export?
> >
> > The main purpose is to autoload drivers for devices that have been
> > created via sysfs or another module.
> >
> > Eg1: We have a serial port on a standard computer that has connected a
> > GPS module. Since it is something that is not in the ACPI nor the DT
> > table the user will run
> >
> > echo serdev_gps > /sys/bus/serial/devices/serial0/new_device
> >
> > Eg2 module: https://github.com/ribalda/linux/blob/415bb3f0076c2b846ebe5=
409589b8e1e3004f55a/drivers/tty/serdev/test_platform.c
> >
> > Modprobe does not know what module to load for that device unless
> > there is a matching MODULE_DEVICE_TABLE
> > Today, we have the same functionality for i2c devices
> > https://www.kernel.org/doc/Documentation/i2c/instantiating-devices
>
> but why does this have to be the driver name? I would rather say, create =
a generic string that describes the hardware and then use that. I think you=
 also want the special handling, as from USB for example, that lets you ref=
erence an existing .compatible or ACPI ID as reference so that the driver_d=
ata is copied.

We can choose any name, but if there are no special variants (like the
rave-sp driver) I would prefer using the module name. We can of course
use more names, like the part number of the the device, but it is very
convenient to also use the module name, and other subsystems also do
that.

If you want to add specific names for this device please let me know
and I will add them to the list. You know much more about this module
than myself.

Thanks!

>
> Regards
>
> Marcel
>


--=20
Ricardo Ribalda
