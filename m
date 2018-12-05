Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE329C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDD220892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqOUsnxg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FDD220892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeLEPjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:39:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:52484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbeLEPjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:39:15 -0500
Received: from earth.universe (dyndsl-091-096-060-051.ewe-ip-backbone.de [91.96.60.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2631C206B7;
        Wed,  5 Dec 2018 15:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544024354;
        bh=zqThkFVDkURSHXROZ4yszDOVhm4bPPTjz/yXkFKU9qM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CqOUsnxgxosg0K76wBKLGgKDtkGARQ6oIvpCQEqUIM/Pr7MOeDWE8NmeHVcLfMZw2
         D4/9pGQSaKg1ajeRdui+QpBlEQ6TfughJ+IuQPmAOU+A05Q8iE1hcQdm6GIgw4ElZS
         eRLR7fLR79vyRqP6OJKPtwFXDEsMp+7nRUagnm0I=
Received: by earth.universe (Postfix, from userid 1000)
        id A6B973C08D6; Wed,  5 Dec 2018 16:39:11 +0100 (CET)
Date:   Wed, 5 Dec 2018 16:39:11 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     gregkh@linuxfoundation.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HSI: omap_ssi: Change to use DEFINE_SHOW_ATTRIBUTE macro
Message-ID: <20181205153911.rlffpcc5rk2s6o6f@earth.universe>
References: <20181201023355.5280-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u6des2sckltamzeq"
Content-Disposition: inline
In-Reply-To: <20181201023355.5280-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u6des2sckltamzeq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 30, 2018 at 09:33:55PM -0500, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---

Thanks, nice cleanup! Queued to hsi-next.

-- Sebastian

>  drivers/hsi/controllers/omap_ssi_core.c | 29 ++++---------------------
>  drivers/hsi/controllers/omap_ssi_port.c | 14 ++----------
>  2 files changed, 6 insertions(+), 37 deletions(-)
>=20
> diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/contro=
llers/omap_ssi_core.c
> index 41a09f506803..a2a35319f7a5 100644
> --- a/drivers/hsi/controllers/omap_ssi_core.c
> +++ b/drivers/hsi/controllers/omap_ssi_core.c
> @@ -48,7 +48,7 @@
>  static DEFINE_IDA(platform_omap_ssi_ida);
> =20
>  #ifdef CONFIG_DEBUG_FS
> -static int ssi_debug_show(struct seq_file *m, void *p __maybe_unused)
> +static int ssi_regs_show(struct seq_file *m, void *p __maybe_unused)
>  {
>  	struct hsi_controller *ssi =3D m->private;
>  	struct omap_ssi_controller *omap_ssi =3D hsi_controller_drvdata(ssi);
> @@ -63,7 +63,7 @@ static int ssi_debug_show(struct seq_file *m, void *p _=
_maybe_unused)
>  	return 0;
>  }
> =20
> -static int ssi_debug_gdd_show(struct seq_file *m, void *p __maybe_unused)
> +static int ssi_gdd_regs_show(struct seq_file *m, void *p __maybe_unused)
>  {
>  	struct hsi_controller *ssi =3D m->private;
>  	struct omap_ssi_controller *omap_ssi =3D hsi_controller_drvdata(ssi);
> @@ -117,29 +117,8 @@ static int ssi_debug_gdd_show(struct seq_file *m, vo=
id *p __maybe_unused)
>  	return 0;
>  }
> =20
> -static int ssi_regs_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ssi_debug_show, inode->i_private);
> -}
> -
> -static int ssi_gdd_regs_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ssi_debug_gdd_show, inode->i_private);
> -}
> -
> -static const struct file_operations ssi_regs_fops =3D {
> -	.open		=3D ssi_regs_open,
> -	.read		=3D seq_read,
> -	.llseek		=3D seq_lseek,
> -	.release	=3D single_release,
> -};
> -
> -static const struct file_operations ssi_gdd_regs_fops =3D {
> -	.open		=3D ssi_gdd_regs_open,
> -	.read		=3D seq_read,
> -	.llseek		=3D seq_lseek,
> -	.release	=3D single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(ssi_regs);
> +DEFINE_SHOW_ATTRIBUTE(ssi_gdd_regs);
> =20
>  static int ssi_debug_add_ctrl(struct hsi_controller *ssi)
>  {
> diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/contro=
llers/omap_ssi_port.c
> index 2ada82d2ec8c..b2b3989ccfd2 100644
> --- a/drivers/hsi/controllers/omap_ssi_port.c
> +++ b/drivers/hsi/controllers/omap_ssi_port.c
> @@ -57,7 +57,7 @@ static void ssi_debug_remove_port(struct hsi_port *port)
>  	debugfs_remove_recursive(omap_port->dir);
>  }
> =20
> -static int ssi_debug_port_show(struct seq_file *m, void *p __maybe_unuse=
d)
> +static int ssi_port_regs_show(struct seq_file *m, void *p __maybe_unused)
>  {
>  	struct hsi_port *port =3D m->private;
>  	struct omap_ssi_port *omap_port =3D hsi_port_drvdata(port);
> @@ -132,17 +132,7 @@ static int ssi_debug_port_show(struct seq_file *m, v=
oid *p __maybe_unused)
>  	return 0;
>  }
> =20
> -static int ssi_port_regs_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ssi_debug_port_show, inode->i_private);
> -}
> -
> -static const struct file_operations ssi_port_regs_fops =3D {
> -	.open		=3D ssi_port_regs_open,
> -	.read		=3D seq_read,
> -	.llseek		=3D seq_lseek,
> -	.release	=3D single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(ssi_port_regs);
> =20
>  static int ssi_div_get(void *data, u64 *val)
>  {
> --=20
> 2.17.0
>=20

--u6des2sckltamzeq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwH8RYACgkQ2O7X88g7
+pqsRg/8DFjmmnqwSZuw9CN9oBqVbCkzWkeqcvjsr30CZ+gonZXPaCDpWk3Y8Fqu
PWzNA7xOll+c+SnXSyrV3wMMpYtFeLFEpFQcJTimOPFrh7cQQEvG6sgmRj+dewxe
LOcT/oBTAj3xxcCLLHavG6iMnP62Xynhw9Cb8XUmW/MW55cRj0n2O3iF5Mw86fNZ
Cz2trxad/io18y23WrCMUpl8Co7Hfc4tmgbYnESzeaIPsjFuV32hw2VA57NTAdzx
VfH2KranGz+SLfYp+TIJaIo0rLtwq4XKoeLg/eNI+9v5be2Mz/0EMV4ZqrCvFyH1
UTPlUHzYbH1QidTM0EnJLoS3Xh0E6zUgFx93GB6Wsf4iKNZjXAISxRwid8XWYdKi
gTpEnVOQEA4n7PCXW0OASpbIfnFiD+fcOADKOKvLh485xMo2rvKv/a9I5jDgvapS
eH5N6Mu3uKX30u/59kBIbph4xVt/MIClc9FOiJVFk9ONDeV85uHg0N5jfI5TDJI3
8kEwg7xkcDHuPtwktabH/98blvRoyFXlsG51c6pKnMp34oZwN6T2SsOx+uCqpgSY
rZQFUgVWVFJmaNm4mQ/UG1/r8Pws6BU9YpahO9uuB2ZNdWp33b9oZ7HhF1rtyYEq
BBS7/unowmepHIxLw69IdQ5XbgeFnfNUwLyTK2tUM7g/Mw5KYFE=
=QERV
-----END PGP SIGNATURE-----

--u6des2sckltamzeq--
