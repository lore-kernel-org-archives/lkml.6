Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9368FC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F87B207E0
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfBHTo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:44:27 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:64437 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfBHTo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 14:44:27 -0500
X-Greylist: delayed 557 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Feb 2019 14:44:27 EST
Received: from [91.97.136.117] (helo=localhost)
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <jochen@sprickerhof.de>)
        id 1gsBvU-0005Hy-MR; Fri, 08 Feb 2019 20:35:04 +0100
Date:   Fri, 8 Feb 2019 20:35:05 +0100
From:   Jochen Sprickerhof <jochen@sprickerhof.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] usb: dwc3: Enable GBit Ethernet on Odroid XU4
Message-ID: <20190208193505.GA5822@vis>
References: <20190121140204.GA2360@vis>
 <5C5A9DCB.8040507@ti.com>
 <20190206093830.GS26157@vis>
 <CGME20190206101740epcas2p131674b4b9733047711855ffb2e7a99a7@epcas2p1.samsung.com>
 <5C5AB41C.9080402@ti.com>
 <bdbce410-7f48-17a5-b58b-3ebd65ca6913@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <bdbce410-7f48-17a5-b58b-3ebd65ca6913@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Df-Sender: NTc3MDAz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marek,

* Marek Szyprowski <m.szyprowski@samsung.com> [2019-02-08 13:36]:
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
>I confirm that on Odroid XU4 USB 3.0 works only when all related drivers
>(dwc3, xhci and exynos5 drd phy) are compiled into the kernel. If they
>are compiled as modules, USB 3.0 calibration doesn't work. The mentioned
>patch doesn't fix anything.

I've just tried Linux v5.0-rc5 with the Debian config and=20
USB_XHCI_PLATFORM=3Dy and it works, thanks!

Is there a way to make it work with xhci compiled as a module, so it=20
would work in Debian out of the box?

Cheers Jochen

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEc7KZy9TurdzAF+h6W//cwljmlDMFAlxd2eUACgkQW//cwljm
lDPPHBAAnDHdDPIaq7kOdaLqP8bJRPxh1jU+C+jFA96s+nh34nHC3eRGEX5IZe7o
y3vfnslLmMSvhVhzVOmCzoC4B58sIHBNwEijKqdecMD8pDY4yxmKfGWSIDy+8qBl
sbz2el2Qq3MBNBmMn1uTczDg7Lb/I8TkpzLZ4brXKQsZifEJm8gVIPRh8zqAYz8z
sSYxvMHd2VUxT+daPRMnJJwSnpDkvGwC8ti8btK4GPHzYwyV4Yl9BLSUMQxUehAk
YsJx6VnBhu1e7E3t/9QqatgXYkrLcozgjSGKiV2HKKr0+OYa/ko2zfL9P5zAvGZx
0atzR5Crx0mQNQPeU6KC5QB801/XzydkhHHxpG2iDi37j/H9GFcb8KWeYdqagZsa
7uk13DQ/htuHDoas81WnRaGa7t7XrfIhQZMSVADdmSfmK/Fsu551djKuH8Y7N5sh
BpGyRgQXciBdYRUMhDoa99K5rBeuXlfZ6VKCHg67OJaueaX2SumXxTvBZUTDvvlX
eTDzZ9nuhX7bbBQf4UFgcFZWGJMMt9EBRrgvJu2AmWZ5Mbv4MVX0XYuP2khwXZ9F
lvu5KyiKqQExG3XZkN2dKCXU/34f6Kf/M02rOQDXlj11WMZEsVGQCkcX0CUix9Z0
mn0B/hfgSU3K45dK1DVlhXnyc3WWgEVA05hdVDpO0EkH331Mr6M=
=qgKH
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
