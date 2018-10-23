Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B3CC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6805A20652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="l4bhE/uW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6805A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbeJWRcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:32:17 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:33552 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727704AbeJWRcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:32:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9B65B8EE0FC;
        Tue, 23 Oct 2018 02:09:46 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F2H9WlPlsN2Y; Tue, 23 Oct 2018 02:09:44 -0700 (PDT)
Received: from [172.20.48.127] (unknown [62.232.21.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 12E098EE0D5;
        Tue, 23 Oct 2018 02:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1540285784;
        bh=H1MyH1/gU67Nqxg+v7ZaMVq2TXoWPQoFyqOAPMgwX4g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=l4bhE/uW9oQCD04KhKNhMzCk6PKEnG1qjIj8f3feaboNoItCMt8NsU+msd7GNMSLb
         hmEhDmjTeNomMyx5kow4OpJHYU0ISvtpZO3jAiMJ7nza6OqvoF23EgPK42k2gekwLo
         zKD2p6UQn6BX7SAER6vWK+njXMpS2MT2+JxyHKsE=
Message-ID: <1540285779.3347.27.camel@HansenPartnership.com>
Subject: Re: [Ksummit-discuss] [GIT PULL] code of conduct fixes for 4.19-rc8
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Greg Kroah-Hartman <greg@kroah.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Date:   Tue, 23 Oct 2018 10:09:39 +0100
In-Reply-To: <20181022211025.GA8911@kroah.com>
References: <1540066514.3464.22.camel@HansenPartnership.com>
         <20181022211025.GA8911@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-22 at 22:10 +0100, Greg Kroah-Hartman wrote:
> On Sat, Oct 20, 2018 at 01:15:14PM -0700, James Bottomley wrote:
> > This is the series of patches which has been discussed on both
> > ksummit-discuss and linux-kernel for the past few weeks.  As Shuah
> > said when kicking off the process, it's designed as a starting
> > point for the next phase of the discussion, not as the end point,
> > so it's only really a set of minor updates to further that goal.
> > 
> > The merger of the three patches to show the combined effect is
> > attached below.  However, Greg recently posted the next phase of
> > the discussion, so people will be asking what the merger of the
> > series looks like.  Ignoring the non-CoC documents, I think it
> > looks like this
> 
> Sorry for not responding sooner for this, travel and the meeting
> today took up my time.
> 
> Anyway, as we discussed today in the Maintainers summit, let's leave
> the Code of Conduct text alone for now.

I still think rejecting this pull request in favour of your own patches
rather than doing a combination is a process mistake.  However, I do
believe most people can live with the current status quo.  So I'm not
going to object further (and I'm grateful for the commitment to try to
be more transparent and actually follow our own processes next time we
do something like this that we also arrived at at the Maintainer
Summit).

>   It matches what "upstream" has with the exception of removing that
> one paragraph.

Um, and adding the interpretation paragraph; that paragraph is one of
the most significant changes because the interpretation document
corrals a lot of the potential effects of the undiluted contributor
covenant.

>   If you have issues with the wording in it, please work with
> upstream to fix the issues there as hundreds of other projects will
> benefit with your changes if they are really needed.

Deflection to "upstream" is a bit of a red herring on two counts:
firstly because we have no commitment to move to later revisions and
secondly because the interaction of the interpretation document with an
update is quite a big source of potential conflicts: to properly update
we'd have to update both documents which means us potentially rewriting
one or both again.

I also think deflection to "upstream" is a social mistake.  If you want
the community to own the code of conduct, you can't keep telling them
it's someone else's document.

James


> For now, let's let things settle down and not worry about
> hypothetical situations that might possibly happen in some way or
> another as we can debate that type of thing endlessly (it's a good
> skill we have which makes us great kernel developers, but it not
> always transferrable to other environments).
> 
> If real issues do come up in the future, we will address them then,
> as we always have the option to change and revisit things as needed.
> 
> thanks,
> 
> greg k-h
> _______________________________________________
> Ksummit-discuss mailing list
> Ksummit-discuss@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
> 

