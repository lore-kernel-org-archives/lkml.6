Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F60C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7442A20878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlKiZbZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732979AbfAKR3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:29:47 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42239 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbfAKR3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:29:46 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so7036046plp.9;
        Fri, 11 Jan 2019 09:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Ko/FWRLCeuj+yXZD1eSdFoifFvwbUH6md1uqi+OLoA=;
        b=IlKiZbZtOF5AzGUGpElai8eVbwzYd0jnPX2QwOwK5GnrYbNreFguwsJxRUCGTWv3Jf
         837bOlpLcMQQbx4HkEvbGbmVhe1Jyn8FTLspeFq/tGZnne4NyFF/vgczag3ZfOqKYgvF
         WzeZEsLXnGWE3NsU48Ijzt/8Q4B1vvKusIb7hO+GZpg2wAbYa3bu1wmSWCMFJ+mHTSmd
         lIgEszHsIaF3fgNZbCmbJiw6+gU2kkUgLbknSPfPgdwA1wrg6Uu+QyP3y44Hbfyrz4Xy
         WII0Vuu/H76RpGm2Pkr/7oFQnQJ+40O9Ipb1JYkpY3g2XVMP7jdfkYScEPlC2B/s3n8u
         yz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=5Ko/FWRLCeuj+yXZD1eSdFoifFvwbUH6md1uqi+OLoA=;
        b=DOjFneWu1oZ5Qfiel3SmQs+XtcStjCRFS7L/DGPpjEE2v3TwxB71tq7OOyvm/kcyo8
         X5g5VaJzjAGM556I1wJcz80J+Vr38JSdKpewcmEBxnY2NbiJ9gPkDT+JuTvxzdE0IgFU
         9EfW9X+xzxnvkESoH595XFzaQELxkPsaO30TMvWs/G4wEXQQ6rhUTxw6fvnT6vWCeGjS
         bWMG86U2LhoT2TyYeBiQIjbYCQ/RZmSfny1eJ8hHdd1kUmkmoHkf5/hkwxJQwgpBuRNA
         LKMzGs/9Gr/XBZOiUn3Jbn2x7DLd3U/1mYjQHw2HMYhPvG/nYbXESgfigHaK6zIRA5ou
         v6hg==
X-Gm-Message-State: AJcUukduqT+lK498l5by9BJEX+OwOVwBeo4cOwgQam1igADEZ3wQleab
        dN+bGQdCjBNjP5MXAdYvsAo=
X-Google-Smtp-Source: ALg8bN5wmUC+atXVSVCqgBQq8yogV4F1O9yZVIv6fzxcos01UFA4EJoNzdt9ia3TMSzDDtRX1Pc3mg==
X-Received: by 2002:a17:902:e20b:: with SMTP id ce11mr15019611plb.251.1547227784635;
        Fri, 11 Jan 2019 09:29:44 -0800 (PST)
Received: from gmail.com ([2605:e000:1117:c227:3b53:d0fe:bff:4913])
        by smtp.gmail.com with ESMTPSA id l184sm117480471pfc.112.2019.01.11.09.29.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 09:29:43 -0800 (PST)
Date:   Fri, 11 Jan 2019 07:29:40 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Joe Perches <joe@perches.com>, Gal Pressman <galpress@amazon.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Tariq Toukan <tariqt@mellanox.com>,
        "xavier.huwei@huawei.com" <xavier.huwei@huawei.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Stephen Warren <swarren@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH v4] coding-style: Clarify the expectations around bool
Message-ID: <20190111172940.zufmrhvukqo5hkat@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Joe Perches <joe@perches.com>,
        Gal Pressman <galpress@amazon.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Tariq Toukan <tariqt@mellanox.com>,
        "xavier.huwei@huawei.com" <xavier.huwei@huawei.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Stephen Warren <swarren@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190110234805.GN6890@ziepe.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zp7lkj5ihh2r6cwq"
Content-Disposition: inline
In-Reply-To: <20190110234805.GN6890@ziepe.ca>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zp7lkj5ihh2r6cwq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2019 at 11:48:13PM +0000, Jason Gunthorpe wrote:
> There has been some confusion since checkpatch started warning about bool
> use in structures, and people have been avoiding using it.
>=20
> Many people feel there is still a legitimate place for bool in structures,
> so provide some guidance on bool usage derived from the entire thread that
> spawned the checkpatch warning.

Hey Jason,

I very much agree that the bool expectations could be much clearer, and this
patch is a nice step in that direction! Just a couple small nitpicks:

> +Do not use bool if cache line layout or size of the value matters, its s=
ize
> +and alignment varies based on the compiled architecture. Structures that=
 are
> +optimized for alignment and size should not use bool.

+Do not use bool if cache line layout or size of the value matters, as its =
size
                                                                    ^
                                                                    |
Adding an "as" makes the sentence flow a bit cleaner: --------------

> +into a single bitwise 'flags' argument and 'flags' can often a more read=
able
> +alternative if the call-sites have naked true/false constants.

+into a single bitwise 'flags' argument and 'flags' can often be a more rea=
dable
                                                              ^
                                                              |
Missing a "be" here: -----------------------------------------

Ack from me after those two corrections.

Reviewed-by: Joey Pabalinas <joeypabalinas@gmail.com>

--=20
Cheers,
Joey Pabalinas

--zp7lkj5ihh2r6cwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlw40oMACgkQ2rGdfm9D
tVIt6w//YCX55pUgnakyxl8AEZJg8IeJW725Pj9QA04LY0CaNZ/uRhxvw4IaOTUq
svXR3RxqEd+B/GMo5WIokxdlPtovU3tbccda3VX14LXKW7J9KMSR5cMdoq7pxCKX
SuvmDdgU9lF2AiSBF7+46DohL7ENd67wPFswwCcVBfPfNVX7RucfmnXMGZwhiTFF
fgNjRxsCS4DOVj7Ps9rblhIk3PmSKglTiTu83H9mx3h5AmF5Rd3Rsf9dy2mSYevp
0NWojWI6+6y2nV4gA9KIo5lW2RutlClpLAmxUMhiQWlQLka2ZUbUI6AlCDwmNnqz
iyW0QtLNvnSvfgTcbG6gmaHGn5YKCGRB+FZuWLV7igwJLfr7f2lzZgtU2BXZaGnl
ys6+Ul2x+I0E/ZfqpBcfu0G3lSpTiMLmCRNBSzkEbZjqn/n05cvuHVGUEEELWBq7
foyg/g5rkjhqEPoSJqaVIn1ngRyMRvAcRdOgOCmn6sidSs21QsZprh4nBGqcio2y
dt0DSaDSvZZoFaJJwIFT2XHOGUy2X30/CCMb67JrNLav6u4fIYPk1bSUL4YEgjoY
1n5tfDv/Fpif1JMscsQvryM4XegLkjTAq/fRx4QmB1PWuqVktlTDZnuGNEo3o0kD
MdBnYUPp51nMlL60JsVoZF+36VOU2QvrLuLxTN8uKxh1YOtR0ck=
=p1Hy
-----END PGP SIGNATURE-----

--zp7lkj5ihh2r6cwq--
