Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B52CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A24920817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A24920817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeK0HbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:31:24 -0500
Received: from anholt.net ([50.246.234.109]:37710 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727086AbeK0HbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:31:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id CFE5310A0E8E;
        Mon, 26 Nov 2018 12:36:05 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 5GR06qdr7wBr; Mon, 26 Nov 2018 12:36:04 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 611BB10A017F;
        Mon, 26 Nov 2018 12:36:04 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id F1E282FE1FE6; Mon, 26 Nov 2018 12:36:03 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Michael Zoran <mzoran@crowfest.net>,
        Tomasz Figa <tfiga@chromium.org>, helen.koike@collabora.com
Cc:     Sandy Huang <hjc@rock-chips.com>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        "list\@263.net\:IOMMU DRIVERS \<iommu\@lists.linux-foundation.org\>\,
        Joerg Roedel \<joro\@8bytes.org\>\," 
        <iommu@lists.linux-foundation.org>,
        "list\@263.net\:IOMMU DRIVERS \<iommu\@lists.linux-foundation.org\>\,
        Joerg Roedel \<joro\@8bytes.org\>\," <joro@8bytes.org>,
        "list\@263.net\:IOMMU DRIVERS \<iommu\@lists.linux-foundation.org\>\,
        Joerg Roedel \<joro\@8bytes.org\>\," 
        <linux-arm-kernel@lists.infradead.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list\:ARM\/Rockchip SoC..." 
        <linux-rockchip@lists.infradead.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        =?utf-8?Q?St=C3=A9phane?= Marchesin <marcheu@google.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v3] drm/rockchip: update cursors asynchronously through atomic.
In-Reply-To: <1d10a4323a49ca09bbb7dc865aaaf5b8c5e3b3d5.camel@crowfest.net>
References: <20181119190805.19139-1-helen.koike@collabora.com> <CAAFQd5DDZwhdMDbrHthQwm2bQ3+NoZNcemAktVTxkR3=LfnnTg@mail.gmail.com> <d3fb3b21-6c3d-6b01-727b-dbd66540ce92@collabora.com> <CAAFQd5Afa9ndmU0=q5Kjv-BY+0qpvOdq2+eOTO6OebX4-2NENA@mail.gmail.com> <1d10a4323a49ca09bbb7dc865aaaf5b8c5e3b3d5.camel@crowfest.net>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Mon, 26 Nov 2018 12:36:03 -0800
Message-ID: <87o9abbmq4.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Michael Zoran <mzoran@crowfest.net> writes:

> On Fri, 2018-11-23 at 11:27 +0900, Tomasz Figa wrote:
>>=20
>> The point here is not about setting and resetting the plane->fb
>> pointer. It's about what happens inside
>> drm_atomic_set_fb_for_plane().
>>=20
>> It calls drm_framebuffer_get() for the new fb and
>> drm_framebuffer_put() for the old fb. In result, if the fb changes,
>> the old fb, which had its reference count incremented in the atomic
>> commit that set it to the plane before, has its reference count
>> decremented. Moreover, if the new reference count becomes 0,
>> drm_framebuffer_put() will immediately free the buffer.
>>=20
>> Freeing a buffer when the hardware is still scanning out of it isn't
>> a
>> good idea, is it?
>
> No, it's not.  But the board I submitted the patch for doesn't have
> anything like hot swapable ram.  The ram access is still going to work,
> just it might display something it shouldn't. Say for example if that
> frame buffer got reused by somethig else and filled with new data in
> the very small window.
>
> But yes, I agree the best solution would be to not release the buffer
> until the next vblank.
>
> Perhaps a good solution would be for the DRM api to have the concept of
> a deferred release?  Meaning if the put() call just added the frame
> buffer to a list that DRM core could walk during the vblank.  That
> might be better then every single driver trying to work up a custom
> solution.
>
>> The vc4 driver seems to be able to program the hardware to switch the
>> scanout to the new buffer immediately:
>>=20
>> https://elixir.bootlin.com/linux/v4.20-rc3/source/drivers/gpu/drm/vc4/vc=
4_plane.c#L794
>>=20
>> Although I wonder if there isn't still a tiny race there - the
>> hardware may have just started refilling the FIFO from the old
>> address. Still, if the FIFO is small, the FIFO refill operation may
>> be
>> much shorter than it takes for the kernel code to actually free the
>> buffer. Eric and Michael, could you confirm?
>>=20
>
> I don't have those boards anymore, and I don't have access to any
> technical documentation on the GPU so I can't really add much here.=20=20
> Eric can probably provide the best information.

I don't think I understood my scanout hardware well enough when I
started on the async update stuff for rpi.  vc4 probably needs to wait
until the HW starts scanning out a new line before letting the old BO
get freed.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlv8WTMACgkQtdYpNtH8
nug/8g//Qdb/mO4elB5pT5C2hntdmbojIIRYCggRx9GRhN11f9SDGJFbcUE4Hlmy
VRLqWtFYCLkKspMRPGHyKjS1LSEIAK+3YsITMz+iXzVzR13xuKAIztGvPVWkqOdt
cO3JbnNqA1HcBviI5x+s8085TrqtE45y6C9YsX4mHmP/hY2HX0RiEyK8jqwp+EGo
/8nMoqfzW8i9xabAcLuTQHl/5jgDBw1qpHof7VaQN4BK/Vamvw2wR8OadgsTjY1b
wrYfS1UtABX9bXefSG411/wRM1q9/aBO5198IavbEVKX0qY4eg1UbBSOPyBe1EQo
XKUxyQDL6IHr7lewyMx8l1K+BeZIC41yUa7c8ley48KQC8XBxJ7D4f9vQMQBflch
zGdVguOP+TUGbvWXgT3DGOxAZdN+bxdIw1F5J2iYhGzL2gxhAh+4XqlBDDMV8wSM
T4M/Zc7p7Po3i051zljZpRrwF6NZXgtlnxGzp7enZ2CGbIm38dA1J6f1dVbvpsiK
xDyNDPARznvJRKhzI24tif9M/jFunzOEI9qmaNC/3lWvoCI11f07uaXPUfSS98eY
7W0RtwezhiaoehiKoTvxfv6KhRprl4seVHSJhRX5cmQ3PAE+UtYtbm+zPYgiODPr
WICwLebgm3q/aqH0DAZb7WjDvu0dACQc7BoSB8OtEC03CDgMlh0=
=HcqO
-----END PGP SIGNATURE-----
--=-=-=--
