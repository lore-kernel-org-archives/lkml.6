Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF82DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 04:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7B821873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 04:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="A1vtsC9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeLSEM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 23:12:58 -0500
Received: from ozlabs.org ([203.11.71.1]:42431 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbeLSEM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 23:12:58 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43KM1d4W0gz9s2P;
        Wed, 19 Dec 2018 15:12:53 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545192775;
        bh=agQD+rzVYI3FazhqxI9bPNzgsYyON/YytEuZQZILjYU=;
        h=Date:From:To:Cc:Subject:From;
        b=A1vtsC9LLqSu3cbjRlBTmfvrxGGJTxblaZzBcoeupBlOObsj29Xp/ixyrWX5DuXo5
         m6IYTFzCz72KTVW2hbvhHJ6ygxXiBOOIe4ymaZnra18Ved9KWvTz6Noj8Y43Q2R4te
         OkhW4AduuWRysNln2LiT5NO27OwG511wfCnHovs5Js8aNCoJgsSFm6LFO6SK8AUUEU
         nURD5ICKOs9lmqmaDDjYY+R2kVj3kCSSYg/WUw9a8zEH2/Ae5bcJQqm/DmDlqpIr9S
         cle87DDkgB5frKcH/TXImIlmNYvR9npJfqSdtmCwXV/29NZSSgGWsJYhwBh/xQ0wlR
         4B6J9NLdphWhg==
Date:   Wed, 19 Dec 2018 15:12:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Marc Orr <marcorr@google.com>
Subject: linux-next: manual merge of the kvm tree with the tip tree
Message-ID: <20181219151252.3e27a7f8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Wy72QkJ_3RjgB0ZhYvD/jBY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Wy72QkJ_3RjgB0ZhYvD/jBY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm tree got a conflict in:

  arch/x86/kvm/x86.c

between commit:

  eb012ef3b4e3 ("x86: Remove Intel MPX")

from the tip tree and commit:

  b666a4b69739 ("kvm: x86: Dynamically allocate guest_fpu")

from the kvm tree.

I fixed it up (the former removed some code updated by the latter, so I
did that) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be mentioned
to your upstream maintainer when your tree is submitted for merging.
You may also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Wy72QkJ_3RjgB0ZhYvD/jBY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwZxUQACgkQAVBC80lX
0GxkgAf+KpOi5GYRWrCxptB3CZfRzKSZWoR3G20znQtTlsDyUq3dbmsv8LUOZv6q
U0f1z0LnpmqQ/fjbdtn+nh+pESsV/W6HPQOmd+ya9kClEXN7wzmXaaxMDg66i1jh
2VrEps5Nzw8RTh43eyA0Yn+iyB0GpuJk06uiV9FL9yVzhDoX+hrtwIQpvSgbp5pq
R91tjiGLKrWHS1CZN7cmeG8MdzxcB86MG94m5sg416/y4iBBD0peWF7hd3y1PEbH
lzbBI2EsXJmXW6iuqBYe3GSuxINAzwdQ2T22eTLSonEV2hQPUyOXf6kPOwfTt89o
ErLokEJGCOJf+/tD3oJtgrwEY+Wslw==
=2Igu
-----END PGP SIGNATURE-----

--Sig_/Wy72QkJ_3RjgB0ZhYvD/jBY--
