Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753014AbeDQOHm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:07:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752592AbeDQOHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:07:40 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E412183B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Tue, 17 Apr 2018 16:07:37 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: viro@zeniv.linux.org.uk, arnd@arndb.de, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: Re: [PATCH] hsi: clients: Change return type to vm_fault_t
Message-ID: <20180417140737.45xtk7qanthxzgsm@earth.universe>
References: <20180417135742.GA30368@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gylny6llc5krr34d"
Content-Disposition: inline
In-Reply-To: <20180417135742.GA30368@jordon-HP-15-Notebook-PC>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gylny6llc5krr34d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 17, 2018 at 07:27:42PM +0530, Souptick Joarder wrote:
> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.
>=20
> Reference id -> 1c8f422059ae ("mm: change return type to
> vm_fault_t")
>=20
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/hsi/clients/cmt_speech.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hsi/clients/cmt_speech.c b/drivers/hsi/clients/cmt_s=
peech.c
> index 324cb8e..a1d4b93 100644
> --- a/drivers/hsi/clients/cmt_speech.c
> +++ b/drivers/hsi/clients/cmt_speech.c
> @@ -1098,7 +1098,7 @@ static void cs_hsi_stop(struct cs_hsi_iface *hi)
>  	kfree(hi);
>  }
>=20
> -static int cs_char_vma_fault(struct vm_fault *vmf)
> +static vm_fault_t cs_char_vma_fault(struct vm_fault *vmf)
>  {
>  	struct cs_char *csdata =3D vmf->vma->vm_private_data;
>  	struct page *page;
> --
> 1.9.1
>=20

Thanks, queued to hsi-next.

-- Sebastian

--gylny6llc5krr34d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrV/6QACgkQ2O7X88g7
+pobzA//ZAv/MiqmprUGMP+eBbi8Lpe9U5bRXJdJMT0BVz9v6XusbFtorIl4aG3b
z0sMO0VlOBl5pqWlWhtQOYNDQVnadi0dbgY3UPdptJTss1MfneyndQZT16HsHnNI
SmJOurADAjreE6TyBvbLNm6qCZoWIto0mMuMZPWt75pLSTcqnFsCUbx5gzqSUlli
pfOKzWAvmluKaX3v8FeL9mu+CokC3NyLmJ3hJlmiu0laD9PQel3BRNY/B+Ko516Y
vDPQXfDsGuEKzm+xkJY9mK7JgrmIrLD4jrJetqqPMnVLApxvKuDYJhj69Er85o0R
8n/05/R4/EJ//HEDEBtFPvE6ATU55D4SzamjB1BsRi5YNuaxRL0pikqWJUi6aFgF
iqloBmVfRuf5vChH15KzH+l4UQtFApLJ2gJOWgzezVq+CyTsBQgsmOptpB7w3M8M
xFs8Fe83SDEgYhoQ+t0ve6Kc+dWyVrmUKAKZe7jkevWYrF6poa6XRCyoDIs4bK7p
PdO0Q+CfZyfHDjDWGi+3L+APTBrun9glXbQw69oAs7ryIqmi1YtdbRViUOlA7xu2
7gh6L6tOW0sIszs+sMMuBYSKYHV5k99h63wZSWS+wimJNPO6HRg87+Kz2eKg2nZk
YiwckB64q3dCkcNuf0s2lWDn44XhhyZE/EpdHLOjzASI9C21bjY=
=cj2n
-----END PGP SIGNATURE-----

--gylny6llc5krr34d--
