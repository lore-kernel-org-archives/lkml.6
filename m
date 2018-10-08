Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CCAC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07592086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="te2JQvcE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07592086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeJHWP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:15:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45327 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeJHWP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:15:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id u12-v6so5371259pfn.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 08:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PY/9zZj3jrYjYbi3nlZY69bsIEXHzLEOEBoYD2q+JSQ=;
        b=te2JQvcEBnI641CwkaJVC1vRPGnS7BJpjukaJTaF2OLR8DlYHWOlgCkmhERyZeRs/V
         iAgGgo1y+cv25tBWEfAgltGeYKrFTgRDhy7sfvxNxfJ+qSVLmn3wiQZXltzNAQcqoF38
         A/JIGcWqBLN+XWYwjUH4AL3gs5FuMMhQkD1fxN4i+dfk5pzBXoQz4EGkdp2uzp6TJY6q
         tvbEg52hQV6VXFrbmc6Xep7LedzUsyaSE2g+HCB851G/8msoFTC82KcqMsRcoaM9jBy7
         F28eAPx8ZskJ52kUnu4U7uK9BgIs0VNMooQGu0l10wp1tOY1c+jEdcNh6ZOl7PWYcKkI
         rlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PY/9zZj3jrYjYbi3nlZY69bsIEXHzLEOEBoYD2q+JSQ=;
        b=LYJwF/kKx2L/xlV2hyetKHoEdk7k+uy70hGO0yzMoiR0UJcQ0K8XXddMmJWsqtfOrx
         TTkZxHkbWsP/T5N5wpsYReMrxjRkvfNoWMcaObprZVnVUFIV5vxD3EuoaatfyeYOX/kW
         8tpIvIe0M6YAmogpLoYs6jnhg2UmeLbmVg9dknqnFrPxFEtTDBgXrFk560FjiDJCEVEv
         egNcOMJQ0wJLWfFHfnyDl26tZiwLpjhCqMY3B0mg/3+QaD5osrUme02Bx5WOHUOTglLH
         mjrNftezjFkg3/23Dh+9xvtymuvtIa8N5l22wMHDwlCzB+zR8GZLsHY0sNOpYPtgveK2
         61pw==
X-Gm-Message-State: ABuFfoh2V7vasw15Q2bEJsHQz0IGCKytJUjFkeOEIJoLfoA2VcM3uDSM
        pS1z+hkyLWEF/vSmvJjGkADZjBp9TckVKBqd/rY=
X-Google-Smtp-Source: ACcGV62nTpHm2xN1BSnz4pYzRpKsX0SO0BKEhfjBzeKo0CLAK7eledMTH/1OFWuV6XH2yin05lnktIQl7KmzBkvLz+E=
X-Received: by 2002:a63:e54d:: with SMTP id z13-v6mr21370978pgj.169.1539011026772;
 Mon, 08 Oct 2018 08:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <1538861738.4088.5.camel@HansenPartnership.com>
 <1538861851.4088.7.camel@HansenPartnership.com> <ECADFF3FD767C149AD96A924E7EA6EAF80516F31@USCULXMSG01.am.sony.com>
 <1538883209.4088.14.camel@HansenPartnership.com> <ECADFF3FD767C149AD96A924E7EA6EAF80517411@USCULXMSG01.am.sony.com>
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF80517411@USCULXMSG01.am.sony.com>
From:   "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Date:   Mon, 8 Oct 2018 11:03:34 -0400
Message-ID: <CAKON4Ox9M_wCrzvKCBdqP4U+wtJkSW+y4ogOJZEhjhy4vRmUPw@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH 2/2] code-of-conduct: Strip the
 enforcement paragraph pending community discussion
