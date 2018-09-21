Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6725AC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE0421547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GKDaSNZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE0421547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389283AbeIUOIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 10:08:49 -0400
Received: from ozlabs.org ([203.11.71.1]:34605 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388909AbeIUOIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 10:08:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Gml11Js6z9sBJ;
        Fri, 21 Sep 2018 18:21:00 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537518061;
        bh=Tw+nq9m/tEgrJTGDY5mCl4EpRAjZ3gJ3Fur1WXaRbyA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GKDaSNZtSjsTZWD6f54BGeIynmyPHi3cfWt325uxPuUXYzkdnpPaE7PY7sLfq8T5R
         s0SjvQ9+c5i7bcPjwkHZdHo+CIuMfhPWcUpkKUN425FuLJY55o9PYrUXZcQDNmqIie
         UO94TtUk3pzN564uc/gGr57GzHtG80ofUQimDdknCQrh1rXH69btofht/6BvprjygO
         9PKTy5BxLTD+CbnRWGoPpM8xkgAkfK/Nagl25wF5nEXekOYbv786Yqi2xHrW+Mw0H9
         Tttv6hV/YthsSbLOKVcIUn0FExgcTn5QeXSMc32BufgnYrudUuNf5aJM9BzKNXpGpc
         z8LS8SuSuF7Vg==
Date:   Fri, 21 Sep 2018 18:20:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [REVIEW][PATCH 1/9] signal/powerpc: Use force_sig_mceerr as
 appropriate
Message-ID: <20180921182016.45039844@canb.auug.org.au>
In-Reply-To: <20180918175850.4437-1-ebiederm@xmission.com>
References: <878t3yitze.fsf@xmission.com>
        <20180918175850.4437-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/hFzliqTZXG32fC_.thNh2X2"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hFzliqTZXG32fC_.thNh2X2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, 18 Sep 2018 19:58:42 +0200 "Eric W. Biederman" <ebiederm@xmission.c=
om> wrote:
>
> In do_sigbus isolate the mceerr signaling code and call
> force_sig_mceerr instead of falling through to the force_sig_info that
> works for all of the other signals.
>=20
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Looks good to me.  I was going to mention further cleanup, but I see
you do that in a later patch.

Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell

--Sig_/hFzliqTZXG32fC_.thNh2X2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlukqcEACgkQAVBC80lX
0GzsOAf9FbPsGUfwnqkVUOxlUsK16JCBbL0AaAeq1SnTh0/e/N81AmfhDql5BEzx
67TeRWxlO1dRUBa4LcMQDMCR/73vskgBgamUiwW3+3Im6gBpCFZLjtXbsVOdtzrH
be/TNU+tCitFphIwFJRXGLS29bLqdKHHpbCaNXdQ6ndA9tiXgp7k6EdsCRvLddpj
JJRVMaDtn61fJrazuuU6kzLU+XQuPhWU/Vk2VM6n9HaYfojys6iJcb6VA2tGO6BS
Zn/+5AKDloz2TXHD5hPyk3t3uTxZ/gIfXEi67TqvqcIz6nTeM2mvejPH02PPQFqg
r389zGrHSMpokgtlwKIwO2UEqL0sAQ==
=hAFB
-----END PGP SIGNATURE-----

--Sig_/hFzliqTZXG32fC_.thNh2X2--
