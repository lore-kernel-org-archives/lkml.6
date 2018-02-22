Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3082549-1519268837-2-1769533098551501429
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519268837; b=sN8mH/gzPjhROOy1N3syL7DWVEYzIX6sIXoVyg0tDFAD0Cr
    B1CJGTDv/clfsQFSM4EioQ1H5e0o7+lvgvpmGpVgET7aJ2Xiyt9MRl6KEBLtH6Oh
    yO56A/f3cHQe8ta5bV92qTMM5POGurFK9nZPlKD0leTpleasn2mOayYiBlu+3w/z
    nP/0PuLWhQhXzWbr2AT3n2Xw2MPy9hoc65rypOzKK6zoStqv9hCoCu9Km8KWTlxr
    DL3jwBBlDPdnfuKyBjqABhvnw6GlByqf62qZDJ3kGdr9bepgKY37pswyp22pJYIe
    2iy8+vZy9i2SL1ywON7jKhWTkTswdfKg1I1MyHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:in-reply-to
    :references:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :sender; s=arctest; t=1519268837; bh=qwhCSULMzLQRzQeg4+sXP/H6RKI
    XSm7gcEZkMgqFiCk=; b=JhiPzJQsF1p+CIhFz0v/czV0Rm7LJb5Wzsg/VIghTkN
    Bl0jbjSgzhYrs3Q8yIj7w8iJbTZXYolQ6P4Dj25EQve97+1ehiZDoEkSnEd4f8+x
    GQrSNwjEcn4YQP6PACny6mFmXyOnVXAlIneqXuah38R4BfoC0oMzMGIBvMCmsAni
    4EzOuZfl+G9CdYhy6gePJIDDVCeSC/6/NoIDcc7DwcgGHfHpTd7zfz5lzAD4xvH5
    R4Eq+Uu9nCG9+1XptErH2s43btpYuZQqlD3iUh4Xr5nrZ/ZT96COatkcccwGOED2
    v4f5VVrn0wiAjAD60ixXv2TtmZv7hXwjpvz0j6XwNEw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neilb@suse.com>
To: James Simmons <jsimmons@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
 Andreas Dilger <andreas.dilger@intel.com>, Oleg Drokin <oleg.drokin@intel.com>
Date: Thu, 22 Feb 2018 14:06:54 +1100
Subject: Re: [PATCH 24/41] staging: lustre: clio: add CIT_DATA_VERSION and
 remove IOC_LOV_GETINFO
In-Reply-To: <1475461717-21631-25-git-send-email-jsimmons@infradead.org>
References: <1475461717-21631-1-git-send-email-jsimmons@infradead.org>
 <1475461717-21631-25-git-send-email-jsimmons@infradead.org>
Message-ID: <871shdk9ip.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: "John L. Hammond" <john.hammond@intel.com>, Bobi Jam <bobijam.xu@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: multipart/mixed; boundary="===============2536639799962603263=="
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============2536639799962603263==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Another ancient patch....


On Sun, Oct 02 2016, James Simmons wrote:

> From: John L. Hammond <john.hammond@intel.com>
>
> During development a new api, cl_object_obd_info_get()
> and cl_object_data_version() which then were later
> replaced by a better solution CIT_DATA_VERSION. For
> the case of the upstream client their is no point in
> introducing a API to only have it removed later. Due
> to the way the patches landed with their dependencies
> it is not possible to separate out two patches. These
> two combined patches do the following:
>
>  * Add a new cl_io type CIT_DATA_VERSION to get file
>    data version.
>  * Remove the unused IOC_LOV_GETINFO ioctl.
>  * Remove ll_glimpse_ioctl() and ll_lsm_getattr().
>  * Remove the OBD API method obd_getattr_async().
>
> Signed-off-by: John L. Hammond <john.hammond@intel.com>
> Signed-off-by: Bobi Jam <bobijam.xu@intel.com>
> Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-5823
> Reviewed-on: http://review.whamcloud.com/12748
> Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-6356
> Reviewed-on: http://review.whamcloud.com/14649
> Reviewed-by: Henri Doreau <henri.doreau@cea.fr>
> Reviewed-by: Jinshan Xiong <jinshan.xiong@intel.com>
> Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
> Signed-off-by: James Simmons <jsimmons@infradead.org>

