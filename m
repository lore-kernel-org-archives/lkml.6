Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6C6C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E718208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mwejviGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E718208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbeGaHVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 03:21:19 -0400
Received: from ozlabs.org ([203.11.71.1]:50947 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeGaHVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 03:21:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41flhN3bqvz9ryn;
        Tue, 31 Jul 2018 15:42:44 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533015764;
        bh=OL3DsG164BG6Os0lnEr0huaFxDjLg8QKtnFLRMgTHEs=;
        h=Date:From:To:Cc:Subject:From;
        b=mwejviGvWs7SM3IPn6UUs8Gz1RVrR4st81DgcPLLJQY0XaUz+dJuvI0xYDGJLDB83
         +W43zq41/OPWWOvNJ80bHc1hQoew8mZuTFsLzAfIm5/30aNpeGxVJRu4YnPEGuAjYd
         nBgQzZuMlLpVlBZAqqwlOVNvstldLyDccH0cW835d72hL5oVqRbcDoOB6AEeGm1J0q
         adRXN+cCCX73njdNeFO1rN3xh5IkUlxbnwZmUqkE7EmSOkMZVbMOFAUKtNF1ZRtP6R
         6BKkyWQmD5QKsbkqjhDPZkiqY8WOpCg8r9ZYoCbXrnESvBeSi7QfN7FmkHCG1hCXoF
         qaYV5DVR5RAAw==
Date:   Tue, 31 Jul 2018 15:42:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robherring2@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: linux-next: manual merge of the pinctrl tree with the devicetree
 tree
Message-ID: <20180731154243.203068c5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2n_oiD8D16eSY/rV4f/cylq"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2n_oiD8D16eSY/rV4f/cylq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the pinctrl tree got a conflict in:

  Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt

between commit:

  791d3ef2e111 ("dt-bindings: remove 'interrupt-parent' from bindings")

from the devicetree tree and commit:

  de1d08b22974 ("dt-bindings: pinctrl: add syscfg mask parameter")

from the pinctrl tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
index a8bb36b4f9fd,046a3de026d4..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
@@@ -37,9 -37,12 +37,10 @@@ Required properties
 =20
  Optional properties:
   - reset:	  : Reference to the reset controller
-  - st,syscfg: Should be phandle/offset pair. The phandle to the syscon no=
de
-    which includes IRQ mux selection register, and the offset of the IRQ m=
ux
-    selection register.
 - - interrupt-parent: phandle of the interrupt parent to which the external
 -   GPIO interrupts are forwarded to.
+  - st,syscfg: Should be phandle/offset/mask.
+ 	-The phandle to the syscon node which includes IRQ mux selection registe=
r.
+ 	-The offset of the IRQ mux selection register
+ 	-The field mask of IRQ mux, needed if different of 0xf.
   - gpio-ranges: Define a dedicated mapping between a pin-controller and
     a gpio controller. Format is <&phandle a b c> with:
  	-(phandle): phandle of pin-controller.

--Sig_/2n_oiD8D16eSY/rV4f/cylq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltf9tMACgkQAVBC80lX
0Gy3qggAmTga7himmgQEmBYbj7JanhYTvlGJoJR4xePb0gWwOWLq4WZLeXRwtWkk
et/P6vqqpiDwbaReYYkxbMKMCFBRQefRTHq9c3W/pgsMX5GzUHl935kmywQPs7xf
rSm0dhMvqucS0FYPMMkUaswfk/JHJvLWyAcZpoJ9MHoNj8xfpst9wRhLjR/hVU0U
cvO748FKhreiQa6YOPpviHdjpmHjzbTQbqDQ0ZGTrxILv6up8POQvNCI8pKGDDLM
rKB231C/qz+SQSvFYuq2AAfkVxKSOyZ20CBSfYW3BpkoC+NenSAVrS60sMhlhloV
BN7XpsABC4XOq0U3rer1gUkjsdZF1w==
=7UXy
-----END PGP SIGNATURE-----

--Sig_/2n_oiD8D16eSY/rV4f/cylq--
