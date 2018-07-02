Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAA5C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C222154C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaFtbnce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C222154C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752508AbeGBNS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:18:58 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40698 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbeGBNSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:18:55 -0400
Received: by mail-wr0-f196.google.com with SMTP id t6-v6so3214175wrn.7;
        Mon, 02 Jul 2018 06:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KzAJiBlrIe6rJ7U2avRI9T9ivZ6XfONYA0KdK98Rbwo=;
        b=QaFtbnce0q9XanfyjPBOXepyOjmLiSkWGLh0hIE/JhBWktkcuqVai8PxTnu2TDPJl4
         MdvMakK9rYzciuUgfjnqrNQO0ysfLg1HvGG2C7csTU5tF4v0F4b0KYtK8rFDHsrkrXO8
         tROOdH09aRIZxDpzPQ6dtEB1TPrmI/er1vDojHs8eC5gLCu8oqfMNMzQh+0GhgXaKWjN
         l6qQNgk1zvmurqG3t+Vcel7tz4vXRzHpJQpxmRbDSk5jPI//ZVGR7SqUQiR/uyakcgtk
         Gcj0Z/u68Inkdetfg5HeNLtmSdMkvulRFjd1cjTHC4EpMPI0phpe9lNljETxNGIOiKJW
         CAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KzAJiBlrIe6rJ7U2avRI9T9ivZ6XfONYA0KdK98Rbwo=;
        b=L3i4nrXjGo9XJf7akARMExHc60DDSgttqc7creL7edS2aaOEf+0kXGScL6MRwwC1M3
         c90RwCDfUAvh+VjIDDO5TNRl6G+bgUfZcUGt17vdsMr+n6rnyZADSSM/XdFEWKctYcCQ
         vXuvB5tCr5DY2zgkCEq3v3kqaFivrRZpBWe8sPKNWAjox4zcwsRyxdGxBZdGqmfiQyA2
         AofYgYUiuyQbAir3vgXDpAIRUACzMcXaYCaMVUZpFaGFhE7dVqPLCu22H96w3vyo7joX
         dYiqe+/M93iG6x5OPzyiYs8+MPZO0EctFjf+wbeaLuUjg9CZ3tvS6LVCH9dUk0Va/rZq
         j+JQ==
X-Gm-Message-State: APt69E3Sc0mOrtdOxGNKbS2uK5vHOCv4P5DxDdatwpHz9ntBGqETCbj+
        4YBqbDjRFZd3oioJjOG4WzI=
X-Google-Smtp-Source: AAOMgpeDOGaoLVYNNlGtF6O8yiFEI9eyc0TOGyDxGxvQ9eZ4CR01BuDgYyk+Yb4hiUElgoU6YodJPA==
X-Received: by 2002:adf:a9b3:: with SMTP id b48-v6mr4049041wrd.48.1530537533560;
        Mon, 02 Jul 2018 06:18:53 -0700 (PDT)
Received: from localhost (pD9E51838.dip0.t-ipconnect.de. [217.229.24.56])
        by smtp.gmail.com with ESMTPSA id l15-v6sm19448383wrs.95.2018.07.02.06.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 06:18:52 -0700 (PDT)
Date:   Mon, 2 Jul 2018 15:18:51 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mikko Perttunen <mperttunen@nvidia.com>
Cc:     jassisinghbrar@gmail.com, gregkh@linuxfoundation.org,
        jonathanh@nvidia.com, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/8] serial: Add Tegra Combined UART driver
Message-ID: <20180702131851.GH13096@ulmo>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702114033.15654-7-mperttunen@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4LFBTxd4L5NLO6ly"
Content-Disposition: inline
In-Reply-To: <20180702114033.15654-7-mperttunen@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4LFBTxd4L5NLO6ly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 02:40:31PM +0300, Mikko Perttunen wrote:
> The Tegra Combined UART (TCU) is a mailbox-based mechanism that allows
> multiplexing multiple "virtual UARTs" into a single hardware serial
> port. The TCU is the primary serial port on Tegra194 devices.
>=20
> Add a TCU driver utilizing the mailbox framework, as the used mailboxes
> are part of Tegra HSP blocks that are already controlled by the Tegra
> HSP mailbox driver.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>=20
> Notes:
>     v2:
>     - Removed (void) casts for unused variables.
>     - Changed the uart_set_options() call to be on one line, even if its
>       over 80 characters.
>     - Added defines for magic numbers.
>     - Style fixes.
>     - Changed Kconfig entry to depend on the Tegra HSP driver instead of
>       just the mailbox framework.
>    =20
>     v3:
>     - Removed FLUSH bit, as it's unnecessary and slows down printing
>     - Removed call to uart_set_options
>     - Added mbox_free_channel calls to remove()
>=20
>  drivers/tty/serial/Kconfig       |   9 ++
>  drivers/tty/serial/Makefile      |   1 +
>  drivers/tty/serial/tegra-tcu.c   | 291 +++++++++++++++++++++++++++++++++=
++++++
>  include/uapi/linux/serial_core.h |   3 +
>  4 files changed, 304 insertions(+)
>  create mode 100644 drivers/tty/serial/tegra-tcu.c

The driver looks good to me. But for my own understanding, is there some
way we can make use of the multiplexing? That is, could we add a
mechanism to have the driver filter out only a specific stream? Could we
also specify which stream to send data back to? What happens by default?
Which stream is data sent to?

Thierry

--4LFBTxd4L5NLO6ly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAls6JjsACgkQ3SOs138+
s6Eocg//ecQc8Nx/NJvOletPxaThwcsEtINjIWHInHZq6CzmY/lrvS9ewzqWHocv
xV+qUziWgRY5i8LUnQ/bPnCRRHP3oEZQOhAigZCK4sZX17LyaL/RMFqcT61+Umlv
pE98vpYGeBFKt92VMv3ou5pKNQH/CM9CM0pVhhUSlm7LCgy3M4PZqxPApSCdbWLw
MoQE4Ex0E5uZr5L7x/S9V5xz051pey3vfTziOvZj8FasXSZZtoZ0zIEkuzKO25q+
2XYSH0j2Xihfp9bvOcO70pVAPykSLYF0QYqmoFH6apJnwomSEYYompC67BXUYOit
0l8NXCED1RG6a3mkCU9fr/tfcyKoz83iADrJv3gNI3QJhWFWduIEaSQS8rqeHZSn
e2cXirbqp28L3PVmOKWbKuDQY0/Uow7eLZw+ckd8PBXsOTDPdsdjm12IyGEEKugJ
NPBtX6oQms2hauvJGAvv6hb1XZafTeiaF7fMXzOQJVNL1owNPx5dd908XFLP6ca0
HVuq5pq+T/sFuM0yyX4zHbTKHWu1+DkManiN8AQw3V42LbN6/3GdGx7+PbYHVdCA
9gFUv28cY5uq+Dju5BSOi3tPMcv7gNxWhb2EPOImR+0UND+ET7DzVLLkhK6dUZsL
nHx/r0HX0CnHn8o2243Jb6KIzvmuqkbbE3jEOlgSedC34qH56Os=
=+LfL
-----END PGP SIGNATURE-----

--4LFBTxd4L5NLO6ly--
