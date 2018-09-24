Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3311C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9532098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="RZDHWqk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9532098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbeIXTUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 15:20:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44309 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728917AbeIXTUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 15:20:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id v16-v6so19646431wro.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 06:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1Qla0hf/ZuwJB9W2b8qP9+0liT+B/PNXuD+YQ09ZjwM=;
        b=RZDHWqk5JC6Iq/Faq/F7GnjnbPgXbH3fwhTxG+axWebvAtK+/fTsmpignIcruUoOOn
         qtf8gICjO58Db92Q57poYmF61Lc1EBXOxfzZrIbrkjUItqzzZ18t1kxECJhK8xAMOHD2
         q8IXPGmz1E1CPoXGTw6ABLn+owT9QI76Y+BsosTe21gBL5NP2ZYyRfTd1gfsdJbheM3L
         ui9fwRZDNW2mY3fIU6HnhGkLR2EjM+nKx1pdAjNaKGvUnN/uWv7Y4nwNqkcqMnLie/y1
         iGGPdt+Qm6Ye5NbZtjKJ0pLACB7ZMDh44pYlTdgZD98Al0R9TJNbtkyqxPwdwUjdYhIb
         JKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1Qla0hf/ZuwJB9W2b8qP9+0liT+B/PNXuD+YQ09ZjwM=;
        b=lBKt1o0jU/8Pt94tXhO4bFd8ysWJrgkVmW0Lz1/2L05GB1gmY09RQEPMV0m7fwZg/T
         KnGuEOz2H7dfgualGN17EMx6HK5wmdzLVhn5dViFYkgXTXWhB3f2C3FHaAiqBAsVnn0j
         Sj7/Mi7cgSIO0mWQY+kTiDeAXrv1UXApObyAhz3k5EITWU/GwaxUDZyC2MGuBrWJZFIk
         WGpKQc3RFVdKI2C+3TqyClcfG27BV49TxDMeDOp7ytdkW2YW9VtmUBPiie2q5YWXAEod
         lk+VTintrc69SD9l3kW5w86/1SWkCSXtgiE21E4PUTexNsIlqujOL+nE+MB+KBetsJpl
         uWyA==
X-Gm-Message-State: ABuFfojY7FxkZKGfk7zHBYX5gmKWlyP8qlOgmNTPrlI0SfyUT0Lct6Lf
        U0xzRxsH61yxnV9bOP+EDrbzgg==
X-Google-Smtp-Source: ACcGV63HomWHl2wKG49SOZTPGSSPTlV7wCxTf99mgHUBau1EeAjAMDi5GJn/iRKRakoIMQWndQOMvQ==
X-Received: by 2002:a5d:4c49:: with SMTP id n9-v6mr8795920wrt.71.1537795100027;
        Mon, 24 Sep 2018 06:18:20 -0700 (PDT)
Received: from brauner.io (p5097958a.dip0.t-ipconnect.de. [80.151.149.138])
        by smtp.gmail.com with ESMTPSA id b22-v6sm11359947wme.48.2018.09.24.06.18.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 06:18:18 -0700 (PDT)
Date:   Mon, 24 Sep 2018 15:18:16 +0200
From:   Christian Brauner <christian@brauner.io>
To:     David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>, aviro@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] fsmount: do not use legacy MS_ flags
Message-ID: <20180924131815.76topcqqh3spyvvp@brauner.io>
References: <20180922132106.wfa6xaxwbu276qka@brauner.io>
 <20180921155455.flkf5vdrm3vgn6do@brauner.io>
 <20180920151214.15484-6-mszeredi@redhat.com>
 <20180920151214.15484-1-mszeredi@redhat.com>
 <17157.1537542475@warthog.procyon.org.uk>
 <20311.1537548756@warthog.procyon.org.uk>
 <8221.1537631312@warthog.procyon.org.uk>
 <3868.1537742717@warthog.procyon.org.uk>
 <30364.1537771838@warthog.procyon.org.uk>
 <29956.1537792665@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ouaxp4t3sd3or2bq"
Content-Disposition: inline
In-Reply-To: <29956.1537792665@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ouaxp4t3sd3or2bq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 01:37:45PM +0100, David Howells wrote:
> Christian Brauner <christian@brauner.io> wrote:
>=20
> > I have thought a little more about splitting up the mount flags into
> > sensible sets. I think the following four sets make sense:
> >
> > enum {
> >         MOUNT_ATTR_PROPAGATION =3D 1,
> >         MOUNT_ATTR_SECURITY,
> >         MOUNT_ATTR_SYNC,
> >         MOUNT_ATTR_TIME,
> > };
>=20
> Al (I think it was) has been against splitting them up before (I've previ=
ously
> proposed splitting the topology propagation flags from the mount attribut=
es).

