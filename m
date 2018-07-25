Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F60C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E433920843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E433920843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbeGYWoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:44:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58078 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731316AbeGYWoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:44:21 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D8A15BBF;
        Wed, 25 Jul 2018 21:30:47 +0000 (UTC)
Date:   Wed, 25 Jul 2018 14:30:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     jbaron@akamai.com, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH -next] fs/epoll: simply CONFIG_NET_RX_BUSY_POLL ifdefery
Message-Id: <20180725143046.74ee1238493e3b4aef57e72e@linux-foundation.org>
In-Reply-To: <20180725200633.c36cdaf4ymgscump@linux-r8p5>
References: <20180725185620.11020-1-dave@stgolabs.net>
        <20180725123513.5f36a6b787d06c8066a24ade@linux-foundation.org>
        <20180725200633.c36cdaf4ymgscump@linux-r8p5>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018 13:06:33 -0700 Davidlohr Bueso <dave@stgolabs.net> wrote:

> >> +#else
> >> +#define ep_busy_loop(ep, nonblock)		do { } while (0)
> >> +#define ep_reset_busy_poll_napi_id(ep)		do { } while (0)
> >> +#define ep_set_busy_poll_napi_id(epi)		do { } while (0)
> >> +
> >> +#endif /* CONFIG_NET_RX_BUSY_POLL */
> >
> >inlines are preferred.  Because macros are fugly and can cause
> >unused-var warnings when the stub versions are used.
> 
> Fair enough.
> 
> >This?
> 
> Do you want me to send a v2 or will you fold in the below?

I queued both patches.
