Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC50C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFACB26D96
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFACB26D96
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752184AbeFZQPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:15:39 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41014 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751631AbeFZQPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:15:37 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7682420775; Tue, 26 Jun 2018 18:15:35 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4A3F7203B0;
        Tue, 26 Jun 2018 18:15:35 +0200 (CEST)
Date:   Tue, 26 Jun 2018 18:15:36 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] RTC for 4.18
Message-ID: <20180626161536.GH4207@piout.net>
References: <20180610221645.GA26123@piout.net>
 <ff6d048a-c683-56e0-13f9-1627cdfd0ea9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff6d048a-c683-56e0-13f9-1627cdfd0ea9@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/06/2018 16:51:40+0100, Jon Hunter wrote:
> >       rtc: tps6586x: let the core handle rtc range
> 
> Sorry I am missing the original mail with the above change, but I
> have noticed on v4.18-rc1 that rtc wake-ups from suspend are no
> longer working on one of our Tegra boards. The bisect points to the
> above change and reverting it fixes the problem. I have not had
> chance to dig further, but if you have any thoughts, please let me
> know.


Thanks for the report, does the following patch fix the issue:

https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/patch/?id=1b287f23b0a1fcb2b502dae981a8024be379391e


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
