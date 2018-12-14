Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C5BC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E2620879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544786772;
	bh=g4K7jXzzlPbTZe8GwSbXMtTxkOWRGMyv2aHyOcxpX4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=Kl69ZDC5J1/0S7aMRxnr6uVvV7JyDXUPp2gPELgGbTHbfo8TmguNp1teroDJFRp8L
	 DQrkSBh294XispeUWhYLWeCbbUR+CK5WRl/myL3zKHZXEY6hjNNczGQtT6PyHMlGDh
	 OJy+n+2T0dKk/QFzrAYsB7CEzQoQLJf1lCOHuTmU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E2620879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbeLNL0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 06:26:11 -0500
Received: from mga18.intel.com ([134.134.136.126]:8404 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729129AbeLNL0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 06:26:11 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Dec 2018 03:26:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,352,1539673200"; 
   d="asc'?scan'208";a="302166815"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by fmsmga006.fm.intel.com with ESMTP; 14 Dec 2018 03:26:06 -0800
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
In-Reply-To: <d5623e70-7971-d729-f395-7259ab0efdb0@ti.com>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com> <1542535751-16079-9-git-send-email-pawell@cadence.com> <5BFE8883.7090802@ti.com> <CAL411-oKvu3EADStit=JtbcxVzM_fFGF2uPn67-wmXxPzUK6GQ@mail.gmail.com> <6b19b55c-66d7-439e-df8f-7b311b45af5e@ti.com> <BYAPR07MB470972A525D85B03C3037D3BDDA60@BYAPR07MB4709.namprd07.prod.outlook.com> <CAL411-oc-_0H88egpHsc06ptL12UsaE63rWwjN7novuFFx_qbA@mail.gmail.com> <5a41de27-cd1f-0cfd-ccdc-dccbf0854fcb@ti.com> <87bm5ol6zt.fsf@linux.intel.com> <d5623e70-7971-d729-f395-7259ab0efdb0@ti.com>
Date:   Fri, 14 Dec 2018 13:26:02 +0200
Message-ID: <875zvwl585.fsf@linux.intel.com>
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
>>>>>> All this should be part of comments in code along with information a=
bout
>>>>>> controller versions which suffer from the errata.
>>>>>>
>>>>>> Is there a version of controller available which does not have the
>>>>>> defect? Is there a future plan to fix this?
>>>>>>
>>>>>> If any of that is yes, you probably want to handle this with runtime
>>>>>> detection of version (like done with DWC3_REVISION_XXX macros).
>>>>>> Sometimes the hardware-read versions themselves are incorrect, so its
>>>>>> better to introduce a version specific compatible too like
>>>>>> "cdns,usb-1.0.0" (as hinted to by Rob Herring as well).
>>>>>>
>>>>>
>>>>> custom match_ep is used and works with all versions of the gen1
>>>>> controller. Future (gen2) releases of the controller won=E2=80=99t ha=
ve such
>>>>> limitation but there is no plan to change current (gen1) functionality
>>>>> of the controller.
>>>>>
>>>>> I will add comment before cdns3_gadget_match_ep function.
>>>>> Also I will change cdns,usb3 to cdns,usb3-1.0.0 and add additional
>>>>> cdns,usb3-1.0.1 compatible.
>>>>>
>>>>> cdns,usb3-1.0.1 will be for current version of controller which I use.
>>>>> cdns,usb3-1.0.0 will be for older version - Peter Chan platform.
>>>>> I now that I have some changes in controller, and one of them require
>>>>> some changes in DRD driver. It will be safer to add two separate
>>>>> version in compatibles.
>>>>>
>>>>
>>>> Pawel, could we have correct register to show controller version? It is
>>>> better we could version judgement at runtime instead of static compati=
ble.
>>>
>>> Agree with detecting IP version at runtime.
>>>
>>> But please have some indication of version in compatible string too,
>>=20
>> why? Runtime detection by revision register should be the way to go if
>> the HW provides it. Why duplicate the information in compatible string?
>>=20
>>> especially since you already know there is going to be another revision
>>> of hardware. It has the advantage that one can easily grep to see which
>>> hardware is running current version of controller without having access
>>> to the hardware itself. Becomes useful later on when its time to
>>> clean-up unused code when boards become obsolete or for requesting
>>> testing help.
>>=20
>> This doesn't sound like a very strong argument, actually. Specially when
>> you consider that, since driver will do revision checking based on
>> revision register, you already have strings to grep. Moreover, we don't
>> usually drop support just like that.
>
> AFAICS, it is impossible to know just by grep'ing if there is any
> hardware still supported in kernel and using DWC3_REVISION_194A, for
> example.

but why do you even care?=20

> If we are never going to drop support for any revision, this does not
> matter much.
>
> Also, once you have the controller supported behind PCI, then I guess
> you are pretty much tied to having to read hardware revision at runtime.

that's another argument *for* using runtime detection, not against it.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlwTk0oACgkQzL64meEa
mQYA5w/9FY3dE8D+YHmrb3tnHyR6vwaTBRUsHcVyJ1J0yspewdcd/07/VcXfnD28
ebvRVP4Idebgch5S9J/CRMYE1LAn/SMDYyZshye/iuOv1SMReVaPo9YW5/hFPKGX
r8BfKhE/4qHMVWeTN1euiYr8iTtPldBcZ+1R3+JxDyYqFL8XD0c6bgeVrHfSBBBn
CrqqAn6boJCurIAQ7DpRhrN84hz4zI5dbRM5vAvEWerqjxl2LU3ADvX6KQzSM81J
BqdIo6ucOok3FAlhg9OVeA+IceRMjdvHFisN1Tlcqu2ZmacneGZuNvQ1/0l7B6Th
ciDraD8jWbIYxCl/m9tmLPC8qx6Od5o4s19ZYCBwVtgJTTypzIC1c3MHcD6a3rcG
WOlT7kPB7xr2H8UUXmd3l6ZzOFrJpLPfQPihvQNt6Uy3aQjt4WXvYiIyS8XciXkn
8TduIbwJ0mAuivKrTBOUGWE6oCMnJs8x2oz+Ytoli9FkhxgXsfWhYBgZlLcZB6nT
h5Obm7VtLAaskRpSe4vIV/Wg4Qac7OcjYL4WytDuL79A6py05DZ5kigxLUfToPyF
OPcwGHAOjri82WZIDzksQY9hB7yBuxAWGL6tERnamRtxCN1qIczzxlTttQq5dF4q
4hV2JhbROuNDETAUzAS6c8ypj0+d/ngF75m/vhsqr23J8SEkYjk=
=hfQv
-----END PGP SIGNATURE-----
--=-=-=--
