Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4E3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC3D208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKYS6gVF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbfAJULl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:11:41 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39815 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbfAJULk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:11:40 -0500
Received: by mail-lf1-f67.google.com with SMTP id n18so9227419lfh.6;
        Thu, 10 Jan 2019 12:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IZ5yCbDjDzq/MFLaQ0vkgsP/PWGCdxmNoG7kHMs1bJk=;
        b=EKYS6gVFP25UuRwCX+mcHxUD0CE5QLHL2/q8De6DLqyxLV4H0pVqzet9bdZYXpd8Lv
         zNKvnlMYOldPScf3BxAI/6LjRrfqcTJ4bsIAOz0ggvMn8j3AUmOJLSTmeih+ocle1vBL
         hqglADQTCzbIsbXFGa7RtzDlP/MTMnBwjrWCy3A2+/yVxOu2gEDszgPGpIvhD1GRy4dI
         /XndpJknhutxSO4JLRXSzfJoQAN5otkR16j2E1NXL+v903xhtDpWGYgHMB9xK6AJ+c9W
         9jTzUy+CswjwhKifEnFTUgMWkky6jRBhKuOKcbzKyfONvF0vOifSAuMbz2g0DOyBswCc
         kzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IZ5yCbDjDzq/MFLaQ0vkgsP/PWGCdxmNoG7kHMs1bJk=;
        b=Hv5QeQ/XmPLLj1wIGCMXLaM9OdbToJGyMTCZPrqJC1J2ceOYSAptEdlRWK8zTj4BUq
         83jyX5uU1oiUFBKBT7wLWLirmjkqNnTqlLekC+YMPJwGDOSGQgQmehGxgWCnIVJM8Axs
         575OpHWQ9MNJ+oT/PUqAPNplHFBgxgIqbHvUBvQ3wF2xyIFQ/A3nuw/ePNoKy8tArfbO
         xCCqgYLTDAMSq7EEJApMylDGZoY5cGNmPPD5NGqELMo1aY1JNVIJYUawtPWljdrHeGsm
         fvjWmvEMXbiTN03C3N9iw7Zz9uZW/r9LIQIo9nLatvn2OdEEsG9Zmwbq8mkHXzD9GO3D
         ivDg==
X-Gm-Message-State: AJcUukePMABWEqIbAP650c5B+GkoKMHMNTT1aniqm6vRDC/sl5vEjHgc
        DzdjwjUBhHmWEO9okoXeKYo=
X-Google-Smtp-Source: ALg8bN5kndbdByuvMcdXu8Zs/52aBpLTTmwVuVd/CPsI7sJWHYpvWXtzFWVg2OnPdQFMV6X2jaFrbw==
X-Received: by 2002:ac2:4343:: with SMTP id o3mr6892157lfl.129.1547151097290;
        Thu, 10 Jan 2019 12:11:37 -0800 (PST)
Received: from acerlaptop.localnet ([2a02:a315:5445:5300:5dc1:592c:c674:2869])
        by smtp.gmail.com with ESMTPSA id z6sm14453866lfd.50.2019.01.10.12.11.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 12:11:36 -0800 (PST)
