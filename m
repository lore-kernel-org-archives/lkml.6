Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE970C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B490F208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544784480;
	bh=5m5qoJaIdvR2oQjiWntmeabfFKaA7DTcuO1ndznkJ6E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=i3BJL0YvIRXrhDcLdwBpbQun7BvFJsvuSeZlfaDQoZJmEBS+eDiAJjF1rVMH9UXhb
	 7h4seE1rIEc3wxjFifsfd76tPMAtI6dbZMRTMq7doj5DMRk7CeQ7zZQc+rdUESE1Tw
	 7AF7OOWgOtF/ebw33C/jeViRYwPMYN8IJRS3vzH8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B490F208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbeLNKr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:47:59 -0500
Received: from mga11.intel.com ([192.55.52.93]:58312 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbeLNKr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:47:59 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Dec 2018 02:47:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,352,1539673200"; 
   d="asc'?scan'208";a="118800176"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga001.jf.intel.com with ESMTP; 14 Dec 2018 02:47:54 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Sekhar Nori <nsekhar@ti.com>, Peter Chen <hzpeterchen@gmail.com>,
        pawell@cadence.com
Cc:     rogerq@ti.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        adouglas@cadence.com, jbergsagel@ti.com, nm@ti.com,
        sureshp@cadence.com, peter.chen@nxp.com, pjez@cadence.com,
        kurahul@cadence.com
Subject: Re: [RFC PATCH v2 08/15] usb:cdns3: Implements device operations part of the API
In-Reply-To: <5a41de27-cd1f-0cfd-ccdc-dccbf0854fcb@ti.com>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com> <1542535751-16079-9-git-send-email-pawell@cadence.com> <5BFE8883.7090802@ti.com> <CAL411-oKvu3EADStit=JtbcxVzM_fFGF2uPn67-wmXxPzUK6GQ@mail.gmail.com> <6b19b55c-66d7-439e-df8f-7b311b45af5e@ti.com> <BYAPR07MB470972A525D85B03C3037D3BDDA60@BYAPR07MB4709.namprd07.prod.outlook.com> <CAL411-oc-_0H88egpHsc06ptL12UsaE63rWwjN7novuFFx_qbA@mail.gmail.com> <5a41de27-cd1f-0cfd-ccdc-dccbf0854fcb@ti.com>
Date:   Fri, 14 Dec 2018 12:47:50 +0200
Message-ID: <87bm5ol6zt.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi,

Sekhar Nori <nsekhar@ti.com> writes:

<snip>

>>>> All this should be part of comments in code along with information abo=
ut
>>>> controller versions which suffer from the errata.
>>>>
>>>> Is there a version of controller available which does not have the
>>>> defect? Is there a future plan to fix this?
>>>>
>>>> If any of that is yes, you probably want to handle this with runtime
>>>> detection of version (like done with DWC3_REVISION_XXX macros).
>>>> Sometimes the hardware-read versions themselves are incorrect, so its
>>>> better to introduce a version specific compatible too like
>>>> "cdns,usb-1.0.0" (as hinted to by Rob Herring as well).
>>>>
>>>
>>> custom match_ep is used and works with all versions of the gen1
>>> controller. Future (gen2) releases of the controller won=E2=80=99t have=
 such
>>> limitation but there is no plan to change current (gen1) functionality
>>> of the controller.
>>>
>>> I will add comment before cdns3_gadget_match_ep function.
>>> Also I will change cdns,usb3 to cdns,usb3-1.0.0 and add additional
>>> cdns,usb3-1.0.1 compatible.
>>>
>>> cdns,usb3-1.0.1 will be for current version of controller which I use.
>>> cdns,usb3-1.0.0 will be for older version - Peter Chan platform.
>>> I now that I have some changes in controller, and one of them require
>>> some changes in DRD driver. It will be safer to add two separate
>>> version in compatibles.
>>>
>>=20
>> Pawel, could we have correct register to show controller version? It is
>> better we could version judgement at runtime instead of static compatibl=
e.
>
> Agree with detecting IP version at runtime.
>
> But please have some indication of version in compatible string too,

why? Runtime detection by revision register should be the way to go if
the HW provides it. Why duplicate the information in compatible string?

> especially since you already know there is going to be another revision
> of hardware. It has the advantage that one can easily grep to see which
> hardware is running current version of controller without having access
> to the hardware itself. Becomes useful later on when its time to
> clean-up unused code when boards become obsolete or for requesting
> testing help.

This doesn't sound like a very strong argument, actually. Specially when
you consider that, since driver will do revision checking based on
revision register, you already have strings to grep. Moreover, we don't
usually drop support just like that.

Personally, I wouldn't bother. Just like dwc3 never bothered and nothing
bad came about because of it. Well, there are quirks which are
undetectable and for those we have quirk flags. I much prefer that
arrangement.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlwTilYACgkQzL64meEa
mQZF2BAAyWZdJ40EfnIL5X/zVA6cIKPa6jNWl/omllvQBuo1YyaAhsqkRJshUKhH
hQspft8wlfMByo/F7+B86DAi6XHefxhcboCbaAnafuR/9DybU2RByvwG5WBWcUBH
27Fqb4n1VFQgSfZI+EmIbJI3qL/rfd9MzwToXhl7lpJlhnIChQY/JZCRIYTlbCvi
YOcRhGEJPNE874EQcV4LpK5LxuXZX12qjh3WAGZoQ7//s7xIPKMtgKQSIWWa5QKz
WyqXu1eQSwKXXAhVrDxJUbPa/N2f8DI3Ompld0flze3vUX8izLgmJF+KmQY5RoVk
Du24TWIey5B+z9y5YGPAFQ8HN7VmjTIKk69j5z6FLJMp/3YdRnEeachmk76WL9LM
awNlVafiE4w+ExTwBXHkkShuYKVV5WMSiA/Snwe45cyB+fQH432dF6TfyMuXVgRD
bwOPw9spZSNlS1xlGWot7dPLhH4SCvgaH9GeTFISA78KQD83hPr0S1y1RwVbLyK4
HEGfEm4pKPqati0yppoXhl7o+MvhQMLMzVJsLsUol/2Rx34iLvpDLXc6Z+3IhCzy
7gd2YzW386U1lZYFQsqdohiWKmiRV953neOkruBkCwxGqq15rgqr5Qpbgdj12L0C
esA8hjDYiQGT8t5KRbEcWCKvmy7Q9zdKiOQTxXK/ey66p1ZsviU=
=+VII
-----END PGP SIGNATURE-----
--=-=-=--
