Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9563CC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2FC20666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCbDxecb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2FC20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbeJBDGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:06:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33950 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeJBDGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 23:06:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id z4-v6so14035278wrb.1;
        Mon, 01 Oct 2018 13:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FLHnXhzjSkHGW8vf/FsYcORweQj0oqHcHRWPcFW11KY=;
        b=MCbDxecbWS+xXa56UdtlkG2aICUTOoqLWovcBJpteDoWla3VDuC1vMGRIiSjtT52hu
         xHUslJPCVp9Vi5XqfOj44zir89UUYxcnd8HTs9v09dSsPJoFnF8wgT0Va+D+Yu6Kpv8K
         RWUSxEFFud14FyvcBxVW/aA+wxQ7IZc9YLRoXHvRNMp7HseUqkBVFJsXLhWY05TpQY9n
         FjETiTKTwh8tJxkKR87KrkUKqdzpOfJPVVeHvfFc2PUaJvAGy+BoBWBkkNXdQ+/wLYJF
         IG6fujhZ9x8dplyP+NueZtVcIPYMJu1apwFmWZPBqM20IaRtvEJ/dw5F7fmp9OLufUqz
         ZCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FLHnXhzjSkHGW8vf/FsYcORweQj0oqHcHRWPcFW11KY=;
        b=EotjGjWxT6wNB5eXRDRHvOYh9tHK4jOPcIiuYVjnvK4y9Brk7unaQhwcvLbjuoH+d+
         oQkn7X7V5bxIdznwhZ5mQNGId2Fm44HYRFt47CUBeL3YmA6CWgc44bm2HPHKkYCyscPK
         /vIDMYKRjl2OsG9ZEptPgZtCx3Igu8syqkgbUcdg9SHaYL5lI75Hwqxi2Ed539u56uYk
         ILfp9B/GRXTnUMZOxIckDIIZV8Rg44LSVHn5xe4WdGK8YhcCuvUWvbzbL7rtaq2luiqg
         I+koS11DYCrsF0XOHxhAolUq8xcBzFst8QhJUbN1lf+oegT57zNxAodW0foBwhy5oUMe
         /hfQ==
X-Gm-Message-State: ABuFfoj4EGsX5mCDrryxIc57zw5MeCCYTcn7hGdB1OgmL1M1T7mJgMJI
        +u3VZLFF98UhM4Q1hvCKf52aBSj8
X-Google-Smtp-Source: ACcGV62ACjniy6IQQJF+2Lf1qR5DxDRmNnBrgtyEv7QQoQiBRmlQAEWz9E2dBIW+aUidfgPD3R+6gw==
X-Received: by 2002:adf:a1dd:: with SMTP id v29-v6mr8016513wrv.50.1538425619493;
        Mon, 01 Oct 2018 13:26:59 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id e21-v6sm1527110wma.8.2018.10.01.13.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 13:26:58 -0700 (PDT)
Date:   Mon, 1 Oct 2018 22:26:57 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>
Subject: Re: Race-free unlinking of directory entries
Message-ID: <20181001202657.cwmsroyrfal47ure@pali>
References: <20171220191844.wnb3bgkpreg2tjia@pali>
 <20180409074241.2ibvhh3g5lzxnt4g@pali>
 <20180409095919.GA9621@infradead.org>
 <20180409101009.6kxd47jeowef7wt2@pali>
 <20180409102414.GA23471@infradead.org>
 <20180409103554.64flwtm5xamhrkkp@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mnqj4zlmv7w4vhja"
Content-Disposition: inline
In-Reply-To: <20180409103554.64flwtm5xamhrkkp@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mnqj4zlmv7w4vhja
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday 09 April 2018 12:35:54 Pali Roh=C3=A1r wrote:
> On Monday 09 April 2018 03:24:14 Christoph Hellwig wrote:
> > On Mon, Apr 09, 2018 at 12:10:09PM +0200, Pali Roh=C3=A1r wrote:
> > > Another example:
> > >=20
> > > fd =3D open("/a")
> > > link("/a", "/b")
> > > unlink("/a")
> > >=20
> > > Calling funlink for fd should unlink "/b" or it should fail?
> >=20
> > It should fail, as '/a' doesn't refer to name that is visible in the
> > namespace.
> >=20
> > > And another example:
> > >=20
> > > fd =3D open("/a")
> > > rename("/a", "/b")
> > >=20
> > > What should funlink do for fd now?
> >=20
> > remove the directory entry refering to '/b' as that is what fd refers
> > to.
>=20
> Why it should differ in these two cases? Calling /bin/ln /a /b followed by
> /bin/rm /a results in the same state as calling /bin/mv /a /b. This is
> something which works in POSIX systems.
>=20
> I think it is strange that new possible funlink call would work only if
> external applications uses /bin/mv and would fail if /bin/ln and /bin/rm
> are used.
>=20
> This is reason why I suggested two parameters funlink, it takes fd for
> unlinking and pathname which must contain same inode as fd. So when you
> call it with fd+"/b" it unlink "/b" without failing.

Imagine that you have opened file descriptor in your program and you
want to unlink file behind that file descriptor.

Now some external process rename that file via rename() syscall and
based on your argument unlinking file descriptor in your program pass.

But if that external process do link() syscall followed by unlink()
syscall -- to simulate rename operation -- then based on your argument
unlinking file descriptor in your program fails.

I think this is really inconsistency which is not so good.

=2E..

Has somebody else opinion on this problem?

Because I still think that funlinkat() syscall has its usage.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--mnqj4zlmv7w4vhja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCW7KDDgAKCRCL8Mk9A+RD
UseNAKCCrV3tRUgGgxxj5D9e/voOeC0QCACgrEH69kxaVW0Uh3CLsTGjrNvzet4=
=wkNm
-----END PGP SIGNATURE-----

--mnqj4zlmv7w4vhja--
