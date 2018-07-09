Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182D8C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A5120842
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A5120842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754541AbeGILsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:48:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:39972 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754451AbeGILsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:48:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CD202AE51;
        Mon,  9 Jul 2018 11:48:38 +0000 (UTC)
Date:   Mon, 9 Jul 2018 13:48:37 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Namit Gupta <gupta.namit@samsung.com>,
        linux-kernel@vger.kernel.org, pankaj.m@samsung.com,
        a.sahrawat@samsung.com, himanshu.m@samsung.com
Subject: Re: [PATCH] printk: remove unnecessary kmalloc() from syslog during
 clear
Message-ID: <20180709114837.zhzwmtcff2y3bl6i@pathway.suse.cz>
References: <CGME20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2@epcas5p3.samsung.com>
 <20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2~54wyKcT0_3155531555epcas5p3y@epcas5p3.samsung.com>
 <20180625133705.7zsg2rkw4xtyg6ie@pathway.suse.cz>
 <20180625103704.49811ec1@gandalf.local.home>
 <20180625144407.GB443@tigerII.localdomain>
 <20180626124332.62isabqkefpgqpgk@pathway.suse.cz>
 <20180626103959.79e92a35@gandalf.local.home>
 <20180627150641.p56xyy6mdzvnfpig@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627150641.p56xyy6mdzvnfpig@pathway.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-06-27 17:06:41, Petr Mladek wrote:
> On Tue 2018-06-26 10:39:59, Steven Rostedt wrote:
> > This looks fine. For proper history though, what I do in this case,
> > would be to make this into two patches. One with Namit's original
> > patch, and then a second that removes the code duplication (your patch).
> 
> Proposed patch:
> 
> From: Petr Mladek <pmladek@suse.com>
> Date: Wed, 27 Jun 2018 16:37:42 +0200
> Subject: [PATCH] printk: Clean up syslog_print_all()
> 
> syslog_print_all() is called twice. Once with a valid buffer
> and once just to set the indexes.
> 
> Both variants are already handled separately. This patch just
> makes it more obvious. It does not change the existing behavior.

JFYI, I have pushed this separate clean up patch into printk.git,
branch for-4.19.

Best Regards,
Petr
