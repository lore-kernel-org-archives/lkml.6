Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D388C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5555C20853
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHm5LSoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5555C20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbeJVS1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:27:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40831 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbeJVS1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:27:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id g21-v6so12656899pfi.7;
        Mon, 22 Oct 2018 03:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QM4Yu+1p2haCXP5W9H76haVjc7F3evCtWrd2v/xitOw=;
        b=CHm5LSoVjAZjGaGgMuBuNh4+3ZpPpDoZQbdQjesuP7zkg519prfK7r9IOpGbaMM0h8
         oB0Qu7rxHy6XEccKfV6D3sAlLvHqCDlDB42aRDlPBcXLCb76QPyNtq+Rp5JbYDwfhAmG
         ioV3DTSTy/eyTTj82EJa83Vl3rXU4ogjqdEzrfZeP5wR2q7PbT31NrpZ4+gBRgZsvUMQ
         qo09zwztoKi/N7xrvk6wtd1krCUnLA7SRB+zx98oPshqInmqdnoKMcTjyggj5mpd9hIA
         ac2ox4xC12j/c+cK98YZRwXvb2y3qLfHNY7yvO7YEJ/daof5Cn3e2dlJjoFmZdteMRzm
         NGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QM4Yu+1p2haCXP5W9H76haVjc7F3evCtWrd2v/xitOw=;
        b=mV1m/jm/1EYQ7+eno7HELe7+FuPuAd3cBd/HzYLP4CtfiuGYqL2RJhA25EMSLlN013
         CBiVhYfzA/zoKJSjSUqiFgtxAm22FG4GvvhfCnMlFgFNpbN7XhSVvfTpD24Yo2lJbTrJ
         j2IEjimX3sTTrKrRq2hrS4ulOGXRkTykVOH/DfRJBWFwJD2XRDf2jC9ocbPxZJj06MTQ
         lzvNvXgC0Z+DL8Bwid5+u09qsx7Xnd4psQ8MiC8YTiVPokssegviIo8Ivk6zE3G7ksXJ
         eiw29xVsyGQHCb1xFL6MckuxbvOaQAB0xV+azlnzgdxvQz0H5x343N2Y09uoLaJjftlR
         FJrg==
X-Gm-Message-State: ABuFfogtu59Y+UpC2ftOIxwHzNmcK1sPc+Gy5sZHe+e0hhqCMdELgLIX
        LWw2yZxqOf2Q3P7ko6evejY=
X-Google-Smtp-Source: ACcGV61A6EmDBf+Y4gjVCzE5LmzhPk6LP3+flUTZETHNJP9DYrK8jQSVKrp8aVf1ZnPpT1Vxo4htaQ==
X-Received: by 2002:a62:de05:: with SMTP id h5-v6mr45339377pfg.258.1540202997589;
        Mon, 22 Oct 2018 03:09:57 -0700 (PDT)
Received: from localhost ([39.7.58.252])
        by smtp.gmail.com with ESMTPSA id j25-v6sm36021730pff.116.2018.10.22.03.09.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 03:09:55 -0700 (PDT)
Date:   Mon, 22 Oct 2018 19:09:52 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Daniel Wang <wonderfly@google.com>
Cc:     sergey.senozhatsky.work@gmail.com, Petr Mladek <pmladek@suse.com>,
        rostedt@goodmis.org, stable@vger.kernel.org,
        Alexander.Levin@microsoft.com, akpm@linux-foundation.org,
        byungchul.park@lge.com, dave.hansen@intel.com, hannes@cmpxchg.org,
        jack@suse.cz, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mel Gorman <mgorman@suse.de>, mhocko@kernel.org, pavel@ucw.cz,
        penguin-kernel@i-love.sakura.ne.jp, peterz@infradead.org,
        tj@kernel.org, torvalds@linux-foundation.org, vbabka@suse.cz,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Peter Feiner <pfeiner@google.com>
Subject: Re: 4.14 backport request for dbdda842fe96f: "printk: Add console
 owner and waiter logic to load balance console writes"
Message-ID: <20181022100952.GA1147@jagdpanzerIV>
References: <CAJmjG2-RrG5XKeW1-+rN3C=F6bZ-L3=YKhCiQ_muENDTzm_Ofg@mail.gmail.com>
 <20181002212327.7aab0b79@vmware.local.home>
 <20181003091400.rgdjpjeaoinnrysx@pathway.suse.cz>
 <CAJmjG2_4JFA=qL-d2Pb9umUEcPt9h13w-g40JQMbdKsZTRSZww@mail.gmail.com>
 <20181003133704.43a58cf5@gandalf.local.home>
 <CAJmjG291w2ZPRiAevSzxGNcuR6vTuqyk6z4SG3xRsbaQh5U3zQ@mail.gmail.com>
 <20181004074442.GA12879@jagdpanzerIV>
 <20181004083609.kcziz2ynwi2w7lcm@pathway.suse.cz>
 <20181004085515.GC12879@jagdpanzerIV>
 <CAJmjG2-e6f6p=pE5uDECMc=W=81SYyGCmoabrC1ePXwL5DFdSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJmjG2-e6f6p=pE5uDECMc=W=81SYyGCmoabrC1ePXwL5DFdSw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/21/18 11:09), Daniel Wang wrote:
> 
> Just got back from vacation. Thanks for the continued discussion. Just so
> I understand the current state. Looks like we've got a pretty good explanation
> of what's going on (though not completely sure), and backporting Steven's
> patches is still the way to go?

Up to -stable maintainers.

Note, with or without Steven's patch, the non-reentrable consoles are
still non-reentrable, so the deadlock is still there:

	spin_lock_irqsave(&port->lock, flags)
	 <NMI>
	  panic()
	   console_flush_on_panic()
	    spin_lock_irqsave(&port->lock, flags)		// deadlock


// And I wouldn't mind to have more reviews/testing on [1].


Another deadlock scenario could be the following one:

	printk()
	 console_trylock()
	  down_trylock()
	   raw_spin_lock_irqsave(&sem->lock, flags)
	    <NMI>
	     panic()
	      console_flush_on_panic()
	       console_trylock()
	        raw_spin_lock_irqsave(&sem->lock, flags)	// deadlock

There are no patches addressing this one at the moment. And it's
unclear if you are hitting this scenario.


> I see that Sergey had sent an RFC series for similar things. Are those
> trying to solve the deadlock problem in a different way?

Umm, I wouldn't call it "another way". It turns non-reentrant serial
consoles to re-entrable ones. Did you test patch [1] from that series
on you environment, by the way?

[1] lkml.kernel.org/r/20181016050428.17966-2-sergey.senozhatsky@gmail.com

	-ss
