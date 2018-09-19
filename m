Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A83ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823E6206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ClgPLOyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823E6206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbeISQIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 12:08:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbeISQIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 12:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iqr09i23TZhkGDBYDAY58mBBUgRGl1Cde3DyDerKDpY=; b=ClgPLOyFxw0g+wcyf3qr20SrG
        Hbr1T19nN79o/85riL0kHYQtCgVdbB6+SUXqysSM0tCTjtJvZBHK8/JBTcp7h2ZLjLcdVf9YmJ4e0
        jsAbFw3lOCNzgv44X1Ik2p95uWOh4NS4bE67sEpz/pRW8lrszuMINWTCaPu8DzBBVmXhiiofc3Rbq
        iBHvA9hlBtOjwPKVeE2Z/nRXSD9XD1ARkvdQF7fvVX5Vh1Ia9seSgxLXofP3z1F6mhbOO/KaguImT
        jfkxKFLj/7WS1yea6DAQ+Tq7cwxnlItcUvbHmKurnC7JxQloteTABQKYgDxhUkRtcojjqd354yvZj
        YH+HJMqng==;
Received: from 177.41.113.87.dynamic.adsl.gvt.net.br ([177.41.113.87] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2Zki-0002kk-CT; Wed, 19 Sep 2018 10:30:36 +0000
Date:   Wed, 19 Sep 2018 07:30:30 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>, Chris Mason <clm@fb.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Olof Johansson <olof@lxom.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Code of Conduct: Let's revamp it.
Message-ID: <20180919073030.3629bc7f@coco.lan>
In-Reply-To: <20180918191613.GD4501@amd>
References: <20180917114852.hzo36b2fewdzqc4t@wunner.de>
        <20180917122430.GA3320@kroah.com>
        <20180918191613.GD4501@amd>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 18 Sep 2018 21:16:14 +0200
Pavel Machek <pavel@ucw.cz> escreveu:

> On Mon 2018-09-17 14:24:30, Greg Kroah-Hartman wrote:
> > On Mon, Sep 17, 2018 at 01:48:52PM +0200, Lukas Wunner wrote: =20
> > > Seriously though, I read this to know what I need to be aware of but =
oddly
> > > the language of this paragraph says it doesn't apply to me:  I'm not =
using
> > > an official project e-mail address nor an official social media accou=
nt,
> > > nor has anyone appointed me as representative.  I can live with that,=
 I'm
> > > just wondering what the benefit of a document is that only seems to a=
pply
> > > to a tiny fraction of the community. =20
> >=20
> > I do not think you are reading the document correctly.  As an example,
> > it should cover any emails sent to this list.  That is not a "tiny
> > fraction" by my last count :) =20
>=20
> In typical "being nice but not really honest", you failed to answer
> the other question in this comment.
>=20
> Lukas asked:
>=20
> > > to a tiny fraction of the community.  Has this CoC been discussed
> > > anywhere?
> > > I'm not seeing it in the LKML or ksummit-discuss archive. =20
>=20
> And yes, I see problems with this CoC. You seriously expect "all
> maintainers" to ban Al Viro for commenting in his usual funny way?
>=20
> Derogatory comments are now prohibited, so what you do now when
> receiving bad code? Ignore it completely? _That_ is evil.
>=20
> What is wrong with =E2=80=99s in the document? Normal ascii is '. Same mi=
stake
> was in Linus' announcement. Does it have same author?
>=20
> Publishing email address without explicit permission is now
> prohibited. WTF? How does that interact with signoffs? Merging GPLed
> code is no longer allowed when the original author can not be reached?
>=20
> Who is author of the document? First signoff is by Chris Mason (is
> that signoff chain real?) but Greg is listed as author.
>=20
> The document does not describe current practices. It was not
> discussed. Yet it states that contributors pledge... and it tries to
> speak for me? That does not exactly sound like a positive environment
> to me.
>=20
> No thanks,

Agreed. Despite its "welcoming/nice language" (whatever it is), the way=20
it was written I can't see any good coming from it. It reminds code of=20
conducts used by some radical groups where it is up to the neighbors to
apply surveillance over their communities, in order to punish them.

Also, it turns maintainers into baby-sitters, forcing them to
do a lot of non-technical stuff in order to punish bad behaviors.
When they fail[1], the maintainers get punished.

[1] Maintainers sooner or later will fail: no maintainer I know has
PhD on psychology (or whatever it is required) in order to teach
good manners to grown ups.=20

Also, how someone would avoid a misconduct on "public spaces when
an individual is representing the project or its community"?

That basically states that no maintainer or Kernel developer can
ever be drunk on a LF party.

Sorry guys, no more beer :-)      (nor Scotch while in Edinburgh)

Thanks,
Mauro