With so many Reviewed-by :-)


>=20=20
> +static void
> +lov_io_data_version_end(const struct lu_env *env, const struct cl_io_sli=
ce *ios)
> +{
> +	struct lov_io *lio =3D cl2lov_io(env, ios);
> +	struct cl_io *parent =3D lio->lis_cl.cis_io;
> +	struct lov_io_sub *sub;
> +
> +	list_for_each_entry(sub, &lio->lis_active, sub_linkage) {
> +		lov_io_end_wrapper(env, sub->sub_io);

This sort of construct occurs several other times in the same file:

lov_io_read_ahead:
	rc =3D cl_io_read_ahead(sub->sub_env, sub->sub_io,

lov_io_submit:
		rc =3D cl_io_submit_rw(sub->sub_env, sub->sub_io,
				     crt, queue);

lio_io_commit_async:
		rc =3D cl_io_commit_async(sub->sub_env, sub->sub_io, queue,
					from, to, cb);

lov_io_fsync_end:
		struct cl_io *subio =3D sub->sub_io;
		lov_io_end_wrapper(sub->sub_env, subio);


Every other time, sub->sub_env is used with sub->sub_io.
In this new code, 'env' is (incorrectly) used with sub->sub_io.

This reliably causes my testing to crash as the LNVRNT() in cl2osc_io()
fails, and I test with
   CONFIG_LUSTRE_DEBUG_EXPENSIVE_CHECK=3Dy

Does anyone have any idea why no other testing trips over this?

lustre-release has the same bug in
  Commit: fcd45488711a ("LU-5683 clio: add CIT_DATA_VERSION")

I'll send a patch for Linux.  Someone else might like to fix
lustre-release.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlqOM84ACgkQOeye3VZi
gbkQKw//YDCJBiMcUy9n23Ix0QUZgpsmjuRxo/wktVvKFdwWOUstURZ6uPtD6GWH
HBQvhmJvuIvIIf+uVIqv021aNb3vvdcgqkFvB8EtedVgTodfRYU/GoEuBKtpx4Lw
I+qmb61PakNa6rYQJea1w0y5RZhbtZCUzIBsWgN5R51AnbW2EfURdn5nkIVpPt/0
tcPLLLjXGRRYatUehvEPohCpdY8qcIV/Bl/xUfJdikRZrtqy7FbEaU2ipRWau/YE
RxmenWVVaRDr0h4r0mxWez3dHU6y26BPar6iB/SDX1hoCRpJCS+105diGh+/0+4s
7AWW0wd41fhtM5fxfkrpWgMc8RL17YSLrzV6PNx3f+Ae0OHx0HQwAgSWawTTj6K1
LaPqznSrTtXcvq95kPM9Kmd/NCQFcllTIOHhPxKGe4zYUb6pfkHlJFEWcML9CTLT
vm8ANYF2wsVRfJfs745cX8z2Ev90DJh/O2S+XmcefdhzE9w3dofWUooP0r6idGhT
P4HtoJIWo+RTAqjY6cY2u0HI/m1DLhCoepzFpJ8IDc3bnsZUpoAptp38flrRNJzD
f1Zs2NmZRXa9X8S5HG2nFkyUZqyU3dCIsEgKBlN4aiOPbMaHOOP0EyGMZ5/gjGzS
dU5ejjrNZ05tWjsKgThZVgOfWN+RG85ea0YhBtGvnIEBp2EHT1I=
=lS+h
-----END PGP SIGNATURE-----
--=-=-=--

--===============2536639799962603263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============2536639799962603263==--
