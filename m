Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-329774-1523650986-5-15109042184989117871
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
    1523650986; b=HfpE9XB+u0bEVwEz9sYVLqwnpexGxQATJviOxnwpGV7+qoeuuV
    mGl1EtcG78bLdtrNoq03QOnYz+mn5fM+INNpcD7KadM024X+Dv55GTfrZRGsjzKD
    7CDVAxvqPP3dIbdYikXkt9GzA5l7swmVMQwFSSOPMUOO8UBdQQoYoYijcj5gruSH
    EzEVXpE5cUkA0t/Wd1l64CSYiprTDPtDHpuKHEKONx9PXaODkMVfsjjGwz7FZDiP
    xsae1OkSLEqZH4atjS7xts+yjeQdjxyhCuMFLnSMea+713WYioWtUY+NzClxvshH
    ft2hXJQOkzNYKRoR/bczCk8McnwHbS2ixNTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523650986; bh=iC9wx92u70oolebqeusEo3YU/pM8wd
    cT0MVzH99zrxo=; b=IThpviX4W3oxBhb0HtdlpiHP4uIxOZjbNuQygkMQE1EPIO
    37wJ0PmLamjtk694SpXNQhigdrh5dMN71HNnZUp3A/AfzQt/+MYxjvkMZKFIlU0/
    ZbT5o8opX0eK4auzNtQUHflG7a8D3nOJxX/NT6VEEee/LbCES79E+fUnK/Fti9QV
    a/o8RZBc845OhfXtY0+CHw/wSiMcG3+c/9tO8jM0wd6lB9rcvfyTvZFKIec5rPyv
    QHI+PucSzwHMv/yhJV18iiWoZBKkhy3A9vMjfVHQbUOunejevHmvRpTSDgsRTVw9
    4jFTrIgPwWnx5jT35lPP/NO+HRKAUjgbymQUzh6g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfOksi4Fe+aClGstZUZLlHbFP2uT0bCkCEzkOpyOjlgBy0yoA9110Jdo35RtqMlQkc8hXynPcQaFCags30JOlUCw33vEaIyKOZ9tkh+/m8MhKXklgJ28b
    zc5uSuWfug2Pfjo0C+hhkUNhUvUvltAXD9GYfiM+hfmnmBUGXjlPAF6UXch4EFw/rzlY6/qk/7D4o7GUzcNrmuqTx5WZnSXnZSDcIon+kxcKN9DLWMTRFbgc
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=vTr9H3xdAAAA:8
    a=M8rcC2nyAAAA:8 a=RXnXJx7MAAAA:8 a=UxrwPScVLuthl5S3hWsA:9
    a=OsD-6IQzdt067eao:21 a=yxvnz9oDvJAYCZEV:21 a=CjuIK1q_8ugA:10
    a=0dxXHNIcbWwA:10 a=gA6IeH5FQcgA:10 a=NWVoK91CQyQA:10 a=rJR57v3BzPr6qgsNjnsA:9
    a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8 a=fUSZZkATYxXnQMecnGkA:9 a=x8gzFH9gYPwA:10
    a=7PCjnrUJ-F5voXmZD6jJ:22 a=K9tzwgKBnWaK51F8Cre1:22 a=U_UV0sFCMgXoaKVbI-EZ:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750989AbeDMUWi (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 16:22:38 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56723 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbeDMUWg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 13 Apr 2018 16:22:36 -0400
Date: Fri, 13 Apr 2018 22:22:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@linux-foundation.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 07/24] hibernate: Disable when the kernel is locked down
Message-ID: <20180413202234.GA4484@amd>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
 <152346392521.4030.5108539377959227838.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <152346392521.4030.5108539377959227838.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-04-11 17:25:25, David Howells wrote:
> From: Josh Boyer <jwboyer@fedoraproject.org>
>=20
> There is currently no way to verify the resume image when returning
> from hibernate.  This might compromise the signed modules trust model,
> so until we can work with signed hibernate images we disable it when the
> kernel is locked down.

I'd rather see hibernation fixed than disabled like this.

I believe Jiri Kosina may have some patches for that?
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrREYoACgkQMOfwapXb+vIowwCfUxzs3aUSVyQ2xrc9jllsTOiW
MWsAnicxnBuk7FXujrLwnUpctw0Ry4WG
=FD71
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
