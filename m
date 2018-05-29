Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967384AbeE2V5O (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 17:57:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:44603 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966304AbeE2V5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 17:57:13 -0400
From: NeilBrown <neil@brown.name>
To: Sankalp Negi <sankalpnegi2310@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date: Wed, 30 May 2018 07:57:05 +1000
Cc: Sankalp Negi <sankalpnegi2310@gmail.com>
Subject: Re: [PATCH] staging: mt7621-mmc: Fix line size exceeding 80 columns.
In-Reply-To: <20180529173757.nmw46a6xbrgh35wd@localhost>
References: <20180529173757.nmw46a6xbrgh35wd@localhost>
Message-ID: <87vab6unv2.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, May 29 2018, Sankalp Negi wrote:

> This patch fixes the checkpatch.pl warning:
>
> WARNING: line over 80 characters
>
> Signed-off-by: Sankalp Negi <sankalpnegi2310@gmail.com>
> ---
>  drivers/staging/mt7621-mmc/dbg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/mt7621-mmc/dbg.c b/drivers/staging/mt7621-mm=
c/dbg.c
> index d897b1216348..0b007e060ddc 100644
> --- a/drivers/staging/mt7621-mmc/dbg.c
> +++ b/drivers/staging/mt7621-mmc/dbg.c
> @@ -229,7 +229,7 @@ static int msdc_debug_proc_read(struct seq_file *s, v=
oid *p)
>  }
>=20=20
>  static ssize_t msdc_debug_proc_write(struct file *file,
> -				const char __user *buf, size_t count, loff_t *data)
> +			const char __user *buf, size_t count, loff_t *data)

Thanks, but .... not like this please.
The code inside () should never be indented before the '(' unless the
'(' is at the end of a line.
So you could make it

static ssize_t msdc_debug_proc_write(struct file *file, const char __user *=
buf,
				     size_t count, loff_t *data)

or

static ssize_t
msdc_debug_proc_write(struct file *file, const char __user *buf, size_t cou=
nt,
		      loff_t *data)

or even

static ssize_t msdc_debug_proc_write(
	struct file *file, const char __user *buf, size_t count, loff_t *data)

(though I don't think checkpatch will like that).
But neither the original or your new version are indented properly.
Try to do more than just remove the warnings - try to make the code
beautiful!

Thanks,
NeilBrown

>  {
>  	int ret;
>=20=20
> --=20
> 2.11.0

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsNzLEACgkQOeye3VZi
gbmXkQ//TjZnJwNjwhJlIIpgvL6uR05CETVeLBx9eWojD5JQcWBtsM491JEc+ebq
MpS6RjQOOT35oaFijnnQzfiY3FMPeqtGZJrpFY6c7kvzHLddWMRFPqPpcLDfzBwy
lmgQofaHSOLScsD4VqA9aN7uctu3dWkdfM3v831rtDgoTKq4p4oH8oFi/SVgF6E7
YzVyzWU55TAQGotqkrghvu9x2ZSC0LFm4qVEUxB4DekUvzYHroDRBNBMN4v1wxeh
yWyFd0sCLHNot6PVTesoDySIyaZ4Voskja1Zoiup7jpvRKkByaNyICLlWfNBmAox
B+U1v4u63pTWcnV7ZopZ2/t7YbGnUuTI4lI1WVrlHlhVCqckVfvAjyvlMkLd9IrN
0YGBaHVK3SJOMqtzLBLA5vj+xaBZtKQlNkJ0Xdt4IYmY/Zo1Vxh8vcJxNAG6DjWf
3ui8sI88XUQGkxUtOP1pZdgWkAGpxLtl3x2+gZBtaWuX27FXmTMzd6utp/fpzCLh
p1TBQb8ZFadaO7iraVJR9PLgXST/PAONqKHP2/0v1Y5c3b52UPoC/R0S1veNhzwQ
bfzesl87VRMS5g/AGWqp7qvMYASnrWF5JrXgmzC2henmG2Nbhtu+ag1BclrZeE4A
sTlUXQ+N5weqKDcqsDBiJbpn2iaXIzdzihfciP10RJyPXXT/U+4=
=UxS9
-----END PGP SIGNATURE-----
--=-=-=--
