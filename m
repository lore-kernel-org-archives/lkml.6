Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6ED5C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8462720841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="hr7VqVS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8462720841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbeJHVUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:20:21 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42758 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726056AbeJHVUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:20:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BC4D48EE2EC;
        Mon,  8 Oct 2018 07:08:26 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 88DPsMC4owcH; Mon,  8 Oct 2018 07:08:26 -0700 (PDT)
Received: from [153.66.254.242] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 17F468EE0FD;
        Mon,  8 Oct 2018 07:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1539007706;
        bh=PKREqNPr12/NEXMbDEFMaQlgJ5I6kZugtL4sM+F1jfk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hr7VqVS27kfNDrfdkm3O2gjKpbmfgO1sLeNS96DK5dTIk/gGpyqrw6NszkdYbMNOK
         ynmQx7eZ/xIR20ONpiMjXC0BYxaOpCtudd2xGq9sVbDDTuzKeOes/TJHMXcOM7Cfsl
         4W5kAYJSBY8k6HQiPTa2YGHkiIQLIptzZCYABh+0=
Message-ID: <1539007704.4344.2.camel@HansenPartnership.com>
Subject: Re: [Ksummit-discuss] [PATCH 1/2] code-of-conduct: Fix the
 ambiguity about collecting email addresses
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Dave Airlie <airlied@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
Date:   Mon, 08 Oct 2018 07:08:24 -0700
In-Reply-To: <CAPM=9tz3Z=vD6qWUL2boZGEAgMeC_o9euBXFu2V58RHOn6gR9g@mail.gmail.com>
References: <1538861738.4088.5.camel@HansenPartnership.com>
         <1538861799.4088.6.camel@HansenPartnership.com>
         <CAPM=9tz3Z=vD6qWUL2boZGEAgMeC_o9euBXFu2V58RHOn6gR9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-08 at 08:25 +1000, Dave Airlie wrote:
> On Sun, 7 Oct 2018 at 07:36, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > From 4a614e9440148894207bef5bf69e74071baceb3b Mon Sep 17 00:00:00
> > 2001
> > From: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Date: Sat, 6 Oct 2018 14:21:56 -0700
> > Subject: [PATCH 1/2] code-of-conduct: Fix the ambiguity about
> > collecting email  addresses
> > 
> > The current code of conduct has an ambiguity in the it considers
> > publishing private information such as email addresses unacceptable
> > behaviour.  Since the Linux kernel collects and publishes email
> > addresses as part of the patch process, add an exception clause for
> > email addresses ordinarily collected by the project to correct this
> > ambiguity.
> > 
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.c
> > om>
> > ---
> >  Documentation/process/code-of-conduct.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/process/code-of-conduct.rst
> > b/Documentation/process/code-of-conduct.rst
> > index ab7c24b5478c..aa40e34e7785 100644
> > --- a/Documentation/process/code-of-conduct.rst
> > +++ b/Documentation/process/code-of-conduct.rst
> > @@ -31,7 +31,7 @@ Examples of unacceptable behavior by participants
> > include:
> >  * Trolling, insulting/derogatory comments, and personal or
> > political attacks
> >  * Public or private harassment
> >  * Publishing others’ private information, such as a physical or
> > electronic
> > -  address, without explicit permission
> > +  address not ordinarily collected by the project, without
> > explicit permission
> >  * Other conduct which could reasonably be considered inappropriate
> > in a professional setting
> > 
> 
> I agree we want something like this, the question is whether we want
> to change the CoC text from upstream, or clarify it in a separate
> section.

A Code of Conduct should be clear and not hedged around with footnotes
and interpretations in my opinion, which is why I offered the patch
like this.

> This isn't a legally binding license or anything, but departing from
> the upstream wording makes it tricker to merge new upstream versions
> if they are considered appropriate.

The way I look at this is that it's very much like a vendor driver. 
Some are mirror images of the source because we work closely with them;
others could be forks.  However, the process for vendor drivers is that
we make them work for us first and then see how the vendor wants to
handle it.

Once we agree the shape of what we need I promise to try to push it
back into the source ... is that good enough compromise?

James

