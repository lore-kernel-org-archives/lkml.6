Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D48C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A25125DE3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brZn8Tht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A25125DE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbeGBNri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:47:38 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39145 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752136AbeGBNrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:47:35 -0400
Received: by mail-wr0-f195.google.com with SMTP id b8-v6so15623188wro.6;
        Mon, 02 Jul 2018 06:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H0kUeYovygzjPn9JVrVy1hiYJh+Gto2G8aq7Vg76iWo=;
        b=brZn8ThtsXJR5SlFhm6iaWHKEwasVGRO590tMf14quCqwq91cddEKYWmho89OtVL+X
         kBDh+/AVl37dmuRL1qh+RR70ob2wEVEGjPJ99I651DFNLLlnpj1pYgvkrfpNYm0BFntf
         vogR5v9Js50jSOZsaMmmpGth2fUXpXdoolu///NtyckYCnqdvwLJuN8Nfl7U1Zt/ami7
         mYC0OlJxB+5G96uztVWM19Z8x1Ox29y/ZkwvRsLwzMfvRVpxH6ivz24dGwK2PQGlpLFq
         ZORvWUSn/R2yVEY5JO4I6X0803hJY5ccIrzP5fTc0GFid410g9hcd3A6e4CIMpb2AWWd
         lLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H0kUeYovygzjPn9JVrVy1hiYJh+Gto2G8aq7Vg76iWo=;
        b=OJTSBR/pkSbboJbyM8eI3x1BU2PKaCHmXy4yemPK5lT+O+7WYhY2qngkpuY5/Z52Zz
         MPF+os/Yu4Md9ETGdzxfbkaF3ZpWRPJ4ap+LjnIgAKA+KejT+JyRpFy1dXw0X99ZQgXY
         CeLWVT4eZ16cbN7YI138Tmx9hPRDIn0euKRtUg2ET0hEubYDXGvrIJ0R2Wc15fDwXjIA
         Yk7bCiMW+WMxIxuPYbmIpdzYHKv6Q29DHGzSnbTTX9mNLUEOgvj80swTRkHuafvnW9NI
         a//WR2Bl2L6MQpsKVAdD3i9EWGsBWQ8ZyHw34LcrJcI+T/wRlrSN/8cMgYlgK1CA717G
         xYeA==
X-Gm-Message-State: APt69E17MmG5rI1IgKYwut6tlFoIvkO4Y7IXi9BQSMYky7iJb1nfQ506
        uBdncmV54cAFyznp6wFV7LY=
X-Google-Smtp-Source: AAOMgpd+6bX/vOX2U3jQRf86BfHEcFI7sfgN3312g1RVKhzvwK3ui0E2Bucf13K+wmRg8abiBKmbLg==
X-Received: by 2002:adf:f850:: with SMTP id d16-v6mr4311002wrq.172.1530539253229;
        Mon, 02 Jul 2018 06:47:33 -0700 (PDT)
Received: from localhost (pD9E51838.dip0.t-ipconnect.de. [217.229.24.56])
        by smtp.gmail.com with ESMTPSA id e126-v6sm14635073wmd.43.2018.07.02.06.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 06:47:32 -0700 (PDT)
Date:   Mon, 2 Jul 2018 15:47:31 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mikko Perttunen <cyndis@kapsi.fi>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
        jonathanh@nvidia.com, linux-serial@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 6/8] serial: Add Tegra Combined UART driver
Message-ID: <20180702134731.GI13096@ulmo>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702114033.15654-7-mperttunen@nvidia.com>
 <20180702131851.GH13096@ulmo>
 <50c4702b-3d59-e443-5075-c888f83a2615@kapsi.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CD/aTaZybdUisKIc"
