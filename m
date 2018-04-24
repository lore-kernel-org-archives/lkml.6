Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752980AbeDXRgU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 13:36:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751492AbeDXRgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 13:36:15 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE3E21735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=leon@kernel.org
Date: Tue, 24 Apr 2018 20:36:12 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org, Faisal Latif <faisal.latif@intel.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] IB/nes: fix nes_netdev_start_xmit()'s return type
Message-ID: <20180424173612.GI24820@mtr-leonro.local>
References: <20180424131545.2810-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f5QefDQHtn8hx44O"
Content-Disposition: inline
In-Reply-To: <20180424131545.2810-1-luc.vanoostenryck@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f5QefDQHtn8hx44O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 24, 2018 at 03:15:45PM +0200, Luc Van Oostenryck wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, but the implementation in this
> driver returns an 'int'.
>
> Fix this by returning 'netdev_tx_t' in this driver too.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  drivers/infiniband/hw/nes/nes_nic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

ipoib_start_xmit() needs the same fix.

Thanks.

--f5QefDQHtn8hx44O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkhr/r4Op1/04yqaB5GN7iDZyWKcFAlrfawsACgkQ5GN7iDZy
WKfbUhAAhOvypJ95u/rDjVkRH752kVdNPdDMojU0DjVznGZe5U1tzvAriR5FPSq1
s5O5dCoC9Z4E4Q1/jiG6z1QTX5V9faxdB/F6StUhPjD8dznYplIxWrFv+YqZOyzo
YzMYrQgv+i4Rw8+39BWKVchW8uLz5PxtlOjtzB0JFBLy1BcMG6X1D5r4faI567Qc
moB3aeP4wqFXKX6sI7HfPjjWlyzXrkUQG1s9Yzl5fspQCRnpR6ZcF7UMT7FEqvHp
OChr6Mo/b/LanjYacKgz/oQ2IR7WQe73xRrszHizI0f1nNnJ9GcEsMb/+AHZ3VDO
t107BCDJ5r2GXfTv7OrivKe0GlO7rITFFbfGO/+0TT1Rflg2Xq66g4lBfb2N7dNP
u2R6ti9lDXYy5VdSyeQdkzpdb8L2QKkqLyxK+hFX9S/JH8FAAQYJxeePw710PqgA
/NVo58pcnx1fIVycLuZ4wV1CPOgofn9p3LsLZRl05cGkQu42dU6ScS897WoYuUju
Zv4k90ezHaNX1jsQZhTLB6jzqXDMuFmHpI9TsxsUN/0/P1g5dkxdWGv8YH6kq8ed
w5xMGaDSGHEniuW06LC41wtcgjXH80J5P9zaWJZYHfP2CF+LPI0AWVXRo8UUaaYI
F+hclUwuTHDFkSzhv+tKR4PO1h7Lv6mcXoI1ZfeU8P7a67fmU9k=
=2qAd
-----END PGP SIGNATURE-----

--f5QefDQHtn8hx44O--
