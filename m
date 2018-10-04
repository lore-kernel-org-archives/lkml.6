Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25C8C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F6320877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F6320877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbeJEDew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 23:34:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40717 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeJEDew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 23:34:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id s5-v6so3947415pfj.7;
        Thu, 04 Oct 2018 13:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2uXS6aWYvA+zYMcIioiCW+XSet7+x1KyCmctnmDjKGw=;
        b=rwBqhwsIG4wrrH6NhHZYuHOzKwKngTAnWGX77zhBqk77Tdo0bQwvCTFSjXxSE+KARq
         yjZVyQmvpWGEGDn2q0ptaKWNSwwKVJkemNwywFdDLkECyZirTTjpu2UXIxCRtYkwgjm5
         SLoF2V8h11jU30lgT+5FdiabiqcDIJQtWmbSz0cQdrkAB8paaB2iUSESHomd4SOCk4tw
         +xC+79pHTIXy0BRFSUapsKwLho3AF0DgWv/mAJONvuBHpsLBMfPqV3gq3AMCdmAm8v06
         IjVA1paezh31CLNRJQB/kF6LZhEA/mE+bUsf/fxihYyOwBwmXOQUD/yUDrKljW+YTRy7
         gTFw==
X-Gm-Message-State: ABuFfojoImpG+nXHfVYRdTwM2PWkUi4rwUrmGY4cv0RLETu4VteNQnFF
        FNl6tIsB3EA+gL9+fUyOTcU=
X-Google-Smtp-Source: ACcGV61sRgxpdrWl7zH/8V10FRp7h7cT3tTyhK0tDl6EYAGKU7AkWJkBDac/htCZvxPWk0WPPHye6w==
X-Received: by 2002:a63:5660:: with SMTP id g32-v6mr7041505pgm.227.1538685593684;
        Thu, 04 Oct 2018 13:39:53 -0700 (PDT)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id h87-v6sm2616196pfj.78.2018.10.04.13.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 13:39:52 -0700 (PDT)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Thu, 04 Oct 2018 13:39:50 -0700
Date:   Thu, 4 Oct 2018 13:39:50 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-kbuild@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>, Petr Vorel <pvorel@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Felix Fietkau <nbd@nbd.name>, kconfig-sat@googlegroups.com
Subject: Re: [kconfig-sat] [ANN] init-kconfig - easy way to embrace Linux's
 kconfig
Message-ID: <20181004203950.GN5238@garbanzo.do-not-panic.com>
References: <20181004200249.GL5238@garbanzo.do-not-panic.com>
 <20181004200859.GA10237@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004200859.GA10237@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 01:09:00PM -0700, Josh Triplett wrote:
> On Thu, Oct 04, 2018 at 01:02:49PM -0700, Luis Chamberlain wrote:
> > Every now and then a project is born, and they decide to use Linux's
> > kconfig to enable configuration of their project. As it stands we *know*
> > kconfig is now used in at least over 12 different projects [0]. I myself
> > added kconfig to one as well years ago. Even research reveals that
> > kconfig has become one of the leading industrial variability modeling
> > languages [1] [2].
> > 
> > What is often difficult to do though is to start off using kconfig and
> > integrating it into a project. Or updating / syncing to the latest
> > kconfig from upstream Linux.
> > 
> > I had yet another need to use kconfig for another small project so
> > decided to make a clean template others can use and help keep it in sync.
> > This is a passive fork which aims to keep in sync with the Linux
> > kernel's latest kconfig to make it easier to keep up to date and to
> > enable new projects to use and embrace kconfig on their own.  The goal
> > is *not* to fork kconfig and evolve it separately, but rather keep in
> > sync with the evolution of kconfig on Linux to make it easier for
> > projects to use kconfig and also update their own kconfig when needed.
> 
> Is there a *fundamental* reason that we couldn't have this *be* Linux
> kconfig, whether pulled in by submodule or regular merges, and avoid
> having any divergence at all?

The structure of kconfig in Linux would have to be changed to make
adoption and sync easier. If that is a goal we wish to embrace, I'm
all for it.

  Luis
