Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75166C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442762086C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549630345;
	bh=gzsFFxhY/vxcDbusniXRM/csEGoQGw+/kSIDREfrnqI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=jyUzLkaSTEcA6kHR33FalwiwjszcOhAK6SChvl/Dl0ja01JjK6CfmzvwcJ6jaHM5y
	 p/GZvXqXU1A/Uhg+FMCyKsB8eEo01oytVRQ7stBxet6Et22jQk0g9p01aaTFMqskon
	 qrGcUcf5Ws0uTqpNaYWgyQNxNGxarmsKiSnUyWek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfBHMwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:52:24 -0500
Received: from mga14.intel.com ([192.55.52.115]:3400 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbfBHMwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:52:21 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 04:52:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,347,1544515200"; 
   d="asc'?scan'208";a="120948675"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2019 04:52:19 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Roger Quadros <rogerq@ti.com>,
        Jochen Sprickerhof <jochen@sprickerhof.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] usb: dwc3: Enable GBit Ethernet on Odroid XU4
In-Reply-To: <bdbce410-7f48-17a5-b58b-3ebd65ca6913@samsung.com>
References: <20190121140204.GA2360@vis> <5C5A9DCB.8040507@ti.com> <20190206093830.GS26157@vis> <CGME20190206101740epcas2p131674b4b9733047711855ffb2e7a99a7@epcas2p1.samsung.com> <5C5AB41C.9080402@ti.com> <bdbce410-7f48-17a5-b58b-3ebd65ca6913@samsung.com>
Date:   Fri, 08 Feb 2019 14:52:15 +0200
Message-ID: <8736oyl9xc.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Marek Szyprowski <m.szyprowski@samsung.com> writes:
>>>> On 21/01/19 16:02, Jochen Sprickerhof wrote:
>>> [..]
>>>>> I'm not sure why this it only works with the driver compiled into the
>>>>> kernel nor why it needs a hard reset or why it was the line was dropp=
ed
>>>>> when the patch was accepted. Would be great to get some feedback of t=
he
>>>>> authors.
>>>> When XHCI driver is compiled into the kernel are the relevant PHY driv=
ers
>>>> compiled in as well?
>>> Only CONFIG_USB_PHY=3Dy (I took the config from the linux-image-4.19.0-=
1-armmp_4.19.13-1_armhf.deb Debian package as a basis where this is the def=
ault).
>
> I confirm that on Odroid XU4 USB 3.0 works only when all related drivers
> (dwc3, xhci and exynos5 drd phy) are compiled into the kernel. If they
> are compiled as modules, USB 3.0 calibration doesn't work. The mentioned
> patch doesn't fix anything.

cool, thanks. So the problem is elsewhere.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlxde38ACgkQzL64meEa
mQaIHQ//QFi3UZE7sCkB3cWqeSdCGJ0KIDQoOc9KqE06N0/dENnwJJTw6jYJXSWa
CwreiMal7yKFy7ry/nZ2TQhgWXL/XDvk6444xRiFo4jFluKsSLZbq/rotyS9SOGy
VMQYO/vWY7p8GwALoxz5ddCRDRi5HSkOx2aBRYk/51YC5rIeyHYKtXB+4vnKwtxD
pbazMChgeLDZDcXUAO+RQYaDdamhvAadcX+8hzujA2IhYikym4XusnJvaNy/xF4N
HpJMXjISUHsfLfQE+sSk+Wz+GcJgfQuUkHAnRABMVOWAj2iqw0IIDGQenDO9BUcT
BRYNPbskE+YyXSK353XHYyuXtw7bxi7zr2DgLMFW72165PVMjSjwjJvh+0cRLpCn
ywzH0SYX96J+JbTBqsiQ5Hc3Uf1oesz4gXX2467ZsQmcBDU6O+KDEj1lcCGS4d3C
E1IQaLnBxTVvDl054o5ftVCo9NRM+iAKyl6LYSDk7aRhE0ya1QZe/ab0ByNbIJ3W
bXBejFQTQzwJGt4IXKPsHRCTBqPXQ8myYqDdGFafUm2CFlfLJgZzZ2P6Xq3ubLNm
ZwgqyKvQ46PoeYa7+A1Fi+AqpZolxv6bZvTG+aQYn3alf/6B8HxyhrUFSmQKVH/m
V99SOsAR3pF93hGId8qBSNKaKB+YBIFfateUY3N8cCSYvrHxeH8=
=Vf++
-----END PGP SIGNATURE-----
--=-=-=--
