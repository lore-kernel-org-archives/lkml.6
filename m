Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFEEC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC3C20879
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eqx89OFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC3C20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeLLLUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:20:05 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44256 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbeLLLUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:20:04 -0500
Received: by mail-ot1-f67.google.com with SMTP id f18so17225217otl.11;
        Wed, 12 Dec 2018 03:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tZCX6lTCcCdMhudsRwUebVQucf3Y8ZCpVdCoE+/uFog=;
        b=Eqx89OFh3fN2gJUFqsrAyhkgXZXEc98pnFLEXTevaDxViH0IWYkH7vnLKRpBAKpEjz
         s1h13SK9/6IflbLxlxK5wdocD9uW7JOCf4P/NqnWBBoT+gQUoCy3RghGhIcxxm+o31bC
         JZgisyrkgvhZjXfjZJ/J+mwJplFB1NvNn8k+aYzSD/gdpNUTT3W2X4ONMY2tsfsvfvNs
         7UYqmCoPAyhYo4L7zrUgi4vzaVJ0GWi3gpSEMp76Kgu9eIqmrP4iOBNGV/BzWDiWmEHL
         tN3fYgGJ4aqwVmXc3x3dYNf1j8Od5lGJlZoJiVjsSVPKFXAcXOtVmho65hhcDHqUB57h
         yg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tZCX6lTCcCdMhudsRwUebVQucf3Y8ZCpVdCoE+/uFog=;
        b=dSo2n5Wc5BDQFJh+Z4GVUAz4Y8h41Xeuyr35JRoH1dUPRpRXEpy6IdMkWSxvSddY0z
         QYhJMheB7P1RkrET+D4PuBOu6xJAX3zVmRhHmdAXQTGLmj2jf1wPdcTrPJHxKHxKx4Ob
         teyNiXvU090b4bZmDcEGecmBuRdOJfdPSewXR/LH5zBVqgWrmZgxq2Rau/O7f/eflus2
         io0OE6fvuj3WxJmD436NROM+IH+iZwzc5/azskTw9KANZGAb786dMUQRk2MjnCxd8XR6
         xjwafFxazju/jOm3XfPra75zdwl0UWB8t0WLez/OFtyJTcN9hLoNUMWjlZnoHqK4AwMo
         Yyvw==
X-Gm-Message-State: AA+aEWawdUqdHS1pUC4366wniqmpqnHAADjFvOANEFhONRLIAVeTZy14
        HyMROwWEt5f27yNyiWaiKuXcimacrIoZCrL3LVw=
X-Google-Smtp-Source: AFSGD/WtpizY0Bsi7FzC9F9D3F8UoCwk7TT5Nn/GoaztmU2K1Cy6TK+/QnsXAUb1vg5BKhT0b830vzi3hJdgXN12lec=
X-Received: by 2002:a9d:282:: with SMTP id 2mr13618652otl.287.1544613602857;
 Wed, 12 Dec 2018 03:20:02 -0800 (PST)
MIME-Version: 1.0
References: <1544425521-775-1-git-send-email-Anson.Huang@nxp.com>
 <20181210232358.GA11621@bogus> <DB3PR0402MB3916E1651ABC07F6F788B265F5A60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAL_Jsq+sP_fsQaoT6FpZNRxjhPAhCcE8e-0xffUUxShcC2LuHw@mail.gmail.com> <DB3PR0402MB39164538D3969FE51C649B65F5A70@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39164538D3969FE51C649B65F5A70@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 12 Dec 2018 09:19:57 -0200
Message-ID: <CAOMZO5DXNpn18pzngmAt+hyiWNtfwckafxCzbJ17EgndjABwWg@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: iio: light: isl29018: update power
 supply name
To:     Yongcai Huang <anson.huang@nxp.com>
Cc:     Rob Herring <robh@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Wed, Dec 12, 2018 at 4:17 AM Anson Huang <anson.huang@nxp.com> wrote:
>
> Hi, Fabio
>         Obviously, some of the dts files (such as arch/arm/boot/dts/exyno=
s5420-peach-pit.dts) using "vcc" as isl29018's power supply name, they are =
NOT matched with datasheet, so should we update those dts files with "vdd" =
as well or just using the "vcc" in isl29018 driver? Which solution is bette=
r?

We should not break existing dtbs, so in this case just keep the
existing supply name and you could add the new optional vdda supply as
per the datasheet.
