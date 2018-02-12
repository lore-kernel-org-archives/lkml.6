Return-Path: <James.Hogan@mips.com>
X-Google-Smtp-Source: AH8x226FFgzR2nTzJWAaLSDzdknpVErAZgZsaqIrbthrWu22ddFZcAS7BzmZlmDmw7airNStBxlz
ARC-Seal: i=1; a=rsa-sha256; t=1518449332; cv=none;
        d=google.com; s=arc-20160816;
        b=sF4Kl7XWlXtEwskj4mvj9iiDiGGzhdiq4jz8dG3XSvIPpLaC33XEvTHEQM3Tm6tKf9
         AFBkvIUXLro25pfImA6hezQdNY5l9TIToWxAfJsy/qpsN0z6lMPMkkKvcwxlWaTmaibu
         pG1dhPy840xOJa6wGAwlnS56RHKXReGMxlD/ZQG2rZK25Lkv5DSolZriPyn3jVATmdON
         4FLKFrrQwOAg2deO1LF0uU/aWZwg2mL2NgI2M0UUxyiEKdzAa8ngbmxOQCbPH+6Vyoo4
         +tqxvBYbaFl16QCf0mkZ/lrrNN4my6z88Yfkl95zh83uOIsCPkUlyTKRMnh4wgzU5RYt
         4WNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=+MjD9JwoLhGx6GgInQ7ntPID3ZYc1ALR63jWwyAlU1Y=;
        b=KUsu9zAAVt8Lw9hCfeZmjqUqGpO/zqOMItdjugjkIVEqSaeFpNCD9xRDjYN/vMklkt
         Fvh4FDtwuFGsaEv27eZmQSVCi2xlSL2hb9OlM0wiqZ/MymFKGNIuYEmKP3rA1lFmmiVj
         ofz0NuFeIwjxdhoWxClkMhUJbJTu6GNncU3Lh70NxT6M4yo87HGJiR48g3FW2qaOcWlx
         no/Yt3rESlDnccMnqCWx6eFMqNN0Ea0g7k1o5rRamQeM9dno8c3O1aYyjCvfuO4suBfl
         h8pTB+60GIubCUZDtODHqc9lSV+507m4Z8aORNE43/hgEBC7eZeuqSdNAU6T2wh7zl3Y
         BqmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of james.hogan@mips.com designates 64.235.150.225 as permitted sender) smtp.mailfrom=James.Hogan@mips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of james.hogan@mips.com designates 64.235.150.225 as permitted sender) smtp.mailfrom=James.Hogan@mips.com
Date: Mon, 12 Feb 2018 15:22:32 +0000
From: James Hogan <james.hogan@mips.com>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kalle Valo <kvalo@codeaurora.org>
CC: Adric Blake <promarbler14@gmail.com>, <m@bues.ch>,
	<linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: B43 driver no longer works in Linux 4.15 (bisected)
Message-ID: <20180212152231.GK11819@jhogan-linux.mipstec.com>
References: <CAE1jjefE1qjgcHMik36Na0OYoFON+kCi5cEDSq=y11HdsyPn0Q@mail.gmail.com>
 <20180205183324.GD8479@saruman>
 <87sha68cv9.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lZZ4ablUVnt2XgAh"
Content-Disposition: inline
In-Reply-To: <87sha68cv9.fsf@kamboji.qca.qualcomm.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1518449300-637139-21590-119664-15
X-BESS-VER: 2018.1-r1801291959
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189944
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1592209527145241962?=
X-GMAIL-MSGID: =?utf-8?q?1592209527145241962?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--lZZ4ablUVnt2XgAh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2018 at 05:08:10PM +0200, Kalle Valo wrote:
> James Hogan <jhogan@kernel.org> writes:
> > On Mon, Feb 05, 2018 at 01:23:31PM -0500, Adric Blake wrote:
> >> I bisected to this "first bad commit:"
> >>=20
> >> commit 58eae1416b804d900014d84feadda7195007cc30
> >> Author: James Hogan <jhogan@kernel.org>
> >> Date:   Mon Jan 15 21:17:14 2018 +0000
> >>=20
> >>     ssb: Disable PCI host for PCI_DRIVERS_GENERIC
> >
> > Yes, really sorry about that and thanks for going to the effort of
> > bisecting. There is a patch here:
> > https://patchwork.kernel.org/patch/10185397/
> >
> > which is applied to linux-next as commit
> > a9e6d44ddeccd3522670e641f1ed9b068e746ff7, and is tagged for stable,
> > though I've just noticed the stable email address is incorrect... I'll
> > make sure it gets applied to the 4.15 stable branch though as soon as
> > I notice its merged.
>=20
> The commit is now in v4.16-rc1.

Yes, thanks,

Greg: Please can commit a9e6d44ddeccd3522670e641f1ed9b068e746ff7 ("ssb:
Do not disable PCI host on non-Mips") be applied to 4.15 stable (the
wrong stable email address was Cc'd in the commit message).

Thanks
James

--lZZ4ablUVnt2XgAh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqBsTEACgkQbAtpk944
dnoW7g/7BauajOVfRAoPO4fV0Jq9YkV0rKzOVfBHfL8IwQA4O12BHRupdIXNfe8t
pdni0H560mHlhlX3FIl6kXZGQNMDAQpAyErsW7vFkk2/SJWrP1gEMQImPMgROdKp
mCVIv2iOtIke106hAdR8YaGyBE4iUefNpjYkuYimnTEI1DvgweDWUrMUuejg/6LO
fEiKvikaBEG7W/XivabTvPn/BBcRRnle2LtVH4PcXkvecX+6DCDu/wcSVfBceRAQ
1wdhPB9a2pPcg+seCMgvAOnHWqTYr6eGQOjuRCUIBcHJ+PTi1pNU8jn07PntjZ6D
YyvFX4ebCPogVfOtUJ/tz3IR2s24LDlpylXPysBhaDWNgkyggpmpiObfO6hlfagL
1ohbZbCMunS3vmE/dwn3lsiVLu90srvP7i4+8SU1IkI24RPpcyUEjZ0nVyB25+qj
ivEEe3rhNDaigESKBdkPYSoReVT+NE58lwT/7IIn606A4PkEVIgucxhA+P/gKe9s
Ef6Es6DHjnQ1tUmitCBUZc2vHSMEty7xx4mtu4If+XlBjbilX/Cz9xOLRdK/irAh
k//xovujDYCiAKKJZRINhmE3ltTWY1tyaWsGm6fNUCCQ4XsgK8AGHtbdDVkm12Oh
6zdFpbM7Rw4nWYZycTu4TF9xyFwP92PU3DTSLTXxcLQ9NQq8ZRs=
=eg0W
-----END PGP SIGNATURE-----

--lZZ4ablUVnt2XgAh--
