Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE1DC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653062192C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404212AbfBOJKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:10:04 -0500
Received: from sauhun.de ([88.99.104.3]:60384 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388927AbfBOJKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:10:01 -0500
Received: from localhost (unknown [83.221.228.209])
        by pokefinder.org (Postfix) with ESMTPSA id 310A02E3551;
        Fri, 15 Feb 2019 10:10:00 +0100 (CET)
Date:   Fri, 15 Feb 2019 10:09:59 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jun Gao <jun.gao@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>, linux-i2c@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: mediatek: modify threshold passed to
 i2c_get_dma_safe_msg_buf()
Message-ID: <20190215090959.soxkf3ho3or2geme@ninjato>
References: <20190215090202.157100-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z7e24ofik27zxdzz"
Content-Disposition: inline
In-Reply-To: <20190215090202.157100-1-hsinyi@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z7e24ofik27zxdzz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 05:02:02PM +0800, Hsin-Yi Wang wrote:
> i2c_get_dma_safe_msg_buf() allocates space based on msg->len. If threshol=
d is
> 0 and msg->len is also 0, function makes zero-length allocation, which re=
turns
> a special ZERO_SIZE_PTR instead of a NULL pointer, and this will cause la=
ter
> code to fail. Modify the threshold to > 0 so the function returns NULL po=
inter.
>=20
> Fixes: fc66b39fe36a ("i2c: mediatek: Use DMA safe buffers for i2c transac=
tions")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Right. But we need to fix i2c_get_dma_safe_msg_buf(), so it will be
handled for all callers. Do you want to add a check if msg->len is 0 or
shall I? Both fine for me.


--z7e24ofik27zxdzz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxmgecACgkQFA3kzBSg
KbbmfBAAqYW+JvwMtjirjdXC3UPcneALX9Iw2pOiZ2zmKVFJp27osp1IkQyxPDgW
WvJ1+0O2l2+YLM1HMxhQKZVSsULwUD8CaltGxlKypNQZa/ka8kWOffsOUODldueC
bqddzNomrk5OCmkywbbcAq4iVcxfLRffnrjqtP+CXHqxi5OIG5cNclI5u5zjnuOY
rEg7fu2p9p0wXS6fSfEW0iK84XKfbAkcyxJLryEx8o5QDAvow99wmFjJ3x9deKFf
UNcoRYUgyZK+DXQF0SUr1EuEOStuXC8yoKncyuYD7rfRIMQBU0Q/YDy3TnWj5Fa3
AI07nksJ+Swqzu3hn158vKvqMRkX9n+C6BSBgajGE/mAMffIHXuDTfxpNOkDDqri
FaVtITfGcp/s3aLCu8vFoyuyK05LV0xt7RGqMt4mglFU/dMXvRkKEyDmLx3ASdIl
7S2fO8ldd5DPTAKnpBJnEhxD1x2YdPqn0o8lMYMXPkIk1+6tFakXB7ACBJ4b5oJf
CBUzj/2aYGJ9RH5AEW+BVXnTrKwBTs885zmZkgHM/FxgusV6t1srPXImocRVvyQC
KtGiVLYW34c3x72ONu/09kPocbRJubyWUsCntSDWfIBuRkcQXmfbroNRq2SEFlGA
hy18Oc7VKRxSqrRs8V4ibmcpEY7BcMydmFC4aelBei3mCz1nHms=
=Jioo
-----END PGP SIGNATURE-----

--z7e24ofik27zxdzz--
