Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633FDC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24591214E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24591214E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933438AbeFUQHk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 12:07:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39926 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932858AbeFUQHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 12:07:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A40D881663C3;
        Thu, 21 Jun 2018 16:07:38 +0000 (UTC)
Received: from localhost (ovpn-116-75.ams2.redhat.com [10.36.116.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21EBA11166E1;
        Thu, 21 Jun 2018 16:07:37 +0000 (UTC)
Date:   Thu, 21 Jun 2018 17:07:37 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc:     davem@davemloft.net, jhansen@vmware.com, cavery@redhat.com,
        borntraeger@de.ibm.com, fiuczy@linux.ibm.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1 1/1] VSOCK: fix loopback on big-endian systems
Message-ID: <20180621160737.GB7460@stefanha-x1.localdomain>
References: <1529502711-8028-1-git-send-email-imbrenda@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline
In-Reply-To: <1529502711-8028-1-git-send-email-imbrenda@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 21 Jun 2018 16:07:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 21 Jun 2018 16:07:38 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'stefanha@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 20, 2018 at 03:51:51PM +0200, Claudio Imbrenda wrote:
> The dst_cid and src_cid are 64 bits, therefore 64 bit accessors should be
> used, and in fact in virtio_transport_common.c only 64 bit accessors are
> used. Using 32 bit accessors for 64 bit values breaks big endian systems.
>=20
> This patch fixes a wrong use of le32_to_cpu in virtio_transport_send_pkt.
>=20
> Fixes: b9116823189e85ccf384 ("VSOCK: add loopback to virtio_transport")
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> ---
>  net/vmw_vsock/virtio_transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbK81JAAoJEJykq7OBq3PI0jIIAJy5eUCfQZQyGX30y2ZNcF30
RrAhXeCm5sQ72UVotBgIeloRPNtzpN0tbXPQIBl+YNDDY1l+ZXACQ395DMHhLsGs
kgJJLcIDJVsojBlblxo1ZdVO4ZfvpSlN3gaM4HOqrYsb+Hwl+qJPP0fyB+duesRA
rctwL6BjMF/VG+32yt418kwf1sf2jD0wDfrPRIUYah00JIjvV2SXCeJBQTsDZNyz
poAuTEM2m5Pt6iNDC4+mcmJsMdwqNSIUs1xO29MGHNNEJyHi1zj5+KbKxBOPDlVS
sosICssaxkVPZU5Z9Ymw+GTBUo0PD8n1VgHSbYAX3P4X3xlKDJ+QuFTIPLBUdKE=
=/OTE
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
