Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3718C41535
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 00:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C2120BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 00:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="F9gi79gL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C2120BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbeHWDrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 23:47:14 -0400
Received: from ozlabs.org ([203.11.71.1]:34239 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbeHWDrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 23:47:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41wlRc53l5z9s3Z;
        Thu, 23 Aug 2018 10:20:12 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534983612;
        bh=kqyvbC6NIffenx9nLX/6LmV00S9ZyPdSaQW5pVNU2O4=;
        h=Date:From:To:Cc:Subject:From;
        b=F9gi79gLDzARSwBgaixtoqbBgMoStPpXbwC1dBXUu6eZiIqPsR3/ymCr4756C0xGa
         X9faJeB3/NK+shv5T5IIQAhuh8OeU51nlhTiXA3nkj3bzkdg7zktMrBGkEemNxtYji
         nIk5Ms958zGJf4s9ejTqRpVNSnFu4c+ENuMtakr8e2u9U+PkNj2OqUAAXXhTNGOznv
         3cxDYvvqNGZt21UCig/UD+SCmJFLSKSewHeIJHWVbStvm7HLd2Sj/HqyMeiSIid9tX
         8TUjtCHH+pqoaGRAj7wxNioEPc9sAiIHSP8etZmF9mNEhuPSQ5sj2c5rko9Mwi+uWt
         euTzZ2M9G8p8w==
Date:   Thu, 23 Aug 2018 10:20:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the apparmor tree
Message-ID: <20180823102012.0c7cbe1c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ne3jaP9jZKMvco7v7M/_dyG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ne3jaP9jZKMvco7v7M/_dyG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi John,

After merging the apparmor tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

security/apparmor/policy_unpack.c: In function 'unpack_dfa':
security/apparmor/policy_unpack.c:426:1: warning: label 'fail' defined but =
not used [-Wunused-label]
 fail:
 ^~~~

Introduced by commit

  fb5841091f28 ("apparmor: remove no-op permission check in policy_unpack")

--=20
Cheers,
Stephen Rothwell

--Sig_/ne3jaP9jZKMvco7v7M/_dyG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt9/bwACgkQAVBC80lX
0GxBPwf/cHb/E+iZ6IeOU9O64Y/SExKCaGLlsOAp/7K2wbsiVmRdkeyBG9mO1Qlt
GVEt50EmvREmYdiJkJ1wojfPC3+ML/ScehG/meMqLKoY1AV2r4oNRGdJc2U/RzHs
c9C4qBBlltjVRw53tJFLDzivc1wBqkYN113s76kuu5TTC2xY+vChg21DvjxHKbhK
NBsGdXmKZRHr5avAdm6KXdda5kLbhIfMgq1/IH7vNLo3NsyQClFGrf+5Qa1jXKIu
Ho3WNcBQswY9q8wi7q/BnFAeZs9w/qdwZGMdTfwUCe5EadZgXsWXr6XMOL9Ng49n
OMF4Qd2HHPyep/jp0iVlKyW8YlsTJg==
=3qEc
-----END PGP SIGNATURE-----

--Sig_/ne3jaP9jZKMvco7v7M/_dyG--