Right, that request could probably be fulfilled by the first draft for
this idea that I had but didn't send out.
Basically, having a sequential enum that only ever gets bumped when we
run out of flags in a set, i.e.

enum {
        MOUNT_ATTR_SET_1 =3D 1,
        MOUNT_ATTR_SET_2 =3D 2,
        MOUNT_ATTR_SET_3 =3D 3,
        .
        .
        .
};

Then we would currently only define a single set
enum {
        MOUNT_ATTR_SET_1 =3D 1,
};

dump all the current mount flags we would like to support in there and
call it a day until we run out of flags at which point we introduce
MOUNT_ATTR_SET_2.
But honestly, I find defining cuts by forming sets of logically related
flags to be more intuitive and transparent for kernel- and userspace.
But I'm just another muppet with an opinion. :)

>=20
> > #define MOUNT_ATTR_NOATIME     (1<<1)
> > #define MOUNT_ATTR_RELATIME    (1<<3)
> > #define MOUNT_ATTR_STRICTATIME (1<<4)
>=20
> These aren't independent, but are actually settings on the same dial, so I
> would suggest that they shouldn't be separate flags.  I'm not sure about
> LAZYTIME though.

So what you or Miklos suggested before, namely making them an enum too?

>=20
> > enum {
> >         MOUNT_ATTR_PROPAGATION =3D 1,
> >         MOUNT_ATTR_SECURITY,
> >         MOUNT_ATTR_SECURITY_1 =3D MOUNT_ATTR_SECURITY,
> >         MOUNT_ATTR_SYNC,
> >         MOUNT_ATTR_TIME,
> >         MOUNT_ATTR_SECURITY_2,
> > };
>=20
> In UAPI headers, always explicitly number your symbols, even in an enum, =
just
> to make sure that the numbers don't get transparently changed by accident.

+1 and thanks for the tip!

>=20
> > These flags will likely become AT_* flags or be tied to a syscall
> > afaict.
> >
> > #define MS_REMOUNT      32
> > #define MS_BIND	        4096
> > #define MS_MOVE	        8192
> > #define MS_REC	        16384
>=20
> MS_REMOUNT: fd =3D fspick(); fscommand(fd, FSCONFIG_CMD_RECONFIGURE);
>=20
> MS_REMOUNT|MS_BIND: mount_setattr().
>=20
> MS_BIND: fd =3D open_tree(..., OPEN_TREE_CLONE); move_mount(fd, "", ...);
>=20
> MS_MOVE: fd =3D open_tree(..., 0); move_mount(fd, "", ...);
>=20
> MS_REC: AT_RECURSIVE
>=20
> > Internal sb flags will not be part of the new mount attr sets. (They
> > should - imho - not be exposed to userspace at all.):
>=20
> Agreed.
>=20
> > What remains is an odd duck that probably could be thrown into security
> > but also *shrug*
> >
> > #define MS_I_VERSION    (1<<23)
>=20
> Um.  I think it would probably belong with atime settings.
>=20
> David

--ouaxp4t3sd3or2bq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE7btrcuORLb1XUhEwjrBW1T7ssS0FAluo5BcACgkQjrBW1T7s
sS0O5w//UJUVK32uvIzX3Bbr7rxqWvq7kBRP952YMXnbqFhQFVE3C2oLRZ4EE4NT
w1N+1MZQ4Rrf7Q5627Z529hyYCe0BfJSHyf3fkGyWX2wvdt1DOQtzW4PSdIFKZ4Z
bF9h92cZtHGJwipRkMFZFKbpy93A87QKYrwtTDN1Rz0+OlwEF6vyewVk0gLSjrdw
7CR8OnebLVjquhZXdunbkGkewh4Dz8OHmTWILXzqUEHkVxY62KljzCsuUn+fZsGn
y+vKmCWRsTP8JXLzjD6yZqi031uy/LDv5evhQn3tmt9w8kJl5KLUNDaRYUwSmjS/
ih6BPmFp5xcuRdC+eAg2T3A6dgK9fg2nXp4OP7e3JWS89BdzmyYng8H31JXES9l9
tAcK6UZdgOPwSrQY2dhATKS5lnybA3tqa3wcbS/oLuGZxGraU208tRGcfjZiXHVf
G2XgWkvdxYY+nSpJdWKTLhQQnyDy+oMCcKp/m8kB1jjAz9HrsuP5TF/OSUnSzJz3
bniuNK6h38UZi8xvF5G8JhFrKLPzclKZog4lguSEt/1EYmLANbZTcj+pC7iZxri8
YEHL20IIcrB+Q98RqCbrOB4lSO0+3ksacLYGky1On9qddvjaa1/Qbn+pNaRjgfAr
HrRpQiJ1sw8q2U3iHRN/j3G6+/9dUz5e3DsjSTXwfwGuYMGnurk=
=zvds
-----END PGP SIGNATURE-----

--ouaxp4t3sd3or2bq--
