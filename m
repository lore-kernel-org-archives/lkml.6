Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39721C65C24
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 17:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F982087D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 17:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="u8WFzXIX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F982087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbeJHAsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 20:48:32 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:32884 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726178AbeJHAsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 20:48:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 50E508EE2BB;
        Sun,  7 Oct 2018 10:40:31 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ksfxidYzKJWX; Sun,  7 Oct 2018 10:40:31 -0700 (PDT)
Received: from [153.66.254.242] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D1AC68EE0D2;
        Sun,  7 Oct 2018 10:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1538934031;
        bh=7eT4zYW3wu4fV7YpN15Qd+pcpVVlkfjkAQxCJTmMw7o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=u8WFzXIXgE198+s4i/paA1JMqIAaMw51M/4XN7mjnhPwkflUXcY0tYVq26gGCNom7
         4p44RD9j/7EfFbIgz+O9DSj3dvhvKpQkxpmN7bow5BPR2BJTm52PHojRBFXHGMy3/r
         j0BUBgjUXmJhcgR11fzhruHgLB43lpc0Egx1xRP8=
Message-ID: <1538934030.4010.1.camel@HansenPartnership.com>
Subject: Re: [Ksummit-discuss] [PATCH 0/2] code of conduct fixes
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
Date:   Sun, 07 Oct 2018 10:40:30 -0700
In-Reply-To: <CAKMK7uFvmXtk=WiZJxGrzQQD1RHv7srA-_e8KdwXZ9Kn5rcmiQ@mail.gmail.com>
References: <1538861738.4088.5.camel@HansenPartnership.com>
         <CAKMK7uFvmXtk=WiZJxGrzQQD1RHv7srA-_e8KdwXZ9Kn5rcmiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-10-07 at 19:11 +0200, Daniel Vetter wrote:
> Hi James,
> 
> On Sat, Oct 6, 2018 at 11:36 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > We've had several threads discussing potential changes to the code
> > of
> > conduct but Mauro is the only person to have proposed an actual
> > patch.
> > In order to move the debate on, I'm presenting two patches, one to
> > fix
> > the email problem Mauro identified and the other to strip the
> > enforcement section pending community discussion as Shuah
> > suggested.
> > 
> > I'll take responsibility for collecting any tags people want to add
> > (review/ack/sign off, etc) and sending the patch in as a signed
> > pull
> > request before 4.19 final if they get enough community support.
> > 
> > Note, I've sent both patches in as a series to facilitate review
> > and
> > discussion, but they are separable if one is looked on with less
> > favour
> > than the other.
> > 
> > It was also a bit unclear which list to send this to, but I finally
> > settled on linux-kernel as the catch all and ksummit-discuss since
> > that's where most of the current discussion is.  I can add other
> > lists
> > as people suggest them.
> 
> Personally I'm not happy at all with how the new code of conduct was
> rushed in, least because I still don't understand why it happened,
> but also for all the other reasons we've discussed here in the past
> few weeks.
> 
> For all the same reasons I don't think it's a good idea to now rush
> in a few edits, just a few days before the 4.19 release. In my
> experience, and I've discussed code of conducts and their enforcement
> for years even before we implemented the fd.o/dri-devel one, mailing
> lists aren't the best place to have this discussion. Definitely not
> under the time pressure of just a few days to get it all sorted. I
> hope that we can have these discussiones at the maintainer summit and
> kernel summit/plumbers, and will have more clarity in a few weeks
> (probably more likely months).
> 
> But I also understand that there's lots of people (me included) who
> don't want to ship a release with the code of conduct in it's current
> in-between state. I think adding a disclaimer at the top, along the
> lines of
> 
> "Please note that this code of conduct and it's enforcement are still
> under discussion."

I don't disagree with the position, but eliminating our old code of
conduct in favour of another we cast doubt on with this disclaimer
effectively leaves us with nothing at all, which seems to be a worse
situation.  In that case, I think reverting the CoC commit
(8a104f8b5867c682) and then restarting the replacement process is
better than adding a disclaimer to the new one.

My preference is to try to fix what we have instead of starting over,
but it's not a strong one, so if people want to go for the revert
instead of the amendment, I'd be happy to redo the patch series with
that.

James


> would make this clear and ameliorate the concerns from many people
> about the open questions we still have, at least for now. This would
> give us the time to discuss all the details properly and with all due
> deliberation. I'm travelling next week, so not the right guy to push
> this, but I'd be happy to ack such a patch (or something along the
> same lines). I also believe that this statement is undisputed enough
> that we can gather widespread support for it in the few days left
> until 4.19 ships to make it happen.
> 
> Thanks, Daniel

