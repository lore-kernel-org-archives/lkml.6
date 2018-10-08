Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8DFC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481532089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nzx3q2Gv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481532089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeJIDDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 23:03:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34920 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbeJIDDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 23:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WG7Dk5OPpOMO1UTYw/FTHl05v5IkuVTYd6nps4K8U1s=; b=Nzx3q2Gvo94fMji9maSz2OJYl
        /yh3mQn8Z+AlpGC+IrmHMY4QqtyhGWpMFr9gAmR8I3VO5VI7VuV/POZDuzi2XApfyttNRQCyfX/go
        9qwVRp4l+LHFVfqQDy0WdHq8UWCVGGJDhE5dkq/bDULujXy1DZHkZw2Q7FnLTbwNDyAxJA+xW4MgW
        um52ldaqFhomc7c41SwZOQH7Ch9pH8U/erwZnGZQHhrIlLR1uPIg/0geCz4ZpiV1sso6RqoF/FhDF
        gshsI9niBU6VZZ9jaHSvLlzSnheVbmzFgYB26viweFTsd9oSPStYeQCIuk8hwqTfgWDcifMae76Qf
        WnqhGDpKQ==;
Received: from [179.183.98.126] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9bXN-00074m-Fv; Mon, 08 Oct 2018 19:49:53 +0000
Date:   Mon, 8 Oct 2018 16:49:50 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] [PATCH 1/2] code-of-conduct: Fix the
 ambiguity about collecting email addresses
Message-ID: <20181008164950.71793583@coco.lan>
In-Reply-To: <1538926141.4115.2.camel@HansenPartnership.com>
References: <1538861738.4088.5.camel@HansenPartnership.com>
        <1538861799.4088.6.camel@HansenPartnership.com>
        <CAKMK7uGvgttqL_RoXumd0F4w8UMqwaVODaMWnOZz5weSFzDJ2A@mail.gmail.com>
        <1538926141.4115.2.camel@HansenPartnership.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, 07 Oct 2018 08:29:01 -0700
James Bottomley <James.Bottomley@HansenPartnership.com> escreveu:

> On Sun, 2018-10-07 at 11:04 +0200, Daniel Vetter wrote:
> > On Sat, Oct 6, 2018 at 11:36 PM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote: =20
> > >=20
> > > From 4a614e9440148894207bef5bf69e74071baceb3b Mon Sep 17 00:00:00
> > > 2001
> > > From: James Bottomley <James.Bottomley@HansenPartnership.com>
> > > Date: Sat, 6 Oct 2018 14:21:56 -0700
> > > Subject: [PATCH 1/2] code-of-conduct: Fix the ambiguity about
> > > collecting email
> > > =C2=A0addresses
> > >=20
> > > The current code of conduct has an ambiguity in the it considers
> > > publishing private information such as email addresses unacceptable
> > > behaviour.=C2=A0=C2=A0Since the Linux kernel collects and publishes e=
mail
> > > addresses as part of the patch process, add an exception clause for
> > > email addresses ordinarily collected by the project to correct this
> > > ambiguity.
> > >=20
> > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.c =
=20
> > > om> =20
> > > ---
> > > =C2=A0Documentation/process/code-of-conduct.rst | 2 +-
> > > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/Documentation/process/code-of-conduct.rst
> > > b/Documentation/process/code-of-conduct.rst
> > > index ab7c24b5478c..aa40e34e7785 100644
> > > --- a/Documentation/process/code-of-conduct.rst
> > > +++ b/Documentation/process/code-of-conduct.rst
> > > @@ -31,7 +31,7 @@ Examples of unacceptable behavior by participants
> > > include:
> > > =C2=A0* Trolling, insulting/derogatory comments, and personal or
> > > political attacks
> > > =C2=A0* Public or private harassment
> > > =C2=A0* Publishing others=E2=80=99 private information, such as a phy=
sical or
> > > electronic
> > > -=C2=A0=C2=A0address, without explicit permission
> > > +=C2=A0=C2=A0address not ordinarily collected by the project, without
> > > explicit permission
> > > =C2=A0* Other conduct which could reasonably be considered inappropri=
ate
> > > in a
> > > =C2=A0=C2=A0=C2=A0professional setting =20
> >=20
> > We've discussed this a bit with freedesktop.org people a while ago,
> > both from a CoC and privacy regulations pov, and we concluded that
> > attaching random people's emails in Reported-by: and similar lines,
> > without their consent, is indeed a problem. Bugzilla is rather
> > problematic in this way, since it looks like it's protecting your
> > email address and keeping it private, but then you can still just
> > grab it from the bugzilla emails without first asking for permission.
> > That's one of the reasons why fd.o admins want to retire Bugzilla in
> > favour of gitlab issues (where this is handled a lot more strictly). =20
>=20
> This is a code of conduct example of a violation.  While I agree we
> should exercise sensitivity in reporter expectations I don't think a
> maintainer getting it wrong should be equated to doxxing.
>=20
> In many ways, this is why having examples sections in quasi legal
> documents is a bad thing to do because it's arguable (as you have done)
> that if some behaviour isn't explicitly mentioned in the unacceptable
> examples it must be acceptable.
>=20
> Look at it this way: if a maintainer screws up and adds a reported by
> from someone who didn't expect their email to be published should that
> be treated as an immediate code of conduct violation by whatever
> enforcement process we come up with?  I think most maintainers would
> answer "no" to this.=20

Agreed.=20

I'd say more: what happens if someone adds a diff inside a bug
report? Not adding the author can be problematic too.

People should assume that, when reporting a bug, replying to
a patch, etc, his e-mail will be visible by people, and it can be
used when a fixup patch is produced. If someone doesn't want that,
it should *explicitly* say otherwise.

The text changes suggested by James reflects that: an e-mail sent in
private, with an explicit message saying to not use the personal
address is not an "electronic address not ordinarily collected by the
project".

Of course, it is up to the maintainer/developer that receives
such e-mails to either use its content, anonimizing the submitter
as requested (and eventually taking associated risks with regards
to GPL - if the email contains a patch) or to just ignore it.

Anyway, such "special cases" are the kind of thing that makes sense
on a FAQ, and not at the letter of the document itself.

Thanks,
Mauro
