Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B9FC65C1B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 17:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90942087D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 17:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHWuMyKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90942087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeJHA7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 20:59:12 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39236 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbeJHA7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 20:59:11 -0400
Received: by mail-pl1-f193.google.com with SMTP id w14-v6so9011861plp.6
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 10:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jdHfr+oJYsCNSjRpa6DJVw4SA4PzWsHtuVbL2FD7mZY=;
        b=UHWuMyKukEpcslgCMN6ztP5bL1lrQDvJn6PM8ColT66z6w+ej1Hp3vLIhQow5ckOIY
         XinBlJrMKDu17zOX4Ms6KkBQLlXMnPF7e/QXSjkQh4Is+f8BebPRs0WQZPDuyugeLaoX
         llPR/OwMBPfjUnINkZk8mCxBZAu1LSdUK4jbE39ZALoLUt0G9KXHaC+xe9pX7+LwKPWD
         CwupHUbPvxsr5lrVLwQGT+NwrkbaceBjj22p4nnlGJEvhm+pp6ZBwQ7UqY5FMCuYTF37
         GwKOEnoN9QuUAVLF1a1Lp6cl9cZsNsPUr6x/beP4103x0csD/ajHlcBXlCzahY5FVRTp
         /7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jdHfr+oJYsCNSjRpa6DJVw4SA4PzWsHtuVbL2FD7mZY=;
        b=h1HicsX+mUbxbsd1x1UGAVwIXfJhQ2Tkp9XW8ZEONZ1Dk/cctLl4LMx2mGWCRGH2Bc
         a9L+JfKYU64hYsRpHQgdcbhzK0si7lnKlGV001PizvxyDnVbjDNihH5Hb9oyPUFzwhZi
         9yhB31IVm/7IrhF/uypTK1SfkKtHGLpx+NiW3QN9QzXZ5YgBcuYHCYK32/xBCxFpbdRJ
         2f7P7ys+0IGdJpEjAmi1QhtctkWGEjjD/Jt7nYVikXsAEAe6+dfxvKtfMgZF6m90/xKE
         w7LFcDuWaNzDYBiYpJfzL5Bup3uYhEZ/D+f7BT62QF+hmOgmF7hV8iIG0OieYf3BLFYP
         V2DQ==
X-Gm-Message-State: ABuFfoj2RyyFHzW6j7qg9UEL4KcRgM31viWfNy5Ih4xk1iPlVSbxgO1f
        HI57k1CDMRzbkcgT026Q03kRyxmig+hAMw8dMkDHTg==
X-Google-Smtp-Source: ACcGV62GD7aKztaHlXFWuCsj6RNvAINZvKe4C9XfMVI8ZyrVIU/6nBEbLa9euvs07vtFctnnq3WndbMEaGYWlLMRn5M=
X-Received: by 2002:a17:902:a716:: with SMTP id w22-v6mr6099670plq.334.1538934669037;
 Sun, 07 Oct 2018 10:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <1538861738.4088.5.camel@HansenPartnership.com>
 <CAKMK7uFvmXtk=WiZJxGrzQQD1RHv7srA-_e8KdwXZ9Kn5rcmiQ@mail.gmail.com> <1538934030.4010.1.camel@HansenPartnership.com>
In-Reply-To: <1538934030.4010.1.camel@HansenPartnership.com>
From:   "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Date:   Sun, 7 Oct 2018 13:50:57 -0400
Message-ID: <CAKON4OyztjgTp_AJcrUjpkmT36RY4r-jMzNG75+riOy8U=PTgQ@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH 0/2] code of conduct fixes
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     daniel.vetter@ffwll.ch, lkml <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 7, 2018 at 1:42 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Sun, 2018-10-07 at 19:11 +0200, Daniel Vetter wrote:
> > Hi James,
> >
> > On Sat, Oct 6, 2018 at 11:36 PM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > > We've had several threads discussing potential changes to the code
> > > of
> > > conduct but Mauro is the only person to have proposed an actual
> > > patch.
> > > In order to move the debate on, I'm presenting two patches, one to
> > > fix
> > > the email problem Mauro identified and the other to strip the
> > > enforcement section pending community discussion as Shuah
> > > suggested.
> > >
> > > I'll take responsibility for collecting any tags people want to add
> > > (review/ack/sign off, etc) and sending the patch in as a signed
> > > pull
> > > request before 4.19 final if they get enough community support.
> > >
> > > Note, I've sent both patches in as a series to facilitate review
> > > and
> > > discussion, but they are separable if one is looked on with less
> > > favour
> > > than the other.
> > >
> > > It was also a bit unclear which list to send this to, but I finally
> > > settled on linux-kernel as the catch all and ksummit-discuss since
> > > that's where most of the current discussion is.  I can add other
> > > lists
> > > as people suggest them.
> >
> > Personally I'm not happy at all with how the new code of conduct was
> > rushed in, least because I still don't understand why it happened,
> > but also for all the other reasons we've discussed here in the past
> > few weeks.

As far as I know none of the usual open source friendly lawyers have
reviewed and commented. I suspect this document is on shaky legal
ground and it needs a vetting from the legal community. For example,
is the CoC simply guidance or it is a legal contract? I don't know
enough about the law to answer that.

> >
> > For all the same reasons I don't think it's a good idea to now rush
> > in a few edits, just a few days before the 4.19 release. In my
> > experience, and I've discussed code of conducts and their enforcement
> > for years even before we implemented the fd.o/dri-devel one, mailing
> > lists aren't the best place to have this discussion. Definitely not
> > under the time pressure of just a few days to get it all sorted. I
> > hope that we can have these discussiones at the maintainer summit and
> > kernel summit/plumbers, and will have more clarity in a few weeks
> > (probably more likely months).
> >
> > But I also understand that there's lots of people (me included) who
> > don't want to ship a release with the code of conduct in it's current
> > in-between state. I think adding a disclaimer at the top, along the
> > lines of
> >
> > "Please note that this code of conduct and it's enforcement are still
> > under discussion."
>
> I don't disagree with the position, but eliminating our old code of
> conduct in favour of another we cast doubt on with this disclaimer
> effectively leaves us with nothing at all, which seems to be a worse
> situation.  In that case, I think reverting the CoC commit
> (8a104f8b5867c682) and then restarting the replacement process is
> better than adding a disclaimer to the new one.
>
> My preference is to try to fix what we have instead of starting over,
> but it's not a strong one, so if people want to go for the revert
> instead of the amendment, I'd be happy to redo the patch series with
> that.
>
> James
>
>
> > would make this clear and ameliorate the concerns from many people
> > about the open questions we still have, at least for now. This would
> > give us the time to discuss all the details properly and with all due
> > deliberation. I'm travelling next week, so not the right guy to push
> > this, but I'd be happy to ack such a patch (or something along the
> > same lines). I also believe that this statement is undisputed enough
> > that we can gather widespread support for it in the few days left
> > until 4.19 ships to make it happen.
> >
> > Thanks, Daniel
>
> _______________________________________________
> Ksummit-discuss mailing list
> Ksummit-discuss@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss



-- 
Jon Smirl
jonsmirl@gmail.com
