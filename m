Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C557C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D53921720
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="bnyzvKWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbeLaVep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 16:34:45 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36848 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeLaVep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 16:34:45 -0500
Received: by mail-lf1-f66.google.com with SMTP id a16so18866349lfg.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 13:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Uy5fa1TLSuQ69CNtPL1RugTu3eJ1608hyl6e4NGebXA=;
        b=bnyzvKWLK7raDHo6lVWyh7ticJupmdaV4vnufr8IyHyV9SmnrHxAYKAFx7ppTCUVlJ
         66h6xeAbm6DqTbUqZZsONMdzE4O/iDDkpjsWy/8qnpOPzbL1YKiQEbze8ZuIHVI+ARMt
         dPykBFdFywoJD9pPm6oRoMb5Hfkjh6rf53H+BSfyJKt0MZFNh7wEpnPgKpvnCflMHYne
         heMV/Cj7sjJABaE8BqmmAcAhrDoWHxD+GD8J6ufek6gFbeSt6YUCGN4JbytJtREwVBw5
         jBw0jVFg1axIvs/jJlRYVrgvwEjn/vEAwNhNUk/H1Wuk0c+4B32rd9AleqXzviBVLn1G
         vXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uy5fa1TLSuQ69CNtPL1RugTu3eJ1608hyl6e4NGebXA=;
        b=UtGRePEOrzRFW9NCvNyLxDXxPZlwazokUj9ZthC+trcn79fHSHFz5DBXbGq56pFfxL
         T34lHDnmvkCpR7RPDjwywBKd61va6kVTJETRaCgHavP008i1yF4GeWSRj7VTBilUe7dO
         kLJoD37m+FE73vrsE8IwIKNrTBzIb6qlW50ziOBL5TolWO0HQvly6p+uS2d8VGWsW/Ht
         aTVtvrct7TOkbSR2jmupchvpduVrmKR6+wZpLHGmzQHntIkGcBQoR2+GJR9cPd1iHWSP
         LvLTj5YyS5hrYTXySN9WcBT5Zw+NFKJegbZ1LlQV5h1MUBEClsSQ6wTHK2Os5UkcXMRi
         Epyw==
X-Gm-Message-State: AA+aEWZ5ZvdmPZBE8oGPRLPE4ZCLjbkhaSfOxTbP6O1SzcUeC2lP924P
        HuDz7HsUmvYfTA5tniU9bvuY8g==
X-Google-Smtp-Source: AFSGD/XmtbLtxyim/Tnj9LgrB3yxJt3M3ChmdLSBrO2uQ+WVunVrAI+BBu+UGWCrsqmeTzaU7oymgg==
X-Received: by 2002:a19:5510:: with SMTP id n16mr18791078lfe.68.1546292081646;
        Mon, 31 Dec 2018 13:34:41 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id l3-v6sm10416120ljg.21.2018.12.31.13.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Dec 2018 13:34:40 -0800 (PST)
Date:   Mon, 31 Dec 2018 13:06:17 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     arm-soc <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [GIT PULL] tee driver fix for v4.21
Message-ID: <20181231210617.6cxtq2nqynil2ltw@localhost>
References: <20181212122800.GA29450@jax.ideon.se>
 <20181212213617.mltwlxfcbap4prlj@localhost>
 <CAHUa44F=_DmhnvKxCAfErBcGL96=nmW0eSvgdhkF+pb+c-zhjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHUa44F=_DmhnvKxCAfErBcGL96=nmW0eSvgdhkF+pb+c-zhjg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:29:06AM +0100, Jens Wiklander wrote:
> On Wed, Dec 12, 2018 at 11:16 PM Olof Johansson <olof@lixom.net> wrote:
> >
> > On Wed, Dec 12, 2018 at 01:28:00PM +0100, Jens Wiklander wrote:
> > > Hello arm-soc maintainers,
> > >
> > > Please pull this tee driver fix for a possible double list_del() in the
> > > OP-TEE driver while uninitializing.
> > >
> > > Thanks,
> > > Jens
> > >
> > > The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:
> > >
> > >   Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-subsys-fix-for-4.21
> > >
> > > for you to fetch changes up to b2d102bd0146d9eb1fa630ca0cd19a15ef2f74c8:
> > >
> > >   tee: optee: avoid possible double list_del() (2018-12-11 14:38:21 +0100)
> > >
> > > ----------------------------------------------------------------
> > > Avoid possible double list_del in supplicant comms
> > >
> > > A fix for the OP-TEE driver to avoid possible double list_del during
> > > tee-supplicant communication while the system is shutting down.
> >
> > Do you want this for 4.20 or 4.21? Seems like .20 material to me but the tag
> > name is 4.21.
> 
> It's just that we're so late in the 4.20 cycle. If you're OK with
> taking it now I'm happy with that.

I dropped the ball on this before the holidays, I've queued it up in
a next/late branch now so we'll send it in towards the end of the merge window.


-Olof
