Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D32DC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A4C2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A4C2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbeLKMbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:31:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:53254 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726135AbeLKMbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:31:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2875CAE3C;
        Tue, 11 Dec 2018 12:31:00 +0000 (UTC)
Message-ID: <64c0fef108dc3bdb137c84714644d770f2008ac5.camel@suse.de>
Subject: Re: [PATCH] staging: vchiq: rework remove_event handling
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tara Null <tn@fastmail.net>, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 11 Dec 2018 13:30:55 +0100
In-Reply-To: <20181211100728.GC3116@kadam>
References: <20181210211231.4084251-1-arnd@arndb.de>
         <20181211100728.GC3116@kadam>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-6Xl5zNzwmyTPg82Yk6D2"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6Xl5zNzwmyTPg82Yk6D2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-12-11 at 13:07 +0300, Dan Carpenter wrote:
> On Mon, Dec 10, 2018 at 10:11:58PM +0100, Arnd Bergmann wrote:
> > Note that I'm changing it back to 'killable' after the previous
> > patch
> > changed 'killable' to 'interruptible', apparently based on a
> > misunderstanding
> > of the subtle down_interruptible() macro override in
> > vchiq_killable.h.
>=20
> Oh wow...  The non standard down_interruptible() macro is ugly.
>=20

Same reaction here, *_*. I wasn't even aware of it.

Arnd, as long as it you're not doing it already. I'll prepare some
extra fixes for the rest of completions and get rid of that file
altogether.

Regards,
Nicolas

--=-6Xl5zNzwmyTPg82Yk6D2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlwPrf8ACgkQlfZmHno8
x/70jggAmDlmYkQniQi3bwL3vGHNBDfc5O2Q4qXDuDXUF+Hiaaq2Qdft0V0T7YTE
1/Ex5iP+rk+Rqc3/1XObOtmdwwrrZZ7IWn4VjsLd06f8f/EyWBxghwA4edgrmW18
+AB/ZGnfd7qdAnty+OzTACEN1IZQSRN3vkwGt99uAgH+AtERPKiQbM67Ma6tiH+i
HOuWG+Ge6lDMeE9lSC5yK9sLHAzZu0rRpDddWYpJMmscmG9AOIKFcJsz6ifbt6cM
6GUaJMX33QlI/yZk2pXcFBKqk8IrsLgwmGkVRSaJvC7WNBKFXv8944G70q/1kxfD
6Ls4YS+R9QE99KJqjSdXSHJETV72kw==
=oAA/
-----END PGP SIGNATURE-----

--=-6Xl5zNzwmyTPg82Yk6D2--

