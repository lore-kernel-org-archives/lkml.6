Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id dhHwIX4MG1vpYQAAmS7hNA
	; Fri, 08 Jun 2018 23:19:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EE5286089E; Fri,  8 Jun 2018 23:19:53 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="TxoLOg3x"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7DCBB60275;
	Fri,  8 Jun 2018 23:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7DCBB60275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753165AbeFHXTv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 19:19:51 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:42544 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753031AbeFHXTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 19:19:49 -0400
Received: by mail-pg0-f49.google.com with SMTP id c10-v6so1418378pgu.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 16:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=OHpmlgk11OaAtHpieg8gD8hkBAsJjor5Bt6OuODWhuE=;
        b=TxoLOg3xer0iFisZLolqVQnVePVr1Q2uAVmuxMrC6p+iVXt6GzegW+mai6i89ksiPR
         I3hom0XhPl2FrJk1bfopdG6+HsqDQgb1tVKFpeKhEhfmwf3dnUO1kSDdUBAzs04uvdb9
         lEK5NdMhmEuqBkNONaNHsnUiJsfHBOq+mO918QjmzSEtXPURhf1lccsB4UiUlGQlhLJA
         YuKVlnKZb0iemKzlzgd7OcFRTBmmu+j4p8pByrBI8XJvTqEv2KoenufBwlXWlsyYGFB/
         piWYukxKW3aKypksdryz7oAFHPpzUA+wuP98bzSN1Bl272lR4i/Ba4XLI5an7r/DFy/h
         lPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=OHpmlgk11OaAtHpieg8gD8hkBAsJjor5Bt6OuODWhuE=;
        b=mFrhlpXLqq6gGoJ6ZZDz5n+QxBSJS31cEXwRjkEzHxRhDlfSVDWgDfRTpOZ79ZkUet
         91NiceU/N+ySQLpO6K/bxyeI7jhztxpL7ZFpZ71EbMLOVORllJNCbx/Dhz0H9p5lNpir
         lzc8n78kxdzdj/zZYQsV9bxoaAAt05QfWIwC3Pspfl9jnE0PZ6dsvKkNUoVCgZ4sXqFj
         b+COApxi5NUKXKirc8qdFn5COpd7XAosWNPRZbMmseBV9MJwfg1buZrH5dd+PvAyxOI+
         E7lm+sA01EfsrZlPK7+C6zYyR+uZEnHa2AA8dT4P2CYouDdZ2ZLxAaZPcsBZHeczZfLf
         9c/g==
X-Gm-Message-State: APt69E1L5D2U1tBOP/ujXfCL2TSo1wjMrgJW5W0VXD6/iIvLFOM3FE/E
        6FxFeqqCsknDTPv0Ago61ofd0w==
X-Google-Smtp-Source: ADUXVKL3goLbyTpbWvWvwdwnPE9rWCovZ7q2WMUhrfMPrgQ6KhALcJgtF3CbOzg+bNZ2wpw1eyRRmA==
X-Received: by 2002:a63:a356:: with SMTP id v22-v6mr2931776pgn.182.1528499988381;
        Fri, 08 Jun 2018 16:19:48 -0700 (PDT)
Received: from xeon-e3 (204-195-35-107.wavecable.com. [204.195.35.107])
        by smtp.gmail.com with ESMTPSA id i88-v6sm14923444pfi.153.2018.06.08.16.19.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 16:19:48 -0700 (PDT)
Date: Fri, 8 Jun 2018 16:19:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-netdev <netdev@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: linux-next: Please add mlx5-next tree
Message-ID: <20180608161945.66f4628f@xeon-e3>
In-Reply-To: <20180606192500.GZ2958@mtr-leonro.mtl.com>
References: <20180606192500.GZ2958@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/iuh=vHxoaWVk2Mm6=WKGlDG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iuh=vHxoaWVk2Mm6=WKGlDG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Jun 2018 22:25:00 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> Hi Stephen,
>=20
> Can you please add the branch "mlx5-next" from the following tree to the
> linux-next integration tree?
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/
>=20
> The mlx5-next branch is used to send shared pull requests to both netdev
> and RDMA subsystems and it is worth to have linux-next coverage on it
> before.
>=20
> Thanks

I would hope all network drivers keep getting review in netdev.
Don't want a path to upstream that bypasses review.

--Sig_/iuh=vHxoaWVk2Mm6=WKGlDG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEn2/DRbBb5+dmuDyPgKd/YJXN5H4FAlsbDxEACgkQgKd/YJXN
5H74Dg//cOmo++ATnkQe0N+Ojxm/v8Puqu/+vS+1MFCYL7JR+/ZM6EJNfJ5u8Rvl
vjlJoKnA4ek9CljopF4LV7CWAdSpqN3rrbhvSWlR9Z0mIfThh6flBE7gPErkKavW
2So/EcDXCnC83mCew11k5fEDLpbPEK2Ik3OdwPV3qIiz7dedrK1ULWSptSKrxR1o
iUAxN/gdDizR+ZvlTqOc10os10m8BLiqYHJu1WeEH84FFICkSouyartNtWv/iSCY
dJz6GKhFvUB2CdavhJvqNzgI64OreoJTIh7b8TJqbCQWLYzklF+Et6lsOBtLayP1
FI9Jg+f4nKDyXomfzbm3r+p0wMncK6atIzqtqpCw3TjnRH92G5U5/0M+qyOCE/jT
7tzqlp24oPUYvL9zwf8RR83UaUw4dB5MKhTxnrutWtpJYtZMMg9jfabFwgI2Y7+1
aAwppQBYj7WOzx1Vf/7N782yssL1rhpWpwLGU90FOoYgw3+l44a4EAKsvGB2KZ3N
bClGGGbxCiojPZe+Buu160RSFMuJ9+qvCU8rSbO+FzlQWPsTZI7B1nOptnKCsc/W
cOpeSHcHcc94hgcBg1fK+gaFhtdSZJvzmM8CXZOH8VPIZE5wr0bmDKD8Ez5LWVlT
dZMK7uFtTwaq4IcSQEMxJJVq+poJnJ7p0/3LDJEFlZysIeg1TRw=
=feST
-----END PGP SIGNATURE-----

--Sig_/iuh=vHxoaWVk2Mm6=WKGlDG--
