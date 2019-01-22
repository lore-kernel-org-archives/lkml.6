Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF3FC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7B220823
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="1sNZKwjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfAVJRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:17:46 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:4592 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbfAVJRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:17:45 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 5C8FC365;
        Tue, 22 Jan 2019 10:17:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1548148661; x=1549963062; bh=Sy9fz5u8T6Z9GyAEQ9KlgkUvpSAzdBo8ty7
        rb+lWWq4=; b=1sNZKwjXrYpcnAUF7+GL+wgQt81zAudZQ1TmzY4gGsQihOJUda8
        SEslQrCKBUzR1vYDKOfcMGnJBCHAkYT+1blK5CoLISvIm41ukhj6UA6oldEBBplg
        fIFxz5V4aEDe2wo/03bsiyfDQ08UulJTpDN9B/Sn0hxdFw0ghETP+gE5n/bWsguf
        0WsStwtl4nx3LprE7nmq+I6It+akTyqIb367KX1n7znBqrtGYvLkuAuXqO3Sbzl6
        rpPHD4ExJrZnMMKpvSuKedwi9E/I99mBU2T55HUmyUkKuEElb+imhUx3ygO20tDK
        hEC7fjccPEe3ywsg8trSsz/6mdn07IW8hAx6SFOL3a7npc89x4Xsx4JjCy5bYP7O
        8rVl+W+aGMvN9Y0RYm1/TkKyVaQnRx0SMNS15aXxi+uFSyhfkwoIIt9x453iaBad
        V/cYDchDnSKtkVljSQKCCb9KtmBVx3VkRat+uc8K+UXJZ93EHG9wa0EK6UV7tuD0
        viKqY/Dj2JpgF/W9Rfv+aHvU8Sqn3ek5vWXts+OtEFUEFXna8fDuYtcAcwlY4FLj
        3Zw6xwqA36eoTIINOBwNz0nOH3nCUj4VVqIYDvYOiIT80Uynv+NOw1IA6xAqGoOw
        1TKUF3ZsCUko44DEsMJYTMkrOump8rQ7ljEHdXoL2JArWfqQ3AJORXtA=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TyOWCGE6S0LL; Tue, 22 Jan 2019 10:17:41 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id DAEB031F;
        Tue, 22 Jan 2019 10:17:41 +0100 (CET)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 880AF2513;
        Tue, 22 Jan 2019 10:17:41 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Greg KH <greg@kroah.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc:process: remove note from 'stable api nonsense'
Date:   Tue, 22 Jan 2019 10:17:40 +0100
Message-ID: <7591367.SLz3PkBNkD@pcbe13614>
In-Reply-To: <20190121083708.GA6462@kroah.com>
References: <20190118215804.3340-1-federico.vaga@vaga.pv.it> <53383524.y9DmdCAcNX@pcbe13614> <20190121083708.GA6462@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, January 21, 2019 9:37:08 AM CET Greg KH wrote:
> On Mon, Jan 21, 2019 at 09:14:00AM +0100, Federico Vaga wrote:
> > On Monday, January 21, 2019 2:43:38 AM CET Jonathan Corbet wrote:
> > > On Fri, 18 Jan 2019 22:58:04 +0100
> > >=20
> > > Federico Vaga <federico.vaga@vaga.pv.it> wrote:
> > > > The link referred by the note can't be retrieved: this patch just
> > > > remove that old note.
> > > >=20
> > > > Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> > > > ---
> > > >=20
> > > >  Documentation/process/stable-api-nonsense.rst | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/Documentation/process/stable-api-nonsense.rst
> > > > b/Documentation/process/stable-api-nonsense.rst index
> > > > 24f5aeecee91..57d95a49c096 100644
> > > > --- a/Documentation/process/stable-api-nonsense.rst
> > > > +++ b/Documentation/process/stable-api-nonsense.rst
> > > > @@ -171,8 +171,7 @@ is also a rough job.
> > > >=20
> > > >  Simple, get your kernel driver into the main kernel tree (remember=
 we
> > > >  are talking about GPL released drivers here, if your code doesn't
> > > >  fall
> > > >=20
> > > > -under this category, good luck, you are on your own here, you leech
> > > > -<insert link to leech comment from Andrew and Linus here>.)  If yo=
ur
> > > > +under this category, good luck, you are on your own here, you leec=
h).
> > > >  If
> > > > your>
> > > >=20
> > > >  driver is in the tree, and a kernel interface changes, it will be
> > > >  fixed
> > > >  up by the person who did the kernel change in the first place.  Th=
is
> > > >  ensures that your driver is always buildable, and works over time,
> > > >  with
> > >=20
> > > I've applied this.  I do wonder if the "you leech" should maybe come =
out
> > > too, though.  I don't think that parasitic worms are a protected class
> > > under the CoC, but they might still suffer emotionally from being
> > > compared to the purveyors of proprietary modules...
> >=20
> > I agree, do you want me to change the patch?
>=20
> I would leave it as-is for now please.  When this was written, there was
> a lot of discussion about closed source modules, and how the companies
> that created them were leeches on our development community.  No one
> disagreed with that statement, and a number of companies privately
> agreed with us.
>=20
> That still has not changed.
>=20
> So I would like to see this remain.

I agree on the message, but I disagree on the usage of "you leech".

My 2 Cents

I do not like political correctness statements, but in this case the docume=
nt=20
is talking to other developers - who typically do not take decisions about=
=20
license - and comparing them to a leech: isn't it too much?


Alternatives without direct comparison to leech.


Here, I just played with punctuation to create some emphasis around "You ar=
e=20
on your own here".
=2D----8<-----
Simple, get your kernel driver into the main kernel tree. Remember we are=20
talking about GPL released drivers here, if your code doesn=E2=80=99t fall =
under this=20
category, good luck. You are on your own here.
=2D----8<-----

And here I just made the reference indirect
=2D----8<-----
(remember we are talking about GPL released drivers here, if your code does=
n=E2=80=99t=20
fall under this category, good luck, you are on your own here, leeching has=
=20
its negative sides)
=2D----8<-----


I will not insist more, it is just a minor discussion about the rights of a=
=20
poor worm :)

>=20
> thanks,
>=20
> greg k-h


=2D-=20
=46ederico Vaga
http://www.federicovaga.it/


