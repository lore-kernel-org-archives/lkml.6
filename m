Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DD0ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2802084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2802084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbeGRWBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:01:55 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:41858 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbeGRWBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:01:55 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1ffttd-0006ep-7G; Wed, 18 Jul 2018 21:22:05 +0000
Date:   Wed, 18 Jul 2018 22:22:05 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] call_with_creds()
Message-ID: <20180718212205.GY30522@ZenIV.linux.org.uk>
References: <CAOssrKf60FHqgG6pB5zOP7iV-qdHdDUODdG7SVpoNh3Pipo=6w@mail.gmail.com>
 <CAOssrKdqnsPSipweUCers6d2AgJX2aVGQUs1pd7cB79GoSJH1Q@mail.gmail.com>
 <20180718124340.GS30522@ZenIV.linux.org.uk>
 <CAOssrKcS+kwK+S1aojhbW_4p8FJLPaafBDqDu89d=F14wT-0rw@mail.gmail.com>
 <20180718181252.GU30522@ZenIV.linux.org.uk>
 <CA+55aFxh62Yttq-W2Cr_YQQ5tAL1xjijjnaz1-zdZNqZPQFM0g@mail.gmail.com>
 <20180718194637.GV30522@ZenIV.linux.org.uk>
 <CA+55aFydd9ji2eJSNVK7Fjpziehvm6fO3b1eTeUAn0L1tk3GmQ@mail.gmail.com>
 <20180718200411.GW30522@ZenIV.linux.org.uk>
 <CA+55aFwhnOPO26ubjJ9WhK6YT8JqD5_UTGmNLFWbPdv-On99=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwhnOPO26ubjJ9WhK6YT8JqD5_UTGmNLFWbPdv-On99=w@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 01:43:00PM -0700, Linus Torvalds wrote:

> What I really think I'd prefer is to have some simple way to "poison"
> current_cred().  It could be something as simple as a per-thread
> counter, and we'd have current_cred() do
> 
>         WARN_ON_ONCE(in_interrupt() || current->cred_poison);

Why is counter any better than LSB of a pointer?
