Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69520C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C1B206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545047799;
	bh=snZz1kPQXI44pil4ItUXLJL09iXzq3PRu5q3atLxCPw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=uS3g7B4tnkAyB/5dBE0fx6J0xqba7akUP749XvpUrAEb79igTv3quD/PSwKWhVNu7
	 BMyrDhd8+A6TLyigS3z1zg35L2b9a+oxvXFIL/MlqYTxXio7JGGfTOXKg9nKRnvNRI
	 GmviCZtVnrr/l89OybzQVUvuJhu17SFPrwjv2yAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732595AbeLQL4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:56:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:19239 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbeLQL4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:56:37 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2018 03:56:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,365,1539673200"; 
   d="asc'?scan'208";a="99332985"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga007.jf.intel.com with ESMTP; 17 Dec 2018 03:56:31 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>,
        "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq\@ti.com" <rogerq@ti.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel\@ti.com" <jbergsagel@ti.com>,
        "nsekhar\@ti.com" <nsekhar@ti.com>, "nm\@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen\@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v1 2/2] usb:cdns3 Add Cadence USB3 DRD Driver
In-Reply-To: <BYAPR07MB47097F1DE4D13CB23763A7C8DDBC0@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1544445555-17325-1-git-send-email-pawell@cadence.com> <1544445555-17325-3-git-send-email-pawell@cadence.com> <87h8fkmfar.fsf@linux.intel.com> <BYAPR07MB47095110AF28CC11B4C9E144DDA60@BYAPR07MB4709.namprd07.prod.outlook.com> <87a7lbme3m.fsf@linux.intel.com> <BYAPR07MB47097F1DE4D13CB23763A7C8DDBC0@BYAPR07MB4709.namprd07.prod.outlook.com>
Date:   Mon, 17 Dec 2018 13:56:27 +0200
Message-ID: <87pnu0gydw.fsf@linux.intel.com>
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

Pawel Laszczak <pawell@cadence.com> writes:
>>>>> +static irqreturn_t cdns3_device_irq_handler(int irq, void *data)
>>>>> +{
>>>>> +	struct cdns3_device *priv_dev;
>>>>> +	struct cdns3 *cdns =3D data;
>>>>> +	irqreturn_t ret =3D IRQ_NONE;
>>>>> +	unsigned long flags;
>>>>> +	u32 reg;
>>>>> +
>>>>> +	priv_dev =3D cdns->gadget_dev;
>>>>> +	spin_lock_irqsave(&priv_dev->lock, flags);
>>>>
>>>>you're already running in hardirq context. Why do you need this lock at
>>>>all? I would be better to use the hardirq handler to mask your
>>>>interrupts, so they don't fire again, then used the top-half (softirq)
>>>>handler to actually handle the interrupts.
>>>
>>> Yes, spin_lock_irqsave is not necessary here.
>>>
>>> Do you mean replacing devm_request_irq with a request_threaded_irq ?
>>> I have single interrupt line shared between  Host, Driver, DRD/OTG.
>>> I'm not sure if it will work more efficiently.
>>
>>The whole idea for running very little in hardirq context is to give the
>>scheduler a chance to decide what should run. This is important to
>>reduce latency when running with RT patchset applied, for
>>example. However, I'll give you that, it's a minor requirement. It's
>>just that, to me, it's a small detail that's easy to implement.
>
> I will do it in PATCH v2 or PATCH v3.=20=20
> I need to post next version before 24 of December, so if I can do it
> before this date then it will be in PATCH v2.=20

Take your time :-) Nothing will happen until next year. I already sent
my pull request for v4.21 and a large chunk of the community takes a few
days off during the holiday season.

There's really no rush from a community stand point.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlwXjusACgkQzL64meEa
mQYKpg//Wimwk9sUeFUERdJB++wwrH2WgY8w5bzYfWtS0vT8j7iwEByZOmtCID6q
BwmBw/L1XcaohJFcQWLhxEMDmOEs3QS5E2EwEI1UsVVj8UW07gazDvsZWwpOAdvB
DToqjwM9RVl4Xa79tfW+tTbz51Z0YrKgpBPUXSZSqLKkHqrgnfcKnS4R5dJ9I8NU
fCYuIMdQJoo5CzSHYsoGYHithyMdKP/txZRHvrmItn9CHBJDmHVoy+p77QFdlryd
zqU7p3FOOIcFSXdy+NIvcTPOiBZkI39Uuu4AgqY078qhN+ZjcmZGiDsxiKhPLcYA
sLptN62jEXEA99pXCNJU5CzCjz0h0VC/qfoCKKFw5ELj2TGT+rvTaWArHJK3ecwn
DWBGmzHOWfS/AOnfLU2HaeO2a2aUs3xbH905rt7zh/Cz4DGkAKg7k5l+HJ0TEk/T
k8GM3rArCkeGQhJcehMGqyWTDg56W0HiMp6htRZelZ084Jd+mzPI358glzrh+cWE
RQJSqJiCG/wx+oOVrIglyZoGmpiztexjQ/RKY9GCqSrM7extVMt3NQAXI5DFLvhX
ohb9e1ar7c3zrstRFY8M12aWFZ86bdl09u5dRauAAe3RUmart/Gn9TBYGYOlaWxn
1exLyL4Pb/cuaziDygtf0sHGeFnBi1k76Nfyq7e3s7my9/p7rI4=
=ijdd
-----END PGP SIGNATURE-----
--=-=-=--
