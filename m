Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DABC4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C18620989
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HFWEa+JM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C18620989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbeKUGiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 01:38:12 -0500
Received: from ozlabs.org ([203.11.71.1]:33191 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbeKUGiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 01:38:12 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42zxZC6dgKz9s4s;
        Wed, 21 Nov 2018 07:07:15 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1542744437;
        bh=mNKQiB+Yp+9B2gXTKy18+MrbRbKbCf5nPorI3AsHS6I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HFWEa+JMyspZ+HH6SODGo+J8qGt/Qnu6aoRnk+Exg8bn27J8bPvzAA6EWDpDumQ0s
         2vFeb+mepagUsVfsWE+3UT78nYqXQpEUaRVuWcsYKeQTlJFePujAoy98pIQTJ9A47v
         kiCtuGO9LYe4dZLTw5GKKaR1HbRwTPi7B/UjT9sOhF+zaJY1TDNeu/itEQq/RXVwWb
         HdsjzRnUcOd7p5LPOm3PuFdyeQbeKs96uDfBV7AIUmuZMD6w+XGU62QROn4/p79e6Z
         GN1J7gEo6obnc4Fd0BCh3rpek9M0N+wCThKhuES/l/A/uV0FYYLb/EUDSwj2wpzQ+w
         auAEURn8wsffg==
Date:   Wed, 21 Nov 2018 07:07:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        marcandre.lureau@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH -next 1/2] mm/memfd: make F_SEAL_FUTURE_WRITE seal more
 robust
Message-ID: <20181121070658.011d576d@canb.auug.org.au>
In-Reply-To: <20181120183926.GA124387@google.com>
References: <20181120052137.74317-1-joel@joelfernandes.org>
        <CALCETrXgBENat=5=7EuU-ttQ-YSXT+ifjLGc=hpJ=unRgSsndw@mail.gmail.com>
        <20181120183926.GA124387@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ooUNGYHyJAbidRTGc1JxAN0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ooUNGYHyJAbidRTGc1JxAN0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Joel,

On Tue, 20 Nov 2018 10:39:26 -0800 Joel Fernandes <joel@joelfernandes.org> =
wrote:
>
> On Tue, Nov 20, 2018 at 07:13:17AM -0800, Andy Lutomirski wrote:
> > On Mon, Nov 19, 2018 at 9:21 PM Joel Fernandes (Google)
> > <joel@joelfernandes.org> wrote: =20
> > >
> > > A better way to do F_SEAL_FUTURE_WRITE seal was discussed [1] last we=
ek
> > > where we don't need to modify core VFS structures to get the same
> > > behavior of the seal. This solves several side-effects pointed out by
> > > Andy [2].
> > >
> > > [1] https://lore.kernel.org/lkml/20181111173650.GA256781@google.com/
> > > [2] https://lore.kernel.org/lkml/69CE06CC-E47C-4992-848A-66EB23EE6C74=
@amacapital.net/
> > >
> > > Suggested-by: Andy Lutomirski <luto@kernel.org>
> > > Fixes: 5e653c2923fd ("mm: Add an F_SEAL_FUTURE_WRITE seal to memfd") =
=20
> >=20
> > What tree is that commit in?  Can we not just fold this in? =20
>=20
> It is in linux-next. Could we keep both commits so we have the history?

Well, its in Andrew's mmotm, so its up to him.

--=20
Cheers,
Stephen Rothwell

--Sig_/ooUNGYHyJAbidRTGc1JxAN0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv0aWoACgkQAVBC80lX
0GzyDwgAnINJOo+z0k5/uEZUNf1WTX20DuqXkwO5M+usRMxeraxGHTcP0NqYzcE7
tnsF/WBGwqXOrB0//rRttyqg9oHKCZatgDs5SUPIaPXuSCSc8/72uWZxNleiHnMQ
CjQwVZbxXzQU1aNT5hplpctUU1Y/MEMqPivy3pcUAPowvbGIYh2TM5OFvIQxqeyU
hhRDUzS2ijhyxE65IzYbE9+a90YkBliE0GcR3+92Lfs2+dafP+VI0ExM95niyNaP
TFYDevRCS7JwDx4ASR07wsbs1Vs9Y4nA3ZGyCDMVogbqBEx+VQQaGpgwTtkvJhhb
m6MpQMsDAMHBBs/2I1f53tSwtuh0kg==
=2jN8
-----END PGP SIGNATURE-----

--Sig_/ooUNGYHyJAbidRTGc1JxAN0--
