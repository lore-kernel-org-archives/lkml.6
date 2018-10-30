Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D72C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB0420664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="y30ofgft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB0420664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeJaGtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:49:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43943 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725743AbeJaGtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:49:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id n10-v6so6311822pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 14:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rew2gv4nVpDtTMnjKCCNmg5kcJfYNGTT9ybPrEx+zJQ=;
        b=y30ofgftD0wIeQyusVx0RfEuXqttEXrfgimH/kIKElSYpGPd+eTZWstqQPjcWcbEat
         a6AgsyGckFFVgcaNoneYihXEWf8Uk7c7sCtZAoZdNx4WfhPj+9qbPODLd+n7EdVzLF2C
         sA+9J/Al0oFrfKkxskDlAqwoQ5PHAzlT87RhRfrZS6KaocRnb4Rd0vEPH70NpNEbAxAn
         uBG1yVG3Q1Vy29entfqF/rbEJxNI6jhwpACjyr3tA9CRx6vZZTGLWgBCNjfShR1p8ZKu
         4GjwOTGoumN829cd/+BA8HFLoUGs03eA4FNhCf7G082xHWEXR4zYK4jbzE9qrOhk2Q/h
         TNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rew2gv4nVpDtTMnjKCCNmg5kcJfYNGTT9ybPrEx+zJQ=;
        b=WaMrjw79gh2BuYEGcpXC49oCYMU6AjxnDMJOYY7nzacRCepMig/uJR9RJiRFxLo1hp
         sFNwFfv7cMm4mKydJoGzWZ7DQ3+A82E+8xirzEeB47B3fHypkcpZ99sLzrpHlfCU8V3j
         QmncbzIH9vhbPvuL0f65siUiAon+IfpyGv1QLiKi5ugfSHU9Rbs02ljqH3N6nVm9Uwof
         SUqmPAt3tPvDYhgqVsfG/8W0sjrYUYz2kbafaM55g/wMCENnQeA5FdFlHKDk2vEZPfiu
         uwOQwbjbTa8Bp/MmjbHQADfZnv0kDFRk+U92TTAkNaRglvGyE6KGXFr2UzS3OOVeM9lc
         z6ZQ==
X-Gm-Message-State: AGRZ1gL+NgePr40+Im4M8511DGgsnBSRq9kYV2lt3ybT0jF8mHoSnTkQ
        kTnCp+RI2xSovX7yVJ7hkAC0LQ==
X-Google-Smtp-Source: AJdET5eD4JV8kM0uXTB1HgZyo1g+QYgmjGCh3oJIPxI97sUoNTs284t/4yLY5xZgwqvYBkw8EARUSA==
X-Received: by 2002:a63:2586:: with SMTP id l128mr475518pgl.104.1540936448037;
        Tue, 30 Oct 2018 14:54:08 -0700 (PDT)
Received: from cisco ([128.107.241.161])
        by smtp.gmail.com with ESMTPSA id d2-v6sm44579313pfj.122.2018.10.30.14.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 14:54:07 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:54:04 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v8 1/2] seccomp: add a return code to trap to userspace
Message-ID: <20181030215404.GF7343@cisco>
References: <20181029224031.29809-1-tycho@tycho.ws>
 <20181029224031.29809-2-tycho@tycho.ws>
 <CAGXu5jLjum=TDab67L5XdWKEmzU_5rYeLfGXB1vb2BmfZdPuHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLjum=TDab67L5XdWKEmzU_5rYeLfGXB1vb2BmfZdPuHQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 02:49:21PM -0700, Kees Cook wrote:
> On Mon, Oct 29, 2018 at 3:40 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> >     * switch to a flags based future-proofing mechanism for struct
> >       seccomp_notif and seccomp_notif_resp, thus avoiding version issues
> >       with structure length (Kees)
> [...]
> >
> > +struct seccomp_notif {
> > +       __u64 id;
> > +       __u32 pid;
> > +       __u32 flags;
> > +       struct seccomp_data data;
> > +};
> > +
> > +struct seccomp_notif_resp {
> > +       __u64 id;
> > +       __s64 val;
> > +       __s32 error;
> > +       __u32 flags;
> > +};
> 
> Hrm, so, what's the plan for when struct seccomp_data changes size?

I guess my plan was don't ever change the size again, just use flags
and have extra state available via ioctl().

> I'm realizing that it might be "too late" for userspace to discover
> it's running on a newer kernel. i.e. it gets a user notification, and
> discovers flags it doesn't know how to handle. Do we actually need
> both flags AND a length? Designing UAPI is frustrating! :)

:). I don't see this as such a big problem -- in fact it's better than
the length mode, where you don't know what you don't know, because it
only copied as much info as you could handle. Older userspace would
simply not use information it didn't know how to use.

> Do we need another ioctl to discover the seccomp_data size maybe?

That could be an option as well, assuming we agree that size would
work, which I thought we didn't?

Tycho
