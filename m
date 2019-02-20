Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFCAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E5A20855
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a6tr9OLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfBTXjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 18:39:51 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43747 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725989AbfBTXju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 18:39:50 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 09F4523733;
        Wed, 20 Feb 2019 18:39:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 20 Feb 2019 18:39:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=R+1XRH
        9hHORtPG3X4sZt0YpWgH0VQjQV+CvjLcZs8Kc=; b=a6tr9OLjGrqZhJ9nDMYiYA
        pp294kGuBKZ2G61KKS0rLYJvw+PNrm0nU8Cr/yoWlGdl6jaiL+rHCHYjym30WyFs
        08Ak9iIrf9v7v8s9YlZ5xhwwBDNg5IrHC1fFqpydfKRysC4daG4CoPxZv9UZzLhR
        NwLZ3p7alpfJn6wLGftoH/jh9Efq82Wz2gieTQv/d/UMEcR6d0gfz/ovuFoyJMss
        2Pd3GrKvieKJYbVCYIQcR7qS0L5t454v1bbEiR06AyfcvVFQZL9r1CKpvQC/ewZV
        xLudHkbVBl8w4700WzkzZuD1y/kF52kK/Z/BrYkAwU3hKFckd1FNxOclywT2/AWQ
        ==
X-ME-Sender: <xms:Q-VtXEI-ETSqyRaACa2Ks99EvXEjridd9PcIUFExAtackZYYx9_QZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtdejgdduvdculddtuddrgedtledrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesghdtreertderjeenucfhrhhomhepofgrrhgv
    khcuofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomhgrrhhmrghrvghksehinh
    hvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecukfhppeeluddrieehrdefgedr
    feefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgvkhesihhnvhhishhisg
    hlvghthhhinhhgshhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:Q-VtXJJrRJB5ey--Ztpvjeuo9BQ6o2qjO3EjU0LSxvwKupye1hJsjg>
    <xmx:Q-VtXFnAy8fi9p1NpBzjt8dc4SwjDA1XUkwzjLJt7OtbIoLC0wJyyA>
    <xmx:Q-VtXHIfW3UX2pzPsD-GDO84CEeodh4sIyDa12SeAn2gUonY1NIpSg>
    <xmx:ReVtXEaNlPfVx3iJk0LlgG0X0spudSK_NNFEbafWkhFznwUBWo2MvQ>
Received: from mail-itl (ip5b412221.dynamic.kabel-deutschland.de [91.65.34.33])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2DFAB100E5;
        Wed, 20 Feb 2019 18:39:45 -0500 (EST)
Date:   Thu, 21 Feb 2019 00:39:41 +0100
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        x86@kernel.org, Ankur Arora <ankur.a.arora@oracle.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Xen-devel] [PATCH RFC 00/39] x86/KVM: Xen HVM guest support
Message-ID: <20190220233941.GA5279@mail-itl>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <20190220201609.28290-1-joao.m.martins@oracle.com>
User-Agent: Mutt/1.11.1+94 (9b965fac) (2019-01-05)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 20, 2019 at 08:15:30PM +0000, Joao Martins wrote:
>  2. PV Driver support (patches 17 - 39)
>=20
>  We start by redirecting hypercalls from the backend to routines
>  which emulate the behaviour that PV backends expect i.e. grant
>  table and interdomain events. Next, we add support for late
>  initialization of xenbus, followed by implementing
>  frontend/backend communication mechanisms (i.e. grant tables and
>  interdomain event channels). Finally, introduce xen-shim.ko,
>  which will setup a limited Xen environment. This uses the added
>  functionality of Xen specific shared memory (grant tables) and
>  notifications (event channels).

Does it mean backends could be run in another guest, similarly as on
real Xen? AFAIK virtio doesn't allow that as virtio backends need
arbitrary write access to guest memory. But grant tables provide enough
abstraction to do that safely.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAlxt5T0ACgkQ24/THMrX
1ywuXgf8CxriAQi41O9KOBv2YBHj6F7y0aXbFijExKEae2dRQAFiC/FF3Pmsny4Q
m6MSC9lVwdkZeg05S9T0ljll+XPGVb5a2rwn1aevI6i0zHOsI8/MoJrkfpL9iUmR
VncMocTrf3ysT/azWkFCbQFmVYutTZx7YFTyTaqpH6Y0aSR/IfN4Tmkwf3Vck4Eq
kDesmHKpXdS8VdVXfV3umReqMJnvMZlRQfisUtOzRWqrORwooCcB83703ewGvHz+
n5/WJrbkZ8XeKOuK0NfIC3u45pvAFdI/7oH7LedoK4qwo/EV6HyfKMkrAjSVAxme
1b0Yyf/5F0sbZeFPOHGTVHFV6iBgsQ==
=MtoW
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
