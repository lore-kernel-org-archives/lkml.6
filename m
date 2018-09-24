Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976DEC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427B120989
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="HImeo+vG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427B120989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbeIXPtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:49:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39042 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbeIXPtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:49:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id q8-v6so9326067wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 02:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gm6HYZr4sWxgC9KrqZ72BlK5PTIojuM4EYLhtKwFCzM=;
        b=HImeo+vG2wflpyZi14r+pv1H0oS9B5nDQIHPMVnhDlVaWiMZIylA6rX/sT7wxMzDaa
         bhvWmiqNRxR5o13bcIqZiiMwA6+0Il8PN5yk2l+8Xpkf4hr/wXMNOPa8DD+N1NmSllk7
         q0yTNHoCpTDWzf/PYuIQtcxvvdBgpwHpIa3wfLb8VF0SPDQ1mmGgOedDc8jvVOuLH7kl
         BMLvQCRPQGHOzF3UxtcdTZ3s2ztEx2v4fU33DbEjyuleX4fDcgGYm702CYxB/88z30se
         w61yoKaAENi8Yd3fgYAKTzUx52Dgr64WJQi/tAcbMG8MFbE0fvFJ8W45mBS1wYWVlhdz
         hNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gm6HYZr4sWxgC9KrqZ72BlK5PTIojuM4EYLhtKwFCzM=;
        b=ZANN+V9uefWJH1xHKtEKvBhcrRCjw73IJ0cB4qoM/FhK0cRoXGuFtBQOSQKJJPSSD9
         ae8VBMaqf6rTU7VuxqypZ7KQT4wtiuOxQ3wMuEIJNf1/rcaSJmY2rgVIAsQ37QVB3d36
         XueXW0Z5i2xTxR3BMdafJi5nrOslCOdefJW8bGwbFAGVDBn8fgiiUze7CpaIRYMt3dc1
         pQDF1n7JM3QpZL+vmIU5C0mTX88cR2yZMaipT9xRVKWlujPEU33sd/+WC4LXOOyj3Gy7
         BUrMkTwTsF2al8Q6k9qll9dxLHlAMC+Mx15SHyRpXjta5UD1+sQCAsE5ukiRbx/sFIvz
         IK+Q==
X-Gm-Message-State: APzg51C4CcvA2sBi98FGsN8TiYFBilecob1mX4zWnUdRkT8C+lrMIs4o
        ViD9SdEBLkvcU7Mv8Y7w3zxIMA==
X-Google-Smtp-Source: ANB0VdZHYDHRwxLlbgyjXjfQ+8YEuvoFKUM98qtSmtl4T8dHiAp9l5mN3gjAd2pj2b7vGuagsBuk1Q==
X-Received: by 2002:a1c:a386:: with SMTP id m128-v6mr6036128wme.139.1537782479006;
        Mon, 24 Sep 2018 02:47:59 -0700 (PDT)
Received: from brauner.io ([88.128.81.117])
        by smtp.gmail.com with ESMTPSA id a203-v6sm13901846wmh.31.2018.09.24.02.47.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 02:47:58 -0700 (PDT)
Date:   Mon, 24 Sep 2018 11:47:56 +0200
From:   Christian Brauner <christian@brauner.io>
To:     David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] fsmount: do not use legacy MS_ flags
Message-ID: <20180924094755.lkwdbrrayfrp45uu@brauner.io>
References: <20180922161406.6beo2ob6ki2otrjx@brauner.io>
 <20180922132106.wfa6xaxwbu276qka@brauner.io>
 <20180921155455.flkf5vdrm3vgn6do@brauner.io>
 <20180920151214.15484-6-mszeredi@redhat.com>
 <20180920151214.15484-1-mszeredi@redhat.com>
 <17157.1537542475@warthog.procyon.org.uk>
 <20311.1537548756@warthog.procyon.org.uk>
 <8221.1537631312@warthog.procyon.org.uk>
 <3868.1537742717@warthog.procyon.org.uk>
 <30364.1537771838@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="agm3bumfxevf7fv5"
Content-Disposition: inline
In-Reply-To: <30364.1537771838@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--agm3bumfxevf7fv5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 07:50:38AM +0100, David Howells wrote:
> Christian Brauner <christian@brauner.io> wrote:
>=20
> > Ok, understood. What about passing the different attrs as a struct?
> >=20
> > struct mount_attr {
> >         unsigned int attr_cmd,
> >         unsigned int attr_values,
> >         unsigned int attr_mask,
> >=20
> > };
> >=20
> > mount_setattr(int dfd, const char *path, unsigned int atflags,
> >               struct mount_attr *attr);
> >=20
> > I find that to be a little cleaner in all honesty.
> > One could also add a version argument similar to what we currently do
> > for vfs fcaps so that kernel and userspace can easily navigate
> > compabitility when a new member gets added or removed in later releases.
>=20
> Yeah, we could do that - it's not like I expect mount_setattr() to have t=
o be
> particularly performant in the user interface.  I would put the attr_cmd =
in
> the argument list, probably, so that you can use that to vary the struct =
in
> future (say we run out of attribute bits).

Yes, that makes sense and mimicks standard ioctl() behavior. So

