Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6FD12C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B95208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="1Kjf8xrV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B95208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935665AbeFMT5f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 15:57:35 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37627 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935502AbeFMT5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 15:57:32 -0400
Received: by mail-lf0-f65.google.com with SMTP id g21-v6so5828521lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 12:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WfAXGTm2ylYuYbe7b1X3YHQXpgN/mAxOS+08JLdlQjQ=;
        b=1Kjf8xrVFlXG4ieMLJ5MMY6GCXKPodyBL79RKaX1arfYSJ4Srwk0eCFAPut1FAP+tp
         9rpj56PPIPKnHd37HXjXtTJv4Du5WRyagl7GBCNCxYOVq5NA/R5xVw0TylCL1O7q6u9J
         tN7KqcFwJCMMs1htJbT+qIcn6BWaAR1ygo/V0cF1oW08z70CPoVvceu5dAEpwz7yTBPY
         i2ar85SEJtaqNuS5Bly7LIU9NCsCuh2RTK2/PhuZQc9YBH7N1EXh/4BuJtaPJEm3Wnuy
         TCk24HfE601ukJ8ye87fRYf2RZULSRVuo4ZPi5zPH1dopNp1B4aRvrs4FxVhw0TRL64f
         e7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WfAXGTm2ylYuYbe7b1X3YHQXpgN/mAxOS+08JLdlQjQ=;
        b=Lg1Hl3Vd00f/XJYJgJqdppT1KNt5r8rP5hs/OVGftn/tq1khUdT0wIqydP7TeAAW9d
         klO2cghjKmoPL+Rhhrbc07Mm0uXrO51LAJfQm6A84c0JOK/PWN9/XaW/0yZF2YbpHUKb
         eLUj46jJRI6XACVqONfWIWbRihoZDQVvC6DkoMAUS7PyA4r7SNsLFlvyfmk4k+twFtB6
         okZGgOxhJEXcHqf7pGcNUhvPO/xSzz3l4tmRd4bfzGrJaU7iV6wFWT2s0EGcZTqe4y+j
         tD7GUvCg61/K9biRLwaR+Vt6l5uuSk9TxQxu8hEVbNUZFbVeBjjhRtReuVnlTmDm/s0W
         YaCg==
X-Gm-Message-State: APt69E1hBndDIRsF6PHxiAe3+WskBUvUpFD1LcE5x6wEBqh3nXHCB3fI
        hqCRbARgOi9pdWhINn9j42tdNc9Yxqva71H27Lhl
X-Google-Smtp-Source: ADUXVKJPX8z8RkjnDkxOKxB2B8P0S8B5GIQVZFtLGOJxiiVcjZuaP59ShcGiOR9sq642CTMxkXbXoeHUpamvkpCdZgw=
X-Received: by 2002:a2e:29cf:: with SMTP id p76-v6mr4196531ljp.12.1528919850356;
 Wed, 13 Jun 2018 12:57:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:a911:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 12:57:29
 -0700 (PDT)
X-Originating-IP: [108.20.156.165]
In-Reply-To: <38670733fba157f7acd9c1555b44a296420f0774.camel@perches.com>
References: <1e91f8e10ce76d3208239b6b5899aab76d1543ff.1528743633.git.joe@perches.com>
 <fcac609a-08a8-b3ab-a69e-2e65e2ad63e9@schaufler-ca.com> <alpine.LRH.2.21.1806130631400.13763@namei.org>
 <CAHC9VhTpsYDT5+CjdtiBmLMDEKV9fmGv+DyXVtUuja9d4i2ecg@mail.gmail.com>
 <3d890108a942b6a3fb9a5326501174af270707dc.camel@perches.com>
 <CAHC9VhRHd+nxKQRj5PjoN7Te3NjomtWcb_0ZxzcxAzwX024m9A@mail.gmail.com>
 <00961ef3fb41930a3304da935f1f73ebe386e83c.camel@perches.com>
 <CAHC9VhRXBx_Q2eM48FFqX9PbPz0k8R74gfFFoRhwV91n2_BPsQ@mail.gmail.com> <38670733fba157f7acd9c1555b44a296420f0774.camel@perches.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Jun 2018 15:57:29 -0400
