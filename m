Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59E0C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822A124B0A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSmqvsm6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 822A124B0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeGBODu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:03:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55542 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751956AbeGBODr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:03:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id v16-v6so9211768wmv.5;
        Mon, 02 Jul 2018 07:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FLTNVuVHwS09kmnSDPG3sB5y0oinFGSJHY6z95lYdV8=;
        b=MSmqvsm6uRJb27Nvx3MRBw01w6z1FFhHbIGSwVqeknwftj4fVQ9ZfQ1/zA5Ul1Kq45
         3VHdh3PcHa4v8Vang03BoeISuDHNwWsZlotPliaTLPmrnrdygpBILViKa/rXEnDX+Da/
         DKL5kE5o+fj0fUcNZUG/ujwSI8BNWQ804TgIJSAcZkkCKcITsL59Sjo7YQxxkrl9d5eP
         /4NURuFhvLDzEu3G2xCviwh8CgTSXYngxYVPW4iMIg61+ijnwS03Qt3pDLd5DGsFnbn5
         0eZEkwEzPfo9+OOXM/VhHZthWE1qOFCnQvi6SPHGkhyxQjBUCCVJdNN3i3bR7GZhAT8u
         UGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FLTNVuVHwS09kmnSDPG3sB5y0oinFGSJHY6z95lYdV8=;
        b=PUpxq1SUreIF4JnNzig7YxLGTGTR7TDPMKzzqChVtaG9Dfnpbwm75fygzJw5SF2wFn
         Bgz9fQ1qBoYYT+FX90LF7qZadn7YHEml+oY4i8b039nwdcwLaHlNsNi1nd4Lzrz2G9R+
         7PVe3UN5D1Hv84c6n4+ETzAy4dzJk3NOsOTBDY85v1d7HfUTB4L9fKXhjT3cSSZM1dNr
         Z7onCBDz4aeLmWX9yMXZdf23yhX0GjEBw0vYfeLiIsDhpeqN3O1LW5Vase0QO/Iz6Wql
         tMQHXsEs9t79he8rPbM2aEFgYuHHmPG7piapzFtqcd3R1WfGjhdj2iQDaBWWZ7VkzjCq
         gSrA==
X-Gm-Message-State: APt69E3cVs2SJt+0d5nP4tFXKCfgLKt21Wk7z1MY8hSzvMeOWgi7UAT5
        SMxaAv2yALT4RrvKhhlSgNM=
X-Google-Smtp-Source: AAOMgpcXCgyOPKLX1FcZrOou3q9yf9CLXngsmjFXJO8FSchBkJe/xbiHZ6mmcVLI0VIPzjqsejGfeA==
X-Received: by 2002:a1c:8d15:: with SMTP id p21-v6mr7696250wmd.145.1530540225755;
        Mon, 02 Jul 2018 07:03:45 -0700 (PDT)
Received: from localhost (pD9E51838.dip0.t-ipconnect.de. [217.229.24.56])
        by smtp.gmail.com with ESMTPSA id d102-v6sm10960883wma.10.2018.07.02.07.03.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 07:03:44 -0700 (PDT)
Date:   Mon, 2 Jul 2018 16:03:43 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mikko Perttunen <mperttunen@nvidia.com>, jassisinghbrar@gmail.com,
        gregkh@linuxfoundation.org
Cc:     jonathanh@nvidia.com, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] Tegra Combined UART driver
Message-ID: <20180702140343.GO13096@ulmo>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Iys0Un1O+0sigPHU"
Content-Disposition: inline
In-Reply-To: <20180702114033.15654-1-mperttunen@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Iys0Un1O+0sigPHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 02:40:25PM +0300, Mikko Perttunen wrote:
> Hi, here's v3. Changes are in individual patches. Acks are still
> missing from the following patches:
>=20
> mailbox: Add transmit done by blocking option
> mailbox: tegra-hsp: Refactor in preparation of mailboxes
> mailbox: tegra-hsp: Add support for shared mailboxes
> serial: Add Tegra Combined UART driver

There don't seem to be any build-time dependencies between the above, so
technically I guess these could be applied to the respective trees
separately. The only thing we need to be careful about is to not merge
the final patch before the others, because it will break serial console
if the other patches aren't applied.

Jassi, Greg,

What I could do to resolve the runtime dependency is pull the mailbox
patches into a separate branch, create another separate branch for the
TCU driver that is based on the mailbox branch and then base the DT
changes on that branch, or possibly send a separate pull request for
just the DT change late in the merge window or shortly after v4.19-rc1.

Obviously the latter would be equivalent to you guys merging the patches
through your trees for v4.19-rc1 and me sending out a late pull request
for the DT bits.

Any preference?

Thierry

--Iys0Un1O+0sigPHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAls6ML8ACgkQ3SOs138+
s6GrjxAApVMK4gKLyqmXitg+u5FHQadFlJu89OVNUqmuF2AWqg3qq74JssA/QLAH
dv6nRRrhGvizXqcj6B6F2U8It0cvah8fJYxci1oDKxlPo0ejPuNGGCRMw79MO+Jk
SHhufCIoB7HisBIh/ocjLowlFD+B9Z9udhEiIqJHAZ9xhA+t4EvuGNqdnqxELX+6
0gK20Of2tXdF8TZPIQ9qZDt0mH97oLWofygzv2zO6GsQeead7H1MXMa6QBHBt8NC
yUeLKncthYL/x9NA7GBhfL2RJFrUFCjUt3um2+CPEv1OmGrz8DFu+ozcoqWwYzDE
q4Wa+uYsW5Qupt0Oj9F2DdMeqi7aHFtptKOxHLUNj6fHj2maIDfUU2AAcfiFogkP
kk8VO1o7DikltjWT7NeZRRaUa8SkWW1xgQKKWRFiMu3J1BowoYrE/Qo9IZPOj82b
T4UScNA0zNO87u0sJBCLZo+VFMEM32qdPPYYe04SiT/Bh3Cnsh2mJC++ctT3lGWT
OUYiiDn+1MJRiuatb1PkVbKaOnUxNyi98duTTksHbqODfyYuybvMAHS+EUYjc80k
vMX9Kt7FJR1DQSx8k2f4R+ebk7g8upDQWc/RWUTlA0PDuzPmGFe/Gdg+tWIDVGOB
I0TXw3stMEQezthrRaBwy9l+f58tOpWYJX6qaewtCzgMqE0/DY4=
=llM5
-----END PGP SIGNATURE-----

--Iys0Un1O+0sigPHU--
