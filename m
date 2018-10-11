Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2683CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69C320865
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="SdBr3ABK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A69C320865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbeJKHYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:24:34 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59422 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725968AbeJKHYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:24:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id AB9AF8EE303;
        Wed, 10 Oct 2018 17:00:03 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qTkavombU_lS; Wed, 10 Oct 2018 17:00:03 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3B3F08EE0C7;
        Wed, 10 Oct 2018 17:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1539216003;
        bh=4iccRVph7j1/N+rIvpmWQ2JqMj4fm0y27NO1ij/bEvM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SdBr3ABKu0X/sjZY0X8VhmWFmkfpyHAhIV+OQSt9Q5iqC2NL2p1X2CiJ9vdsbArzx
         GwWTF9syKLgJeXYDCNeZPkFwqDFNfj5Y0Ud5ox7VY6q/kFTw73PK/ptnj0hM3FU7du
         oX7CeN7WafV5B7dzTL4DqI0SdBirx9RZJsaYIAUQ=
Message-ID: <1539216001.3462.1.camel@HansenPartnership.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 0/3] code of conduct fixes
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Date:   Wed, 10 Oct 2018 17:00:01 -0700
In-Reply-To: <87efcxtmhf.fsf@xmission.com>
References: <1539202053.12644.8.camel@HansenPartnership.com>
         <87efcxtmhf.fsf@xmission.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-10 at 18:23 -0500, Eric W. Biederman wrote:
> James Bottomley <James.Bottomley@HansenPartnership.com> writes:
> 
> > Resend to show accumulated tags and also to add a third patch
> > listing the TAB as the reporting point as a few people seem to
> > want.  If it gets the same level of support, I'll send it in with
> > the other two.
> 
> 
> There is also:
> 
> > Our Responsibilities
> > ====================
> > 
> > Maintainers are responsible for clarifying the standards of
> > acceptable behavior and are expected to take appropriate and fair
> > corrective action in response to any instances of unacceptable
> > behavior.
> > 
> > Maintainers have the right and responsibility to remove, edit, or
> > reject comments, commits, code, wiki edits, issues, and other
> > contributions that are not aligned to this Code of Conduct, or to
> > ban temporarily or permanently any contributor for other behaviors
> > that they deem inappropriate, threatening, offensive, or harmful.
> 
> Which is very problematic.
> a) In append only logs like git we can not edit history.
>    Making it a mainters responsibility to edit the history, to do the
>    impossible is a problem.

Git isn't entirely append only.  We can do limited history changes by
rebasing.  Some trees do that quite a lot.  Github has this same
history problem, so certainly we could amend commits before they hit
Linus' tree but after that it isn't "fair corrective action" because it
can't be done technically.

> b) There are no responsibilities of for people who are not
> Maintainers.
>    That is another problem.

Yes, I don't disagree with this.  It's one of the huge problems with
this whole CoC thing: in a community which has apparent leaders but no
real power structure, conforming to a CoC becomes everyone's
responsibility not just the maintainers.

> c) The entire tone of the reponsibilities section is out of line with
> a
>    community where there are no enforcement powers only the power to
>    accept or not accept a patch.  Only the power to persuade not to
>    enforce.

Persuasion and Leadership go hand in hand.  I agree there's no backing
power to compel, but persuasive leaders are still not powerless. 
There's always potentially an outlier who simply won't listen and won't
be persuaded, but they're usually not members of the community either
...

> Overall in the discussions I have heard people talking about
> persuading, educating, and not feeding trolls.   Nowhere have I heard
> people talking about policing the community which I understand that
> responsiblity section to be talking about.

Policing is the wrong word: no-one has policing power.  However, we
still have persuasive power.  The point is there's a reasonable line
you can tread as a persuader.  Some very few people simply won't
listen, but we have, actually, excluded them before without a code of
conduct.

> Increasingly I am getting the feeling that this document does not the
> linux development community.  Perhaps a revert and trying to come up
> with better language from scratch would be better.

I'm open to pushing a revert instead. However, I think this one is
workable too if interpreted reasonably.

> I don't know how to rephrase that reponsibility section but if we
> don't go with the revert something looks like it need sot be done
> there.

That is an argument for keeping what we have ... these things are
difficult to write.

James


