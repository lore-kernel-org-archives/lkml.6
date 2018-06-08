Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id gH7tJPPzGVtldgAAmS7hNA
	; Fri, 08 Jun 2018 03:11:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B38B1607DC; Fri,  8 Jun 2018 03:11:49 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gDA3MJln"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1F2E160452;
	Fri,  8 Jun 2018 03:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F2E160452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbeFHDLq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 23:11:46 -0400
Received: from ozlabs.org ([203.11.71.1]:33781 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752285AbeFHDLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 23:11:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4126rW2ykNz9s1R;
        Fri,  8 Jun 2018 13:11:39 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1528427502;
        bh=Guzi0+dfZN/mXg9vEsp7XtS0D9X/ZbwW3C7iDxhG6Pc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gDA3MJlnB2dtVP5QLZr7XolsJQI/EG6T+8RZ3ba56KAxOI1wiMid3yVJIf9QxQUOc
         /6Th8iL4W347W6u6SgUmBsXUTHgB2AZQ7vgi+H2zolPOyucQcpj/ZB2NAP+C3CVVYr
         30LQ27qnxNKvdk+1VaMPFVdxfCgkUffF7bG/mCZ+JAmh+sTpdTGi3xPvVCCkVPGImJ
         gt3lYWlRMmvY5wOCEriGKzQWSNF63aQ5q79TedSLYbscEmSBo0aUqd576cjCMLcGhM
         ygtO/ReioiY4JpGS3tybzxJoAuWCfW9jP5WJsZOIiXwFyIZESjcy8VQTN8g+lHUxJJ
         QKRa8R3bkcZVg==
Date: Fri, 8 Jun 2018 13:11:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
        Chad Dupuis <chad.dupuis@cavium.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the scsi tree with the net-next
 tree
Message-ID: <20180608131138.50810e67@canb.auug.org.au>
In-Reply-To: <20180525013810.GG4828@sirena.org.uk>
References: <20180525013810.GG4828@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/oFBvz+qP9J72/FvUYHtLEkd"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oFBvz+qP9J72/FvUYHtLEkd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 25 May 2018 02:38:10 +0100 Mark Brown <broonie@kernel.org> wrote:
>
> Today's linux-next merge of the scsi tree got a conflict in:
>=20
>   drivers/scsi/qedf/qedf.h
>=20
> between commit:
>=20
>   8673daf4f55bf3b91 ("qedf: Add get_generic_tlv_data handler.")
>=20
> from the net-next tree and commit:
>=20
>   4b9b7fabb39b3e9d7 ("scsi: qedf: Improve firmware debug dump handling")
>=20
> from the scsi tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc drivers/scsi/qedf/qedf.h
> index cabb6af60fb8,2372a40326f8..000000000000
> --- a/drivers/scsi/qedf/qedf.h
> +++ b/drivers/scsi/qedf/qedf.h
> @@@ -501,9 -499,8 +504,10 @@@ extern int qedf_post_io_req(struct qedf
>   extern void qedf_process_seq_cleanup_compl(struct qedf_ctx *qedf,
>   	struct fcoe_cqe *cqe, struct qedf_ioreq *io_req);
>   extern int qedf_send_flogi(struct qedf_ctx *qedf);
>  +extern void qedf_get_protocol_tlv_data(void *dev, void *data);
>   extern void qedf_fp_io_handler(struct work_struct *work);
>  +extern void qedf_get_generic_tlv_data(void *dev, struct qed_generic_tlv=
s *data);
> + extern void qedf_wq_grcdump(struct work_struct *work);
>  =20
>   #define FCOE_WORD_TO_BYTE  4
>   #define QEDF_MAX_TASK_NUM	0xFFFF

This is now a conflict between the scsi tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/oFBvz+qP9J72/FvUYHtLEkd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsZ8+oACgkQAVBC80lX
0Gw+Awf+MwQdnxX0K13gISjEo5GCZeLHu6iCdP6EWClTY7sfUrnsHpBwiHRC3AIH
pN78mqFO/4HXdYDE1wsHFqx0JIlL3f8R7IJHXX/keqFMUd7er9kA+XgMoMzjNb/c
scs2RzXnpMnr89gJ8TeRetuuMzCbQBI/YC/fA0O5luamxjcE4pb/L7FCgIE8dVfu
HTQ1Ql4EqhHRSgAaEyNDPyPNBTSmnPUN/xwUqSXFF1CwGVcz/AwVumrXxzYlr8QR
YbwCxYdXKeJnTQv+G2lrArVe7fyFnu7KjV4F6stTAqrZ/cKixOAZ5PAft1XnD1YX
fH/ttnWRBbfCa0rg+4Tujj33vVQ7jQ==
=9q2W
-----END PGP SIGNATURE-----

--Sig_/oFBvz+qP9J72/FvUYHtLEkd--
