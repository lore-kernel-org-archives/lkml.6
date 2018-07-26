Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD09C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F90C20883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F90C20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbeGZMdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 08:33:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:32987 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729097AbeGZMdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 08:33:52 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2018 04:17:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,404,1526367600"; 
   d="asc'?scan'208";a="57318803"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.68.37])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jul 2018 04:17:26 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Anurag Kumar Vulisha <anuragku@xilinx.com>,
        Rob Herring <robh@kernel.org>
Cc:     "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mark.rutland\@arm.com" <mark.rutland@arm.com>,
        "v.anuragkumar\@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: dwc3: core: Add quirk for enabling AutoRetry feature in the controller
In-Reply-To: <MWHPR02MB2816DDEAE84716F88B08EB46A72B0@MWHPR02MB2816.namprd02.prod.outlook.com>
References: <1532168920-3269-1-git-send-email-anurag.kumar.vulisha@xilinx.com> <20180725200325.GA21007@rob-hp-laptop> <MWHPR02MB2816DDEAE84716F88B08EB46A72B0@MWHPR02MB2816.namprd02.prod.outlook.com>
Date:   Thu, 26 Jul 2018 14:14:09 +0300
Message-ID: <877eli1c72.fsf@linux.intel.com>
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


hi,

Anurag Kumar Vulisha <anuragku@xilinx.com> writes:
> Hi Rob,
>
> Thanks for your comments, please see my comments inline
>
>>-----Original Message-----
>>From: Rob Herring [mailto:robh@kernel.org]
>>Sent: Thursday, July 26, 2018 1:33 AM
>>To: Anurag Kumar Vulisha <anuragku@xilinx.com>
>>Cc: gregkh@linuxfoundation.org; mark.rutland@arm.com; balbi@kernel.org;
>>v.anuragkumar@gmail.com; linux-usb@vger.kernel.org; devicetree@vger.kerne=
l.org;
>>linux-kernel@vger.kernel.org
>>Subject: Re: [PATCH] usb: dwc3: core: Add quirk for enabling AutoRetry fe=
ature in the
>>controller
>>
>>On Sat, Jul 21, 2018 at 03:58:40PM +0530, Anurag Kumar Vulisha wrote:
>>> By default when core sees any transaction error(CRC or overflow)
>>> it replies with terminating retry ACK (Retry=3D1 and Nump =3D=3D 0).
>>> Enabling this Auto Retry feature in controller, on seeing any
>>> transaction errors makes the core to send an non-terminating ACK
>>> transaction packet (that is, ACK TP with Retry=3D1 and Nump !=3D 0).
>>> Doing so will give controller a chance to recover from the error
>>> condition.
>>>
>>> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
>>> ---
>>>  Documentation/devicetree/bindings/usb/dwc3.txt |  5 +++++
>>>  drivers/usb/dwc3/core.c                        | 16 ++++++++++++++++
>>>  drivers/usb/dwc3/core.h                        |  6 ++++++
>>>  3 files changed, 27 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt
>>b/Documentation/devicetree/bindings/usb/dwc3.txt
>>> index 7f13ebe..2ba2bc2 100644
>>> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
>>> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
>>> @@ -94,6 +94,11 @@ Optional properties:
>>>  			this and tx-thr-num-pkt-prd to a valid, non-zero value
>>>  			1-16 (DWC_usb31 programming guide section 1.2.3) to
>>>  			enable periodic ESS TX threshold.
>>> + - snps,enable_auto_retry: Set to enable Auto retry Feature to make the
>>
>>s/_/-/
> Sorry, I am not able to understand what needs to fixed here. Please help =
me in
> understanding, so that I can fix it in v2.

replace _ with -

>>> +			controller operating in Host mode on seeing transaction
>>> +			errors(CRC errors or internal overrun scenerios) on IN
>>> +			transfers to reply to the device with a non-terminating
>>> +			retry ACK (i.e, an ACK TP with Retry=3D1 & Nump !=3D 0)
>>
>>Seems like the property is unnecessary. When would you not want this
>>retry behavior? Why not just enable unconditionally in the driver?
>>
> There is no harm in adding this fix always but I think this Retry
> feature should be added depending on the user and type of the
> application. For example, applying this feature in a streaming
> application where isochronous transfers are used might end up in

read the docs. Auto Retry in only for non-isochronous IN endpoints. You
don't need any quirk for this. Just enable it unconditionally. Actually,
you wanna make sure the core can run in Host mode before setting this,
but that's it. No need for a quirk.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAltZrQEACgkQzL64meEa
mQZwtw/9HYBSUy/EQHw0y2JadXUWbjKRD4DwbHHteudftN7ytcGWlKbb9ymhKMSX
KhUk3NkEkXxlB13G4KCBKUaaowKkgWRDjZwK4viXGKiI6mp1gl5vI8vh6xtEtUHD
YdZv8kU0qJ78bRCKbcP8t0xdr9zjCN5YbzkIPolIYhjDDvVeWhm2bTY7IzcfDxwJ
Xtkc/Vox72M62Zk2fHiaRPRai/xDE5NDuzwFJYCIwKMX2PmhB7s+Hd7eNOJLtMga
x7DdITFdHoR9eRa4FlMpWpzVSK/oSmNIYAMX30moqiS5TQJ3pD1SE0hFbHYH7MKk
D7OqIS6ATrE2Jbt+aj58OupLp1rWOGAtMev47luzz4EEn2YNOGwkvch8yBaLGNL7
f4xQsigwZZdeBUW2waxMQwYNYsJykZFYPi/ndGE6+Kckrl6OMdNXhGM6AO/Sydkd
I398o1nAZIZMWTal7qq/KNOCR41Kr6X+zyBCKBy7vywQ9PY6zhu2ds5jc1pLGXOz
TkZ1dRpolI0lGVfET1Kp+5SLDzR/2v06VaUVdmRdx2YNMmsQsH/RsCVbgIbPLpFx
wMqbZgX5kVT15QmsEm6KpDkTqlCCj3D3kClCfJG5XJakTNUMbyyIPtglEpi59pO2
uekMGftXUMZ/CLblBTOsVt3IR41e5vEFOtNykyo7Puos/ywUMm0=
=T4BK
-----END PGP SIGNATURE-----
--=-=-=--
