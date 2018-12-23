Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D85EC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21AB218FD
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545558082;
	bh=gXFE0VqoS42SeGgZnWvW/b7G26oOyeM6vd6SqERabyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t2DUJiLVnQf6rWOQ63zQg8HVYDElivEgXiSaxeVq1YI8ei7YbhR7QhIewws6jUxpj
	 hQNhqJj/dU9Oh+4V34PzUKAuKXqnXXiGJbBBOSEekuJ9G72lKRVUSi4aPOcYIg5xr5
	 vz58hzzptL3T8U+CJ0qfrtf+EbWfcC3k9ecVtLeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbeLWJlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 04:41:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:33686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbeLWJlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 04:41:21 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0787218FD;
        Sun, 23 Dec 2018 09:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545558080;
        bh=gXFE0VqoS42SeGgZnWvW/b7G26oOyeM6vd6SqERabyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RBD+2BBElhe4DHzKE78BK18iCTWFE1hE2Wa/I/pp0VPYdQEEoLyzCBxUiylj7Ur2t
         d8cAVeXrs6vSMokb7Yw/3GNMHh2xCSbDOREEMbdlSUcXyz7BCuKL3w0nBtWEXuisC7
         6uk9ug54+NVON3VDMJr6jwcfC2n5sP346ybKhvVM=
Date:   Sun, 23 Dec 2018 11:41:17 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Doug Ledford <dledford@redhat.com>,
        kernel-janitors@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/20] IB/ipoib: drop useless LIST_HEAD
Message-ID: <20181223094117.GQ3940@mtr-leonro.mtl.com>
References: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
 <1545555435-24576-7-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6eUvXotnMb6+obQB"
Content-Disposition: inline
In-Reply-To: <1545555435-24576-7-git-send-email-Julia.Lawall@lip6.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6eUvXotnMb6+obQB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 23, 2018 at 09:57:01AM +0100, Julia Lawall wrote:
> Drop LIST_HEAD where the variable it declares is never used.
>
> Commit 31c02e215700 ("IPoIB: Avoid using stale last_send counter
> when reaping AHs") removed the uses, but not the declaration.
>
> The semantic patch that fixes this problem is as follows:
> (http://coccinelle.lip6.fr/)
>
> // <smpl>
> @@
> identifier x;
> @@
> - LIST_HEAD(x);
>   ... when != x
> // </smpl>
>
> Fixes: 31c02e215700 ("IPoIB: Avoid using stale last_send counter when reaping AHs")
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

--6eUvXotnMb6+obQB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcH1g9AAoJEORje4g2clinbiAP/09GK5uVeUsgTo9XjVHeaW++
hsT8BlZjsZp1bLcOXWGNQHqPNtUDdxDiOp5vdnsTN9cayNUmqbWV1+Fd+NIkiXO6
CL308qmZc7Rh+lc9Kzx89P06KQ8naRa98MkC+OK2FwDRCi0iM7kfhhU76SHu5m4a
9Xfrsqq5V5tUdIVIZnaKcKF9cOH9yKQ84GLxhR5KJkTipDvp4rttTTSBDJwr2rGR
vZxME3gSRLN67jpugpYavRNeklUcZ/pVIdlV1PnRhHN1CHAc4oDFj7hCBCJ8eR0D
0kzeTSKOPZn+MpkFZWbM67d3IT8gc2GFML1cdNDCeD8zL0MWW8plkrpojgWlC+re
LAxETG6EdnIV0JFU7X88tK1tcBOHtTixkD1AMONuABATglQoYMAHhZvuhDiVZU4e
3QrkmMjPeWoJW0ZoiGDUcprWJl3qkflHTg3M06q+FuCMOzvvSvJUYEBFd4/Gut+L
S8HUOhcDw/CDHhjorLAwWEkifoSSYEFJvWQEXmn6OjvCd3SLUdjttsZ5ZLVnJlYf
ANM09Uh966ymj3uno+m4qcsFzkX9yYfLFTnhnmPf8ZJoinKdC6ztLd7eo7Aubk1Q
IgkAPX+a0NI0A9urHY1s91AXIcJs9CKQVh5xvemhTTEm4B6yQjJh1jcNRwnZod/x
jSGxgzvyFRWO/kb0vvRa
=hj/d
-----END PGP SIGNATURE-----

--6eUvXotnMb6+obQB--
