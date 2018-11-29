Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB7BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2DA20832
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2DA20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeK2M6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:58:16 -0500
Received: from shelob.surriel.com ([96.67.55.147]:49648 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbeK2M6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 07:58:16 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <riel@shelob.surriel.com>)
        id 1gSBXI-0008U1-EQ; Wed, 28 Nov 2018 20:54:36 -0500
Message-ID: <acc97851fe8f8d46a684e7b6255eded48cce29b7.camel@surriel.com>
Subject: Re: [PATCH 05/29] x86/fpu: add might_fault() to user_insn()
From:   Rik van Riel <riel@surriel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Date:   Wed, 28 Nov 2018 20:54:36 -0500
In-Reply-To: <20181128222035.2996-6-bigeasy@linutronix.de>
References: <20181128222035.2996-1-bigeasy@linutronix.de>
         <20181128222035.2996-6-bigeasy@linutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-5lsNr2pVguhcsEL3ExOw"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5lsNr2pVguhcsEL3ExOw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-11-28 at 23:20 +0100, Sebastian Andrzej Siewior wrote:
> Every user of user_insn() passes an user memory pointer to this
> macro.
>=20
> Add might_fault() to user_insn() so we can spot users which are using
> this macro in sections where page faulting is not allowed.

Nice catch.

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-5lsNr2pVguhcsEL3ExOw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlv/RtwACgkQznnekoTE
3oNEGAgAvdamUHqGVBDgH/3XH31RSfjNytZjvtvag4usnH4ry7YksXywIzSAINNO
0bXIeYVH5Cwn/HNUK78V6KjWcg2ZGrrcw7fTH1/zljyibW2h7ssw0/bpjRewbrch
RZmoEDOObObzy6yxsPxLvxFZtPjEPTB7HZnRAa5lnJAhJreBbXtHT0QP/aS1T1CU
rIzfYIYA69+VK+Z4LcH8nTpD3idMRG3eIAPFOf8ANuOiVOTBORiwYRGCPnuEkV2B
cuH2+ow0SkY2wWPD1R2ONQv+hcFw/Yn3vChBlkhCexmIcdE+Kp2X5sZn8s0sgVsR
cAv01HSseUfDA4dJx6qg2vs6yzuqAA==
=C54D
-----END PGP SIGNATURE-----

--=-5lsNr2pVguhcsEL3ExOw--

