Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D2BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACF42083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kmCMdF/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ACF42083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936965AbeFSB3M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 21:29:12 -0400
Received: from ozlabs.org ([203.11.71.1]:36473 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755375AbeFSB3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 21:29:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 418r3913p6z9s2R;
        Tue, 19 Jun 2018 11:29:09 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529371749;
        bh=jVWnbokANVYmCQPcVVScwfVxlugVo8Hj0OVdx9gEL0s=;
        h=Date:From:To:Cc:Subject:From;
        b=kmCMdF/mpCrtIQYzhvgjr6kKpAUTAvoFZjyDa7LIXLLZlsjSKUqH3eGq+ZRHWihBf
         m8W49cFio+rOja5syvyxP7bwIoeLTy/0oFOaGsxsZLdQWuIzVa6WXztP5IKO6huVAR
         9Mw54TDvMbnda7+RbRsF5mrKsky0/HhNTd4hiQDf5/rOJWbeRdhlLGjJyBvoco5CXq
         mPOY2iBYEmfGsr+IOtUyw8wxFinnJumARdyX6sbglqKrs4RkLc4t90oWNebJ1Q9QWa
         Dstq9OS3eW4mvkZL0o45QfP0+FDAP/GgAIojSOTxR6JRyWDzgLPr8fZYajVSgJNVW+
         6zGUbKnFNNntQ==
Date:   Tue, 19 Jun 2018 11:29:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the vfs tree
Message-ID: <20180619112908.421e512e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/l609MokBjYqhXJ_4xGx.r/b"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/l609MokBjYqhXJ_4xGx.r/b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

After merging the vfs tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

<stdin>:1338:2: warning: #warning syscall open_tree not implemented [-Wcpp]
<stdin>:1341:2: warning: #warning syscall move_mount not implemented [-Wcpp]
<stdin>:1344:2: warning: #warning syscall fsopen not implemented [-Wcpp]
<stdin>:1347:2: warning: #warning syscall fsmount not implemented [-Wcpp]
<stdin>:1350:2: warning: #warning syscall fspick not implemented [-Wcpp]
<stdin>:1353:2: warning: #warning syscall fsinfo not implemented [-Wcpp]

Not really suprising.

--=20
Cheers,
Stephen Rothwell

--Sig_/l609MokBjYqhXJ_4xGx.r/b
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsoXGQACgkQAVBC80lX
0GzHxwf/a4/3VI5fh2YkvwaEN4x7xWpM0xkJ6GOqMKvgtZv0McL9Xar3mmIuhYC7
WxeLE+zTdpBTYgCvN22oOUku2nxckjA6vEFJo+iXzZZcjULvGem7mMNVBKswce5H
I+exVtpZ/QL7i74BPwIQyRK9O9cPw8nkO51xdssAmIBHkmXC8Q+oI7TTGOX9WOG/
pTg0l3bXboYPsHvLSNceU0OimwJCpdKShscQRwlbB4ip1wLa7pHA9YKM4p1lP5yp
dfrG/WHyLQtfGW7GP18zCWaULBM3YcB5U/hgUlyexk7dvDni3iwpjTkL8p6LMPK5
YmlPjFYJhU9cAViJPlcujyzI5p+M0Q==
=/olF
-----END PGP SIGNATURE-----

--Sig_/l609MokBjYqhXJ_4xGx.r/b--
