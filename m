Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B813EC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E1EA20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548178982;
	bh=7w5nNfW96UrGImUpHTbVooxyIZkFfUVaOnAnfWrDHDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E/AgrRMogIXomziRU0S5FFrbgRBw07hGvHQiERsFCMiZVBqKaxmpzZJ6TKZuWBg3B
	 AQbXNqgXGTS4W6cXoa07bdwA/hTaZuive2bVcRwW2sUk6dr86EuGaGSB0HFCxkiXPd
	 iW/wLsLHVQ2ByOqvq8h4gCKsKlS4vtxYEZlUgCgc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbfAVRnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:43:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbfAVRnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 12:43:00 -0500
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA52220879;
        Tue, 22 Jan 2019 17:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548178979;
        bh=7w5nNfW96UrGImUpHTbVooxyIZkFfUVaOnAnfWrDHDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u+ZmHTa7aDPzJAx48E1YQ9sCjs3AJmu/5pKLsJ2vBEC1etp4vxtwhlV3rbE3BYNJA
         fW3QBMA0SEprSj+C/BP89i7tBXj8kyYoBbtEBrcu8NiiCfUTywr02eK7G66QLIpAUw
         CuEnhytjRGWopt+j2tzOm6CLpXCoDa2wN6PYBYns=
Date:   Tue, 22 Jan 2019 19:42:54 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 5/8] infiniband: mlx5: no need to check return value of
 debugfs_create functions
Message-ID: <20190122174254.GE3604@mtr-leonro.mtl.com>
References: <20190122151800.15092-1-gregkh@linuxfoundation.org>
 <20190122151800.15092-6-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <20190122151800.15092-6-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 22, 2019 at 04:17:57PM +0100, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: linux-rdma@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/infiniband/hw/mlx5/cong.c    | 15 +++-----
>  drivers/infiniband/hw/mlx5/main.c    |  8 ++---
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  8 +----
>  drivers/infiniband/hw/mlx5/mr.c      | 51 +++++-----------------------
>  4 files changed, 18 insertions(+), 64 deletions(-)
>

Thanks,
Acked-by: Leon Romanovsky <leonro@mellanox.com>

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcR1YeAAoJEORje4g2clinHPAP/A7jQ7mZ7g718Tan+qeF6TDu
s9RE2ISUf3M4c9GDplyR2dB4vSRQYc0HT2uYCEXfBQlLGlwR+Twxgq8SMU9tggXX
rFsvYGAwjEu0AUBWFl3xDht4oeo+yGYeDRKmP7Hn/U4S3VwCBPSUpiHhnQ0Fe+Mt
IvZZMLf1VSHJvqat+xGtGujZ6HbMHWoNCSFUJaR0vtsIONd7zL5vj+39gLwWNc/q
TleLp19nEDTefnrmL4eMAqXcQ7xX789P2SLDPMg3msrQimE1yi65vVPCtzTEiIfK
pH1LAgD1nL/N0YQG2cXAU0ekhh8pIbvWEDVdrFeAwMFfURXiY5JWevxB2vlv9Aei
ErelGBMHYBvA+dc306tqi96rYuLZe7tvNQg9XGpKMv70Mcn8F07jCb8i5C4sOfET
C4VFhivP3imDilBkBOYSlKpnGkwqaFA8nBxCe4Acy2KqX+tuWLGJLKqmrK026rIU
xRCU9mit4mvXss4QscQs3Uhp9XDwe+e0eZMmQkjW4Tn+nX311Zt1CJDrr/sodBR+
s24TPVxqYOXo/eqzTuc3tlVJvap2RLC65uajcS8EWu6+Bge33ea+hqsjfVLTIDG1
nbDYniuZURoIe6oKmblJTwB3YXGfthhk4MtcEUQGMRucEE7vxQbHX/3F6QiYwQIl
6Jq/Eqw2PMqrHVbpS6zL
=cVsM
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
