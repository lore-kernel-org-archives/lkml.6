Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38437C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F185820675
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="T3EdRF6w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfACUMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 15:12:41 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42265 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfACUMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 15:12:40 -0500
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so30706151lja.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 12:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3HRbx+kANi/LpX7QSrBgebnH4xitj7ViR0/Kwe3qcrM=;
        b=T3EdRF6wAwt0dsopDCHCKHC+2B1tLHJxrZiZYiDLnubB73dt40CrrtURGkdWIS7xzs
         2PJBNE3NTkImdT8t/jWGPsdvaWmA7dJwvOlBLe/SKyL+NzkfYlXV6YpIY7bRF6EIS1H6
         f81UURnqW1bT6pD911GUteKYCzDN3yMs07nw6Cm7yAZsDodqZdu6XEpBaAriQSH1p6hr
         0APWWXVvYgZxUmK6iSUKXk91R8mJWSfmFTmkdbuDySKIXCcNhQOUUmJ2JBM4lHtBF8HU
         91CpT2eiDlxQ4ATgdj6YUBg/CsVkIrBT5mWOupJXnWxssH7lPwGjLdF2OORw1DTZajxX
         YWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3HRbx+kANi/LpX7QSrBgebnH4xitj7ViR0/Kwe3qcrM=;
        b=AlePzDn8BpGkCbL7yxh59olkxGlonEIPIniTGjHS+ZtpOTbTCL1DcmdQAgwHBm1WUu
         5J1BeRCibZKYDeTkxnVs8iczIVh62wo7wwi9w+HybSdEqwWXVpaVf8dxcjlFUkYqnFiT
         ej0smGsItZNM3hgQnc4gwnzHUC5K7YhXAUDdtlMxH8yhjZawyUFfIOPT2X57+2Omb8DR
         5ptMZiMi3PiY68j+0gsnVc7NHLX+NFLU30TVnBrLtwPUzUAHOODQUXVbmbuvLUG8THsH
         cVgYni6rOsmje+Lr0mUcjmq3U15Ki/pSfqSVC9tNKkLPmDy2ggdVkDq4HSLTLqDCHOsU
         /vDg==
X-Gm-Message-State: AA+aEWahWQSRrIcKPKgpuQ40EbIDkKW02+aJysHf/mr6ojdru4a/wpWw
        Bmk1ixhV25ovZYvgJ++hIz3L8ZY6Tm/VJZ0cRc9w
X-Google-Smtp-Source: ALg8bN60S7zQVqgl1jOEk8Ggm5y00BtZG02jMl4fzYrBA041Jcjk5Vgx0Hsvqw1ptVYNjoGExrNv61JynMGEy5jHnCg=
X-Received: by 2002:a2e:880a:: with SMTP id x10-v6mr29867987ljh.174.1546546358526;
 Thu, 03 Jan 2019 12:12:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1533065887.git.rgb@redhat.com> <20190103161525.GA6551@roeck-us.net>
 <20190103173613.jb5kukysslozytwg@madcap2.tricolour.ca>
In-Reply-To: <20190103173613.jb5kukysslozytwg@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 3 Jan 2019 15:12:27 -0500
Message-ID: <CAHC9VhTzX6dJCqAN_8Vpd5t7JhZamu2gRDRQve1-ubz739GsSg@mail.gmail.com>
Subject: Re: [PATCH ghak90 (was ghak32) V4 00/10] audit: implement container identifier
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, ebiederm@xmission.com,
        simo@redhat.com, carlos@redhat.com, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dhowells@redhat.com,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        netfilter-devel@vger.kernel.org, viro@zeniv.linux.org.uk,
        luto@kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 12:36 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2019-01-03 08:15, Guenter Roeck wrote:
> > Hi,
> >
> > On Tue, Jul 31, 2018 at 04:07:35PM -0400, Richard Guy Briggs wrote:
> > > Implement kernel audit container identifier.
> >
> > I don't see a follow-up submission of this patch series. Has it been abandoned,
> > or do I use the wrong search terms ?
>
> Guenter, thanks for your interest in this patchset.  I haven't
> abandoned it.  I've pushed some updates to my own (ill-publicized)
> public git repo.  This effort has been going on more than 5 years with 8
> previous revisions trying to document task namespaces and deciding that
> was insufficient.
>
> For this patchset I waited 11.5 weeks (80 days, Jules Verne anyone?)
> before the primary intended maintainer did the first review, then I
> responded within 2 weeks with further questions and a followup patch
> proposal and then waited another 8 weeks for any response before adding
> another query for that followup patch proposal review at which point I
> got a rude answer saying I had disappointed and exhausted the
> maintainer's goodwill with some hints at how to proceed just before new
> year's.

For what it is worth, I've found your emails to me to be rather "rude"
as well (to borrow the term), and I responded with what I felt was
appropriate.  Perhaps our interactions may have been seen as overly,
or quickly, harsh but I would remind those that we have several years
of history that extends far beyond the lists which obviously affects
how we interact.  Our expectations for each other are clearly higher
than either of us are delivering, so I'm going to suggest what I've
suggested before, albeit privately: let's stick to the code, that's
where we can find common ground.

There were only a few outstanding threads/questions from your last
posting, you should have responses to those sitting in your inbox now.

> I'd be delighted with other upstream review to get other angles and to
> take some of the load and responsibility off the primary maintainer.
>
> I expect to submit a v5 within a week without having had those questions
> directly answered, but with some ideas of what to check and verify
> before I resubmit.  Most of the changes have been sitting in that branch
> for two months, already rebased one kernel version and will need
> updating again.

-- 
paul moore
www.paul-moore.com