From:   =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Sebastian Reichel <sre@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: mfd: max8998: Add charger subnode binding
Date:   Thu, 10 Jan 2019 21:11:35 +0100
Message-ID: <7002692.meb5AFBGDJ@acerlaptop>
In-Reply-To: <5765349a-c94d-49c1-45b5-ab7ac09f9923@samsung.com>
References: <1524844982-4714-1-git-send-email-pawel.mikolaj.chmiel@gmail.com> <2089055.mctyXeETjz@acerlaptop> <5765349a-c94d-49c1-45b5-ab7ac09f9923@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Thursday, 10 January 2019 18:47:11 CET Sylwester Nawrocki wrote:
> Hi,
>=20
> On 5/1/18 16:43, Pawe=C5=82 Chmiel wrote:
> > On Tuesday, May 1, 2018 2:45:40 PM CEST Sebastian Reichel wrote:
> >> On Fri, Apr 27, 2018 at 06:03:02PM +0200, Pawe=C5=82 Chmiel wrote:
> >>> This patch adds devicetree bindings documentation for
> >>> battery charging controller as the subnode of MAX8998 PMIC.
> >>> It's based on current behavior of driver.
> >>>
> >>> Fixes: ee999fb3f17f ("mfd: max8998: Add support for Device Tree")
> >>> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/mfd/max8998.txt | 22 +++++++++++++=
+++++++++
> >>>  1 file changed, 22 insertions(+)
>=20
> >>> --- a/Documentation/devicetree/bindings/mfd/max8998.txt
> >>> +++ b/Documentation/devicetree/bindings/mfd/max8998.txt
> >>> @@ -50,6 +50,21 @@ Additional properties required if max8998,pmic-buc=
k2-dvs-gpio is defined:
> >>>  - max8998,pmic-buck2-dvs-voltage: An array of 2 voltage values in mi=
crovolts
> >>>    for buck2 regulator that can be selected using dvs gpio.
> >>> =20
> >>> +Charger: Configuration for battery charging controller should be add=
ed
> >>> +inside a child node named 'charger'.
> >>> +  Required properties:
> >>> +  - max8998,charge-eoc: Setup "End of Charge". If value equals 0,
> >>> +    remain value set from bootloader or default value will be used.
> >>> +    Valid values: 0, 10 - 45
> >>> +
> >>> +  - max8998,charge-restart: Setup "Charge Restart Level". If value e=
quals 0,
> >>> +    remain value set from bootloader or default value will be used.
> >>> +    Valid values: -1, 0, 100, 150, 200
>=20
> Perhaps change the property name to max8998,charge-restart-threshold,=20
> in include/linux/mfd/max8998.h we have:
>=20
>  * @restart: Restart Level in mV: 100, 150, 200, and -1 for disable.
>  *   If it equals 0, leave it unchanged.
>=20
> Then we could make it an optional property:
>=20
>  - max8998,charge-restart-threshold: Charge restart threshold in millivol=
ts.=20
>    Valid values are: 0, 100, 150, 200. If the value equals 0 the charger=
=20
>    restart will be disabled.
>=20
> If the property is missing the charger restart threshold configuration wo=
uld
> be left unchanged.
>=20
Strange, i've looked at max8998 and didn't saw information that those value=
s are in mV (maybe it was from vendor sources).

> >>> +  - max8998,charge-timeout: Setup "Charge Full Timeout". If value eq=
uals 0,
> >>> +    remain value set from bootloader or default value will be used.
> >>> +    Valid values: -1, 0, 5, 6, 7
> >>
> >> What are those values? seconds?
> >>
> > Honestly i don't know. I've just documented values accepted currently=20
> > by charger driver, so we can use it from devicetree.
> > I couldn't find any max8998 datasheet with this information (units, pos=
sible=20
> > values etc for those properties).
>=20
> The charge timeout is in hours, as described in include/linux/mfd/max8998=
=2Eh:
>=20
>=20
> "* @timeout: Full Timeout in hours: 5, 6, 7, and -1 for disable.
>  *   If it equals 0, leave it unchanged.
>  *   Otherwise, leave it unchanged."
>=20
> We could change description of the property to something along the lines =
of:
>=20
> Optional properties:
>=20
>   - max8998,charge-timeout: Charge timeout in hours. Valid values are:
>     0, 5, 6, 7. If the value is 0 the charge timer will be disabled.
>=20
> Then if the property is missing the driver will leave charge timer config=
uration
> unchanged.
>=20
>=20
Thanks Sylwester Nawrocki for all those hints (mostly regarding units of th=
ose magic numbers/values). I'll prepare new version of those patches with a=
ll hints included.


