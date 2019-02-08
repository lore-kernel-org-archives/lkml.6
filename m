Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0DAC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B95A21908
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ns5QJS7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfBHVoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 16:44:37 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45786 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbfBHVoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 16:44:37 -0500
Received: by mail-ua1-f66.google.com with SMTP id e16so1602576uam.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 13:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YJW9rMF5DRZYQjdws4gaur4H8MyvRZ8SXf+L2porsaA=;
        b=ns5QJS7c59bqnR5dfI9O8Dpz2Snqke6o/2UbEyWR5fxjOAgFSUMXgg2gk18oX2Oc8Y
         uV3bY56NJa44RqhsZ5g+qiC7uPwODc9d6VnOJ1b6s0jYpiumVarKDkdUPmFKT3kLTlDJ
         SBlU1/EanMQyMkYwq/4Ndr2OWBVzFu1n+QDrO5cS9aieV/ODJpJEtObQ1xkb6yGtyCWg
         EI/BJCo5Hh7kEmRH1ikg1dRgNVe9ypVjsd5oUJiN0oQKE+MVJCC4ReksZwsAdA0dhi3D
         tSfGK7DvoTgaV4ben/MqhHEfxSoxH2rulgL4VSl5r5gX9aFyDVYq5oACytv3lf02vNhp
         atDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YJW9rMF5DRZYQjdws4gaur4H8MyvRZ8SXf+L2porsaA=;
        b=l/XEmumEHu7LRM2fi6zK2qbYlMm07COtrvsB7HMyiGsD4W01xUGD8skAPLc8usORZb
         XDtUVkb57Qe18Uyq/EhES+RH3EIqf5uY690hgO6AcZjQVIxZVGAz2zSuFNo2dK2Uex4t
         BWAY4JiokVphpwrnm1WCuvJIWdKF22RavY5vnmStcNbLJ1Lq1ZfmLeIP4MzEJDV1vtQq
         b+0t1y55gGSOfQuyAhzH7mviVC5IUufjKzbIxTp0Yp2Ql9L1dfqIOp1a2NsQagGELMLd
         NAvJt7wpnOuhy4yKdImW6wBpM0qVfYW5w18ey5EsXRruRFMeZBmb5n9jq4Qd7QISkJf1
         BYYw==
X-Gm-Message-State: AHQUAuZ8mwswaxS1qbCdFL+43bt2GJ7E4l8fpx7pOh1clW637fG0H/yx
        5bOko8iLRWdIjMB3o6a63UiEg2tczW7G0SAWKbM=
X-Google-Smtp-Source: AHgI3IaT+q8xjSGUoJe8VIQuGevSW0/ZVvKsdb3G2YdA5C7Vjr1CHHY2vEH7w7b/OCICVOtDcID/REyHWlaDRnMI89A=
X-Received: by 2002:ab0:6446:: with SMTP id j6mr9378857uap.2.1549662276126;
 Fri, 08 Feb 2019 13:44:36 -0800 (PST)
MIME-Version: 1.0
References: <20190204203254.4026-1-oded.gabbay@gmail.com> <20190206115237.GA6750@rapoport-lnx>
 <CAFCwf10K9Ejqm_=jrtOyXAs4yL-6zs1X79O=dwjg=2jmB3PPYA@mail.gmail.com> <1c29159a1b55cb6ad278023588861268e22e626c.camel@perches.com>
In-Reply-To: <1c29159a1b55cb6ad278023588861268e22e626c.camel@perches.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Fri, 8 Feb 2019 23:44:11 +0200
Message-ID: <CAFCwf12SPXjuDSfViSTLZexdi1YoNKqcGtb6k3H5bU6o2kzmeA@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] Habana Labs kernel driver
To:     Joe Perches <joe@perches.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>, ogabbay@habana.ai,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 11:43 PM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2019-02-08 at 23:33 +0200, Oded Gabbay wrote:
> > On Wed, Feb 6, 2019 at 1:52 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > > On Mon, Feb 04, 2019 at 10:32:39PM +0200, Oded Gabbay wrote:
> > > > Hello,
> > > > This is v3 of the Habana Labs kernel driver patch-set. It contains minor fixes
> > > > according to reviews done on v2. In addition, it is rebased on v5.0-rc5.
> []
> > > Nit: git am is unhappy about black lines at EOF, e.g:
> > >
> > > Applying: habanalabs: add basic Goya support
> > > .git/rebase-apply/patch:29: new blank line at EOF.
> > > +
> > Yes, but on the other hand, joe perches gave me a comment about
> > missing newline at end of Makefile.
> > So either diff will complain or git am.
>
> Not really.
>
> The desired modification was the last non-blank line of
> the Makefile should have a terminating newline, not that
> there was a blank line at EOF.
>
>
ok, thanks for the clarification, I'll fix that.
Oded
