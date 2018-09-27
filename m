Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5366C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85626215F0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85626215F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbeI0VwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:52:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbeI0VwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:52:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6500D86672;
        Thu, 27 Sep 2018 15:33:26 +0000 (UTC)
Received: from localhost (ovpn-116-35.ams2.redhat.com [10.36.116.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86DFD65328;
        Thu, 27 Sep 2018 15:33:22 +0000 (UTC)
Date:   Thu, 27 Sep 2018 16:33:21 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH net V2] vhost-vsock: fix use after free
Message-ID: <20180927153321.GB10133@stefanha-x1.localdomain>
References: <20180927122204.4188-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <20180927122204.4188-1-jasowang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 27 Sep 2018 15:33:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 27, 2018 at 08:22:04PM +0800, Jason Wang wrote:
> The access of vsock is not protected by vhost_vsock_lock. This may
> lead to use after free since vhost_vsock_dev_release() may free the
> pointer at the same time.
>=20
> Fix this by holding the lock during the access.
>=20
> Reported-by: syzbot+e3e074963495f92a89ed@syzkaller.appspotmail.com
> Fixes: 16320f363ae1 ("vhost-vsock: add pkt cancel capability")
> Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> - V2: fix typos
> - The patch is needed for -stable.
> ---
>  drivers/vhost/vsock.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)

Thank you, Jason!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbrPhBAAoJEJykq7OBq3PI4+YH/iTCwaaWk6eiQLX6SQFLM1S5
dtkS+0+ja7FhmKnTwHQYN+tB025xfmFwtDhSEb+F582co7ggqflOhNUdh3t8Ehel
SNkeDGEeolpB1IX5evuvbnZuFpAjPhMqBIUqnoxIoJNAyYo6fMbQkdfyBXnqDsnH
c5oS9yz5OvUzu4IhR/KYqKtljwZNUcniitMKYNN1+LpH7g0QzLpeAs3FADVtoNUB
HEAFFhvOa7k+7EFJfw7FgccC5zWsDSVyoVtdxtFK2BPujrW3JfFLRWKQgrUKhY2u
TKVp0htYP4qG2YXbBPjbbC8OUrILllvtxENF2mgZZXvDE3lIZw9Vl8b5+WVVrlo=
=wXAN
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
