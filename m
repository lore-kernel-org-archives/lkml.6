Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B23C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5492086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544629571;
	bh=5enrAM6ZpjqZSHv/N1wzjeQE7yf+/9/XKqO4PCBk4X8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0tI+Bu8awa8clXv83YjP8NGlFNUZgnGkxb6TNBG1kY71hOWsPG4c7X2c/HQ0D7hVe
	 soDoOr035bBtRQelcnUYvJXDwRVxV/s/h3sj7uQKDw/E827hTH1niFvGbM+YBe46gq
	 RJ3Iq5aP8gYgybFs9D3rb9wnqqc8mqrkJ0bLQS/s=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5492086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeLLPqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:46:10 -0500
Received: from mail-qt1-f182.google.com ([209.85.160.182]:41010 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeLLPqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 10:46:09 -0500
Received: by mail-qt1-f182.google.com with SMTP id d18so20935050qto.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 07:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7ROe6wvRxdMjJizUnyaCJMkft2Ey7iHnqNLwAW4MDb4=;
        b=MFiWiLig1WK+d7pM2ayUyMGxhkpy9TkVid7GR2WpFG6DxA+rKBOREAngnHl+qLNbb3
         hXmS8artYqSvSI+p6Ei2J6vqg6EDxQF4nqFdCH3BYwxmSWZpRm4KMBiyXOzxWeWzxCoD
         zsOrXGVnj5uERz/knRmmX94KHxfSgK3HEX5OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7ROe6wvRxdMjJizUnyaCJMkft2Ey7iHnqNLwAW4MDb4=;
        b=maAGJljzBHtWVKM9eLXEFT4Gci+b+KuZmfcpH0BRf17cxRqb0lWwHo57c3O9kjQqPu
         sN3rxb64f7M90tq/oUEdA068EkQ0vGQKeaY/i5hiOzhZ3Et2Ospapr+NVzfsDKUkwxan
         WuJPAkrcywA12eD7B76NKUD7gJYpPvMpcrwJS1JmvjM2oQhmXpmMuCDWjnI2epmsYuVY
         6gGSSEhj+nem3ri3+sh3hxtd125oh2YRR5N8uO54z8zjZhnaiMpOGF4+DdoyX2Ry6csF
         ZhMVCI71MchCY/npElsXyVmCWBE6a+ihVsyTT/ZGQWkq5VsJc39D/yZifuxla/Tqd8xf
         JlHQ==
X-Gm-Message-State: AA+aEWZrjlURUEYJLcXWZS1o0j7cvy3xkPxWy2WO/TuYy8rihXWMUhT6
        AVzUMUI2E9vyIqDv3tUnmbeNDQ==
X-Google-Smtp-Source: AFSGD/WK15zNn4b5C8k0YfPYbWn82THJgy2CgtaWWGbdDg4dznTHUYu5a1176WT0vw+1laAZ23S/ng==
X-Received: by 2002:ac8:4055:: with SMTP id j21mr20093700qtl.389.1544629568701;
        Wed, 12 Dec 2018 07:46:08 -0800 (PST)
Received: from pure.paranoia.local ([198.144.156.49])
        by smtp.gmail.com with ESMTPSA id r67sm13738893qkr.28.2018.12.12.07.46.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 07:46:08 -0800 (PST)
Date:   Wed, 12 Dec 2018 10:46:05 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the gfs2 tree
Message-ID: <20181212154605.GC17249@pure.paranoia.local>
References: <20181212072402.7b967df7@canb.auug.org.au>
 <20181212073802.2fc8dc53@canb.auug.org.au>
 <CAHpGcM+wCSrj0pk89ZoMENp+L_zSXbSFhEJcsdDEOh1F-GmGvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcM+wCSrj0pk89ZoMENp+L_zSXbSFhEJcsdDEOh1F-GmGvg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 09:47:43PM +0100, Andreas Grünbacher wrote:
> > Now, after the rebase:
> >
> > Commits
> >
> >   187e4dad3f55 ("gfs2: Remove vestigial bd_ops")
> >
> > is missing a Signed-off-by from its committer.
> 
> Yep, I've not asked for a way to get the server to reject or warn
> about such pushes without a reason.

We don't run checks on push that involve iterating through commits,
because most of the pushes we receive are merges and rejecting on a
commit somewhere deep in an octopus merge would just result in angry
maintainers.

Best,
-K
