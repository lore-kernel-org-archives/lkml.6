Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D3AECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E0820837
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E0820837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbeGQTOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 15:14:04 -0400
Received: from anholt.net ([50.246.234.109]:46716 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729717AbeGQTOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 15:14:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id D778F10A18B0;
        Tue, 17 Jul 2018 11:40:09 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id HK35PBbdt-9v; Tue, 17 Jul 2018 11:40:08 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id B110510A0353;
        Tue, 17 Jul 2018 11:40:08 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 224E02FE2D94; Tue, 17 Jul 2018 11:40:08 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH v2] drm/pl111: Use 64-bit arithmetic instead of 32-bit
In-Reply-To: <20180704142255.GA8614@embeddedor.com>
References: <20180704142255.GA8614@embeddedor.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Tue, 17 Jul 2018 11:40:07 -0700
Message-ID: <87d0vlg0zc.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

"Gustavo A. R. Silva" <gustavo@embeddedor.com> writes:

> Add suffix ULL to constant 1000 in order to give the compiler complete
> information about the proper arithmetic to use.
>
> Notice that such constant is used in a context that expects an
> expression of type u64 (64 bits, unsigned) and the following
> expression is currently being evaluated using 32-bit arithmetic:
>
> mode->clock * 1000
>
> Addresses-Coverity-ID: 1466139 ("Unintentional integer overflow")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

This is silly.  The clock won't be over 4ghz -- we haven't seen anything
over 1024x768 on this hardware as far as I know.  The u64 is for the
multiplication by width/height below.

I've still applied the patch to shut up the tool.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAltOOAcACgkQtdYpNtH8
nuiPjQ/9GimicpQZHzxGqUb41WrnQN59Y4/uFX0Ux3CWKY33rzOh/vfIL3WxW6hn
moso2oYRMGrLs2ZLZXVVtiiUPYNP71oXPDPGIuXN9Ur4gPoGCzPUSjHmQ6fBYbuk
QGFNq4J1OG9e8p7nhT22DMTctC6Fwdrf4tMFcqqBbam1kQHR2k/6yWLgOmlwr173
O9RQtQJVwtPo75Qs5hWdUG6NFcTiEhWuDV/gEWhMNZ1VwtVt01ztOVJCgiPOqlbe
q0Fgz/7ttkxIWHTqkFpP1FIzRQOmPYuFsBY+KotjROt42KjVelCMMsjI1ZgNQtcU
0nFUrKxuA3leRQ5xEIyT9rleyzXPJ+knumyyd7biC+/3nIKXM2yfOeubtwh2TY7J
nSo+tlak8B11A2GCo9tX0I//sUTTICZyMnNAGZsjwnT1KRvr5EILJaI/k8pW73BK
D++5MdZsdDj11k5Ffo50e53qriqqbBZHPiylXxVis44kUEKuvLcJAEBvkII5zlL0
rM4n18dZv0wrSZFo++IQ3803N6PZoSeJupH9A3CM3ylUUS7kN1OEo46Mwhejq2s+
8EAdxokJpOjBytmdxvES/0WSOrwdPOyDS+OWsvamUayigv+JtEElejXSdlDUhkfO
j7deKGW5aHMSzuyAcZmQrvA5dqtX0VUgCflq+75FGC0Vjrqb03w=
=njA4
-----END PGP SIGNATURE-----
--=-=-=--
