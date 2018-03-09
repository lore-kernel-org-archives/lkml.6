Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-123275-1520587429-2-845596836908763632
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
    t=1520587429; b=Q9JSbYhVXCM1A17JW4khoIQZJjDYZGrTcRT2zqcJeKpozhK
    qXyxnX1Gd8p3ea/ufB/zZFLVjlzQswfNllDrcIIro8HO9vmw58Syn9X+x9nqFIJj
    s8v7W4QMFM2tShw1AlV93WDbrNkZdv7ibicf/OWLQSHqUandtvbhiJ7hrhLBvtzj
    tAaiJT+2ZfDUbT1MawTXu9badZmH19jtKuBLNo7ZtyiSo1d24uKOdXu20Hbxdvh2
    EevkDnk3hfSBqiYZvzEpiW18e/cbT4nqrB2zTe2u/nZmhcWbUAt1m1PBBW8w7XvH
    18FE0P6EHbeVRTcw0FSM6I5zhJx3zOafU42/6iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1520587429; bh=Ld019cL3kVvPyA+dzMNTzX9KHyyBSz8mnnHo+7
    K4ZoE=; b=AcKbvcYsx8N4qqucXk0C9Lt5ILJ1uh1Hmz7FL1xwQr7jMN3Nm6wGR9
    Kr6XfJuIPzVfHjPAutpW8Q+NsSRXfJtUeFjeOnYblAX1bZmK4Rp6XONb/wF9LrIL
    8BWWQovZRzrf/d43v3wRS/CW2JZgwKkyTuw31P8RmZqHbqc04bY5mZKpkCnjDbKx
    GV9IIyENtUEaoPclvjFtYR3SS13PX72tf7l66FmwaU/mQFmnm2U/MVkxSkFKAyeX
    kk6ZwKO48Rxn1XNHfSqzcCnGyKSvS1RNu4LIpKunvxnLSZPPn2eKmwIDojSaiYTY
    963TeylWfHWSQQWN/WPkQuNE9J59nhYA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
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
        id S1750912AbeCIJXa (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 04:23:30 -0500
Received: from mga05.intel.com ([192.55.52.43]:50851 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750869AbeCIJX3 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 9 Mar 2018 04:23:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,444,1515484800";
   d="asc'?scan'208";a="24232001"
From: Felipe Balbi <balbi@kernel.org>
To: Roger Quadros <rogerq@ti.com>, Baolin Wang <baolin.wang@linaro.org>
Cc: USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Prevent indefinite sleep in _dwc3_set_mode during suspend/resume
In-Reply-To: <5bc56ef5-66b1-d40c-1639-e748fe18cdbd@ti.com>
References: <1519730526-22274-1-git-send-email-rogerq@ti.com> <87sh9l5z4l.fsf@linux.intel.com> <94cd6377-1327-2309-8d69-6ab0de2bdfd4@ti.com> <87po4i3o1v.fsf@linux.intel.com> <a907787a-dea2-5f15-3d25-693680a42b71@ti.com> <CAMz4kuKOnAPckX1=nqVPyF7O5u-0YrekTfMddYwe0WC2-0AFDw@mail.gmail.com> <87k1uq3ho6.fsf@linux.intel.com> <8ec0485e-89af-568b-e34a-b0cd490817d0@ti.com> <CAMz4kuJpBXY92zhG7s_VRkpcTHeLCE_vBLLSFVxLWjN2GQvyyw@mail.gmail.com> <87h8puwyn5.fsf@linux.intel.com> <5bc56ef5-66b1-d40c-1639-e748fe18cdbd@ti.com>
Date: Fri, 09 Mar 2018 11:23:19 +0200
Message-ID: <87muzha9h4.fsf@linux.intel.com>
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

<snip>

>>> When we set up the DWC3_DEPCMD_ENDTRANSFER command in
>>> dwc3_stop_active_transfer(), we can do not set DWC3_DEPCMD_CMDIOC,
>>> then there will no endpoint command complete interrupts I think.
>>>
>>> cmd |=3D DWC3_DEPCMD_CMDIOC;
>>=20
>> I remember some part of the databook mandating CMDIOC to be set. We
>> could test it out without and see if anything blows up. I would,
>> however, require a lengthy comment explaining that we're deviating from
>> databook revision x.yya, section foobar because $reasons. :-)
>>=20
>
> This is what the v3.10 databook says
>
> "When issuing an End Transfer command, software must set the CmdIOC
> bit (field 8) so that an Endpoint Command Complete event is generated
> after the transfer ends. This is necessary to synchronize the
> conclusion of system bus traffic before the End Transfer command is
> completed."
>
> with a note
>
> "If GUCTL2[Rst_actbitlater] is set, Software can poll the completion
> of the End Transfer command by polling the command active bit to be
> cleared to 0."
>
> fyi.
>
> Rst_actbitlater - "Enable clearing of the command active bit for the
> ENDXFER command after the command execution is completed.  This bit is
> valid in device mode only."
>
> So I'd prefer not to clear CMDIOC for all cases.
>
> Could we some how just tackle the dwc3_gadget_exit case like I did in
> this patch?

if you can send a version that doesn't iterate over all endpoints twice,
sure. We still need a comment somewhere, and I fear we may get
interrupts later in some cases. How would we deal with that?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqiUocACgkQzL64meEa
mQbDNRAAlQAftJ6UAfjPtOiHl04ULWtantMA+aTybY9FVEVs7XHuL/a4DQU3BrFa
KTceNsZLgTlYO5d9sn3dXiBc2U5qsj7mwLS1Tne4HdizFCiLB/nQFz5xLOQLckRM
xeScvVRDRa05HeaJhipnVUyH9/eKV4rXgXcW6bOEtSIzU5Be49GxZR2rOyZShuI4
Xc9Ab7D0idZZ3KkxZFu9cEXB/lzvmrNPYcW9wL8ZvpagEzTJE4vr0bqWXIbT7acY
tTgAQA1AtVOFOfcIe6+q1Ek5M+hEmuvzxsvEAhgG4pLmzHtFNr2d7RiU0A6pvEG9
kakaWsO8IoC+m1tyAdsAMDYVOnC5fuvfAQ0NS+7eo1Fp5Q3gvT6WCCvuaRgvFMeA
dNMgdSZYoFoe1UFSLk81qp2VNkThJSHmY9z+zYnoISiEsU+ORqPP4C4Owq6F5i1m
rDbBNgq7bTTfcsex7E+S1FDJ7ahFa9MWxc89HiccH9aNlS3z4+HoMhWxAcieO8qB
26mOAKN9jL9Ok8OfB5bnUQ0Cx0/qyYzFOKrOfDn7V4nzY1xYcn5CzYCLrRWri/Sa
CWAJQ7s7EBw10V0hnbq/dKJPe+hFKJFuPw97qZqkj1KJ+MpEwjLH/7ZHxJgGH7YO
aG0MU5A9cm66AOn011Dit6mHmgFLuv8WRCetfRmw1Yasp14pAhA=
=yZpY
-----END PGP SIGNATURE-----
--=-=-=--
