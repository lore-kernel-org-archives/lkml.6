Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BE9C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88BC20844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="dq0ZedvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbfBENGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:06:13 -0500
Received: from tomli.me ([153.92.126.73]:48658 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfBENGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:06:12 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 04feca8d;
        Tue, 5 Feb 2019 13:06:09 +0000 (UTC)
X-HELO: localhost.localdomain
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.localdomain) (2402:f000:1:1501:200:5efe:7b75:4650)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Tue, 05 Feb 2019 13:06:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=1490979754; bh=5lcRfBFPtcEwjLQR+HPEzHjnwv8/n0ocD1kO1pC/il0=; b=dq0ZedvDWvFVfzUacS+bVObpL3/z9e99Y1xvnX6n/P427QG/f9aRZOk1JsbydjO1p8inVlo6kTD0m8uG/Ahcph5QTMIWfS5LkUDVg/z0usAN8IMNSn9Rfv+7vVPdwHjE0EESX3/xIm/DTEa486l5lc17HGmdnO/Srh6gtnnrNR7RDAm9134++1BEtZkBvtN8hMDqN9XUPTCiw4aSPJj2bNw8B/GKL/AP2bRQLr8mh5zb5xUX0RMw42evn6JWeVWpoMYgLfwfKmStKG6MpE18R6NqVn/hoHas18uQPPixCFwjwMQRYJUaWOK2PFPtoH3mBs+iH7tgjht1tADyVGTlIg==
Date:   Tue, 5 Feb 2019 21:05:59 +0800
From:   Tom Li <tomli@tomli.me>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     paulmck@linux.ibm.com, ak@linux.intel.com, bp@alien8.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        rjw@rjwysocki.net, ville.syrjala@linux.intel.com,
        viresh.kumar@linaro.org, linux-mips@vger.kernel.org
Subject: Re: [REGRESSION 4.20-rc1] 45975c7d21a1 ("rcu: Define RCU-sched API
 in terms of RCU for Tree RCU PREEMPT builds")
Message-ID: <20190205130559.GA12858@localhost.localdomain>
References: <20181113135453.GW9144@intel.com>
 <20181113151037.GG4170@linux.ibm.com>
 <20181114202013.GA27603@linux.ibm.com>
 <20181126220122.GA6345@linux.ibm.com>
 <20190205050700.GA31571@localhost.localdomain>
 <20190205095809.GA16356@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205095809.GA16356@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 11:58:09AM +0200, Aaro Koskinen wrote:
> Can you try below fix? It works on my Loongson.

Hello Aaro, thanks for your response. But in case you've missed
the original thread, please check it at:

https://lkml.org/lkml/2018/11/13/857

My problem is NOT about how to fix the problem on Loongson (or
x86): the patch in the original thread (only has one-line-of-code,
simply changes timing of cpufreq_core_init), or your patch, is
indeed working. But they are workarounds, the real issue is the race
condition in cpufreq.

My question is

1. What's the progress and current consensus about how the underlying
problem can be fixed.

2. If there's no consensus since November, is it possible that we land
a hotfix patch to linux-stable as a temporary workaround?

Cheers,
Tom Li.
