Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0/TnDAmhHls0PgAAmS7hNA
	; Mon, 11 Jun 2018 16:22:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1A29060792; Mon, 11 Jun 2018 16:22:20 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYc2lsJE"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4FC98601C3;
	Mon, 11 Jun 2018 16:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4FC98601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933402AbeFKQWR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 12:22:17 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35918 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752816AbeFKQWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 12:22:15 -0400
Received: by mail-lf0-f67.google.com with SMTP id u4-v6so31487638lff.3;
        Mon, 11 Jun 2018 09:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8Z3Y3sF+WSa1pn9y6ovwqk5lbsUpB80ngFmnSB5KRDc=;
        b=OYc2lsJENdBgLjo3R5KSasX+PYRYZAJQzKCPSp/4Xfjj9jSpN9ks9669mNl2LNPj4L
         yDfnZDT57OSISvb8ardy86uPQ1IHq9m6VjKkfJP1RypifkMppQYB57QJKwtLw5Ex13k/
         dO/FZsW4sSELs/jAjDrDVonmiDGVeQTAiyCMF/4hZK5NBfBQQh3ubdxxZurq2+6wBw7d
         fvjjVyq5Emhg7F+R634d7q4GoA8Sh8CmUI/WhQgqX9RIbE6wa2c92QY1QSqcQPymhJSb
         OxKVdAE92wFU+6zsVHSAVoROEBxs0atEtm23XgojLlAPNdyXe+sQcrKZa/WsE2qKQqi4
         iINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8Z3Y3sF+WSa1pn9y6ovwqk5lbsUpB80ngFmnSB5KRDc=;
        b=SXqSQR4RUfoc5jallDpP9801YnSttIcWMmrdHQ6y1xBt4G0dNxNcdzO4A5af1pTXoy
         zC5tDJGN8gD6mR8cgvPUYWAlJ8c0fOWaNgUfQQG0Ilo6hw7UgSOybuHc1tm3XspyuPKk
         DONYpAPHG7WezB8vpW0KJoP5umEq/JUMwkE6FeGciId+De8zF1VuSAw9ScwL1vbKblMy
         mpTqUPwplOxVgz4lMP6+rKkHnwqfzE2xqGR1dUBO5SmZ0ouRZt10XUDiyk7J/NI2+/Wz
         TlGiO0hSmWo6qSvz0QPvbQsra2p4v0FVoWwA/bCh7O5OzaYinsxJbXD0zU0m4SET3hOf
         YXsg==
X-Gm-Message-State: APt69E1UuChYtDWEexv4SCrv+sxX2J9DRIeTXWmgBOInr+9jALrCe3Wz
        gLkn/A7XTFI1UgWrcS5r9dk9GfOX3GTW8v2fXNF9m570kp8=
X-Google-Smtp-Source: ADUXVKL3D/GGkx6fuP0rcokHg6GmmF+YlCTWPjYvNjHUHppxqUu0lyCw+PniEQd6gtaM05I05Rn7kZGUi6sjeX9HAdg=
X-Received: by 2002:a19:9f95:: with SMTP id i143-v6mr11401205lfe.125.1528734133770;
 Mon, 11 Jun 2018 09:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180611115240.32606-16-ricardo.ribalda@gmail.com> <CCB7FF79-F89A-4421-A6C0-E0663BEE6065@holtmann.org>
 <CAPybu_0=ykAcCx=nZyrv90YRfihDxi3s2+Nz+6UP8Fwd5eH2-A@mail.gmail.com>
 <B4BC9DB0-2D7C-4F9D-99FE-8227D4DC3D54@holtmann.org> <CAPybu_2ViGvN6egz-Ajq4+1fv6VAVFswuvSPAVmYH0a9R-Yjvw@mail.gmail.com>
 <07871EF5-D1D3-4677-8100-B5E7F14DB302@holtmann.org>
In-Reply-To: <07871EF5-D1D3-4677-8100-B5E7F14DB302@holtmann.org>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Mon, 11 Jun 2018 18:21:56 +0200
Message-ID: <CAPybu_37067-Vny5ZbMK6ZkU8=f-Pk8f9=Sf+NsK7V_VGBMBLg@mail.gmail.com>
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
On Mon, Jun 11, 2018 at 5:52 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Ricardo,
>
> >>>> the commit message is misleading me. If I build something with ACPI =
or DT support, then modinfo will show all modalias information for ACPI and=
 DT compatible strings. What else does udev/modprobe actually need? Is some=
thing broken with the modalias export?
> >>>
> >>> The main purpose is to autoload drivers for devices that have been
> >>> created via sysfs or another module.
> >>>
> >>> Eg1: We have a serial port on a standard computer that has connected =
a
> >>> GPS module. Since it is something that is not in the ACPI nor the DT
> >>> table the user will run
> >>>
> >>> echo serdev_gps > /sys/bus/serial/devices/serial0/new_device
> >>>
> >>> Eg2 module: https://github.com/ribalda/linux/blob/415bb3f0076c2b846eb=
e5409589b8e1e3004f55a/drivers/tty/serdev/test_platform.c
> >>>
> >>> Modprobe does not know what module to load for that device unless
> >>> there is a matching MODULE_DEVICE_TABLE
> >>> Today, we have the same functionality for i2c devices
> >>> https://www.kernel.org/doc/Documentation/i2c/instantiating-devices
> >>
> >> but why does this have to be the driver name? I would rather say, crea=
te a generic string that describes the hardware and then use that. I think =
you also want the special handling, as from USB for example, that lets you =
reference an existing .compatible or ACPI ID as reference so that the drive=
r_data is copied.
> >
> > We can choose any name, but if there are no special variants (like the
> > rave-sp driver) I would prefer using the module name. We can of course
> > use more names, like the part number of the the device, but it is very
> > convenient to also use the module name, and other subsystems also do
> > that.
> >
> > If you want to add specific names for this device please let me know
> > and I will add them to the list. You know much more about this module
> > than myself.
>
> if we want to use the driver name, then why not build this into the new_d=
evice handling itself instead of duplicating that name in each serdev_devic=
e_id table. What is the reference here? For example platform device do matc=
hing on driver name if I recall this correctly.

We do the matching also over driver name at serdev_device_match():

if (sdrv->id_table)
return !!serdev_match_id(sdrv->id_table, sdev);

return strcmp(sdev->modalias, drv->name) =3D=3D 0;

This is just for the module autoloading

>
> However what is most important is that device_get_match_data() actually w=
orks. There should be no difference between DT, ACPI or a dynamic device.

Agree, will take a look to this tomorrow morning.

>
> Regards
>
> Marcel
>


--=20
Ricardo Ribalda
