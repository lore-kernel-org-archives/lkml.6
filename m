Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827C9C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACEF2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QEQCUWg+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ACEF2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbeJIChU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:37:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59002 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbeJIChU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=snJoplR6JThjVb49dH/rz/cj9gqwHmyjtsCdxCwnUkw=; b=QEQCUWg+JaIxpNmSNfEid/kB2
        u8mDSySWaauzERSddBOQiNNaVIDgim30DCUFPzmuAAcAQb5/05FrKpuwU9GWQojb7NbkLtWv1C+CK
        PmozWm4i/tVhJBJkp5PaM0EHngMx8vJccrIcLzSYJqtyeQ7Mu6c88W9kz+/ecZbpq9w4eSy1iAOxV
        A4fsAVpaEMAwKW2bEzEz3cvZK3hJtAEaurdQtebf4hNOdd1Pyl0kCYwI/sGj08VUBFoytnO6qwmTP
        R+Vozuqs99Dg3VzK4l3aiEPNr6dgQaUMvZy98ivgTpK685RYKHSOYnqLaflVpgxRAKhRbOPAmV10s
        rv/GJH90Q==;
Received: from [179.183.98.126] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9b8K-0006zr-TT; Mon, 08 Oct 2018 19:24:01 +0000
Date:   Mon, 8 Oct 2018 16:23:57 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] [PATCH 1/2] code-of-conduct: Fix the
 ambiguity about collecting email addresses
Message-ID: <20181008162357.7004ba48@coco.lan>
In-Reply-To: <1539012620.4344.5.camel@HansenPartnership.com>
References: <1538861738.4088.5.camel@HansenPartnership.com>
        <1538861799.4088.6.camel@HansenPartnership.com>
        <20181008152043.GA5796@localhost>
        <1539012620.4344.5.camel@HansenPartnership.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 08 Oct 2018 08:30:20 -0700
James Bottomley <James.Bottomley@HansenPartnership.com> escreveu:

> On Mon, 2018-10-08 at 08:20 -0700, Josh Triplett wrote:
> > On Sat, Oct 06, 2018 at 02:36:39PM -0700, James Bottomley wrote: =20
> > > The current code of conduct has an ambiguity in the it considers
> > > publishing private information such as email addresses unacceptable
> > > behaviour.=C2=A0=C2=A0Since the Linux kernel collects and publishes e=
mail
> > > addresses as part of the patch process, add an exception clause for
> > > email addresses ordinarily collected by the project to correct this
> > > ambiguity. =20
> >=20
> > Upstream has now adopted a FAQ, which addresses this and many other
> > questions. See https://www.contributor-covenant.org/faq .
> >=20
> > Might I suggest adding that link to the bottom of the document,
> > instead? (And then, optionally, submitting entries for that FAQ.) =20
>=20
> We can debate that as part of everything else, but my personal opinion
> would be we should never point to an outside document under someone
> else's control for guidance as to how our community would enforce its
> own code of conduct.

Fully agreed on that. The same argument that we use for GPL 2 only
applies here: we should stick with an specific version of this it, in
a way that we won't be automatically bound to whatever new version
of it would say.

Btw, the term "social contract" is there at the FAQ. At least in
Brazil, as far as I can tell, there's no distinction of a "social
contract" and a "contract". From what I understand, both will have
equal legal value.

Thanks,
Mauro
