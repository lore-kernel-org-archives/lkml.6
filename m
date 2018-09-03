Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2F3C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41C420869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=austad-us.20150623.gappssmtp.com header.i=@austad-us.20150623.gappssmtp.com header.b="0zbvydU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B41C420869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=austad.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbeIDAx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:53:57 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:37282 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbeIDAx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:53:57 -0400
Received: by mail-lj1-f177.google.com with SMTP id v9-v6so1330275ljk.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 13:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austad-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Io1qT+qXXptYjpKmHi2VlaVG143Dv02mojjf1V+lOk=;
        b=0zbvydU977VcCBDOVkIkzRGbJ10bGbisgbewkoUyIFlMvy9EZXrVN1HGXmf/B34J9z
         rMrJ7acs4/rmLnkh1iMnN/HM077558C2EAsxO0SaKvFueI9M5eaQdapEgtuvAR4JAnpE
         mWAINonTiaCt6He8QH/nc6wWNTNOodojvCI6QQiRZqv2/KDsmGoX92xk1uc0yEMnNjM3
         BN0B0B6eIKCBtF9UidrwX6HbGqss1oa3k2NQHmC5cnymmZZgaTRqEQvQeoyKX0l7Y6x4
         PHr+YQsikHwc6Vu1F5Qavk5KO0A1MX7U87JVo3cfOMH5qkB43ziJIwmXMQ1vuGZKXnYs
         9QkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Io1qT+qXXptYjpKmHi2VlaVG143Dv02mojjf1V+lOk=;
        b=uMm+YVNVqVU5bzr8P/+9ziNcKgWRWrPxEgNdRlivoi3otQ+dXl80y3SNvEGZxpNMBR
         YwyyKMQSCiUVlimq0fcTOjUys2xgvF6JB3gJxWOCtZBPxL0TgRPxnToFvWuuD2wsky13
         sOWgGJIA19+fHHOkZCWkNDezDhcUmZosKUf9wrUExzqGIs8uxQ+gmU1a8fCBaoMllqDp
         wSfI/yv8HWcOBXkXZeK9rPkIYX+nZmdDBO1TzWWv2d4EPWvxlQFIXYzsohmPV2FPfWPe
         KGW022LWrBgtCe5t5+6jshP3prAD4maFd72jDve2eWiQFlFYox751r+D9wtQNPhYMRIa
         hi6g==
X-Gm-Message-State: APzg51Bmno9qhzSwug7Vnw0ypwS2i8xcWmTauLN9QhUZjdeyXolmXMRc
        uhwdSD4SufPaQ2dojgyO/1agLXzZ9Q8qxK+9
X-Google-Smtp-Source: ANB0VdZgMPuThSihRf8wpv9btB/sXA+GvCsuQ64EfN5YkeJOweYts3N5/gZXVPaQrOkBD0ID+9UllA==
X-Received: by 2002:a2e:9b59:: with SMTP id o25-v6mr17858359ljj.132.1536006724605;
        Mon, 03 Sep 2018 13:32:04 -0700 (PDT)
Received: from sisyphus.home.austad.us (11.92-220-88.customer.lyse.net. [92.220.88.11])
        by smtp.gmail.com with ESMTPSA id j135-v6sm3654460lfj.91.2018.09.03.13.32.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 13:32:03 -0700 (PDT)
Date:   Mon, 3 Sep 2018 22:32:01 +0200
From:   Henrik Austad <henrik@austad.us>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] Drop all 00-INDEX files from Documentation/
Message-ID: <20180903203201.GA11920@sisyphus.home.austad.us>
References: <1535545728-8402-1-git-send-email-henrik@austad.us>
 <58648986219ce0173ff45d34def0da9f9f34b55f.camel@perches.com>
 <20180903105542.GA9485@sisyphus.home.austad.us>
 <20180903124545.089ead51@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <20180903124545.089ead51@lwn.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2018 at 12:45:45PM -0600, Jonathan Corbet wrote:
> On Mon, 3 Sep 2018 12:55:42 +0200
> Henrik Austad <henrik@austad.us> wrote:
>=20
> > On Wed, Aug 29, 2018 at 09:20:30AM -0700, Joe Perches wrote:
> > > On Wed, 2018-08-29 at 14:28 +0200, Henrik Austad wrote: =20
> > > > The 00-INDEX files are supposed to give a summary of all files pres=
ent
> > > > in a directory, but these files are horribly out of date and their
> > > > usefulness is brought into question.
> > > >=20
> > > > A few years back it was mentioned that these files were no longer
> > > > needed, and they have since then grown further out of date, so perh=
aps
> > > > it is time to just throw them out. =20
> > >=20
> > > Good idea.
> > >=20
> > > .rst is becoming more common and these 00-INDEX files
> > > are unnecessary and occasionally misleading. =20
> >=20
> > Ok, should I respin and clean up all the other files referencing 00-IND=
EX=20
> > and send to a wider audience?
>=20
> Wider audience might be good.  I've not yet decided whether I think this
> is a good idea or not.  We certainly don't need those files for stuff
> that's in the RST doctree, that's what the index.rst files are for.  But I
> suspect some people might complain about losing them for the rest of the
> content.  I do get patches from people updating them, so some folks do
> indeed look at them...

Yes, hence the RFC. As I said, I'm happy to update the 00-INDEX-files, but=
=20
if we decide not to keep them, I rather not spend time on it.

Let me respin and add a few references to 00-INDEX from other files and see=
=20
if we can decide what color to paint this particular bikeshed in a wider=20
audience :)

--=20
Henrik Austad

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluNmkEACgkQ6k5VT6v45ln0WwCgmKksT4bQj0By6L5voXaGo5Ds
0kAAnAxYRqh+FL9uea9kygyTUz8Rz4mN
=vC82
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
