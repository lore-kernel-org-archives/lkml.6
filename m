Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316FAFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB5220892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="drV62tJG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eG3ZZISR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB5220892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbeG3Jdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:33:41 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:37691 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726401AbeG3Jdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:33:40 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id A43F7358;
        Mon, 30 Jul 2018 03:59:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 30 Jul 2018 03:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=G51edHxvjsCfSdersHPYPe1W7FvLuaKvW7FK0VltXS8=; b=drV62tJG
        n3cALeUwYoQt5rlU8+fu4uALK0+KDOX+xpIqzMQHzdjtezMYQqbZC5vuGnRgmcZE
        o0uNhFAAMrgwP7AhjUVYWQO4XP1A8fxSsGNW6BBjGbRDSxL4/3ZyYouBzg4v7o4I
        rDQk6bPUWU/iISGcdZEubZvnLq70/Dqg5mdCurmxHeT8AY8CUQnd6VnHCpNjgozY
        Sei3BSFyFUF0YdzJtr2jynPIR5JwEBXHHGjUO4ZppCPEjjwZ+i9G/711sxuiEyJS
        4GY1dVhGsD/uFts3YrgP1JOV8ybnMWh4eJF5L7poJZeW6MJg/UcoD2KURvPG0Lsp
        BCLgfLhOtbJSDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=G51edHxvjsCfSdersHPYPe1W7FvLu
        aKvW7FK0VltXS8=; b=eG3ZZISRex26P3yLpV4YuxUH6RlmM7eQa6v83t1wftH8/
        KsduUPmVo/7giw2YsgEyLXKWBCQDyhPkNWD4VWLxNitOR3sGrYXbLigd1Aci/lAC
        sD70swJiF8lCU6YwphBEIVKdZcfU7NPefcc66HcV8gfy9y1I7gDQ9nPRHhE603dI
        LB/EVoTXn+NYpIzaL85R7L/bYfOfwe4sZ9EhmTsQDlR5E9pdtEfcr76W3hUVFTQP
        yUqS+xmQ6+6pEWuKgGiypW+TgjAiTERDBqRq5knT5Y+JDeZpzcNJIkLoI9hXfVh0
        gY5XdCaQcDFJiUr3aig3Hlamz4GCNBRrO1YAKMiyQ==
X-ME-Proxy: <xmx:eMVeWyEP8NZg8RGPmJ5qvwbnS7WIwZcURkg3blC0LCdVKnfwmh0LUg>
    <xmx:eMVeWwBj5M9IMIvPjswUXogDGFqqIdopDMieoHZVLRNfeSVSoG0QJg>
    <xmx:eMVeWwAKHnNup9OujaRYYD36JvqYSmfy--8e21Njuiku73XJYUpdPA>
    <xmx:eMVeW2M1jNbYw5xJl2S7hzVMp1UuW_x12ZbA-yPM218sAVLmlwfFEA>
    <xmx:eMVeW8P6ZCozAYsGpxhz-XwaHbDCjHuH81h5E8qb0rOnj7lNa9xD6w>
    <xmx:ecVeW5PjDmnfVgzh-s0fjIOq1cWDtlSmpAQAAaPB6CerDSEy3wbFmQ>
X-ME-Sender: <xms:eMVeWxOdvLVK42YGU4DycBZoq6J4NuO_lW-QzuWUeoCLlphz1pHQZw>
Received: from apu2.pks.im (x4e30b842.dyn.telefonica.de [78.48.184.66])
        by mail.messagingengine.com (Postfix) with ESMTPA id DF019E4014;
        Mon, 30 Jul 2018 03:59:51 -0400 (EDT)
Received: from localhost (10.192.0.12 [10.192.0.12])
        by apu2.pks.im (OpenSMTPD) with ESMTPSA id 6304f3c9 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Mon, 30 Jul 2018 07:59:50 +0000 (UTC)
Date:   Mon, 30 Jul 2018 09:59:49 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Tomas Janousek <tomi@nomi.cz>
Cc:     Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: fix NPE when resuming SCSI devices using blk-mq
Message-ID: <20180730075949.GA1755@xps.pks.im>
References: <b712b87a509dc64619a3aec7c673935ed09be5de.1531488173.git.ps@pks.im>
 <CACVXFVPoO7kcEnUVmqGVWDgiTVYup2sD9puBZ8FzY+mDaMp-bQ@mail.gmail.com>
 <20180729094131.4kwuukzgfgtisgya@notes.lisk.in>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <20180729094131.4kwuukzgfgtisgya@notes.lisk.in>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 29, 2018 at 11:41:31AM +0200, Tomas Janousek wrote:
> Hi,
>=20
> On Fri, Jul 13, 2018 at 09:41:41PM +0800, Ming Lei wrote:
> > Now runtime PM is disabled for blk-mq/scsi_mq, not sure how this issue =
is
> > triggered on your machine.
>=20
> While Patrick did miss the following patch:
>=20
> * 765e40b675a9 ("block: disable runtime-pm for blk-mq"; July 2017).
>=20
> there is at least one other way to trigger it -- enable laptop-mode-tools
> or tlp which enable runtime-pm for all devices.
>=20
> The "disable runtime-pm for blk-mq" only disables it _by_default_, but do=
esn't
> prevent it from being enabled again from user-space, which it is unless o=
ne
> manually blacklists sd devices from runtime-pm enablement. It's bitten a =
few
> people already: https://github.com/rickysarraf/laptop-mode-tools/issues/1=
23
>=20
> (I found this thread because I'm also getting the NULL pointer dereferenc=
e at
> 00000000000001a8 on resume from suspend.)

Huh, I did send out some more details on how I reproduce the
issue, but it seems like my mail didn't get through. While I
don't use laptop-mode-tools, I do have some custom hotplugging
scripts which do in fact enable runtime-PM for most devices.

Regards
Patrick

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAltexXUACgkQEXxntp6r
8SyzOg//T0tHxr7/QEE+jM9OHI6NouFFHh7CubJtlZk9Ocv0VQv/4AY9zSfkkqQ/
9gkGaRnSbM7J7IMdAMsjDkDB+5FUw7uKIFB+0zCxjUK09Zq9jnhw0yiWMCiwOedh
v96KLiacbIa/l6E+h+xMStNv0goGQcF3AzHlDKjgtstJSnL7aD7XX4URve4YeSuQ
AAq3yQUbk8tPZcnlJm9SwTXUd6MOoYjCsdl6ptPl7Z1iNrf3ZhGoUzPUaUoG3RE3
4ZqM74Y3KOHTBhXzyZkoz/SFkUghHJGdaZMm7zk8ApfhQAGw0573JPsH4pj4z7h6
b0ad2PYmLn8O2c22w6THQMyVO1HaUQg6ngJfTzZHSaGlwqxNFfAKcwYBbAFUS+fQ
Wb6YlIopC2MVYyAK21r+0p50SntCULRu04ptRFe0gILpfc0JnY89DYOPwk7yEClB
OXyUKbRXCm/+USe9kKx4vFRzJVdL5Ubohu6v7da6Lm8C6YqZC/o9fYYegrzZdIKB
TAZQWhRiscXPqdD2lZtmTpKFp2QuKcbWwi7PSrP4jz2gar/s8xN7LATQThSPOEkK
x+uuGQWFaqGQTHDwn7ViRCXX2rtTysu0Q6fztZ3wc75T7fIzkk98XfAPGGbG5pFV
qOUKuC7MJaGMOc9g3LJSXblqZUgW/liSvGB7aSecWXVAV2LLACI=
=RrcF
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
