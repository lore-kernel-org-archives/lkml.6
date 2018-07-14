Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C417ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 13:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7A320890
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 13:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrjJ8JMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7A320890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeGNNUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 09:20:37 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54599 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeGNNUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 09:20:37 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so758547wmb.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 06:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=prePNszIhXbrO1dQIVd8yvol/2k558JD5RfR9AjKWiM=;
        b=SrjJ8JMtxo/o97iIxrKqBiKUlpjf6H1aBz15z31miXMm3z2tB4iVgyffavf4l+MOpC
         avZ5GjDz8HFm6WmQ2N96MfGs3nGcnz62D7bRm3E4qKTh96f2aqK0X315w+RBu5drOUHf
         +bhbeykZHX+au4/YIntZyrOGrI9cM+YmLPk4NhcQMZfB3LvL8eFWrkfMFUdJzXhhQ/zb
         iKfDYeINJHnWUI810FNhcq8flNgme1sQV3uQqtGiE8UT9x4XFqpwy8XElBj2Y9ikG0OQ
         e9B+fC93dqSPR3pKc2qZ+MKrEU24dWRZyTO9BWtZQfgAuogsVAbvi9I4rsSLiP98ju3S
         /NMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=prePNszIhXbrO1dQIVd8yvol/2k558JD5RfR9AjKWiM=;
        b=b4iA84VYfKs+dofci7QMYw073AkQ7VDmvrgcvSKyqyvGRwE0Fk7WR31TzwpzgJsgSv
         UMu3CJ8FWodcBmjPvIiwOnhdd8QKXlnI312FAlT068MINQt/oBO7SxgsutcKFGke+7JX
         XYIzYnD+P6g7ZGtfGMP1L2qIIA81sQKsAGC9q1lemX6SiRz6XfYWnBzAyzoO8xJztgfe
         vjgRE1POF2tDsPhq5ysp/ekyxtNL416z2KUOTo1QyrRtBorouUzkB67LwUT5WywEpl4C
         JYr5Oa85UZT/0Skmc1NkK+fK1Hz5V+qut+YYFpz3s+MsbBSezTUi0OVH31210WfbgUKd
         XIrA==
X-Gm-Message-State: AOUpUlF4ZAX5WKYjsaxi5p0QLAL2xHVGPJvJkN4purq0ZP1cB2qtIHaH
        +FlmXEz9ZgWFDCYb5y4V10Y=
X-Google-Smtp-Source: AAOMgpegLMMh6Gs4X3X82kkPiJK/U+ktDso0KvBpK68fjFT5kT7XPmcOIr5r+lHvmw1/Y+kMbzFqrQ==
X-Received: by 2002:a1c:6444:: with SMTP id y65-v6mr5604131wmb.98.1531573293790;
        Sat, 14 Jul 2018 06:01:33 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s9-v6sm7803065wmc.34.2018.07.14.06.01.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Jul 2018 06:01:32 -0700 (PDT)
Date:   Sat, 14 Jul 2018 15:01:30 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        andy.shevchenko@gmail.com, arnd@arndb.de, aryabinin@virtuozzo.com,
        boqun.feng@gmail.com, catalin.marinas@arm.com, dvyukov@google.com,
        glider@google.com, hpa@zytor.com, linuxdrivers@attotech.com,
        parri.andrea@gmail.com, peter@hurleysoftware.com,
        tglx@linutronix.de
Subject: Re: [PATCHv3 00/12] atomics: generate atomic headers / instrument
 arm64
Message-ID: <20180714130130.GA23906@gmail.com>
References: <20180705164053.10073-1-mark.rutland@arm.com>
 <20180706131603.GA11172@arm.com>
 <20180706132124.GN2494@hirez.programming.kicks-ass.net>
 <20180713150607.rf6hkwsxpe4gsxqt@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713150607.rf6hkwsxpe4gsxqt@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark Rutland <mark.rutland@arm.com> wrote:

> On Fri, Jul 06, 2018 at 03:21:24PM +0200, Peter Zijlstra wrote:
> > On Fri, Jul 06, 2018 at 02:16:04PM +0100, Will Deacon wrote:
> > > On Thu, Jul 05, 2018 at 05:40:41PM +0100, Mark Rutland wrote:
> > > > This series scripts the generation of the various atomic headers, to ensure
> > > > that the various atomic APIs remain consistent, reducing the risk of human
> > > > error, and simplifying future rework. This fleshes out the instrumented atomics
> > > > such that arm64 can be migrated over to them.
> > > 
> > > Thanks! For the series apart from the shell scripts:
> > > 
> > > Acked-by: Will Deacon <will.deacon@arm.com>
> > 
> > Awesome, Ingo can you stuff these here patches into locking/core
> > someplace?
> 
> Looks like Ingo was only Cc'd for the above.
> 
> Ingo, are you happy to pick these up?
> 
> I've pushed out a branch [1] with Will's acks and a trivial commit
> message change for patches 8-10 which I don't think is too important. I
> can post that as v4 if you'd prefer to pick that.

Yeah, please post the very latest to the mailing list.

Thanks!

	Ingo
