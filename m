Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA662C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82AE620685
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82AE620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbeH2UEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 16:04:33 -0400
Received: from shelob.surriel.com ([96.67.55.147]:37510 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbeH2UEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 16:04:33 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fv2zf-0000NW-6V; Wed, 29 Aug 2018 12:06:55 -0400
Message-ID: <9ff9dd41ff99560dcb3eb78f5835da67293f860c.camel@surriel.com>
Subject: Re: [PATCH v2] x86/nmi: Fix some races in NMI uaccess
From:   Rik van Riel <riel@surriel.com>
To:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Nadav Amit <nadav.amit@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Date:   Wed, 29 Aug 2018 12:06:54 -0400
In-Reply-To: <dd956eba16646fd0b15c3c0741269dfd84452dac.1535557289.git.luto@kernel.org>
References: <dd956eba16646fd0b15c3c0741269dfd84452dac.1535557289.git.luto@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-nStG//HEP214a3gQ/inZ"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nStG//HEP214a3gQ/inZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-08-29 at 08:47 -0700, Andy Lutomirski wrote:
> In NMI context, we might be in the middle of context switching or in
> the middle of switch_mm_irqs_off().  In either case, CR3 might not
> match current->mm, which could cause copy_from_user_nmi() and
> friends to read the wrong memory.
>=20
> Fix it by adding a new nmi_uaccess_okay() helper and checking it in
> copy_from_user_nmi() and in __copy_from_user_nmi()'s callers.
>=20
> Cc: stable@vger.kernel.org
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Nadav Amit <nadav.amit@gmail.com>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-nStG//HEP214a3gQ/inZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAluGxJ4ACgkQznnekoTE
3oPRawf9FDAGQGrXHrkWkB7dhuU6VpIDXvowhfrrWtLk2Yt69cm2XZuDetCVCbAE
plSadIuGuaRm4E0IJXlBQNNRpY+kFNYtOzdklt5yEKe0eB4g5+pcQmYuGgBJu+Xh
/si8oPUD52Yp8+J2pmEDdQUlCa3jR7an7LRO4rE7gsg007HZ6YbA4l3FJE31gkWm
XRkDaHZZ15oKxxscycUWiwnWC8zFTYDViHZgjnDlsXuOd3ZpNd61dP+5DscqkPh/
coTdliPzSSq8/N1+mZJbFPLny0ksMiw0YHpunNGdHWNwdSxqpXhW8UKMFLK1QBGB
gSdXff0o3K6tfXO2BPOGIRCO0P2lGg==
=ZCwn
-----END PGP SIGNATURE-----

--=-nStG//HEP214a3gQ/inZ--

