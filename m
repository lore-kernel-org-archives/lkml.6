Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1950445-1525950080-2-9823205765881131860
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525950079; b=NI1wQZQr7k6QmIJt/IDTKeblXQDvpP6VF3DjKZMribIjMzvQy6
    RZKa+kHgdWzQNrlASzFokzAqI4NYWz7tuFplrXq0/MHLAtf0pjvlg59d31f+ZfQy
    KaQzGLbgI5WS521eybT6GD9PVmpfUfuI5qkGeLCuBR3OADwsCkpOmdXhckRDuE+I
    EC1pdbxg7Sr0yd4+ZhzATpIcpV+wLKmbcYCZelyF0P83EubsEfTewiOld2RnpIDm
    FGsp8Lu92mYAwOQz9cfQ6QptpOU2TgDu+q32wEuRPUj64iC6Q5e5bZYjKDXTG2Xv
    Y4yKNR4/4kLCEkstApnv51L6DwFneFXQVvZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525950079; bh=t/iklZuqbBcYzZewHpoTP4IE4jCZNs
    8apAiGAeUdQEk=; b=gPVT+N6FcE8gDV1t6qzJSSkWNeG8dKyCRoakwGjQhxNHq+
    Xd+c5v54Wl1f1Hrq9F30qjSOfHGopUPmryhPxWl6Djw8vSOrc3heu5BuAB7SxHQ6
    qtifRY5nmDpC64zPOTyOk9tfPxyIL3rJF5Q6nG+BPBA8VFTkQ49m7Bx9tl5rKC4j
    FhGHlzGPRYhaSvdRUIrFFrWkZ0wCUt/KUtRfcTE6xOlGCCyrAgLSE8bEQKeunk8w
    uakiRTkY29l030JLfPHcDYbLtKP2ls64qnbq4V8MLswrcGv8zqqWSsiyNtxjw0nK
    uSFnoaVECHRNH2ZNSaDKh8lg2LuFZL49ccs2PdCg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB2OanNPC6N2v/43qvFJvXBusdVL6slPD84rZv7W9P3Vujz9clxNXUdJqO9Ou/Js4NE/Je7tKMw6eTu1KXD8BZfjzzlDKavhbMUg5O2lGHU5/7V0GJcI
    6i/O2VGvns4J/Buk5VQRcZXkhOOsUC79VnmMytfw//MTN2MrjIm5IGq1/pvDoFVs2qWg3fKQKFog0U42zwsEgn+rJo0BqBBVItT/doT8VzZp/z66NHnnDLP+
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=M8rcC2nyAAAA:8
    a=RXnXJx7MAAAA:8 a=HUjmxnNXZNXdJnS9sNIA:9 a=CjuIK1q_8ugA:10 a=0dxXHNIcbWwA:10
    a=gA6IeH5FQcgA:10 a=NWVoK91CQyQA:10 a=laPRTa_85ASkRVWaiJEA:9 a=ONNS8QRKHyMA:10
    a=VwQbUJbxAAAA:8 a=fUSZZkATYxXnQMecnGkA:9 a=x8gzFH9gYPwA:10
    a=K9tzwgKBnWaK51F8Cre1:22 a=U_UV0sFCMgXoaKVbI-EZ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756852AbeEJLBQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 07:01:16 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57350 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756679AbeEJLBP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 May 2018 07:01:15 -0400
Date: Thu, 10 May 2018 13:01:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@linux-foundation.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 24/24] debugfs: Restrict debugfs when the kernel is
 locked down
Message-ID: <20180510110113.GA6977@amd>
References: <20180413202241.GB4484@amd>
 <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
 <152346403637.4030.15247096217928429102.stgit@warthog.procyon.org.uk>
 <27818.1524148547@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <27818.1524148547@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-04-19 15:35:47, David Howells wrote:
> Pavel Machek <pavel@ucw.cz> wrote:
>=20
> > >  (1) chmod and chown are disallowed on debugfs objects (though the ro=
ot dir
> > >      can be modified by mount and remount, but I'm not worried about =
that).
> >=20
> > This has nothing to do with the lockdown goals, right? I find chown of
> > such files quite nice, to allow debugging without doing sudo all the ti=
me.
>=20
> It allows someone to give everyone access to files that should perhaps on=
ly be
> accessible by root.  Besides, if you disable lockdown then you can do thi=
s if
> you want.

As I said this has nothing to do with lockdown, so does not belong in
this series. (And besides, it is bad idea.)

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlr0JnkACgkQMOfwapXb+vKsZwCfVdFRRD0vggdq5dy87grncAKq
zooAn1UP9zxiDCMEYTDHNkNjszBUVend
=+dt4
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