To:     Tim.Bird@sony.com
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 9:51 AM <Tim.Bird@sony.com> wrote:
>
>
>
> > -----Original Message-----
> > From: James Bottomley
> > On Sat, 2018-10-06 at 21:43 +0000, Tim.Bird@sony.com wrote:
> > > > -----Original Message-----
> > > > From: James Bottomley
> > > >
> > > > Significant concern has been expressed about the responsibilities
> > > > outlined in the enforcement clause of the new code of
> > > > conduct.  Since there is concern that this becomes binding on the
> > > > release of the 4.19 kernel, strip the enforcement clauses to give
> > > > the community time to consider and debate how this should be
> > > > handled.
> > > >
> > > > Signed-off-by: James Bottomley
> > > > <James.Bottomley@HansenPartnership.com>
> > > > ---
> > > >  Documentation/process/code-of-conduct.rst | 15 ---------------
> > > >  1 file changed, 15 deletions(-)
> > > >
> > > > diff --git a/Documentation/process/code-of-conduct.rst
> > > > b/Documentation/process/code-of-conduct.rst
> > > > index aa40e34e7785..4dd90987305b 100644
> > > > --- a/Documentation/process/code-of-conduct.rst
> > > > +++ b/Documentation/process/code-of-conduct.rst
> > > > @@ -59,21 +59,6 @@ address, posting via an official social media
> > > > account, or
> > > > acting as an appointed
> > > >  representative at an online or offline event. Representation of a
> > > > project may
> > > > be
> > > >  further defined and clarified by project maintainers.
> > > >
> > > > -Enforcement
> > > > -===========
> > > > -
> > > > -Instances of abusive, harassing, or otherwise unacceptable
> > > > behavior may be
> > > > -reported by contacting the Technical Advisory Board (TAB) at
> > > > -<tab@lists.linux-foundation.org>. All complaints will be reviewed
> > > > and
> > > > -investigated and will result in a response that is deemed
> > > > necessary and
> > > > -appropriate to the circumstances. The TAB is obligated to maintain
> > > > -confidentiality with regard to the reporter of an
> > > > incident.  Further details of
> > > > -specific enforcement policies may be posted separately.
> > >
> > > I think it's OK to leave the above section, as it doesn't speak to
> > > enforcement, but rather is just a set of reporting instructions,
> > > with an assurance of confidentiality.  This seems to me not to be
> > > the objectionable part of this section.
> > > (IOW, I would omit this removal from the patch).
> >
> > So I did think about that, but it struck me that with both paragraphs
> > removed, the current CoC is very similar to the status quo: namely
> > every subsystem handles their own issues and that's formalised by the
> > "Our Responsibilities" section.  That also makes me think that whether
> > we want a centralised channel of reporting or enforcement and what it
> > should be also ought to be part of the debate.  The TAB was created to
> > channel community technical input into the Linux Foundation.  That's
> > not to say it can't provide the reporting and arbitration structure,
> > but if we're going to do it right we should debate the expansion of its
> > duties (and powers).
>
> When the Code of Conflict was adopted 3 years ago, we already created
> the central reporting mechanism, so I actually think leaving (ie including) the above
> paragraph is closer to the status quo.  I think it's the expanded powers and
> duties (or perception thereof) that are causing concern and I think debating
> those to clarify intent, and adopting changes as needed  to ameliorate concerns
> is worthwhile.

In most cases any CoC is not going to be much of a problem. The
problem is going to occur when one of the top five or so people is
accused of a violation. That is going to end up in the mainstream
press. Big money and corporate power will be at play.  The CoC needs
needs to be designed to handle something like the Bredan Eich
situation.  In that situation he was initially attacked by external
parties. I will keep recommending that the legal community weigh in
before making this official policy. We are focusing on the case of the
random individual, but I suspect the problem lies in an attack on the
leadership.

>
> I believe that in the vast majority of cases, the TAB will end up
> performing a mediator role to smooth hurt feelings and remind and encourage
> improved communication - very similar to what we've done in the past.  I really
> believe that bans will continue to be very few and far between, as they have
> been historically (I can only think of 3 in the past decade.)
>  -- Tim
>
> _______________________________________________
> Ksummit-discuss mailing list
> Ksummit-discuss@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss



-- 
Jon Smirl
jonsmirl@gmail.com
