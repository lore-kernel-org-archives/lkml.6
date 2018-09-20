Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C412C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 05:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F188C21525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 05:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWin/dgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F188C21525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731413AbeITKpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 06:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:56922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbeITKpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 06:45:23 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F1D721522;
        Thu, 20 Sep 2018 05:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537419833;
        bh=VC4P/+2+3yftX7K9YNrzlx+Rxaej6O0R5LSTRGb6U84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oWin/dgWogDUkjoDoHNMUDcsB6QK5JMKbQUhT5uxwaDT7KkhzSlOxygasAY8vB8WE
         UIuyvRwgbk7lldpXHVTSyRK0pY986EOQCJdRKg789HNAztRXrZ/Ubcp+cobOjYPCJH
         YMxbcnRfg89sGBuqst2bjhLvTv6iVIFWVk+bls4c=
Date:   Thu, 20 Sep 2018 08:03:50 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] IB/mlx4: Remove unnecessary parentheses
Message-ID: <20180920050350.GE3519@mtr-leonro.mtl.com>
References: <20180920033229.15102-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SNIs70sCzqvszXB4"
Content-Disposition: inline
In-Reply-To: <20180920033229.15102-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SNIs70sCzqvszXB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 19, 2018 at 08:32:29PM -0700, Nathan Chancellor wrote:
> Clang warns when more than one set of parentheses are used in single
> conditional statements.
>
> drivers/infiniband/hw/mlx4/mcg.c:676:16: warning: equality comparison
> with extraneous parentheses [-Wparentheses-equality]
>                         if ((method == IB_MGMT_METHOD_GET_RESP)) {
>                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/infiniband/hw/mlx4/mcg.c:676:16: note: remove extraneous
> parentheses around the comparison to silence this warning
>                         if ((method == IB_MGMT_METHOD_GET_RESP)) {
>                             ~       ^                         ~
> drivers/infiniband/hw/mlx4/mcg.c:676:16: note: use '=' to turn this
> equality comparison into an assignment
>                         if ((method == IB_MGMT_METHOD_GET_RESP)) {
>                                     ^~
>                                     =
>
> Remove the unnecessary parentheses to silence this warning.
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/infiniband/hw/mlx4/mcg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

--SNIs70sCzqvszXB4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJboyo2AAoJEORje4g2clincQcQAMWuB2aiHb6PR7iy05Iz6o2F
mtp9JQVFHHuQSfgV1oLHLQWAklD8QjFBhOM+T1dAF5dMdeYMK0EMWocn6uSYSMJF
vUpzYe7qV7ImLrBhTI2zUGMbZRyDOpLnReT4fFZ32by74ABYJvUd3LjId+GclEdC
h2sQfi1DsqMM5U/IoQ/aDL9k+cB9DasJegsaEEXcPg8x1SaYwvHX5zN7CzqgGXxJ
Lx06c5A2/xJR3MWFs8Bts49f5zZV82+jw+JjU+4gsd93awvxw1KnY7LUG8ydf901
pCKfxGbf7cNxm9XTUk4KFjRYm7o1s4O7zQl+Ii3WtP/oJSAdISHk1CeihT0tDAnO
XXfaQ2IY9HmMWeKJq19mPz9KVXgI4htXzCDED86VoaNRlanXVZVYV2XVFEKX0UnB
xp9DsPHK93N+nnXUnh7a1gM6kfCk5GYi1rBFjJ415+1ppzCWIu2sabaV1Nc2WavS
nUFJSq2voi7i6Yj8BlqVnpUMS+HLIB3KaqiCBcecilNuOxn2oVpmeutZCRGhAGUn
DKmp6trJrmvhAKd1kWA1lAHJ5mpyv8UIS/QZaRuZRMoxZjY5zfT7t7XmsMiLJQ1U
FgBZIBTr49ntNanyhzhg+XesIajVTSzKdCyXmgKJpiawzkJbIgH7z1CPiyiB2tWh
KpSojCk+qHeyv61j7fLY
=8ZPj
-----END PGP SIGNATURE-----

--SNIs70sCzqvszXB4--
