Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060EBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15B520838
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392579AbfBOJZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:25:04 -0500
Received: from sauhun.de ([88.99.104.3]:60584 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388428AbfBOJZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:25:03 -0500
Received: from localhost (unknown [83.221.228.209])
        by pokefinder.org (Postfix) with ESMTPSA id 36CCC2E3551;
        Fri, 15 Feb 2019 10:25:01 +0100 (CET)
Date:   Fri, 15 Feb 2019 10:25:00 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jun Gao <jun.gao@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>, linux-i2c@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: mediatek: modify threshold passed to
 i2c_get_dma_safe_msg_buf()
Message-ID: <20190215092500.6q3hqnoufyowiqaz@ninjato>
References: <20190215090202.157100-1-hsinyi@chromium.org>
 <20190215090959.soxkf3ho3or2geme@ninjato>
 <CAJMQK-jrpnfzKNYh01Pg6QydSSa-=6x44Pj1wwMdXw7G3x-ybA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y2t44ovekq3k3td5"
Content-Disposition: inline
In-Reply-To: <CAJMQK-jrpnfzKNYh01Pg6QydSSa-=6x44Pj1wwMdXw7G3x-ybA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y2t44ovekq3k3td5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 15, 2019 at 05:17:27PM +0800, Hsin-Yi Wang wrote:
> Ok, I can add a check in another patch. Should we return NULL pointer
> if msg->len is 0 or print out some warnings? Thanks.

No warning, msg->len == 0 is a valid setting. But interesting question:
I was about to say NULL, but your driver would assume ENOMEM there and
discard the message which is also not correct since msg->len == 0 is a
valid setting. So, should we just return msg->buf then? Will this work
with your driver? Can it handle zero-length transfers?

> On Fri, Feb 15, 2019 at 5:10 PM Wolfram Sang <wsa@the-dreams.de> wrote:
> >
> > On Fri, Feb 15, 2019 at 05:02:02PM +0800, Hsin-Yi Wang wrote:
> > > i2c_get_dma_safe_msg_buf() allocates space based on msg->len. If threshold is
> > > 0 and msg->len is also 0, function makes zero-length allocation, which returns
> > > a special ZERO_SIZE_PTR instead of a NULL pointer, and this will cause later
> > > code to fail. Modify the threshold to > 0 so the function returns NULL pointer.
> > >
> > > Fixes: fc66b39fe36a ("i2c: mediatek: Use DMA safe buffers for i2c transactions")
> > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> >
> > Right. But we need to fix i2c_get_dma_safe_msg_buf(), so it will be
> > handled for all callers. Do you want to add a check if msg->len is 0 or
> > shall I? Both fine for me.
> >

--y2t44ovekq3k3td5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxmhWwACgkQFA3kzBSg
KbaFFQ//fuSyJ7pBnGx4oHNrTC5YHyX1SDtwZyZqo5kDgB7MNJ5yOR3Gd2jTCx8j
IzJEQlO6bVPUCJSgdZTvWjfOdbbkLyakIhbMYoDOTPl+JV73M1GU0bppG7oggqTV
T/DbHUvQ5YlshB/eENAJtbVJjGu7rjmd2Ttbm4PSUl5Y1zyiT0JLAMEEvDfW8UxY
cOMY8u8bHZtbDxkMRQ73L2h7C0XFb7TdoxmdYmbNvFBmczHAzznvgrHtxGmTg2R2
ThO7WNRTzABSeudmLeZhKTIum4hvwp3ghyBsRos8kiBpSmDz/0vRcBvqG+4ZThuO
GbqQTyK+Lln4Q7zkPdCSb1GWO6IGGFysXUAIewTRmr2yWgP5zkAtaZkbDkDdz1aW
6EUlgfWg//3BXQimXWpMwZ/sOij8IJ2XBsIytssuO6pJon+q3/sspY+QBnOWFsiJ
UhcW12LdEXZW7Nvi+BxRYfRlSy3TxOb5Z2sGYsOMZ0P8SGyQxFFiUQ6ks99hr0hf
Clv3SBpRv7Kua4LmziFL/PtNnNkr/9Z9j/sdk8hfh2Zzlx0D1+k8sWvWN2KjYxa1
ZKDVf3RzdKWPbw0nloni4/6aQ9/+sohzz6Ov09l0Gvu6exQIF5XAmCw/Gh6WjyiV
UzARwXWjLRkPuGDRFEIe7WgmwlcaF0NMC8zwttf8FavI4eNdOxQ=
=eOq9
-----END PGP SIGNATURE-----

--y2t44ovekq3k3td5--
