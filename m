Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E15C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A50D2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A50D2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeJLSFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:05:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:48902 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726665AbeJLSFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:05:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 11FC4AF0E;
        Fri, 12 Oct 2018 10:33:25 +0000 (UTC)
Date:   Fri, 12 Oct 2018 12:33:24 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: fix integer overflow in setup_log_buf()
Message-ID: <20181012103324.gsczzzf4wiaq5tfm@pathway.suse.cz>
References: <20181010103808.882-1-sergey.senozhatsky@gmail.com>
 <20181010113308.9337-1-sergey.senozhatsky@gmail.com>
 <20181012090159.nmqcrodrxi66n2lz@pathway.suse.cz>
 <20181012092724.GB19882@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012092724.GB19882@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-10-12 18:27:24, Sergey Senozhatsky wrote:
> On (10/12/18 11:01), Petr Mladek wrote:
> > > Make "free" unsigned integer and use appropriate printk() specifier.
> > > 
> > > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > 
> > I have pushed this fix into printk.git, for-4.20 branch.
> 
> Thanks.
> 
> > Please note that this 2nd hunk was already part of the commit
> > e6fe3e5b7d16e8f14 ("printk: Give error on attempt to set log
> > buffer length to over 2G"), see
> > https://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git/commit/?h=for-4.20&id=e6fe3e5b7d16e8f146a4ae7fe481bc6e97acde1e
> 
> Oh, indeed. I guess I used linux-next which didn't have your commit.

Yeah, I forgot to push some recent changes for linux-next.

Best Regards,
Petr
