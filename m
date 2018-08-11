Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14255C46464
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 02:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF636223DC
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 02:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="H/1F1P0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF636223DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbeHKFFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 01:05:04 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37279 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbeHKFFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 01:05:04 -0400
Received: by mail-it0-f67.google.com with SMTP id h20-v6so5337612itf.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 19:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ur4f9/w+LFWvIoYHvdY+PE05LjiSedDGlF7sC7pzXvE=;
        b=H/1F1P0ZGoPT5UckQBtHc9v4QAQgNh8UY4aPngibiivLANFBPzbdrghIQD1iOos+2J
         LCstuuasllQwtKrTKNGG1JTX7f5slZtjBmBR7XeqC6W23UoKkp9YS6TJ6QfxiA3HeVzd
         wB9Bv9rg3uxMfMsvj7FUe+WC3/9KSPIFdnUOFQZlCEEbmUaOblxO8DqM/ZNFtOVrJyhI
         256Ng0qsTiis6iQvzLm+RTCTn4GbqjnM9TWbo0saPw1wQHFJlyoV29PR3U/zEb7rl5gy
         99E85djLhl0ADeuPy6+lvaBDMAPlRw46J/+bZQ8z30+O8pDMJeaUvUec6ZQxflrOO5sd
         TFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ur4f9/w+LFWvIoYHvdY+PE05LjiSedDGlF7sC7pzXvE=;
        b=oEp+hleHVtBEIg/2SDTB1MTT40xbJGG8mz5BuCTWo1aFus2PX1qF3fdCwulTbg9uE1
         zog5pSO83vXuYXqj10Pbxh4qZ1FN8AsZb3b1rO0e8N4jCx22Ih4oAFHWKjfcdkTgd+m3
         khea3OcZLZ7q69e7tGfPgwgNy+Un0NJhsM4KacO1Yo5WGR6jp1UPhJFNzXMZOfu2xeIq
         UkN1zQr8OCCf7Pa8r7NC86WE0zWcQd62BLCnAFTlxAjr/c3z75YhPoUO+rKvzUdSuuef
         2JFathLj0dTgsj+hUj7A3UNOKem+R8OKpBRf43AN4jYzNqDRID/3uXjupeJN2ulnl9u3
         iPfw==
X-Gm-Message-State: AOUpUlEO8unILsq9+j3iC2DUIitV82C/3N1LXXOtJJeqmvlg38z6Sowb
        VvZENgSu9nUsHoQ4GHKa+Tzzrg==
X-Google-Smtp-Source: AA+uWPylnRpKFMP6nXqvGuNRJ4WeXBYIVNjtEIdAKCQXXIPqYQTt4IBTjo7jlrUS7rALXnoE5+Xpew==
X-Received: by 2002:a24:d30d:: with SMTP id n13-v6mr2796125itg.87.1533954754650;
        Fri, 10 Aug 2018 19:32:34 -0700 (PDT)
Received: from cisco.lan ([8.24.24.129])
        by smtp.gmail.com with ESMTPSA id b5-v6sm1466808ioh.43.2018.08.10.19.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 19:32:33 -0700 (PDT)
Date:   Fri, 10 Aug 2018 20:32:32 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Dinesh Subhraveti <subhraveti@apporbit.com>
Cc:     Kees Cook <keescook@chromium.org>, Tobin Harding <me@tobin.cc>,
        linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v4 0/4] seccomp trap to userspace
Message-ID: <20180811023232.GI12274@cisco.lan>
References: <20180621220416.5412-1-tycho@tycho.ws>
 <20180807024442.GA12274@cisco.lan>
 <CAP4sa4+rODVahad2hW-L3h7k6fkfGBsoCfDfBVuMwp3Aaie2KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP4sa4+rODVahad2hW-L3h7k6fkfGBsoCfDfBVuMwp3Aaie2KA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 09:11:50PM -0700, Dinesh Subhraveti wrote:
> On Mon, Aug 6, 2018 at 7:44 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> > Hi all,
> >
> > Dinesh Subhraveti has claimed that some part of this series might be
> > patented. While he has not furnished me with anything to confirm this
> > claim, I'll put this series on hold.
> 
> For the sake of everyone's clarity, there is no patent or intellectual
> property issue here and we'd like to see this feature in the kernel.  I did
> indicate that there is a patent related to the mechanism underlying this
> patch set but that is completely incidental to the issue here.  We have
> filed that patent only for the purpose of defense and have no interest or
> resources to go after infringements.  As such, I spoke about the approach,
> it's value for networking and a few possible ways of implementing it in the
> kernel at Linux Plumbers Conference 2017.
> 
> As a contractor and a member of our team at AppSwitch (FKA Fermat), Tycho
> Andersen helped implement a fully user space version of system call trap
> mechanism based on seccomp / fd-passing and participated in our team
> discussions about upstreaming a kernel version of the feature.  Given that
> context, we were taken aback that he posted the v1 patch set without
> letting us know and without any mention of AppSwitch in the post even
> though he was still under contract at that time.

It seems we disagree on the series of events, but agree that this
patchset should move forward. I'll work on preparing a v5.

Thanks!

Tycho
