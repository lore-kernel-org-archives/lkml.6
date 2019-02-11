Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1CEC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73212217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549926623;
	bh=VFaQK1P93H4pBYLtgMcZ5ytlww/HwVbAWSImW8PhU5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OI830feVTR+dTW3ummKIdDE9UeJLcc6fBy6QbXHgWzH5erBvK9oVgmN+mWiAJXTts
	 0nWh59n/eRPtjTCusGCSp1ExdcWDbq0LgDDVuif4X7YoQy1oUJaQVjY/V/y8xUFmmJ
	 ya8PCaFi2/GS5jUu5DbJCOxvz0E/cVjietSldBYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfBKXKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:10:21 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36100 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfBKXKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 18:10:21 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so2708749itj.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 15:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MKmbpPUHZp+qcDMrKqRrxDlgP/yKOLVeKW0Rs4b/jgM=;
        b=DMOjHjq0aBZ1i+aDF2P7cTNN2pZi8Yd8O6t/XfxTW3u4dKiYxZzQVbgKQu0fE0JaNE
         8BW1N19q2eR1qBEXvqMmxUeIlRmgLuB+8wo90rLbWzzVK6pARCT4RCF4HGhQufacaQX5
         6kBEMYa8doWtecrJnNi5abto103RBw5nhZ9hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MKmbpPUHZp+qcDMrKqRrxDlgP/yKOLVeKW0Rs4b/jgM=;
        b=QGtOEa0CrLjOcWL/q8AWrmKEH+i2J/p8AESfCTre97rEuyNADeogjV5Ms2RVgSlGc4
         q9npSVFkWtsQtqeDGjS00RPwWNHgO5DV0//yBGFDmRKiHEnXnsqHUp7RPpZO/pKiDJ7D
         +loxWThChQL1v1eZMqXvjuosqH9Y3coTyILRezv7yq8JULKnTM/5mpKYXGbScd0gnbZP
         IwF8rdMqfVXcYz7VFQRPtT8/zyVNQrN4zaKjgxTq9rll94HYG1JCDQVRN4b0FJVrUqwe
         7EzNoVgKnoW767ootNIE30MyMcFHRi2ui3jOzwY6ytiSdJzLhSXdMjDNeV/Tnez7Lmxa
         UqOA==
X-Gm-Message-State: AHQUAubPKgIQejUWl+5seDKobzoktb9ySzb04132/Wh5oSQS5mPIFau1
        mnTFDJ/3SH7vWcPJkNFJjkHgzA==
X-Google-Smtp-Source: AHgI3IYo0D0VlUxEbWL006J7LpJS+ncKlf5NSndykjeR/wpGHZrqMyGQbxwX6Wtc8cQHCufkx3V+UQ==
X-Received: by 2002:a02:8cf6:: with SMTP id n51mr389165jal.86.1549926620127;
        Mon, 11 Feb 2019 15:10:20 -0800 (PST)
Received: from chatter.qube.local ([199.66.90.209])
        by smtp.gmail.com with ESMTPSA id u25sm4948883iob.23.2019.02.11.15.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 15:10:19 -0800 (PST)
Date:   Mon, 11 Feb 2019 18:10:16 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eduardo Valentin <edubezval@gmail.com>, pr-tracker-bot@kernel.org,
        Rui Zhang <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Thermal-SoC management fixes for v5.0-rc6
Message-ID: <20190211231016.GA2937@chatter.qube.local>
References: <20190210041721.GA2805@localhost.localdomain>
 <154977271617.2362.11794417398216386913.pr-tracker-bot@kernel.org>
 <20190211031921.GA1799@localhost.localdomain>
 <CAHk-=wgz_WpD7jc084QROuM0zszEG0-WvQhQZPsCboMOWNRiWw@mail.gmail.com>
 <20190211201619.GA8065@work>
 <CAHk-=wg9yvP3hGVRSnc=8qoj0g7_zt=_2FjmgSAu-0DViyFtaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHk-=wg9yvP3hGVRSnc=8qoj0g7_zt=_2FjmgSAu-0DViyFtaw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 02:04:08PM -0800, Linus Torvalds wrote:
>> Okay, so I need guidance on the proper behaviour here. As this 
>> request
>> didn't use the magic wording for the commit-id (as generated by
>> git-request-pull), we ended up trying to look up the remote. The remote
>> specified was:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes
>>
>> Since it's a short refname, we first try to look it up as a tag:
>
>No, you don't do even that.
>
>The name is "fixes". But you seem to match it with one of these:
>
>> $ git ls-remote git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes^{}
>> a6d25f4c951b8b28f2eaec6f891ff834622532f2        refs/tags/omap-for-v3.10-rc1/fixes^{}
>> 77319669af37a1cfc844b801e83343b37e3c7e13        refs/tags/omap/fixes^{}
>
>*NEITHER* of which is a tag named "fixes". One is named
>"omap-for-v3.10-rc1/fixes" and the other is a tag named "omap/fixes".

Linus:

Thank you for the feedback. I've implemented a fix that handles 
shortname refs more properly in order to avoid hitting this problem 
again.

Regards,
-K
