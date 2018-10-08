Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1488C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9EA2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9EA2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbeJHUPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:15:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:42564 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725914AbeJHUPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:15:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B364EACFB;
        Mon,  8 Oct 2018 13:03:56 +0000 (UTC)
Date:   Mon, 8 Oct 2018 15:03:56 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     zhe.he@windriver.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] printk: Correct wrong casting
Message-ID: <20181008130356.pb6qetwveuuqfofj@pathway.suse.cz>
References: <1538239553-81805-1-git-send-email-zhe.he@windriver.com>
 <1538239553-81805-2-git-send-email-zhe.he@windriver.com>
 <20181002055018.GB598@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002055018.GB598@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-10-02 14:50:18, Sergey Senozhatsky wrote:
> On (09/30/18 00:45), zhe.he@windriver.com wrote:

> > Correct wrong casting that might cut off the normal output.
> 
> A commit message probably could have been a bit more descriptive,
> mentioning that log_first_seq and console_seq are 64-bit unsigned
> integers, this is a Cc material potentially.

I have used the following text:

log_first_seq and console_seq are 64-bit unsigned integers.
Correct a wrong casting that might cut off the output. 

> > Signed-off-by: He Zhe <zhe.he@windriver.com>
> > Cc: stable@vger.kernel.org
> > Cc: pmladek@suse.com
> > Cc: sergey.senozhatsky@gmail.com
> > Cc: rostedt@goodmis.org
> 
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

And pushed this patch into printk.git, branch for-4.20.

Best Regards,
Petr
