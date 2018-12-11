Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E97C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D90120849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544528827;
	bh=gRRgU6Gx26vikAqPrYNblP4KVbfUpbyiIegByNAXiUs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=upWfJmkyxUaigHjbK9izbcGksjKt9WY6sdaPvhhb5b8wl1Z1oHxOyeH4AB7B+rZgc
	 KVQ0YRSNXXXcnT8AxaXAMnF7/7PF2cFXpXWko7xyoPUu9EoUVzGoYRGJ0SvYuCnuUh
	 cbK7ZvzIjEepgSfxgpCbeSDknR/wSTfwXIQcSTgA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D90120849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbeLKLrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:47:05 -0500
Received: from mga07.intel.com ([134.134.136.100]:45156 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbeLKLrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:47:05 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 03:47:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,342,1539673200"; 
   d="asc'?scan'208";a="302866348"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by fmsmga005.fm.intel.com with ESMTP; 11 Dec 2018 03:47:00 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Roger Quadros <rogerq@ti.com>, Pawel Laszczak <pawell@cadence.com>,
        devicetree@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, adouglas@cadence.com,
        jbergsagel@ti.com, nsekhar@ti.com, nm@ti.com, sureshp@cadence.com,
        peter.chen@nxp.com, pjez@cadence.com, kurahul@cadence.com
Subject: Re: [PATCH v1 2/2] usb:cdns3 Add Cadence USB3 DRD Driver
In-Reply-To: <5C0F85E4.10609@ti.com>
References: <1544445555-17325-1-git-send-email-pawell@cadence.com> <1544445555-17325-3-git-send-email-pawell@cadence.com> <5C0F85E4.10609@ti.com>
Date:   Tue, 11 Dec 2018 13:46:51 +0200
Message-ID: <87k1kgmgk4.fsf@linux.intel.com>
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

Roger Quadros <rogerq@ti.com> writes:
>> This patch introduce new Cadence USBSS DRD driver
>> to linux kernel.
>>=20
>> The Cadence USBSS DRD Driver is a highly
>> configurable IP Core which can be
>> instantiated as Dual-Role Device (DRD),
>> Peripheral Only and Host Only (XHCI)
>> configurations.
>>=20
>> The current driver has been validated with
>> FPGA burned. We have support for PCIe
>> bus, which is used on FPGA prototyping.
>>=20
>> The host side of USBSS-DRD controller is compliance
>> with XHCI specification, so it works with
>> standard XHCI linux driver.
>>=20
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/Kconfig                |    2 +
>>  drivers/usb/Makefile               |    2 +
>>  drivers/usb/cdns3/Kconfig          |   44 +
>>  drivers/usb/cdns3/Makefile         |   16 +
>>  drivers/usb/cdns3/cdns3-pci-wrap.c |  157 +++
>>  drivers/usb/cdns3/core.c           |  451 +++++++
>>  drivers/usb/cdns3/core.h           |  108 ++
>>  drivers/usb/cdns3/debug.h          |  346 ++++++
>>  drivers/usb/cdns3/debugfs.c        |  168 +++
>>  drivers/usb/cdns3/drd.c            |  315 +++++
>>  drivers/usb/cdns3/drd.h            |  129 ++
>>  drivers/usb/cdns3/ep0.c            |  864 +++++++++++++
>>  drivers/usb/cdns3/gadget-export.h  |   28 +
>>  drivers/usb/cdns3/gadget.c         | 1802 ++++++++++++++++++++++++++++
>>  drivers/usb/cdns3/gadget.h         | 1177 ++++++++++++++++++
>>  drivers/usb/cdns3/host-export.h    |   28 +
>>  drivers/usb/cdns3/host.c           |   74 ++
>>  drivers/usb/cdns3/trace.c          |   11 +
>>  drivers/usb/cdns3/trace.h          |  343 ++++++
>
> You went to the other extreme of combining everything (host/gadget/drd) t=
ogether
> which again makes this very hard to review.
>
> I think what Felipe meant was to only combine the gadget driver code
> into one patch.
>
> The series could be split into 6 patches like so.
> -dt binding
> -pci glue
> -core driver
> -host driver
> -gadget driver
> -drd driver

no, no. This is fine. We _could_ split out PCI glue to its own patch,
but it's rather pointless seing as it's so small.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlwPo60ACgkQzL64meEa
mQYVaQ//SWD7ik1bFKOvm13A8mLphPuwef4FHi75UJ26VKbdTqfoUwMyYzxH1Qn/
nIePbHRunPNhonrNGpzKM0t6qfd5h9DYhGp2t6Vp0rQxacHHhFPG5GXlYTXbbeqW
y7A2A+PMmDhfmgU1+4ywVUC3dyFTGVeETu9WDa+oemw5LMlMDSgr/5518lzE9zqW
oxqRqNe1ucXwGoYLN5MjCsco+ojL3Km/FWBsrbXQfg1DSNLXXLW6FJu+8uMsunMC
EvCTKk9VxUtgtrQoIbkTo1+DBfK26tfvKN2v01Yi8xrxMrvMc8JHtYBpis4O+jcw
By8flXBvvI3tYJ/fFgqJlkRFdmu8UXyyi59oEyEj7QEklBwVg3ePtsDkJwBNWhS4
cAyySDe2MZB922fP3lA2s0AQxq5Sgc9DvA0zskqax1eqHC2AJpjvhxvbf8utnl+Q
LZdXBjNaJ7uQEtQEd8e4R8cZSeQmmKDOuy3+4e6ZV4jbR95Xz1CGEJaK+2bvRj/x
odAULfkl93p+oGjwYAEEOCptkaCH6aMv9bUt7eaX9hMMgkY3Mg46KIjmg4WoPtq3
DqTgr3ajXzUyL5OxsowBqzc5s7dZoi60PJcSoeeU7NUFqkqyEH7w89iiMbxuDdtv
z3bB+r5rWd8I9Vq7vyLibnBioa/7rq6KE+VKiKfZQnRmf9RRhwc=
=qvrM
-----END PGP SIGNATURE-----
--=-=-=--
