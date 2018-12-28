Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3542C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B239E20873
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546001350;
	bh=Fvaz5kHbWoU2hcomRafWjmAvnKC+g1veMxWhIuZlnbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s+gIOP3tGQrzYeLGvCNkqUxKAL19sBNxXd3h29UdsSgI8qVEgfwJA82RJepJzzLIz
	 N6mk/cVwn3O8JtDqj7HJ7o9dMRpkTyjTx/0BD+1kloMeAz+2UnDZmuprma3ItCvs+4
	 LJWXw6O3Nrbx+vJhrXgvqDwpM8UwaqKo+9TMCZQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbeL1MtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:49:09 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36713 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729832AbeL1MtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:49:09 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so19664716wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 04:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pDuBV0J8gEFUT2C/YG5kiHgW3KPzlCz/R9KpBQIhxyI=;
        b=We33a4w5WnnII+Y5qnYMweAedkgXDus1bEspQd9bGZ54lh1GRijGsmMgwJK7PmJUHg
         PRWJXQnsBlotNBwxkUMAwrtjCzWfnYvRV6qNUZvJpia4p/lTwFTh1c7dXeMTx99oe9Kj
         4TNQ+XbHqlr8imVzdI3PMX9fN8U3lH7mlmH4XfeYFMTQP+0W5p2FVNIizjP2z6oR1W1r
         fIG7hgiUNM9874D2TsO2d2b9Afdk2tdOz9GcrV5nAH1rcQM5yEa56Z5Xme3W4whd8CWF
         nxk1CC1v7XKcycP9yeB4sQgM11zZRzIFxyqkLIkYldqIMQni/5KiYscoszlPdbPG8T91
         e0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pDuBV0J8gEFUT2C/YG5kiHgW3KPzlCz/R9KpBQIhxyI=;
        b=BAa0KkRBhRSCYJw48Bt/rF6Uu5QSYeEY0qjISTejdjd+aQ9/TI3gvwnP2f14SKJM0T
         fIro5ryGWiFkG3ABn9DuK9vafyO05ZJNnB3ndwvDFmmmWw3yrIKgP6MRhR4VtSeHpiHN
         ckdbyWsyNVDCBsl1GeaeLfRWU5HcwRgKYlG6SB1+lgbb49EqdhnhyQC69w9fJV0jvuaC
         XG6/eMt1XrHCe7z533eVp8VucFZMDkE/Eu1wxvvR7EDWxE61meJjPF0HAMuk063RQRzd
         ksLhP58wlgjkJc8bmVBI3HtpN4b0XNfzqQiOwf9ig+/6wsttsWXzO05WO6iO7/+04azh
         Pfqg==
X-Gm-Message-State: AA+aEWaPYti/UGqF+JtVS/4eW3ndITOEbxvOqasFkHpVHtih1qvyplPe
        +NBHEUCV9G4KB3wkP2zuYdCEvFD2
X-Google-Smtp-Source: ALg8bN55d0xTeex4+uyOE1A63PYCyW7+STilngDfizLwBIZnaUrurvEAJW0vXIDcV4R+vLA2Tyq5WA==
X-Received: by 2002:a7b:cd85:: with SMTP id y5mr23025356wmj.129.1546001347239;
        Fri, 28 Dec 2018 04:49:07 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id m193sm28201335wmb.26.2018.12.28.04.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 04:49:06 -0800 (PST)
Date:   Fri, 28 Dec 2018 13:49:04 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>
Subject: Re: [GIT PULL] x86/cache updates for 4.21
Message-ID: <20181228124904.GC20003@gmail.com>
References: <20181223124859.GA26860@zn.tnic>
 <CAHk-=wiX_6f+7DUaG-x2cQHctjtSHdMrtAeixitOQkbswq2scA@mail.gmail.com>
 <20181226205616.GA4557@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226205616.GA4557@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@suse.de> wrote:

> On Wed, Dec 26, 2018 at 12:26:12PM -0800, Linus Torvalds wrote:
> > I've pulled this, but I think the new config option name is bad.
> > 
> > I think it should probably have been called "X86_RESCTRL" instead of
> > just "RESCTRL". That's way too generic a name for something that is
> > (at least currently) very much an x86 feature.
> 
> Right you are...

... and it's almost as if someone complained about this already:

   https://lkml.org/lkml/2018/11/23/389

   "Also, the Kconfig space, when it gets extended with the AMD bits, should
    probably follow the same nomenclature: CONFIG_X86_CPU_RESOURCE_CONTROL=yor such."

;-)

Anyway, I kind of dropped the ball after that first round of complaints, 
should have looked again.

Thanks,

	Ingo
