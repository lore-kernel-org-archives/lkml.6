Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2215319-1521706913-2-3077891903784410610
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521706912; b=fbeEoiUx/Rs4d6SbC+UHR/G7zW/TLRAoBwbGFkyFQX1u/jd
    nA+zp4qm6YIriDJU1S6yGf6mBarmWls+tvDBZWepwP24+jIpfzIhtgJK7p0CuzC0
    RAVSpkKuBWe+tm2XMwJQU9/6MsQKzDvUry+hzh2YY0KH8x4Ld1qdbNAXHiS7j4GE
    UQ0kMRubZrtFQHRD7bT2fVFeQKLHpqt1vJ7qbo2imO+kTzrgKlDMGTOmpUpYEinR
    Ot1GC1GyjRDcX+P7dIEUqPY3tbaupILEb9bS1MInjoQ5fWJ9hpQ1Y/p1Hf5T98Uq
    T0fR0L2myqxigznEyDcNS7qx7RjHXQCxW2JWUOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1521706912; bh=KVeR7xpS2w5CKYDNOJ1bAP8yY/6CZn0vi5OLKL
    lnkv0=; b=jmEETctnhB5uhijZc7VJ8sMfyZutY4js5ZVSbUrXoMn7s4uzUBrtlN
    01eaXE9pDf5Q8rUZWk2yF/1xQikNgnvcvQv+/IKmOCKq5wpIf7kBAvvjPgZKAZCk
    pZIDXXOaQ8xDbVM9svu++YwXLqiBKjtfeDH/xvGz/v3NuDn2EckJUE1eQ1jzlA0C
    Pw4jahxEK8scPcuFLmyG5k2i+R9YVShyKdcTJ0bR0aq+iXg+VfdLZpJQpg7Dm5ef
    6/wLjjDg23v2j1rkOqZwRTwGQuucuuh4U93N+YHVYyT5k/x+OxyBtZ+acJ5O8VDj
    A8/3mEFSifcoAtxKC4s5DAKrsT1N1QuQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbeCVIUy (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 04:20:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:35593 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752533AbeCVIUx (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 22 Mar 2018 04:20:53 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,343,1517904000";
   d="asc'?scan'208";a="37125739"
From: Felipe Balbi <balbi@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: linux-next: Tree for Mar 21 (usb/dwc3)
In-Reply-To: <03aae369-e923-64e7-bac9-133ad0c8afc5@infradead.org>
References: <20180321192511.2d40e4ce@canb.auug.org.au> <03aae369-e923-64e7-bac9-133ad0c8afc5@infradead.org>
Date: Thu, 22 Mar 2018 10:20:25 +0200
Message-ID: <87efkcplme.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Randy Dunlap <rdunlap@infradead.org> writes:
> On 03/21/2018 01:25 AM, Stephen Rothwell wrote:
>> Hi all,
>>=20
>> Changes since 20180320:
>>=20
>
>
> on i386:
>
> ERROR: "__tracepoint_dwc3_gadget_generic_cmd" [drivers/usb/dwc3/dwc3.ko] =
undefined!
> ERROR: "__tracepoint_dwc3_ep_queue" [drivers/usb/dwc3/dwc3.ko] undefined!
> ERROR: "__tracepoint_dwc3_free_request" [drivers/usb/dwc3/dwc3.ko] undefi=
ned!
> ERROR: "__tracepoint_dwc3_event" [drivers/usb/dwc3/dwc3.ko] undefined!
> ERROR: "__tracepoint_dwc3_gadget_ep_enable" [drivers/usb/dwc3/dwc3.ko] un=
defined!
> ERROR: "__tracepoint_dwc3_alloc_request" [drivers/usb/dwc3/dwc3.ko] undef=
ined!
> ERROR: "__tracepoint_dwc3_prepare_trb" [drivers/usb/dwc3/dwc3.ko] undefin=
ed!
> ERROR: "__tracepoint_dwc3_complete_trb" [drivers/usb/dwc3/dwc3.ko] undefi=
ned!
> ERROR: "__tracepoint_dwc3_writel" [drivers/usb/dwc3/dwc3.ko] undefined!
> ERROR: "__tracepoint_dwc3_readl" [drivers/usb/dwc3/dwc3.ko] undefined!
> ERROR: "__tracepoint_dwc3_gadget_ep_cmd" [drivers/usb/dwc3/dwc3.ko] undef=
ined!
> ERROR: "__tracepoint_dwc3_ctrl_req" [drivers/usb/dwc3/dwc3.ko] undefined!
> ERROR: "__tracepoint_dwc3_ep_dequeue" [drivers/usb/dwc3/dwc3.ko] undefine=
d!
> ERROR: "__tracepoint_dwc3_gadget_giveback" [drivers/usb/dwc3/dwc3.ko] und=
efined!
> ERROR: "__tracepoint_dwc3_gadget_ep_disable" [drivers/usb/dwc3/dwc3.ko] u=
ndefined!

compiling here to test it out. Thanks

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqzZ0kACgkQzL64meEa
mQYFhA/7BC1eIzCT/ba3St3AiKOJ2Gio3bayhJAzsuCesvMHTvwLVPSpAl9ZxRBc
ulUToTWIqag6dPmUmk0WJAlLyxYV5Cxt5AO7IYmGfIiWUPcxJkXbzxs6PopvU/X8
2qUciz4fK+jOdswb2HjzqRaoniFugD44JlY8PHGkx3wkpWhO5bpgGWapygQa37+l
GHEXvbQzZ6GgWGeAzzE3Kf0mN7RKP0wU3/H65Z1oNwQ2XnhY+jCy+QUmD4PmSL/K
0QUULZXWeEGwVqakAzln4SsQtoXs7EBdswFQAIkbS8LpahVhx0upUpkCvs1+SIwn
3ejuRae4wVYShMSc1hQ6Nh4zNEEPKjDwDyBSVwS0xN431zY22KVkbUHly1U5svtr
06m/MbzZ7O+eiTObxE749h0nd7dRKjaBBMb2RRBD1zjfUcy/A9IAO1jQAXlonF6l
e0Dpb6VNUBEEZ7LP9hISwJf8mVyopdIucbyvO+TIZxHQaBRKcGd8dNowuI61z4Qo
BV2Vts7Y+WORb6rSrWb1Ht/PjQObSIc5B5Qa7JJKTvwjHtMZi4zn8+pNsnh+R82U
idp0y6xOOISAy6Crpz04PtNzxYtKw8mBzQbXroB0AeowFgC8mXQwTH2nlTFoODDs
jodPu3R6ZMmira4QWZhO4Vf8k9pd4vqKNsw1FvwQrrnN3jrTTQ0=
=fKef
-----END PGP SIGNATURE-----
--=-=-=--
