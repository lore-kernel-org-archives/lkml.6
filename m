Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A0EC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296D021A28
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296D021A28
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbeHHXTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:19:19 -0400
Received: from sauhun.de ([88.99.104.3]:38402 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727530AbeHHXTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:19:18 -0400
Received: from localhost (p54B334CC.dip0.t-ipconnect.de [84.179.52.204])
        by pokefinder.org (Postfix) with ESMTPSA id 5B1D06DC54D;
        Wed,  8 Aug 2018 22:57:53 +0200 (CEST)
Date:   Wed, 8 Aug 2018 22:57:53 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Jun Gao <jun.gao@mediatek.com>
Cc:     srv_heupstream@mediatek.com, devicetree@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 2/3] i2c: Add helper to ease DMA handling
Message-ID: <20180808205752.llowh4bvu2wkuhga@ninjato>
References: <1530955795-17714-1-git-send-email-jun.gao@mediatek.com>
 <1530955795-17714-3-git-send-email-jun.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rp4jubaesdmneqdp"
Content-Disposition: inline
In-Reply-To: <1530955795-17714-3-git-send-email-jun.gao@mediatek.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rp4jubaesdmneqdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 07, 2018 at 05:29:54PM +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
>=20
> This function is needed by i2c_get_dma_safe_msg_buf() potentially.
> It is used to free DMA safe buffer when DMA operation fails.
>=20
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>

Right, we need something like this. This leaks in the sh_mobile driver,
too :(

I am still thinking if there is a nice way to put this functionality
into i2c_release_dma_safe_msg_buf() itself somehow...

Thanks!


--rp4jubaesdmneqdp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltrWUwACgkQFA3kzBSg
Kba6Tw/+Iimt7Umis4CVLfglXlJM8cOcQwzHzSmtfK88GLGEPybXuZuk6hJ+2G1m
p964DyDxJy+DCrdA7jIU64RdFOuf62+nZVRS0xt50Ycl+OhayWr9FL5teoFZ+uSn
EKU5MnhgnO0MPG05JciJGS7SM5hFbT86n70ktre589BT8g7QnV7sO1BVi5LDoyPL
9zCSYFCYZZ/+gfP2oMtSJT8LkHgSEYz9JXCWmANs/HhWepbtemQRJ5rvPens7yCa
xq/OkH7NoIJ9Ipewv/J6RJJsZBw7bXPnfp4WaHIvZog0WZHYJkSbQk5DDNgIYu3T
Z1lRM8P1eWn2dhYSPrjv8k+FFFX1O5rM2uCkATDZierjJSa4wgYVanizY7TP28km
dfXlL/Vb92KZICGQBBG3gbe3ueWoNxUmSljMn7rUKPybJ+P1MYZHk6TF/momdpDx
SLKwhU9PaKy/9dukiU8L+vWcgw69ic7RHbKV84EwxhjDX6XhexPI2H4L+uOfyJZo
UplbqRhIOXk1h5tbk1m6NJAVlFFSGcWNvdR28+CQl9LBBnOWR6vWYspYrERLrXlu
+rISW9VO/G5F0CZfZ0Eka335h8c1f5ybq84pWk1nPRn8RmSmn+hgWiHEdzZJV632
4WmPNIK4ZcTX85fahz06Z+RRk6Mn60mQZzjzzgDr9Q+PimU+e08=
=9FC3
-----END PGP SIGNATURE-----

--rp4jubaesdmneqdp--
