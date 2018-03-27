Return-Path: <mchehab@kernel.org>
X-Google-Smtp-Source: AG47ELuvjL2ugGpegIHNbEQKWRcDqG0PntYKTLHljH6NxUjtkok93jmsMwenP7G8oDQuoE25Isv6
ARC-Seal: i=1; a=rsa-sha256; t=1522150261; cv=none;
        d=google.com; s=arc-20160816;
        b=uBM0YslykZ7dEnLIyPPx2djkgipCnpB9p5Ru/N//LV476dMANqkhzzSnfSD03GeHqm
         +8WWhfi3BoBJpYJyq7rYwHhiYaMfF22lCSzpKmy5m6YsHCfZqkN5k5O9pyEp0o04aFiD
         WVJ1hIBTE4VCAglSZcJ5rGosb0XYKGeLEWQXY+ON1Oaf9dQzio/FJwdkRNVf7vvbQXa2
         B1Ve+qR3eBdISYc9jxn5xOMltL22mNb+ClvVMBBAceIOhGihCc2s21XJ0JY3Q3aaBYl6
         ySkBxzwl6eReNzlbfTszIBCp7Ls0qVXTJE5x1OdJGV9LcFdTlczZFWNTLNeqjhIRXZUk
         SU6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=lGfnuC4/krkEkC0Ouew8gbLy7NWPQrKRuxqs+GbbGYU=;
        b=e78t1oQ1XdwBCpKaAl0+1/bLpSiR2txHqQwtNW6UsBNFDlQxudTP5qLZWjCpPpOvKY
         vpUoKpLDpWRGjkBIpoO3N3TJQoTDCzBthDzAKCBewfKFuq8qVOKBlmGZzEBRLRwq6bS6
         0WSktaMqNvk01mU6n4VxxIC3yvSqTZBbspOl6Au73uYTjjURepEBXMtWltENRRhFSzSF
         JVZyumYsrKWVRekYkGqYep6UTA5XiOcsdcjwH/iNYer09dxkysYgIMuw1ii+T4DEr8NZ
         COZ9xIP1tcf1G9A3349EH2POu1DGNAa8Ls3Ei6knHR1lBrlXpS3F1sQi8YBkL/zXyL+k
         Ldow==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=NOxiAmJU;
       spf=neutral (google.com: 2607:7c80:54:e::133 is neither permitted nor denied by best guess record for domain of mchehab@kernel.org) smtp.mailfrom=mchehab@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=NOxiAmJU;
       spf=neutral (google.com: 2607:7c80:54:e::133 is neither permitted nor denied by best guess record for domain of mchehab@kernel.org) smtp.mailfrom=mchehab@kernel.org
Date: Tue, 27 Mar 2018 08:30:54 -0300
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Inki
 Dae <inki.dae@samsung.com>
Subject: Re: Linux 3.18.102
Message-ID: <20180327083054.1d9b7796@vento.lan>
In-Reply-To: <5AB9F365.2030309@samsung.com>
References: <CGME20180325090010epcas1p2864bb6fe3cbc420bc71eb0e7f1c847f1@epcas1p2.samsung.com>
	<20180325085952.GA31575@kroah.com>
	<5AB9A111.1080105@samsung.com>
	<20180327070528.GB31193@kroah.com>
	<5AB9F365.2030309@samsung.com>
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1595911656234901027?=
X-GMAIL-MSGID: =?utf-8?q?1596090233128954329?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Em Tue, 27 Mar 2018 16:31:49 +0900
Seung-Woo Kim <sw0312.kim@samsung.com> escreveu:

> On 2018=EB=85=84 03=EC=9B=94 27=EC=9D=BC 16:05, Greg KH wrote:
> > On Tue, Mar 27, 2018 at 10:40:33AM +0900, Seung-Woo Kim wrote: =20
> >> Hello,
> >>
> >> Until 3.18.102, it looks like following patch series for v4l2 seems mi=
ssed.
> >>
> >> 273caa2 media: v4l2-compat-ioctl32.c: make ctrl_is_pointer work for su=
bdevs
> >> a1dfb4c media: v4l2-compat-ioctl32.c: refactor compat ioctl32 logic
> >> d83a824 media: v4l2-compat-ioctl32.c: don't copy back the result for
> >> certain errors
> >> 169f24c media: v4l2-compat-ioctl32.c: drop pr_info for unknown buffer =
type
> >> a751be5 media: v4l2-compat-ioctl32.c: copy clip list in put_v4l2_windo=
w32
> >> b8c601e media: v4l2-compat-ioctl32.c: fix ctrl_is_pointer
> >> 8ed5a59 media: v4l2-compat-ioctl32.c: copy m.userptr in put_v4l2_plane=
32
> >> 333b1e9 media: v4l2-compat-ioctl32.c: avoid sizeof(type)
> >> 486c521 media: v4l2-compat-ioctl32.c: move 'helper' functions to
> >> __get/put_v4l2_format32
> >> b7b957d media: v4l2-compat-ioctl32.c: fix the indentation
> >> 3ee6d04 media: v4l2-compat-ioctl32.c: add missing VIDIOC_PREPARE_BUF
> >> 181a4a2 media: v4l2-ioctl.c: don't copy back the result for -ENOTTY =20
> >=20
> > That is correct.
> >  =20
> >> Any plan to apply the series? =20
> >=20
> > Do you have a backported version of this series that will apply to that
> > kernel tree?  If so, I'll be glad to apply it but I'm pretty sure the
> > reason I did not apply them was because they did not apply correctly. =
=20
>=20
> I dit not do it myself. I just checked the series is applied on other
> stable trees.

Backporting it from Kernel 4.1 is quite simple. Just two patches
have trivial conflicts.

I did a quick backport at:
	https://git.linuxtv.org/mchehab/experimental.git/log/?h=3Dv3.18.102%2bCVE

Please notice that I didn't test it yet.

Will build such Kernel and see how it behaves with compat32.

If it works fine, I'll submit for stable.

Regards,
Mauro
