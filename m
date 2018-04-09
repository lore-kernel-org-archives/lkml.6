Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1931470-1523304538-3-16460227041442314674
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523304537; b=M8KkqDyJ39UwHa8OLs4iOfghhfuXo4IiWoCugyFWs7/IEHNz2+
    Ggd1h62FGqMFWa1XMfXn5UX21foLtCa6x9xhozcDl4jL5oKBF2dc7m4ZbIFDVdIl
    ph7lZnSutgZg98Ee8OPPPsohf9+dz0JUJZZyvETDB+iz3Jq7yiXxiJsPhC7EHmO6
    dTuK+mOHkP5bVZZ7cnfWdzEhpysbMWC0J4AYBvUVERCSnuP0Lw13EpJTu6dhHsfv
    +E1TxCT8ZsfP1gOG+1TkPjwzcFlWGMNYVkR9QiUTDomPXKFAVCsVmLA3uG5Jdnh/
    4dNNBCqTAYqMNTYRTcHGjbG6PIIJDTauh3Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523304537; bh=5sgyUfSV6K2wCDdkAtafKnpPQxiYtA
    VpzdaBQGOPx3s=; b=gZa68wz8IK1MB1AvUWrN8HYAHuOdiIzH6lp0QUrAAG+0nj
    XRvWErye48jDYOTRiCqlfkGrWNWu9+IEpPbkwH89WoCZ2cnmx/kn+wtfsU0k1W7s
    t7UW5gnl8HdlKiZOOTSf0romWd7APeyxk11DjeCKJ6Q5GltN9+tzcx/rx9BLTf2P
    p8O+vxMd5qUGzU8dnXYb/D5u3Fdc+E6xiL8eOx1PN3W2VdGn52WqyAsq51ok9yWI
    D2vDAnJMbuh/+JX244OqAsSmRYpYmBPXQKDqmkyt828rFigp2linVOEkQwtrDFz4
    vmkHaI5VBBjeov1M9Zt2n3XfHVpmalnLhsvEDnDg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBHontZBaJNsKjmkbFLDoWaw/tKEODddeXxhS0mqNRSh4m6i/+fTHk9obPL3hRXGVl91HtCO4Nqxp7RlbW/cCzdfHQ0TwCmRtbttpbpiVQpiVK89jbRm
    wHWXHtmkiOQru0WIIW0yeZ72kbGKQytsbEbKBiwDgjHxPzgAZrl+KNNunijdBioagsAPowE8TcFop75iiUWOPg1G6dcqiwIqAF+DiNvshIDSOIbEEVZ6hopy
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=EHaNKQqtAAAA:8
    a=80itfb9HdFhjEtago-gA:9 a=QEXdDO2ut3YA:10 a=sZS8fxWRPO7sAyShe78A:9
    a=ONNS8QRKHyMA:10 a=KIA0-nbnOXq3vJi0w304:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754831AbeDIUIt (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 16:08:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754811AbeDIUIo (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 9 Apr 2018 16:08:44 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5684521771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Mon, 9 Apr 2018 21:08:38 +0100
From: James Hogan <jhogan@kernel.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH AUTOSEL for 4.14 043/161] MIPS: JZ4770: Work around
 config2 misreporting associativity
Message-ID: <20180409200838.GB17347@saruman>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
 <20180409001936.162706-43-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
In-Reply-To: <20180409001936.162706-43-alexander.levin@microsoft.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 12:20:20AM +0000, Sasha Levin wrote:
> From: Maarten ter Huurne <maarten@treewalker.org>
>=20
> [ Upstream commit 1f7412e0e2f327fe7dc5a0c2fc36d7b319d05d47 ]
>=20
> According to config2, the associativity would be 5-ways, but the
> documentation states 4-ways, which also matches the documented
> L2 cache size of 256 kB.

JZ4770 support is new in 4.16, so no need for this to be backported.
More likely it'll just break the build due to references to
MACH_INGENIC_JZ4770.

Cheers
James

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrLyEYACgkQbAtpk944
dnoYMA/+J7j53fTTZktDcA/AEGAoibI48k1rSjXv9MM1kjjSPCEcbQFUbMdfLLpk
Wal+55kwJgfU8yLuEntBlHyWOUceGM9a9DGPulDLs97JPVy1yCB0RSzplbcE24aB
Euk4FaqvrEw4L3bDcmoQlL+TOSMdPhgyoAT5xDgDaFLAuMyK+r0KPDhTp+c0YlNn
qZWVlLRN+jYCL/3BCOISd1ab+feD4Gm4kckQGCkbg8SI4vJGrApHkpus6RdNzxtS
B9E36V96zrr24EHG1iOalR0IMI6XXTX7alYcUhCZEVb7lUTlvyUn527vJFh5Pxxx
CXeap6ODc3BPyFNXIE7qBgMMi74i3X0Mo0OTZJ/N3YexBEuhU+H9k+rb2co+0TJ2
AhFbsZcdgpo6xp19bwStpDZ2oyth5/EuJw1s+Q2OkgnEnvKh+RB+mCLkyX+QRpnQ
oDOz3Cn1um7VT4uO9oOM0Kq5u7xGgUnXUr9Ath6zcKqwaQNIdOHGz5fmFk3uncX3
o1UFjqUukb0of/NdtrunYrJ5Tj3OwmGRFTa8ihVB4NSCUApcez+9jqE1NvyQa+Uy
vw3FDZER8XsHXagVC73hmWp8lm4aDOK9IjD+CfwmSHKWDqisELbPexZtRwgbuTz1
GkE3QnqKu8lYqb+8mTtNzCmuu0sumT5RwRMUp6pSW78DPVeuKHI=
=izFW
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
