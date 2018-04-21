Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AIpwx49KQ/Sf+XjXBeNhjYEyzXXb6ERb6e//OD2bUfhmCc4NrEQQPoWPG1f8M3dZLqlj6utV9LJG
ARC-Seal: i=1; a=rsa-sha256; t=1524321622; cv=none;
        d=google.com; s=arc-20160816;
        b=IVjs+NOrVZO4FcgLyz+njUoB98QhXY3jRI60/Sta73vb0jZ9PWmRkoA9YJU/PsnVem
         poeD0XGN1cjQpzwFaMrf2Uder6GfQ8dJE+ty3ii147IeaBOUtwLoKBH7QnWSoZDwb3tI
         /2OrRtqD1SH/vNyi0EM1LksjZoboSl++SllJvDCnDlgXUKWSBM4bZzkNI3rNOsHcZcFM
         D+XuqQiCKhmKisy6f4WSPli2OTb36OlbkAzsNtJeKGuzNyc+kltGtSssggYJJWmxPOFW
         swHZhY87er95WqXBcU/cczSKFCbUfNIK5i2VFCJ4M6IiVJE28QkPzsO3HcEIuUNsUYV1
         LK8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=wSF7hGhR7Posj5/mqa6M7i341iqMqz5NO9vSFM64Cm8=;
        b=wGyGvoPl92APWA1nBdr011DAqNev5fYoM9or7VEDUtT1OtwPL67R0M1Z94WeT75mIV
         QXW4lf7qckAl1c7g/MjcH2h6ArgjZ3jCLn8qtSJJhhUKUNO8AI6WoWuBzO6wI1N0uYXP
         alU/UJXwAW4X/E25CypTjDrKuy8YOSY0pDsRqlBeYSZZKWrqVqEPGKoxi41rytmTeLTh
         oKS5Mz/PrZ83hfRqgI3GolD36FJ1KFY4I8+6hk2v4qVLe2EDS198Vu/gCt3RnuYaZR08
         dCbY3WUT2yMZV873fXngkYw+AoiMSytcR+YrFHJvyZSGD3D+OCfh+u60gZN2VuKrfXCg
         PO8A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDC5204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 21 Apr 2018 15:40:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>,
 <knaack.h@gmx.de>, <lars@metafoo.de>, Peter Meerwald-Stadler
 <pmeerw@pmeerw.net>, <gregkh@linuxfoundation.org>,
 <Michael.Hennerich@analog.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/14] staging: iio: ad7746: Fix bound checkings
Message-ID: <20180421154013.3e9c3c3e@archlinux>
In-Reply-To: <20180418103948.00004b93@huawei.com>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
	<1523637411-8531-4-git-send-email-hernan@vanguardiasur.com.ar>
	<20180415160550.4705667e@archlinux>
	<CALfa3vFgh7jtb=B6doOu-y2Bm77wu4zVdLE1LuxbruTTKjLU=A@mail.gmail.com>
	<20180418103948.00004b93@huawei.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649691066295032?=
X-GMAIL-MSGID: =?utf-8?q?1598367069183260405?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 18 Apr 2018 10:39:48 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Mon, 16 Apr 2018 11:47:05 -0300
> Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar> wrote:
>=20
> > On Sun, Apr 15, 2018 at 12:05 PM, Jonathan Cameron <jic23@kernel.org> w=
rote: =20
> > > On Fri, 13 Apr 2018 13:36:40 -0300
> > > Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar> wrote:
> > >   =20
> > >> Also remove unnecessary parenthesis   =20
> > > I am probably missing something.  I'm not sure what you mean
> > > by fix bound checking?   There are superfluous brackets, but
> > > I don't see any functional change to indicate there was anything
> > > wrong with the original checks.
> > >   =20
> >=20
> > Maybe I'm wrong but | is a bitwise operator while || is a logical one.
> > There are no functional changes as you said but, from K&R, "One must
> > distinguish the bitwise operators & and | from the logical operators
> > && and II, which imply left-to-right evaluation of a truth value. For
> > example, if x is 1 and y is 2, then x & y is zero while x && y is one"
> > so it'd be slightly faster if the first condition is true, and it
> > would be the "correct" operator to use in this case, even though it
> > doesn't affect the result. =20
> Got you, I missed the operator change entirely. Doh.
>=20
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> Jonathan
>=20
> >  =20
> > >>
> > >> Signed-off-by: Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar>
> > >> ---
> > >>  drivers/staging/iio/cdc/ad7746.c | 4 ++--
> > >>  1 file changed, 2 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/=
cdc/ad7746.c
> > >> index 516aa93..d793785 100644
> > >> --- a/drivers/staging/iio/cdc/ad7746.c
> > >> +++ b/drivers/staging/iio/cdc/ad7746.c
> > >> @@ -458,7 +458,7 @@ static int ad7746_write_raw(struct iio_dev *indi=
o_dev,
> > >>               ret =3D 0;
> > >>               break;
> > >>       case IIO_CHAN_INFO_CALIBBIAS:
> > >> -             if ((val < 0) | (val > 0xFFFF)) {
> > >> +             if (val < 0 || val > 0xFFFF) {
> > >>                       ret =3D -EINVAL;
> > >>                       goto out;
> > >>               }
> > >> @@ -470,7 +470,7 @@ static int ad7746_write_raw(struct iio_dev *indi=
o_dev,
> > >>               ret =3D 0;
> > >>               break;
> > >>       case IIO_CHAN_INFO_OFFSET:
> > >> -             if ((val < 0) | (val > 43008000)) { /* 21pF */
> > >> +             if (val < 0 || val > 43008000) { /* 21pF */
> > >>                       ret =3D -EINVAL;
> > >>                       goto out;
> > >>               }   =20
> > >   =20
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html =20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
