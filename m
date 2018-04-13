Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-329774-1523650978-2-15950178773592422290
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
    1523650978; b=g1qB+Sgs/vN7BBcnQ8tc/22sHT6Om+gE0N2U8vXcjpB8K+skvw
    QbNdyp8psJK9Ck696IJUQD2Hy4WNdVEv6QS3CtnxPawycA7uqgiApfxmOLMHBmQU
    Je7fEWGzji2AjrgNcbBsOFVmnulK6WYLmoRnCvTEvkAYI30VMhAovhouuqSRnmSW
    4Tw/pmHKHRjEo9y+pyUGHDhJiZFMLq44+LaU09zpBg+SsuZ3zc8Tyhpze3CnIXZa
    mdWUIxOFt1kpImhxkxf5E+FDxbQ1DBrJ9IZNocvBnzWMyj1NN1Kr5twUZY5FAYSX
    46YKjdR9biU00/0aDNzzbUw2GHwTNgy2vKBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523650978; bh=SgqZz0/kJBJzmt9z+cBpPdDEuJ/gwn
    cuD0IEBZS5GcQ=; b=jz4DwON/rmOfECEQYqTZPCDngiEaTp4/yFZhwUUKvTZLnH
    EbyEbMXTn5dG/xw4iXdMUIqYlmsHZpmc1fC2WQejriZ0Ge13wS+DYaLTHRT82vGM
    mBSB2GeaKz7e6S/r7GNptNa9OnboirxoutpzxzCPOUAKBrIuULzrj/tMNNRxt5Ah
    wOEQxL9OqvEkGHGxkT+YZJd9+m8G1xXD/LOwXX/MEDPUXvunc1j6fUxDM++jdRQ0
    amAxNiUDkVocRQ/1C8140GgswarKLXx/Eah8NLwB1+a3kDs4G6m2mDi980eE+jjS
    i9vPOL2zjYROSoRVsasgC9KIflZK+zhOmF6Hdq2w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGcPcEY4MgJTaySTpnBtbm7CN/OEzTOiM9e4yqKhiHpq7T3Oth28vyibBKTVLe6v6lZL3gXt++i7hvt7++7MEZ7/1SFRk+FCQO8QkGEI9I6ZSpUcZXnh
    B/faiAPuJWPCPy5zGCZzqPFRymlUjN8re17PO5rUPiiUBFME3TjDSf+S7d/hfk7uV6COVNBRE3fH8KjElLqW3hX3t7ydSffKkhGbwJV7tsul3H7Tby/mq70o
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=M8rcC2nyAAAA:8
    a=RXnXJx7MAAAA:8 a=u-CgsrzmgoaB1oUMz_AA:9 a=CjuIK1q_8ugA:10 a=0dxXHNIcbWwA:10
    a=gA6IeH5FQcgA:10 a=NWVoK91CQyQA:10 a=_-qdGLtDKeih3NeNQJgA:9 a=ONNS8QRKHyMA:10
    a=VwQbUJbxAAAA:8 a=fUSZZkATYxXnQMecnGkA:9 a=x8gzFH9gYPwA:10
    a=K9tzwgKBnWaK51F8Cre1:22 a=U_UV0sFCMgXoaKVbI-EZ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751042AbeDMUWp (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 16:22:45 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56739 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750973AbeDMUWn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 13 Apr 2018 16:22:43 -0400
Date: Fri, 13 Apr 2018 22:22:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@linux-foundation.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 24/24] debugfs: Restrict debugfs when the kernel is
 locked down
Message-ID: <20180413202241.GB4484@amd>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
 <152346403637.4030.15247096217928429102.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
In-Reply-To: <152346403637.4030.15247096217928429102.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-04-11 17:27:16, David Howells wrote:
> Disallow opening of debugfs files that might be used to muck around when
> the kernel is locked down as various drivers give raw access to hardware
> through debugfs.  Given the effort of auditing all 2000 or so files and
> manually fixing each one as necessary, I've chosen to apply a heuristic
> instead.  The following changes are made:
>=20
>  (1) chmod and chown are disallowed on debugfs objects (though the root d=
ir
>      can be modified by mount and remount, but I'm not worried about that=
).

This has nothing to do with the lockdown goals, right? I find chown of
such files quite nice, to allow debugging without doing sudo all the time.

>  (2) When the kernel is locked down, only files with the following criter=
ia
>      are permitted to be opened:
>=20
> 	- The file must have mode 00444
> 	- The file must not have ioctl methods
> 	- The file must not have mmap

Dunno. Would not it be nicer to go through the debugfs files and split
them into safe/unsafe varieties?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrREZEACgkQMOfwapXb+vJzCACfSnkCF/54N13G7pz0zGeDo6ze
e6sAn1h0VTYzTyRfA28tZ4D7RyjjUYJU
=ESt0
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
