Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC8EC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A818214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="d7gWscaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A818214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbeHPCl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 22:41:58 -0400
Received: from ozlabs.org ([203.11.71.1]:40423 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728148AbeHPCl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 22:41:58 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41rR301KCDz9s0R;
        Thu, 16 Aug 2018 09:47:24 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534376846;
        bh=T6WM0hX75PN4+MxrlrhzZHWM6widdhz13E8y3Y5+6AQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d7gWscaU7/8dA6PiJv9LoeRmf0AxdNa/DotsOAKv8Z+2NR2fw2FKVzogZR5LOhawd
         XUH7T/mA+vnQFI1Gymchx47HzuNBNL6Hl+O+lYGA5JCqptBtQ12XhTPh3ox6ekE8BX
         oHt9R47WMnHc2aP37pT+grV7uSxO0eGJbpRvPBdW70uV7wYUXFVbJ4M2PFI2nRzFnC
         gYsxf3jcnST0vILCBNRX+XR7fel8t4HKcLL+0PRlPQ3jXMZdPXt5rcZVlqAq4dP1W4
         TLG1J6XKrlaXcHgyICIIIp9WLiQg6JdP90Ln6s8swkJoovwwiLvbICreNe+bGxecV0
         GgaGa1yHW3RHQ==
Date:   Thu, 16 Aug 2018 09:47:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matteo Croce <mcroce@redhat.com>, Julian Anastasov <ja@ssi.bg>
Subject: Re: linux-next: manual merge of the net-next tree with the
 netfilter tree
Message-ID: <20180816094723.07452406@canb.auug.org.au>
In-Reply-To: <20180807124932.73422224@canb.auug.org.au>
References: <20180807124932.73422224@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/g0YZMO5jvaCY_ec_kDH7s38"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/g0YZMO5jvaCY_ec_kDH7s38
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 7 Aug 2018 12:49:32 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the net-next tree got a conflict in:
>=20
>   net/netfilter/ipvs/ip_vs_conn.c
>=20
> between commit:
>=20
>   16e98cec49a4 ("ipvs: don't show negative times in ip_vs_conn")
>=20
> from the netfilter tree and commit:
>=20
>   ec1b28ca9674 ("ipvs: provide just conn to ip_vs_state_name")
>=20
> from the net-next tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc net/netfilter/ipvs/ip_vs_conn.c
> index 615286dcf4c0,0edc62910ebf..000000000000
> --- a/net/netfilter/ipvs/ip_vs_conn.c
> +++ b/net/netfilter/ipvs/ip_vs_conn.c
> @@@ -1107,10 -1122,8 +1122,10 @@@ static int ip_vs_conn_seq_show(struct s
>   				&cp->caddr.in6, ntohs(cp->cport),
>   				&cp->vaddr.in6, ntohs(cp->vport),
>   				dbuf, ntohs(cp->dport),
> - 				ip_vs_state_name(cp->protocol, cp->state),
> + 				ip_vs_state_name(cp),
>  -				(cp->timer.expires-jiffies)/HZ, pe_data);
>  +				jiffies_delta_to_msecs(cp->timer.expires -
>  +						       jiffies) / 1000,
>  +				pe_data);
>   		else
>   #endif
>   			seq_printf(seq,
> @@@ -1120,10 -1133,8 +1135,10 @@@
>   				ntohl(cp->caddr.ip), ntohs(cp->cport),
>   				ntohl(cp->vaddr.ip), ntohs(cp->vport),
>   				dbuf, ntohs(cp->dport),
> - 				ip_vs_state_name(cp->protocol, cp->state),
> + 				ip_vs_state_name(cp),
>  -				(cp->timer.expires-jiffies)/HZ, pe_data);
>  +				jiffies_delta_to_msecs(cp->timer.expires -
>  +						       jiffies) / 1000,
>  +				pe_data);
>   	}
>   	return 0;
>   }
> @@@ -1173,10 -1184,9 +1188,10 @@@ static int ip_vs_conn_sync_seq_show(str
>   				&cp->caddr.in6, ntohs(cp->cport),
>   				&cp->vaddr.in6, ntohs(cp->vport),
>   				dbuf, ntohs(cp->dport),
> - 				ip_vs_state_name(cp->protocol, cp->state),
> + 				ip_vs_state_name(cp),
>   				ip_vs_origin_name(cp->flags),
>  -				(cp->timer.expires-jiffies)/HZ);
>  +				jiffies_delta_to_msecs(cp->timer.expires -
>  +						       jiffies) / 1000);
>   		else
>   #endif
>   			seq_printf(seq,
> @@@ -1186,10 -1196,9 +1201,10 @@@
>   				ntohl(cp->caddr.ip), ntohs(cp->cport),
>   				ntohl(cp->vaddr.ip), ntohs(cp->vport),
>   				dbuf, ntohs(cp->dport),
> - 				ip_vs_state_name(cp->protocol, cp->state),
> + 				ip_vs_state_name(cp),
>   				ip_vs_origin_name(cp->flags),
>  -				(cp->timer.expires-jiffies)/HZ);
>  +				jiffies_delta_to_msecs(cp->timer.expires -
>  +						       jiffies) / 1000);
>   	}
>   	return 0;
>   }

This is now a conflict between Linus' tree and the netfilter tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/g0YZMO5jvaCY_ec_kDH7s38
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt0u4sACgkQAVBC80lX
0Gxa/ggAiYjYiiKScMfhGCtvWCIDZ/4e9xlpIa0XAxGvaGRtuc/WXC0D/+bFXFkf
ArQqXC/cni5NLfPckJBSy0QqP0D9m+74bVFf6tB7rq4XV/PVvj1UlotTl6PIfQXo
prnqqA7hqDSN8QignxF+n8D8SuRSr7kwavBl/RdlcCrLFzkVJWRp/yO/YdpWxhgG
fYg9O1XtCr3kagGquSZl8sn/wmsTHIfnuAeXMQCuBflQTByicsbBuSOrkupDnHCr
76ePXH5FUDQeJNPFROjbFrMyoFoUqCoqJ0lkK6duEcmql7V2QkyA2sUkyfE7nJFr
QIjjkFTjS45uJ9a3xC66FMcOZy+q9w==
=VZut
-----END PGP SIGNATURE-----

--Sig_/g0YZMO5jvaCY_ec_kDH7s38--
