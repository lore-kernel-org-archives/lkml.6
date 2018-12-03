Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A525DC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D57A20848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fPkOmVnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D57A20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbeLCOtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:49:00 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:56697 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726394AbeLCOs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:48:59 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 2AF642205C;
        Mon,  3 Dec 2018 09:47:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 03 Dec 2018 09:47:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=jqc2MR
        qua+KJIGif6w9XLYG+onFwEqFJEdf3FZHdfw8=; b=fPkOmVnPkfMngbSe42HH3m
        7bWTITKL8icSvPjpMvUgBwY9R8qZn99qsWGhUfOX/oa4pV5KUiUecJcV1timXnKJ
        yhdxpHXiR5xBRClxJjazVYcmzVg/XBgYoPAJJcX34p26SogI8WSBQot2rBwb9JOz
        RP/eGR2hozeihC1AqQaMk3yZFsnQ+/b7BvbKtrcdDxXR7Ui37L6HjNonwJ+1bANF
        7mG5rVOPrLqayqxNWBVdwqzbh/7sAK0GhPWW0RLQWj2PqShsqb2Ge/bqLUEClkJO
        u+jHDjzoVfBpqmW5UFe6vPwBPlFx8KPOfjzFPVZ21N+GQ6nuyumjjxGIOLviJccQ
        ==
X-ME-Sender: <xms:DkIFXKm7mIN36D3mZo-_WfL665DgGMvsN8LFFqrBcIYRmj-ViSF29w>
X-ME-Proxy: <xmx:DkIFXB7jUAXgfm0pgeG25MDPaFEx11oxpwCLFA3misABpOfWbzduQg>
    <xmx:DkIFXPGdbof6H4xOZB5x17AaKL6WhvQmZapOj0Au891ARQEEKmLMYw>
    <xmx:DkIFXKQOBsx5jygZkYWMl0i4cIoNf8GK__I9uqmLkcaZKIaDhhaTnQ>
    <xmx:DkIFXIsRsvBZQNQm29IEjViMiYbunY-bsfPOPMcoOiyhDjPs2j4sQg>
    <xmx:DkIFXJxFUMsGzvUFQEZ4ca73zadqC9WybYKiuUSR0Y5-EnmKvokClg>
    <xmx:D0IFXJAxw3_pdt_x5ez9gnv9UwfRFFeZ3acElN2j86gV_EryLIey5g>
Received: from mail-itl (ip5b40a57c.dynamic.kabel-deutschland.de [91.64.165.124])
        by mail.messagingengine.com (Postfix) with ESMTPA id E943B102DD;
        Mon,  3 Dec 2018 09:47:40 -0500 (EST)
Date:   Mon, 3 Dec 2018 15:47:38 +0100
From:   Marek Marczykowski <marmarek@invisiblethingslab.com>
To:     Jan Beulich <JBeulich@suse.com>
Cc:     Dwayne Litzenberger <dlitz@dlitz.net>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [Xen-devel] [PATCH 2/2] xen-pciback: Allow enabling/disabling
 expansion ROM
Message-ID: <20181203144738.GQ781@mail-itl>
References: <cover.55c0e31b75e2fbdf4206cc39c2fd7581793ae7ae.1543772656.git-series.marmarek@invisiblethingslab.com>
 <cover.55c0e31b75e2fbdf4206cc39c2fd7581793ae7ae.1543772656.git-series.marmarek@invisiblethingslab.com>
 <a05e3cf451d692dc4b1c81c8b5d66fc75d1fa325.1543772656.git-series.marmarek@invisiblethingslab.com>
 <5C050CF3020000780020223F@prv1-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YPYi+6JBnn8IjLOH"
Content-Disposition: inline
In-Reply-To: <5C050CF3020000780020223F@prv1-mh.provo.novell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YPYi+6JBnn8IjLOH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 03, 2018 at 04:01:07AM -0700, Jan Beulich wrote:
> >>> On 02.12.18 at 18:47, <marmarek@invisiblethingslab.com> wrote:
> > From: Dwayne Litzenberger <dlitz@dlitz.net>
> >=20
> > Newer AMD GPUs store their initialization routines as bytecode on the
> > ROM.  This fixes the following initialization error inside the VM when
> > doing PCI passthrough:
> >=20
> >     radeon 0000:00:05.0: Invalid PCI ROM header signature: expecting 0x=
aa55, got 0xffff
> >     radeon 0000:00:05.0: Invalid PCI ROM header signature: expecting 0x=
aa55, got 0xffff
> >     [drm:radeon_get_bios [radeon]] *ERROR* Unable to locate a BIOS ROM
> >     radeon 0000:00:05.0: Fatal error during GPU init
>=20
> Isn't it that qemu is supposed to surface the ROM image to guests,
> making it unnecessary to allow guests control over the physical
> enable bit?=20

Unless that qemu is in stubdomain, where it use pciback to access
everything about the device...

> Also why would allowing to alter the bit depend on
> whether the address portion of the value is non-zero?

That's a good question. According to commit message I think it should be
a ROM presence check instead. If needed at this point at all - is this
function even called if there is no ROM?

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--YPYi+6JBnn8IjLOH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAlwFQgoACgkQ24/THMrX
1yzHOwgAlmyX8AwWoWYIW87CGtuTbVpBXQmaYjhCULHvRQaHsxW2b2xeviyuAScY
cC3TKViZwgtFEHkH/mODR96Dn0KDxabDMxIym/FAXu179KS5lPpFZQhNo1oDNaL6
072FLHQ1xOXxqHVUp4AQOc9gBnXmFGXBG+WXqOyCT0/PiJDeymucnsQuu1jdVRgb
5pU2gsB8bYbyy6ZXfpbLLm/mQR8i6k8SR0TBmNHK5H43SR4eUDDPZQqOCwyWTBUn
hMfSw2zUyNJllugBbclxxXEFZM+Vq8ZAiriqND/xLWl4wrlpqT654E2aymSD6qTU
djuJIkiQ15nhaZe7UecjCpyRyegojA==
=IdtU
-----END PGP SIGNATURE-----

--YPYi+6JBnn8IjLOH--
