Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2198058-1520522870-2-6418886397220923200
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='at',
  MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520522870; b=G4VRrmUkagPdyuIkyN8nBdAzNEh5KaBihf6OZ7bLn6Kex+N
    hL6Gws5y+z8iIOYcp80MUc9SsR836gM/qSdJG14iJVQ8mvK/ljcjvvOebXacQm2k
    dOAelDiajmjRfLy0yyRvBmdu0fykBzfPsc6Urov3i3iU8ihEUfCP9KwGXgnniZB4
    YXmQvMjA0m5E/U7SPlDiehr0H7b5dEZ3q/E1ygZ5r8CGNGF2iY9lXnz0gqI3s6Nh
    zUzIveZ2i9rakCEY+7wZ6iKf8nt0cw4jgDodxRJ7Ex2LL977pYiritVVl4o30ToV
    XkzIfx4uvJZcpj9jFLxFloVx19bRiIFyrM2T6eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=arctest; t=1520522870; bh=q0wfVT
    4xcZY6q+8mCkTPIxQptqFSy7+T93gh7iolaHk=; b=edirpOedFoKEsOixe0JNow
    c9cVbSn4f9sfkQfs3vCBj5NCQLYlA9U/rSaVrY0NUlNr/4o4WCs6k7qLxXSY5/l0
    MvbRGMthnLW62EgysHOQJIYqVQgcIsdSvRzO36vxTkqcWez6rtKvnD1/BK+q6eFV
    1SS3wrYnK2unzVHF+HkY1DpIkKL+W411j8ldBEuHBHjiEdfB/hZcI4porEbPUYIe
    AIazuGQyTIgMNjp3rgCFJeJeTgbp/gUFAy7TP0cP5v+RN5lMvxsBbQRaKx19ETHq
    PMfSZ7Bjyx3oveeGMP8OJN0mnPPqh1a+NKx5tKmOaOiOB1jBzOKZxcqnlwb0P+Fw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=nod.at;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nod.at header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=nod.at;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nod.at header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932537AbeCHP1r convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Thu, 8 Mar 2018 10:27:47 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:48682 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754846AbeCHP1q (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 10:27:46 -0500
From: Richard Weinberger <richard@nod.at>
To: dedekind1@gmail.com
Cc: Linus Walleij <linus.walleij@linaro.org>,
        linux-mtd@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Mark Vasut <marek.vasut@gmail.com>,
        Boris BREZILLON <boris.brezillon@free-electrons.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>, tharvey@gateworks.com,
        stable <stable@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] ubi: Reject MLC NAND
Date: Thu, 08 Mar 2018 16:28:50 +0100
Message-ID: <10429741.dU3vzh71GH@blindfold>
In-Reply-To: <1520521275.20980.41.camel@gmail.com>
References: <20180303104554.5958-1-richard@nod.at> <3797589.z8fAhu5iDP@blindfold> <1520521275.20980.41.camel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Artem,

Am Donnerstag, 8. März 2018, 16:01:15 CET schrieb Artem Bityutskiy:
> On Thu, 2018-03-08 at 15:43 +0100, Richard Weinberger wrote:
> > As stated by David Woodhouse, it was a huge mistake by UBI to not
> > reject MLC
> > NAND from the very beginning.
> 
> Correction: when we were developing UBI/UBIFS and upstreamed them, MLC
> was widely used yet we did not really know about it. So there was
> nothing to reject yet.

You mean *not* widely used?
 
> The mistake is that we did not add the reject timely. When people
> started reporting MLC issues we were answering that UBI/UBIFS stack
> needs more work to make MLC safe to use, and we hoped someone would do
> the work.

True.
TBH Boris and I also thought that adding MLC support is not a that big deal...

Thanks,
//richard
