Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BE8C5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23C7214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="EIC6erfs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23C7214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeJQKe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 06:34:58 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38310 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726988AbeJQKe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 06:34:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6E7058EE2BB;
        Tue, 16 Oct 2018 19:41:33 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WdplTvPkHA7q; Tue, 16 Oct 2018 19:41:33 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id DF95F8EE0BA;
        Tue, 16 Oct 2018 19:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1539744093;
        bh=9T7/RWdoK60XJZNrbU1pUqF7haTUIqrC/vVUp8xKDaQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EIC6erfsCzD9iNUnbpANgMSErnSlCbgSI95gwbM1llh+0t/KH7LVU3sfHL9oow9dr
         6qFZ3Ouy0AmwY425OjCtKsG3yldx/Oi6IDOySQKHlIrX50TAitRVffg6lLDYKR0mcZ
         eWVvGXh0fcNuX4w7pOPyTtKtB9f7o4z4eRmBgx4U=
Message-ID: <1539744091.2805.108.camel@HansenPartnership.com>
Subject: Re: [Ksummit-discuss] [PATCH v3 1/3] code-of-conduct: Fix the
 ambiguity about collecting email addresses
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Frank Rowand <frowand.list@gmail.com>,
        ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 16 Oct 2018 19:41:31 -0700
In-Reply-To: <e332116b-62e8-9930-c263-d022edb5828e@gmail.com>
References: <1539701820.2805.6.camel@HansenPartnership.com>
         <1539701896.2805.7.camel@HansenPartnership.com>
         <e332116b-62e8-9930-c263-d022edb5828e@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-16 at 19:10 -0700, Frank Rowand wrote:
> On 10/16/18 07:58, James Bottomley wrote:
> > The current code of conduct has an ambiguity in the it considers
> > publishing
> > private information such as email addresses unacceptable
> > behaviour.  Since
> > the Linux kernel collects and publishes email addresses as part of
> > the patch
> > process, add an exception clause for email addresses ordinarily
> > collected by
> > the project to correct this ambiguity.
> > 
> > Fixes: 8a104f8b5867c682 ("Code of Conduct: Let's revamp it.")
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Acked-by: Shuah Khan <shuah@kernel.org>
> > Acked-by: Guenter Roeck <linux@roeck-us.net>
> > Reviewed-by: Alan Cox <alan@llwyncelyn.cymru>
> > Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> > Acked-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.c
> > om>
> > ---
> >  Documentation/process/code-of-conduct.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/process/code-of-conduct.rst
> > b/Documentation/process/code-of-conduct.rst
> > index ab7c24b5478c..aa40e34e7785 100644
> > --- a/Documentation/process/code-of-conduct.rst
> > +++ b/Documentation/process/code-of-conduct.rst
> > @@ -31,7 +31,7 @@ Examples of unacceptable behavior by participants
> > include:
> >  * Trolling, insulting/derogatory comments, and personal or
> > political attacks
> >  * Public or private harassment
> >  * Publishing others’ private information, such as a physical or
> > electronic
> > -  address, without explicit permission
> > +  address not ordinarily collected by the project, without
> > explicit permission
> >  * Other conduct which could reasonably be considered inappropriate
> > in a
> >    professional setting
> >  
> > 
> 
> Repeating my comment on version 1:
> 
> My understanding of the concern behind this change is that we should
> be able to use an email address for the current development
> practices, such as Reported-by, Suggested-by, etc tags when the email
> address was provided in what is a public space for the project.  The
> public space is visible to anyone in the world who desires to access
> it.
> 
> I do not understand how "ordinarily collected by the project" is
> equivalent to "an email address that was provided in a public space
> for the project".

I don't think it is ... or should be.  This section is specifically
enumerating unacceptable behaviours.  The carve out "email address not
ordinarily collected by the project" means that adding someone's email
address in a tag isn't immediately sanctionable in the code of conduct
as unacceptable behaviour if a question about whether you asked
explicit permission arises.  Equally, a carve out from unacceptable
behaviours doesn't make the action always acceptable, so it's not a
licence to publish someone's email address regardless of context.

> Ordinarily collected could include activities that can be expected to
> be private and not visible to any arbitrary person in the world.

It's not a blanket permission, it's an exclusion from being considered
unacceptable behaviour.  I would be interested to know what information
we ordinarily collect in the course of building linux that should be
considered private because I might have missed something about the
implications here.

James

> My issue is with the word choice.  I agree with the underlying
> concept.
> 
> -Frank
> _______________________________________________
> Ksummit-discuss mailing list
> Ksummit-discuss@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

