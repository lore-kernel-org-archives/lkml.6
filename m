Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D74C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E9E20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545046457;
	bh=MUIXoCS2VCgdiNecnhVaetyo3qENjjw5++AKEY6IN5w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=KjU8VppTUGUei7nqCDhbKSkHagE9+kuIxImpjmoGVFw159hBBH6wNoNkvtcvjDmVy
	 O7hEJGA35AZyr9nC7/F0ZY2bjt9DHlnz7csVupjSkHnw4qRKn9TJMkO3TS3ESlPrGh
	 1P056REkvDlcilWsgqgUDhe0L7GXAqJec9arcwJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732236AbeLQLeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:34:16 -0500
Received: from mga05.intel.com ([192.55.52.43]:35824 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbeLQLeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:34:15 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2018 03:34:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,365,1539673200"; 
   d="asc'?scan'208";a="102123939"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga008.jf.intel.com with ESMTP; 17 Dec 2018 03:34:11 -0800
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
In-Reply-To: <BYAPR07MB4709B102102DA96FE975264ADDBC0@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1544445555-17325-1-git-send-email-pawell@cadence.com> <1544445555-17325-3-git-send-email-pawell@cadence.com> <87h8fkmfar.fsf@linux.intel.com> <BYAPR07MB47095110AF28CC11B4C9E144DDA60@BYAPR07MB4709.namprd07.prod.outlook.com> <87a7lbme3m.fsf@linux.intel.com> <BYAPR07MB4709B102102DA96FE975264ADDBC0@BYAPR07MB4709.namprd07.prod.outlook.com>
Date:   Mon, 17 Dec 2018 13:34:00 +0200
Message-ID: <87sgywgzfb.fsf@linux.intel.com>
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
>>>>> +	case USB_REQ_SET_ISOCH_DELAY:
>>>>> +		sprintf(str, "Set Isochronous Delay Delay: %d ns", wValue);
>>>>> +		break;
>>>>> +	default:
>>>>> +		sprintf(str,
>>>>> +			"SETUP BRT: %02x BR: %02x V: %04x I: %04x L: %04x\n",
>>>>> +			bRequestType, bRequest,
>>>>> +			wValue, wIndex, wLength);
>>>>> +	}
>>>>> +
>>>>> +	return str;
>>>>> +}
>>>>
>>>>All of these are a flat out copy of dwc3's implementation. It's much,
>>>>much better to turn dwc3's implementation into a generic, reusable
>>>>library function then spinning your own as a duplicated effort.
>>> I agree,
>>> It would be nice to have a set of decoding function  in some generic li=
brary. It could be used
>>> also by other drivers.
>>> Who should do this ?
>>
>>since you're the first to reuse it, then it should be you :-)
>
> So I can prepare debug.h  in drivers/usb/gadget directory.=20

no, not there. Host drivers can rely on it too, if they want. Let's have
it on drivers/usb/common/debug.c (or some other name) and a header under in=
clude/linux/usb/

> Function form drivers/usb/dwc3/debug.h that could be common are:=20
>
> static inline void dwc3_decode_get_status(__u8 t, __u16 i, __u16 l, char =
*str)
> static inline void dwc3_decode_get_set_descriptor(__u8 t, __u8 b, __u16 v,
> 						  __u16 i, __u16 l, char *str)
> static inline void dwc3_decode_set_clear_feature(__u8 t, __u8 b, __u16 v,=
 __u16 i, char *str)=09=09=09=09=09=09=09=09=09=09=09=09
> static inline void dwc3_decode_set_address(__u16 v, char *str)
> static inline void dwc3_decode_get_set_descriptor(__u8 t, __u8 b, __u16 v=
, __u16 i, __u16 l, char *str)=09=09=09=09=09=09=20=20
> static inline void dwc3_decode_get_configuration(__u16 l, char *str)
> static inline void dwc3_decode_set_configuration(__u8 v, char *str)
> static inline void dwc3_decode_get_intf(__u16 i, __u16 l, char *str)
> static inline void dwc3_decode_set_intf(__u8 v, __u16 i, char *str)
> static inline void dwc3_decode_synch_frame(__u16 i, __u16 l, char *str)
> static inline const char *dwc3_decode_ctrl(char *str, __u8 bRequestType, =
__u8 bRequest, __u16 wValue, __u16 wIndex, __u16 wLength)
>
> After changed it could looks like:=20
> static inline void usb_decode_get_status(__u8 bRequestType, __u16 wIndex,=
 __u16 wLength, char *str)
