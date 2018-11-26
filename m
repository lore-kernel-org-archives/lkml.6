Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46391C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30CD20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MG3ui1QR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F30CD20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeK0Iy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:54:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:44232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbeK0Iy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:54:58 -0500
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EBFF20873;
        Mon, 26 Nov 2018 21:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543269565;
        bh=eE1xmoAJXWYSGF0vbmqOJeIfQVk1IxRw8PziQSH+HGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MG3ui1QR+KqUSnoGjzvRaqx7KEuC8p3bicB4pY2agX0FpEddrenGXJ1Z+iR0kTY4Q
         wL5GF35O3GH0HxkzVk1oHZ0Bj+VCJYkmQT9moJ4kTmgzfK5ccA1HO0+JoCGQl8atc8
         JGTPku+nzdkC59QBf9i0v5gwjf8ts8wEEYp6bF/I=
Date:   Mon, 26 Nov 2018 13:59:24 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kees Cook <keescook@google.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the f2fs tree
Message-ID: <20181126215924.GA55960@jaegeuk-macbookpro.roam.corp.google.com>
References: <20181126111933.1b0fb324@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126111933.1b0fb324@canb.auug.org.au>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 11/26, Stephen Rothwell wrote:
> Hi Jaegeuk,
> 
> After merging the f2fs tree, today's linux-next build
> (x86_64_allmodconfig) produced this warning:
> 
> In file included from fs/f2fs/dir.c:11:
> fs/f2fs/f2fs.h: In function '__mark_inode_dirty_flag':
> fs/f2fs/f2fs.h:2388:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (set)
>       ^
> fs/f2fs/f2fs.h:2390:2: note: here
>   case FI_DATA_EXIST:
>   ^~~~
> 
> Exposed by my use of -Wimplicit-fallthrough
> 
> I am not sure why this has turned up now (as opposed to earlier today).

The above change had been there for a long time, as an intended behavior.
Hmm, I'm not sure how to avoid this.

Thanks,

> 
> -- 
> Cheers,
> Stephen Rothwell


