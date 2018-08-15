Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA0BC4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 11:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932A12148D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 11:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932A12148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbeHOODK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 10:03:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39372 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbeHOODK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 10:03:10 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 31216BC8;
        Wed, 15 Aug 2018 11:11:24 +0000 (UTC)
Date:   Wed, 15 Aug 2018 13:11:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
        Jiri Bohac <jbohac@suse.cz>
Subject: Re: [PATCH 4.4.y] tcp: Fix missing range_truesize enlargement in the
 backport
Message-ID: <20180815111121.GA17583@kroah.com>
References: <20180815095846.7734-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815095846.7734-1-tiwai@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 11:58:46AM +0200, Takashi Iwai wrote:
> The 4.4.y stable backport dc6ae4dffd65 for the upstream commit
> 3d4bf93ac120 ("tcp: detect malicious patterns in
> tcp_collapse_ofo_queue()") missed a line that enlarges the
> range_truesize value, which broke the whole check.
> 
> Fixes: dc6ae4dffd65 ("tcp: detect malicious patterns in tcp_collapse_ofo_queue()")
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> 
> Greg, this is a fix-up specific to 4.4.y stable backport that had a
> slightly different form from upstream fix.  I haven't looked at the
> older trees, but 4.9.y and later took the upstream fix as is, so this
> patch isn't needed for them.
> 
> The patch hasn't been tested with the real test case, though; let me
> know if the current code is intended.  Thanks!

Hm, I did the initial backport, and then Eric showed what I got wrong
and fixed that up, so being still wrong is not inconceivable at all :)

Have you tried testing this with the reproducer?  That might be the best
verification here.  If your testing proves to be good, I'll gladly take
this patch, thanks!

greg k-h

thanks,

greg k-h
