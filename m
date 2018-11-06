Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1011C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245812086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245812086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbeKGJEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 04:04:31 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:55442 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730409AbeKGJEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 04:04:30 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 61BC81090B255;
        Tue,  6 Nov 2018 15:36:48 -0800 (PST)
Date:   Tue, 06 Nov 2018 15:36:47 -0800 (PST)
Message-Id: <20181106.153647.1701013551426767213.davem@davemloft.net>
To:     ast@fb.com
Cc:     songliubraving@fb.com, dsahern@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kernel-team@fb.com, ast@kernel.org,
        daniel@iogearbox.net, peterz@infradead.org, acme@kernel.org
Subject: Re: [RFC perf,bpf 5/5] perf util: generate bpf_prog_info_event for
 short living bpf programs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <27fc8327-3390-ba5a-6063-89c9e7165e7b@fb.com>
References: <b984776a-ce69-ab16-ed87-1cea89c9d79a@gmail.com>
        <6C5A9FBD-F50D-444C-9038-E9557EC850D2@fb.com>
        <27fc8327-3390-ba5a-6063-89c9e7165e7b@fb.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 06 Nov 2018 15:36:48 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexei Starovoitov <ast@fb.com>
Date: Tue, 6 Nov 2018 23:29:07 +0000

> I think concerns with perf overhead from collecting bpf events
> are unfounded.
> I would prefer for this flag to be on by default.

I will sit in userspace looping over bpf load/unload and see how the
person trying to monitor something else with perf feels about that.

Really, it is inappropriate to turn this on by default, I completely
agree with David Ahern.

It's hard enough, _AS IS_, for me to fight back all of the bloat that
is in perf right now and get it back to being able to handle simple
full workloads without dropping events..

Every new event type like this sets us back.

If people want to monitor new things, or have new functionality, fine.

But not by default, please.
