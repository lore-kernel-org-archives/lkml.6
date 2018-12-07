Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACAFC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319A720837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319A720837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbeLGSmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:42:50 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:51702 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbeLGSmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:42:49 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 6190872CC59;
        Fri,  7 Dec 2018 21:42:46 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 549507CEAAE; Fri,  7 Dec 2018 21:42:46 +0300 (MSK)
Date:   Fri, 7 Dec 2018 21:42:46 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Breno Leitao <leitao@debian.org>,
        Andy Lutomirski <luto@kernel.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] powerpc/ptrace: replace ptrace_report_syscall() with
 a tracehook call
Message-ID: <20181207184246.GA31278@altlinux.org>
References: <20181116121701.14359da0@akathisia>
 <87ftw12nyn.fsf@concordia.ellerman.id.au>
 <20181119210139.GA8360@altlinux.org>
 <87efbe166y.fsf@concordia.ellerman.id.au>
 <20181203031823.GE11573@altlinux.org>
 <20181207011946.GA18558@altlinux.org>
 <87y391k2tq.fsf@concordia.ellerman.id.au>
 <20181207154255.GA28964@altlinux.org>
 <20181207163410.GA19110@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20181207163410.GA19110@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 07, 2018 at 05:34:10PM +0100, Oleg Nesterov wrote:
> On 12/07, Dmitry V. Levin wrote:
> > On Fri, Dec 07, 2018 at 10:12:49PM +1100, Michael Ellerman wrote:
> >
> > > > Sorry, this patch does not work, please ignore it.
> > >
> > > Hmm OK. Why exactly?
> >
> > Unfortunately, I have no idea why it doesn't work.
> > All I can say is it breaks strace because the kernel no longer sends
> > syscall entry stops.
>=20
> May be because TIF_SYSCALL_EMU/etc is a bit number, not a mask? IOW, rath=
er
> than
>=20
> 	whatever & TIF_XXX
>=20
> you should do
>=20
> 	whatever & _TIF_XXX
>=20
> intstead?

Thanks Oleg, this was exactly the reason why it didn't work.
That kind of things happens when you let userspace people hack you kernel. =
:)


--=20
ldv

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcCr8mAAoJEAVFT+BVnCUIStwP/RCWLHfccYIYOaOZbt2c+XfP
o4z6JNFxh37RDbYe+7Omdn+UNJKHc+QHkaRK3fO/2aceuGIshUkqi6IvV6pXy4au
jYxFyD75dgYTV33iDvFOFrATkCXHy3jRxZpKaQOxWdMRBIdgPHTqhgFh2fL0T9i4
Ld/eoaUiUd1KwdpzuJod5S5IxEFkjQdnAollvroo0tAFvC6PRO1MqxvDGZ1SAyA1
umN9tG5GMFXKVlKRnuX1wp54EBB//idStq0CVCdLdEWi3MlcMPPGFXOZYndIS5SN
0XXD5CD3FFMt+Gl+1kP4Z1V+cOTYCajKWN7NLzVq79gPwqP3Fy7BWmVSzXyh2qFD
npF/qcGX4zh3OilqY/8MM2T9MHH5I7Hi9WCWag2HmRVDc9nkvXpgPB5572XFF038
wEDV4ZBH/+uPzm53pushoFL7za/WKS+y0QIEIxy0aS12fXCsvUx1xIniPk2PfgXK
aIjQje0UeVC5MQ0Qabmkavg849KsyoBR+kZA57bsv+PydyWR2MJPIWpmvB2OVwBc
yuudwLTrkIZm30qE7w1cEROzWgTUnC/DcUDVu7zjtlLV41mITDxwcTTdWP0/OvCv
UvyW5K3VPGviyvfNMT6bCH86Cjb5W2DqCxcdeW2ZvBXUnjS+KxnKQh9ulrSJqCm9
+mFvkgjOZJ324Ure7AZh
=3hv8
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
