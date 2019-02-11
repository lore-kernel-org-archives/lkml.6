Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FDFC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A56217FA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549916187;
	bh=w/s9xlzRh59t7jprCwstkFbNLsWyXogDFZ8+EnPz3Q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k3hQIhiCRZLQ7V60w7cN8N18HgjTrrg7h83ZB7HBntOWr4OvUm20xcP+20EtnOZlx
	 bUjvup9K/nmGMoYE5Tr6liZJtjrSfyM8jqHKq/4u7TjELoRwkr4bLkkwJ4VYYtj9qE
	 R7MaRVvZ2YcY2a1K5ePt31dXslzBlwUDS4yQqLhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732482AbfBKUQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:16:26 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33053 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbfBKUQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:16:25 -0500
Received: by mail-qk1-f195.google.com with SMTP id x9so7306365qkf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 12:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QJnyjvaZBoZ3afwpMN9J4813A29VZR5pPoLfyh7zSgY=;
        b=SxOg+pHKudeuTCNgasLL8K0HQSC/YMQMPHqCUDyUxxI5B/Qz912O5Oy4b+9r7c3kr5
         okNmYjtJ/fHAIXFfDrecltK9HmSqV7Ru6s9yJUPYXmcT4d3r7F454d/ndUSAhQqLZdSx
         n0gnPqn/u/ywgfzq65ivbvGvHH4w3+GT1g5ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=QJnyjvaZBoZ3afwpMN9J4813A29VZR5pPoLfyh7zSgY=;
        b=cudnAX7p2fOJMyW83sm60cRTn9c/xE6zxatJao7YO5WntQF3xeKRAxWsGTE68OGCGF
         pEZlGA8gEbaxZlP+vTT0xPD81EHjg3epcccZhHSjrdIPlJ1B2YpVOWDesHNL/Byna4tT
         BpWwdps4ijXvuMpoA5RZLokcQADgBpY1g86G/FyrpTf4sgJ0Lq5wUs4bZUNpo1vp2pw1
         Be6VfUPKJXWP47KdqoQi7Romtsg4YLl6cJ5g7TjU7DvgNN0r0k3KaqXct/BDtT8CZEC/
         BLvNo64m3QH9WnFEw4FD9UgPLio88NT+k4PJ8WyxTCshLe6Rk1fPfabwbqpB48zsI2t0
         96KA==
X-Gm-Message-State: AHQUAuY14CpTJD3NLLz7+7J2oDxuTCib2Az+g5OKcLPYjZGj3nE6puJb
        J+CKtzOcf2puDzg34uAYRiWdlw==
X-Google-Smtp-Source: AHgI3IZ7gcNzkZHVv52x8HR99XW6FJoqhbMZnIhXr7YngseF0fi9md6zarxW/F0wELOK5vo1ytxQrQ==
X-Received: by 2002:a37:b1c7:: with SMTP id a190mr25676qkf.94.1549916183586;
        Mon, 11 Feb 2019 12:16:23 -0800 (PST)
Received: from work ([192.0.231.225])
        by smtp.gmail.com with ESMTPSA id u19sm10662796qka.43.2019.02.11.12.16.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 12:16:22 -0800 (PST)
Date:   Mon, 11 Feb 2019 15:16:19 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eduardo Valentin <edubezval@gmail.com>, pr-tracker-bot@kernel.org,
        Rui Zhang <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Thermal-SoC management fixes for v5.0-rc6
Message-ID: <20190211201619.GA8065@work>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        Eduardo Valentin <edubezval@gmail.com>, pr-tracker-bot@kernel.org,
        Rui Zhang <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190210041721.GA2805@localhost.localdomain>
 <154977271617.2362.11794417398216386913.pr-tracker-bot@kernel.org>
 <20190211031921.GA1799@localhost.localdomain>
 <CAHk-=wgz_WpD7jc084QROuM0zszEG0-WvQhQZPsCboMOWNRiWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHk-=wgz_WpD7jc084QROuM0zszEG0-WvQhQZPsCboMOWNRiWw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 10:34:09AM -0800, Linus Torvalds wrote:
>> > > git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal 
>> > > fixes
>> >
>> > has been merged into torvalds/linux.git:
>> > https://git.kernel.org/torvalds/c/7ad915f5ebf5b9e7ca98a7048d8f84a631fe388b
>>
>> I think the bot is off here because the above commit is about a merge
>> from the linux-omap tree from Tony.
>
>Indeed.
>
>.. and the pr-tracker-bot thing actually made me ignore the pull
>request, thinking I had left it in my inbox despite having pulled it.
>
>So it would be really good to know why pr-tracker-bot ended up
>replying to the wrong email, because it can cause real problems.

Okay, so I need guidance on the proper behaviour here. As this request 
didn't use the magic wording for the commit-id (as generated by 
git-request-pull), we ended up trying to look up the remote. The remote 
specified was:

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

Since it's a short refname, we first try to look it up as a tag:

$ git ls-remote git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes^{}
a6d25f4c951b8b28f2eaec6f891ff834622532f2        refs/tags/omap-for-v3.10-rc1/fixes^{}
77319669af37a1cfc844b801e83343b37e3c7e13        refs/tags/omap/fixes^{}

If it finds a matching tag, the script assumes you'd meant to specify 
the tag, not the head. Is that the opposite of git's behaviour when 
applying a remote? Should we be checking for a head first, before we try 
the refname as a tag? I assume that's the case, but want to double-check 
with you all.

-K
