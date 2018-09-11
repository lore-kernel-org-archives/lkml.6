Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C236C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF8720866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UP/SMae7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF8720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeIKUdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:33:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35404 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbeIKUdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:33:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id 7-v6so12464476pgf.2;
        Tue, 11 Sep 2018 08:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hO4ptVjqIF1H9wiW4ryILDVrxT+zLd5nC2KssR2sleo=;
        b=UP/SMae7S3TFJRvj6TvJUdn4+S/aooaaM2eXYL1gv6KySwFu8urLn7mXos0z5U8POx
         aZdSHhXKOTgwc1GUAIzq/laroPasOrdIQEx6bkW68G5i5DkbMs+VVBp9n9zxwMI5LKQB
         0qmAM4QDzQBMiSIKjB6xIFGmBDz0Tz4CyeDHKnwR62EBzySk47RoDsx2ikvOgzNbpuce
         QKCwhw89MmPqKpK2zGvEHj/c+gvR78X83evYgYSsnHDTfDVacHfPNptkt4X91OjwLvJ+
         UyLQTFfodBtFb8TJ5qu7kdFyjHLZ3LN5nyvLBQ1nqXPcIUvobOsxlabjqOf/UFC8jYc9
         dWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hO4ptVjqIF1H9wiW4ryILDVrxT+zLd5nC2KssR2sleo=;
        b=qPZ92sBzzC2/03mBPxlyP/iNSodI+B/eh6Xyxy2/EZYnkoYfYHZ6cwoEVg+76TcykY
         c228aRkZDom1W1O+fBlsnVAaOM+XyV7VmCHjKsepxLvHbNFi6AU1rbTA5rqr8Yi2nYPQ
         +pwBBBSIGT044i1nEzWM5HF9pvx9Qqm6pCZZY7vBW3bYvfxrNyuhD5ipAVnf1ILKy5Ga
         WgQHbMDcdXgRu9Rs9E3qD4aXkm39+N8uS9MWwgkIPC6veUhmBMk8oHbg1N3JQH6h8p29
         Dxot9BB5lVLBldnLvk1vhon6HHTpIFkxU9O/sG+yILPUUu5hQLjGham0AACrg8i+l8Qb
         Ufqg==
X-Gm-Message-State: APzg51CmYf0yL3foNuy791LNztqde4B9CwiHE2wrgR+u9OzPdGM3VnQw
        wdkbdOHAvFj2dqU4n+y1hAg=
X-Google-Smtp-Source: ANB0VdaCQgdyJOkcf/5SNv9orn8fZthmYXLrQhll7csl6/1AY3LBBOCuIJXImy/yAfcmr6MTIQcVNQ==
X-Received: by 2002:a63:115f:: with SMTP id 31-v6mr28945614pgr.53.1536680005761;
        Tue, 11 Sep 2018 08:33:25 -0700 (PDT)
Received: from [192.168.84.35] (148.98.198.104.bc.googleusercontent.com. [104.198.98.148])
        by smtp.gmail.com with ESMTPSA id y69-v6sm37886650pfd.36.2018.09.11.08.33.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 08:33:24 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] usb: typec: get the vbus source and charge values from the devicetree
From:   Guenter Roeck <groeck7@gmail.com>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20180911145931.32441-1-angus@akkea.ca>
Date:   Tue, 11 Sep 2018 08:33:22 -0700
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8A418EC6-62A4-4354-8928-7693696409D1@gmail.com>
References: <20180906192644.24587-1-angus@akkea.ca> <20180911145931.32441-1-angus@akkea.ca>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I cant put my finger on it but this seems wrong. As i said both src and sink=
 should never be true at the same time. I also din=E2=80=99t understand why t=
urning off src should power off your board. Ultimately my concern is that we=
 may be just painting over the real problem, and that would be really bad to=
 do with dt properties.

Note that sending to groeck7@ makes it hard for me to see your emails and to=
 reply. Using linux@roeck-us.net would be much better.

Guenter

Sent from my iPhone

> On Sep 11, 2018, at 7:59 AM, Angus Ainslie (Purism) <angus@akkea.ca> wrote=
:
>=20
> If the board is being powered by USB disabling the source and sink
> can remove power from the board. Allow the source and sink to be
> initallized based on devicetree values.
>=20
> Changed since V2:
>=20
> Change the devicetree documentation.
> Change the devicetree property names.
>=20
> Changed since V1:
>=20
> use devicetree values instead of hardcoded initialization.
>=20
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
> .../devicetree/bindings/usb/typec-tcpci.txt        |  6 ++++++
> drivers/usb/typec/tcpm.c                           | 14 +++++++++++---
> 2 files changed, 17 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/typec-tcpci.txt b/Docum=
entation/devicetree/bindings/usb/typec-tcpci.txt
> index 0dd1469e7318..b07418ae6482 100644
> --- a/Documentation/devicetree/bindings/usb/typec-tcpci.txt
> +++ b/Documentation/devicetree/bindings/usb/typec-tcpci.txt
> @@ -15,6 +15,12 @@ Required sub-node:
>   of connector node are specified in
>   Documentation/devicetree/bindings/connector/usb-connector.txt
>=20
> +Optional properties for usb-c-connector sub-node:
> +- init-vbus-source: set the initalization value for vbus-source to true.
> +  If this property is not present the initial value will be false.
> +- init-vbus-sink: set the initalization value for vbus-sink to true.
> +  If this property is not present the initial value will be false.
> +
> Example:
>=20
> ptn5110@50 {
> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> index ca7bedb46f7f..10c14ece3858 100644
> --- a/drivers/usb/typec/tcpm.c
> +++ b/drivers/usb/typec/tcpm.c
> @@ -2462,9 +2462,7 @@ static int tcpm_init_vbus(struct tcpm_port *port)
> {
>    int ret;
>=20
> -    ret =3D port->tcpc->set_vbus(port->tcpc, false, false);
> -    port->vbus_source =3D false;
> -    port->vbus_charge =3D false;
> +    ret =3D port->tcpc->set_vbus(port->tcpc, port->vbus_source, port->vbu=
s_charge);
>    return ret;
> }
>=20
> @@ -4266,6 +4264,16 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,=

>        return -EINVAL;
>    port->port_type =3D port->typec_caps.type;
>=20
> +    if (fwnode_property_present(fwnode, "init-vbus-source"))
> +        port->vbus_source =3D true;
> +    else
> +        port->vbus_source =3D false;
> +
> +    if (fwnode_property_present(fwnode, "init-vbus-sink"))
> +            port->vbus_charge =3D true;
> +    else
> +            port->vbus_charge =3D false;
> +
>    if (port->port_type =3D=3D TYPEC_PORT_SNK)
>        goto sink;
>=20
> --=20
> 2.17.1
>=20
