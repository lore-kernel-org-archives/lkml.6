Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754FBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3F6222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="u5k3ijkR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tZsVn8Cz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394634AbfBNIdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:33:51 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39493 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388618AbfBNIdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:33:51 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C0A4C23B09;
        Thu, 14 Feb 2019 03:33:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 14 Feb 2019 03:33:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=vFPd37LZbMcPnKi3DY/of7ed0Wx
        CuHCJq/PTXTEj56o=; b=u5k3ijkRXAa2zWU8Ec2x1QCRZpAZhJLnZ99aWA2ZD10
        eCDCr3dLEw2XdIVMOyToXcoCbO8paBFQDTinfJpGwu2S42vNjk6LJYm/PRQVF+Hb
        +K87nae6Q6IvxmZWmTtTn6ZPhXqhX+bpoAegvT3p1moX+Ehb5oeVC1uhAzXS6pUd
        LRhJyPDPLM/64il+xaqQVXEQ/lfgcsqakODYRzk10hmheOpXdCJYrY/uiIYMOym8
        5ZdBRPnaZooczdgLdu5/emNEb99QS7tStZgKhxJjKHRXy72YBPAJAQxBAFZhUhTr
        t5/uGCkEtpO/u7mKrWyCBZvHmmiCg8c3P8gZfK3J1iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=vFPd37
        LZbMcPnKi3DY/of7ed0WxCuHCJq/PTXTEj56o=; b=tZsVn8Czm3jgha0SZllFQJ
        6byzwgdjjHI/fpq+uBuD56X/BXEiQRas3t3/zz3s+nITAjWb3mcdWDW1S91n5S2C
        gUtXQj6vT+1xsNcPDsmvVUq+LsYasTqroMS530D0ahC77Yoyq+EFQw3fdOJuyDv3
        EnJLBItjXEeh7Gv42xb6p+zbNrGtgyGf8H3tzSsWO6zo4FgxXXaMFcTXnGqC+QCe
        wV/Ur21B6RjDGMYxB+wBUXcaDUhkJuXf4b2KSSqnVZGGkVRlozgrvHYgmdRUQUew
        OPC/D6Lh/KFtX2x3XgS+Mt9oNidT4Yhl5qK4DIzdqyPaSZqxkdI3skVaZ+d3EW5A
        ==
X-ME-Sender: <xms:7CdlXBHt7azdpZtU9sHYFd5J8rNkrR41JSvKCpUnm7QYu0nNk_cfUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddtgedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhlucfvnfffucdlfe
    dtmdenucfjughrpeffhffvuffkfhggtggujgfofgesghdtreerofervdenucfhrhhomhep
    fdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtohgsihhnrdgttgeqnecukf
    hppeduudekrddvuddurdduleelrddutdegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehm
    vgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:7CdlXAkNj3HIcPSrj44B-1Za5uwcs2nfcNF0NhQcbcVM5efiARMQeg>
    <xmx:7CdlXMdFLEv1VkihGsW2LrGPYwFr9O61NNq-efzY07EG_03TEn3yCw>
    <xmx:7CdlXKZt-ZzLJyu92s7lXsETsksG_e1f3qd89rOjVnGob6EowfOaUw>
    <xmx:7SdlXLhESg5axY8yMED9tT5aMaNjJ7PvQEbIOZc2NGI8hr3kryAIpw>
Received: from localhost (ppp118-211-199-104.bras1.syd2.internode.on.net [118.211.199.104])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9928B10310;
        Thu, 14 Feb 2019 03:33:47 -0500 (EST)
Date:   Thu, 14 Feb 2019 19:33:35 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the leaks tree
Message-ID: <20190214083335.GA3053@eros.localdomain>
References: <20190214183605.3132886d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20190214183605.3132886d@canb.auug.org.au>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 14, 2019 at 06:36:05PM +1100, Stephen Rothwell wrote:
> Hi Tobin,
>=20
> Commit
>=20
>   5d06b3fc8e61 ("leaking_addresses: Completely remove --version flag")
>=20
> is missing a Signed-off-by from its author and committer.

Thanks, fixed.

	Tobin


--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEc/+jpUAIMPwyplf8QL+eTCadZgcFAlxlJ9sACgkQQL+eTCad
Zgdy8A/8DxMAK2W0fTnqiOFd/W/cU1295Av8IUBdKBrgXlDaiSzIJLaCN29EQwE+
Ku4xiHgBPzSqbkif+UfbHnPLEH7yxRjg8+2VGx3Q8QUm1Fh4s0jBurPXX1iDe5lx
BwTehd+ruEREdZaOafA2DRT3+yKo/OiVRkDmrjl7SG6fmDiYiO91bVfjv8aJqNEg
4PJZnUI6qeI0V2ASZVtWqUfZp8vqVKCBNQHOrPRUFsIOIbxItM06VGHAZNsKkbzp
DM+aNDOGHklq3mv11dv5nC5ydVr+NetnLkDaqZkZd3EbIr20DkrGpoOYiqj4rV+f
4ZwX76tDv6+GD5QEQJ7HmKIBneDHQp6DnRhMRk13UvkgBCG+3QTelo0hWgVspoZW
f5Uu/hhC/pfoERMESgk56/L7rJENaHQGtw60+zDMhsJLeWMGiW3/f2oj703IuCwn
Xvki5IoKftSdsiUBgWmYZcy+MlygDfZrzfaBUoDTnO2GZ5m3GwIZKIpdzEPO+i5x
KqTcg7TSe75JnZbO0hIHXuJm5moIVbaa17jyOoqDHh8MHrCicIPi7OxO2KoFjiXa
drriAYZFIr2XRirQOAHqZAH+I7eGSep0/yvh9LZR60Xp8U7ez920tcU1q08b1u4r
482lLY/U1HntoDhTI8NOFM9ZeuaByKAkWOanlfYC/DT/oLfKSZE=
=fzEN
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
