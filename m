Return-Path: <jonathan.cameron@huawei.com>
X-Google-Smtp-Source: AIpwx4+F+S/ksV2kUy1MncOHkbSDQALFf1/AG8z76SrglLpUZlto3dQNeVC+ZMpea1v+Z1eWR5Mv
ARC-Seal: i=1; a=rsa-sha256; t=1524044434; cv=none;
        d=google.com; s=arc-20160816;
        b=HXpM6h2m6RyDsQdNMkxni4BStZYnJzcg8uxwz8v7fJV7zn4oB3EkuouxSbG8B6G6RS
         G3v6xyyy7X9O4jP7yNAkpDkCtr/17FxsXiZyvWBKB016lLpnXVtxFKalbaGVLoH1j1MJ
         g8j5FacPvq8gMxSqghwWs2ybO6s4GoLSmQM1oDHMB8XaQqWQ+N+BdDICDfVqNkgosa41
         isRpTGCXcG4hOZsqi8uVwDGO62soVsBDOT+BuI5/Jwnj3QcOAm/1rNNGBoGDURGcGYHE
         6LDFlCiXZ+WzYAsOxA4pk1VzmNvc0hHvPUWk4QCsoS/bYNPDMOLkPyx7L318g8GgpMHW
         Ah6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=UwKN2O6PCamp5KyXmX+F3bl1S7eouOJ8HamAkCt+Ebc=;
        b=xDJRzfds7W/xS0r8XOO7tiDgtptwuO5vwMI9MoUSLa99pQvF7DuSsxqijjCHZs3AJ/
         b7CwGAGAZQxYajvs2TiSw8c+owXUMqIivkKDHpdgSValYKHUIqfEpK+wSbNVfozi1Dkm
         2t8jbr1quD/TMr2hGOoeEB5nmM/HyDOcQ/BlcKLhMvYLVkOFIX6XKWb6YrUOwcCE4yxd
         6wWvZuT0JZFgFNGhNsSXgcT3Hi2SFrCS46atO3DBd+8C7WPF/T6zjz/TIJv/hJifaCrL
         OB5o4n/5+gX8P7M/67AOZNqiixXyJX7RIBkRiBi253ce1HqmWiMzNTwzK1hcw9SwBp8X
         3Osg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jonathan.cameron@huawei.com designates 45.249.212.32 as permitted sender) smtp.mailfrom=jonathan.cameron@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jonathan.cameron@huawei.com designates 45.249.212.32 as permitted sender) smtp.mailfrom=jonathan.cameron@huawei.com
Date: Wed, 18 Apr 2018 10:39:48 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: =?ISO-8859-1?Q?Hern=E1n?= Gonzalez <hernan@vanguardiasur.com.ar>
CC: Jonathan Cameron <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, <gregkh@linuxfoundation.org>,
	<Michael.Hennerich@analog.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/14] staging: iio: ad7746: Fix bound checkings
Message-ID: <20180418103948.00004b93@huawei.com>
In-Reply-To: <CALfa3vFgh7jtb=B6doOu-y2Bm77wu4zVdLE1LuxbruTTKjLU=A@mail.gmail.com>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
	<1523637411-8531-4-git-send-email-hernan@vanguardiasur.com.ar>
	<20180415160550.4705667e@archlinux>
	<CALfa3vFgh7jtb=B6doOu-y2Bm77wu4zVdLE1LuxbruTTKjLU=A@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649691066295032?=
X-GMAIL-MSGID: =?utf-8?q?1598076416968693431?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018 11:47:05 -0300
Hern=E1n Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> On Sun, Apr 15, 2018 at 12:05 PM, Jonathan Cameron <jic23@kernel.org> wro=
te:
> > On Fri, 13 Apr 2018 13:36:40 -0300
> > Hern=E1n Gonzalez <hernan@vanguardiasur.com.ar> wrote:
> > =20
> >> Also remove unnecessary parenthesis =20
> > I am probably missing something.  I'm not sure what you mean
> > by fix bound checking?   There are superfluous brackets, but
> > I don't see any functional change to indicate there was anything
> > wrong with the original checks.
> > =20
>=20
> Maybe I'm wrong but | is a bitwise operator while || is a logical one.
> There are no functional changes as you said but, from K&R, "One must
> distinguish the bitwise operators & and | from the logical operators
> && and II, which imply left-to-right evaluation of a truth value. For
> example, if x is 1 and y is 2, then x & y is zero while x && y is one"
> so it'd be slightly faster if the first condition is true, and it
> would be the "correct" operator to use in this case, even though it
> doesn't affect the result.
Got you, I missed the operator change entirely. Doh.

Jonathan

>=20
> >>
> >> Signed-off-by: Hern=E1n Gonzalez <hernan@vanguardiasur.com.ar>
> >> ---
> >>  drivers/staging/iio/cdc/ad7746.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cd=
c/ad7746.c
> >> index 516aa93..d793785 100644
> >> --- a/drivers/staging/iio/cdc/ad7746.c
> >> +++ b/drivers/staging/iio/cdc/ad7746.c
> >> @@ -458,7 +458,7 @@ static int ad7746_write_raw(struct iio_dev *indio_=
dev,
> >>               ret =3D 0;
> >>               break;
> >>       case IIO_CHAN_INFO_CALIBBIAS:
> >> -             if ((val < 0) | (val > 0xFFFF)) {
> >> +             if (val < 0 || val > 0xFFFF) {
> >>                       ret =3D -EINVAL;
> >>                       goto out;
> >>               }
> >> @@ -470,7 +470,7 @@ static int ad7746_write_raw(struct iio_dev *indio_=
dev,
> >>               ret =3D 0;
> >>               break;
> >>       case IIO_CHAN_INFO_OFFSET:
> >> -             if ((val < 0) | (val > 43008000)) { /* 21pF */
> >> +             if (val < 0 || val > 43008000) { /* 21pF */
> >>                       ret =3D -EINVAL;
> >>                       goto out;
> >>               } =20
> > =20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
