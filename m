Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DDCC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD182084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfAUJDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:03:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:35092 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfAUJDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:03:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2019 01:03:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,502,1539673200"; 
   d="asc'?scan'208";a="293125500"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga005.jf.intel.com with ESMTP; 21 Jan 2019 01:03:44 -0800
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     "Zengtao \(B\)" <prime.zeng@hisilicon.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: dwc3: gadget: don't remove the request if bus-expired
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED24E49C55@dggemm526-mbx.china.huawei.com>
References: <1545339230-10520-1-git-send-email-prime.zeng@hisilicon.com> <87won7mzcn.fsf@linux.intel.com> <678F3D1BB717D949B966B68EAEB446ED24E49C55@dggemm526-mbx.china.huawei.com>
Date:   Mon, 21 Jan 2019 11:03:40 +0200
Message-ID: <87lg3ejsb7.fsf@linux.intel.com>
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

"Zengtao (B)" <prime.zeng@hisilicon.com> writes:
>>-----Original Message-----
>>From: Felipe Balbi [mailto:felipe.balbi@linux.intel.com]
>>Sent: Monday, January 14, 2019 4:13 PM
>>To: Zengtao (B) <prime.zeng@hisilicon.com>
>>Cc: Zengtao (B) <prime.zeng@hisilicon.com>; Greg Kroah-Hartman
>><gregkh@linuxfoundation.org>; linux-usb@vger.kernel.org;
>>linux-kernel@vger.kernel.org
>>Subject: Re: [PATCH] usb: dwc3: gadget: don't remove the request if
>>bus-expired
>>
>>* PGP Signed by an unknown key
>>
>>
>>Hi,
>>
>>Zeng Tao <prime.zeng@hisilicon.com> writes:
>>> We have already returned EAGAIN for bus-expiry, and it's designed to
>>> start with a future Frame number and start the transfer again. So we
>>> should not remove the request for that case.
>>>
>>> Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
>>
>>Do we need a Fixes tag here? How about Cc stable? Can you share
>>tracepoints exposing the problem?
>>
>
> I am not sure that we need to Fixes tag, it's not related to any single p=
atch, but
> there is definitely something wrong, after rethinking it again, I found t=
hat there
> are still some problems for this patch, for the reties inside the driver,=
 we should not
> remove the request, but if we return -EAGAIN to the gadget layer, we shou=
ld because
> the gadget will requeue the request again if we return -EAGAIN.
>
> Any suggestions.=20

Well, that needs to be patched, sure. I'm just saying that we need to
blame a patch that was incomplete so we know which stable releases need
this. Perhaps the patch at fault here was my patch adding the retry
method for isoc transfers.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlxFiuwACgkQzL64meEa
mQYn/RAAqPwza0sGcY5jJToQVdfYQj9Lf2kCljL1TmZdu2CZt5g6NSlILiPOJ204
NCF2dJjIUckNELLUR9E9HS/PWpDzdVvRJq9GIpb0xycANvBHDEhcI5h53lZ6vKlA
epD3/OB2H2jQJvNdMmMk7GgWZPxSw63h9uARg9/guKQosjM8ypul7igToTAvWGL7
O9Kp20mVIRK7MrQeAcNaXD9X8+b4bYoc/t8c9Q+n6xxPB6varnN92tvh4HBrzOIJ
0Oa6gIqQ+gMroQ130poK9lLvPuAzZzuZhMtqBXVRPSW7Zcc4pof2UnY9k8SZDKik
/RWIQ1JC/J1RxCCT5TVApeCMyCPKURJ4tvl9CpW6DR80USbKmiStaEhuv+Ufg6xj
fETEW6HEkC/VlnHOq9BR2HpK/mEeABtqYUUsJc+celd5ac5eqq4sIZRSGmDHrCcU
E4ElvOhd9q+I8vZ9fVk0VWkJRzb7F4pat0CKU/TpAk5Aaepgv+ro62bnKXddHBvf
qR+0RXg/8u8/cfHN6+VBUIpE2sIVBd6Mcjzbfhw1WnMlmM5LjFtewIUbaX8taW91
4KjyE7KYlbZ2EeO4vyLV+2m13qUY9lCS9dsNpzKp0neAeV4pdINXxXlKyYyjJPbF
dvT+IpexpDqnPFPh7DSGdmvmbcVN7O294Q9p/NM9y6y9qMH4jdE=
=CPIk
-----END PGP SIGNATURE-----
--=-=-=--
