Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57512ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC252075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC252075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbeGRM4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:56:15 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56008 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbeGRM4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:56:15 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fflPe-0001dX-6v; Wed, 18 Jul 2018 12:18:34 +0000
Date:   Wed, 18 Jul 2018 13:18:34 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 (v4.18 regression fix)] vfs: don't evict uninitialized
 inode
Message-ID: <20180718121833.GR30522@ZenIV.linux.org.uk>
References: <20180706204521.29654-1-mszeredi@redhat.com>
 <CAJfpeguFaaE8i+fAg3HhQm6MPcFzMciY3WLfQUPdnY4xnmC7kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguFaaE8i+fAg3HhQm6MPcFzMciY3WLfQUPdnY4xnmC7kg@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 01:40:08PM +0200, Miklos Szeredi wrote:
> Ping?
> 
> This (or some variant) needs to go into 4.18.

Yes - icache series is on the top of my list, now that -open stuff
is (hopefully) sorted out (in for-next, anyway).

I'm putting together a queue with that stuff at the moment.

BTW, why have you left generic_readlink() sitting around?  AFAICS,
it could've been folded into the only remaining caller just as
you've made it static in late 2016...  I'll fold it in;
just curious what was the reason for not doing that back then...
