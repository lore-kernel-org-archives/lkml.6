Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A4CC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 915A3208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="XDhDy+PB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 915A3208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbeJSEAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:00:34 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42178 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725735AbeJSEAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:00:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BF4F68EE108;
        Thu, 18 Oct 2018 12:57:59 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jNSdOsdx2QOs; Thu, 18 Oct 2018 12:57:59 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4A9678EE0D5;
        Thu, 18 Oct 2018 12:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1539892679;
        bh=rFzXz5gDHCjHLWWk4C9GVS2f3B6KeCcyAYf2i9f2Ddc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XDhDy+PBcf0ko8X4lLhWNBCM0StcXr1HHAdXvTZNTRMc1rZXaeTlArL6Oqg2hN+PB
         oMMZQx+GmJ3qxP9awA+ojjtf8RkHTnu4XFwt1OzKSUjJRAGBup1VsGdxK6Cn2C9wxM
         d7m6JTZALmI0j9JTn1OFZIDF9rpKZRuYPw+bldvw=
Message-ID: <1539892678.18970.30.camel@HansenPartnership.com>
Subject: Re: [Ksummit-discuss] [PATCH v3 1/3] code-of-conduct: Fix the
 ambiguity about collecting email addresses
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Tim.Bird@sony.com, frowand.list@gmail.com,
        ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 18 Oct 2018 12:57:58 -0700
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF805271E5@USCULXMSG01.am.sony.com>
References: <1539701820.2805.6.camel@HansenPartnership.com>
         <1539701896.2805.7.camel@HansenPartnership.com>
         <e332116b-62e8-9930-c263-d022edb5828e@gmail.com>
         <1539744091.2805.108.camel@HansenPartnership.com>
         <16a20416-0045-dfe6-d937-63f2f0cff269@gmail.com>
         <1539803331.3769.62.camel@HansenPartnership.com>
         <b056cdc3-29de-b6c8-b2a7-67b93b0fd730@gmail.com>
         <1539874609.2845.5.camel@HansenPartnership.com>
         <b9f5376f-d8e8-bfe5-d27e-14c26d4859b8@gmail.com>
         <ECADFF3FD767C149AD96A924E7EA6EAF805271E5@USCULXMSG01.am.sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-18 at 19:49 +0000, Tim.Bird@sony.com wrote:
> > -----Original Message-----
> > From: Frank Rowand
> > 
> > On 10/18/18 07:56, James Bottomley wrote:
> > > On Wed, 2018-10-17 at 12:53 -0700, Frank Rowand wrote:
> > > > On 10/17/18 12:08, James Bottomley wrote:
> > > 
> > > [...]
> > > > > > Trying to understand how you are understanding my comment
> > > > > > vs what
> > > > > > I intended to communicate, it seems to me that you are
> > > > > > focused on
> > > > > > the "where allowed" and I am focused on the "which email
> > > > > > addresses".
> > > > > > 
> > > > > > More clear?  Or am I still not communicating well enough?
> > > > > 
> > > > > I think the crux of the disagreement is that you think the
> > > > > carve
> > > > > out equates to a permission which is not specific enough and
> > > > > I
> > > > > think it
> > > > 
> > > > Nope.  That is a big place where I was not transferring my
> > > > thoughts
> > > > to clear communication.  I agree that what I wrote should have
> > > > been
> > > > written in terms of carve out instead of permission.
> > > > 
> > > > 
> > > > > doesn't equate to a permission at all, which is why there's
> > > > > no need
> > > > > to make it more explicit.  Is that a fair characterisation?
> > > > 
> > > > Nope.  My concern is "which email addresses".
> > > 
> > > The idea here was because it's a carve out that doesn't give
> > > permission
> > > and because the permission is ruled by the project contribution
> > > documents, the carve out should be broad enough to cover anything
> > > they
> > > might say hence "email addresses not ordinarily collected by the
> > > project" are still included as unacceptable behaviour.
> > > 
> > > Perhaps if you propose the wording you'd like to see it would
> > > help
> > > because there still looks to be some subtlety I'm not getting.
> > 
> > 
> > From the beginning of the thread:
> > 
> >   > @@ -31,7 +31,7 @@ Examples of unacceptable behavior by
> > participants
> > include:
> >   >  * Trolling, insulting/derogatory comments, and personal or
> > political
> > attacks
> >   >  * Public or private harassment
> >   >  * Publishing others’ private information, such as a physical
> > or electronic
> >   > -  address, without explicit permission
> >   > +  address not ordinarily collected by the project, without
> > explicit
> > permission
> >   >  * Other conduct which could reasonably be considered
> > inappropriate in a
> >   >    professional setting
> > 
> > 
> > Alternative (and I'm sure someone else can probably clean this up a
> > little bit):
> > 
> > + address that has been provided in a public space for the project,
> > without explicit permission
> 
> This ends up reading like so:
> 
> ----
> Examples of unacceptable behavior by participants include:
> ...
> * Publishing others’ private information, such as a physical or
> electronic
> address that has been provided in a public space for the project,
> without
> explicit permission.
> ----
> 
> I think that in context, you want a 'not' in there.  That is:
> unacceptable behavior includes publishing others' private
> information... that has *not* been provided in a public space.  So, I
> think the suggested text needs some fixing, IMHO.

You beat me to this one.  However, there is another issue that I did
touch on but perhaps not in this subthread: For those of us who live in
the US, our addresses (that's physical and sometimes email) are
actually provided in a public space because they're available in the
public property records.  That's actually why I chose "not ordinarily
collected by the project" as opposed to "not previously provided in the
public space" or an equivalent because doxxing in the US is mostly
finding this information from public sources and broadcasting it.

> I looked at this issue upstream, and decided to leave the wording in
> the CoC itself alone - favoring instead to add a clarifying addition
> to the upstream CoC FAQ, about some email addresses not being
> private information.
> 
> The reason I took that approach, rather than try to change the
> wording inside the CoC, is that the current wording seems to me to be
> sufficient. The thing that is unacceptable is publishing private
> information.  The "such as..." clause is intended to convey examples
> of the types of thing that might usually be considered private
> information.  But it is not exhaustive, nor is it necessarily
> correct, depending on the circumstances.  In particular, email
> addresses are sometimes private information and sometimes not.
> In the context of kernel development, many email addresses are not
> private.
> 
> I am sympathetic to the argument that we use emails as public
> information so much in kernel development processes, that it makes
> sense to omit this or qualify it more.

I think that's the sense of the people who acked this, yes.  Personally
I'm happy with a separate clarification in another document, but I can
also see the argument that we do need our single CoC to be consistent
with our operational method, which is why I proposed the patch.

> My own views are that:
> 1) if we change this line at all, we should simply omit the "such
> as..." part of the phrase, and leave it at:
> 
> * Publishing others’ private information without explicit permission

This looks OK to me too ... the problem with the original is that the
additional qualification overlaps our normal project method of
operation, this solves the issue as well.

James


> but also
> 2) I'm OK with leaving the phrase as is and handling the concerns
> in an clarifying document.
> 
> Just my 2 cents.
>  -- Tim
> 
> 
> 
> _______________________________________________
> Ksummit-discuss mailing list
> Ksummit-discuss@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

