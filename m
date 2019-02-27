Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE953C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97EE420863
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="D/h6eaaX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbfB0Ske (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 13:40:34 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42335 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfB0Skd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 13:40:33 -0500
Received: by mail-pg1-f196.google.com with SMTP id b2so8364572pgl.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 10:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MgxCH2yRcy0/a3sHAu7Y7l4oM3URGcXqPS7a9ORZj6I=;
        b=D/h6eaaXsN7UGubF6KL/3De6CYDXG1FruFU9VYgpCfUu+Oykaa76hkqE1Q9CUShPqd
         u9vv6+eGUJg9iUQueo2lpNXZ0XmLmDyLg955NAmgU4K6IoLIUGfsERTKZePwvcPiMtkU
         LhMKEQPT665BGXs2ORygAyvj/PGYz9fhy9Fk2c9tahwXzFtHjCdcbIy4IdulBohSzGaY
         gKF8nco/o+e5E8FUJHBwh5oFdntHsa37r312sisitFV33Afletht17enGpgBhAwWi/cL
         1IVqdORhSvSqB2KBVai/CYfmYszb1Oy1+FnyYuvTmfACD3Zs78zTfq9hVRJtcGt+vaWX
         X5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MgxCH2yRcy0/a3sHAu7Y7l4oM3URGcXqPS7a9ORZj6I=;
        b=UeRusWsVE12LCUMXydJvKToXCTWFOVy36oPhWEN3D6jiOhX7H6OyY/ZVe5nTP/bLfv
         /xkQdJ5bsY0x1b5ls3YeCTHQ4S7RnQLepQxiYKVKLUsHBCVxHn2s2xE0dl97ybPrcsyP
         xEjq45RxibplxhI+UG/oQFP8Bw4kLrEJ5o6S9KW4O2Wj6iRuys4oSbf8LKNXq8pZVFuP
         /XWvJkd2oCQ2Qhaqm5JfeDnN2rWceCKYQWA+JHtX6A8PfJYuL/cW78tBMimfczI7vlcY
         IREiurMTs8qnqa3iqsIZXnyH9jQYkLdixHB1T0ag43ztPH9695Gct/8fdMb0NFTFzCwS
         vN0g==
X-Gm-Message-State: AHQUAuZYbYsMTQ8ZSzCLdDoS1Hi69bs2r19mjaflm1ZeLvegFGjr3X9n
        lf1PoLJO1Mn8b1B7BT/ibE5ceQ==
X-Google-Smtp-Source: AHgI3IZRAssfJOq3i4Y3+DM1TbR6TJSuEStoViaxtujDAWwH3JSg1caXX+lj4K8WJcj8b/f+1RVQPg==
X-Received: by 2002:a62:11ca:: with SMTP id 71mr3106395pfr.18.1551292832821;
        Wed, 27 Feb 2019 10:40:32 -0800 (PST)
Received: from shemminger-XPS-13-9360 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id b26sm21393089pfo.33.2019.02.27.10.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 10:40:32 -0800 (PST)
Date:   Wed, 27 Feb 2019 10:40:28 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Harini Katakam <harinik@xilinx.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        David Miller <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Harini Katakam <harinikatakamlinux@gmail.com>
Subject: Re: Request for suggestion on net device re-naming/re-ordering
 based on DT alias
Message-ID: <20190227104028.707a75e2@shemminger-XPS-13-9360>
In-Reply-To: <CAFcVEC+8P25MKWhizUUEuamikaZYUOjpppV=59=W3POTEfQqXw@mail.gmail.com>
References: <CAFcVEC+8P25MKWhizUUEuamikaZYUOjpppV=59=W3POTEfQqXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019 17:24:03 +0530
Harini Katakam <harinik@xilinx.com> wrote:

> Hi,
>=20
> We've had some users requesting control over net device name order
> when multiple ethernet devices are present on a system. I've tried a
> few solutions to this and looked it up on forums. But I apologize if
> I have missed something.
>=20
> I know that the current system allocates eth<n> as per probe order
> but that is obviously not stably controlled by user (tried DT
> re-ordering and defer probe). One solution is to use DT alias names
> to write to (net_device)->name as follows:
> Devicetree:
> aliases {
>    ethernet0 =3D &mac1;
>    ethernet1 =3D &mac0;
> };
> Driver probe:
> +       /* Read ethernet DT alias id and assign to right device name*/
> +       id =3D of_alias_get_id(np, "ethernet");
> +       if (id < 0) {
> +               dev_warn(&pdev->dev, "failed to get alias id (%u)\n", id);
> +               return id;
> +       }
> +       snprintf(dev->name, sizeof(dev->name), "eth%d", id);
> +
>=20
> These three drivers seem to have something similar for mdio/phy bus IDs:
> drivers/net/ethernet/broadcom/genet/bcmmii.c:409: id =3D
> of_alias_get_id(dn, "eth");
> drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c:43: plat->bus_id =3D
> of_alias_get_id(np, "ethernet");
> drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c:404:
> plat->bus_id =3D of_alias_get_id(np, "ethernet");
>=20
> Drawback: This approach will break if alias is not provided for one
> of the interfaces on board. Not to mention, there could be systems
> with multiple ethernet makes (for ex. Cadence macb and Xilinx axienet)
> If one of the drivers does not have an alias read mechanism, it is
> possible to have clashing ID assignments. Is there any way this
> solution can be changed to be stable/acceptable?
>=20
> One other alternative I've tried is netdev kernel bootargs but this
> device name was not being picked by the kernel:
> https://www.kernel.org/doc/html/v4.19/admin-guide/kernel-parameters.html
> netdev=3D <mac1=E2=80=99s interrupt id>, <mac1=E2=80=99s base address>, e=
th0
> netdev=3D<mac0=E2=80=99s interrupt id>, <mac0=E2=80=99s base address>, et=
h1
>=20
> Could you please suggest any alternatives?
> Thanks!
>=20
> Regards,
> Harini

Device naming is a hard problem, and there is no perfect solution.

Device tree should be providing hints to userspace policy for naming, not
trying to do it in the kernel.=20
See: https://www.freedesktop.org/wiki/Software/systemd/PredictableNetworkIn=
terfaceNames/
