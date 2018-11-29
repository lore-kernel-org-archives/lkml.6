Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32422C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB32B20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB32B20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbeK3ELj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:11:39 -0500
Received: from verein.lst.de ([213.95.11.211]:44772 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729157AbeK3ELj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:11:39 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 46C7E68B02; Thu, 29 Nov 2018 18:05:35 +0100 (CET)
Date:   Thu, 29 Nov 2018 18:05:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@fb.com>,
        lkp@01.org
Subject: Re: [LKP] [block] 9d037ad707: BUG:unable_to_handle_kernel
Message-ID: <20181129170535.GA28147@lst.de>
References: <20181129092031.GF21676@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129092031.GF21676@shao2-debian>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 05:20:31PM +0800, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 9d037ad707ed6069fbea4e38e6ee37e027b13f1d ("block: remove req->timeout_list")
> https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git mq-perf

This looks very odd.  How could we introduce a new BUG with the removal
of an unused structure member?