Content-Disposition: inline
In-Reply-To: <50c4702b-3d59-e443-5075-c888f83a2615@kapsi.fi>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CD/aTaZybdUisKIc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 04:30:07PM +0300, Mikko Perttunen wrote:
> On 02.07.2018 16:18, Thierry Reding wrote:
> > On Mon, Jul 02, 2018 at 02:40:31PM +0300, Mikko Perttunen wrote:
> > > The Tegra Combined UART (TCU) is a mailbox-based mechanism that allows
> > > multiplexing multiple "virtual UARTs" into a single hardware serial
> > > port. The TCU is the primary serial port on Tegra194 devices.
> > >=20
> > > Add a TCU driver utilizing the mailbox framework, as the used mailbox=
es
> > > are part of Tegra HSP blocks that are already controlled by the Tegra
> > > HSP mailbox driver.
> > >=20
> > > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > > ---
> > >=20
> > > Notes:
> > >      v2:
> > >      - Removed (void) casts for unused variables.
> > >      - Changed the uart_set_options() call to be on one line, even if=
 its
> > >        over 80 characters.
> > >      - Added defines for magic numbers.
> > >      - Style fixes.
> > >      - Changed Kconfig entry to depend on the Tegra HSP driver instea=
d of
> > >        just the mailbox framework.
> > >      v3:
> > >      - Removed FLUSH bit, as it's unnecessary and slows down printing
> > >      - Removed call to uart_set_options
> > >      - Added mbox_free_channel calls to remove()
> > >=20
> > >   drivers/tty/serial/Kconfig       |   9 ++
> > >   drivers/tty/serial/Makefile      |   1 +
> > >   drivers/tty/serial/tegra-tcu.c   | 291 ++++++++++++++++++++++++++++=
+++++++++++
> > >   include/uapi/linux/serial_core.h |   3 +
> > >   4 files changed, 304 insertions(+)
> > >   create mode 100644 drivers/tty/serial/tegra-tcu.c
> >=20
> > The driver looks good to me. But for my own understanding, is there some
> > way we can make use of the multiplexing? That is, could we add a
> > mechanism to have the driver filter out only a specific stream? Could we
> > also specify which stream to send data back to? What happens by default?
> > Which stream is data sent to?
>=20
> There is no multiplexing on the producer/device side (i.e. what this driv=
er
> does). The mailbox specified in device tree specifies the stream we send
> stuff to. The mailboxes are per-CPU (we use the CCPLEX mailbox here), so =
it
> cannot really be changed.

Oh, I see, so there is one stream per pair of mailboxes? That is, the
mailboxes we specify in the DT define which stream we receive from and
send to?

Thierry

--CD/aTaZybdUisKIc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAls6LPEACgkQ3SOs138+
s6GgoRAAgtnbovyRq903FXdRr2JlpUdtYTe6KCeaqJKUJLW/jeCa3FbHzG6e3j2S
z4su9htK4XWFVirwoGDnJgcQfgqIyfMpynjD8j+ol9L6q5ZMKGqKdg1+sNG6DwkF
M5oYhrTJVaSLlw2X6u3EeBCekqHQjwMEKrKAF+dA7HXOxkZ7vgH9k78VbLgO8yyq
40O7VIuJuLzPicAj74uRYQYBSpX1nyUWIjtoyBxhojFoUvein50Ek1XzEPf/Bgdy
7CM/x9K3Qh/P+shnJXHbbr8pDOTL0LeeOxmJQ90rRbbb0K8gwNpc+U6ZA0KHHYWt
+bKholbST16nc23pvv35KImjgHis+tYJ8y0TTtNoRI+l8nNCqGGRHLrmHRnhZHj9
RKGN2nd0sZf/MtcsciLWsVkI7i85SvxzulWI1Xty4Y4yfKBYOKyC+ix4ul7w3TRJ
Ztd4BVF22PUTkA9KNATLhlX2YvCjIs1MPI28u2YgY2UqNu135OBT49ggiK7Ys8oo
PwftqVO/Ipp/fdHYHLB3xckvhY30XsBHZqRnj+4K9yw6K3wNOBv5cqNrAl94+uBL
Q91dMAos5hVjKg5rEwPdbELYT4f0r53GpC/3BRgPlZzUY9NIqIPIdJfZZX55VCs4
dLHS7tgo2KhTOlkOYod2x6HjmdID4Xn9kjrcvYvO+OMVXMib0Rg=
=fZKs
-----END PGP SIGNATURE-----

--CD/aTaZybdUisKIc--
