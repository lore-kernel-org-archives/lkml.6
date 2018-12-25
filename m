Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FE2C07520
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 04:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF18218CD
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 04:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545711975;
	bh=FIRIC3YZtGEyVeu1VBESTCi++oPa4WDn+jsOu+vNyqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0/2j6d/TyUSF0/Tye69tACezAvUGp4myOCI2wGUzfu41PDdpkajh5rqF0+aGORYap
	 iAeFNoJwcS4C8HzY/r0jm+zIMUmA4osIWB3P00ACdU/Hy68ltHmQ0TniKbvV0OUvhd
	 2IfbEGVI1nYN+NVxptA5Fh2xwFepzRTgiu+pQ7nw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbeLYE0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 23:26:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbeLYE0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 23:26:14 -0500
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC871218B0;
        Tue, 25 Dec 2018 04:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545711973;
        bh=FIRIC3YZtGEyVeu1VBESTCi++oPa4WDn+jsOu+vNyqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pD3yOKzy0nE+/Z892JEmswpG0SqrKF4SRuVNQrWIJB/TZsgZlz48c7noW4Rl/C5a+
         y+FuDc4pEv1EUPHQYBxP6GhZbHPKMT8u7un1CwGqdkFZrylPVuRFvb2TK9BDyn+xsu
         YjPZCXXavQLJpXc7KNYFXu4rVJp0Y66UzPTuIE74=
Date:   Tue, 25 Dec 2018 06:26:10 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband/qedr: Potential null ptr dereference of qp
Message-ID: <20181225042610.GC10329@mtr-leonro.mtl.com>
References: <20181224182445.21256-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
In-Reply-To: <20181224182445.21256-1-pakki001@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 24, 2018 at 12:24:45PM -0600, Aditya Pakki wrote:
> idr_find() may fail and return a NULL pointer. The fix checks the
> return value of the function and returns an error in case of NULL.
>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/infiniband/hw/qedr/qedr_iw_cm.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/infiniband/hw/qedr/qedr_iw_cm.c b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> index 505fa3648762..93b16237b767 100644
> --- a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> +++ b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> @@ -492,6 +492,8 @@ int qedr_iw_connect(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param)
>  	int i;
>
>  	qp = idr_find(&dev->qpidr.idr, conn_param->qpn);
> +	if (unlikely(!qp))
> +		return -EINVAL;

As was already pointed, qedr is racy in their accesses to idr_find() and
NULL pointer is less worry about their IDR code.

>
>  	laddr = (struct sockaddr_in *)&cm_id->m_local_addr;
>  	raddr = (struct sockaddr_in *)&cm_id->m_remote_addr;
> --
> 2.17.1
>

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcIbFiAAoJEORje4g2clinIpQP/jIB2bXORjzOzylSYEO/qpXb
byJfdtJmObMHWtEc7po5slq+CxFMcQm1sOtLjocJIpEdfDoZle1eSoyxgQGY0+dg
rt67ROoMHdiNxXqB5yPJvDdQHBT9/BBBtat5smuVAUxWGXGkpEz9ELI1J8OfaX1B
1GqkgZ10rIztXOc1xlkS9FyjThOtdScsXXKGz+JR6vKYMIybDlTLzOYnIwPtDw9o
45tyn15vKyah5SRqrSFL/cKpABbOjR8IW3qWR5TvJ46zmPewdO0VPs0NO27Hx+mn
I/kZ4xhR8MPYfYsruOAsOBRrlej25T9BPpc3SufZjfA7U3yqIdPnkJI5MznfDS/x
yiWhd9kmQXBSoeu5Ro/gXxltoVSrby4aVtoRMPSKhBGPixE0MvT7kIhlVa8ig2Of
BbAUsH6uhkmT6pFABS+xsPOt5xLEjEgHpJIjV1ceij165OfnBgRUUSz3nmDlZLaz
QYywBmIl1pAhzDb7KXHMvMYFeaKZ4Y+c5FvAQxPhe2JutdeBrYmf9cr3B0rMaXw8
nasvx0QvzUu4wmVIiAayYfGIk2IsqgnpXjGCIRiY2kBP6mh2t92v+rzl1TbjPe1b
Dg571oyUPSU1TXGQt6Ao+sSb6aEbYO/b+fFNA/akpw5hTSKUFhSQAR8ttX5h8lHr
rmAqYGwNqbHp3IF75vVc
=XC4T
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
