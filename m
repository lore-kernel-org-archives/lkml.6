Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0D2ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9282621526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="Q/lRJout"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9282621526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbeJQW4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:56:31 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44158 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJQW4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:56:31 -0400
Received: by mail-io1-f66.google.com with SMTP id s6-v6so8366516ioa.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 08:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+w4uT5M8XVFGHMdg7etMkPkGeFLqeczrwzOvfjem6lk=;
        b=Q/lRJoutlLlmjy0pJ6pvEEgqRgZIkr2eiqBYr4KpVwIuUXhtwujUOPrB/U2pMZpHaO
         P0DZI92LNlVgwdyxTTpYGAbwiAKWQgsm6ynNoBx4jb7xSDzRv8L2A0pKNNe/xXwW9hmn
         ndqC6jT1fpEMrYYZlyTUrVnKq9gGr9oYxukxqiqrkykCa8PB8JoSFMwDi3KZyfXc4CvQ
         SRxL3vaGY0HevinBdEv85Ntv0RoMP8wJAZ2Mlb/WSkEqnBm0ZBdxXEbpRrVR5W+8t8KY
         eEgXTGhX256JyPmjIy/f3Mj/TgLzJkUz9tW/9od/90OIgdAQnoL7agHdvMTmXZvvNI23
         bQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+w4uT5M8XVFGHMdg7etMkPkGeFLqeczrwzOvfjem6lk=;
        b=XKjprXQL8xx098f6QgnS57g3c1Fye7bmHJxidM3SLVicxbL/nBHbWG7fg/cW5P2Vtt
         nvfT7so38BJnfjB+ABRQdg6uo3dC1ZS7O5mL4eG1WEDK7PF8hfX86bo980CTB4iOET2o
         v5iCfnvNbAhnSAXX4cQzOxfNd37rwzZfZLgPiNhXTSZR3d1Fj6clu5xhXkzkKAT/qieO
         UlD08T4op7RbklIT/+YHfloN92LbqZV7zbiq6I0kzQUePmLYLfe7Mb6Kbb+JpJTzmT9A
         CiptJyNKCRhwr63mtUCElfmzqAqWM2AlKWzDyvss8qPT+qVFKziD9uMfEgRmCpEsIYnl
         VItg==
X-Gm-Message-State: ABuFfohOuKTv2BzeV6z9z23BtUONGXTJ91TJ+msEKj6xsG3maGzRQnS0
        K3bQGwSSWKWe/SkNrnZ6G/QLSg==
X-Google-Smtp-Source: ACcGV632yLGjynJrfsjEUlYLd0cCZ67Xf6Wp+LEOfdRDwi6YIEQAuaCQUCDDv7kFeeYPO5fvUsIqFg==
X-Received: by 2002:a6b:cc02:: with SMTP id c2-v6mr15756223iog.180.1539788424969;
        Wed, 17 Oct 2018 08:00:24 -0700 (PDT)
Received: from cisco (174-16-200-171.hlrn.qwest.net. [174.16.200.171])
        by smtp.gmail.com with ESMTPSA id p136-v6sm1057627itb.37.2018.10.17.08.00.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 08:00:23 -0700 (PDT)
Date:   Wed, 17 Oct 2018 09:00:22 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Michael Tirado <mtirado418@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v6 3/5] seccomp: add a way to get a listener fd from
 ptrace
Message-ID: <20181017150022.GA7544@cisco>
References: <20180906152859.7810-1-tycho@tycho.ws>
 <20180906152859.7810-4-tycho@tycho.ws>
 <CALCETrXGBZyqDb7DEysHmOkxaBrXUp4s2X08HfqZkpjM28s3Hg@mail.gmail.com>
 <CAMkWEXNN2_saQN-yQ7Pwgau1YTYQQuih+KLnKj5-cOYa6CyMPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMkWEXNN2_saQN-yQ7Pwgau1YTYQQuih+KLnKj5-cOYa6CyMPw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 07:25:00AM +0000, Michael Tirado wrote:
> On Thu, Sep 13, 2018 at 12:02 AM Andy Lutomirski <luto@amacapital.net> wrote:
> >
> > Or we could have a
> > seccomp() mode that adds a filter but only kicks in after execve().
> >
> > --Andy
> 
> Hey that's a pretty good idea, then we could block execve in a seccomp
> launcher without post-exec cooperation, or that patch I wrote that used
> an execve counter which probably should have been through prctl instead.
> 
> As for the rest of this long thread,
> has anyone mentioned a specific use case that I missed? I didn't see code
> patches sent to the linux-kernel mailing list, only this discussion thread
> so I'm probably missing some important context.  Was it for loading modules
> into kernel from a container?  Couldn't that be handled completely in user
> space without using seccomp at all? Do we really want to turn seccomp into
> a container IPC mechanism? It seems out of scope IMO, and especially
> if it could be handled in user space already.

That's one of the use cases, but there are a large number of others. I
discuss a few in patch 1:
https://www.spinics.net/lists/linux-containers/msg33956.html

> Why does it have to be a file descriptor, what would you be writing back to?
> Could waitid be used somehow instead of ptrace to get notification
> from a filter?

You can already do this with SECCOMP_RET_TRACE. Of course, that means
the task has to be traced, and avoiding that is the point of this
series.

> tldr, can someone kindly tell me how to find all the details surrounding these
> patches so I can stop making really bad guesses?

FWIW, I'm dropping the ptrace bits (and the fd passing bits) from the
next version, because they seem fairly controversial. So this will be
going away.

Tycho