> static inline void usb _decode_get_set_descriptor(__u8 bRequestType, __u8=
 bRequest, __u16 wValue,
> 						  __u16 wIndex, __u16 wLength, char *str)
> static inline void usb_decode_set_clear_feature(__u8 bRequestType, __u8 b=
Request, __u16 wValue, __u16 wIndex, char *str)=09=09=09=09=09=09=09=09=09=
=09=09=09
> static inline void usb_decode_set_address(__u16 v, char *str)
> static inline void usb_decode_get_set_descriptor(__u8 bRequestType, __u8 =
bRequest, __u16 wValue, __u16 wIndex, __u16 wLength, char *str)=09=09=09=09=
=09=09=20=20
> static inline void usb_decode_get_configuration(__u16 wLength, char *str)
> static inline void usb_decode_set_configuration(__u8 wValue, char *str)
> static inline void usb_decode_get_intf(__u16 wIndex, __u16 wLength, char =
*str)
> static inline void usb_decode_set_intf(__u8 wValue, __u16 wIndex, char *s=
tr)
> static inline void usb_decode_synch_frame(__u16 wIndex, __u16 wLength, ch=
ar *str)
> static inline const char * usb _decode_ctrl(char *str, __u8 bRequestType,=
 __u8 bRequest, __u16 wValue, __u16 wIndex, __u16 wLength)
>
> Sorry but I prefer some more significant names :)

meh, no worries

> For me functions in drivers/usb/dwc3/debug.h looks ok, but I think that c=
ould be better to
> add additional usb_decode_test_mode and usb_decode_device_feature and lit=
tle simplify usb_decode_get_set_descriptor.=20

sure, just propose patches. Just make sure that your patches do a single
thing per patch. Meaning, first you add a patch moving functions to
drivers/usb/common and updating dwc3, then you add another to decode
test mode (then update dwc3), and another simplifying set_descriptor.

> What do you think about this?
>
> One more question.=20
> Can I add drivers/usb/gadget/debug.h file  as part of my  set patches, or=
 this should be done as separate, new patch ?=20

Your first patch moving functions from dwc3 should move them somewhere ;)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlwXiaoACgkQzL64meEa
mQb9+BAA0UfEj50YYeKcKFhqmWi16A5m/NFeikwuBKpNfGBhYln18XPA5NuCCX0t
j1aXzy2C6K11NDXSyA3XSq6LsVNOQP8Xq2B26fnnUNVuuVCdgynNVSxjuOEmfLD3
9o8GmDQ9qvI6QCsjFAM+nZZzakJ8IGYdq87dKDS30rR2+tyRpznD5jXfPqyLB1uK
LtyGcF6z6r851yzJTlEFLtUm4eDJ1pCiRWBJYmqcGPIXXCz1iGTs2Jnmg/fwRoeE
1z6SnQkyoxnKutDTJ7duvY2Y/Oc7H2XwTLtAgEw3jv+AB8UxmlqAF7wxxxK6tXaj
KdsTRPwstiTvOv+PUqFyL/bWx3nJi7IzqpdXZ1UEV4XMxN6O4jSDMSOTmIdteqUH
lMl9i+odGUq58EzPFiiTccufl4m5/Z8u1SR0df0mplQNlJLpV8vkVMrRakmZVOzk
wMUBbx03Pe6JLax1/q6FPFlc2PmtzKiiCUbePQ2J4GAzj7nhSUCtj0OJ4JPTVEw0
umAJ+7F6pIzKpur2RZ4+kETCEjLft/4cyo4yc6jW14hwtXz7FgrAza/0ZtWInhNm
ruiF6umHuyJFcZZT60+Sbp/+YX1Q/brgvWoMYEgmO124giOKTC++H1er0URPTXIN
4YyzAJkdKhVfCJFo85aQmXYN/OCbhI2ffvjYLqTJ6Lz9t8DNB3o=
=qwLD
-----END PGP SIGNATURE-----
--=-=-=--
