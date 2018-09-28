Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC614C004D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB6C2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="en8TL5pE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB6C2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeI2CEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 22:04:05 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:33876 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbeI2CEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 22:04:05 -0400
Received: by mail-pf1-f171.google.com with SMTP id k19-v6so4991415pfi.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 12:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WEQl5IzG81WV5YNGoYj9zpCSvMVbbtN+IT4FLklw/2E=;
        b=en8TL5pEFphV3+X+uQKluovbjUeBdtJ6oumlTNsfO71QACpP4e4kAkHxYrG/mtXy81
         IrDBFb2bTcOTaOC1hfYyVr11gCTcC4s+OqWGy/PkRi7ffSXEPdozgCvhMYba9mBRj/zu
         5xQHnGIHXVlbRGLaKRPtOs0oyLxaOo39amrzvpq1dFxHqBralKaHxmmtQOEKGaxonpfX
         54m75F9ogwcdj0fg6S7Xmdxk9cpJbcY3cRkVoHQ81YvtVllGNo65AQjMLWUbwXfqLX9w
         JyWJpIPfxU20e0hhgFJJ7XqcS5ZgcaMpfgVs9tn18NfmUc9jkPBSmRV6vKuF0KUQtUlU
         6b1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WEQl5IzG81WV5YNGoYj9zpCSvMVbbtN+IT4FLklw/2E=;
        b=raguEweweuTiIo+RP+giLgZ9P5XLyQAIejSFZ2A7AnPB+g8MsBqCx6eDDFLcE9FrT8
         eFk2rZkCG2SXdqaixqXzMVSsw3rRrzRn/kEi2YTKrFgu28u1QaSzSbVpjAPcnDY9u4Me
         CB5dkmGRashBmAkBRhY+CEtch9QsIC276npF4KWlOKF2W9NByu9E4KGIusUsYrU5v04C
         VEMulB0R3yk1RlYUM2AWDTPBL6PfHU0ZiveGdoCZu24oUAvv2FCNmIPcMotQOV+lmJw5
         QRSB7OSUlH5o0z2erwdxlCpK7G9xnvse6BAYwUB0g4DYlqV24CKQtryG/r5O0lE6yeHO
         DNVA==
X-Gm-Message-State: ABuFfogJEpxbj9VoJBR/9KTu9/sPPFst+jATP+KAKcAAHm+AoJnNwNX0
        +6BDaPOA1E4UrQ5M2i8l7kDBWAqTQ/ysu4wB88Y=
X-Google-Smtp-Source: ACcGV610Y4nVonQDWk+nud4bdAWbubprnuWzu2EZhWcayWtg7AWXyCllSK6WzEDUkEx4mB/y2SLhhv/Pi/1g+8cKmtA=
X-Received: by 2002:a63:e54d:: with SMTP id z13-v6mr72853pgj.169.1538163529557;
 Fri, 28 Sep 2018 12:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net> <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
 <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net> <589966d9cd0ddccc88f33fcb7975bb4464be7696.camel@surriel.com>
 <87zhwbj8xe.fsf@redhat.com> <CAMjeLr-mWag=iO=CoNHeK9pkCu4y6vZUp03_zpJOG+e=n85j+g@mail.gmail.com>
 <20180921231545.GC2966@thunk.org> <CAKON4Oy3=7H+9WxzK-xK=T7t7rN7L3_PsJ+cdUWTjiKN=BGSRg@mail.gmail.com>
 <d364f33b-fbb4-57e0-78f5-302cd5c9050f@petrovitsch.priv.at>
 <CAMjeLr-a4cCrs0cF0aBRoeeXXLwiM835BXqhP9ZoeLB8=w=YKw@mail.gmail.com>
 <8c18dcc5-9028-672f-1449-359ac3d73592@petrovitsch.priv.at>
 <CAMjeLr-j1XhZJgcvsP5z6SHCDmbUA=rMyfvQpX40qKBK+2ojbw@mail.gmail.com>
 <9be16b08-7aa9-d42e-24c0-f054af39b78a@petrovitsch.priv.at> <20180928165653.17bbdb13@alans-desktop>
In-Reply-To: <20180928165653.17bbdb13@alans-desktop>
From:   "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Date:   Fri, 28 Sep 2018 15:38:37 -0400
Message-ID: <CAKON4OzrMCOdsDy3+NNah=QiqJ+QurjT2br63yV=6Gu+gvUZfg@mail.gmail.com>
Subject: Re: Code of Conduct: Let's revamp it.
To:     gnomes@lxorguk.ukuu.org.uk
Cc:     bernd@petrovitsch.priv.at,
        Mark Rosenblitt-Janssen <dreamingforward@gmail.com>,
        Theodore Tso <tytso@mit.edu>, fche@redhat.com,
        Rik van Riel <riel@surriel.com>,
        Edward Cree <ec429@cantab.net>,
        Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 11:56 AM Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
>
> > Well, then I have to repeat myself: Signed-off source code (in form of
> > patches) in a well-known programming language for a (nowadays)
> > well-known GPLv2 licensed project mailed on "everyone can subscribe"
> > mailinglists, (thus) to be found in several $SEARCH_ENGINE-indexed
> > mailinglist archives, if accepted to be found in lots of publicly
> > accessible git repos can be not intended to be published?
> >
> > I wonder what else must happen.
>
> There is a bigger problem in the ambiguity.

Alan, I think there is much wisdom in the Linux community writing
their own CoC. This CoC would go through the same RFC process that any
kernel commit goes through and be discussed on LKML.  I fully expect
this CoC would contain many of the concepts from Contributors Covenant
but as an independently developed document it would not bring external
baggage into the community. The kernel community is full of very smart
people and has access to fine lawyers. Developing a Linux specific CoC
that expresses the community's views, is compatible with laws in the
varied countries and which respects the GPL is a worthy goal.


>
> It's easy to deal with signed off by lines because I had the sense to
> make sure that the DCO covered us for EU data protection and thus it's
> explicit.
>
> It's relatively easy to deal with the case of 'I contributed some code'.
>
> It's really not at all obvious what happens with 'I got some code from
> another project that contains it's authors name'.
>
> The wording IMHO just needs tightening up - and that's a useful
> discussion that ought to he bad. I tihnk everyone understands the *inent*
> of such wording - don't go around doxing people, or posting their home
> address on facebook and calling for people to attend with pitchforks.
>
> There's a second related area that needs sorting out in wording which is
> the implication of any kind of privacy in a complaint - which is really
> bad in two ways
>
> As it is set up now the tab is not a lawyer so the tab could not claim
> any kind of legal privilege. That means in the event of a complaint the
> tab would be powerless not to release almost all the info in the
> complaint if hit by a data protectin request in many jurisdictions. Sure
> they'd have to (and be required to) remove some of the information that
> might identify the complainant.
>
> Secondly one thing that we've learned repeatedly (and notably from the
> church scandals) is that there are some complaints that should upon
> receipt be handed directly to law enforcement, but there is no carve out
> for this.
>
> The other issue is that whoever handles any complaint system needs a
> budget and lawyers because they will potentially have to field judicial
> reviews and other challenges. That means the TAB needs to have
> exemplary record keeping and process because anyone who stands up in a
> legal challenge and says 'Umm.. we read it and talked about it and kind
> of decided X but I don't remember why and there are no minutes and there
> is on process document' is going to get fried. Someone needs to have that
> process in place well in advance.
>
> Alan



-- 
Jon Smirl
jonsmirl@gmail.com
