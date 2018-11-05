Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CE2C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4493C2081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4493C2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388265AbeKFIOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:14:30 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:35584 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388180AbeKFIOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:14:30 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AE5A614920CC7;
        Mon,  5 Nov 2018 14:52:29 -0800 (PST)
Date:   Mon, 05 Nov 2018 14:52:27 -0800 (PST)
Message-Id: <20181105.145227.1208804116999835276.davem@davemloft.net>
To:     jolsa@redhat.com
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        jolsa@kernel.org
Subject: Re: [PATCH RFC] hist lookups
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181105203447.GA25674@krava>
References: <20181104201821.GA22049@krava>
        <20181104.165039.878682622135788379.davem@davemloft.net>
        <20181105203447.GA25674@krava>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 05 Nov 2018 14:52:29 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>
Date: Mon, 5 Nov 2018 21:34:47 +0100

> I put something together.. still testing, but it's already
> showing 0 lost events when for 'overwrite = 0' case even
> for high load.. the old code shows ~1500 for same workload
> 
> I'm printing lost event counts in stdio output header:
> 
>   # perf top -d 1 --stdio
>      PerfTop:    5734 irqs/sec  kernel:57.3%  exact: 100.0% lost: 0 [4000Hz cycles:ppp],  (all, 8 CPUs)
> 
> will probably add it to tui as well, seems useful
> 
> I pushed it in perf/fixes branch in:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> 
> it's stil work in prograss.. not too manye complete changelogs ;-)

Looks interesting!

I'll play with this on sparc64 later, thanks!
