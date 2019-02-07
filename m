Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289EAC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85B121907
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfBGW7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:59:05 -0500
Received: from anholt.net ([50.246.234.109]:58728 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfBGW7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 17:59:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 6B2D210A2C1E;
        Thu,  7 Feb 2019 14:59:04 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id zVfRQlTG8Oyj; Thu,  7 Feb 2019 14:59:03 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 4E4FF10A0353;
        Thu,  7 Feb 2019 14:59:03 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id E21862FE464C; Thu,  7 Feb 2019 14:59:02 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] drm/vc4: Use struct_size() in kzalloc()
In-Reply-To: <20190131010015.GA32272@embeddedor>
References: <20190131010015.GA32272@embeddedor>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Thu, 07 Feb 2019 14:59:02 -0800
Message-ID: <87r2cjmci1.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

"Gustavo A. R. Silva" <gustavo@embeddedor.com> writes:

> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct foo {
>     int stuff;
>     void *entry[];
> };
>
> instance = kzalloc(sizeof(struct foo) + count * sizeof(struct boo), GFP_KERNEL);
>
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed and pushed to drm-misc-next.  Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlxcuDYACgkQtdYpNtH8
nuhg7BAAqcbA9jWn2TWP8xHFGijD0r/gZEejmEsOwdKb6G5U+TTrlz8g5Z6cpX7J
ArnkfJG41gE5nxonAJZEGKE/+aN2sTJjSq3MFTpU+igJSHhdlkTIZadiLNSZNgSy
1zmHm6Gufcpq6IJsBlKya3nd+p+sVIPBkEF51iMm98A8g6JL31kDioY8+Zq5mCjt
rUZNHjgTStPaX+CZg0N7mZAUIdQCLVn6cz0ibDAJ/kgjekyk5N8YPp1ZaJmGnjSW
Ov7fDcydL68bvA4IWDxZaUh9OPfiu1RyPWFCCEGc/OYgFrdHvUIzAAInrfPb+On9
yesrQq7+6ELGwsicgSm2Ks7dixudCeQpN17PjcF4rt1PBnSjRXw40MlNHe3/vdGW
6yelgdc4Gn0rQ7P6KTEZe7AC+QOUpe2bQEZeS8XMFKaSvpCbw5gdIa8mFVP6jDwI
h1MFIFserjbEkn4TJYlYz+Y/PCaPXLLM/GBvyAI8wt3gXzKvBQAxrIekkNrzm4Mt
MtQWVb0FqwiQeJg0KAEP2BgbLp9I0ZmNCoAA2JNUsvyHhSYjX49zwy5LHiI4noje
Ez/k84p6bShWbOu/Lhu0NJhPZnnKt80MoWqZcyU2W0PpPtg2AZtjBt6XiLpFtwXO
nV4z+M6HBfzaSVOqRyQa/GkHZLGcaShlIJR/r93lZIG0ihHXpjA=
=vCJb
-----END PGP SIGNATURE-----
--=-=-=--
