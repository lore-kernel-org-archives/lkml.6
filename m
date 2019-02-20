Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B116EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA3E2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfBTViI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 16:38:08 -0500
Received: from wp260.webpack.hosteurope.de ([80.237.133.29]:44288 "EHLO
        wp260.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726070AbfBTViH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 16:38:07 -0500
X-Greylist: delayed 996 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Feb 2019 16:38:06 EST
Received: from p508bc6f1.dip0.t-ipconnect.de ([80.139.198.241] helo=vega.skynet.aixah.de); authenticated
        by wp260.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1gwZJ3-0006cU-4I; Wed, 20 Feb 2019 22:21:29 +0100
Received: from vega.skynet.aixah.de (localhost [IPv6:::1])
        by vega.skynet.aixah.de (Postfix) with ESMTP id B2781260020;
        Wed, 20 Feb 2019 22:21:28 +0100 (CET)
Date:   Wed, 20 Feb 2019 22:21:18 +0100
From:   Luis Ressel <aranea@aixah.de>
To:     linuxppc-dev@lists.ozlab.org
Cc:     linux-kernel@vger.kernel.org
Subject: make modules_prepare doesn't build arch/powerpc/lib/crtsavres.o
Message-ID: <20190220222118.1e15c0f9@vega.skynet.aixah.de>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/BsA+yXbZSXgfZIbEUlii.id"; protocol="application/pgp-signature"
X-bounce-key: webpack.hosteurope.de;aranea@aixah.de;1550698686;34d75ac8;
X-HE-SMSGID: 1gwZJ3-0006cU-4I
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BsA+yXbZSXgfZIbEUlii.id
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello,

as documented in the top-level Makefile, "make modules_prepare" is
supposed to get a pristine kernel tree into a state that's suitable to
build out-of-tree modules. However, this is not the case for the
powerpc arch, since all modules are linked against
arch/powerpc/lib/crtsavres.o on ppc32 (and ppc64 if binutils is too
old).

A similar problem applies to "make clean" -- it is supposed to retain
all files which are neccessary for module building, but the global
"find . -name '*.o' -delete" it performs drops crtsavres.o.

--=20
Regards,
Luis Ressel

Please CC me when replying; I'm not subscribed to the kernel MLs.

--Sig_/BsA+yXbZSXgfZIbEUlii.id
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEbPzLt4vriSGj7oj2YKkwapaNrTgFAlxtxM4ACgkQYKkwapaN
rTgsGQ/9GlNxBW7O1TUeVmrwniofcHNG2xvz9eO6156Y8t7fp1QoMUnjyvo+12J1
FDfyL3K2PH+rwBPFnUV6Yg9+JlM2jG3BkUvX5FxfEi/scIyGpJO38Mvta5bhoJjf
OVa3ZhNZ6xNAGebS9COaSsNH/7pjG7PICrTyI3yvsNNd8BEAtCuWFQpPiLkmBvqj
vfIgnWCyg35HaTVO0MVC2UJP6YTV8ntcvo5AM2379YkJZWwDSSvxLHbNv8HFyXLs
TB8LnKdu8wWufOBERY2KbmDXkySQx1QFd6aLPxA6v+/DyRInsFTeCESQZXFzevGi
kq21ORVF/LZd4b+BmnH2h+sXSIUkVxK645h9hsuin9yQinHDf9pYAxcvlrXvuxsI
GXW+1P9krX72YLPcLeitROr5ZKqbpBoh/fGdVO3B5+0eT9p/EaRgntd989SZzROa
uqWDJLu9NPy1WhVEhbIBL3BtG9KyQCOI7c51RMZhHIViewvOJavxevTn6VPl8JBy
SytLJYH0tTK2id6RsZh6Z40skGu25xYRvAITWevF4BcbIQj6e/NBDyXWnn6GJwTs
/fpf4CBifEDBDewikhWf2q0MzEJeWDaJuaW978MosQp8uSuxcw/0eD2ADhoJmuqO
D1vSCCMWKJNw0E1N3i30zeLLN9Jgumh/Akbh5leZGNTPHXX6hL0=
=PSYQ
-----END PGP SIGNATURE-----

--Sig_/BsA+yXbZSXgfZIbEUlii.id--
