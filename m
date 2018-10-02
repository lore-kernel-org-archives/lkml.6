Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C82C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C958820C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oGwHT0HZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C958820C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbeJBMNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 08:13:18 -0400
Received: from ozlabs.org ([203.11.71.1]:57515 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbeJBMNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 08:13:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42PSSn3v2Lz9sCq;
        Tue,  2 Oct 2018 15:31:53 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538458313;
        bh=70giA5rDcm6pnyYjzP6RMZVdHpcXxwHuMAyFUiPIqQs=;
        h=Date:From:To:Cc:Subject:From;
        b=oGwHT0HZhadf5iMvBXBePs84ugzdp/8Ygjb5z8VXcXCYxjrj8P1wBYOKn8WBmFo5n
         Mmz2xq0cZvL0fiYh6HE0pyoap3TrLC4r58bGgYEOH31pB88Yow1RZQMop8LErsjyKb
         NKflGSIdB/f/tp7ceM27UPxtLJprsLxp2IAjbCRGq4qMC/tQnLSq2scT1eUlmkugKd
         37svdDpJsQv6n6N+mRy6oU3lYIWgKyq+hczHPEZNukMTnK5JAmJQvFWYX/pHcFYQxL
         x6H/f4oY/ZGqs5tcRpb7SHTr8YzgKFoGavvCweIRRuAT8HGm0bnwc0fknmSlw2xnha
         UnnjKQvLLj2aQ==
Date:   Tue, 2 Oct 2018 15:31:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: linux-next: build warning after merge of the char-misc tree
Message-ID: <20181002153149.2a312771@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/irOtuQOPhLavSwGr2qkY3n8"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/irOtuQOPhLavSwGr2qkY3n8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the char-misc tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/nvmem/lpc18xx_eeprom.c: In function 'lpc18xx_eeprom_remove':
drivers/nvmem/lpc18xx_eeprom.c:258:6: warning: unused variable 'ret' [-Wunu=
sed-variable]
  int ret;
      ^~~

Introduced by commit

  226014d13fa5 ("nvmem: lpc18xx_eeprom: use devm_nvmem_register()")

--=20
Cheers,
Stephen Rothwell

--Sig_/irOtuQOPhLavSwGr2qkY3n8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluzAsUACgkQAVBC80lX
0GytxAgAmDRpiVPYk/tReHOcZ70FO+s7MLVHlQNZi5jF5P2axIfTYHgzbHX6YxX2
DE4uPhPNnIva0JGGuF6utg3v51jdqhJDskJ95YofP5KofX/2r5O7iZxIBSC2C11K
+wMn3SknP7Y7GGShxDDVJyunPnv7N6dUYPjr+COGsjVZxVwL/kbCnQIpBpQEpywJ
PKglAOE4RFQDz0Y13qgKlOlzVD0pUsB+8nq9U3hOnyTJgYhSCi/k7k2ZwRhDTjWE
WKEMOtLmRPqwVUp8sZ1ZLBoo3NeUJEqhwNOPSTE1Ua5jPxW7kKvs/SD6Ubr40iT3
R0tJ6ec+3Al0rJtjwJYPk+I2R+omLA==
=U5lr
-----END PGP SIGNATURE-----

--Sig_/irOtuQOPhLavSwGr2qkY3n8--
