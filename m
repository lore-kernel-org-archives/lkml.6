Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49601C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 05:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7782084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 05:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bH0DpjCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7782084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeJEM2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 08:28:14 -0400
Received: from ozlabs.org ([203.11.71.1]:48977 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727179AbeJEM2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 08:28:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42RJJW3xKMz9s4s;
        Fri,  5 Oct 2018 15:31:07 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538717468;
        bh=chsItYXeprhNubUbIyz52WftjOFtVXJMNL9Jxz1+KdQ=;
        h=Date:From:To:Cc:Subject:From;
        b=bH0DpjChdx3i6BMkNVEeAV5NgzThWEBiOr3x3w/gsS4rBmQ44X49kduZF9sR0UwmW
         I+1wDlMrYcqRQR+K0du7CYSBrFPQrXgIP1vzdeNotRGY/c/3a9NoRCbNqPhG5WBFBy
         HPIH84CBkVu4PUBRWxx3+L+g8gHKLn4Zm09R7HVGGxx/12QXB64g1I9aPtPbiAS4iJ
         aq7ofzCPbdBDgar5LGtFIFn093/RgjYZNNKhASdWvlMXDZ6B4vbKrWOx3tY/07dEUh
         I8v/YvlYLb5XXGRM+vzkq3TKDdMEXyl0CEZW+YqPx/vuMVykoM48LtSXMlc4zcoekT
         36aZkx/qjhTEA==
Date:   Fri, 5 Oct 2018 15:31:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Srikanth Jampala <Jampala.Srikanth@cavium.com>
Subject: linux-next: build warning after merge of the crypto tree
Message-ID: <20181005153107.26147ecc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zOMbtx6=kRGT5fGq.h/g2LE"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zOMbtx6=kRGT5fGq.h/g2LE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Herbert,

After merging the crypto tree, today's linux-next build (powerpc
allyesconfig) produced this warning:

drivers/crypto/cavium/nitrox/nitrox_debugfs.c: In function 'stats_show':
drivers/crypto/cavium/nitrox/nitrox_debugfs.c:62:30: warning: format '%lld'=
 expects argument of type 'long long int', but argument 3 has type 'long in=
t' [-Wformat=3D]
  seq_printf(s, "  Posted: %lld\n", atomic64_read(&ndev->stats.posted));
                           ~~~^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                           %ld
drivers/crypto/cavium/nitrox/nitrox_debugfs.c:63:33: warning: format '%lld'=
 expects argument of type 'long long int', but argument 3 has type 'long in=
t' [-Wformat=3D]
  seq_printf(s, "  Completed: %lld\n",
                              ~~~^
                              %ld
      atomic64_read(&ndev->stats.completed));
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/crypto/cavium/nitrox/nitrox_debugfs.c:65:31: warning: format '%lld'=
 expects argument of type 'long long int', but argument 3 has type 'long in=
t' [-Wformat=3D]
  seq_printf(s, "  Dropped: %lld\n", atomic64_read(&ndev->stats.dropped));
                            ~~~^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                            %ld

Introduced by commit

  2a8780be9c26 ("crypto: cavium/nitrox - updated debugfs information.")

--=20
Cheers,
Stephen Rothwell

--Sig_/zOMbtx6=kRGT5fGq.h/g2LE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu29xsACgkQAVBC80lX
0GyBXQgAjrNHLQb795frCbMCZPl/DIeMXdlp9w04Unb65LGRbRmgJFfnNFpdohIn
QZbzC8BsqWjJXtmZHxu1VU3IweaMDBUkPuZQTFKo0iN9aGg0lVrwIcqmZC9G+1EX
1LO9fUhAeyQn26J1IA4n1fq0XZgqnRl3JuzBFXfOoLQebQKkgCbIgZ3njDSnmsK6
JB2ebvDJkdzg0yGRPGy7sNKvBgKpX6fCq4bN6gOoO4LoE65b9SfElcrHtVeDugym
D7TTOqnKSQn68IVagDC/BZLmbBHCt472auTTEVI948XhzaoW0dp/LGkclMp6MwT+
2N/bWTvoGCLkJogZh+/a/fOVsRo+ZQ==
=TvXe
-----END PGP SIGNATURE-----

--Sig_/zOMbtx6=kRGT5fGq.h/g2LE--
