Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-220748-1520591862-2-17135185963078405040
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520591862; b=U4TnrGThHRmGsZAhxxXO7Wp3duCksuCc0j6w4hBeAH9lNa0
    O04jl0jrac07j2WCXVNzckopgQDVAEQCQeSR/iMntr94B0McWHcDs/N35NkjTUIm
    +pglxW0AeVlWS9eclWwnZO1eb8dKXJzsStwdjNLBWCPMW5mIWFrxSsS3XVwVWHOb
    DHiEQ0oz57clOZzG52W5JvV63WlnpPtOhoPsF49wl22IQyOq/WwfCRSDCL5RG5lN
    voyBXz79k9LM3v092VXHE62OX2EV3VUWZ03L+k6842FqkqGAJ/Uf5LoJzCEf5Atu
    dkS4byQpvIF0/u1YZ5HlGQ07g/Sxh5z/wsyhfoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1520591862; bh=T1WQ5P6addAmYHXXPT5+d7ZhWbkac9li7o5Qvd
    9adEI=; b=V93IVXH2vk0JvoWd0e2DAmyT8WFY/Ok6N3E8i31DZgH2hh8XdgBoaB
    IUKOBviUKwt/Csgg4stGpM7HhekeL7i4qCw8BVkLpqKJL9UfPdm8noGDux5pcVv2
    796cVjqN6j4EVVS2yBiR4H+YdC/Up9i8xpQPh8I0e6T96uOxlD8wQGe3GJ2wp2dP
    yEeqOc8g7u33hpQ8Cfm5g/H4zKK6vI3SX26Rb5rzvewP7zxxztM+1T2pKMx8EYNH
    DAuQqvYkc+lWShmFgKvgoikrWJspa56JxZBsZ24JiEbbByrFLHV8OnXHycOZqXpg
    t2MzLWPQfMza3bGNNyidJuzh9N9U1R5w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751068AbeCIKhJ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 05:37:09 -0500
Received: from mga18.intel.com ([134.134.136.126]:11097 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750937AbeCIKhJ (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 9 Mar 2018 05:37:09 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,445,1515484800";
   d="asc'?scan'208";a="210136462"
From: Felipe Balbi <balbi@kernel.org>
To: Roger Quadros <rogerq@ti.com>, Baolin Wang <baolin.wang@linaro.org>
Cc: USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Prevent indefinite sleep in _dwc3_set_mode during suspend/resume
In-Reply-To: <f8edc87c-919f-46ab-f437-303dede74c82@ti.com>
References: <1519730526-22274-1-git-send-email-rogerq@ti.com> <87sh9l5z4l.fsf@linux.intel.com> <94cd6377-1327-2309-8d69-6ab0de2bdfd4@ti.com> <87po4i3o1v.fsf@linux.intel.com> <a907787a-dea2-5f15-3d25-693680a42b71@ti.com> <CAMz4kuKOnAPckX1=nqVPyF7O5u-0YrekTfMddYwe0WC2-0AFDw@mail.gmail.com> <87k1uq3ho6.fsf@linux.intel.com> <8ec0485e-89af-568b-e34a-b0cd490817d0@ti.com> <CAMz4kuJpBXY92zhG7s_VRkpcTHeLCE_vBLLSFVxLWjN2GQvyyw@mail.gmail.com> <87h8puwyn5.fsf@linux.intel.com> <5bc56ef5-66b1-d40c-1639-e748fe18cdbd@ti.com> <87muzha9h4.fsf@linux.intel.com> <f8edc87c-919f-46ab-f437-303dede74c82@ti.com>
Date: Fri, 09 Mar 2018 12:36:58 +0200
Message-ID: <87h8ppa62d.fsf@linux.intel.com>
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

Roger Quadros <rogerq@ti.com> writes:
>>> This is what the v3.10 databook says
>>>
>>> "When issuing an End Transfer command, software must set the CmdIOC
>>> bit (field 8) so that an Endpoint Command Complete event is generated
>>> after the transfer ends. This is necessary to synchronize the
>>> conclusion of system bus traffic before the End Transfer command is
>>> completed."
>>>
>>> with a note
>>>
>>> "If GUCTL2[Rst_actbitlater] is set, Software can poll the completion
>>> of the End Transfer command by polling the command active bit to be
>>> cleared to 0."
>>>
>>> fyi.
>>>
>>> Rst_actbitlater - "Enable clearing of the command active bit for the
>>> ENDXFER command after the command execution is completed.  This bit is
>>> valid in device mode only."
>>>
>>> So I'd prefer not to clear CMDIOC for all cases.
>>>
>>> Could we some how just tackle the dwc3_gadget_exit case like I did in
>>> this patch?
>>=20
>> if you can send a version that doesn't iterate over all endpoints twice,
>> sure. We still need a comment somewhere, and I fear we may get
>> interrupts later in some cases. How would we deal with that?
>>=20
>
> how about explicitly masking that interrupt? Is it possible?

I think I showed that the bit is reserved on recent dwc3 core releases
(anytyhing 2.40a+, at least).

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqiY8oACgkQzL64meEa
mQZMVA//SLuKyFvyJ9jzEdkSXmymC8nQgPSJxImfn+NCJVH4Z/9ImedZfL+SkMY6
LHdUciBRa3EVmHgB5lnC108uNfIVf6ofPlfMT2fA+CoMV0lfeFSwk9AAyZPfC/hA
TVuSuNMRZdVfHZCcSs0IfpqQVs8PAFi8L5wJfy1z01Sdji2DOmDIYedHohWbNdw6
cf9bjE2r2ZYAZW8nbXQqhhQvoSLYi9AKxMKtwb8NhGnXMDnoiAWa/E41PbANSPOa
95JGpaO+MtoNlQ6x2JwCgPHGM9nht4c6GjpCnSDSWDEwzci7hwHflE0wUb0Rn+Iw
a1Ii1Te6jPGNq3Z8jaP66poND7dG3Q0HKqYfNGdxHk4u6hb7qXsx0kVh6T1mhtl2
ojqZorvQHRjlZKM/IsoA/Y85gbjG/wVlk+ykYVUUYikm+/XzWS9SPfA48282yBv5
m0uNO0XhZz1fLER0QmYV073XapPTzHzI9At3xJLVDxFVvF3nyk+vutrUoSFPS7Zg
ZuN/tZtioYDc1cBppvI9X7tW7X5Mi/A4xxTWwmNXPQf7T0T7eTJaanDHH5Bl+coF
VkG2EEtXXucoVyc2erjJN23EaKwGe4doJBkyK2kO85VitUQwNW615o0ko5WC6tBB
9jLF5nUJeFdmDEgfrNw9lxZ+F7GOqo8gzhdTLk1hBDleza6ZsqI=
=V937
-----END PGP SIGNATURE-----
--=-=-=--
