Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9379C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913EA21104
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790638;
	bh=GLR0bapOUXYd5LK2nY/m39nXF13vg0Fug24ipq4FcN8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=m4JfkuvpKs5ybTAU1KGhP7/OhEqhBWT0OFO6Ix7H2wePJ9JLWotLZX4DbLPbYcjnK
	 /FBxetWMNWuP+hwvZcKjVGzHH61iJu8oxk1zPWMz8wmgM/RgsUEVwrzG2HMOL1QoSX
	 g+/67s0cEmemCbe5LlATcpGj1SNSJHymt57vqwnc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 913EA21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbeLNMab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:30:31 -0500
Received: from mga07.intel.com ([134.134.136.100]:22676 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730967AbeLNMa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:30:28 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Dec 2018 04:30:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,352,1539673200"; 
   d="asc'?scan'208";a="259467770"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga004.jf.intel.com with ESMTP; 14 Dec 2018 04:30:22 -0800
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
In-Reply-To: <7e6ac47e-61e4-ecd3-73d3-9b1be2d81479@ti.com>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com> <1542535751-16079-9-git-send-email-pawell@cadence.com> <5BFE8883.7090802@ti.com> <CAL411-oKvu3EADStit=JtbcxVzM_fFGF2uPn67-wmXxPzUK6GQ@mail.gmail.com> <6b19b55c-66d7-439e-df8f-7b311b45af5e@ti.com> <BYAPR07MB470972A525D85B03C3037D3BDDA60@BYAPR07MB4709.namprd07.prod.outlook.com> <CAL411-oc-_0H88egpHsc06ptL12UsaE63rWwjN7novuFFx_qbA@mail.gmail.com> <5a41de27-cd1f-0cfd-ccdc-dccbf0854fcb@ti.com> <87bm5ol6zt.fsf@linux.intel.com> <d5623e70-7971-d729-f395-7259ab0efdb0@ti.com> <875zvwl585.fsf@linux.intel.com> <7e6ac47e-61e4-ecd3-73d3-9b1be2d81479@ti.com>
Date:   Fri, 14 Dec 2018 14:30:18 +0200
Message-ID: <87va3wz3xh.fsf@linux.intel.com>
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

Sekhar Nori <nsekhar@ti.com> writes:
>>>>> especially since you already know there is going to be another revisi=
on
>>>>> of hardware. It has the advantage that one can easily grep to see whi=
ch
>>>>> hardware is running current version of controller without having acce=
ss
>>>>> to the hardware itself. Becomes useful later on when its time to
>>>>> clean-up unused code when boards become obsolete or for requesting
>>>>> testing help.
>>>>
>>>> This doesn't sound like a very strong argument, actually. Specially wh=
en
>>>> you consider that, since driver will do revision checking based on
>>>> revision register, you already have strings to grep. Moreover, we don't
>>>> usually drop support just like that.
>>>
>>> AFAICS, it is impossible to know just by grep'ing if there is any
>>> hardware still supported in kernel and using DWC3_REVISION_194A, for
>>> example.
>>=20
>> but why do you even care?
>
> When, for example, its coming in the way of some clean-up I am
> attempting to do.

can you share one example when a revision check got in the way of a
cleanup? I fail to see a situation when we need to drop support to older
platforms just to clean some code up.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlwToloACgkQzL64meEa
mQam5Q//WQEWQZi6uiQOByEzaPDKl0Cj9Z/kHQj6uN4gEPoGEX4v5LJqDYBgjRfu
RKzL9W1tTzzCZhxJ42jG8VdF12YkWMl4OHkNsdij+9k30wUxRHPciMNYjXoWq/Mi
7mXROG6BenWB/qqJjLIlKctHNjBrPypvTyfXNUNVvT8nWJPEZeZJB0EV4jDc9Ox4
5/PPJQTy6dOOG2R5IABDXtZGag9+US9a/ny7SSdpROcJgyjHYW+UvIZ5B2T/+KA0
TC/WyKWS1mb4BDcJKItaZPze+yESDu8O1N4RSo8ygF7NwExkXBl3aRiUrY3lpDnA
Qxk5ym454V7hd6NNyV4k1lfnRd9PZek/KbquO1Fv4ihAVd8n4Mzor6TtbsKguEzE
dI5P1WtT+1fopjC0FoNvHxiGB/E0onOzgv0+4tvyLcBlEUNvJe4SQWbWgpeH+2+N
XeyK+zV151AlPFNwKm8DNNCuJqVDcGNEsQ+gkB0y7MESasTsZkm+N9mijC5K8WKB
g/mcHwR6W3UjC2bnWO7IXA8XFzGE79cXXwFVwnYAjxzNBLn6mbKjS//vvlu41WxB
URMBMhKlKHIgUJHo7aOx/Py1C/arSDcFsf7Gs5V3WOWysxUnJr9Rv9/5crDFE1C7
WGNdwbXkzpT4Ex/yKtvg4S4BgvV66FW3BCRnuzjgoipjxZN51/8=
=eVG+
-----END PGP SIGNATURE-----
--=-=-=--
