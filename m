Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711B3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 04:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3027E2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 04:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3027E2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbeKSPPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 10:15:12 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:33416 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeKSPPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 10:15:11 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3EEC8148C8AAC;
        Sun, 18 Nov 2018 20:52:46 -0800 (PST)
Date:   Sun, 18 Nov 2018 20:52:43 -0800 (PST)
Message-Id: <20181118.205243.227550158553460819.davem@davemloft.net>
To:     jolsa@redhat.com
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        jolsa@kernel.org
Subject: Re: [PATCH RFC] hist lookups
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181113104054.GJ30042@krava>
References: <20181111232627.GC30042@krava>
        <20181111.153259.2003083478035551655.davem@davemloft.net>
        <20181113104054.GJ30042@krava>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 18 Nov 2018 20:52:46 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>
Date: Tue, 13 Nov 2018 11:40:54 +0100

> I pushed/rebased what I have to perf/fixes branch again
> 
> please note I had to change our compile changes, because
> they wouldn't compile on x86, but I can't verify on sparc,
> so you might see some compile fails again

I just checked your current perf/fixes branch.

It builds on Sparc ;-)

And it behaves better too.  I do get tons of drops and lost events,
but it seems to keep going even during the hardest load.

Eventually I end up with a lot of unresolvable histogram entries,
so that is something to look into.

I looked at your drop logic and it seems perfect, we avoid dropping
all non-SAMPLE events which is what we want.  So that can't be the
cause of the issues I am seeing.

