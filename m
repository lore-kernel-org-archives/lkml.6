Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC48C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A2A2063F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080638;
	bh=RilTJVWy9H9jF5/HPeumBDxrkqUuVH6VFhZVyhrcTgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xCEK5TmiCy+WRJxRpCMhgLFqJtKTkHmetdfxyFF0RRe2OxV/yi9KbEbtYgUum/mvY
	 /rh32f/vD1NumBnxFiuIDbwrTqvCz22Md8Vuwtg3cOh6f/I4Db+NqTVajH9YZzfOQh
	 AgVlt83p22RJmMuU75kQcEBt+m2CMzWGpq3rvYrs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbfAUOX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:23:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:35758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729183AbfAUOX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:23:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20AF32063F;
        Mon, 21 Jan 2019 14:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548080635;
        bh=RilTJVWy9H9jF5/HPeumBDxrkqUuVH6VFhZVyhrcTgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eNiqe9cVWhdL2kwXH21KqZXTB2XBiaK5bt7pkyR2gHXgJPiZC6hj/iWRV8qEaPUBu
         Nxs9V2k1rVFA6BezXVlouSEaMA+qFvmi9qJ+pchMcBrzRf27yyKYmQO9f24ttJdW2K
         /zOH0C6jfJMw5vB38Zr6NePVCekQXdPRVZM0HNcY=
Date:   Mon, 21 Jan 2019 15:23:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        syzbot+9933e4476f365f5d5a1b@syzkaller.appspotmail.com,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 4.20 085/111] blockdev: Fix livelocks on loop device
Message-ID: <20190121142345.GA6028@kroah.com>
References: <20190121122455.819406896@linuxfoundation.org>
 <20190121122505.487073207@linuxfoundation.org>
 <20190121140301.GA16096@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121140301.GA16096@quack2.suse.cz>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 03:03:01PM +0100, Jan Kara wrote:
> On Mon 21-01-19 14:43:19, Greg Kroah-Hartman wrote:
> > 4.20-stable review patch.  If anyone has any objections, please let me know.
> 
> Greg, when applying this, you should also apply commit c8a83a6b54d0 "nbd:
> Use set_blocksize() to set device blocksize". Otherwise some nbd
> functionality would regress.

Thanks, now queued up.

greg k-h