struct mount_attr {
        unsigned int attr_values,
        unsigned int attr_mask,
}

mount_setattr(int dfd, const char *path, unsigned int atflags,
              unsigned int attr_cmd, struct mount_attr *attr);

I have thought a little more about splitting up the mount flags into
sensible sets. I think the following four sets make sense:

enum {
        MOUNT_ATTR_PROPAGATION =3D 1,
        MOUNT_ATTR_SECURITY,
        MOUNT_ATTR_SYNC,
        MOUNT_ATTR_TIME,
};

MOUNT_ATTR_PROPAGATION:
#define MOUNT_ATTR_PRIVATE    (1<<0)
#define MOUNT_ATTR_SHARED     (1<<1)
#define MOUNT_ATTR_SLAVE      (1<<2)
#define MOUNT_ATTR_UNBINDABLE (1<<3)

MOUNT_ATTR_SECURITY:
#define MOUNT_ATTR_MANDLOCK     (1<<0)
#define MOUNT_ATTR_NODEV        (1<<1)  =20
#define MOUNT_ATTR_NOEXEC       (1<<2) =20
#define MOUNT_ATTR_NOSUID       (1<<3) =20
#define MOUNT_ATTR_NOREMOTELOCK (1<<4)
#define MOUNT_ATTR_RDONLY       (1<<5) =20
#define MOUNT_ATTR_POSIXACL     (1<<6)
#define MOUNT_ATTR_SILENT       (1<<7) =20

MOUNT_ATTR_SYNC
#define MOUNT_ATTR_DIRSYNC     (1<<0)
#define MOUNT_ATTR_SYNCHRONOUS (1<<1)

MOUNT_ATTR_TIME:
#define MOUNT_ATTR_LAZYTIME    (1<<0)
#define MOUNT_ATTR_NOATIME     (1<<1)
#define MOUNT_ATTR_NODIRATIME  (1<<2)
#define MOUNT_ATTR_RELATIME    (1<<3)
#define MOUNT_ATTR_STRICTATIME (1<<4)

If we ever run out of flags in a specific set I suggest to introduce a
new enum member of the same name with a version number appended and an
alias with a (obvs lower) version number for the old set. A concrete
example would be:

enum {
        MOUNT_ATTR_PROPAGATION =3D 1,
        MOUNT_ATTR_SECURITY,
        MOUNT_ATTR_SECURITY_1 =3D MOUNT_ATTR_SECURITY,
        MOUNT_ATTR_SYNC,
        MOUNT_ATTR_TIME,
        MOUNT_ATTR_SECURITY_2,
};

These flags will likely become AT_* flags or be tied to a syscall
afaict.

#define MS_REMOUNT      32
#define MS_BIND	        4096
#define MS_MOVE	        8192
#define MS_REC	        16384

Internal sb flags will not be part of the new mount attr sets. (They
should - imho - not be exposed to userspace at all.):

#define MS_KERNMOUNT    (1<<22)
#define MS_SUBMOUNT     (1<<26)
#define MS_NOREMOTELOCK (1<<27)
#define MS_NOSEC        (1<<28)
#define MS_BORN	        (1<<29)
#define MS_ACTIVE       (1<<30)
#define MS_NOUSER       (1<<31)

What remains is an odd duck that probably could be thrown into security
but also *shrug*

#define MS_I_VERSION    (1<<23)

Christian

--agm3bumfxevf7fv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE7btrcuORLb1XUhEwjrBW1T7ssS0FAluosssACgkQjrBW1T7s
sS3gYhAAm3KARS3C3Q4qtCsgVqikraFdr9uZTqJ38TiDZLkHr1bJDUsFR2HLdKWq
Mvv6u0ID8mg6jrYxU9Vgo6nHqd5HnX/YKIviOYYI4R5YQTCig48HmgnOgk+DJI/g
W/U3PaPowkbcPMdryXfSEV1AgRZCvouwr48H/C34lYe9ONPrIJCbI3J6AsxMiTI1
92vLM3vIkBfBtvh00vzgAeOH+gl3ik+NltEGMAgASoAkS9w784pnKcHGA+anci3s
BF85KL63OT3brUHwB1/e7CvmTsQRf0cn/KC75yK/KrGXOQYvHAEPV6ySyBDAVs54
sRzDpbIaX809TsjBEE1uknPNhlLZVvM+JqZbnPaNjt2S5mxkLF0tM/Kkfbae0YmC
joquTl++IuNpZIFKz2e2SyW+OKSHApDJ/ud4QX8PwM5mlugpuZIjEOwkJeSOP+pT
lpB71sNjYhjrxYD4upYA1cGaWWSvbl80YIWYQnNN7By7dI9X7iXMb8SIijeOm9lD
rYNCEkjn4RkCgRtikOMODAMudHcuMT8dYV3kv3/LO1iRPs3gm//pMXpok6Qbx+N9
ZoXB72P0o/0n3fegPROBVhZteH1U2wsJ0GEaHSUbLnavGt4IGPksce8EsC/3uOxb
9+fHQocGos3i11MsybQKAspwOzJfjk0teug9sImUu+t9BjhhFz4=
=yzeQ
-----END PGP SIGNATURE-----

--agm3bumfxevf7fv5--