Message-ID: <CAHC9VhRX7Vx9_FB69EgxLypo1SnA9bobtxeLn8KzuHEN8CSaNA@mail.gmail.com>
Subject: Re: [-next PATCH] security: use octal not symbolic permissions
To:     Joe Perches <joe@perches.com>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 3:30 PM, Joe Perches <joe@perches.com> wrote:
> On Wed, 2018-06-13 at 12:19 -0400, Paul Moore wrote:
>> On Wed, Jun 13, 2018 at 12:04 PM, Joe Perches <joe@perches.com> wrote:
>> > On Wed, 2018-06-13 at 11:49 -0400, Paul Moore wrote:
>> > > On Tue, Jun 12, 2018 at 8:29 PM, Joe Perches <joe@perches.com> wrote:
>> > > > On Tue, 2018-06-12 at 17:12 -0400, Paul Moore wrote:
>> > > > > Joe, in general I really appreciate the fixes you send, but these
>> > > > > patches that cross a lot of subsystem boundaries (this isn't the first
>> > > > > one that does this) causes unnecessary conflicts in -next and during
>> > > > > the merge window.  Could you split your patches up from now on please?
>> > > >
>> > > > Sorry. No.  Merge conflicts are inherent in this system.
>> > >
>> > > Yes, merge conflicts are inherent in this system when one makes a
>> > > single change which impacts multiple subsystems, e.g. changing a core
>> > > kernel function which is called by multiple subsystems.  However, that
>> > > isn't what this patch does, it makes a number of self-contained
>> > > changes across multiple subsystems; there are no cross-subsystem
>> > > dependencies in this patch.  You are increasing the likelihood of
>> > > conflicts for no good reason; that is why I'm asking you to split this
>> > > patch and others like it.
>> >
>> > No.  History shows with high certainty that splitting
>> > patches like this across multiple subsystems of a primary
>> > subsystem means that the entire patchset is not completely
>> > applied.
>>
>> I think that is due more to a lack of effort on the part of the patch
>> author to keep pushing the individual patches.
>
> Nope.  Try again.
>
> Resistance to change and desire for status quo
> occurs in many subsystems.

Which gets back to the need for persistence on the part of the patch
author.  If your solution to a stubborn susbsystem is to go around
them by convincing another, potentially unrelated subsystem, to merge
the patch then I firmly believe you are doing it wrong.

>> > It's _much_ simpler and provides a generic mechanism to
>> > get the entire patch applied to send a single patch to the
>> > top level subsystem maintainer.
>>
>> I understand it is simpler for you, but it is more difficult for everyone else.
>
> Not true.

I think we are at the agree to disagree stage.

The way you have structured this patch it makes it easier for you to
submit, but makes it potentially more difficult for me (likely other
LSM maintainers too), the -next folks, and Linus.

> It's simply a matter of merge resolution being pushed down
> where and when necessary.
>
> See changes like the additions of the SPDX license tags.

Please don't even try to suggest that this trivial patch you are
proposing is even remotely as significant as the SPDX change.  There
are always going to be exceptions to every rule, and with each
exception there needs to be a solid reason behind the change.  The
SPDX change had a legitimate reason (legal concern) for doing it the
way it was done; this patch isn't close to that level of concern.

>> Further, where the LSMs are concerned, there is no "top level
>> subsystem maintainer" anymore.  SELinux and AppArmor send pull
>> requests directly to Linus.
>
> MAINTAINERS-SECURITY SUBSYSTEM
> MAINTAINERS-M:  James Morris <jmorris@namei.org>
> MAINTAINERS-M:  "Serge E. Hallyn" <serge@hallyn.com>
> MAINTAINERS-L:  linux-security-module@vger.kernel.org (suggested Cc:)
> MAINTAINERS-T:  git git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
> MAINTAINERS-W:  http://kernsec.org/
> MAINTAINERS-S:  Supported
> MAINTAINERS:F:  security/
> MAINTAINERS-
>
> If James is not approving or merging security/selinux or
> security/tomoyo then perhaps the F: entries could be
> augmented with appropriate X: entries or made specific
> by using specific entries like:
>
> F:      security/*
> F:      security/integrity/
> F:      security/keys/

That is a good point.  I'll put together a patch for selinux/next as
soon as the merge window closes.  I'll let the other LSMs do as they
see fit.  As I said previously, I believe the only other LSM that
sends directly to Linux is AppArmor.

-- 
paul moore
www.paul-moore.com
